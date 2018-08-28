Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-00176a03.pphosted.com ([67.231.157.48]:49404 "EHLO
        mx0a-00176a03.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726995AbeH1LiE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 28 Aug 2018 07:38:04 -0400
Received: from pps.filterd (m0048204.ppops.net [127.0.0.1])
        by m0048204.ppops.net-00176a03. (8.16.0.22/8.16.0.22) with SMTP id w7S6bxYP027389
        for <linux-integrity@vger.kernel.org>; Tue, 28 Aug 2018 02:41:17 -0400
From: "Safford, David (GE Global Research, US)" <david.safford@ge.com>
To: "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
CC: Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [RFC PATCH 2/2] Add code for TLV formatted IMA measurement list
Date: Tue, 28 Aug 2018 06:41:09 +0000
Message-ID: <BCA04D5D9A3B764C9B7405BBA4D4A3C002569235@ALPMBAPA12.e2k.ad.ge.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

This RFC patch adds code to support TLV formatted IMA measurement lists,
which also purge read records on read, and which include additional
fields, including sequence number, timestamp, owner, group, and mode.

Signed-off-by: David Safford <david.safford@ge.com>
 
---
 security/integrity/ima/ima_fs_tlv.c    | 105 ++++++++++
 security/integrity/ima/ima_queue_tlv.c |  95 +++++++++
 security/integrity/ima/ima_tlv.c       | 260 +++++++++++++++++++++++++
 security/integrity/ima/ima_tlv.h       |  77 ++++++++
 4 files changed, 537 insertions(+)
 create mode 100644 security/integrity/ima/ima_fs_tlv.c
 create mode 100644 security/integrity/ima/ima_queue_tlv.c
 create mode 100644 security/integrity/ima/ima_tlv.c
 create mode 100644 security/integrity/ima/ima_tlv.h

diff --git a/security/integrity/ima/ima_fs_tlv.c b/security/integrity/ima/ima_fs_tlv.c
new file mode 100644
index 000000000000..b8cdc8769a52
--- /dev/null
+++ b/security/integrity/ima/ima_fs_tlv.c
@@ -0,0 +1,105 @@
+/*
+ * Copyright (C) 2018 GE
+ * Author: David Safford <david.safford@ge.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation, version 2 of the
+ * License.
+ *
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/fcntl.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/seq_file.h>
+#include <linux/rculist.h>
+#include <linux/rcupdate.h>
+#include <linux/parser.h>
+#include <linux/vmalloc.h>
+
+#include "ima.h"
+
+extern struct mutex ima_extend_list_mutex;
+
+/*
+ * We are deleting each record after it is shown, so we always
+ * start at the head of the list, and need the mutex.
+ */
+void *ima_measurements_start(struct seq_file *m, loff_t *pos)
+{
+	struct ima_queue_entry *qe;
+
+	mutex_lock(&ima_extend_list_mutex);
+	qe = list_entry(ima_measurements.next, struct ima_queue_entry, later);
+	mutex_unlock(&ima_extend_list_mutex);
+	if (&qe->later == &ima_measurements)
+		return NULL;
+	return qe;
+}
+
+/*
+ * we have shown this record, delete it, and get the new queue head
+ */
+void *ima_measurements_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	struct ima_queue_entry *qe = v;
+
+	mutex_lock(&ima_extend_list_mutex);
+	list_del(&qe->later);
+	ima_free_queue_entry(qe);
+	qe = list_entry(ima_measurements.next, struct ima_queue_entry, later);
+	mutex_unlock(&ima_extend_list_mutex);
+	(*pos)++;
+	if (&qe->later == &ima_measurements)
+		return NULL;
+	return qe;
+}
+
+static void tlv_put(struct seq_file *m, u8 t, u32 l, u8 *v)
+{
+	u32 clen = cpu_to_le32(l);
+	ima_putc(m, &t, sizeof(t));
+	ima_putc(m, &clen, sizeof(clen));
+	ima_putc(m, v, l);
+}
+
+int ima_measurements_show(struct seq_file *m, void *v)
+{
+	struct ima_queue_entry *qe = v;
+	struct ima_record_entry *e;
+	u8 type;
+	u32 clen;
+
+	e = qe->entry;
+	if (e == NULL)
+		return -1;
+
+	tlv_put(m, IMA_TLV_SEQ, sizeof(e->seq), (u8 *)&(e->seq));
+	tlv_put(m, IMA_TLV_PCR, sizeof(e->pcr), (u8 *)&(e->pcr));
+
+	/* nest the digest */
+	type = IMA_TLV_DIGEST;
+	clen = cpu_to_le32(sizeof(e->digest) + 5);
+	ima_putc(m, &type, sizeof(type));
+	ima_putc(m, &clen, sizeof(clen));
+	tlv_put(m, ima_hash_algo, sizeof(e->digest), e->digest);
+
+	tlv_put(m, IMA_TLV_CONTENT, e->content.l, e->content.v);
+
+	return 0;
+}
+
+int __init ima_fs_record_init(void)
+{
+	tlv_runtime_measurements =
+	    securityfs_create_file("tlv_runtime_measurements",
+				   S_IRUSR | S_IRGRP, ima_dir, NULL,
+				   &ima_measurements_ops);
+	if (IS_ERR(tlv_runtime_measurements))
+		return -1;
+
+	return 0;
+}
diff --git a/security/integrity/ima/ima_queue_tlv.c b/security/integrity/ima/ima_queue_tlv.c
new file mode 100644
index 000000000000..c5205552b9d8
--- /dev/null
+++ b/security/integrity/ima/ima_queue_tlv.c
@@ -0,0 +1,95 @@
+/*
+ * Copyright (C) 2018 GE
+ * Author: David Safford <david.safford@ge.com
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation, version 2 of the
+ * License.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/module.h>
+#include <linux/rculist.h>
+#include <linux/slab.h>
+#include "ima.h"
+
+#define AUDIT_CAUSE_LEN_MAX 32
+
+LIST_HEAD(ima_measurements);	/* list of all measurements */
+
+struct ima_h_table ima_htable = {
+	.len = ATOMIC_LONG_INIT(0),
+	.violations = ATOMIC_LONG_INIT(0),
+	.queue[0 ... IMA_MEASURE_HTABLE_SIZE - 1] = HLIST_HEAD_INIT
+};
+
+/* mutex protects atomicity of extending measurement list
+ * and extending the TPM PCR aggregate. Since tpm_extend can take
+ * long (and the tpm driver uses a mutex), we can't use the spinlock.
+ */
+DEFINE_MUTEX(ima_extend_list_mutex);
+
+/* ima_add_template_entry helper function:
+ * - Add template entry to the measurement list and hash table, for
+ *   all entries except those carried across kexec.
+ *
+ * (Called with ima_extend_list_mutex held.)
+ */
+static int ima_add_digest_entry(struct ima_record_entry *entry)
+{
+	struct ima_queue_entry *qe;
+
+	qe = kmalloc(sizeof(*qe), GFP_KERNEL);
+	if (qe == NULL) {
+		pr_err("OUT OF MEMORY ERROR creating queue entry\n");
+		return -ENOMEM;
+	}
+	qe->entry = entry;
+
+	INIT_LIST_HEAD(&qe->later);
+	list_add_tail_rcu(&qe->later, &ima_measurements);
+	atomic_long_inc(&ima_htable.len);
+	return 0;
+}
+
+int ima_add_tlv_entry(struct ima_record_entry *entry, int violation,
+			   const char *op, struct inode *inode,
+			   const unsigned char *filename)
+{
+	u8 digest[TPM_DIGEST_SIZE];
+	const char *audit_cause = "hash_added";
+	char tpm_audit_cause[AUDIT_CAUSE_LEN_MAX];
+	int audit_info = 1;
+	int result = 0, tpmresult = 0;
+
+	mutex_lock(&ima_extend_list_mutex);
+
+	result = ima_add_digest_entry(entry);
+	if (result < 0) {
+		audit_cause = "ENOMEM";
+		audit_info = 0;
+		goto out;
+	}
+
+	if (violation)		/* invalidate pcr */
+		memset(digest, 0xff, sizeof(digest));
+	else
+		memcpy(digest, entry->digest, sizeof(digest));
+
+	tpmresult = ima_pcr_extend(digest, entry->pcr);
+	if (tpmresult != 0) {
+		snprintf(tpm_audit_cause, AUDIT_CAUSE_LEN_MAX, "TPM_error(%d)",
+			 tpmresult);
+		audit_cause = tpm_audit_cause;
+		audit_info = 0;
+	}
+out:
+	mutex_unlock(&ima_extend_list_mutex);
+	integrity_audit_msg(AUDIT_INTEGRITY_PCR, inode, filename,
+			    op, audit_cause, result, audit_info);
+	return result;
+}
+
+
diff --git a/security/integrity/ima/ima_tlv.c b/security/integrity/ima/ima_tlv.c
new file mode 100644
index 000000000000..104aa827bb0a
--- /dev/null
+++ b/security/integrity/ima/ima_tlv.c
@@ -0,0 +1,260 @@
+/*
+ * Copyright (C) 2018 GE
+ * Author:  David Safford <david.safford@ge.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation, version 2 of the
+ * License.
+ *
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/rculist.h>
+#include <crypto/hash.h>
+#include <linux/time.h>
+#include "ima.h"
+
+static u64 ima_seqnum;
+u32 ima_tlv_selected = 0x7f;
+
+void ima_free_record_entry(struct ima_record_entry *entry)
+{
+	kfree(entry->content.v);
+	kfree(entry);
+}
+
+void ima_free_queue_entry(struct ima_queue_entry *qe)
+{
+	ima_free_record_entry(qe->entry);
+	kfree(qe);
+}
+
+int ima_tlv_content_size(struct ima_event_data *event_data,
+			    struct ima_record_entry **entry)
+{
+	int l = 0;
+	struct inode *inode = NULL;
+	struct timespec ts;
+
+	if (event_data->file)
+		inode = file_inode(event_data->file);
+
+	if (is_selected(IMA_TLV_CONTENT_PATH))
+		l = l + IMA_TLV_HDR_SIZE + strlen(event_data->filename);
+	/* ima_hash may be null if violation */
+	if (is_selected(IMA_TLV_CONTENT_DATAHASH) && event_data->iint->ima_hash)
+		l = l + IMA_TLV_HDR_SIZE + event_data->iint->ima_hash->length;
+	/* may be null */
+	if (is_selected(IMA_TLV_CONTENT_OWNER) && inode)
+		l = l + IMA_TLV_HDR_SIZE + sizeof(inode->i_uid);
+	if (is_selected(IMA_TLV_CONTENT_GROUP) && inode)
+		l = l + IMA_TLV_HDR_SIZE + sizeof(inode->i_gid);
+	if (is_selected(IMA_TLV_CONTENT_MODE) && inode)
+		l = l + IMA_TLV_HDR_SIZE + sizeof(inode->i_mode);
+	if (is_selected(IMA_TLV_CONTENT_TIMESTAMP))
+		l = l + IMA_TLV_HDR_SIZE + sizeof(ts.tv_sec);
+	return l;
+}
+
+static void ima_tlv_buf(u8 *buf, u8 type, u32 l, const u8 *v)
+{
+	buf[0] = type;
+	*((u32 *)(buf + 1)) = cpu_to_le32(l);
+	memcpy(buf + IMA_TLV_HDR_SIZE, v, l);
+}
+
+static int ima_tlv_content_fill(struct ima_event_data *event_data,
+			    struct ima_record_entry **entry)
+{
+	int l = 0;
+	u8 *pos = (*entry)->content.v;
+	struct inode *inode = NULL;
+	struct timespec ts;
+
+	if (event_data->file)
+		inode = file_inode(event_data->file);
+
+	if (is_selected(IMA_TLV_CONTENT_PATH)) {
+		l = strlen(event_data->filename);
+		ima_tlv_buf(pos, IMA_TLV_CONTENT_PATH, l, event_data->filename);
+		pos = pos + IMA_TLV_HDR_SIZE + l;
+	}
+	/* ima_hash may be null if violation */
+	if (is_selected(IMA_TLV_CONTENT_DATAHASH) &&
+	    event_data->iint->ima_hash) {
+		l = event_data->iint->ima_hash->length;
+		ima_tlv_buf(pos, IMA_TLV_CONTENT_DATAHASH, l,
+			    event_data->iint->ima_hash->digest);
+		pos = pos + IMA_TLV_HDR_SIZE + l;
+	}
+	/* inode may be NULL */
+	if (is_selected(IMA_TLV_CONTENT_OWNER) && inode) {
+		ima_tlv_buf(pos, IMA_TLV_CONTENT_OWNER, sizeof(inode->i_uid),
+			   (const u8 *)&(inode->i_uid));
+		pos = pos + IMA_TLV_HDR_SIZE + sizeof(inode->i_uid);
+	}
+	if (is_selected(IMA_TLV_CONTENT_GROUP) && inode) {
+		ima_tlv_buf(pos, IMA_TLV_CONTENT_GROUP, sizeof(inode->i_gid),
+			   (const u8 *)&(inode->i_gid));
+		pos = pos + IMA_TLV_HDR_SIZE + sizeof(inode->i_gid);
+	}
+	if (is_selected(IMA_TLV_CONTENT_MODE) && inode) {
+		ima_tlv_buf(pos, IMA_TLV_CONTENT_MODE, sizeof(inode->i_mode),
+			   (const u8 *)&(inode->i_mode));
+		pos = pos + IMA_TLV_HDR_SIZE + sizeof(inode->i_mode);
+	}
+	if (is_selected(IMA_TLV_CONTENT_TIMESTAMP)) {
+		getnstimeofday(&ts);
+		ima_tlv_buf(pos, IMA_TLV_CONTENT_TIMESTAMP, sizeof(ts.tv_sec),
+			   (const u8 *)&(ts.tv_sec));
+		pos = pos + IMA_TLV_HDR_SIZE + sizeof(ts.tv_sec);
+	}
+
+	return l;
+}
+
+int ima_alloc_init_record(struct ima_event_data *event_data,
+			    struct ima_record_entry **entry)
+{
+	int len;
+	*entry = kzalloc(sizeof(**entry), GFP_NOFS);
+	if (!*entry)
+		return -ENOMEM;
+
+	len = ima_tlv_content_size(event_data, entry);
+	(*entry)->content.l = len;
+	(*entry)->content.t = IMA_TLV_CONTENT;
+	(*entry)->seq = ima_seqnum++;
+	(*entry)->content.v = kzalloc(len, GFP_KERNEL);
+	if (!(*entry)->content.v) {
+		kfree(*entry);
+		return -ENOMEM;
+	}
+	return ima_tlv_content_fill(event_data, entry);
+}
+
+int ima_store_record(struct ima_record_entry *entry,
+		       int violation, struct inode *inode,
+		       const unsigned char *filename, int pcr)
+{
+	static const char op[] = "add_tlv_measure";
+	static const char audit_cause[] = "hashing_error";
+	int result;
+	struct {
+		struct ima_digest_data hdr;
+		char digest[TPM_DIGEST_SIZE];
+	} hash;
+
+	if (!violation) {
+		/* this function uses default algo */
+		hash.hdr.algo = HASH_ALGO_SHA1;
+		result = ima_calc_field_array_hash(&entry->content, &hash.hdr);
+		if (result < 0) {
+			integrity_audit_msg(AUDIT_INTEGRITY_PCR, inode,
+					    "tlv", op,
+					    audit_cause, result, 0);
+			return result;
+		}
+		memcpy(entry->digest, hash.hdr.digest, hash.hdr.length);
+	}
+	entry->pcr = pcr;
+	result = ima_add_tlv_entry(entry, violation, op, inode, filename);
+	return result;
+}
+
+/*
+ * Calculate the hash of ima content tlv data (this is what gets extended)
+ */
+static int ima_calc_field_array_hash_tfm(struct ima_tlv *field_data,
+					 struct ima_digest_data *hash,
+					 struct crypto_shash *tfm)
+{
+	SHASH_DESC_ON_STACK(shash, tfm);
+	u32 datalen, datalen_to_hash;
+	u8 *data_to_hash;
+	int rc;
+
+	shash->tfm = tfm;
+	shash->flags = 0;
+
+	hash->length = crypto_shash_digestsize(tfm);
+
+	rc = crypto_shash_init(shash);
+	if (rc != 0)
+		return rc;
+
+	/* hash the 't' byte */
+	rc = crypto_shash_update(shash, (const u8 *)&(field_data->t), 1);
+
+	/* hash the canonical (little endian) 'l' field */
+	datalen = field_data->l;
+	datalen_to_hash = cpu_to_le32(datalen);
+	rc = crypto_shash_update(shash, (const u8 *)&datalen_to_hash, sizeof(datalen));
+
+	/* hash the ima content */
+	data_to_hash = field_data->v;
+	rc = crypto_shash_update(shash, (const u8 *)data_to_hash, datalen);
+
+	rc = crypto_shash_final(shash, hash->digest);
+
+	return rc;
+}
+
+int ima_calc_field_array_hash(struct ima_tlv *field_data, struct ima_digest_data *hash)
+{
+	struct crypto_shash *tfm;
+	int rc;
+
+	tfm = ima_alloc_tfm(hash->algo);
+	if (IS_ERR(tfm))
+		return PTR_ERR(tfm);
+
+	rc = ima_calc_field_array_hash_tfm(field_data, hash, tfm);
+
+	ima_free_tfm(tfm);
+
+	return rc;
+}
+
+int ima_need_xattr(void)
+{
+	if (ima_tlv_selected & IMA_TLV_CONTENT_LABEL)
+		return 1;
+	else
+		return 0;
+}
+
+int __init ima_init_selected(char *str)
+{
+	u32 temp;
+
+	if (!kstrtou32(str, 0, &temp))
+		ima_tlv_selected = temp;
+	return 0;
+}
+__setup("ima_tlv_selected=", ima_init_selected);
+
+void __init ima_init_record_list(void)
+{
+
+}
+
+int __init ima_init_records(void)
+{
+	return 0;
+}
+
+int __init ima_hash_setup(char *str)
+{
+	int i;
+
+	ima_hash_algo = HASH_ALGO_SHA256;
+	i = match_string(hash_algo_name, HASH_ALGO__LAST, str);
+	if (i > 0)
+		ima_hash_algo = i;
+	ima_hash_setup_done = 1;
+	return 1;
+}
+__setup("ima_hash=", ima_hash_setup);
diff --git a/security/integrity/ima/ima_tlv.h b/security/integrity/ima/ima_tlv.h
new file mode 100644
index 000000000000..f4861a6c7f65
--- /dev/null
+++ b/security/integrity/ima/ima_tlv.h
@@ -0,0 +1,77 @@
+/*
+ * Copyright (C) 2018 GE
+ *
+ * Author: David Safford <david.safford@ge.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation, version 2 of the
+ * License.
+ *
+ */
+
+#ifndef __LINUX_IMA_TLV_H
+#define __LINUX_IMA_TLV_H
+
+/* TCG Top Level TLV Types */
+#define IMA_TLV_SEQ	0
+#define IMA_TLV_PCR	1
+#define IMA_TLV_DIGEST		2
+#define IMA_TLV_CONTENT	7
+
+/* TCG Digest Types */
+#define IMA_TLV_DIGEST_SHA1	4
+#define IMA_TLV_DIGEST_SHA256	8
+
+/* IMA Specific Content Types */
+#define IMA_TLV_CONTENT_PATH		0
+#define IMA_TLV_CONTENT_DATAHASH	1
+#define IMA_TLV_CONTENT_DATASIG		2
+#define IMA_TLV_CONTENT_OWNER		3
+#define IMA_TLV_CONTENT_GROUP		4
+#define IMA_TLV_CONTENT_MODE		5
+#define IMA_TLV_CONTENT_TIMESTAMP	6
+#define IMA_TLV_CONTENT_LABEL		7
+
+struct ima_tlv {
+	u8 t;
+	u32 l;
+	u8 *v;
+};
+
+struct ima_record_entry {
+	u64 seq;
+	u8 pcr;
+	u8 digest[TPM_DIGEST_SIZE];
+	struct ima_tlv content;
+};
+
+struct ima_queue_entry {
+	struct list_head later;
+	struct ima_record_entry *entry;
+};
+extern struct list_head ima_measurements;
+
+#define is_selected(x) ((1<<(x)) & ima_tlv_selected)
+#define IMA_TLV_HDR_SIZE (sizeof(u8) + sizeof(u32))
+
+int ima_add_tlv_entry(struct ima_record_entry *entry, int violation,
+			   const char *op, struct inode *inode,
+			   const unsigned char *filename);
+
+int ima_calc_field_array_hash(struct ima_tlv *field_data,
+			      struct ima_digest_data *hash);
+
+int ima_need_xattr(void);
+int ima_init_records(void);
+void ima_init_record_list(void);
+int ima_alloc_init_record(struct ima_event_data *event_data,
+		       struct ima_record_entry **entry);
+int ima_store_record(struct ima_record_entry *entry, int violation,
+		       struct inode *inode,
+		       const unsigned char *filename, int pcr);
+void ima_free_record_entry(struct ima_record_entry *entry);
+void ima_free_queue_entry(struct ima_queue_entry *qe);
+
+
+#endif /* __LINUX_IMA_TLV_H */
--
2.17.1

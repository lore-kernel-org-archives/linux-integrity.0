Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-00176a03.pphosted.com ([67.231.157.48]:50440 "EHLO
        mx0a-00176a03.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726567AbeH1LmB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 28 Aug 2018 07:42:01 -0400
Received: from pps.filterd (m0048206.ppops.net [127.0.0.1])
        by m0048206.ppops.net-00176a03. (8.16.0.22/8.16.0.22) with SMTP id w7S6cwMl004331
        for <linux-integrity@vger.kernel.org>; Tue, 28 Aug 2018 02:41:14 -0400
From: "Safford, David (GE Global Research, US)" <david.safford@ge.com>
To: "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
CC: Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [RFC PATCH 1/2] refactor IMA template code into separate files.
Date: Tue, 28 Aug 2018 06:41:05 +0000
Message-ID: <BCA04D5D9A3B764C9B7405BBA4D4A3C00256922E@ALPMBAPA12.e2k.ad.ge.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

This RFC patch refactors the existing IMA template code, to enable the addition
of a separate TLV formatted measurement list. There are few changes to the
code, other than moving the template specific code into template specific files.

Signed-off-by: David Safford <david.safford@ge.com>
---
 security/integrity/ima/Kconfig                |  17 +-
 security/integrity/ima/Makefile               |   6 +-
 security/integrity/ima/ima.h                  |  85 ++-----
 security/integrity/ima/ima_api.c              | 113 +--------
 security/integrity/ima/ima_crypto.c           |  88 ++-----
 security/integrity/ima/ima_fs.c               | 207 +---------------
 security/integrity/ima/ima_fs_template.c      | 230 ++++++++++++++++++
 security/integrity/ima/ima_init.c             |  10 +-
 security/integrity/ima/ima_main.c             |  43 +---
 security/integrity/ima/ima_policy.c           |   6 +-
 .../ima/{ima_queue.c => ima_queue_template.c} |  21 +-
 security/integrity/ima/ima_template.c         | 219 ++++++++++++++++-
 security/integrity/ima/ima_template.h         |  88 +++++++
 13 files changed, 630 insertions(+), 503 deletions(-)
 create mode 100644 security/integrity/ima/ima_fs_template.c
 rename security/integrity/ima/{ima_queue.c => ima_queue_template.c} (90%)
 create mode 100644 security/integrity/ima/ima_template.h

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 6a8f67714c83..5d549356ffd3 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -57,10 +57,23 @@ config IMA_LSM_RULES
 	help
 	  Disabling this option will disregard LSM based policy rules.
 
+choice
+	prompt "IMA measurement list format"
+	default IMA_LIST_TEMPLATE
+	depends on IMA
+	help
+	  Choose the original template format or new TLV format.
+
+	config IMA_LIST_TEMPLATE
+		bool "template"
+	config IMA_LIST_TLV
+		bool "tlv"
+endchoice
+
 choice
 	prompt "Default template"
 	default IMA_NG_TEMPLATE
-	depends on IMA
+	depends on IMA && IMA_LIST_TEMPLATE
 	help
 	  Select the default IMA measurement template.
 
@@ -80,7 +93,7 @@ endchoice
 
 config IMA_DEFAULT_TEMPLATE
 	string
-	depends on IMA
+	depends on IMA && IMA_LIST_TEMPLATE
 	default "ima" if IMA_TEMPLATE
 	default "ima-ng" if IMA_NG_TEMPLATE
 	default "ima-sig" if IMA_SIG_TEMPLATE
diff --git a/security/integrity/ima/Makefile b/security/integrity/ima/Makefile
index d921dc4f9eb0..7845a7c9d6c7 100644
--- a/security/integrity/ima/Makefile
+++ b/security/integrity/ima/Makefile
@@ -6,8 +6,10 @@
 
 obj-$(CONFIG_IMA) += ima.o
 
-ima-y := ima_fs.o ima_queue.o ima_init.o ima_main.o ima_crypto.o ima_api.o \
-	 ima_policy.o ima_template.o ima_template_lib.o
+ima-y := ima_fs.o ima_init.o ima_main.o ima_crypto.o ima_api.o ima_policy.o
 ima-$(CONFIG_IMA_APPRAISE) += ima_appraise.o
 ima-$(CONFIG_HAVE_IMA_KEXEC) += ima_kexec.o
+ima-$(CONFIG_IMA_LIST_TLV) += ima_queue_tlv.o ima_tlv.o ima_fs_tlv.o
+ima-$(CONFIG_IMA_LIST_TEMPLATE) += ima_queue_template.o ima_template.o \
+				ima_fs_template.o ima_template_lib.o
 obj-$(CONFIG_IMA_BLACKLIST_KEYRING) += ima_mok.o
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 354bb5716ce3..b11b5769a446 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -32,6 +32,7 @@
 #include <asm/ima.h>
 #endif
 
+
 enum ima_show_type { IMA_SHOW_BINARY, IMA_SHOW_BINARY_NO_FIELD_LEN,
 		     IMA_SHOW_BINARY_OLD_STRING_FMT, IMA_SHOW_ASCII };
 enum tpm_pcrs { TPM_PCR0 = 0, TPM_PCR8 = 8 };
@@ -43,12 +44,6 @@ enum tpm_pcrs { TPM_PCR0 = 0, TPM_PCR8 = 8 };
 #define IMA_HASH_BITS 9
 #define IMA_MEASURE_HTABLE_SIZE (1 << IMA_HASH_BITS)
 
-#define IMA_TEMPLATE_FIELD_ID_MAX_LEN	16
-#define IMA_TEMPLATE_NUM_FIELDS_MAX	15
-
-#define IMA_TEMPLATE_IMA_NAME "ima"
-#define IMA_TEMPLATE_IMA_FMT "d|n"
-
 /* current content of the policy */
 extern int ima_policy_flag;
 
@@ -67,43 +62,7 @@ struct ima_event_data {
 	const char *violation;
 };
 
-/* IMA template field data definition */
-struct ima_field_data {
-	u8 *data;
-	u32 len;
-};
-
-/* IMA template field definition */
-struct ima_template_field {
-	const char field_id[IMA_TEMPLATE_FIELD_ID_MAX_LEN];
-	int (*field_init)(struct ima_event_data *event_data,
-			  struct ima_field_data *field_data);
-	void (*field_show)(struct seq_file *m, enum ima_show_type show,
-			   struct ima_field_data *field_data);
-};
-
-/* IMA template descriptor definition */
-struct ima_template_desc {
-	struct list_head list;
-	char *name;
-	char *fmt;
-	int num_fields;
-	struct ima_template_field **fields;
-};
-
-struct ima_template_entry {
-	int pcr;
-	u8 digest[TPM_DIGEST_SIZE];	/* sha1 or md5 measurement hash */
-	struct ima_template_desc *template_desc; /* template descriptor */
-	u32 template_data_len;
-	struct ima_field_data template_data[0];	/* template related data */
-};
 
-struct ima_queue_entry {
-	struct hlist_node hnext;	/* place in hash collision list */
-	struct list_head later;		/* place in ima_measurements list */
-	struct ima_template_entry *entry;
-};
 extern struct list_head ima_measurements;	/* list of all measurements */
 
 /* Some details preceding the binary serialized measurement list */
@@ -130,15 +89,23 @@ extern bool ima_canonical_fmt;
 /* Internal IMA function definitions */
 int ima_init(void);
 int ima_fs_init(void);
-int ima_add_template_entry(struct ima_template_entry *entry, int violation,
-			   const char *op, struct inode *inode,
-			   const unsigned char *filename);
+int ima_fs_record_init(void);
+int ima_hash_setup(char *str);
+extern int ima_hash_algo;
+extern int ima_hash_setup_done;
+extern struct dentry *ima_dir;
+extern struct dentry *binary_runtime_measurements;
+extern struct dentry *tlv_runtime_measurements;
+extern struct dentry *ascii_runtime_measurements;
+extern const struct file_operations ima_measurements_ops;
+extern const struct file_operations ima_ascii_measurements_ops;
+extern void ima_measurements_stop(struct seq_file *m, void *v);
+struct crypto_shash *ima_alloc_tfm(enum hash_algo algo);
+void ima_free_tfm(struct crypto_shash *tfm);
 int ima_calc_file_hash(struct file *file, struct ima_digest_data *hash);
 int ima_calc_buffer_hash(const void *buf, loff_t len,
 			 struct ima_digest_data *hash);
-int ima_calc_field_array_hash(struct ima_field_data *field_data,
-			      struct ima_template_desc *desc, int num_fields,
-			      struct ima_digest_data *hash);
+int ima_pcr_extend(const u8 *hash, int pcr);
 int __init ima_calc_boot_aggregate(struct ima_digest_data *hash);
 void ima_add_violation(struct file *file, const unsigned char *filename,
 		       struct integrity_iint_cache *iint,
@@ -146,13 +113,13 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
 int ima_init_crypto(void);
 void ima_putc(struct seq_file *m, void *data, int datalen);
 void ima_print_digest(struct seq_file *m, u8 *digest, u32 size);
-struct ima_template_desc *ima_template_desc_current(void);
-int ima_restore_measurement_entry(struct ima_template_entry *entry);
+
 int ima_restore_measurement_list(loff_t bufsize, void *buf);
 int ima_measurements_show(struct seq_file *m, void *v);
+int ima_ascii_measurements_show(struct seq_file *m, void *v);
+void *ima_measurements_start(struct seq_file *m, loff_t *pos);
+void *ima_measurements_next(struct seq_file *m, void *v, loff_t *pos);
 unsigned long ima_get_binary_runtime_size(void);
-int ima_init_template(void);
-void ima_init_template_list(void);
 
 /*
  * used to protect h_table and sha_table
@@ -190,6 +157,12 @@ enum ima_hooks {
 	__ima_hooks(__ima_hook_enumify)
 };
 
+#ifdef CONFIG_IMA_LIST_TLV
+#include "ima_tlv.h"
+#else
+#include "ima_template.h"
+#endif
+
 /* LIM API function definitions */
 int ima_get_action(struct inode *inode, const struct cred *cred, u32 secid,
 		   int mask, enum ima_hooks func, int *pcr);
@@ -203,12 +176,7 @@ void ima_store_measurement(struct integrity_iint_cache *iint, struct file *file,
 			   int xattr_len, int pcr);
 void ima_audit_measurement(struct integrity_iint_cache *iint,
 			   const unsigned char *filename);
-int ima_alloc_init_template(struct ima_event_data *event_data,
-			    struct ima_template_entry **entry);
-int ima_store_template(struct ima_template_entry *entry, int violation,
-		       struct inode *inode,
-		       const unsigned char *filename, int pcr);
-void ima_free_template_entry(struct ima_template_entry *entry);
+
 const char *ima_d_path(const struct path *path, char **pathbuf, char *filename);
 
 /* IMA policy related functions */
@@ -318,5 +286,4 @@ static inline int security_filter_rule_match(u32 secid, u32 field, u32 op,
 #else
 #define	POLICY_FILE_FLAGS	S_IWUSR
 #endif /* CONFIG_IMA_READ_POLICY */
-
 #endif /* __LINUX_IMA_H */
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index a02c5acfd403..6443777d0fa1 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -22,103 +22,6 @@
 
 #include "ima.h"
 
-/*
- * ima_free_template_entry - free an existing template entry
- */
-void ima_free_template_entry(struct ima_template_entry *entry)
-{
-	int i;
-
-	for (i = 0; i < entry->template_desc->num_fields; i++)
-		kfree(entry->template_data[i].data);
-
-	kfree(entry);
-}
-
-/*
- * ima_alloc_init_template - create and initialize a new template entry
- */
-int ima_alloc_init_template(struct ima_event_data *event_data,
-			    struct ima_template_entry **entry)
-{
-	struct ima_template_desc *template_desc = ima_template_desc_current();
-	int i, result = 0;
-
-	*entry = kzalloc(sizeof(**entry) + template_desc->num_fields *
-			 sizeof(struct ima_field_data), GFP_NOFS);
-	if (!*entry)
-		return -ENOMEM;
-
-	(*entry)->template_desc = template_desc;
-	for (i = 0; i < template_desc->num_fields; i++) {
-		struct ima_template_field *field = template_desc->fields[i];
-		u32 len;
-
-		result = field->field_init(event_data,
-					   &((*entry)->template_data[i]));
-		if (result != 0)
-			goto out;
-
-		len = (*entry)->template_data[i].len;
-		(*entry)->template_data_len += sizeof(len);
-		(*entry)->template_data_len += len;
-	}
-	return 0;
-out:
-	ima_free_template_entry(*entry);
-	*entry = NULL;
-	return result;
-}
-
-/*
- * ima_store_template - store ima template measurements
- *
- * Calculate the hash of a template entry, add the template entry
- * to an ordered list of measurement entries maintained inside the kernel,
- * and also update the aggregate integrity value (maintained inside the
- * configured TPM PCR) over the hashes of the current list of measurement
- * entries.
- *
- * Applications retrieve the current kernel-held measurement list through
- * the securityfs entries in /sys/kernel/security/ima. The signed aggregate
- * TPM PCR (called quote) can be retrieved using a TPM user space library
- * and is used to validate the measurement list.
- *
- * Returns 0 on success, error code otherwise
- */
-int ima_store_template(struct ima_template_entry *entry,
-		       int violation, struct inode *inode,
-		       const unsigned char *filename, int pcr)
-{
-	static const char op[] = "add_template_measure";
-	static const char audit_cause[] = "hashing_error";
-	char *template_name = entry->template_desc->name;
-	int result;
-	struct {
-		struct ima_digest_data hdr;
-		char digest[TPM_DIGEST_SIZE];
-	} hash;
-
-	if (!violation) {
-		int num_fields = entry->template_desc->num_fields;
-
-		/* this function uses default algo */
-		hash.hdr.algo = HASH_ALGO_SHA1;
-		result = ima_calc_field_array_hash(&entry->template_data[0],
-						   entry->template_desc,
-						   num_fields, &hash.hdr);
-		if (result < 0) {
-			integrity_audit_msg(AUDIT_INTEGRITY_PCR, inode,
-					    template_name, op,
-					    audit_cause, result, 0);
-			return result;
-		}
-		memcpy(entry->digest, hash.hdr.digest, hash.hdr.length);
-	}
-	entry->pcr = pcr;
-	result = ima_add_template_entry(entry, violation, op, inode, filename);
-	return result;
-}
 
 /*
  * ima_add_violation - add violation to measurement list.
@@ -131,7 +34,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
 		       struct integrity_iint_cache *iint,
 		       const char *op, const char *cause)
 {
-	struct ima_template_entry *entry;
+	struct ima_record_entry *entry;
 	struct inode *inode = file_inode(file);
 	struct ima_event_data event_data = {iint, file, filename, NULL, 0,
 					    cause};
@@ -141,15 +44,15 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
 	/* can overflow, only indicator */
 	atomic_long_inc(&ima_htable.violations);
 
-	result = ima_alloc_init_template(&event_data, &entry);
+	result = ima_alloc_init_record(&event_data, &entry);
 	if (result < 0) {
 		result = -ENOMEM;
 		goto err_out;
 	}
-	result = ima_store_template(entry, violation, inode,
+	result = ima_store_record(entry, violation, inode,
 				    filename, CONFIG_IMA_MEASURE_PCR_IDX);
 	if (result < 0)
-		ima_free_template_entry(entry);
+		ima_free_record_entry(entry);
 err_out:
 	integrity_audit_msg(AUDIT_INTEGRITY_PCR, inode, filename,
 			    op, cause, result, 0);
@@ -283,7 +186,7 @@ void ima_store_measurement(struct integrity_iint_cache *iint,
 	static const char audit_cause[] = "ENOMEM";
 	int result = -ENOMEM;
 	struct inode *inode = file_inode(file);
-	struct ima_template_entry *entry;
+	struct ima_record_entry *entry;
 	struct ima_event_data event_data = {iint, file, filename, xattr_value,
 					    xattr_len, NULL};
 	int violation = 0;
@@ -291,20 +194,20 @@ void ima_store_measurement(struct integrity_iint_cache *iint,
 	if (iint->measured_pcrs & (0x1 << pcr))
 		return;
 
-	result = ima_alloc_init_template(&event_data, &entry);
+	result = ima_alloc_init_record(&event_data, &entry);
 	if (result < 0) {
 		integrity_audit_msg(AUDIT_INTEGRITY_PCR, inode, filename,
 				    op, audit_cause, result, 0);
 		return;
 	}
 
-	result = ima_store_template(entry, violation, inode, filename, pcr);
+	result = ima_store_record(entry, violation, inode, filename, pcr);
 	if ((!result || result == -EEXIST) && !(file->f_flags & O_DIRECT)) {
 		iint->flags |= IMA_MEASURED;
 		iint->measured_pcrs |= (0x1 << pcr);
 	}
 	if (result < 0)
-		ima_free_template_entry(entry);
+		ima_free_record_entry(entry);
 }
 
 void ima_audit_measurement(struct integrity_iint_cache *iint,
diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index 4e085a17124f..3f34af6c48ce 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -78,7 +78,7 @@ int __init ima_init_crypto(void)
 	return 0;
 }
 
-static struct crypto_shash *ima_alloc_tfm(enum hash_algo algo)
+struct crypto_shash *ima_alloc_tfm(enum hash_algo algo)
 {
 	struct crypto_shash *tfm = ima_shash_tfm;
 	int rc;
@@ -97,7 +97,7 @@ static struct crypto_shash *ima_alloc_tfm(enum hash_algo algo)
 	return tfm;
 }
 
-static void ima_free_tfm(struct crypto_shash *tfm)
+void ima_free_tfm(struct crypto_shash *tfm)
 {
 	if (tfm != ima_shash_tfm)
 		crypto_free_shash(tfm);
@@ -442,74 +442,7 @@ int ima_calc_file_hash(struct file *file, struct ima_digest_data *hash)
 	return ima_calc_file_shash(file, hash);
 }
 
-/*
- * Calculate the hash of template data
- */
-static int ima_calc_field_array_hash_tfm(struct ima_field_data *field_data,
-					 struct ima_template_desc *td,
-					 int num_fields,
-					 struct ima_digest_data *hash,
-					 struct crypto_shash *tfm)
-{
-	SHASH_DESC_ON_STACK(shash, tfm);
-	int rc, i;
-
-	shash->tfm = tfm;
-	shash->flags = 0;
-
-	hash->length = crypto_shash_digestsize(tfm);
-
-	rc = crypto_shash_init(shash);
-	if (rc != 0)
-		return rc;
-
-	for (i = 0; i < num_fields; i++) {
-		u8 buffer[IMA_EVENT_NAME_LEN_MAX + 1] = { 0 };
-		u8 *data_to_hash = field_data[i].data;
-		u32 datalen = field_data[i].len;
-		u32 datalen_to_hash =
-		    !ima_canonical_fmt ? datalen : cpu_to_le32(datalen);
-
-		if (strcmp(td->name, IMA_TEMPLATE_IMA_NAME) != 0) {
-			rc = crypto_shash_update(shash,
-						(const u8 *) &datalen_to_hash,
-						sizeof(datalen_to_hash));
-			if (rc)
-				break;
-		} else if (strcmp(td->fields[i]->field_id, "n") == 0) {
-			memcpy(buffer, data_to_hash, datalen);
-			data_to_hash = buffer;
-			datalen = IMA_EVENT_NAME_LEN_MAX + 1;
-		}
-		rc = crypto_shash_update(shash, data_to_hash, datalen);
-		if (rc)
-			break;
-	}
-
-	if (!rc)
-		rc = crypto_shash_final(shash, hash->digest);
-
-	return rc;
-}
-
-int ima_calc_field_array_hash(struct ima_field_data *field_data,
-			      struct ima_template_desc *desc, int num_fields,
-			      struct ima_digest_data *hash)
-{
-	struct crypto_shash *tfm;
-	int rc;
-
-	tfm = ima_alloc_tfm(hash->algo);
-	if (IS_ERR(tfm))
-		return PTR_ERR(tfm);
-
-	rc = ima_calc_field_array_hash_tfm(field_data, desc, num_fields,
-					   hash, tfm);
-
-	ima_free_tfm(tfm);
 
-	return rc;
-}
 
 static int calc_buffer_ahash_atfm(const void *buf, loff_t len,
 				  struct ima_digest_data *hash,
@@ -638,6 +571,23 @@ static void __init ima_pcrread(int idx, u8 *pcr)
 		pr_err("Error Communicating to TPM chip\n");
 }
 
+/*
+ * FIXME - This still assumes SHA1
+ */
+int ima_pcr_extend(const u8 *hash, int pcr)
+{
+	int result = 0;
+
+	if (!ima_used_chip)
+		return result;
+
+	result = tpm_pcr_extend(NULL, pcr, hash);
+	if (result != 0)
+		pr_err("Error Communicating to TPM chip, result: %d\n", result);
+	return result;
+}
+
+
 /*
  * Calculate the boot aggregate hash
  */
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index ae9d5c766a3c..f3375ca5b268 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -31,16 +31,6 @@
 
 static DEFINE_MUTEX(ima_write_mutex);
 
-bool ima_canonical_fmt;
-static int __init default_canonical_fmt_setup(char *str)
-{
-#ifdef __BIG_ENDIAN
-	ima_canonical_fmt = true;
-#endif
-	return 1;
-}
-__setup("ima_canonical_fmt", default_canonical_fmt_setup);
-
 static int valid_policy = 1;
 #define TMPBUFLEN 12
 static ssize_t ima_show_htable_value(char __user *buf, size_t count,
@@ -78,40 +68,8 @@ static const struct file_operations ima_measurements_count_ops = {
 	.llseek = generic_file_llseek,
 };
 
-/* returns pointer to hlist_node */
-static void *ima_measurements_start(struct seq_file *m, loff_t *pos)
-{
-	loff_t l = *pos;
-	struct ima_queue_entry *qe;
-
-	/* we need a lock since pos could point beyond last element */
-	rcu_read_lock();
-	list_for_each_entry_rcu(qe, &ima_measurements, later) {
-		if (!l--) {
-			rcu_read_unlock();
-			return qe;
-		}
-	}
-	rcu_read_unlock();
-	return NULL;
-}
 
-static void *ima_measurements_next(struct seq_file *m, void *v, loff_t *pos)
-{
-	struct ima_queue_entry *qe = v;
-
-	/* lock protects when reading beyond last element
-	 * against concurrent list-extension
-	 */
-	rcu_read_lock();
-	qe = list_entry_rcu(qe->later.next, struct ima_queue_entry, later);
-	rcu_read_unlock();
-	(*pos)++;
-
-	return (&qe->later == &ima_measurements) ? NULL : qe;
-}
-
-static void ima_measurements_stop(struct seq_file *m, void *v)
+void ima_measurements_stop(struct seq_file *m, void *v)
 {
 }
 
@@ -121,75 +79,6 @@ void ima_putc(struct seq_file *m, void *data, int datalen)
 		seq_putc(m, *(char *)data++);
 }
 
-/* print format:
- *       32bit-le=pcr#
- *       char[20]=template digest
- *       32bit-le=template name size
- *       char[n]=template name
- *       [eventdata length]
- *       eventdata[n]=template specific data
- */
-int ima_measurements_show(struct seq_file *m, void *v)
-{
-	/* the list never shrinks, so we don't need a lock here */
-	struct ima_queue_entry *qe = v;
-	struct ima_template_entry *e;
-	char *template_name;
-	u32 pcr, namelen, template_data_len; /* temporary fields */
-	bool is_ima_template = false;
-	int i;
-
-	/* get entry */
-	e = qe->entry;
-	if (e == NULL)
-		return -1;
-
-	template_name = (e->template_desc->name[0] != '\0') ?
-	    e->template_desc->name : e->template_desc->fmt;
-
-	/*
-	 * 1st: PCRIndex
-	 * PCR used defaults to the same (config option) in
-	 * little-endian format, unless set in policy
-	 */
-	pcr = !ima_canonical_fmt ? e->pcr : cpu_to_le32(e->pcr);
-	ima_putc(m, &pcr, sizeof(e->pcr));
-
-	/* 2nd: template digest */
-	ima_putc(m, e->digest, TPM_DIGEST_SIZE);
-
-	/* 3rd: template name size */
-	namelen = !ima_canonical_fmt ? strlen(template_name) :
-		cpu_to_le32(strlen(template_name));
-	ima_putc(m, &namelen, sizeof(namelen));
-
-	/* 4th:  template name */
-	ima_putc(m, template_name, strlen(template_name));
-
-	/* 5th:  template length (except for 'ima' template) */
-	if (strcmp(template_name, IMA_TEMPLATE_IMA_NAME) == 0)
-		is_ima_template = true;
-
-	if (!is_ima_template) {
-		template_data_len = !ima_canonical_fmt ? e->template_data_len :
-			cpu_to_le32(e->template_data_len);
-		ima_putc(m, &template_data_len, sizeof(e->template_data_len));
-	}
-
-	/* 6th:  template specific data */
-	for (i = 0; i < e->template_desc->num_fields; i++) {
-		enum ima_show_type show = IMA_SHOW_BINARY;
-		struct ima_template_field *field = e->template_desc->fields[i];
-
-		if (is_ima_template && strcmp(field->field_id, "d") == 0)
-			show = IMA_SHOW_BINARY_NO_FIELD_LEN;
-		if (is_ima_template && strcmp(field->field_id, "n") == 0)
-			show = IMA_SHOW_BINARY_OLD_STRING_FMT;
-		field->field_show(m, show, &e->template_data[i]);
-	}
-	return 0;
-}
-
 static const struct seq_operations ima_measurments_seqops = {
 	.start = ima_measurements_start,
 	.next = ima_measurements_next,
@@ -202,79 +91,13 @@ static int ima_measurements_open(struct inode *inode, struct file *file)
 	return seq_open(file, &ima_measurments_seqops);
 }
 
-static const struct file_operations ima_measurements_ops = {
+const struct file_operations ima_measurements_ops = {
 	.open = ima_measurements_open,
 	.read = seq_read,
 	.llseek = seq_lseek,
 	.release = seq_release,
 };
 
-void ima_print_digest(struct seq_file *m, u8 *digest, u32 size)
-{
-	u32 i;
-
-	for (i = 0; i < size; i++)
-		seq_printf(m, "%02x", *(digest + i));
-}
-
-/* print in ascii */
-static int ima_ascii_measurements_show(struct seq_file *m, void *v)
-{
-	/* the list never shrinks, so we don't need a lock here */
-	struct ima_queue_entry *qe = v;
-	struct ima_template_entry *e;
-	char *template_name;
-	int i;
-
-	/* get entry */
-	e = qe->entry;
-	if (e == NULL)
-		return -1;
-
-	template_name = (e->template_desc->name[0] != '\0') ?
-	    e->template_desc->name : e->template_desc->fmt;
-
-	/* 1st: PCR used (config option) */
-	seq_printf(m, "%2d ", e->pcr);
-
-	/* 2nd: SHA1 template hash */
-	ima_print_digest(m, e->digest, TPM_DIGEST_SIZE);
-
-	/* 3th:  template name */
-	seq_printf(m, " %s", template_name);
-
-	/* 4th:  template specific data */
-	for (i = 0; i < e->template_desc->num_fields; i++) {
-		seq_puts(m, " ");
-		if (e->template_data[i].len == 0)
-			continue;
-
-		e->template_desc->fields[i]->field_show(m, IMA_SHOW_ASCII,
-							&e->template_data[i]);
-	}
-	seq_puts(m, "\n");
-	return 0;
-}
-
-static const struct seq_operations ima_ascii_measurements_seqops = {
-	.start = ima_measurements_start,
-	.next = ima_measurements_next,
-	.stop = ima_measurements_stop,
-	.show = ima_ascii_measurements_show
-};
-
-static int ima_ascii_measurements_open(struct inode *inode, struct file *file)
-{
-	return seq_open(file, &ima_ascii_measurements_seqops);
-}
-
-static const struct file_operations ima_ascii_measurements_ops = {
-	.open = ima_ascii_measurements_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = seq_release,
-};
-
 static ssize_t ima_read_policy(char *path)
 {
 	void *data;
@@ -358,13 +181,14 @@ static ssize_t ima_write_policy(struct file *file, const char __user *buf,
 	return result;
 }
 
-static struct dentry *ima_dir;
-static struct dentry *ima_symlink;
-static struct dentry *binary_runtime_measurements;
-static struct dentry *ascii_runtime_measurements;
+struct dentry *ima_dir;
+struct dentry *binary_runtime_measurements;
+struct dentry *tlv_runtime_measurements;
+struct dentry *ascii_runtime_measurements;
 static struct dentry *runtime_measurements_count;
 static struct dentry *violations;
 static struct dentry *ima_policy;
+static struct dentry *ima_symlink;
 
 enum ima_fs_flags {
 	IMA_FS_BUSY,
@@ -463,20 +287,6 @@ int __init ima_fs_init(void)
 	if (IS_ERR(ima_symlink))
 		goto out;
 
-	binary_runtime_measurements =
-	    securityfs_create_file("binary_runtime_measurements",
-				   S_IRUSR | S_IRGRP, ima_dir, NULL,
-				   &ima_measurements_ops);
-	if (IS_ERR(binary_runtime_measurements))
-		goto out;
-
-	ascii_runtime_measurements =
-	    securityfs_create_file("ascii_runtime_measurements",
-				   S_IRUSR | S_IRGRP, ima_dir, NULL,
-				   &ima_ascii_measurements_ops);
-	if (IS_ERR(ascii_runtime_measurements))
-		goto out;
-
 	runtime_measurements_count =
 	    securityfs_create_file("runtime_measurements_count",
 				   S_IRUSR | S_IRGRP, ima_dir, NULL,
@@ -496,6 +306,9 @@ int __init ima_fs_init(void)
 	if (IS_ERR(ima_policy))
 		goto out;
 
+	if (ima_fs_record_init())
+		goto out;
+
 	return 0;
 out:
 	securityfs_remove(violations);
diff --git a/security/integrity/ima/ima_fs_template.c b/security/integrity/ima/ima_fs_template.c
new file mode 100644
index 000000000000..55e961461392
--- /dev/null
+++ b/security/integrity/ima/ima_fs_template.c
@@ -0,0 +1,230 @@
+/*
+ * Copyright (C) 2005,2006,2007,2008 IBM Corporation
+ *
+ * Authors:
+ * Kylene Hall <kjhall@us.ibm.com>
+ * Reiner Sailer <sailer@us.ibm.com>
+ * Mimi Zohar <zohar@us.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation, version 2 of the
+ * License.
+ *
+ * File: ima_fs.c
+ *	implemenents security file system for reporting
+ *	current measurement list and IMA statistics
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
+bool ima_canonical_fmt;
+static int __init default_canonical_fmt_setup(char *str)
+{
+#ifdef __BIG_ENDIAN
+	ima_canonical_fmt = true;
+#endif
+	return 1;
+}
+__setup("ima_canonical_fmt", default_canonical_fmt_setup);
+
+/* returns pointer to hlist_node */
+void *ima_measurements_start(struct seq_file *m, loff_t *pos)
+{
+	loff_t l = *pos;
+	struct ima_queue_entry *qe;
+
+	/* we need a lock since pos could point beyond last element */
+	rcu_read_lock();
+	list_for_each_entry_rcu(qe, &ima_measurements, later) {
+		if (!l--) {
+			rcu_read_unlock();
+			return qe;
+		}
+	}
+	rcu_read_unlock();
+	return NULL;
+}
+
+void *ima_measurements_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	struct ima_queue_entry *qe = v;
+
+	/* lock protects when reading beyond last element
+	 * against concurrent list-extension
+	 */
+	rcu_read_lock();
+	qe = list_entry_rcu(qe->later.next, struct ima_queue_entry, later);
+	rcu_read_unlock();
+	(*pos)++;
+
+	return (&qe->later == &ima_measurements) ? NULL : qe;
+}
+
+
+/* print format:
+ *       32bit-le=pcr#
+ *       char[20]=template digest
+ *       32bit-le=template name size
+ *       char[n]=template name
+ *       [eventdata length]
+ *       eventdata[n]=template specific data
+ */
+int ima_measurements_show(struct seq_file *m, void *v)
+{
+	/* the list never shrinks, so we don't need a lock here */
+	struct ima_queue_entry *qe = v;
+	struct ima_record_entry *e;
+	char *template_name;
+	u32 pcr, namelen, template_data_len; /* temporary fields */
+	bool is_ima_template = false;
+	int i;
+
+	/* get entry */
+	e = qe->entry;
+	if (e == NULL)
+		return -1;
+
+	template_name = (e->template_desc->name[0] != '\0') ?
+	    e->template_desc->name : e->template_desc->fmt;
+
+	/*
+	 * 1st: PCRIndex
+	 * PCR used defaults to the same (config option) in
+	 * little-endian format, unless set in policy
+	 */
+	pcr = !ima_canonical_fmt ? e->pcr : cpu_to_le32(e->pcr);
+	ima_putc(m, &pcr, sizeof(e->pcr));
+
+	/* 2nd: template digest */
+	ima_putc(m, e->digest, TPM_DIGEST_SIZE);
+
+	/* 3rd: template name size */
+	namelen = !ima_canonical_fmt ? strlen(template_name) :
+		cpu_to_le32(strlen(template_name));
+	ima_putc(m, &namelen, sizeof(namelen));
+
+	/* 4th:  template name */
+	ima_putc(m, template_name, strlen(template_name));
+
+	/* 5th:  template length (except for 'ima' template) */
+	if (strcmp(template_name, IMA_TEMPLATE_IMA_NAME) == 0)
+		is_ima_template = true;
+
+	if (!is_ima_template) {
+		template_data_len = !ima_canonical_fmt ? e->template_data_len :
+			cpu_to_le32(e->template_data_len);
+		ima_putc(m, &template_data_len, sizeof(e->template_data_len));
+	}
+
+	/* 6th:  template specific data */
+	for (i = 0; i < e->template_desc->num_fields; i++) {
+		enum ima_show_type show = IMA_SHOW_BINARY;
+		struct ima_template_field *field = e->template_desc->fields[i];
+
+		if (is_ima_template && strcmp(field->field_id, "d") == 0)
+			show = IMA_SHOW_BINARY_NO_FIELD_LEN;
+		if (is_ima_template && strcmp(field->field_id, "n") == 0)
+			show = IMA_SHOW_BINARY_OLD_STRING_FMT;
+		field->field_show(m, show, &e->template_data[i]);
+	}
+	return 0;
+}
+
+
+void ima_print_digest(struct seq_file *m, u8 *digest, u32 size)
+{
+	u32 i;
+
+	for (i = 0; i < size; i++)
+		seq_printf(m, "%02x", *(digest + i));
+}
+
+/* print in ascii */
+int ima_ascii_measurements_show(struct seq_file *m, void *v)
+{
+	/* the list never shrinks, so we don't need a lock here */
+	struct ima_queue_entry *qe = v;
+	struct ima_record_entry *e;
+	char *template_name;
+	int i;
+
+	/* get entry */
+	e = qe->entry;
+	if (e == NULL)
+		return -1;
+
+	template_name = (e->template_desc->name[0] != '\0') ?
+	    e->template_desc->name : e->template_desc->fmt;
+
+	/* 1st: PCR used (config option) */
+	seq_printf(m, "%2d ", e->pcr);
+
+	/* 2nd: SHA1 template hash */
+	ima_print_digest(m, e->digest, TPM_DIGEST_SIZE);
+
+	/* 3th:  template name */
+	seq_printf(m, " %s", template_name);
+
+	/* 4th:  template specific data */
+	for (i = 0; i < e->template_desc->num_fields; i++) {
+		seq_puts(m, " ");
+		if (e->template_data[i].len == 0)
+			continue;
+
+		e->template_desc->fields[i]->field_show(m, IMA_SHOW_ASCII,
+							&e->template_data[i]);
+	}
+	seq_puts(m, "\n");
+	return 0;
+}
+
+const struct seq_operations ima_ascii_measurements_seqops = {
+	.start = ima_measurements_start,
+	.next = ima_measurements_next,
+	.stop = ima_measurements_stop,
+	.show = ima_ascii_measurements_show
+};
+
+static int ima_ascii_measurements_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &ima_ascii_measurements_seqops);
+}
+
+const struct file_operations ima_ascii_measurements_ops = {
+	.open = ima_ascii_measurements_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release,
+};
+
+int __init ima_fs_record_init(void)
+{
+	binary_runtime_measurements =
+	    securityfs_create_file("binary_runtime_measurements",
+				   S_IRUSR | S_IRGRP, ima_dir, NULL,
+				   &ima_measurements_ops);
+	if (IS_ERR(binary_runtime_measurements))
+		return -1;
+
+	ascii_runtime_measurements =
+	    securityfs_create_file("ascii_runtime_measurements",
+				   S_IRUSR | S_IRGRP, ima_dir, NULL,
+				   &ima_ascii_measurements_ops);
+	if (IS_ERR(ascii_runtime_measurements))
+		return -1;
+
+	return 0;
+}
+
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index 29b72cd2502e..22f606e8380e 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -47,7 +47,7 @@ static int __init ima_add_boot_aggregate(void)
 {
 	static const char op[] = "add_boot_aggregate";
 	const char *audit_cause = "ENOMEM";
-	struct ima_template_entry *entry;
+	struct ima_record_entry *entry;
 	struct integrity_iint_cache tmp_iint, *iint = &tmp_iint;
 	struct ima_event_data event_data = {iint, NULL, boot_aggregate_name,
 					    NULL, 0, NULL};
@@ -72,17 +72,17 @@ static int __init ima_add_boot_aggregate(void)
 		}
 	}
 
-	result = ima_alloc_init_template(&event_data, &entry);
+	result = ima_alloc_init_record(&event_data, &entry);
 	if (result < 0) {
 		audit_cause = "alloc_entry";
 		goto err_out;
 	}
 
-	result = ima_store_template(entry, violation, NULL,
+	result = ima_store_record(entry, violation, NULL,
 				    boot_aggregate_name,
 				    CONFIG_IMA_MEASURE_PCR_IDX);
 	if (result < 0) {
-		ima_free_template_entry(entry);
+		ima_free_record_entry(entry);
 		audit_cause = "store_entry";
 		goto err_out;
 	}
@@ -125,7 +125,7 @@ int __init ima_init(void)
 	rc = ima_init_crypto();
 	if (rc)
 		return rc;
-	rc = ima_init_template();
+	rc = ima_init_records();
 	if (rc != 0)
 		return rc;
 
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index dca44cf7838e..3f58fbf55426 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -39,36 +39,8 @@ int ima_appraise;
 #endif
 
 int ima_hash_algo = HASH_ALGO_SHA1;
-static int hash_setup_done;
+int ima_hash_setup_done;
 
-static int __init hash_setup(char *str)
-{
-	struct ima_template_desc *template_desc = ima_template_desc_current();
-	int i;
-
-	if (hash_setup_done)
-		return 1;
-
-	if (strcmp(template_desc->name, IMA_TEMPLATE_IMA_NAME) == 0) {
-		if (strncmp(str, "sha1", 4) == 0)
-			ima_hash_algo = HASH_ALGO_SHA1;
-		else if (strncmp(str, "md5", 3) == 0)
-			ima_hash_algo = HASH_ALGO_MD5;
-		else
-			return 1;
-		goto out;
-	}
-
-	i = match_string(hash_algo_name, HASH_ALGO__LAST, str);
-	if (i < 0)
-		return 1;
-
-	ima_hash_algo = i;
-out:
-	hash_setup_done = 1;
-	return 1;
-}
-__setup("ima_hash=", hash_setup);
 
 /*
  * ima_rdwr_violation_check
@@ -172,7 +144,6 @@ static int process_measurement(struct file *file, const struct cred *cred,
 {
 	struct inode *inode = file_inode(file);
 	struct integrity_iint_cache *iint = NULL;
-	struct ima_template_desc *template_desc;
 	char *pathbuf = NULL;
 	char filename[NAME_MAX];
 	const char *pathname = NULL;
@@ -273,9 +244,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 		goto out_locked;
 	}
 
-	template_desc = ima_template_desc_current();
-	if ((action & IMA_APPRAISE_SUBMASK) ||
-		    strcmp(template_desc->name, IMA_TEMPLATE_IMA_NAME) != 0)
+	if ((action & IMA_APPRAISE_SUBMASK) || ima_need_xattr())
 		/* read 'security.ima' */
 		xattr_len = ima_read_xattr(file_dentry(file), &xattr_value);
 
@@ -500,16 +469,16 @@ static int __init init_ima(void)
 {
 	int error;
 
-	ima_init_template_list();
-	hash_setup(CONFIG_IMA_DEFAULT_HASH);
+	ima_init_record_list();
+	ima_hash_setup(CONFIG_IMA_DEFAULT_HASH);
 	error = ima_init();
 
 	if (error && strcmp(hash_algo_name[ima_hash_algo],
 			    CONFIG_IMA_DEFAULT_HASH) != 0) {
 		pr_info("Allocating %s failed, going to use default hash algorithm %s\n",
 			hash_algo_name[ima_hash_algo], CONFIG_IMA_DEFAULT_HASH);
-		hash_setup_done = 0;
-		hash_setup(CONFIG_IMA_DEFAULT_HASH);
+		ima_hash_setup_done = 0;
+		ima_hash_setup(CONFIG_IMA_DEFAULT_HASH);
 		error = ima_init();
 	}
 
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index cdcc9a7b4e24..9922be2098c9 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -111,9 +111,9 @@ static struct ima_rule_entry original_measurement_rules[] __ro_after_init = {
 	 .flags = IMA_FUNC | IMA_MASK},
 	{.action = MEASURE, .func = BPRM_CHECK, .mask = MAY_EXEC,
 	 .flags = IMA_FUNC | IMA_MASK},
-	{.action = MEASURE, .func = FILE_CHECK, .mask = MAY_READ,
-	 .uid = GLOBAL_ROOT_UID, .uid_op = &uid_eq,
-	 .flags = IMA_FUNC | IMA_MASK | IMA_UID},
+	//{.action = MEASURE, .func = FILE_CHECK, .mask = MAY_READ,
+	//.uid = GLOBAL_ROOT_UID, .uid_op = &uid_eq,
+	// .flags = IMA_FUNC | IMA_MASK | IMA_UID},
 	{.action = MEASURE, .func = MODULE_CHECK, .flags = IMA_FUNC},
 	{.action = MEASURE, .func = FIRMWARE_CHECK, .flags = IMA_FUNC},
 };
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue_template.c
similarity index 90%
rename from security/integrity/ima/ima_queue.c
rename to security/integrity/ima/ima_queue_template.c
index 418f35e38015..05d9f021a151 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue_template.c
@@ -74,7 +74,7 @@ static struct ima_queue_entry *ima_lookup_digest_entry(u8 *digest_value,
  * binary_runtime_measurement list entry, which contains a
  * couple of variable length fields (e.g template name and data).
  */
-static int get_binary_runtime_size(struct ima_template_entry *entry)
+static int get_binary_runtime_size(struct ima_record_entry *entry)
 {
 	int size = 0;
 
@@ -93,7 +93,7 @@ static int get_binary_runtime_size(struct ima_template_entry *entry)
  *
  * (Called with ima_extend_list_mutex held.)
  */
-static int ima_add_digest_entry(struct ima_template_entry *entry,
+static int ima_add_digest_entry(struct ima_record_entry *entry,
 				bool update_htable)
 {
 	struct ima_queue_entry *qe;
@@ -138,19 +138,6 @@ unsigned long ima_get_binary_runtime_size(void)
 		return binary_runtime_size + sizeof(struct ima_kexec_hdr);
 };
 
-static int ima_pcr_extend(const u8 *hash, int pcr)
-{
-	int result = 0;
-
-	if (!ima_used_chip)
-		return result;
-
-	result = tpm_pcr_extend(NULL, pcr, hash);
-	if (result != 0)
-		pr_err("Error Communicating to TPM chip, result: %d\n", result);
-	return result;
-}
-
 /*
  * Add template entry to the measurement list and hash table, and
  * extend the pcr.
@@ -159,7 +146,7 @@ static int ima_pcr_extend(const u8 *hash, int pcr)
  * kexec, maintain the total memory size required for serializing the
  * binary_runtime_measurements.
  */
-int ima_add_template_entry(struct ima_template_entry *entry, int violation,
+int ima_add_template_entry(struct ima_record_entry *entry, int violation,
 			   const char *op, struct inode *inode,
 			   const unsigned char *filename)
 {
@@ -203,7 +190,7 @@ int ima_add_template_entry(struct ima_template_entry *entry, int violation,
 	return result;
 }
 
-int ima_restore_measurement_entry(struct ima_template_entry *entry)
+int ima_restore_measurement_entry(struct ima_record_entry *entry)
 {
 	int result = 0;
 
diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index 30db39b23804..4eff9bc32adf 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -16,6 +16,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/rculist.h>
+#include <crypto/hash.h>
 #include "ima.h"
 #include "ima_template_lib.h"
 
@@ -52,6 +53,13 @@ static int template_desc_init_fields(const char *template_fmt,
 				     struct ima_template_field ***fields,
 				     int *num_fields);
 
+int ima_need_xattr(void)
+{
+	struct ima_template_desc *template_desc;
+	template_desc = ima_template_desc_current();
+	return (strcmp(template_desc->name, IMA_TEMPLATE_IMA_NAME) != 0);
+}
+
 static int __init ima_template_setup(char *str)
 {
 	struct ima_template_desc *template_desc;
@@ -60,7 +68,7 @@ static int __init ima_template_setup(char *str)
 	if (ima_template)
 		return 1;
 
-	ima_init_template_list();
+	ima_init_record_list();
 
 	/*
 	 * Verify that a template with the supplied name exists.
@@ -203,7 +211,7 @@ static int template_desc_init_fields(const char *template_fmt,
 	return 0;
 }
 
-void ima_init_template_list(void)
+void ima_init_record_list(void)
 {
 	int i;
 
@@ -221,14 +229,14 @@ void ima_init_template_list(void)
 struct ima_template_desc *ima_template_desc_current(void)
 {
 	if (!ima_template) {
-		ima_init_template_list();
+		ima_init_record_list();
 		ima_template =
 		    lookup_template_desc(CONFIG_IMA_DEFAULT_TEMPLATE);
 	}
 	return ima_template;
 }
 
-int __init ima_init_template(void)
+int __init ima_init_records(void)
 {
 	struct ima_template_desc *template = ima_template_desc_current();
 	int result;
@@ -275,7 +283,7 @@ static struct ima_template_desc *restore_template_fmt(char *template_name)
 static int ima_restore_template_data(struct ima_template_desc *template_desc,
 				     void *template_data,
 				     int template_data_size,
-				     struct ima_template_entry **entry)
+				     struct ima_record_entry **entry)
 {
 	int ret = 0;
 	int i;
@@ -312,7 +320,7 @@ static int ima_restore_template_data(struct ima_template_desc *template_desc,
 	}
 
 	if (ret < 0) {
-		ima_free_template_entry(*entry);
+		ima_free_record_entry(*entry);
 		*entry = NULL;
 	}
 
@@ -332,7 +340,7 @@ int ima_restore_measurement_list(loff_t size, void *buf)
 
 	void *bufp = buf + sizeof(*khdr);
 	void *bufendp;
-	struct ima_template_entry *entry;
+	struct ima_record_entry *entry;
 	struct ima_template_desc *template_desc;
 	DECLARE_BITMAP(hdr_mask, HDR__LAST);
 	unsigned long count = 0;
@@ -433,3 +441,200 @@ int ima_restore_measurement_list(loff_t size, void *buf)
 	}
 	return ret;
 }
+
+/*
+ * ima_free_record_entry - free an existing template entry
+ */
+void ima_free_record_entry(struct ima_record_entry *entry)
+{
+	int i;
+
+	for (i = 0; i < entry->template_desc->num_fields; i++)
+		kfree(entry->template_data[i].data);
+
+	kfree(entry);
+}
+
+/*
+ * ima_alloc_init_record - create and initialize a new template entry
+ */
+int ima_alloc_init_record(struct ima_event_data *event_data,
+			    struct ima_record_entry **entry)
+{
+	struct ima_template_desc *template_desc = ima_template_desc_current();
+	int i, result = 0;
+
+	*entry = kzalloc(sizeof(**entry) + template_desc->num_fields *
+			 sizeof(struct ima_field_data), GFP_NOFS);
+	if (!*entry)
+		return -ENOMEM;
+
+	(*entry)->template_desc = template_desc;
+	for (i = 0; i < template_desc->num_fields; i++) {
+		struct ima_template_field *field = template_desc->fields[i];
+		u32 len;
+
+		result = field->field_init(event_data,
+					   &((*entry)->template_data[i]));
+		if (result != 0)
+			goto out;
+
+		len = (*entry)->template_data[i].len;
+		(*entry)->template_data_len += sizeof(len);
+		(*entry)->template_data_len += len;
+	}
+	return 0;
+out:
+	ima_free_record_entry(*entry);
+	*entry = NULL;
+	return result;
+}
+
+/*
+ * ima_store_template - store ima template measurements
+ *
+ * Calculate the hash of a template entry, add the template entry
+ * to an ordered list of measurement entries maintained inside the kernel,
+ * and also update the aggregate integrity value (maintained inside the
+ * configured TPM PCR) over the hashes of the current list of measurement
+ * entries.
+ *
+ * Applications retrieve the current kernel-held measurement list through
+ * the securityfs entries in /sys/kernel/security/ima. The signed aggregate
+ * TPM PCR (called quote) can be retrieved using a TPM user space library
+ * and is used to validate the measurement list.
+ *
+ * Returns 0 on success, error code otherwise
+ */
+int ima_store_record(struct ima_record_entry *entry,
+		       int violation, struct inode *inode,
+		       const unsigned char *filename, int pcr)
+{
+	static const char op[] = "add_template_measure";
+	static const char audit_cause[] = "hashing_error";
+	char *template_name = entry->template_desc->name;
+	int result;
+	struct {
+		struct ima_digest_data hdr;
+		char digest[TPM_DIGEST_SIZE];
+	} hash;
+
+	if (!violation) {
+		int num_fields = entry->template_desc->num_fields;
+
+		/* this function uses default algo */
+		hash.hdr.algo = HASH_ALGO_SHA1;
+		result = ima_calc_field_array_hash(&entry->template_data[0],
+						   entry->template_desc,
+						   num_fields, &hash.hdr);
+		if (result < 0) {
+			integrity_audit_msg(AUDIT_INTEGRITY_PCR, inode,
+					    template_name, op,
+					    audit_cause, result, 0);
+			return result;
+		}
+		memcpy(entry->digest, hash.hdr.digest, hash.hdr.length);
+	}
+	entry->pcr = pcr;
+	result = ima_add_template_entry(entry, violation, op, inode, filename);
+	return result;
+}
+
+/*
+ * Calculate the hash of template data
+ */
+static int ima_calc_field_array_hash_tfm(struct ima_field_data *field_data,
+					 struct ima_template_desc *td,
+					 int num_fields,
+					 struct ima_digest_data *hash,
+					 struct crypto_shash *tfm)
+{
+	SHASH_DESC_ON_STACK(shash, tfm);
+	int rc, i;
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
+	for (i = 0; i < num_fields; i++) {
+		u8 buffer[IMA_EVENT_NAME_LEN_MAX + 1] = { 0 };
+		u8 *data_to_hash = field_data[i].data;
+		u32 datalen = field_data[i].len;
+		u32 datalen_to_hash =
+		    !ima_canonical_fmt ? datalen : cpu_to_le32(datalen);
+
+		if (strcmp(td->name, IMA_TEMPLATE_IMA_NAME) != 0) {
+			rc = crypto_shash_update(shash,
+						(const u8 *) &datalen_to_hash,
+						sizeof(datalen_to_hash));
+			if (rc)
+				break;
+		} else if (strcmp(td->fields[i]->field_id, "n") == 0) {
+			memcpy(buffer, data_to_hash, datalen);
+			data_to_hash = buffer;
+			datalen = IMA_EVENT_NAME_LEN_MAX + 1;
+		}
+		rc = crypto_shash_update(shash, data_to_hash, datalen);
+		if (rc)
+			break;
+	}
+
+	if (!rc)
+		rc = crypto_shash_final(shash, hash->digest);
+
+	return rc;
+}
+
+int ima_calc_field_array_hash(struct ima_field_data *field_data,
+			      struct ima_template_desc *desc, int num_fields,
+			      struct ima_digest_data *hash)
+{
+	struct crypto_shash *tfm;
+	int rc;
+
+	tfm = ima_alloc_tfm(hash->algo);
+	if (IS_ERR(tfm))
+		return PTR_ERR(tfm);
+
+	rc = ima_calc_field_array_hash_tfm(field_data, desc, num_fields,
+					   hash, tfm);
+
+	ima_free_tfm(tfm);
+
+	return rc;
+}
+
+int __init ima_hash_setup(char *str)
+{
+	struct ima_template_desc *template_desc = ima_template_desc_current();
+	int i;
+
+	if (ima_hash_setup_done)
+		return 1;
+
+	if (strcmp(template_desc->name, IMA_TEMPLATE_IMA_NAME) == 0) {
+		if (strncmp(str, "sha1", 4) == 0)
+			ima_hash_algo = HASH_ALGO_SHA1;
+		else if (strncmp(str, "md5", 3) == 0)
+			ima_hash_algo = HASH_ALGO_MD5;
+		else
+			return 1;
+		goto out;
+	}
+
+	i = match_string(hash_algo_name, HASH_ALGO__LAST, str);
+	if (i < 0)
+		return 1;
+
+	ima_hash_algo = i;
+out:
+	ima_hash_setup_done = 1;
+	return 1;
+}
+__setup("ima_hash=", ima_hash_setup);
+
diff --git a/security/integrity/ima/ima_template.h b/security/integrity/ima/ima_template.h
new file mode 100644
index 000000000000..2234d89216e7
--- /dev/null
+++ b/security/integrity/ima/ima_template.h
@@ -0,0 +1,88 @@
+/*
+ * Copyright (C) 2005,2006,2007,2008 IBM Corporation
+ *
+ * Authors:
+ * Reiner Sailer <sailer@watson.ibm.com>
+ * Mimi Zohar <zohar@us.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation, version 2 of the
+ * License.
+ *
+ * File: ima_template.h
+ *	internal Integrity Measurement Architecture (IMA) definitions
+ */
+
+#ifndef __LINUX_IMA_TEMPLATE_H
+#define __LINUX_IMA_TEMPLATE_H
+
+#define IMA_TEMPLATE_FIELD_ID_MAX_LEN	16
+#define IMA_TEMPLATE_NUM_FIELDS_MAX	15
+
+#define IMA_TEMPLATE_IMA_NAME "ima"
+#define IMA_TEMPLATE_IMA_FMT "d|n"
+
+/* IMA template field data definition */
+struct ima_field_data {
+	u8 *data;
+	u32 len;
+};
+
+/* IMA template field definition */
+struct ima_template_field {
+	const char field_id[IMA_TEMPLATE_FIELD_ID_MAX_LEN];
+	int (*field_init)(struct ima_event_data *event_data,
+			  struct ima_field_data *field_data);
+	void (*field_show)(struct seq_file *m, enum ima_show_type show,
+			   struct ima_field_data *field_data);
+};
+
+/* IMA template descriptor definition */
+struct ima_template_desc {
+	struct list_head list;
+	char *name;
+	char *fmt;
+	int num_fields;
+	struct ima_template_field **fields;
+};
+
+struct ima_record_entry {
+	int pcr;
+	u8 digest[TPM_DIGEST_SIZE];	/* sha1 or md5 measurement hash */
+	struct ima_template_desc *template_desc; /* template descriptor */
+	u32 template_data_len;
+	struct ima_field_data template_data[0];	/* template related data */
+};
+
+struct ima_queue_entry {
+	struct hlist_node hnext;	/* place in hash collision list */
+	struct list_head later;		/* place in ima_measurements list */
+	struct ima_record_entry *entry;
+};
+extern struct list_head ima_measurements;	/* list of all measurements */
+
+int ima_add_template_entry(struct ima_record_entry *entry, int violation,
+			   const char *op, struct inode *inode,
+			   const unsigned char *filename);
+
+int ima_calc_field_array_hash(struct ima_field_data *field_data,
+			      struct ima_template_desc *desc, int num_fields,
+			      struct ima_digest_data *hash);
+
+struct ima_template_desc *ima_template_desc_current(void);
+int ima_restore_measurement_entry(struct ima_record_entry *entry);
+int ima_need_xattr(void);
+int ima_init_records(void);
+void ima_init_record_list(void);
+int ima_alloc_init_record(struct ima_event_data *event_data,
+struct ima_record_entry **entry);
+
+
+int ima_store_record(struct ima_record_entry *entry, int violation,
+		       struct inode *inode,
+		       const unsigned char *filename, int pcr);
+void ima_free_record_entry(struct ima_record_entry *entry);
+
+
+#endif /* __LINUX_IMA_TEMPLATE_H */
-- 
2.17.1

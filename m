Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:9981 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751448AbdKICq4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Nov 2017 21:46:56 -0500
From: Boshi Wang <wangboshi@huawei.com>
To: <linux-integrity@vger.kernel.org>
CC: <hw.likun@huawei.com>, <zohar@linux.vnet.ibm.com>,
        <dmitry.kasatkin@gmail.com>
Subject: [PATCH] ima: add namespace template
Date: Thu, 9 Nov 2017 10:49:14 +0800
Message-ID: <20171109024914.140203-1-wangboshi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Currently IMA can store digests, filenames and signatures. But there may
be different files which owns the same filename due to multiple mount
namespaces, e.g. in the container environment. To distingush them, we
introduce a new templete which contains a namespace field. The namespace
field stores the mount namespace number.

Signed-off-by: Boshi Wang <wangboshi@huawei.com>
---
 security/integrity/ima/ima_template.c     |  3 +++
 security/integrity/ima/ima_template_lib.c | 29 ++++++++++++++++++++++++++++-
 security/integrity/ima/ima_template_lib.h |  4 ++++
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index 7412d02..dd29d4e 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -26,6 +26,7 @@ static struct ima_template_desc builtin_templates[] = {
 	{.name = IMA_TEMPLATE_IMA_NAME, .fmt = IMA_TEMPLATE_IMA_FMT},
 	{.name = "ima-ng", .fmt = "d-ng|n-ng"},
 	{.name = "ima-sig", .fmt = "d-ng|n-ng|sig"},
+	{.name = "ima-ns", .fmt = "d-ng|n-ng|ns"},
 	{.name = "", .fmt = ""},	/* placeholder for a custom format */
 };
 
@@ -43,6 +44,8 @@ static struct ima_template_field supported_fields[] = {
 	 .field_show = ima_show_template_string},
 	{.field_id = "sig", .field_init = ima_eventsig_init,
 	 .field_show = ima_show_template_sig},
+	{.field_id = "ns", .field_init = ima_eventns_init,
+	 .field_show = ima_show_template_ns},
 };
 #define MAX_TEMPLATE_NAME_LEN 15
 
diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
index 28af43f..e0eb67d 100644
--- a/security/integrity/ima/ima_template_lib.c
+++ b/security/integrity/ima/ima_template_lib.c
@@ -13,6 +13,8 @@
  *      Library of supported template fields.
  */
 
+#include <linux/atomic.h>
+#include <linux/proc_ns.h>
 #include "ima_template_lib.h"
 
 static bool ima_template_hash_algo_allowed(u8 algo)
@@ -27,7 +29,8 @@ enum data_formats {
 	DATA_FMT_DIGEST = 0,
 	DATA_FMT_DIGEST_WITH_ALGO,
 	DATA_FMT_STRING,
-	DATA_FMT_HEX
+	DATA_FMT_HEX,
+	DATA_FMT_UINT
 };
 
 static int ima_write_template_field_data(const void *data, const u32 datalen,
@@ -90,6 +93,9 @@ static void ima_show_template_data_ascii(struct seq_file *m,
 	case DATA_FMT_STRING:
 		seq_printf(m, "%s", buf_ptr);
 		break;
+	case DATA_FMT_UINT:
+		seq_printf(m, "%u", *(unsigned int *)buf_ptr);
+		break;
 	default:
 		break;
 	}
@@ -159,6 +165,12 @@ void ima_show_template_sig(struct seq_file *m, enum ima_show_type show,
 	ima_show_template_field_data(m, show, DATA_FMT_HEX, field_data);
 }
 
+void ima_show_template_ns(struct seq_file *m, enum ima_show_type show,
+			  struct ima_field_data *field_data)
+{
+	ima_show_template_field_data(m, show, DATA_FMT_UINT, field_data);
+}
+
 /**
  * ima_parse_buf() - Parses lengths and data from an input buffer
  * @bufstartp:       Buffer start address.
@@ -391,3 +403,18 @@ int ima_eventsig_init(struct ima_event_data *event_data,
 out:
 	return rc;
 }
+
+int ima_eventns_init(struct ima_event_data *event_data,
+		     struct ima_field_data *field_data)
+{
+	struct ns_common *ns;
+	unsigned int ns_id;
+
+	ns = mntns_operations.get(current);
+	if (ns == NULL)
+		return -ENOENT;
+	ns_id = ns->inum;
+	mntns_operations.put(ns);
+	return ima_write_template_field_data(&ns_id, sizeof(ns_id),
+					     DATA_FMT_UINT, field_data);
+}
diff --git a/security/integrity/ima/ima_template_lib.h b/security/integrity/ima/ima_template_lib.h
index 6a3d8b8..9ca9059 100644
--- a/security/integrity/ima/ima_template_lib.h
+++ b/security/integrity/ima/ima_template_lib.h
@@ -29,6 +29,8 @@ void ima_show_template_string(struct seq_file *m, enum ima_show_type show,
 			      struct ima_field_data *field_data);
 void ima_show_template_sig(struct seq_file *m, enum ima_show_type show,
 			   struct ima_field_data *field_data);
+void ima_show_template_ns(struct seq_file *m, enum ima_show_type show,
+			  struct ima_field_data *field_data);
 int ima_parse_buf(void *bufstartp, void *bufendp, void **bufcurp,
 		  int maxfields, struct ima_field_data *fields, int *curfields,
 		  unsigned long *len_mask, int enforce_mask, char *bufname);
@@ -42,4 +44,6 @@ int ima_eventname_ng_init(struct ima_event_data *event_data,
 			  struct ima_field_data *field_data);
 int ima_eventsig_init(struct ima_event_data *event_data,
 		      struct ima_field_data *field_data);
+int ima_eventns_init(struct ima_event_data *event_data,
+		     struct ima_field_data *field_data);
 #endif /* __LINUX_IMA_TEMPLATE_LIB_H */
-- 
2.10.1

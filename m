Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726107AbeIHBFu (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 7 Sep 2018 21:05:50 -0400
From: Eric Biggers <ebiggers@kernel.org>
To: linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Subject: [PATCH] security/integrity: constify some read-only data
Date: Fri,  7 Sep 2018 13:22:23 -0700
Message-Id: <20180907202223.216959-1-ebiggers@kernel.org>
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

Constify some static data that is never modified,
so that it is placed in .rodata.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 security/integrity/digsig.c           |  2 +-
 security/integrity/evm/evm_crypto.c   |  4 ++--
 security/integrity/ima/ima.h          |  2 +-
 security/integrity/ima/ima_api.c      |  3 ++-
 security/integrity/ima/ima_fs.c       |  3 ++-
 security/integrity/ima/ima_init.c     |  2 +-
 security/integrity/ima/ima_main.c     |  2 +-
 security/integrity/ima/ima_template.c | 11 ++++++-----
 8 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index 9bb0a7f2863e..879396fa3be0 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -26,7 +26,7 @@
 
 static struct key *keyring[INTEGRITY_KEYRING_MAX];
 
-static const char *keyring_name[INTEGRITY_KEYRING_MAX] = {
+static const char * const keyring_name[INTEGRITY_KEYRING_MAX] = {
 #ifndef CONFIG_INTEGRITY_TRUSTED_KEYRING
 	"_evm",
 	"_ima",
diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index 8a3905bb02c7..8c25f949ebdb 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -27,7 +27,7 @@
 #define EVMKEY "evm-key"
 #define MAX_KEY_SIZE 128
 static unsigned char evmkey[MAX_KEY_SIZE];
-static int evmkey_len = MAX_KEY_SIZE;
+static const int evmkey_len = MAX_KEY_SIZE;
 
 struct crypto_shash *hmac_tfm;
 static struct crypto_shash *evm_tfm[HASH_ALGO__LAST];
@@ -38,7 +38,7 @@ static DEFINE_MUTEX(mutex);
 
 static unsigned long evm_set_key_flags;
 
-static char * const evm_hmac = "hmac(sha1)";
+static const char evm_hmac[] = "hmac(sha1)";
 
 /**
  * evm_set_key() - set EVM HMAC key from the kernel
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 67db9d9454ca..cc12f3449a72 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -88,7 +88,7 @@ struct ima_template_desc {
 	char *name;
 	char *fmt;
 	int num_fields;
-	struct ima_template_field **fields;
+	const struct ima_template_field **fields;
 };
 
 struct ima_template_entry {
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index a02c5acfd403..99dd1d53fc35 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -51,7 +51,8 @@ int ima_alloc_init_template(struct ima_event_data *event_data,
 
 	(*entry)->template_desc = template_desc;
 	for (i = 0; i < template_desc->num_fields; i++) {
-		struct ima_template_field *field = template_desc->fields[i];
+		const struct ima_template_field *field =
+			template_desc->fields[i];
 		u32 len;
 
 		result = field->field_init(event_data,
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index ae9d5c766a3c..fe0ede883557 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -179,7 +179,8 @@ int ima_measurements_show(struct seq_file *m, void *v)
 	/* 6th:  template specific data */
 	for (i = 0; i < e->template_desc->num_fields; i++) {
 		enum ima_show_type show = IMA_SHOW_BINARY;
-		struct ima_template_field *field = e->template_desc->fields[i];
+		const struct ima_template_field *field =
+			e->template_desc->fields[i];
 
 		if (is_ima_template && strcmp(field->field_id, "d") == 0)
 			show = IMA_SHOW_BINARY_NO_FIELD_LEN;
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index faac9ecaa0ae..59d834219cd6 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -25,7 +25,7 @@
 #include "ima.h"
 
 /* name for boot aggregate entry */
-static const char *boot_aggregate_name = "boot_aggregate";
+static const char boot_aggregate_name[] = "boot_aggregate";
 struct tpm_chip *ima_tpm_chip;
 
 /* Add the boot aggregate to the IMA measurement list and extend
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 2d31921fbda4..1b88d58e1325 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -440,7 +440,7 @@ int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
 	return 0;
 }
 
-static int read_idmap[READING_MAX_ID] = {
+static const int read_idmap[READING_MAX_ID] = {
 	[READING_FIRMWARE] = FIRMWARE_CHECK,
 	[READING_FIRMWARE_PREALLOC_BUFFER] = FIRMWARE_CHECK,
 	[READING_MODULE] = MODULE_CHECK,
diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index 30db39b23804..b631b8bc7624 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -32,7 +32,7 @@ static struct ima_template_desc builtin_templates[] = {
 static LIST_HEAD(defined_templates);
 static DEFINE_SPINLOCK(template_list);
 
-static struct ima_template_field supported_fields[] = {
+static const struct ima_template_field supported_fields[] = {
 	{.field_id = "d", .field_init = ima_eventdigest_init,
 	 .field_show = ima_show_template_digest},
 	{.field_id = "n", .field_init = ima_eventname_init,
@@ -49,7 +49,7 @@ static struct ima_template_field supported_fields[] = {
 static struct ima_template_desc *ima_template;
 static struct ima_template_desc *lookup_template_desc(const char *name);
 static int template_desc_init_fields(const char *template_fmt,
-				     struct ima_template_field ***fields,
+				     const struct ima_template_field ***fields,
 				     int *num_fields);
 
 static int __init ima_template_setup(char *str)
@@ -125,7 +125,8 @@ static struct ima_template_desc *lookup_template_desc(const char *name)
 	return found ? template_desc : NULL;
 }
 
-static struct ima_template_field *lookup_template_field(const char *field_id)
+static const struct ima_template_field *
+lookup_template_field(const char *field_id)
 {
 	int i;
 
@@ -153,11 +154,11 @@ static int template_fmt_size(const char *template_fmt)
 }
 
 static int template_desc_init_fields(const char *template_fmt,
-				     struct ima_template_field ***fields,
+				     const struct ima_template_field ***fields,
 				     int *num_fields)
 {
 	const char *template_fmt_ptr;
-	struct ima_template_field *found_fields[IMA_TEMPLATE_NUM_FIELDS_MAX];
+	const struct ima_template_field *found_fields[IMA_TEMPLATE_NUM_FIELDS_MAX];
 	int template_num_fields;
 	int i, len;
 
-- 
2.19.0.rc2.392.g5ba43deb5a-goog

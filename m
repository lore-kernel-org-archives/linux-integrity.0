Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45518 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751121AbeAVOy3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 Jan 2018 09:54:29 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w0MEplCj119477
        for <linux-integrity@vger.kernel.org>; Mon, 22 Jan 2018 09:54:28 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2fne9eam0v-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 22 Jan 2018 09:54:28 -0500
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 22 Jan 2018 14:54:26 -0000
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        "Bruno E . O . Meneguele" <brdeoliv@redhat.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH 05/10] ima-evm-utils: support verifying the measurement list using multiple keys
Date: Mon, 22 Jan 2018 09:54:00 -0500
In-Reply-To: <1516632845-7087-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1516632845-7087-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-Id: <1516632845-7087-6-git-send-email-zohar@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On a running system, different software packages might be signed by
different parties.  Support verifying signatures in the measurement
list using multiple public keys(eg.  -k "key1, key2, ...").

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 README          |  2 +-
 src/evmctl.c    |  4 +++
 src/imaevm.h    |  1 +
 src/libimaevm.c | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++++----
 4 files changed, 76 insertions(+), 6 deletions(-)

diff --git a/README b/README
index da828cf..1c4bc7a 100644
--- a/README
+++ b/README
@@ -31,7 +31,7 @@ COMMANDS
  ima_sign [--sigfile] [--key key] [--pass password] file
  ima_verify file
  ima_hash file
- ima_measurement file
+ ima_measurement [--key "key1, key2, ..."] file
  ima_fix [-t fdsxm] path
  sign_hash [--key key] [--pass password]
  hmac [--imahash | --imasig ] file
diff --git a/src/evmctl.c b/src/evmctl.c
index 746fc09..e0ed93d 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -1419,6 +1419,10 @@ static int ima_measurement(const char *file)
 		return -1;
 	}
 
+	/* Support multiple public keys */
+	if (params.keyfile)
+		init_public_keys(params.keyfile);
+
 	while (fread(&entry.header, sizeof(entry.header), 1, fp)) {
 		ima_extend_pcr(pcr, entry.header.digest, SHA_DIGEST_LENGTH);
 
diff --git a/src/imaevm.h b/src/imaevm.h
index e397743..ea6a7b1 100644
--- a/src/imaevm.h
+++ b/src/imaevm.h
@@ -205,5 +205,6 @@ int key2bin(RSA *key, unsigned char *pub);
 int sign_hash(const char *algo, const unsigned char *hash, int size, const char *keyfile, const char *keypass, unsigned char *sig);
 int verify_hash(const unsigned char *hash, int size, unsigned char *sig, int siglen);
 int ima_verify_signature(const char *file, unsigned char *sig, int siglen);
+void init_public_keys(const char *keyfiles);
 
 #endif
diff --git a/src/libimaevm.c b/src/libimaevm.c
index a92deed..0ad290a 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -408,6 +408,61 @@ int verify_hash_v1(const unsigned char *hash, int size, unsigned char *sig, int
 	return 0;
 }
 
+struct public_key_entry {
+	struct public_key_entry *next;
+	uint32_t keyid;
+	char name[9];
+	RSA *key;
+};
+static struct public_key_entry *public_keys = NULL;
+
+static RSA *find_keyid(uint32_t keyid)
+{
+	struct public_key_entry *entry;
+
+	for (entry = public_keys; entry != NULL; entry = entry->next) {
+		if (entry->keyid == keyid)
+			return entry->key;
+	}
+	return NULL;
+}
+
+void init_public_keys(const char *keyfiles)
+{
+	struct public_key_entry *entry;
+	char *tmp_keyfiles;
+	char *keyfile;
+	int i = 1;
+
+	tmp_keyfiles = strdup(keyfiles);
+
+	while ((keyfile = strsep(&tmp_keyfiles, ", \t")) != NULL) {
+		if (!keyfile)
+			break;
+		if ((*keyfile == '\0') || (*keyfile == ' ') ||
+		    (*keyfile == '\t'))
+			continue;
+
+		entry = malloc(sizeof(struct public_key_entry));
+		if (!entry) {
+			perror("malloc");
+			break;
+		}
+
+		entry->key = read_pub_key(keyfile, 1);
+		if (!entry->key) {
+			free(entry);
+			continue;
+		}
+
+		calc_keyid_v2(&entry->keyid, entry->name, entry->key);
+		sprintf(entry->name, "%x", __be32_to_cpup(&entry->keyid));
+		log_info("key %d: %s %s\n", i++, entry->name, keyfile);
+		entry->next = public_keys;
+		public_keys = entry;
+	}
+}
+
 int verify_hash_v2(const unsigned char *hash, int size, unsigned char *sig, int siglen, const char *keyfile)
 {
 	int err, len;
@@ -419,12 +474,22 @@ int verify_hash_v2(const unsigned char *hash, int size, unsigned char *sig, int
 	log_info("hash: ");
 	log_dump(hash, size);
 
-	key = read_pub_key(keyfile, 1);
-	if (!key)
-		return 1;
+	if (public_keys) {
+		key = find_keyid(hdr->keyid);
+		if (!key) {
+			log_err("Unknown keyid: %x\n",
+				__be32_to_cpup(&hdr->keyid));
+			return -1;
+		}
+	} else {
+		key = read_pub_key(keyfile, 1);
+		if (!key)
+			return 1;
+	}
 
-	err = RSA_public_decrypt(siglen - sizeof(*hdr), sig + sizeof(*hdr), out, key, RSA_PKCS1_PADDING);
-	RSA_free(key);
+
+	err = RSA_public_decrypt(siglen - sizeof(*hdr), sig + sizeof(*hdr),
+				 out, key, RSA_PKCS1_PADDING);
 	if (err < 0) {
 		log_err("RSA_public_decrypt() failed: %d\n", err);
 		return 1;
-- 
2.7.4

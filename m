Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54004 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751121AbeAVOyf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 Jan 2018 09:54:35 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w0MEpgbj027601
        for <linux-integrity@vger.kernel.org>; Mon, 22 Jan 2018 09:54:35 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2fnhdeabd3-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 22 Jan 2018 09:54:34 -0500
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 22 Jan 2018 14:54:32 -0000
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        "Bruno E . O . Meneguele" <brdeoliv@redhat.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH 08/10] ima-evm-utils: verify the measurement list signature based on the list digest
Date: Mon, 22 Jan 2018 09:54:03 -0500
In-Reply-To: <1516632845-7087-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1516632845-7087-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-Id: <1516632845-7087-9-git-send-email-zohar@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Instead of verifying file signatures included in the measurement list,
by calculating the local file hash, verify the file signature based on the
digest contained in the measurement list.

This patch defines a new option named "--list".

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 README          |  2 +-
 src/evmctl.c    | 14 ++++++++++++--
 src/imaevm.h    |  2 +-
 src/libimaevm.c | 10 +++++++++-
 4 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/README b/README
index f9706f8..f60a9fd 100644
--- a/README
+++ b/README
@@ -31,7 +31,7 @@ COMMANDS
  ima_sign [--sigfile] [--key key] [--pass password] file
  ima_verify file
  ima_hash file
- ima_measurement [--key "key1, key2, ..."] [--pcrs <sysfs file>] file
+ ima_measurement [--key "key1, key2, ..."] [--pcrs <sysfs file>] [--list] file
  ima_fix [-t fdsxm] path
  sign_hash [--key key] [--pass password]
  hmac [--imahash | --imasig ] file
diff --git a/src/evmctl.c b/src/evmctl.c
index 310ff4e..5d1c6ea 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -114,6 +114,7 @@ static char *ima_str;
 static char *selinux_str;
 static char *pcrs_sysfs;
 static char *search_type;
+static int measurement_list;
 static int recursive;
 static int msize;
 static dev_t fs_dev;
@@ -793,7 +794,7 @@ static int verify_ima(const char *file)
 		}
 	}
 
-	return ima_verify_signature(file, sig, len);
+	return ima_verify_signature(file, sig, len, NULL, 0);
 }
 
 static int cmd_verify_ima(struct command *cmd)
@@ -1398,7 +1399,11 @@ int ima_ng_show(struct template_entry *entry)
 	if (sig) {
 		log_info(" ");
 		log_dump(sig, sig_len);
-		err = ima_verify_signature(path, sig, sig_len);
+		if (measurement_list)
+			err = ima_verify_signature(path, sig, sig_len,
+						   digest, digest_len);
+		else
+			err = ima_verify_signature(path, sig, sig_len, NULL, 0);
 	} else
 		log_info("\n");
 
@@ -1599,6 +1604,7 @@ static void usage(void)
 		"      --selinux      use custom Selinux label for EVM\n"
 		"      --caps         use custom Capabilities for EVM(unspecified: from FS, empty: do not use)\n"
 		"      --pcrs         specify local sysfs pcr file\n"
+		"      --list         measurement list verification\n"
 		"  -v                 increase verbosity level\n"
 		"  -h, --help         display this help and exit\n"
 		"\n");
@@ -1651,6 +1657,7 @@ static struct option opts[] = {
 	{"selinux", 1, 0, 136},
 	{"caps", 2, 0, 137},
 	{"pcrs", 1, 0, 138},
+	{"list", 0, 0, 139},
 	{}
 
 };
@@ -1802,6 +1809,9 @@ int main(int argc, char *argv[])
 		case 138:
 			pcrs_sysfs = optarg;
 			break;
+		case 139:
+			measurement_list = 1;
+			break;
 		case '?':
 			exit(1);
 			break;
diff --git a/src/imaevm.h b/src/imaevm.h
index ea6a7b1..f5cee7d 100644
--- a/src/imaevm.h
+++ b/src/imaevm.h
@@ -204,7 +204,7 @@ int key2bin(RSA *key, unsigned char *pub);
 
 int sign_hash(const char *algo, const unsigned char *hash, int size, const char *keyfile, const char *keypass, unsigned char *sig);
 int verify_hash(const unsigned char *hash, int size, unsigned char *sig, int siglen);
-int ima_verify_signature(const char *file, unsigned char *sig, int siglen);
+int ima_verify_signature(const char *file, unsigned char *sig, int siglen, unsigned char *digest, int digestlen);
 void init_public_keys(const char *keyfiles);
 
 #endif
diff --git a/src/libimaevm.c b/src/libimaevm.c
index 0ad290a..247100f 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -580,7 +580,8 @@ int verify_hash(const unsigned char *hash, int size, unsigned char *sig, int sig
 	return verify_hash(hash, size, sig, siglen, key);
 }
 
-int ima_verify_signature(const char *file, unsigned char *sig, int siglen)
+int ima_verify_signature(const char *file, unsigned char *sig, int siglen,
+			 unsigned char *digest, int digestlen)
 {
 	unsigned char hash[64];
 	int hashlen, sig_hash_algo;
@@ -598,6 +599,13 @@ int ima_verify_signature(const char *file, unsigned char *sig, int siglen)
 	/* Use hash algorithm as retrieved from signature */
 	params.hash_algo = pkey_hash_algo[sig_hash_algo];
 
+	/*
+	 * Validate the signature based on the digest included in the
+	 * measurement list, not by calculating the local file digest.
+	 */
+	if (digestlen > 0)
+	    return verify_hash(digest, digestlen, sig + 1, siglen - 1);
+
 	hashlen = ima_calc_hash(file, hash);
 	if (hashlen <= 1)
 		return hashlen;
-- 
2.7.4

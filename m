Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-qt0-f201.google.com ([209.85.216.201]:44009 "EHLO
        mail-qt0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965655AbdKPSVP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Nov 2017 13:21:15 -0500
Received: by mail-qt0-f201.google.com with SMTP id h9so25803424qtc.2
        for <linux-integrity@vger.kernel.org>; Thu, 16 Nov 2017 10:21:15 -0800 (PST)
MIME-Version: 1.0
Date: Thu, 16 Nov 2017 10:21:11 -0800
Message-Id: <20171116182111.26267-1-mjg59@google.com>
Subject: [USER] [PATCH V2] Add support for portable EVM format
From: Matthew Garrett <mjg59@google.com>
To: linux-integrity@vger.kernel.org
Cc: Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Add a --portable argument that generates EVM signatures without using
the inode number and generation or fs UUID.

Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 README       |  6 ++++--
 src/evmctl.c | 34 +++++++++++++++++++++++++---------
 src/imaevm.h |  1 +
 3 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/README b/README
index b1dfafa..da828cf 100644
--- a/README
+++ b/README
@@ -26,7 +26,7 @@ COMMANDS
  --version
  help <command>
  import [--rsa] pubkey keyring
- sign [-r] [--imahash | --imasig ] [--key key] [--pass password] file
+ sign [-r] [--imahash | --imasig ] [--portable] [--key key] [--pass password] file
  verify file
  ima_sign [--sigfile] [--key key] [--pass password] file
  ima_verify file
@@ -46,6 +46,7 @@ OPTIONS
   -f, --sigfile      store IMA signature in .sig file instead of xattr
       --rsa          use RSA key type and signing scheme v1
   -k, --key          path to signing key (default: /etc/keys/{privkey,pubkey}_evm.pem)
+  -o, --portable     generate portable EVM signatures
   -p, --pass         password for encrypted signing key
   -r, --recursive    recurse into directories (sign)
   -t, --type         file types to fix 'fdsxm' (f: file, d: directory, s: block/char/symlink)
@@ -95,7 +96,8 @@ Kernel configuration option CONFIG_EVM_ATTR_FSUUID controls whether to include
 filesystem UUID into HMAC and enabled by default. Therefore evmctl also includes
 fsuuid by default. Providing '--uuid' option without parameter allows to disable
 usage of fs uuid. Providing '--uuid=UUID' option with parameter allows to use
-custom UUID.
+custom UUID. Providing the '--portable' option will disable usage of the fs uuid
+and also the inode number and generation.
 
 Kernel configuration option CONFIG_EVM_EXTRA_SMACK_XATTRS controls whether to
 include additional SMACK extended attributes into HMAC. They are following:
diff --git a/src/evmctl.c b/src/evmctl.c
index c54efbb..60689d4 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -117,6 +117,7 @@ static int recursive;
 static int msize;
 static dev_t fs_dev;
 static bool evm_immutable;
+static bool evm_portable;
 
 #define HMAC_FLAG_NO_UUID	0x0001
 #define HMAC_FLAG_CAPS_SET	0x0002
@@ -418,8 +419,10 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
 		struct h_misc *hmac = (struct h_misc *)&hmac_misc;
 
 		hmac_size = sizeof(*hmac);
-		hmac->ino = st.st_ino;
-		hmac->generation = generation;
+		if (!evm_portable) {
+			hmac->ino = st.st_ino;
+			hmac->generation = generation;
+		}
 		hmac->uid = st.st_uid;
 		hmac->gid = st.st_gid;
 		hmac->mode = st.st_mode;
@@ -427,8 +430,10 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
 		struct h_misc_64 *hmac = (struct h_misc_64 *)&hmac_misc;
 
 		hmac_size = sizeof(*hmac);
-		hmac->ino = st.st_ino;
-		hmac->generation = generation;
+		if (!evm_portable) {
+			hmac->ino = st.st_ino;
+			hmac->generation = generation;
+		}
 		hmac->uid = st.st_uid;
 		hmac->gid = st.st_gid;
 		hmac->mode = st.st_mode;
@@ -436,8 +441,10 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
 		struct h_misc_32 *hmac = (struct h_misc_32 *)&hmac_misc;
 
 		hmac_size = sizeof(*hmac);
-		hmac->ino = st.st_ino;
-		hmac->generation = generation;
+		if (!evm_portable) {
+			hmac->ino = st.st_ino;
+			hmac->generation = generation;
+		}
 		hmac->uid = st.st_uid;
 		hmac->gid = st.st_gid;
 		hmac->mode = st.st_mode;
@@ -452,7 +459,8 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
 		return 1;
 	}
 
-	if (!evm_immutable && !(hmac_flags & HMAC_FLAG_NO_UUID)) {
+	if (!evm_immutable && !evm_portable &&
+	    !(hmac_flags & HMAC_FLAG_NO_UUID)) {
 		err = get_uuid(&st, uuid);
 		if (err)
 			return -1;
@@ -489,7 +497,10 @@ static int sign_evm(const char *file, const char *key)
 
 	/* add header */
 	len++;
-	sig[0] = EVM_IMA_XATTR_DIGSIG;
+	if (evm_portable)
+		sig[0] = EVM_XATTR_PORTABLE_DIGSIG;
+	else
+		sig[0] = EVM_IMA_XATTR_DIGSIG;
 
 	if (evm_immutable)
 		sig[1] = 3; /* immutable signature version */
@@ -1517,6 +1528,7 @@ static void usage(void)
 		"  -f, --sigfile      store IMA signature in .sig file instead of xattr\n"
 		"      --rsa          use RSA key type and signing scheme v1\n"
 		"  -k, --key          path to signing key (default: /etc/keys/{privkey,pubkey}_evm.pem)\n"
+		"  -o, --portable     generate portable EVM signatures\n"
 		"  -p, --pass         password for encrypted signing key\n"
 		"  -r, --recursive    recurse into directories (sign)\n"
 		"  -t, --type         file types to fix 'fdsxm' (f: file, d: directory, s: block/char/symlink)\n"
@@ -1574,6 +1586,7 @@ static struct option opts[] = {
 	{"recursive", 0, 0, 'r'},
 	{"m32", 0, 0, '3'},
 	{"m64", 0, 0, '6'},
+	{"portable", 0, 0, 'o'},
 	{"smack", 0, 0, 128},
 	{"version", 0, 0, 129},
 	{"inode", 1, 0, 130},
@@ -1630,7 +1643,7 @@ int main(int argc, char *argv[])
 	g_argc = argc;
 
 	while (1) {
-		c = getopt_long(argc, argv, "hvnsda:p::fu::k:t:ri", opts, &lind);
+		c = getopt_long(argc, argv, "hvnsda:op::fu::k:t:ri", opts, &lind);
 		if (c == -1)
 			break;
 
@@ -1679,6 +1692,9 @@ int main(int argc, char *argv[])
 		case 'i':
 			evm_immutable = true;
 			break;
+		case 'o':
+			evm_portable = true;
+			break;
 		case 't':
 			search_type = optarg;
 			break;
diff --git a/src/imaevm.h b/src/imaevm.h
index 711596c..e397743 100644
--- a/src/imaevm.h
+++ b/src/imaevm.h
@@ -82,6 +82,7 @@ enum evm_ima_xattr_type {
 	EVM_XATTR_HMAC,
 	EVM_IMA_XATTR_DIGSIG,
 	IMA_XATTR_DIGEST_NG,
+	EVM_XATTR_PORTABLE_DIGSIG,
 };
 
 struct h_misc {
-- 
2.15.0.448.gf294e3d99a-goog

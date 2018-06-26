Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59082 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750933AbeFZQ2r (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 Jun 2018 12:28:47 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5QGO0mh045422
        for <linux-integrity@vger.kernel.org>; Tue, 26 Jun 2018 12:28:46 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jupexfht0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 26 Jun 2018 12:28:46 -0400
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <gcwilson@linux.ibm.com>;
        Tue, 26 Jun 2018 10:28:45 -0600
From: George Wilson <gcwilson@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>
Subject: [PATCH] ima-evm-utils: add --pcrinit and --pcr options to ima_measurement command
Date: Tue, 26 Jun 2018 10:28:27 -0600
Message-Id: <20180626162827.4987-1-gcwilson@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Add a --pcrinit option to the evmctl ima_measurement command so it can
initialize the calculated value of the IMA PCR to something other than
the default of 0, allowing it to accommodate cases where the PCR has been
extended prior to boot.  Also add a --pcr option to select the IMA PCR
that is initialized.  The IMA PCR index defaults to DEFAULT_PCR.

Signed-off-by: George Wilson <gcwilson@linux.ibm.com>
Reviewed-by: Claudio Carvalho <cclaudio@linux.vnet.ibm.com>
---
 README       |  4 +++-
 src/evmctl.c | 44 ++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/README b/README
index 4805564..6bb30d0 100644
--- a/README
+++ b/README
@@ -31,7 +31,7 @@ COMMANDS
  ima_sign [--sigfile] [--key key] [--pass password] file
  ima_verify file
  ima_hash file
- ima_measurement [--key "key1, key2, ..."] [--list] file
+ ima_measurement [--key "key1, key2, ..."] [--list] [--pcrinit hash] [--pcr index] file
  ima_fix [-t fdsxm] path
  sign_hash [--key key] [--pass password]
  hmac [--imahash | --imasig ] file
@@ -57,6 +57,8 @@ OPTIONS
       --smack        use extra SMACK xattrs for EVM
       --m32          force EVM hmac/signature for 32 bit target system
       --m64          force EVM hmac/signature for 64 bit target system
+      --pcrinit      IMA PCR initialization hash (hex without 0x prefix; defaults to 0)
+      --pcr          IMA PCR index (decimal; defaults to DEFAULT_PCR - usually 10)
   -v                 increase verbosity level
   -h, --help         display this help and exit
 
diff --git a/src/evmctl.c b/src/evmctl.c
index 2ffee78..cee515f 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2011 Nokia Corporation
  * Copyright (C) 2011,2012,2013 Intel Corporation
  * Copyright (C) 2013,2014 Samsung Electronics
+ * Copyright (C) 2014,2018 IBM Corp.
  *
  * Authors:
  * Dmitry Kasatkin <dmitry.kasatkin@nokia.com>
@@ -112,6 +113,8 @@ static char *generation_str;
 static char *caps_str;
 static char *ima_str;
 static char *selinux_str;
+static char *pcrinit_str;
+static char *pcridx_str;
 static char *search_type;
 static int measurement_list;
 static int recursive;
@@ -1443,7 +1446,7 @@ void ima_ng_show(struct template_entry *entry)
 		log_err("Remain unprocessed data: %d\n", total_len);
 }
 
-static int ima_measurement(const char *file)
+static int ima_measurement(const char *file, uint8_t *pcrinit, int pcridx)
 {
 	uint8_t pcr[NUM_PCRS][SHA_DIGEST_LENGTH] = {{0}};
 	uint8_t hwpcr[SHA_DIGEST_LENGTH];
@@ -1457,6 +1460,10 @@ static int ima_measurement(const char *file)
 	memset(zero, 0, SHA_DIGEST_LENGTH);
 	memset(fox, 0xff, SHA_DIGEST_LENGTH);
 
+	/* Initialize calculated IMA PCR to designated value */
+	if (pcrinit)
+		memcpy(pcr[pcridx], pcrinit, SHA_DIGEST_LENGTH);
+
 	log_debug("Initial PCR value: ");
 	log_debug_dump(pcr, sizeof(pcr));
 
@@ -1535,6 +1542,8 @@ out:
 static int cmd_ima_measurement(struct command *cmd)
 {
 	char *file = g_argv[optind++];
+	uint8_t _pcrinit[SHA_DIGEST_LENGTH], *pcrinit = NULL;
+	int pcridx = DEFAULT_PCR;
 
 	if (!file) {
 		log_err("Parameters missing\n");
@@ -1542,7 +1551,23 @@ static int cmd_ima_measurement(struct command *cmd)
 		return -1;
 	}
 
-	return ima_measurement(file);
+	if (pcrinit_str) {
+		pcrinit = _pcrinit;
+		if(hex2bin(pcrinit, pcrinit_str, SHA_DIGEST_LENGTH)) {
+			log_err("Bad pcrinit hash argument\n");
+			return -1;
+		}
+	}
+
+	if (pcridx_str)
+		pcridx = atoi(pcridx_str);
+
+	if (pcridx < 0 || pcridx >= NUM_PCRS) {
+		log_err("PCR index is out of range\n");
+		return -1;
+	}
+
+	return(ima_measurement(file, pcrinit, pcridx));
 }
 
 static void print_usage(struct command *cmd)
@@ -1641,9 +1666,12 @@ static void usage(void)
 		"      --selinux      use custom Selinux label for EVM\n"
 		"      --caps         use custom Capabilities for EVM(unspecified: from FS, empty: do not use)\n"
 		"      --list         measurement list verification\n"
+		"      --pcrinit      IMA PCR initialization hash (hex without 0x prefix; defaults to 0)\n"
+		"      --pcr          IMA PCR index (decimal; defaults to %d)\n"
 		"  -v                 increase verbosity level\n"
 		"  -h, --help         display this help and exit\n"
-		"\n");
+		"\n",
+		DEFAULT_PCR);
 }
 
 struct command cmds[] = {
@@ -1657,7 +1685,7 @@ struct command cmds[] = {
 	{"ima_verify", cmd_verify_ima, 0, "file", "Verify IMA signature (for debugging).\n"},
 	{"ima_setxattr", cmd_setxattr_ima, 0, "[--sigfile file]", "Set IMA signature from sigfile\n"},
 	{"ima_hash", cmd_hash_ima, 0, "file", "Make file content hash.\n"},
-	{"ima_measurement", cmd_ima_measurement, 0, "file", "Verify measurement list (experimental).\n"},
+	{"ima_measurement", cmd_ima_measurement, 0, "[--pcrinit hash] [--pcr index] file", "Verify measurement list (experimental).\n"},
 	{"ima_fix", cmd_ima_fix, 0, "[-t fdsxm] path", "Recursively fix IMA/EVM xattrs in fix mode.\n"},
 	{"ima_clear", cmd_ima_clear, 0, "[-t fdsxm] path", "Recursively remove IMA/EVM xattrs.\n"},
 	{"sign_hash", cmd_sign_hash, 0, "[--key key] [--pass [password]", "Sign hashes from shaXsum output.\n"},
@@ -1693,6 +1721,8 @@ static struct option opts[] = {
 	{"selinux", 1, 0, 136},
 	{"caps", 2, 0, 137},
 	{"list", 0, 0, 138},
+	{"pcrinit", 1, 0, 139},
+	{"pcr", 1, 0, 140},
 	{}
 
 };
@@ -1844,6 +1874,12 @@ int main(int argc, char *argv[])
 		case 138:
 			measurement_list = 1;
 			break;
+		case 139:
+			pcrinit_str = optarg;
+			break;
+		case 140:
+			pcridx_str = optarg;
+			break;
 		case '?':
 			exit(1);
 			break;
-- 
2.17.0.582.gccdcbd5

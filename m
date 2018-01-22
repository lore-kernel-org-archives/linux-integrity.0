Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47700 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751287AbeAVOyf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 Jan 2018 09:54:35 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w0MErJth126614
        for <linux-integrity@vger.kernel.org>; Mon, 22 Jan 2018 09:54:35 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2fnhd82e1k-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 22 Jan 2018 09:54:34 -0500
Received: from localhost
        by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 22 Jan 2018 14:54:31 -0000
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        "Bruno E . O . Meneguele" <brdeoliv@redhat.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH 07/10] ima-evm-utils: add support for specifying the pcr file location
Date: Mon, 22 Jan 2018 09:54:02 -0500
In-Reply-To: <1516632845-7087-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1516632845-7087-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-Id: <1516632845-7087-8-git-send-email-zohar@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

The location of the PCRs differs from system to system.  This
patch defines a new "--pcrs <filename>" option.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 README       |  2 +-
 src/evmctl.c | 12 +++++++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/README b/README
index 1c4bc7a..f9706f8 100644
--- a/README
+++ b/README
@@ -31,7 +31,7 @@ COMMANDS
  ima_sign [--sigfile] [--key key] [--pass password] file
  ima_verify file
  ima_hash file
- ima_measurement [--key "key1, key2, ..."] file
+ ima_measurement [--key "key1, key2, ..."] [--pcrs <sysfs file>] file
  ima_fix [-t fdsxm] path
  sign_hash [--key key] [--pass password]
  hmac [--imahash | --imasig ] file
diff --git a/src/evmctl.c b/src/evmctl.c
index f791a5b..310ff4e 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -112,6 +112,7 @@ static char *generation_str;
 static char *caps_str;
 static char *ima_str;
 static char *selinux_str;
+static char *pcrs_sysfs;
 static char *search_type;
 static int recursive;
 static int msize;
@@ -1258,7 +1259,11 @@ static int tpm_pcr_read(int idx, uint8_t *pcr, int len)
 
 	sprintf(pcr_str, "PCR-%d", idx);
 
-	fp = fopen(pcrs, "r");
+
+	if (pcrs_sysfs)
+		fp = fopen(pcrs_sysfs, "r");
+	else
+		fp = fopen(pcrs, "r");
 	if (!fp) {
 		log_err("Unable to open %s\n", pcrs);
 		return -1;
@@ -1593,6 +1598,7 @@ static void usage(void)
 		"      --ima          use custom IMA signature for EVM\n"
 		"      --selinux      use custom Selinux label for EVM\n"
 		"      --caps         use custom Capabilities for EVM(unspecified: from FS, empty: do not use)\n"
+		"      --pcrs         specify local sysfs pcr file\n"
 		"  -v                 increase verbosity level\n"
 		"  -h, --help         display this help and exit\n"
 		"\n");
@@ -1644,6 +1650,7 @@ static struct option opts[] = {
 	{"ima", 1, 0, 135},
 	{"selinux", 1, 0, 136},
 	{"caps", 2, 0, 137},
+	{"pcrs", 1, 0, 138},
 	{}
 
 };
@@ -1792,6 +1799,9 @@ int main(int argc, char *argv[])
 			caps_str = optarg;
 			hmac_flags |= HMAC_FLAG_CAPS_SET;
 			break;
+		case 138:
+			pcrs_sysfs = optarg;
+			break;
 		case '?':
 			exit(1);
 			break;
-- 
2.7.4

Return-Path: <SRS0=quz6=VJ=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC43C742D2
	for <linux-integrity@archiver.kernel.org>; Fri, 12 Jul 2019 21:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78FD6208E4
	for <linux-integrity@archiver.kernel.org>; Fri, 12 Jul 2019 21:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbfGLV2t (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 12 Jul 2019 17:28:49 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:32858 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728040AbfGLV2t (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 12 Jul 2019 17:28:49 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 3DF2D72CCDB;
        Sat, 13 Jul 2019 00:28:46 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id 1BFDA4A4AE8;
        Sat, 13 Jul 2019 00:28:46 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v1 4/5] ima-evm-utils: Fix file2bin stat and fopen relations
Date:   Sat, 13 Jul 2019 00:28:32 +0300
Message-Id: <20190712212833.29280-4-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190712212833.29280-1-vt@altlinux.org>
References: <20190712212833.29280-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Check stat(2) return value, use fstat(2) to avoid race between
stat() and fopen(), remove now unused get_filesize().
Fixes CID 229889.
---
 src/evmctl.c    | 25 ++++++++++++++++++++-----
 src/imaevm.h    |  1 -
 src/libimaevm.c |  8 --------
 3 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index c556d05..f60c12e 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -175,9 +175,10 @@ static int bin2file(const char *file, const char *ext, const unsigned char *data
 static unsigned char *file2bin(const char *file, const char *ext, int *size)
 {
 	FILE *fp;
-	int len;
+	size_t len;
 	unsigned char *data;
 	char name[strlen(file) + (ext ? strlen(ext) : 0) + 2];
+	struct stat stats;
 
 	if (ext)
 		sprintf(name, "%s.%s", file, ext);
@@ -186,18 +187,32 @@ static unsigned char *file2bin(const char *file, const char *ext, int *size)
 
 	log_info("Reading to %s\n", name);
 
-	len = get_filesize(name);
 	fp = fopen(name, "r");
 	if (!fp) {
 		log_err("Failed to open: %s\n", name);
 		return NULL;
 	}
+	if (fstat(fileno(fp), &stats) == -1) {
+		log_err("Failed to fstat: %s (%s)\n", name, strerror(errno));
+		fclose(fp);
+		return NULL;
+	}
+	len = stats.st_size;
+
 	data = malloc(len);
-	if (!fread(data, len, 1, fp))
-		len = 0;
+	if (!data) {
+		log_err("Failed to malloc %zu bytes: %s\n", len, name);
+		fclose(fp);
+		return NULL;
+	}
+	if (fread(data, len, 1, fp) != len) {
+		log_err("Failed to fread %zu bytes: %s\n", len, name);
+		fclose(fp);
+		return NULL;
+	}
 	fclose(fp);
 
-	*size = len;
+	*size = (int)len;
 	return data;
 }
 
diff --git a/src/imaevm.h b/src/imaevm.h
index dc81a3a..36050f4 100644
--- a/src/imaevm.h
+++ b/src/imaevm.h
@@ -211,7 +211,6 @@ extern struct libevm_params params;
 
 void do_dump(FILE *fp, const void *ptr, int len, bool cr);
 void dump(const void *ptr, int len);
-int get_filesize(const char *filename);
 int ima_calc_hash(const char *file, uint8_t *hash);
 int get_hash_algo(const char *algo);
 RSA *read_pub_key(const char *keyfile, int x509);
diff --git a/src/libimaevm.c b/src/libimaevm.c
index f8ab812..1562aaf 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -116,14 +116,6 @@ const char *get_hash_algo_by_id(int algo)
 	return "unknown";
 }
 
-int get_filesize(const char *filename)
-{
-	struct stat stats;
-	/*  Need to know the file length */
-	stat(filename, &stats);
-	return (int)stats.st_size;
-}
-
 static inline off_t get_fdsize(int fd)
 {
 	struct stat stats;
-- 
2.11.0


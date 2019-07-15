Return-Path: <SRS0=GrPZ=VM=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7ACC7618F
	for <linux-integrity@archiver.kernel.org>; Mon, 15 Jul 2019 20:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 011F72145D
	for <linux-integrity@archiver.kernel.org>; Mon, 15 Jul 2019 20:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731055AbfGOUGV (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 15 Jul 2019 16:06:21 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:58520 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731054AbfGOUGV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 15 Jul 2019 16:06:21 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 84D0572CA65;
        Mon, 15 Jul 2019 23:06:19 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id 63E3A4A4A29;
        Mon, 15 Jul 2019 23:06:19 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v2 5/5] ima-evm-utils: Add more error checking in add_file_hash
Date:   Mon, 15 Jul 2019 23:05:53 +0300
Message-Id: <20190715200553.22403-5-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190715200553.22403-1-vt@altlinux.org>
References: <20190715200553.22403-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Check return value of fstat(2) in add_file_hash() and remove
now unused get_fdsize().
---
 src/libimaevm.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/src/libimaevm.c b/src/libimaevm.c
index 1562aaf..ae487f9 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -116,20 +116,13 @@ const char *get_hash_algo_by_id(int algo)
 	return "unknown";
 }
 
-static inline off_t get_fdsize(int fd)
-{
-	struct stat stats;
-	/*  Need to know the file length */
-	fstat(fd, &stats);
-	return stats.st_size;
-}
-
 static int add_file_hash(const char *file, EVP_MD_CTX *ctx)
 {
 	uint8_t *data;
 	int err = -1, bs = DATA_SIZE;
 	off_t size, len;
 	FILE *fp;
+	struct stat stats;
 
 	fp = fopen(file, "r");
 	if (!fp) {
@@ -143,7 +136,12 @@ static int add_file_hash(const char *file, EVP_MD_CTX *ctx)
 		goto out;
 	}
 
-	for (size = get_fdsize(fileno(fp)); size; size -= len) {
+	if (fstat(fileno(fp), &stats) == -1) {
+		log_err("Failed to fstat: %s (%s)\n", file, strerror(errno));
+		goto out;
+	}
+
+	for (size = stats.st_size; size; size -= len) {
 		len = MIN(size, bs);
 		if (!fread(data, len, 1, fp)) {
 			if (ferror(fp)) {
-- 
2.11.0


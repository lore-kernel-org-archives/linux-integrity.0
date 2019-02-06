Return-Path: <SRS0=dZkj=QN=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01E6C169C4
	for <linux-integrity@archiver.kernel.org>; Wed,  6 Feb 2019 12:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 839C020B1F
	for <linux-integrity@archiver.kernel.org>; Wed,  6 Feb 2019 12:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfBFMrl (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 6 Feb 2019 07:47:41 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:53668 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727985AbfBFMrk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 6 Feb 2019 07:47:40 -0500
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 81D8772CC53;
        Wed,  6 Feb 2019 15:47:38 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id CDA094A4A14;
        Wed,  6 Feb 2019 15:47:36 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH] ima-evm-utils: fix memory leak in ima_calc_hash
Date:   Wed,  6 Feb 2019 15:47:27 +0300
Message-Id: <20190206124727.2207-1-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Free EVP_MD_CTX in ima_calc_hash(). Also, remove legacy EVP_MD_CTX usage.

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 src/libimaevm.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/src/libimaevm.c b/src/libimaevm.c
index 6070614..dccb74c 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -322,12 +322,6 @@ int ima_calc_hash(const char *file, uint8_t *hash)
 	EVP_MD_CTX *pctx;
 	unsigned int mdlen;
 	int err;
-#if OPENSSL_VERSION_NUMBER < 0x10100000
-	EVP_MD_CTX ctx;
-	pctx = &ctx;
-#else
-	pctx = EVP_MD_CTX_new();
-#endif
 
 	/*  Need to know the file length */
 	err = lstat(file, &st);
@@ -342,9 +336,11 @@ int ima_calc_hash(const char *file, uint8_t *hash)
 		return 1;
 	}
 
+	pctx = EVP_MD_CTX_new();
 	err = EVP_DigestInit(pctx, md);
 	if (!err) {
 		log_err("EVP_DigestInit() failed\n");
+		EVP_MD_CTX_free(pctx);
 		return 1;
 	}
 
@@ -364,18 +360,21 @@ int ima_calc_hash(const char *file, uint8_t *hash)
 		break;
 	default:
 		log_errno("Unsupported file type");
+		EVP_MD_CTX_free(pctx);
 		return -1;
 	}
 
-	if (err)
+	if (err) {
+		EVP_MD_CTX_free(pctx);
 		return err;
+	}
 
 	err = EVP_DigestFinal(pctx, hash, &mdlen);
+	EVP_MD_CTX_free(pctx);
 	if (!err) {
 		log_err("EVP_DigestFinal() failed\n");
 		return 1;
 	}
-
 	return mdlen;
 }
 
-- 
2.11.0


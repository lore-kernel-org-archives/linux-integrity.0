Return-Path: <SRS0=SrEi=UR=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F70C31E51
	for <linux-integrity@archiver.kernel.org>; Tue, 18 Jun 2019 13:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83E9A2084B
	for <linux-integrity@archiver.kernel.org>; Tue, 18 Jun 2019 13:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfFRN5z (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 18 Jun 2019 09:57:55 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:53598 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfFRN5z (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Jun 2019 09:57:55 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 4E0A772CC58;
        Tue, 18 Jun 2019 16:57:53 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id 126BB4A4A14;
        Tue, 18 Jun 2019 16:57:53 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v5 08/11] ima-evm-utils: Finish conversion of find_keyid to EVP_PKEY API
Date:   Tue, 18 Jun 2019 16:56:20 +0300
Message-Id: <20190618135623.6861-9-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190618135623.6861-1-vt@altlinux.org>
References: <20190618135623.6861-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Replace old find_keyid() with new find_keyid_pkey().

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 src/libimaevm.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/src/libimaevm.c b/src/libimaevm.c
index 73beb28..3b646e5 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -456,7 +456,7 @@ struct public_key_entry {
 };
 static struct public_key_entry *public_keys = NULL;
 
-static EVP_PKEY *find_keyid_pkey(uint32_t keyid)
+static EVP_PKEY *find_keyid(uint32_t keyid)
 {
 	struct public_key_entry *entry;
 
@@ -467,22 +467,6 @@ static EVP_PKEY *find_keyid_pkey(uint32_t keyid)
 	return NULL;
 }
 
-static RSA *find_keyid(uint32_t keyid)
-{
-	EVP_PKEY *pkey;
-	RSA *key;
-
-	pkey = find_keyid_pkey(keyid);
-	if (!pkey)
-		return NULL;
-	key = EVP_PKEY_get0_RSA(pkey);
-	if (!key) {
-		log_err("find_keyid: unsupported key type\n");
-		return NULL;
-	}
-	return key;
-}
-
 void init_public_keys(const char *keyfiles)
 {
 	struct public_key_entry *entry;
@@ -534,7 +518,7 @@ int verify_hash_v2(const char *file, const unsigned char *hash, int size,
 	}
 
 	if (public_keys) {
-		pkey = find_keyid_pkey(hdr->keyid);
+		pkey = find_keyid(hdr->keyid);
 		if (!pkey) {
 			log_err("%s: unknown keyid: %x\n", file,
 				__be32_to_cpup(&hdr->keyid));
-- 
2.11.0


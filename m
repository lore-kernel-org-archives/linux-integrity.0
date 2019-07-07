Return-Path: <SRS0=ErRK=VE=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EEE3C0650E
	for <linux-integrity@archiver.kernel.org>; Sun,  7 Jul 2019 23:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03C2A20663
	for <linux-integrity@archiver.kernel.org>; Sun,  7 Jul 2019 23:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbfGGXtV (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sun, 7 Jul 2019 19:49:21 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:43292 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbfGGXtV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 7 Jul 2019 19:49:21 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id AE52D72CC6C;
        Mon,  8 Jul 2019 02:49:18 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id 938664A4AF6;
        Mon,  8 Jul 2019 02:49:18 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v1 5/5] ima-evm-utils: Fix clang warning about possible unaligned pointer for hdr->keyid
Date:   Mon,  8 Jul 2019 02:48:37 +0300
Message-Id: <20190707234837.4866-6-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190707234837.4866-1-vt@altlinux.org>
References: <20190707234837.4866-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Struct signature_v2_hdr is packed so clang complains that taking address
of packed member may result in an unaligned pointer value:

libimaevm.c:481:21: warning: taking address of packed member 'keyid' of class or structure 'signature_v2_hdr' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
                                __be32_to_cpup(&hdr->keyid));
                                                ^~~~~~~~~~

libimaevm.c:905:17: warning: taking address of packed member 'keyid' of class or structure 'signature_v2_hdr' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
        calc_keyid_v2(&hdr->keyid, name, pkey);
                       ^~~~~~~~~~

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 src/libimaevm.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/src/libimaevm.c b/src/libimaevm.c
index b556276..f8ab812 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -475,10 +475,12 @@ int verify_hash_v2(const char *file, const unsigned char *hash, int size,
 	}
 
 	if (public_keys) {
-		pkey = find_keyid(hdr->keyid);
+		uint32_t keyid = hdr->keyid;
+
+		pkey = find_keyid(keyid);
 		if (!pkey) {
 			log_err("%s: unknown keyid: %x\n", file,
-				__be32_to_cpup(&hdr->keyid));
+				__be32_to_cpup(&keyid));
 			return -1;
 		}
 	} else {
@@ -869,6 +871,7 @@ int sign_hash_v2(const char *algo, const unsigned char *hash, int size, const ch
 	const EVP_MD *md;
 	size_t sigsize;
 	const char *st;
+	uint32_t keyid;
 
 	if (!hash) {
 		log_err("sign_hash_v2: hash is null\n");
@@ -902,7 +905,8 @@ int sign_hash_v2(const char *algo, const unsigned char *hash, int size, const ch
 
 	hdr->hash_algo = get_hash_algo(algo);
 
-	calc_keyid_v2(&hdr->keyid, name, pkey);
+	calc_keyid_v2(&keyid, name, pkey);
+	hdr->keyid = keyid;
 
 	st = "EVP_PKEY_CTX_new";
 	if (!(ctx = EVP_PKEY_CTX_new(pkey, NULL)))
-- 
2.11.0


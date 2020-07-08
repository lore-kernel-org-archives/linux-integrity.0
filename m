Return-Path: <SRS0=10M6=AT=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39E4C433E1
	for <linux-integrity@archiver.kernel.org>; Wed,  8 Jul 2020 06:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC4C32078B
	for <linux-integrity@archiver.kernel.org>; Wed,  8 Jul 2020 06:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729741AbgGHGHn (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 8 Jul 2020 02:07:43 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:53487 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729754AbgGHGHn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Jul 2020 02:07:43 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0U256rZN_1594188458;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0U256rZN_1594188458)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 08 Jul 2020 14:07:39 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     zohar@linux.ibm.com, vt@altlinux.org,
        linux-integrity@vger.kernel.org
Cc:     tianjia.zhang@linux.alibaba.com
Subject: [PATCH ima-evm-utils 1/3] ima-evm-utils: Fix mismatched type checking
Date:   Wed,  8 Jul 2020 14:07:36 +0800
Message-Id: <20200708060738.43558-1-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Even if imaevm_get_hash_algo() returns an error value of -1, it is
forced to be converted to uint8_t type here, resulting in this error
not being checked by the if condition. This patch fixes this error.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 src/libimaevm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/libimaevm.c b/src/libimaevm.c
index e6947d7..a9419ee 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -922,7 +922,7 @@ static int sign_hash_v2(const char *algo, const unsigned char *hash,
 	hdr->version = (uint8_t) DIGSIG_VERSION_2;
 
 	hdr->hash_algo = imaevm_get_hash_algo(algo);
-	if (hdr->hash_algo == -1) {
+	if (hdr->hash_algo == (uint8_t)-1) {
 		log_err("sign_hash_v2: hash algo is unknown: %s\n", algo);
 		return -1;
 	}
-- 
2.17.1


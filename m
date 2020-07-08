Return-Path: <SRS0=10M6=AT=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35CDBC433DF
	for <linux-integrity@archiver.kernel.org>; Wed,  8 Jul 2020 06:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 203CF20786
	for <linux-integrity@archiver.kernel.org>; Wed,  8 Jul 2020 06:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729754AbgGHGHn (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 8 Jul 2020 02:07:43 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:35434 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729756AbgGHGHn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Jul 2020 02:07:43 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01419;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0U25gnGF_1594188460;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0U25gnGF_1594188460)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 08 Jul 2020 14:07:40 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     zohar@linux.ibm.com, vt@altlinux.org,
        linux-integrity@vger.kernel.org
Cc:     tianjia.zhang@linux.alibaba.com
Subject: [PATCH ima-evm-utils 3/3] ima-evm-utils: ima_sign supports sm3 algorithm
Date:   Wed,  8 Jul 2020 14:07:38 +0800
Message-Id: <20200708060738.43558-3-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200708060738.43558-1-tianjia.zhang@linux.alibaba.com>
References: <20200708060738.43558-1-tianjia.zhang@linux.alibaba.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

imaevm sign and verify support sm3 hash algorithm.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 src/libimaevm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/libimaevm.c b/src/libimaevm.c
index 8f2ebcf..9c61e64 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -71,6 +71,7 @@ static const char *const pkey_hash_algo[PKEY_HASH__LAST] = {
 	[PKEY_HASH_SHA384]	= "sha384",
 	[PKEY_HASH_SHA512]	= "sha512",
 	[PKEY_HASH_SHA224]	= "sha224",
+	[PKEY_HASH_SM3_256]	= "sm3",
 	[PKEY_HASH_STREEBOG_256] = "md_gost12_256",
 	[PKEY_HASH_STREEBOG_512] = "md_gost12_512",
 };
-- 
2.17.1


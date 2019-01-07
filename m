Return-Path: <SRS0=ry+W=PP=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436B5C43612
	for <linux-integrity@archiver.kernel.org>; Mon,  7 Jan 2019 02:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12A2920868
	for <linux-integrity@archiver.kernel.org>; Mon,  7 Jan 2019 02:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbfAGC2I (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sun, 6 Jan 2019 21:28:08 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:60202 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726502AbfAGC2I (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 6 Jan 2019 21:28:08 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R221e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=zhang.jia@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0THgsJYS_1546827991;
Received: from localhost(mailfrom:zhang.jia@linux.alibaba.com fp:SMTPD_---0THgsJYS_1546827991)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 07 Jan 2019 10:26:31 +0800
From:   Jia Zhang <zhang.jia@linux.alibaba.com>
To:     zohar@linux.vnet.ibm.com, pvorel@suse.cz
Cc:     linux-integrity@vger.kernel.org, ltp@lists.linux.it,
        zhang.jia@linux.alibaba.com
Subject: [PATCH 1/6] ima/ima_boot_aggregate: Fix the definition of event log
Date:   Mon,  7 Jan 2019 10:26:24 +0800
Message-Id: <1546827989-43569-2-git-send-email-zhang.jia@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1546827989-43569-1-git-send-email-zhang.jia@linux.alibaba.com>
References: <1546827989-43569-1-git-send-email-zhang.jia@linux.alibaba.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

According to [1], the structure of event log should be packed,
and certain fields should be 32-bit unsigned integer. Fortunately,
keeping natural alignment seems to make everything working as
expected all the time.

[1] page 17,18 @https://trustedcomputinggroup.org/wp-content/uploads/TCG_EFI_Protocol_1_22_Final-v05.pdf

Signed-off-by: Jia Zhang <zhang.jia@linux.alibaba.com>
---
 testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c b/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
index f6e7be0..d85d222 100644
--- a/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
+++ b/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
@@ -53,10 +53,10 @@ int main(int argc, char *argv[])
 	struct {
 		struct {
 			u_int32_t pcr;
-			int type;
-			unsigned char digest[SHA_DIGEST_LENGTH];
-			u_int16_t len;
-		} header;
+			u_int32_t type;
+			u_int8_t digest[SHA_DIGEST_LENGTH];
+			u_int32_t len;
+		} header __attribute__ ((packed));
 		char *data;
 	} event;
 	struct {
-- 
1.8.3.1


Return-Path: <SRS0=v/7H=PX=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27057C43387
	for <linux-integrity@archiver.kernel.org>; Tue, 15 Jan 2019 02:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA933206B7
	for <linux-integrity@archiver.kernel.org>; Tue, 15 Jan 2019 02:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbfAOCQj (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 14 Jan 2019 21:16:39 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:55555 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727508AbfAOCQj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 Jan 2019 21:16:39 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R361e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=zhang.jia@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TIG.4Zb_1547518481;
Received: from localhost(mailfrom:zhang.jia@linux.alibaba.com fp:SMTPD_---0TIG.4Zb_1547518481)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 15 Jan 2019 10:14:41 +0800
From:   Jia Zhang <zhang.jia@linux.alibaba.com>
To:     zohar@linux.ibm.com, pvorel@suse.cz
Cc:     linux-integrity@vger.kernel.org, ltp@lists.linux.it,
        zhang.jia@linux.alibaba.com
Subject: [PATCH 3/6] ima/ima_boot_aggregate: Fix extending PCRs beyond PCR 0-7
Date:   Tue, 15 Jan 2019 10:14:33 +0800
Message-Id: <1547518476-34008-4-git-send-email-zhang.jia@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1547518476-34008-1-git-send-email-zhang.jia@linux.alibaba.com>
References: <1547518476-34008-1-git-send-email-zhang.jia@linux.alibaba.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The boot aggragate calculation should never touch PCRs beyond PCR 0-7,
even a PCR extension really manipulates out-of-domain PCRs.

Signed-off-by: Jia Zhang <zhang.jia@linux.alibaba.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
 .../security/integrity/ima/src/ima_boot_aggregate.c       | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c b/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
index 67be6a7..98893b9 100644
--- a/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
+++ b/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
@@ -93,11 +93,16 @@ int main(int argc, char *argv[])
 			printf("%03u ", event.header.pcr);
 			display_sha1_digest(event.header.digest);
 		}
-		SHA1_Init(&c);
-		SHA1_Update(&c, pcr[event.header.pcr].digest,
-			    SHA_DIGEST_LENGTH);
-		SHA1_Update(&c, event.header.digest, SHA_DIGEST_LENGTH);
-		SHA1_Final(pcr[event.header.pcr].digest, &c);
+
+		if (event.header.pcr < NUM_PCRS) {
+			SHA1_Init(&c);
+			SHA1_Update(&c, pcr[event.header.pcr].digest,
+				    SHA_DIGEST_LENGTH);
+			SHA1_Update(&c, event.header.digest,
+				    SHA_DIGEST_LENGTH);
+			SHA1_Final(pcr[event.header.pcr].digest, &c);
+		}
+
 #if MAX_EVENT_DATA_SIZE < USHRT_MAX
 		if (event.header.len > MAX_EVENT_DATA_SIZE) {
 			printf("Error event too long\n");
-- 
1.8.3.1


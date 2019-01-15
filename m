Return-Path: <SRS0=v/7H=PX=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA861C43387
	for <linux-integrity@archiver.kernel.org>; Tue, 15 Jan 2019 02:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83D2020659
	for <linux-integrity@archiver.kernel.org>; Tue, 15 Jan 2019 02:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfAOCPq (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 14 Jan 2019 21:15:46 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:40829 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726886AbfAOCPq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 Jan 2019 21:15:46 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R901e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=zhang.jia@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TIFSdAi_1547518480;
Received: from localhost(mailfrom:zhang.jia@linux.alibaba.com fp:SMTPD_---0TIFSdAi_1547518480)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 15 Jan 2019 10:14:41 +0800
From:   Jia Zhang <zhang.jia@linux.alibaba.com>
To:     zohar@linux.ibm.com, pvorel@suse.cz
Cc:     linux-integrity@vger.kernel.org, ltp@lists.linux.it,
        zhang.jia@linux.alibaba.com
Subject: [PATCH 2/6] ima/ima_boot_aggregate: Don't hard code the length of sha1 hash
Date:   Tue, 15 Jan 2019 10:14:32 +0800
Message-Id: <1547518476-34008-3-git-send-email-zhang.jia@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1547518476-34008-1-git-send-email-zhang.jia@linux.alibaba.com>
References: <1547518476-34008-1-git-send-email-zhang.jia@linux.alibaba.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Instead, use SHA_DIGEST_LENGTH.

Signed-off-by: Jia Zhang <zhang.jia@linux.alibaba.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
 testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c b/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
index d85d222..67be6a7 100644
--- a/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
+++ b/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
@@ -42,7 +42,7 @@ static void display_sha1_digest(unsigned char *pcr)
 {
 	int i;
 
-	for (i = 0; i < 20; i++)
+	for (i = 0; i < SHA_DIGEST_LENGTH; i++)
 		printf("%02x", *(pcr + i) & 0xff);
 	printf("\n");
 }
@@ -94,8 +94,9 @@ int main(int argc, char *argv[])
 			display_sha1_digest(event.header.digest);
 		}
 		SHA1_Init(&c);
-		SHA1_Update(&c, pcr[event.header.pcr].digest, 20);
-		SHA1_Update(&c, event.header.digest, 20);
+		SHA1_Update(&c, pcr[event.header.pcr].digest,
+			    SHA_DIGEST_LENGTH);
+		SHA1_Update(&c, event.header.digest, SHA_DIGEST_LENGTH);
 		SHA1_Final(pcr[event.header.pcr].digest, &c);
 #if MAX_EVENT_DATA_SIZE < USHRT_MAX
 		if (event.header.len > MAX_EVENT_DATA_SIZE) {
@@ -116,7 +117,7 @@ int main(int argc, char *argv[])
 			printf("PCR-%2.2x: ", i);
 			display_sha1_digest(pcr[i].digest);
 		}
-		SHA1_Update(&c, pcr[i].digest, 20);
+		SHA1_Update(&c, pcr[i].digest, SHA_DIGEST_LENGTH);
 	}
 	SHA1_Final(boot_aggregate, &c);
 
-- 
1.8.3.1


Return-Path: <SRS0=jgnH=TO=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C08FC04AB4
	for <linux-integrity@archiver.kernel.org>; Tue, 14 May 2019 22:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBE6E216F4
	for <linux-integrity@archiver.kernel.org>; Tue, 14 May 2019 22:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfENWNq (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 14 May 2019 18:13:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:48450 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726314AbfENWNq (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 May 2019 18:13:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A7110AFBD;
        Tue, 14 May 2019 22:01:31 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH] ima: fix wrong signed policy requirement when not appraising
Date:   Wed, 15 May 2019 00:01:25 +0200
Message-Id: <20190514220125.31222-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Kernel booted just with ima_policy=tcb (not with
ima_policy=appraise_tcb) shouldn't require signed policy.

Regression found with LTP test ima_policy.sh.

Fixes: c52657d93b05 ("ima: refactor ima_init_policy()")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

assuming behavior prior c52657d93b05 was correct.
BTW I admit that using global variable inside helper function is nasty.

Kind regards,
Petr

 security/integrity/ima/ima_policy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index e0cc323f948f..df0e6a1b063b 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -500,7 +500,7 @@ static void add_rules(struct ima_rule_entry *entries, int count,
 		}
 		if (entries[i].action == APPRAISE)
 			temp_ima_appraise |= ima_appraise_flag(entries[i].func);
-		if (entries[i].func == POLICY_CHECK)
+		if (ima_use_appraise_tcb && entries[i].func == POLICY_CHECK)
 			temp_ima_appraise |= IMA_APPRAISE_POLICY;
 	}
 }
-- 
2.16.4


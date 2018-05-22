Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from lan.nucleusys.com ([92.247.61.126]:57674 "EHLO
        zztop.nucleusys.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751196AbeEVOG7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 22 May 2018 10:06:59 -0400
Date: Tue, 22 May 2018 17:06:55 +0300
From: Petko Manolov <petkan@nucleusys.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Linux Integrity <linux-integrity@vger.kernel.org>
Subject: [PATCH] IMA: use list_splice_tail_init_rcu() instead of its open
 coded variant
Message-ID: <20180522140655.GA5794@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

	Hi Mimi,

Please review and consider this patch for mainlining if it looks OK to you.  
I've tested it on v4.17.0-rc6 and seems to be working fine.


		Petko


---
>From e5cb36d4470cf64af2087fba4615ee8539385c98 Mon Sep 17 00:00:00 2001
From: Petko Manolov <petko.manolov@konsulko.com>
Date: Fri, 18 May 2018 14:10:57 +0300
Subject: [PATCH] Replace the open coded version with
 list_splice_tail_init_rcu()

Signed-off-by: Petko Manolov <petko.manolov@konsulko.com>
---
 security/integrity/ima/ima_policy.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index d89bebf85421..722466f843ef 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -509,22 +509,9 @@ int ima_check_policy(void)
  */
 void ima_update_policy(void)
 {
-	struct list_head *first, *last, *policy;
+	struct list_head *policy = &ima_policy_rules;
 
-	/* append current policy with the new rules */
-	first = (&ima_temp_rules)->next;
-	last = (&ima_temp_rules)->prev;
-	policy = &ima_policy_rules;
-
-	synchronize_rcu();
-
-	last->next = policy;
-	rcu_assign_pointer(list_next_rcu(policy->prev), first);
-	first->prev = policy->prev;
-	policy->prev = last;
-
-	/* prepare for the next policy rules addition */
-	INIT_LIST_HEAD(&ima_temp_rules);
+	list_splice_tail_init_rcu(&ima_temp_rules, policy, synchronize_rcu);
 
 	if (ima_rules != policy) {
 		ima_policy_flag = 0;
-- 
2.11.0

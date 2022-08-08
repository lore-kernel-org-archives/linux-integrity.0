Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C95C19F2A
	for <linux-integrity@archiver.kernel.org>; Mon,  8 Aug 2022 03:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234943AbiHHDCY (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sun, 7 Aug 2022 23:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbiHHDCV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 7 Aug 2022 23:02:21 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F911BC9F
        for <linux-integrity@vger.kernel.org>; Sun,  7 Aug 2022 20:02:19 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4M1LWc4bbCz1M8hg;
        Mon,  8 Aug 2022 10:59:08 +0800 (CST)
Received: from [10.67.110.173] (10.67.110.173) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 8 Aug 2022 11:02:16 +0800
Message-ID: <ffbb5ff1-cec7-3dad-7330-31fdfb67fecc@huawei.com>
Date:   Mon, 8 Aug 2022 11:02:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
From:   "Guozihua (Scott)" <guozihua@huawei.com>
Subject: Race conditioned discovered between ima_match_rules and
 ima_update_lsm_update_rules
CC:     Mimi Zohar <zohar@linux.ibm.com>,
        "xiujianfeng@huawei.com" <xiujianfeng@huawei.com>,
        luhuaxin <luhuaxin1@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.173]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500024.china.huawei.com (7.185.36.203)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Community,

Recently we discovered a race condition while updating SELinux policy 
with IMA lsm rule enabled. Which would lead to extra files being measured.

While SELinux policy is updated, the IDs for object types and such would 
be changed, and ima_lsm_update_rules would be called.

There are no lock applied in ima_lsm_update_rules. If user accesses a 
file during this time, ima_match_rules will be matching rules based on 
old SELinux au_seqno resulting in selinux_audit_rule_match returning 
-ESTALE.

However, in ima_match_rules, this error number is not handled, causing 
IMA to think the LSM rule is also a match, leading to measuring extra files.

Relevant codes are as follows:

> static void ima_lsm_update_rules(void)
> {
> 	struct ima_rule_entry *entry, *e;
> 	int result;
> 
> 	list_for_each_entry_safe(entry, e, &ima_policy_rules, list) {
> 		if (!ima_rule_contains_lsm_cond(entry))
> 			continue;
> 
> 		result = ima_lsm_update_rule(entry);

A RCU style update is used with no lock applied. Reading to rules would 
return rules with staled au_seqno.

> 		if (result) {
> 			pr_err("lsm rule update error %d\n", result);
> 			return;
> 		}
> 	}
> }


> int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule)
> {
> 	struct selinux_state *state = &selinux_state;
> 	struct selinux_policy *policy;
> 	struct context *ctxt;
> 	struct mls_level *level;
> 	struct selinux_audit_rule *rule = vrule;
> 	int match = 0;
> 
> 	if (unlikely(!rule)) {
> 		WARN_ONCE(1, "selinux_audit_rule_match: missing rule\n");
> 		return -ENOENT;
> 	}
> 
> 	if (!selinux_initialized(state))
> 		return 0;
> 
> 	rcu_read_lock();
> 
> 	policy = rcu_dereference(state->policy);
> 
> 	if (rule->au_seqno < policy->latest_granting) {
> 		match = -ESTALE;
> 		goto out;
> 	}

SELinux would return -ESTALE here.

> static bool ima_match_rules(struct ima_rule_entry *rule,
> 			    struct user_namespace *mnt_userns,
> 			    struct inode *inode, const struct cred *cred,
> 			    u32 secid, enum ima_hooks func, int mask,
> 			    const char *func_data)
> {
> ...
> 
> 	for (i = 0; i < MAX_LSM_RULES; i++) {
> 		int rc = 0;
> 		u32 osid;
> 
> 		if (!rule->lsm[i].rule) {
> 			if (!rule->lsm[i].args_p)
> 				continue;
> 			else
> 				return false;
> 		}
> 		switch (i) {
> 		case LSM_OBJ_USER:
> 		case LSM_OBJ_ROLE:
> 		case LSM_OBJ_TYPE:
> 			security_inode_getsecid(inode, &osid);
> 			rc = ima_filter_rule_match(osid, rule->lsm[i].type,
> 						   Audit_equal,
> 						   rule->lsm[i].rule);

rc here will be -ESTALE.

> 			break;
> 		case LSM_SUBJ_USER:
> 		case LSM_SUBJ_ROLE:
> 		case LSM_SUBJ_TYPE:
> 			rc = ima_filter_rule_match(secid, rule->lsm[i].type,
> 						   Audit_equal,
> 						   rule->lsm[i].rule);
> 			break;
> 		default:
> 			break;
> 		}
> 		if (!rc)
> 			return false;

-ERRNO is not handled, this func will return true.

> 	}
> 	return true;
> }

It seems that IMA would not "leak" any files, but widening the 
measurement range.

Is this the intended behavior? Or is it a good idea to add a lock for 
LSM rules during update?

-- 
Best
GUO Zihua

Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA99C433EF
	for <linux-integrity@archiver.kernel.org>; Thu, 16 Sep 2021 12:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1440B6127A
	for <linux-integrity@archiver.kernel.org>; Thu, 16 Sep 2021 12:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238578AbhIPMHZ (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 16 Sep 2021 08:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238951AbhIPMHZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Sep 2021 08:07:25 -0400
Received: from ha0.nfschina.com (unknown [IPv6:2400:dd01:100f:2:d63d:7eff:fe08:eb3f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CD017C061574
        for <linux-integrity@vger.kernel.org>; Thu, 16 Sep 2021 05:06:03 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by ha0.nfschina.com (Postfix) with ESMTP id 38E39AE0DE6;
        Thu, 16 Sep 2021 20:06:03 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from ha0.nfschina.com ([127.0.0.1])
        by localhost (ha0.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id y0_0wmCxj8PD; Thu, 16 Sep 2021 20:05:41 +0800 (CST)
Received: from [172.30.18.174] (unknown [180.167.10.98])
        (Authenticated sender: liqiong@nfschina.com)
        by ha0.nfschina.com (Postfix) with ESMTPA id 00C0BAE0DB2;
        Thu, 16 Sep 2021 20:05:40 +0800 (CST)
Subject: Re: [zohar-integrity:next-integrity-testing 1/1]
 security/integrity/ima/ima_policy.c:684:25: sparse: sparse: incompatible
 types in comparison expression (different address spaces):
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-integrity@vger.kernel.org,
        THOBY Simon <Simon.THOBY@viveris.fr>
References: <202109150609.vPQhnWpw-lkp@intel.com>
From:   liqiong <liqiong@nfschina.com>
Message-ID: <1b6c2bf0-cd29-436b-9cdc-2e2a6405601a@nfschina.com>
Date:   Thu, 16 Sep 2021 20:05:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <202109150609.vPQhnWpw-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mini,

I got this sparse warnings, should i fix it ?

It seems the follow patch can fix, but i don't think should do
this check (ima_rules_tmp == NULL).


-static struct list_head *ima_rules = &ima_default_rules;
+static struct list_head __rcu *ima_rules = (struct list_head __rcu *)(&ima_default_rules);

ima_rules_tmp = rcu_dereference(ima_rules);
+if (ima_rules_tmp == NULL)
+	return ;

--
Thanks,

Liqiong

在 2021年09月15日 06:30, kernel test robot 写道:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity-testing
> head:   836f7b6ca082b7031d2687b3493eefd104ddc060
> commit: 836f7b6ca082b7031d2687b3493eefd104ddc060 [1/1] ima: fix deadlock when traversing "ima_default_rules".
> config: x86_64-rhel-8.3-kselftests (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce:
>         # apt-get install sparse
>         # sparse version: v0.6.4-dirty
>         # https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git/commit/?id=836f7b6ca082b7031d2687b3493eefd104ddc060
>         git remote add zohar-integrity https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
>         git fetch --no-tags zohar-integrity next-integrity-testing
>         git checkout 836f7b6ca082b7031d2687b3493eefd104ddc060
>         # save the attached .config to linux build tree
>         make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
>
> sparse warnings: (new ones prefixed by >>)
>>> security/integrity/ima/ima_policy.c:684:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
>>> security/integrity/ima/ima_policy.c:684:25: sparse:    struct list_head [noderef] __rcu *
>>> security/integrity/ima/ima_policy.c:684:25: sparse:    struct list_head *
>    security/integrity/ima/ima_policy.c:976:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
>    security/integrity/ima/ima_policy.c:976:17: sparse:    struct list_head [noderef] __rcu *
>    security/integrity/ima/ima_policy.c:976:17: sparse:    struct list_head *
>    security/integrity/ima/ima_policy.c:1776:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
>    security/integrity/ima/ima_policy.c:1776:25: sparse:    struct list_head [noderef] __rcu *
>    security/integrity/ima/ima_policy.c:1776:25: sparse:    struct list_head *
>    security/integrity/ima/ima_policy.c:2030:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
>    security/integrity/ima/ima_policy.c:2030:25: sparse:    struct list_head [noderef] __rcu *
>    security/integrity/ima/ima_policy.c:2030:25: sparse:    struct list_head *
>
> vim +684 security/integrity/ima/ima_policy.c
>
>    648	
>    649	/**
>    650	 * ima_match_policy - decision based on LSM and other conditions
>    651	 * @mnt_userns:	user namespace of the mount the inode was found from
>    652	 * @inode: pointer to an inode for which the policy decision is being made
>    653	 * @cred: pointer to a credentials structure for which the policy decision is
>    654	 *        being made
>    655	 * @secid: LSM secid of the task to be validated
>    656	 * @func: IMA hook identifier
>    657	 * @mask: requested action (MAY_READ | MAY_WRITE | MAY_APPEND | MAY_EXEC)
>    658	 * @pcr: set the pcr to extend
>    659	 * @template_desc: the template that should be used for this rule
>    660	 * @func_data: func specific data, may be NULL
>    661	 * @allowed_algos: allowlist of hash algorithms for the IMA xattr
>    662	 *
>    663	 * Measure decision based on func/mask/fsmagic and LSM(subj/obj/type)
>    664	 * conditions.
>    665	 *
>    666	 * Since the IMA policy may be updated multiple times we need to lock the
>    667	 * list when walking it.  Reads are many orders of magnitude more numerous
>    668	 * than writes so ima_match_policy() is classical RCU candidate.
>    669	 */
>    670	int ima_match_policy(struct user_namespace *mnt_userns, struct inode *inode,
>    671			     const struct cred *cred, u32 secid, enum ima_hooks func,
>    672			     int mask, int flags, int *pcr,
>    673			     struct ima_template_desc **template_desc,
>    674			     const char *func_data, unsigned int *allowed_algos)
>    675	{
>    676		struct ima_rule_entry *entry;
>    677		int action = 0, actmask = flags | (flags << 1);
>    678		struct list_head *ima_rules_tmp;
>    679	
>    680		if (template_desc && !*template_desc)
>    681			*template_desc = ima_template_desc_current();
>    682	
>    683		rcu_read_lock();
>  > 684		ima_rules_tmp = rcu_dereference(ima_rules);
>    685		list_for_each_entry_rcu(entry, ima_rules_tmp, list) {
>    686	
>    687			if (!(entry->action & actmask))
>    688				continue;
>    689	
>    690			if (!ima_match_rules(entry, mnt_userns, inode, cred, secid,
>    691					     func, mask, func_data))
>    692				continue;
>    693	
>    694			action |= entry->flags & IMA_ACTION_FLAGS;
>    695	
>    696			action |= entry->action & IMA_DO_MASK;
>    697			if (entry->action & IMA_APPRAISE) {
>    698				action |= get_subaction(entry, func);
>    699				action &= ~IMA_HASH;
>    700				if (ima_fail_unverifiable_sigs)
>    701					action |= IMA_FAIL_UNVERIFIABLE_SIGS;
>    702	
>    703				if (allowed_algos &&
>    704				    entry->flags & IMA_VALIDATE_ALGOS)
>    705					*allowed_algos = entry->allowed_algos;
>    706			}
>    707	
>    708			if (entry->action & IMA_DO_MASK)
>    709				actmask &= ~(entry->action | entry->action << 1);
>    710			else
>    711				actmask &= ~(entry->action | entry->action >> 1);
>    712	
>    713			if ((pcr) && (entry->flags & IMA_PCR))
>    714				*pcr = entry->pcr;
>    715	
>    716			if (template_desc && entry->template)
>    717				*template_desc = entry->template;
>    718	
>    719			if (!actmask)
>    720				break;
>    721		}
>    722		rcu_read_unlock();
>    723	
>    724		return action;
>    725	}
>    726	
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

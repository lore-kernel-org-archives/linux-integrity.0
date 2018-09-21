Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from userp2130.oracle.com ([156.151.31.86]:51566 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727795AbeIUOWd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 21 Sep 2018 10:22:33 -0400
Date: Fri, 21 Sep 2018 11:34:29 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: kbuild@01.org, Nayna Jain <nayna@linux.vnet.ibm.com>
Cc: kbuild-all@01.org, linux-integrity@vger.kernel.org,
        zohar@linux.ibm.com, linux-security-module@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com, jforbes@redhat.com,
        Nayna Jain <nayna@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 3/6] ima: refactor ima_init_policy()
Message-ID: <20180921083429.c7sikis5bzxdifny@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180919075522.7684-4-nayna@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi Nayna,

Thank you for the patch! Perhaps something to improve:

url:    https://github.com/0day-ci/linux/commits/Nayna-Jain/Add-support-for-architecture-specific-IMA-policies/20180920-035110

smatch warnings:
security/integrity/ima/ima_policy.c:489 add_rules() warn: should this be a bitwise op?

# https://github.com/0day-ci/linux/commit/84a2e186f940ebc6c34e6d276e55f665167a5bb8
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 84a2e186f940ebc6c34e6d276e55f665167a5bb8
vim +489 security/integrity/ima/ima_policy.c

6f0911a6 Mimi Zohar 2018-04-12  477  
84a2e186 Nayna Jain 2018-09-19  478  static void add_rules(struct ima_rule_entry *entries, int count,
84a2e186 Nayna Jain 2018-09-19  479  		      enum policy_rule_list file)
84a2e186 Nayna Jain 2018-09-19  480  {
84a2e186 Nayna Jain 2018-09-19  481  	int i = 0;
84a2e186 Nayna Jain 2018-09-19  482  
84a2e186 Nayna Jain 2018-09-19  483  	for (i = 0; i < count; i++) {
84a2e186 Nayna Jain 2018-09-19  484  		struct ima_rule_entry *entry;
84a2e186 Nayna Jain 2018-09-19  485  
84a2e186 Nayna Jain 2018-09-19  486  		if (file && IMA_DEFAULT_POLICY)
                                                    ^^^^^^^^^^^^^^^^^^^^^^^^^^
84a2e186 Nayna Jain 2018-09-19  487  			list_add_tail(&entries[i].list, &ima_default_rules);
84a2e186 Nayna Jain 2018-09-19  488  
84a2e186 Nayna Jain 2018-09-19 @489  		if (file && IMA_CUSTOM_POLICY) {
                                                    ^^^^^^^^^^^^^^^^^^^^^^^^^

It does look like it should be "if (file & IMA_CUSTOM_POLICY) {" but I
haven't looked at the context besides what's here in this email.

84a2e186 Nayna Jain 2018-09-19  490  			entry = kmemdup(&entries[i], sizeof(*entry),
84a2e186 Nayna Jain 2018-09-19  491  					GFP_KERNEL);
84a2e186 Nayna Jain 2018-09-19  492  			if (!entry)
84a2e186 Nayna Jain 2018-09-19  493  				continue;
84a2e186 Nayna Jain 2018-09-19  494  
84a2e186 Nayna Jain 2018-09-19  495  			INIT_LIST_HEAD(&entry->list);
84a2e186 Nayna Jain 2018-09-19  496  			list_add_tail(&entry->list, &ima_policy_rules);
84a2e186 Nayna Jain 2018-09-19  497  		}
84a2e186 Nayna Jain 2018-09-19  498  		if (entries[i].action == APPRAISE)
84a2e186 Nayna Jain 2018-09-19  499  			temp_ima_appraise |= ima_appraise_flag(entries[i].func);
84a2e186 Nayna Jain 2018-09-19  500  		if (entries[i].func == POLICY_CHECK)
84a2e186 Nayna Jain 2018-09-19  501  			temp_ima_appraise |= IMA_APPRAISE_POLICY;
84a2e186 Nayna Jain 2018-09-19  502  	}
84a2e186 Nayna Jain 2018-09-19  503  }
84a2e186 Nayna Jain 2018-09-19  504  

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

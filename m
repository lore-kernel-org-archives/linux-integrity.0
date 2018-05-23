Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40852 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932646AbeEWPiD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 May 2018 11:38:03 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4NFTveC134545
        for <linux-integrity@vger.kernel.org>; Wed, 23 May 2018 11:38:03 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2j5852hsfm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 23 May 2018 11:38:02 -0400
Received: from localhost
        by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Wed, 23 May 2018 16:38:00 +0100
Subject: Re: [PATCH] IMA: use list_splice_tail_init_rcu() instead of its
 open coded variant
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Petko Manolov <petkan@nucleusys.com>
Cc: Linux Integrity <linux-integrity@vger.kernel.org>
Date: Wed, 23 May 2018 11:37:56 -0400
In-Reply-To: <20180522140655.GA5794@carbon>
References: <20180522140655.GA5794@carbon>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1527089876.3364.5.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi Petko,

On Tue, 2018-05-22 at 17:06 +0300, Petko Manolov wrote:

The patch description is missing.  Is the following ok?

Use list_splice_tail_init_rcu() to extend the existing custom IMA
policy with additional IMA policy rules.

Mimi

> 
> Signed-off-by: Petko Manolov <petko.manolov@konsulko.com>
> ---
>  security/integrity/ima/ima_policy.c | 17 ++---------------
>  1 file changed, 2 insertions(+), 15 deletions(-)
> 
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index d89bebf85421..722466f843ef 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -509,22 +509,9 @@ int ima_check_policy(void)
>   */
>  void ima_update_policy(void)
>  {
> -	struct list_head *first, *last, *policy;
> +	struct list_head *policy = &ima_policy_rules;
> 
> -	/* append current policy with the new rules */
> -	first = (&ima_temp_rules)->next;
> -	last = (&ima_temp_rules)->prev;
> -	policy = &ima_policy_rules;
> -
> -	synchronize_rcu();
> -
> -	last->next = policy;
> -	rcu_assign_pointer(list_next_rcu(policy->prev), first);
> -	first->prev = policy->prev;
> -	policy->prev = last;
> -
> -	/* prepare for the next policy rules addition */
> -	INIT_LIST_HEAD(&ima_temp_rules);
> +	list_splice_tail_init_rcu(&ima_temp_rules, policy, synchronize_rcu);
> 
>  	if (ima_rules != policy) {
>  		ima_policy_flag = 0;

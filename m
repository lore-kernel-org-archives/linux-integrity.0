Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from sonic310-20.consmr.mail.bf2.yahoo.com ([74.6.135.194]:44561
        "EHLO sonic310-20.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751668AbeCVTGA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 22 Mar 2018 15:06:00 -0400
Subject: Re: [PATCH] ima: Add smackfs to the default appraise/measure list
To: Martin Townsend <mtownsend1973@gmail.com>,
        zohar@linux.vnet.ibm.com, dmitry.kasatkin@gmail.com,
        jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <1521726361-29916-1-git-send-email-mtownsend1973@gmail.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <8d00361b-92ef-1fc6-fb2c-2316666dfbd3@schaufler-ca.com>
Date: Thu, 22 Mar 2018 12:05:51 -0700
MIME-Version: 1.0
In-Reply-To: <1521726361-29916-1-git-send-email-mtownsend1973@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 3/22/2018 6:46 AM, Martin Townsend wrote:
> This is required to use SMACK and IMA/EVM together. Add it to the
> default nomeasure/noappraise list like other pseudo filesystems.
>
> Signed-off-by: Martin Townsend <mtownsend1973@gmail.com>

Acked-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>  security/integrity/ima/ima_policy.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 915f557..d89ed15 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -96,6 +96,7 @@ static struct ima_rule_entry dont_measure_rules[] __ro_after_init = {
>  	{.action = DONT_MEASURE, .fsmagic = BINFMTFS_MAGIC, .flags = IMA_FSMAGIC},
>  	{.action = DONT_MEASURE, .fsmagic = SECURITYFS_MAGIC, .flags = IMA_FSMAGIC},
>  	{.action = DONT_MEASURE, .fsmagic = SELINUX_MAGIC, .flags = IMA_FSMAGIC},
> +	{.action = DONT_MEASURE, .fsmagic = SMACK_MAGIC, .flags = IMA_FSMAGIC},
>  	{.action = DONT_MEASURE, .fsmagic = CGROUP_SUPER_MAGIC,
>  	 .flags = IMA_FSMAGIC},
>  	{.action = DONT_MEASURE, .fsmagic = CGROUP2_SUPER_MAGIC,
> @@ -141,6 +142,7 @@ static struct ima_rule_entry default_appraise_rules[] __ro_after_init = {
>  	{.action = DONT_APPRAISE, .fsmagic = BINFMTFS_MAGIC, .flags = IMA_FSMAGIC},
>  	{.action = DONT_APPRAISE, .fsmagic = SECURITYFS_MAGIC, .flags = IMA_FSMAGIC},
>  	{.action = DONT_APPRAISE, .fsmagic = SELINUX_MAGIC, .flags = IMA_FSMAGIC},
> +	{.action = DONT_APPRAISE, .fsmagic = SMACK_MAGIC, .flags = IMA_FSMAGIC},
>  	{.action = DONT_APPRAISE, .fsmagic = NSFS_MAGIC, .flags = IMA_FSMAGIC},
>  	{.action = DONT_APPRAISE, .fsmagic = CGROUP_SUPER_MAGIC, .flags = IMA_FSMAGIC},
>  	{.action = DONT_APPRAISE, .fsmagic = CGROUP2_SUPER_MAGIC, .flags = IMA_FSMAGIC},

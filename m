Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33912 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751753AbeCVTo0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 22 Mar 2018 15:44:26 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2MJexIb133163
        for <linux-integrity@vger.kernel.org>; Thu, 22 Mar 2018 15:44:26 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2gvfgg888y-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 22 Mar 2018 15:44:25 -0400
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Thu, 22 Mar 2018 19:44:21 -0000
Subject: Re: [PATCH] ima: Add smackfs to the default appraise/measure list
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Casey Schaufler <casey@schaufler-ca.com>,
        Martin Townsend <mtownsend1973@gmail.com>,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date: Thu, 22 Mar 2018 15:44:15 -0400
In-Reply-To: <8d00361b-92ef-1fc6-fb2c-2316666dfbd3@schaufler-ca.com>
References: <1521726361-29916-1-git-send-email-mtownsend1973@gmail.com>
         <8d00361b-92ef-1fc6-fb2c-2316666dfbd3@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1521747855.3848.274.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, 2018-03-22 at 12:05 -0700, Casey Schaufler wrote:
> On 3/22/2018 6:46 AM, Martin Townsend wrote:
> > This is required to use SMACK and IMA/EVM together. Add it to the
> > default nomeasure/noappraise list like other pseudo filesystems.
> >
> > Signed-off-by: Martin Townsend <mtownsend1973@gmail.com>
> 
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>

Thanks!

Mimi
> 
> > ---
> >  security/integrity/ima/ima_policy.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> > index 915f557..d89ed15 100644
> > --- a/security/integrity/ima/ima_policy.c
> > +++ b/security/integrity/ima/ima_policy.c
> > @@ -96,6 +96,7 @@ static struct ima_rule_entry dont_measure_rules[] __ro_after_init = {
> >  	{.action = DONT_MEASURE, .fsmagic = BINFMTFS_MAGIC, .flags = IMA_FSMAGIC},
> >  	{.action = DONT_MEASURE, .fsmagic = SECURITYFS_MAGIC, .flags = IMA_FSMAGIC},
> >  	{.action = DONT_MEASURE, .fsmagic = SELINUX_MAGIC, .flags = IMA_FSMAGIC},
> > +	{.action = DONT_MEASURE, .fsmagic = SMACK_MAGIC, .flags = IMA_FSMAGIC},
> >  	{.action = DONT_MEASURE, .fsmagic = CGROUP_SUPER_MAGIC,
> >  	 .flags = IMA_FSMAGIC},
> >  	{.action = DONT_MEASURE, .fsmagic = CGROUP2_SUPER_MAGIC,
> > @@ -141,6 +142,7 @@ static struct ima_rule_entry default_appraise_rules[] __ro_after_init = {
> >  	{.action = DONT_APPRAISE, .fsmagic = BINFMTFS_MAGIC, .flags = IMA_FSMAGIC},
> >  	{.action = DONT_APPRAISE, .fsmagic = SECURITYFS_MAGIC, .flags = IMA_FSMAGIC},
> >  	{.action = DONT_APPRAISE, .fsmagic = SELINUX_MAGIC, .flags = IMA_FSMAGIC},
> > +	{.action = DONT_APPRAISE, .fsmagic = SMACK_MAGIC, .flags = IMA_FSMAGIC},
> >  	{.action = DONT_APPRAISE, .fsmagic = NSFS_MAGIC, .flags = IMA_FSMAGIC},
> >  	{.action = DONT_APPRAISE, .fsmagic = CGROUP_SUPER_MAGIC, .flags = IMA_FSMAGIC},
> >  	{.action = DONT_APPRAISE, .fsmagic = CGROUP2_SUPER_MAGIC, .flags = IMA_FSMAGIC},
> 

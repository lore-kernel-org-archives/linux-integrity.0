Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41838 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726060AbeI1HM6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 28 Sep 2018 03:12:58 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8S0nJiH005997
        for <linux-integrity@vger.kernel.org>; Thu, 27 Sep 2018 20:51:56 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ms610r1nc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 27 Sep 2018 20:51:55 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 28 Sep 2018 01:51:54 +0100
Subject: Re: [PATCH v4 3/6] ima: refactor ima_init_policy()
From: Mimi Zohar <zohar@linux.ibm.com>
To: Nayna Jain <nayna@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        jforbes@redhat.com
Date: Thu, 27 Sep 2018 20:51:38 -0400
In-Reply-To: <20180926122210.14642-4-nayna@linux.vnet.ibm.com>
References: <20180926122210.14642-1-nayna@linux.vnet.ibm.com>
         <20180926122210.14642-4-nayna@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1538095898.3459.140.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi Nayna,

On Wed, 2018-09-26 at 17:52 +0530, Nayna Jain wrote:

> +static void add_rules(struct ima_rule_entry *entries, int count,
> +		      enum policy_rule_list file)

Using "file" to refer to the policy_rule_list enumeration is unusual.
 Please change the variable name to something more appropriate.

Mimi

> +{
> +	int i = 0;
> +
> +	for (i = 0; i < count; i++) {
> +		struct ima_rule_entry *entry;
> +
> +		if (file & IMA_DEFAULT_POLICY)
> +			list_add_tail(&entries[i].list, &ima_default_rules);
> +
> +		if (file & IMA_CUSTOM_POLICY) {
> +			entry = kmemdup(&entries[i], sizeof(*entry),
> +					GFP_KERNEL);
> +			if (!entry)
> +				continue;
> +
> +			INIT_LIST_HEAD(&entry->list);
> +			list_add_tail(&entry->list, &ima_policy_rules);
> +		}
> +		if (entries[i].action == APPRAISE)
> +			temp_ima_appraise |= ima_appraise_flag(entries[i].func);
> +		if (entries[i].func == POLICY_CHECK)
> +			temp_ima_appraise |= IMA_APPRAISE_POLICY;
> +	}
> +}
> +

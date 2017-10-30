Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48328 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932189AbdJ3PzM (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Oct 2017 11:55:12 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1508774387.3639.128.camel@linux.vnet.ibm.com>
References: <1508774387.3639.128.camel@linux.vnet.ibm.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: dhowells@redhat.com,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Matthew Garrett <mjg59@google.com>,
        linux-security-module <linux-security-module@vger.kernel.org>
Subject: Re: [RFC PATCH] ima: require secure_boot rules in lockdown mode
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Mon, 30 Oct 2017 15:55:10 +0000
Message-ID: <750.1509378910@warthog.procyon.org.uk>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

I've added this into my series as the third patch, but:

Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:

> +			ima_use_appraise_tcb = TRUE;

Did you mean "true" rather than "TRUE"?

> +			entry = kzalloc(sizeof(*entry), GFP_KERNEL);
> +			if (entry) {
> +				memcpy(entry, &secure_boot_rules[i],
> +				       sizeof(*entry));

kmemdup()?

I guess also that oopsing is okay if the allocation fails.  We've run out of
memory during early boot, after all.

> +				INIT_LIST_HEAD(&entry->list);
> +				list_add_tail(&entry->list, &ima_policy_rules);

Isn't the init redundant, given the following line?

David

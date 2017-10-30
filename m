Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60158 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932348AbdJ3RAe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Oct 2017 13:00:34 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9UGxSqr028521
        for <linux-integrity@vger.kernel.org>; Mon, 30 Oct 2017 13:00:33 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2dx6n5vv7k-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 30 Oct 2017 13:00:32 -0400
Received: from localhost
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 30 Oct 2017 17:00:31 -0000
Subject: Re: [RFC PATCH] ima: require secure_boot rules in lockdown mode
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: David Howells <dhowells@redhat.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        Matthew Garrett <mjg59@google.com>,
        linux-security-module <linux-security-module@vger.kernel.org>
Date: Mon, 30 Oct 2017 13:00:27 -0400
In-Reply-To: <750.1509378910@warthog.procyon.org.uk>
References: <1508774387.3639.128.camel@linux.vnet.ibm.com>
         <750.1509378910@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1509382827.3583.143.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, 2017-10-30 at 15:55 +0000, David Howells wrote:
> I've added this into my series as the third patch, but:
> 
> Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> 
> > +			ima_use_appraise_tcb = TRUE;
> 
> Did you mean "true" rather than "TRUE"?

Yes, of course.  Commit 9f4b6a254d7a "ima: Fix bool
initialization/comparison" already addresses it.  Please remove it
from this patch.

> 
> > +			entry = kzalloc(sizeof(*entry), GFP_KERNEL);
> > +			if (entry) {
> > +				memcpy(entry, &secure_boot_rules[i],
> > +				       sizeof(*entry));
> 
> kmemdup()?

Probably

> 
> I guess also that oopsing is okay if the allocation fails.  We've run out of
> memory during early boot, after all.

If the memory allocation fails, the "secure_boot" policy will not be
enabled for custom policies, but how is that "oopsing".  If it fails,
there needs to be some indication of the failure, which there
currently isn't.  Perhaps also prevent loading a custom policy.

> 
> > +				INIT_LIST_HEAD(&entry->list);
> > +				list_add_tail(&entry->list, &ima_policy_rules);
> 
> Isn't the init redundant, given the following line?

ok

Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54966 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751112AbeERMxf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 18 May 2018 08:53:35 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4ICi9OZ050492
        for <linux-integrity@vger.kernel.org>; Fri, 18 May 2018 08:53:34 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2j1v4hgj4t-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 18 May 2018 08:53:34 -0400
Received: from localhost
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Fri, 18 May 2018 13:53:32 +0100
Subject: Re: [PATCH] audit: add containerid support for IMA-audit
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Richard Guy Briggs <rgb@redhat.com>
Cc: containers@lists.linux-foundation.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, paul@paul-moore.com,
        sgrubb@redhat.com
Date: Fri, 18 May 2018 08:53:16 -0400
In-Reply-To: <86df5c2c-9db3-21b9-b91b-30a4f53f9504@linux.vnet.ibm.com>
References: <1520257393.10396.291.camel@linux.vnet.ibm.com>
         <20180305135008.po6lheqnmkqqo6q4@madcap2.tricolour.ca>
         <1520259854.10396.313.camel@linux.vnet.ibm.com>
         <20180308112104.z67wohdvjqemy7wy@madcap2.tricolour.ca>
         <efb6c164-febe-67bb-43a9-795476c4902f@linux.vnet.ibm.com>
         <20180517213001.62caslkjwv575xgl@madcap2.tricolour.ca>
         <86df5c2c-9db3-21b9-b91b-30a4f53f9504@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1526647996.3632.164.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2018-05-18 at 07:49 -0400, Stefan Berger wrote:
> On 05/17/2018 05:30 PM, Richard Guy Briggs wrote:

[...]

> >>> auxiliary record either by being converted to a syscall auxiliary record
> >>> by using current->audit_context rather than NULL when calling
> >>> audit_log_start(), or creating a local audit_context and calling
> >> ima_parse_rule() is invoked when setting a policy by writing it into
> >> /sys/kernel/security/ima/policy. We unfortunately don't have the
> >> current->audit_context in this case.
> > Sure you do.  What process writes to that file?  That's the one we care
> > about, unless it is somehow handed off to a queue and processed later in
> > a different context.
> 
> I just printk'd it again. current->audit_context is NULL in this case.

The builtin policy rules are loaded at __init.  Subsequently a custom
policy can replace the builtin policy rules by writing to the
securityfs file.  Is the audit_context NULL in both cases?



> >> If so, which ones? We could probably refactor the current
> >> integrity_audit_message() and have ima_parse_rule() call into it to get
> >> those fields as well. I suppose adding new fields to it wouldn't be
> >> considered breaking user space?
> > Changing the order of existing fields or inserting fields could break
> > stuff and is strongly discouraged without a good reason, but appending
> > fields is usually the right way to add information.
> >
> > There are exceptions, and in this case, I'd pick the "more standard" of
> > the formats for AUDIT_INTEGRITY_RULE (ima_audit_measurement?) and stick
> > with that, abandoning the other format, renaming the less standard
> > version of the record (ima_parse_rule?) and perhpas adopting that
> > abandonned format for the new record type while using
> > current->audit_context.

This sounds right, other than "type=INTEGRITY_RULE" (1805) for
ima_audit_measurement().  Could we rename type=1805 to be
INTEGRITY_AUDIT or INTEGRITY_IMA_AUDIT?  The new type=1806 audit
message could be named INTEGRITY_RULE or, if that would be confusing,
INTEGRITY_POLICY_RULE.


> 1806 would be in sync with INTEGRITY_RULE now for process related info. 
> If this looks good, I'll remove the dependency on your local context 
> creation and post the series.
> 
> The justification for the change is that the INTEGRITY_RULE, as produced 
> by ima_parse_rule(), is broken.

Post which series?  The IMA namespacing patch set?  This change should
be upstreamed independently of IMA namespacing.

Mimi

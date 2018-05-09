Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42430 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S935397AbeEIPab (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 9 May 2018 11:30:31 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w49FIRWX117390
        for <linux-integrity@vger.kernel.org>; Wed, 9 May 2018 11:30:31 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2hv34wte98-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 09 May 2018 11:30:30 -0400
Received: from localhost
        by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Wed, 9 May 2018 16:30:29 +0100
Subject: Re: [PATCH V3 2/2] EVM: Allow runtime modification of the set of
 verified xattrs
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthew Garrett <mjg59@google.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>
Date: Wed, 09 May 2018 11:00:05 -0400
In-Reply-To: <CACdnJusHQvBk3rO1DqOr=XyeKZkmFqq+HM9HUO7whvUVG9yxYw@mail.gmail.com>
References: <20180501175124.192587-1-mjg59@google.com>
         <20180501175124.192587-2-mjg59@google.com>
         <1525317430.3238.58.camel@linux.vnet.ibm.com>
         <CACdnJuvUze0GSmQcnyFi_3vGEPoEgavrF9WhFoDpmHSni3FwEA@mail.gmail.com>
         <1525815782.3551.86.camel@linux.vnet.ibm.com>
         <CACdnJusHQvBk3rO1DqOr=XyeKZkmFqq+HM9HUO7whvUVG9yxYw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1525878005.3551.223.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, 2018-05-08 at 22:51 +0000, Matthew Garrett wrote:
> On Tue, May 8, 2018 at 2:43 PM Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> 
> > On Tue, 2018-05-08 at 21:30 +0000, Matthew Garrett wrote:
> > > As far as I can tell the VFS doesn't do that, and I wouldn't put it past
> > > someone to use UTF-8 at some point...
> 
> > The audit subsystem uses audit_log_untrustedstrings() to check for
> > control characters.  I'm not sure what should be included, but not
> > checking userspace strings doesn't sound right.
> 
> As far as I can tell it's legitimate for xattr names to include control
> characters. I can't think of /why/ someone would do that, but...
> 
> > > I think a config option would make sense here. Locking doesn't seem
> > > unreasonable, but I'm not sure what the threat model would really be -
> > > adding new xattrs would only result in additional signatures validating
> if
> > > they were signed with a trusted key in the first place.
> 
> > Remember adding additional EVM xattrs isn't limited to just EVM
> > signatures, but for the original EVM HMAC as well.  Did you want to
> > limit it to the EVM portable & immutable signatures?
> 
> If you add entries and then signatures are created you'll end up with
> signatures that won't validate on next boot until the same attributes are
> added. That feels at worst like root being able to trigger a DoS, which
> they'd be able to do by tampering with the signatures via the raw device
> node anyway.

With a system with EVM HMAC enabled and an "ima_policy=appraise_tcb"
policy, which appraises all executables and files owned by root, any
new xattrs would cause the EVM HMAC to be recalculated immediately.
 On boot, if any of these files are accessed prior to the additional
xattrs are added, it could cause the system not to boot properly.

True in both cases it is a DoS, but there is a difference between
accessing the raw device and normal usage.

Adding support for additional xattr names is fine.  Making it a
Kconfig option is required.  Being able to lock adding additional
 xattr names should also be required.

Mimi

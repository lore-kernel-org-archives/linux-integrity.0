Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45276 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751942AbdKCTQM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Nov 2017 15:16:12 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vA3JDb09117564
        for <linux-integrity@vger.kernel.org>; Fri, 3 Nov 2017 15:16:11 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2e0xbkratt-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 03 Nov 2017 15:16:11 -0400
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Fri, 3 Nov 2017 19:16:09 -0000
Subject: Re: [PATCH V3] EVM: Allow userland to permit modification of
 EVM-protected metadata
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthew Garrett <mjg59@google.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>
Date: Fri, 03 Nov 2017 15:16:06 -0400
In-Reply-To: <CACdnJusn8c-8GMX3iY+6xsOGu6uNKQAMr_begLLTp13_p_bdPw@mail.gmail.com>
References: <20171102221005.10190-1-mjg59@google.com>
         <1509725025.3416.73.camel@linux.vnet.ibm.com>
         <CACdnJusn8c-8GMX3iY+6xsOGu6uNKQAMr_begLLTp13_p_bdPw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1509736566.3416.97.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2017-11-03 at 11:49 -0700, Matthew Garrett wrote:
> On Fri, Nov 3, 2017 at 9:03 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> > On Thu, 2017-11-02 at 15:10 -0700, Matthew Garrett wrote:
> >> -             1: enable HMAC validation and creation
> >> -             2: enable digital signature validation
> >> -             3: enable HMAC and digital signature validation and HMAC
> >> -                creation
> >> +             Bit       Effect
> >> +             0         Enable HMAC validation and creation
> >
> > The code and documentation do not seem to be in sync.  Dracut is
> > currently using 1 to indicate the HMAC key has been loaded.
> 
> I've changed from describing the raw values to the bits they
> correspond to, so bit 0 corresponds to a value of 1. I can switch back
> to describing the raw values instead?

Ok, bits are fine.

> >>
> >> +     /* Policy permits modification of the protected attrs */
> >
> > Could we indicate that there is no HMAC key loaded.

Just as a reminder in the comment.

> In the comment, or in kernel output?
> >> +     /* Don't allow a request to freshly enable metadata writes if
> >> +      * keys are loaded.
> >> +      */
> >> +     if ((i & EVM_ALLOW_METADATA_WRITES) &&
> >> +         ((evm_initialized & EVM_KEY_MASK) != 0) &&
> >> +         !(evm_initialized & EVM_ALLOW_METADATA_WRITES))
> >
> > Ok, not sure that the "(evm_initialized & EVM_ALLOW_METADATA_WRITES)"
> > is needed, but it doesn't hurt.
> 
> Goal here was to allow:
> 
> echo 6 >evm
> echo 7 >evm
> 
> t work without an error, but I guess that's not a big deal.
> 
That's fine.

Thanks!

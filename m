Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40120 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751428AbeAYNDD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Jan 2018 08:03:03 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w0PCxM1S101170
        for <linux-integrity@vger.kernel.org>; Thu, 25 Jan 2018 08:03:03 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2fqfe00x6a-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 25 Jan 2018 08:03:01 -0500
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Thu, 25 Jan 2018 13:02:59 -0000
Subject: Re: [PATCH V6 1/2] security: Add a cred_getsecid hook
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthew Garrett <mjg59@google.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        James Morris <james.l.morris@oracle.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov,
        LSM List <linux-security-module@vger.kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Date: Thu, 25 Jan 2018 08:02:53 -0500
In-Reply-To: <CACdnJutphETV-aGj9QTN0Z=VyQYod9R7=HjQSrXDVL2ASQfOzA@mail.gmail.com>
References: <20180108213620.170042-1-mjg59@google.com>
         <CACdnJuutxPpzr4DPaJLuffHCcMWQN_22dA6wzxMQq3XR2R6+Gg@mail.gmail.com>
         <8b7f9729-af09-a59e-0cd0-8db58d82ea56@schaufler-ca.com>
         <CACdnJutphETV-aGj9QTN0Z=VyQYod9R7=HjQSrXDVL2ASQfOzA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1516885373.3751.52.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, 2018-01-25 at 11:58 +1100, Matthew Garrett wrote:
> On Mon, Jan 22, 2018 at 5:14 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> > On 1/21/2018 9:27 PM, Matthew Garrett wrote:
> >> On Tue, Jan 9, 2018 at 8:36 AM, Matthew Garrett <mjg59@google.com> wrote:
> >>> For IMA purposes, we want to be able to obtain the prepared secid in the
> >>> bprm structure before the credentials are committed. Add a cred_getsecid
> >>> hook that makes this possible.
> >> Any feedback on this version of the set?
> >
> >
> > Sorry for the delay. I'm having a mindset crisis on secids just
> > now, and I'm not completely sure if I have any issue with this
> > particular hook. Don't wait for me. If everyone else is OK with
> > it, go ahead.
> 
> Thanks Casey - Mimi, are you ok with the IMA changes? If so, which
> tree should these go through?

The IMA patch needs to be upstreamed via the IMA tree, but the only
additional IMA patches being upstreamed for 4.16, at this point, are
bug fixes.

Sorry, I'm only getting back to this now.  Assuming all is good with
the patch, I'll queue it for after resync'ing with ~4.16.0-rc2.

thanks,

Mimi

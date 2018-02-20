Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:23089 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751763AbeBTO5e (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Feb 2018 09:57:34 -0500
Message-ID: <1519138649.26293.1.camel@linux.intel.com>
Subject: Re: [PATCH 1/2 v3] tpm: cmd_ready command can be issued only after
 granting locality
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: "Winkler, Tomas" <tomas.winkler@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Tue, 20 Feb 2018 16:57:29 +0200
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B942240B1@hasmsx108.ger.corp.intel.com>
References: <20180214134319.4400-1-tomas.winkler@intel.com>
         <20180214134319.4400-2-tomas.winkler@intel.com>
         <20180219112700.yfoywzegqzrpynlk@linux.intel.com>
         <5B8DA87D05A7694D9FA63FD143655C1B942240B1@hasmsx108.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, 2018-02-19 at 11:43 +0000, Winkler, Tomas wrote:
> > All local variable declarations must be in the beginning of the
> > function.
>
> Who says?

It is coherent how we have everything else.

It is much easier to see the stack allocation this way when the
allocation is only done in the beginning of each function. If
you really need to do such pattern, then it would be a better
idea to consider an additional helper function.

> > Your comment about not overriding error code is incorrect.
>
> Please explain?

'l_rc' overrides 'rc' in the case when both are non-zero.

> > The value of 'rc' should be never overridden, which kind of
> > supports to "just
> > print" behavior that we had for a locality error.
>
> You are not consistent, you've agreed with propagating it to user
> space.  The error will  be propagated in case of an error in
> locality relinquish the device is pretty much in non functional
> state and provious errors do not matter much, but rc value won't
> be modified if locality_reliquish succeeds.

Well, sometimes you fail to notice things and I failed to notice the
collision above. The commit message does not describe why 'l_rc'
overrides 'rc' in the case when both are non-zero. What was the
reasoning, which made you end up with this priority order?  Why is
'l_rc' more important than 'rc'?

My take is that does it really make sense have this change as part
of a high priority bug fix that should be as localized as possible?
Seems like a non-trivial problem by itself.

/Jarkko

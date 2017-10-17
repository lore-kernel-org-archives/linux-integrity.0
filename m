Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from smtp2.infineon.com ([217.10.52.18]:40025 "EHLO
        smtp2.infineon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756918AbdJQPWY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 Oct 2017 11:22:24 -0400
From: <Alexander.Steffen@infineon.com>
To: <zohar@linux.vnet.ibm.com>
CC: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <andriy.shevchenko@linux.intel.com>,
        <elfring@users.sourceforge.net>, <linux-integrity@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>, <benh@kernel.crashing.org>,
        <clabbe.montjoie@gmail.com>, <jarkko.sakkinen@linux.intel.com>,
        <jgunthorpe@obsidianresearch.com>, <jsnitsel@redhat.com>,
        <kgold@linux.vnet.ibm.com>, <mpe@ellerman.id.au>,
        <nayna@linux.vnet.ibm.com>, <paulus@samba.org>,
        <PeterHuewe@gmx.de>, <stefanb@linux.vnet.ibm.com>
Subject: RE: [PATCH 3/4] char/tpm: Improve a size determination in nine
 functions
Date: Tue, 17 Oct 2017 15:22:22 +0000
Message-ID: <b22e3c64fde74876acacdee701a46223@infineon.com>
References: <1d3516a2-a8e6-9e95-d438-f115fac84c7f@users.sourceforge.net>
         <83a166af-aecc-649d-dfe3-a72245345209@users.sourceforge.net>
         <1508238182.16112.475.camel@linux.intel.com>
         <c8d37c0407a949c1abb35cfd79c17f58@infineon.com>
 <1508244757.4234.60.camel@linux.vnet.ibm.com>
In-Reply-To: <1508244757.4234.60.camel@linux.vnet.ibm.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

> On Tue, 2017-10-17 at 11:50 +0000, Alexander.Steffen@infineon.com
> wrote:
> > > > Replace the specification of data structures by pointer dereferences
> > > > as the parameter for the operator "sizeof" to make the corresponding
> > > > size
> > > > determination a bit safer according to the Linux coding style
> > > > convention.
> > >
> > >
> > > This patch does one style in favor of the other.
> >
> > I actually prefer that style, so I'd welcome this change :)
> 
> Style changes should be reviewed and documented, like any other code
> change, and added to Documentation/process/coding-style.rst or an
> equivalent file.
> 
> > > At the end it's Jarkko's call, though I would NAK this as I think some
> > > one already told this to you for some other similar patch(es).
> > >
> > >
> > > I even would suggest to stop doing this noisy stuff, which keeps people
> > > busy for nothing.
> >
> > Cleaning up old code is also worth something, even if does not
> > change one bit in the assembly output in the end...
> 
> Wow, you're opening the door really wide for all sorts of trivial
> changes!  Hope you have the time and inclination to review and comment
> on all of them.  I certainly don't.

Well, isn't the point of trivial changes that they are trivial to review? :) For things like that there is probably not even a need to run a test, though with sufficient automation that should not be a problem either.

> There is a major difference between adding these sorts of checks to
> the tools in the scripts directory or even to the zero day bots that
> catch different sorts of errors, BEFORE code is upstreamed, and
> patches like these, after the fact.

Catching those things early in the process is certainly preferable. But at some point you need to fix the existing code, or you'll end up with a mashup of different styles, just because you did not want to touch old code.

> After the code has been upstreamed, it is a lot more difficult to
> justify changes like this.  It impacts both code that is being
> developed AND backporting bug fixes.

Backporting could be an argument, but even that should not be allowed to block improvements indefinitely. I'd prefer a world in which the current code is nice and clean and easy to maintain, to a world where we never touch old code unless it is proven to be wrong.

But looking at the code in question, I cannot see how this should ever be a serious problem. Even when backporting a change takes now ten minutes instead of five, which means it is twice as hard, it is still not difficult.

Alexander

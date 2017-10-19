Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from smtp2.infineon.com ([217.10.52.18]:48048 "EHLO
        smtp2.infineon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751695AbdJSQ63 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Oct 2017 12:58:29 -0400
From: <Alexander.Steffen@infineon.com>
To: <jarkko.sakkinen@linux.intel.com>
CC: <andriy.shevchenko@linux.intel.com>,
        <elfring@users.sourceforge.net>, <linux-integrity@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>, <benh@kernel.crashing.org>,
        <clabbe.montjoie@gmail.com>, <jgunthorpe@obsidianresearch.com>,
        <jsnitsel@redhat.com>, <kgold@linux.vnet.ibm.com>,
        <mpe@ellerman.id.au>, <nayna@linux.vnet.ibm.com>,
        <paulus@samba.org>, <PeterHuewe@gmx.de>,
        <stefanb@linux.vnet.ibm.com>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH 3/4] char/tpm: Improve a size determination in nine
 functions
Date: Thu, 19 Oct 2017 16:58:23 +0000
Message-ID: <8afa2fb8d8704aff804cd8da15e931da@infineon.com>
References: <1d3516a2-a8e6-9e95-d438-f115fac84c7f@users.sourceforge.net>
 <83a166af-aecc-649d-dfe3-a72245345209@users.sourceforge.net>
 <1508238182.16112.475.camel@linux.intel.com>
 <c8d37c0407a949c1abb35cfd79c17f58@infineon.com>
 <20171018144811.klfmzikibuux77pf@linux.intel.com>
In-Reply-To: <20171018144811.klfmzikibuux77pf@linux.intel.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

> On Tue, Oct 17, 2017 at 11:50:05AM +0000, Alexander.Steffen@infineon.com
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
> >
> > > At the end it's Jarkko's call, though I would NAK this as I think some
> > > one already told this to you for some other similar patch(es).
> > >
> > >
> > > I even would suggest to stop doing this noisy stuff, which keeps people
> > > busy for nothing.
> >
> > Cleaning up old code is also worth something, even if does not change
> > one bit in the assembly output in the end...
> >
> > Alexander
> 
> Quite insignificant clean up it is that does more harm that gives any
> benefit as any new change adds debt to backporting.
> 
> Anyway, this has been a useful patch set for me in the sense that I have
> clearer picture now on discarding/accepting commits.

Indeed. I have now a better understanding for why some code looks as ugly as it does.

> One line minor
> clean up will be from now on automatic NAK unless it causes a compiler
> warning or some other visible side-effect.

Not a nice policy, but at least a policy. I have deleted the tasks that I had still planned for other cleanup activities.

Alexander

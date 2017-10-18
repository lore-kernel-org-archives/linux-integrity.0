Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from smtp2.infineon.com ([217.10.52.18]:31072 "EHLO
        smtp2.infineon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934288AbdJRJQQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Oct 2017 05:16:16 -0400
From: <Alexander.Steffen@infineon.com>
To: <julia.lawall@lip6.fr>, <zohar@linux.vnet.ibm.com>
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
Date: Wed, 18 Oct 2017 09:16:12 +0000
Message-ID: <9c1c9a5fa0ce4e978d0bd2571d88e57d@infineon.com>
References: <1d3516a2-a8e6-9e95-d438-f115fac84c7f@users.sourceforge.net>
         <83a166af-aecc-649d-dfe3-a72245345209@users.sourceforge.net>
         <1508238182.16112.475.camel@linux.intel.com>
         <c8d37c0407a949c1abb35cfd79c17f58@infineon.com>
         <1508244757.4234.60.camel@linux.vnet.ibm.com>
         <alpine.DEB.2.20.1710171456360.5035@hadrien>
 <1508253453.4234.81.camel@linux.vnet.ibm.com>
 <alpine.DEB.2.20.1710171725080.5035@hadrien>
In-Reply-To: <alpine.DEB.2.20.1710171725080.5035@hadrien>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

> On Tue, 17 Oct 2017, Mimi Zohar wrote:
> 
> > On Tue, 2017-10-17 at 14:58 +0200, Julia Lawall wrote:
> > >
> > > On Tue, 17 Oct 2017, Mimi Zohar wrote:
> > >
> > > > On Tue, 2017-10-17 at 11:50 +0000, Alexander.Steffen@infineon.com
> > > > wrote:
> > > > > > > Replace the specification of data structures by pointer
> dereferences
> > > > > > > as the parameter for the operator "sizeof" to make the
> corresponding
> > > > > > > size
> > > > > > > determination a bit safer according to the Linux coding style
> > > > > > > convention.
> > > > > >
> > > > > >
> > > > > > This patch does one style in favor of the other.
> > > > >
> > > > > I actually prefer that style, so I'd welcome this change :)
> > > >
> > > > Style changes should be reviewed and documented, like any other
> code
> > > > change, and added to Documentation/process/coding-style.rst or an
> > > > equivalent file.
> > >
> > > Actually, it has been there for many years:
> > >
> > > 14) Allocating memory
> > > ---------------------
> > > ...
> > > The preferred form for passing a size of a struct is the following:
> > >
> > > .. code-block:: c
> > >
> > > 	p = kmalloc(sizeof(*p), ...);
> > >
> > > The alternative form where struct name is spelled out hurts readability
> and
> > > introduces an opportunity for a bug when the pointer variable type is
> changed
> > > but the corresponding sizeof that is passed to a memory allocator is not.
> >
> > True, thanks for the reminder.  Is this common in new code?  Is there
> > a script/ or some other automated way of catching this usage before
> > patches are upstreamed?
> >
> > Just as you're doing here, the patch description should reference this
> > in the patch description.
> 
> The comment in the documentation seems have been there since Linux
> 2.6.14,
> ie 2005.  The fact that a lot of code still doesn't use that style, 12
> years later, suggests that actually it is not preferred, or not preferred
> by everyone.  Perhaps the paragraph in coding style should just be
> dropped.

Or maybe everyone just copied existing code, which did not follow that pattern, because nobody bothered to fix old code ;-)

(This is true at least for tpm_tis_spi, where I was involved in its creation.)

Alexander

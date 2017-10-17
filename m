Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:11453 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965967AbdJQThF (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 Oct 2017 15:37:05 -0400
Message-ID: <1508269017.16112.492.camel@linux.intel.com>
Subject: Re: char/tpm: Improve a size determination in nine functions
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: SF Markus Elfring <elfring@users.sourceforge.net>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Julia Lawall <julia.lawall@lip6.fr>,
        Alexander Steffen <Alexander.Steffen@infineon.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Kenneth Goldman <kgold@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nayna Jain <nayna@linux.vnet.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Peter =?ISO-8859-1?Q?H=FCwe?= <PeterHuewe@gmx.de>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 17 Oct 2017 22:36:57 +0300
In-Reply-To: <9689f036-ba9f-d23b-cf89-c289bc308771@users.sourceforge.net>
References: <1d3516a2-a8e6-9e95-d438-f115fac84c7f@users.sourceforge.net>
         <83a166af-aecc-649d-dfe3-a72245345209@users.sourceforge.net>
         <1508238182.16112.475.camel@linux.intel.com>
         <c8d37c0407a949c1abb35cfd79c17f58@infineon.com>
         <1508244757.4234.60.camel@linux.vnet.ibm.com>
         <alpine.DEB.2.20.1710171456360.5035@hadrien>
         <1508253453.4234.81.camel@linux.vnet.ibm.com>
         <9689f036-ba9f-d23b-cf89-c289bc308771@users.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, 2017-10-17 at 20:41 +0200, SF Markus Elfring wrote:
> > > 	p = kmalloc(sizeof(*p), ...);
> > > 
> > > The alternative form where struct name is spelled out hurts
> > > readability and
> > > introduces an opportunity for a bug when the pointer variable type
> > > is changed
> > > but the corresponding sizeof that is passed to a memory allocator
> > > is not.
> > 

> > before patches are upstreamed?
> 
> I imagine that a corresponding source code analysis variant could be
> applied
> in more cases if sufficient acceptance could be achieved.

So, then instead of still keeping people busy with this noise you better
start doing something like CI integration with that for *new* code?

I'm pretty sure you may also exercise your achievements on
drivers/staging where it would be honored.

Have you talked to Fengguang (0-day LKP)? Have you talked to Arnd (I
think he is related to kernel-ci)?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

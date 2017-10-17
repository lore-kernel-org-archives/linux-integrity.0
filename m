Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from smtp2.infineon.com ([217.10.52.18]:21662 "EHLO
        smtp2.infineon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932959AbdJQL7v (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 Oct 2017 07:59:51 -0400
From: <Alexander.Steffen@infineon.com>
To: <andriy.shevchenko@linux.intel.com>,
        <elfring@users.sourceforge.net>, <linux-integrity@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>, <benh@kernel.crashing.org>,
        <clabbe.montjoie@gmail.com>, <jarkko.sakkinen@linux.intel.com>,
        <jgunthorpe@obsidianresearch.com>, <jsnitsel@redhat.com>,
        <kgold@linux.vnet.ibm.com>, <mpe@ellerman.id.au>,
        <nayna@linux.vnet.ibm.com>, <paulus@samba.org>,
        <PeterHuewe@gmx.de>, <stefanb@linux.vnet.ibm.com>
CC: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH 3/4] char/tpm: Improve a size determination in nine
 functions
Date: Tue, 17 Oct 2017 11:50:05 +0000
Message-ID: <c8d37c0407a949c1abb35cfd79c17f58@infineon.com>
References: <1d3516a2-a8e6-9e95-d438-f115fac84c7f@users.sourceforge.net>
         <83a166af-aecc-649d-dfe3-a72245345209@users.sourceforge.net>
 <1508238182.16112.475.camel@linux.intel.com>
In-Reply-To: <1508238182.16112.475.camel@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

> > Replace the specification of data structures by pointer dereferences
> > as the parameter for the operator "sizeof" to make the corresponding
> > size
> > determination a bit safer according to the Linux coding style
> > convention.
> 
> 
> This patch does one style in favor of the other.

I actually prefer that style, so I'd welcome this change :)

> At the end it's Jarkko's call, though I would NAK this as I think some
> one already told this to you for some other similar patch(es).
> 
> 
> I even would suggest to stop doing this noisy stuff, which keeps people
> busy for nothing.

Cleaning up old code is also worth something, even if does not change one bit in the assembly output in the end...

Alexander

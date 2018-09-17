Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:47691 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728415AbeIRCwh (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 Sep 2018 22:52:37 -0400
Date: Tue, 18 Sep 2018 00:23:14 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Martin Galvan <omgalvan.86@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: Question about the TPM driver
Message-ID: <20180917212314.GF6716@linux.intel.com>
References: <CAN19L9EEYK+OpJSCw+nNv7fCjkS5eQeAXfy=51nfk=fBZne-BA@mail.gmail.com>
 <20180916191605.GB7473@linux.intel.com>
 <CAN19L9HFSkPfrRjDKZZiNXW+rXpV89v9ua1p_r4qmO8pQHfKiA@mail.gmail.com>
 <1537195532.4198.11.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1537195532.4198.11.camel@HansenPartnership.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, Sep 17, 2018 at 07:45:32AM -0700, James Bottomley wrote:
> On Mon, 2018-09-17 at 10:32 -0300, Martin Galvan wrote:
> > El dom., 16 sept. 2018 a las 16:16, Jarkko Sakkinen
> > (<jarkko.sakkinen@linux.intel.com>) escribio:
> > > I understand your concerns but without a concrete workload there is
> > > no
> > > problem with this behavior.
> > 
> > IMHO it's a bit excessive to allocate 4k to end up storing than 100
> > bytes. Beyond that, it's a pretty big gotcha for someone who's
> > writing software which talks to the driver :)
> 
> It's what we do in the kernel, which is one of our most memory
> constrained environments.
> 
> You have to remember that sub page size buffers aren't always managed
> the best at any level (they usually fragment the heap) so even in a
> constrained memory environment, a 4k buffer (4k aligned) is usually
> preferable.
> 
> James

If the commit is not too interfering I still could consider merging it as
even if only for simplifying implementing a TPM user space.

/Jarkko

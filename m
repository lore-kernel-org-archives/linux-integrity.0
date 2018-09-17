Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:47372 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727672AbeIRCtf (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 Sep 2018 22:49:35 -0400
Date: Tue, 18 Sep 2018 00:20:19 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Martin Galvan <omgalvan.86@gmail.com>
Cc: linux-integrity@vger.kernel.org
Subject: Re: Question about the TPM driver
Message-ID: <20180917212019.GE6716@linux.intel.com>
References: <CAN19L9EEYK+OpJSCw+nNv7fCjkS5eQeAXfy=51nfk=fBZne-BA@mail.gmail.com>
 <20180916191605.GB7473@linux.intel.com>
 <CAN19L9HFSkPfrRjDKZZiNXW+rXpV89v9ua1p_r4qmO8pQHfKiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAN19L9HFSkPfrRjDKZZiNXW+rXpV89v9ua1p_r4qmO8pQHfKiA@mail.gmail.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, Sep 17, 2018 at 10:32:18AM -0300, Martin Galvan wrote:
> El dom., 16 sept. 2018 a las 16:16, Jarkko Sakkinen
> (<jarkko.sakkinen@linux.intel.com>) escribio:
> > I understand your concerns but without a concrete workload there is no
> > problem with this behavior.
> 
> IMHO it's a bit excessive to allocate 4k to end up storing than 100
> bytes. Beyond that, it's a pretty big gotcha for someone who's writing
> software which talks to the driver :)

I remember now the patch from Tadeus. Yeah, it does make sense assuming
we can land a solution that does not cause ABI breaks.

/Jarkko

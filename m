Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:60668 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727021AbeIQUNM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 Sep 2018 16:13:12 -0400
Message-ID: <1537195532.4198.11.camel@HansenPartnership.com>
Subject: Re: Question about the TPM driver
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Martin Galvan <omgalvan.86@gmail.com>,
        jarkko.sakkinen@linux.intel.com
Cc: linux-integrity@vger.kernel.org
Date: Mon, 17 Sep 2018 07:45:32 -0700
In-Reply-To: <CAN19L9HFSkPfrRjDKZZiNXW+rXpV89v9ua1p_r4qmO8pQHfKiA@mail.gmail.com>
References: <CAN19L9EEYK+OpJSCw+nNv7fCjkS5eQeAXfy=51nfk=fBZne-BA@mail.gmail.com>
         <20180916191605.GB7473@linux.intel.com>
         <CAN19L9HFSkPfrRjDKZZiNXW+rXpV89v9ua1p_r4qmO8pQHfKiA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, 2018-09-17 at 10:32 -0300, Martin Galvan wrote:
> El dom., 16 sept. 2018 a las 16:16, Jarkko Sakkinen
> (<jarkko.sakkinen@linux.intel.com>) escribio:
> > I understand your concerns but without a concrete workload there is
> > no
> > problem with this behavior.
> 
> IMHO it's a bit excessive to allocate 4k to end up storing than 100
> bytes. Beyond that, it's a pretty big gotcha for someone who's
> writing software which talks to the driver :)

It's what we do in the kernel, which is one of our most memory
constrained environments.

You have to remember that sub page size buffers aren't always managed
the best at any level (they usually fragment the heap) so even in a
constrained memory environment, a 4k buffer (4k aligned) is usually
preferable.

James

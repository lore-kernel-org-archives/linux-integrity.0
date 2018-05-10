Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:40961 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965892AbeEJO3Q (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 May 2018 10:29:16 -0400
Received: by mail-wr0-f196.google.com with SMTP id g21-v6so2221511wrb.8
        for <linux-integrity@vger.kernel.org>; Thu, 10 May 2018 07:29:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180510014433.GM6190@linux.intel.com>
References: <20180430125418.31344-1-david.bild@xaptum.com> <20180504130022.5231-3-david.bild@xaptum.com>
 <20180504190638.ikqhdvcqccakzdjd@ziepe.ca> <CAAi9uDvyzk1vnQVXkJxRCATy85g4nwMLJjqu6rr1YZn9NV_TYw@mail.gmail.com>
 <20180508105515.GB6132@linux.intel.com> <1525793148.3672.8.camel@HansenPartnership.com>
 <CAAi9uDvgd5+d5fNbSGEeEVvdHLzwid6SqC0BVA3BPXkFWR4ooQ@mail.gmail.com> <20180510014433.GM6190@linux.intel.com>
From: "David R. Bild" <david.bild@xaptum.com>
Date: Thu, 10 May 2018 09:29:14 -0500
Message-ID: <CAAi9uDvHLhTYsao0LJH4jTfxufiC7W61S+9=gWOqByMrHrU+0w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] usb: misc: xapea00x: perform platform
 initialization of TPM
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
        philip.b.tricca@intel.com, Jason Gunthorpe <jgg@ziepe.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Huewe <peterhuewe@gmx.de>, linux-usb@vger.kernel.org,
        linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, May 9, 2018 at 8:44 PM, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
> On Tue, May 08, 2018 at 10:29:41AM -0500, David R. Bild wrote:
>> On Tue, May 8, 2018 at 10:25 AM, James Bottomley
>> <James.Bottomley@hansenpartnership.com> wrote:
>> >
>> > > On Fri, May 04, 2018 at 02:56:25PM -0500, David R. Bild wrote:
>> > [...]
>> > > > In particular, it sets the credentials for the platform hierarchy.
>> > > > The platform hierarchy is essentially the "root" account of the
>> > > > TPM, so it's critical that those credentials be set before the TPM
>> > > > is exposed to user-space.  (The platform credentials aren't
>> > > > persisted in the TPM and must be set by the platform on every
>> > > > boot.)  If the driver registers the TPM before doing
>> > > > initialization, there's a chance that something else could access
>> > > > the TPM before the platform credentials get set.
>> >
>
> Who is able to test these changes if we even consider pulling them?

I can send you and the other maintainers cards to test with. That's
dead simple.  (With a USB-A plug, not mini PCI-e, so you can plug it
into any computer.)

They won't have the Xaptum credentials pre-provisioned, and will just
function as normal TPMs.

> I do not have such a card so it will be hard to accept also given
> that it is more intrusive change than usual.

The current approach (the driver does all the initialization) requires
no changes to the TPM driver.  Only someone who buys our card will
ever run that code, so it doesn't impact anyone else.

Best,
David

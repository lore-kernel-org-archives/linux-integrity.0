Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54545 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935656AbeEJObI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 May 2018 10:31:08 -0400
Received: by mail-wm0-f67.google.com with SMTP id f6-v6so4248470wmc.4
        for <linux-integrity@vger.kernel.org>; Thu, 10 May 2018 07:31:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180510015938.GN6190@linux.intel.com>
References: <20180430125418.31344-1-david.bild@xaptum.com> <20180504130022.5231-3-david.bild@xaptum.com>
 <20180504190638.ikqhdvcqccakzdjd@ziepe.ca> <CAAi9uDvyzk1vnQVXkJxRCATy85g4nwMLJjqu6rr1YZn9NV_TYw@mail.gmail.com>
 <20180508105515.GB6132@linux.intel.com> <1525793148.3672.8.camel@HansenPartnership.com>
 <CAAi9uDvgd5+d5fNbSGEeEVvdHLzwid6SqC0BVA3BPXkFWR4ooQ@mail.gmail.com>
 <1525793785.3672.12.camel@HansenPartnership.com> <20180510015938.GN6190@linux.intel.com>
From: "David R. Bild" <david.bild@xaptum.com>
Date: Thu, 10 May 2018 09:31:07 -0500
Message-ID: <CAAi9uDtj=nFnk2=oqhJj_c8vEenDvT5eHKaFEDGSh+u-fxg9vw@mail.gmail.com>
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

On Wed, May 9, 2018 at 8:59 PM, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
> On Tue, May 08, 2018 at 08:36:25AM -0700, James Bottomley wrote:
>> Early boot means userspace. for a hot pluggable device, this would
>> probably be something in udev if you follow the no-daemon model and the
>> daemon could do it if you do follow the daemon model.
>>
>
> Could this be implemented as a first priority to daemon. If it turns out
> to be bad approach we can reconsider kernel. If we land it to kernel it
> is harder to take steps back.

Is the daemon an implementation of the TCG resource manager spec?

Best,
David

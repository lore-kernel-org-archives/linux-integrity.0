Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:46250 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752017AbeENUM0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 May 2018 16:12:26 -0400
Received: by mail-wr0-f196.google.com with SMTP id a12-v6so13612462wrn.13
        for <linux-integrity@vger.kernel.org>; Mon, 14 May 2018 13:12:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180514200834.GE21531@ziepe.ca>
References: <20180430125418.31344-1-david.bild@xaptum.com> <20180504130022.5231-3-david.bild@xaptum.com>
 <20180504190638.ikqhdvcqccakzdjd@ziepe.ca> <CAAi9uDvyzk1vnQVXkJxRCATy85g4nwMLJjqu6rr1YZn9NV_TYw@mail.gmail.com>
 <20180508105515.GB6132@linux.intel.com> <CAAi9uDtt=U_7uSVrxBkC_-ZLobU9WiA4UxuN0pJk18b0Rhv+Lg@mail.gmail.com>
 <20180514193157.GA21531@ziepe.ca> <CAAi9uDvwqFT_nrq1FLM7QiMhUXXLTE4fx7+3HpMXbgp1nW7gOg@mail.gmail.com>
 <20180514200834.GE21531@ziepe.ca>
From: "David R. Bild" <david.bild@xaptum.com>
Date: Mon, 14 May 2018 15:12:25 -0500
Message-ID: <CAAi9uDtnW8-rWAQZ927xvY4t3O2ES5pNfss1vyKzx10F8NcMAA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] usb: misc: xapea00x: perform platform
 initialization of TPM
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        philip.b.tricca@intel.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Huewe <peterhuewe@gmx.de>, linux-usb@vger.kernel.org,
        linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, May 14, 2018 at 3:08 PM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> On Mon, May 14, 2018 at 02:59:36PM -0500, David R. Bild wrote:
>> On Mon, May 14, 2018 at 2:31 PM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
 The driver can setup enough to use the TPM
>> > framework to send commands before completing registration. We use it
>> > in startup timeouts and other flows today.
>>
>>
>> That sounds perfect.  Can you point me to some usages in the code (or
>> relevant functions)?
>>
>
> Well, tpm_tis_core_init() does it
>
> Only the driver that calls tpm_chip_register() gets to use this
> capability, so you can't use "tpm_tis_spi" and the automatic binding
> if you need it.
>
> Looks like the spi binding and tpm_tis_core_init will need some gentle
> editing to allow a SPI based driver the same opportunity.

Thanks for the pointers.  I'll work with Peter to add this capability
for SPI drivers.

Best,
David

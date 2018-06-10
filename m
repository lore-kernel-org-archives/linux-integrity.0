Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:35046 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753900AbeFJL5f (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 10 Jun 2018 07:57:35 -0400
Received: by mail-io0-f193.google.com with SMTP id u4-v6so20822457iof.2
        for <linux-integrity@vger.kernel.org>; Sun, 10 Jun 2018 04:57:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180608155023.GA12577@ziepe.ca>
References: <20180608070209.14769-1-linus.walleij@linaro.org> <20180608155023.GA12577@ziepe.ca>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 10 Jun 2018 13:57:34 +0200
Message-ID: <CACRpkdbjBPpFFs7ggFOhUqrB0mrO=c79FNx3LZs7NQDNR+UAPw@mail.gmail.com>
Subject: Re: [PATCH] tpm_tis_spi: Pass the SPI IRQ down to the driver
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkine@linux.intel.com>,
        linux-integrity@vger.kernel.org, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Jun 8, 2018 at 5:50 PM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> On Fri, Jun 08, 2018 at 09:02:09AM +0200, Linus Walleij wrote:
>> An SPI TPM device managed directly on an embedded board using
>> the SPI bus and some GPIO or similar line as IRQ handler will
>> pass the IRQn from the TPM device associated with the SPI
>> device. This is already handled by the SPI core, so make sure
>> to pass this down to the core as well.
>>
>> (The TPM core habit of using -1 to signal no IRQ is dubious
>> (as IRQ 0 is NO_IRQ) but I do not want to mess with that
>> semantic in this patch.)
>
> Unless something has changed, there is no cross-arch constant called
> NO_IRQ, and the few arches that do define it, tend to use -1..

AFAIU the idea is that for archs that don't define it, it is implicitly
0.

I just refer to this, albeit it's been 7 years:
https://lwn.net/Articles/470820/

Yours,
Linus Walleij

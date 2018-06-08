Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-pl0-f67.google.com ([209.85.160.67]:36132 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751141AbeFHPu0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 8 Jun 2018 11:50:26 -0400
Received: by mail-pl0-f67.google.com with SMTP id a7-v6so6047783plp.3
        for <linux-integrity@vger.kernel.org>; Fri, 08 Jun 2018 08:50:26 -0700 (PDT)
Date: Fri, 8 Jun 2018 09:50:23 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkine@linux.intel.com>,
        linux-integrity@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] tpm_tis_spi: Pass the SPI IRQ down to the driver
Message-ID: <20180608155023.GA12577@ziepe.ca>
References: <20180608070209.14769-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180608070209.14769-1-linus.walleij@linaro.org>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Jun 08, 2018 at 09:02:09AM +0200, Linus Walleij wrote:
> An SPI TPM device managed directly on an embedded board using
> the SPI bus and some GPIO or similar line as IRQ handler will
> pass the IRQn from the TPM device associated with the SPI
> device. This is already handled by the SPI core, so make sure
> to pass this down to the core as well.
> 
> (The TPM core habit of using -1 to signal no IRQ is dubious
> (as IRQ 0 is NO_IRQ) but I do not want to mess with that
> semantic in this patch.)

Unless something has changed, there is no cross-arch constant called
NO_IRQ, and the few arches that do define it, tend to use -1..

Jason

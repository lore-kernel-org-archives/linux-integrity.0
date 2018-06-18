Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:35998 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935546AbeFRSI4 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 18 Jun 2018 14:08:56 -0400
Date: Mon, 18 Jun 2018 21:08:52 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] tpm_tis_spi: Pass the SPI IRQ down to the driver
Message-ID: <20180618180852.GC20697@linux.intel.com>
References: <20180608070907.15185-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180608070907.15185-1-linus.walleij@linaro.org>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Jun 08, 2018 at 09:09:07AM +0200, Linus Walleij wrote:
> An SPI TPM device managed directly on an embedded board using
> the SPI bus and some GPIO or similar line as IRQ handler will
> pass the IRQn from the TPM device associated with the SPI
> device. This is already handled by the SPI core, so make sure
> to pass this down to the core as well.
> 
> (The TPM core habit of using -1 to signal no IRQ is dubious
> (as IRQ 0 is NO_IRQ) but I do not want to mess with that
> semantic in this patch.)
> 
> Cc: Mark Brown <broonie@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko

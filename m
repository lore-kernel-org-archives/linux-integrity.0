Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C8FC433ED
	for <linux-integrity@archiver.kernel.org>; Tue, 27 Apr 2021 23:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D26861139
	for <linux-integrity@archiver.kernel.org>; Tue, 27 Apr 2021 23:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239429AbhD0Xyf (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 27 Apr 2021 19:54:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:35510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236805AbhD0Xyf (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Apr 2021 19:54:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B8260613C2;
        Tue, 27 Apr 2021 23:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619567631;
        bh=jZ19EiK9skSybp7j1AN/MwtGxlp4/wzv2VevVR1REHU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ajUIM8BSWPOPpXkp05FLSOSel/aMN0GcZu5zdY7V1Dn6NICZeVeFwRw2ZPXFwA9Qg
         8TsDHy42vbCjpCQL8llRtX7xEPOXzUdaOmVdmlKaRYgmlajbZSTpwyzLGUCzccyJWG
         7GPSsgDJF9n66rHvYw0w3QVRWwcPOdb95uB6/ao+tk0FIKL7zJtNO8QPYiuEbmyBSq
         P6xo22t2C133oH8akS/w8L4EFNp/kN2/RYvqJeBpQg6YN0XPuWoze30tzM+AUVf30E
         blyc/zij3X1QwmN89jKO9DEdGNHa17JTnGRAGZGveKrvRoiLzPuFHW94B6ZHQ2GT+J
         fgFQVNW82QQwQ==
Date:   Wed, 28 Apr 2021 02:53:48 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        James.Bottomley@hansenpartnership.com, keescook@chromium.org,
        jsnitsel@redhat.com, ml.linux@elloe.vision,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] tpm: Use a threaded interrupt handler
Message-ID: <YIikDCTBcMMxjots@kernel.org>
References: <1619394440-30646-1-git-send-email-LinoSanfilippo@gmx.de>
 <1619394440-30646-2-git-send-email-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1619394440-30646-2-git-send-email-LinoSanfilippo@gmx.de>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Apr 26, 2021 at 01:47:17AM +0200, Lino Sanfilippo wrote:
> Interrupt handling at least includes reading and writing the interrupt
> status register from the interrupt routine. However over SPI those accesses
> require a sleepable context, since a mutex is used in the concerning
> functions.
> For this reason request a threaded interrupt handler which is running in
> (sleepable) process context.
> 
> Signed-off-by: Lino Sanfilippo <LinoSanfilippo@gmx.de>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index e7d1eab..0959559 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -781,8 +781,10 @@ static int tpm_tis_probe_irq_single(struct tpm_chip *chip, u32 intmask,
>  	int rc;
>  	u32 int_status;
>  
> -	if (devm_request_irq(chip->dev.parent, irq, tis_int_handler, flags,
> -			     dev_name(&chip->dev), chip) != 0) {
> +
> +	if (devm_request_threaded_irq(chip->dev.parent, irq, NULL,
> +				      tis_int_handler, IRQF_ONESHOT | flags,
> +				      dev_name(&chip->dev), chip) != 0) {
>  		dev_info(&chip->dev, "Unable to request irq: %d for probe\n",
>  			 irq);
>  		return -1;
> -- 
> 2.7.4
> 

Why?

https://elixir.bootlin.com/linux/v5.12/source/drivers/char/tpm/tpm_tis_core.c#L670

I don't see anything that sleeps there.

/Jarkko1

Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:54898 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752322AbdKFRHo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Nov 2017 12:07:44 -0500
Received: by mail-io0-f195.google.com with SMTP id e89so16372027ioi.11
        for <linux-integrity@vger.kernel.org>; Mon, 06 Nov 2017 09:07:43 -0800 (PST)
Date: Mon, 6 Nov 2017 10:07:41 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Azhar Shaikh <azhar.shaikh@intel.com>
Cc: jarkko.sakkinen@intel.com, linux-integrity@vger.kernel.org
Subject: Re: [PATCH RFC] tpm: Keep CLKRUN enabled throughout the duration of
 transmit_cmd()
Message-ID: <20171106170741.GH26011@ziepe.ca>
References: <1509751809-148601-1-git-send-email-azhar.shaikh@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1509751809-148601-1-git-send-email-azhar.shaikh@intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Nov 03, 2017 at 04:30:09PM -0700, Azhar Shaikh wrote:
> @@ -413,6 +413,8 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
>  	if (chip->dev.parent)
>  		pm_runtime_get_sync(chip->dev.parent);
>  
> +	chip->ops->clk_toggle(chip, true);

You added this new op to the general code, but only updated two
drivers, surely this makes all the other tis drivers oops as
clk_toggle will be NULL?

Suggest checking for NULL before calling.
  
> +#ifdef CONFIG_X86

This is a good place to use IS_ENABLED instead of ifdef:

> +/**
> + * tpm_tis_clkrun_toggle() - Keep clkrun protocol disabled for entire duration
> + *                           of a single TPM command
> + * @chip:	TPM chip to use
> + * @value:	1 - Disable CLKRUN protocol, so that clocks are free running
> + *		0 - Enable CLKRUN protocol
> + */
> +static void tpm_tis_clkrun_toggle(struct tpm_chip *chip, bool value)
> +{
> +	struct tpm_tis_data *data = dev_get_drvdata(&chip->dev);

   if (!IS_ENABLED(CONFIG_X86))
         return;

> +
> +	if (value) {
> +		tpm_platform_begin_xfer(data);
> +		data->flags |= TPM_TIS_CLK_ENABLE;
> +	} else {
> +		data->flags &= ~TPM_TIS_CLK_ENABLE;
> +		tpm_platform_end_xfer(data);
> +	}
> +}
> +#else
> +static void tpm_tis_clkrun_toggle(struct tpm_chip *chip, bool value)
> +{
> +}
> +#endif

> +#ifdef CONFIG_X86
> +void tpm_platform_begin_xfer(struct tpm_tis_data *data);
> +void tpm_platform_end_xfer(struct tpm_tis_data *data);
> +#else
> +void tpm_platform_begin_xfer(struct tpm_tis_data *data)
> +{
> +}
> +void tpm_platform_end_xfer(struct tpm_tis_data *data)
> +{
> +}

These empty stubs need inlines

Why are you using a mixture of callbacks and linked functions to solve
this problem?

Can't you do everything with callbacks?

Jason

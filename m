Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-ot0-f195.google.com ([74.125.82.195]:44922 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933159AbeF2ISr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 29 Jun 2018 04:18:47 -0400
Received: by mail-ot0-f195.google.com with SMTP id w13-v6so9067563ote.11
        for <linux-integrity@vger.kernel.org>; Fri, 29 Jun 2018 01:18:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180629081258.155228-1-louiscollard@chromium.org>
References: <20180629081258.155228-1-louiscollard@chromium.org>
From: Louis Collard <louiscollard@chromium.org>
Date: Fri, 29 Jun 2018 16:18:46 +0800
Message-ID: <CAKNRAJWnDc1j1mmsRDe_jTCpNrc_mpSkR-8giBZJw2bQvGDRgQ@mail.gmail.com>
Subject: Re: [PATCH v2] tpm: Allow tpm_tis drivers to set hwrng quality.
To: linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Jun 29, 2018 at 4:12 PM, Louis Collard
<louiscollard@chromium.org> wrote:
> Adds plumbing required for drivers based on tpm_tis to set hwrng quality.
>
> Signed-off-by: Louis Collard <louiscollard@chromium.org>
> ---
> Changes since v1:
> - based on (hopefully!) correct git tree
>
>  drivers/char/tpm/tpm_tis_core.c | 2 ++
>  drivers/char/tpm/tpm_tis_core.h | 1 +
>  2 files changed, 3 insertions(+)
>
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 8b46aaa9e049..d2345d9fd7b5 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -875,6 +875,8 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>         chip->acpi_dev_handle = acpi_dev_handle;
>  #endif
>
> +       chip->hwrng.quality = priv->rng_quality;
> +
>         /* Maximum timeouts */
>         chip->timeout_a = msecs_to_jiffies(TIS_TIMEOUT_A_MAX);
>         chip->timeout_b = msecs_to_jiffies(TIS_TIMEOUT_B_MAX);
> diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
> index f6e1dbe212a7..f48125f1e6e0 100644
> --- a/drivers/char/tpm/tpm_tis_core.h
> +++ b/drivers/char/tpm/tpm_tis_core.h
> @@ -99,6 +99,7 @@ struct tpm_tis_data {
>         wait_queue_head_t int_queue;
>         wait_queue_head_t read_queue;
>         const struct tpm_tis_phy_ops *phy_ops;
> +       unsigned short rng_quality;
>  };
>
>  struct tpm_tis_phy_ops {
> --
> 2.13.5
>

So sorry for the double-send (and hope I am not making it worse by
sending this!)

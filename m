Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from g2t2352.austin.hpe.com ([15.233.44.25]:55968 "EHLO
        g2t2352.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751393AbdJCU54 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Oct 2017 16:57:56 -0400
Received: from G2W6310.americas.hpqcorp.net (g2w6310.austin.hp.com [16.197.64.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g2t2352.austin.hpe.com (Postfix) with ESMTPS id 6ABA6D4
        for <linux-integrity@vger.kernel.org>; Tue,  3 Oct 2017 20:57:55 +0000 (UTC)
From: "Magalhaes, Guilherme (Brazil R&D-CL)" <guilherme.magalhaes@hpe.com>
To: "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: RE: [PATCH] tpm: adjust command response sleep time for vTPM
Date: Tue, 3 Oct 2017 20:57:53 +0000
Message-ID: <TU4PR84MB03024132AA87A1D337E431E8FF720@TU4PR84MB0302.NAMPRD84.PROD.OUTLOOK.COM>
References: <20171003204640.62236-1-guilherme.magalhaes@hpe.com>
In-Reply-To: <20171003204640.62236-1-guilherme.magalhaes@hpe.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Additionally, see the chart at:
https://drive.google.com/file/d/0ByxwRmmxIzLYUm5WMm5BRmlkZWc/view?usp=sharing

The X axis represents the number of processes executing new file access 
(measurements) and Y axis represents the total number of extends performed. 
The red line represents the workload using vTPM without any adjustment in 
the response polling sleep time. The purple line is with vTPM now with the
polling sleep time adjustment.

The IMA hash table, which causes performance degradation as indicated in 
my previous email, was removed from IMA to run these experiments as well.

--
Guilherme

> -----Original Message-----
> From: Magalhaes, Guilherme (Brazil R&D-CL)
> Sent: terca-feira, 3 de outubro de 2017 17:47
> To: linux-integrity@vger.kernel.org
> Cc: Magalhaes, Guilherme (Brazil R&D-CL) <guilherme.magalhaes@hpe.com>
> Subject: [PATCH] tpm: adjust command response sleep time for vTPM
> 
> Once vTPM is actually a software, it is able to respond the commands much
> quicker than physical TPMs. What we propose is to adjust the response
> polling time to a usec value when the chip is detected as a vTPM.
> With this change, the kernel TPM interface identifies whether the chip is
> vTPM and on this case sets the polling sleep time to an optimized value.
> 
> The performance result was 12x improvement when comparing PCR extends
> using vTPM with the current sleep time and with the adjusted sleep time.
> ---
>  drivers/char/tpm/tpm-interface.c | 6 +++++-
>  drivers/char/tpm/tpm.h           | 2 ++
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-
> interface.c
> index 1d6729be4cd6..d213a3d4b305 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -455,7 +455,11 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct
> tpm_space *space,
>  			goto out;
>  		}
> 
> -		tpm_msleep(TPM_TIMEOUT);
> +		if (chip->flags & TPM_CHIP_FLAG_VIRTUAL)
> +			usleep_range(TPM_TIMEOUT_VTPM_US,
> TPM_TIMEOUT_VTPM_RANGE_US);
> +		else
> +			tpm_msleep(TPM_TIMEOUT);
> +
>  		rmb();
>  	} while (time_before(jiffies, stop));
> 
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 2d5466a72e40..02d2dd761543 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -50,6 +50,8 @@ enum tpm_const {
> 
>  enum tpm_timeout {
>  	TPM_TIMEOUT = 5,	/* msecs */
> +	TPM_TIMEOUT_VTPM_US = 1,	/* usecs */
> +	TPM_TIMEOUT_VTPM_RANGE_US = 5,	/* usecs */
>  	TPM_TIMEOUT_RETRY = 100, /* msecs */
>  	TPM_TIMEOUT_RANGE_US = 300	/* usecs */
>  };
> --
> 2.11.0

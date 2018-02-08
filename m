Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:61324 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750961AbeBHNeG (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 8 Feb 2018 08:34:06 -0500
Date: Thu, 8 Feb 2018 15:34:02 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-integrity@vger.kernel.org,
        Jeremy Boone <Jeremy.Boone@nccgroup.trust>
Subject: Re: [PATCH 1/2] tpm: fix potential buffer overruns caused by bit
 glitches on the bus
Message-ID: <20180208133402.xpszh2p5cpjnu6ki@linux.intel.com>
References: <1517592221.3137.18.camel@HansenPartnership.com>
 <1517592278.3137.19.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1517592278.3137.19.camel@HansenPartnership.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Feb 02, 2018 at 06:24:38PM +0100, James Bottomley wrote:
> From: Jeremy Boone <jeremy.boone@nccgroup.trust>
> 
> Discrete TPMs are often connected over slow serial buses which, on
> some platforms, can have glitches causing bit flips.  If a bit does
> flip it could cause an overrun if it's in one of the size parameters,
> so sanity check that we're not overrunning the provided buffer when
> doing a memcpy().
> 
> Signed-off-by: Jeremy Boone <jeremy.boone@nccgroup.trust>
> Cc: stable@vger.kernel.org
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> ---
>  drivers/char/tpm/tpm-interface.c | 1 +
>  drivers/char/tpm/tpm2-cmd.c      | 4 ++++
>  2 files changed, 5 insertions(+)

Please add me to to-field in the future. I'm also wondering where is the
cover letter.

> 
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index 1d6729be4cd6..e99f4f71c74f 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -1228,6 +1228,7 @@ int tpm_get_random(u32 chip_num, u8 *out, size_t max)
>  			break;
>  
>  		recd = be32_to_cpu(tpm_cmd.params.getrandom_out.rng_data_len);
> +		recd = min_t(u32, recd, num_bytes);

Shouldn't this be rather a check whether num_bytes is surpassed and
return an error if that happens and maybe a klog message?

>  		rlength = be32_to_cpu(tpm_cmd.header.out.length);
>  		if (rlength < offsetof(struct tpm_getrandom_out, rng_data) +
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index f40d20671a78..f6be08483ae6 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -683,6 +683,10 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
>  	if (!rc) {
>  		data_len = be16_to_cpup(
>  			(__be16 *) &buf.data[TPM_HEADER_SIZE + 4]);
> +		if (data_len < MIN_KEY_SIZE ||  data_len > MAX_KEY_SIZE + 1) {
> +			rc = -EFAULT;
> +			goto out;
> +		}

This change looks good to me but I'm thinking if this commit should
split into two?

/Jarkko

Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from eu-smtp-delivery-170.mimecast.com ([207.82.80.170]:42888 "EHLO
        eu-smtp-delivery-170.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751094AbeBHQEI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 8 Feb 2018 11:04:08 -0500
From: Jeremy Boone <Jeremy.Boone@nccgroup.trust>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
CC: "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: RE: EXTERNAL: Re: [PATCH 1/2] tpm: fix potential buffer overruns
 caused by bit glitches on the bus
Date: Thu, 8 Feb 2018 15:56:41 +0000
Message-ID: <2259b8ae37bc45efa398e9f52d7158c2@MANDBSEXCH03.nccgroup.local>
References: <1517592221.3137.18.camel@HansenPartnership.com>
 <1517592278.3137.19.camel@HansenPartnership.com>
 <20180208133402.xpszh2p5cpjnu6ki@linux.intel.com>
In-Reply-To: <20180208133402.xpszh2p5cpjnu6ki@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

> Shouldn't this be rather a check whether num_bytes is surpassed and
> return an error if that happens and maybe a klog message?

Jarkko,

I had originally suggested the use of min_t() in an attempt to make this code symmetric with the behaviour seen in tpm2_get_random() in tpm2-cmd.c.  But I see the value in your suggestion.

Jeremy

-----Original Message-----
From: linux-integrity-owner@vger.kernel.org [mailto:linux-integrity-owner@vger.kernel.org] On Behalf Of Jarkko Sakkinen
Sent: Thursday, February 08, 2018 8:34 AM
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-integrity@vger.kernel.org; Jeremy Boone <Jeremy.Boone@nccgroup.trust>
Subject: EXTERNAL: Re: [PATCH 1/2] tpm: fix potential buffer overruns caused by bit glitches on the bus

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
>  break;
>
>  recd = be32_to_cpu(tpm_cmd.params.getrandom_out.rng_data_len);
> +recd = min_t(u32, recd, num_bytes);

Shouldn't this be rather a check whether num_bytes is surpassed and
return an error if that happens and maybe a klog message?

>  rlength = be32_to_cpu(tpm_cmd.header.out.length);
>  if (rlength < offsetof(struct tpm_getrandom_out, rng_data) +
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index f40d20671a78..f6be08483ae6 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -683,6 +683,10 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
>  if (!rc) {
>  data_len = be16_to_cpup(
>  (__be16 *) &buf.data[TPM_HEADER_SIZE + 4]);
> +if (data_len < MIN_KEY_SIZE ||  data_len > MAX_KEY_SIZE + 1) {
> +rc = -EFAULT;
> +goto out;
> +}

This change looks good to me but I'm thinking if this commit should
split into two?

/Jarkko

________________________________

Jeremy Boone
Principal Security Consultant
NCC Group
51 Breithaupt Street,
Suite 100, Kitchener, N2H 5G5

Telephone: +1 226 606 8318<tel:+1 226 606 8318>
Mobile: +1 226 606 8318<tel:+1 226 606 8318>
Website: www.nccgroup.trust<http://www.nccgroup.trust>
Twitter: @NCCGroupplc<https://twitter.com/NCCGroupplc>
        [https://www.nccgroup.trust/static/img/emaillogo/ncc-group-logo.png]  <http://www.nccgroup.trust/>
________________________________


This email is sent for and on behalf of NCC Group. NCC Group is the trading name of NCC Services Limited (Registered in England CRN: 2802141). The ultimate holding company is NCC Group plc (Registered in England CRN: 4627044). This email may be confidential and/or legally privileged.

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931D41DDFE;
	Sat, 17 Oct 2026 00:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792197093; cv=none; b=bk1nr93PUw6Dv/ho4p6QJ/F9iVH2pV7JEZgMQQZjBWToHczWq+YPxnZwW5UxTMy1px7C34/TBpof+Pl+Dt71PsCjphnwIFmYeyGFGSjNcstj51Bav0oUersunqW/ProD4BCUIDgsoM443xyHzI+MdO16qJW6CStbASNVkdTIG2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792197093; c=relaxed/simple;
	bh=U+5IG8m8xoK7VNVHDpQyrSif0f0AzdCogpfini8OHxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bFx8BL6AUJbD9BTmDudZ1kYcNIJm+9LRvrQwSoRPazVJONs/kM/h7Ty/P79g6nWJo5Sv04Ww5DDur5DS/kPT6WKjvkuMofcpgqsvw/DDKikXcQ7osC2l5Yau9y32fYyiqIoeY68ILjAVLJfPt5Nqzt2SWIPsWrflcL/dg4Ij1SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fe+GEmYx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fe+GEmYx"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 5AC611F000C4;
	Sat, 17 Oct 2026 00:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792197091;
	bh=eCRhchLOfqHs0am17EgcQVDQhry4HHYSAz+0fnhXrD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Fe+GEmYxl0p3NliMBeeebE8ABUVcle+Zly4l5SOrVETvBf4DMHDfdyM+75yFlmiMM
	 yDPfGK88A6BbcLMM5E9Yd0+0lBG9VxpI8QBsrJx2wz5w2hvfEM7fqSuXZgwsNfHpYL
	 3MJmdnBWyAWgtylQ2AG8qVLOaR2flO7wJDkpKLORV4LOLbx9Grmuyn9+4HCpNLQgnl
	 FF+yxlFdZtPeVqoWnYpUClg16lgY4LB/1RkeTf08scLc+Kf5eMJRKKu8PFEcNA3NZM
	 ix66ZXlgyHLivaS8z+Wv320bQJBSAciFKnTqv4g3N8gulmaUOF2pdbtTTgU/jqDcff
	 IxDTDzJnTlJJA==
Date: Sat, 17 Oct 2026 03:31:28 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Surendran Kanagaraj <surenkj@amazon.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	Breno Leitao <leitao@debian.org>, nh-open-source@amazon.com,
	Alexander Graf <graf@amazon.de>,
	Gunnar Kudrjavets <gunnarku@amazon.com>,
	Josh Levinson <joshlev@amazon.com>
Subject: Re: [PATCH v2 2/2] tpm_crb: Raise durations for Amazon NitroTPM
Message-ID: <atLB4N5DZuvKsj5R@kernel.org>
References: <20261016043733.30589-1-surenkj@amazon.com>
 <20261016043733.30589-3-surenkj@amazon.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016043733.30589-3-surenkj@amazon.com>

On Fri, Oct 16, 2026 at 04:37:33AM +0000, Surendran Kanagaraj wrote:
> TPM commands need to complete within the command duration defined in
> the TPM2 spec or keep answering TPM2_RC_RETRY for at most
> TPM2_DURATION_LONG (2s).
> 
> In rare scenarios NitroTPM can enter a mode where it either sends
> TPM2_RC_RETRY for more than 2s or delays command completion. When
> this happens during auth session start, the driver disables the chip
> and every subsequent request fails:
> 
>     tpm tpm0: in retry loop
>     tpm tpm0: tpm2_load_context: failed with a TPM error 0x0922
> 
> Add support for vendor duration overrides to the CRB driver, based on
> the vendor ID read from the interface ID register. For NitroTPM, raise
> TPM_SHORT, TPM_MEDIUM and TPM_LONG to 30s which covers the longest
> unavailability time along with some headroom.
> 
> Tested on an EC2 instance with NitroTPM by inducing multiple
> unavailability windows with no TPM errors, and in QEMU with swtpm by
> holding the TPM in TPM2_RC_RETRY and stalling command completion for
> longer than 2s.
> 
> Assisted-by: LLM
> Signed-off-by: Surendran Kanagaraj <surenkj@amazon.com>
> ---
> V1 -> V2:
> - Raise the durations through ->update_durations() instead of setting
>   chip->busy_timeout_ms.
> - Raise TPM_SHORT, TPM_MEDIUM and TPM_LONG to 30s.
> - Replace the vendor quirk table with a plain vendor ID check.
> - Use the TPM_CRB_ prefix for the new macros.
> - Rename from "tpm_crb: Raise timeouts for Amazon NitroTPM".
> 
> v1: https://lore.kernel.org/linux-integrity/20260923142834.16786-3-surenkj@amazon.com/
> ---
>  drivers/char/tpm/tpm_crb.c | 44 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> index ceb4100ba400..6ba9016d6463 100644
> --- a/drivers/char/tpm/tpm_crb.c
> +++ b/drivers/char/tpm/tpm_crb.c
> @@ -13,6 +13,7 @@
>  
>  #include <linux/acpi.h>
>  #include <linux/highmem.h>
> +#include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/rculist.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> @@ -26,6 +27,15 @@
>  #define ACPI_SIG_TPM2 "TPM2"
>  #define TPM_CRB_MAX_RESOURCES 3
>  
> +/* TPM_CRB_INTF_ID_x vendor ID field, bits 47:32 of the 64-bit register */
> +#define TPM_CRB_INTF_ID_VID(intf_id)	(((intf_id) >> 32) & 0xffff)
> +
> +/* Amazon NitroTPM */
> +#define TPM_CRB_INTF_VID_AMZN		0x0ec2
> +
> +/* Longest NitroTPM unavailability, with some headroom */
> +#define TPM_CRB_AMZN_DURATION_MS	30000
> +
>  static const guid_t crb_acpi_start_guid =
>  	GUID_INIT(0x6BBF6CAB, 0x5463, 0x4714,
>  		  0xB7, 0xCD, 0xF0, 0x20, 0x3C, 0x03, 0x68, 0xD4);
> @@ -521,6 +531,39 @@ static bool crb_req_canceled(struct tpm_chip *chip, u8 status)
>  	return (cancel & CRB_CANCEL_INVOKE) == CRB_CANCEL_INVOKE;
>  }
>  
> +/*
> + * Read the vendor ID from the interface ID register. Returns -ENODEV when
> + * the head registers are not mapped for this start method.
> + */
> +static int crb_vendor_id(struct crb_priv *priv)
> +{
> +	u64 intf_id;
> +
> +	if (!priv->regs_h)
> +		return -ENODEV;
> +
> +	intf_id = lo_hi_readq(&priv->regs_h->intf_id);
> +
> +	return TPM_CRB_INTF_ID_VID(intf_id);
> +}
> +
> +static void crb_update_durations(struct tpm_chip *chip,
> +				 unsigned long *duration_cap)
> +{
> +	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
> +	unsigned long duration;
> +
> +	chip->duration_adjusted = false;
> +
> +	if (crb_vendor_id(priv) == TPM_CRB_INTF_VID_AMZN) {
> +		duration = msecs_to_jiffies(TPM_CRB_AMZN_DURATION_MS);
> +		duration_cap[TPM_SHORT] = duration;
> +		duration_cap[TPM_MEDIUM] = duration;
> +		duration_cap[TPM_LONG] = duration;
> +		chip->duration_adjusted = true;
> +	}
> +}
> +
>  static const struct tpm_class_ops tpm_crb = {
>  	.flags = TPM_OPS_AUTO_STARTUP,
>  	.status = crb_status,
> @@ -532,6 +575,7 @@ static const struct tpm_class_ops tpm_crb = {
>  	.cmd_ready = crb_cmd_ready,
>  	.request_locality = crb_request_locality,
>  	.relinquish_locality = crb_relinquish_locality,
> +	.update_durations = crb_update_durations,
>  	.req_complete_mask = CRB_DRV_STS_COMPLETE,
>  	.req_complete_val = CRB_DRV_STS_COMPLETE,
>  };
> -- 
> 2.47.3
> 

Yeah so this needs a bit more redesign and while it is a possible
way to address all these issues I don't believe it is best possible
way imaginable to do something that lasts long-term.

I don't want to go into concrete proposals because then I would have
to really engineer the whole change while at it because I would
likely try a number of approaches out. I.e. just a bit more effort
and innovation please.

Br, Jarkko

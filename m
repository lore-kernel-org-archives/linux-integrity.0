Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832B25304AD;
	Fri, 16 Oct 2026 16:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792169716; cv=none; b=OduHW9A8YSh3IpbEFVXhx8qvCRHj7AKnNDu3KKywsm27RhjVceJvzmhAjBkLDUAIiTj8+Ej28R8iBXCyyEDKFGSeE2+hiLnpBqBhUyYoY7bN+PGvsQI4+WwPJ2RH21VYlyhQ7BoTflhEZgO3nQAdkQ1C/n+0GmhSoqc6SKgQcZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792169716; c=relaxed/simple;
	bh=saDf3Ozq7NwBYW+zq0u7wY10N4VJ7lLwcMoKNfGPEd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qmcKnDyaKP7iRPr4wwo7Z/onzjIhqISdQ6f9wlrqURb0qAUzyoygrVcFou9s7tGG0HrYihk4j3+dCCJYEeQ4tkqkwPZf27vK8mwKgufoha9rOlziIDR+OQlgbBhD4ElFCN8m99trbWU4pyiuS6jDsHOKbJLz8tZXDKxAndieu9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=OyBV4FFt; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b="OyBV4FFt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=c7XiiXVGQMZTlw/hu5tGFdABDTYIIGVbIpI1631Y1NU=; b=OyBV4FFt103PyF9pRyt+kmplMq
	0dpPaYAMzyFEqrzxePPuDr5Q5Z6WPTIgovUKXxO0Rp1BGoTiafxx3E7oo8EkSFlOTO9xWWq9w8uc+
	YPdqXYGV8tFPgTJfMXgK3Cpjb/GJHwfKsSf2CyuyBsJQftqJQUBMjDbl0dRXehNwQqCXIpZ20F4Kt
	okmu+FDO7ZCN9IgjiPbZ31qCEnXB6Xvoqf7z3uyYZuMcbWZGwvY8N0uRcg6BY2tSGY8yphq0zjb9W
	j2bnGAYHTrh7ajaFDCUk2ZJJY+uL9Nuj/QjSuiXwcISVABkdHvCysizbS5ghjpIlZMWrVDiogJxyH
	3CNSqF9Q==;
Received: from noodles by the.earth.li with local (Exim 4.98.2)
	(envelope-from <noodles@earth.li>)
	id 1xHkmX-00000002QIY-3ndq;
	Fri, 16 Oct 2026 17:27:46 +0100
Date: Fri, 16 Oct 2026 17:27:45 +0100
From: Jonathan McDowell <noodles@earth.li>
To: Surendran Kanagaraj <surenkj@amazon.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org, Breno Leitao <leitao@debian.org>,
	nh-open-source@amazon.com, Alexander Graf <graf@amazon.de>,
	Gunnar Kudrjavets <gunnarku@amazon.com>,
	Josh Levinson <joshlev@amazon.com>
Subject: Re: [PATCH v2 2/2] tpm_crb: Raise durations for Amazon NitroTPM
Message-ID: <atJQgXYkFjcQROb6@earth.li>
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

Bumping all of these to 30s seems excessive. Is it really the case that 
all commands can potentially take this long? Is that because of 
non-TPM-related operations Nitro might be doing behind the scenes?

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

This should really live with the other VID definitions in 
linux/include/tpm.h

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
> 

J.

-- 
... She's the one for me. She's all I really need, oh yeah.

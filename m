Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A20E28E0F;
	Fri, 25 Sep 2026 15:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790351725; cv=none; b=MNR7AzQdFruBDrL9OErOrPnYrG0DBIqEphebsxVrFnl6pfzfIeByMMUoQ0Bj5aZhnAIWy4MBHjeGh/9QhhxZ8SLt62qE3FfZ/oBTnPEqFTahmPk+BA55XexmHnC5MjPVGAGLufUIgXMFY9FQl3maJiYWcXpAgyQWfZyIDMvZyjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790351725; c=relaxed/simple;
	bh=nyo/EhOHK3ocDNiFVF6yWDwCwl82D+AW1WKJ8EumOAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tt5J16WOBFlqMHgSQVFUjPF453bdR29gxqKwWvJbI76rbvXqA3hJTw3UCiIf1rm/yzlI+I8Hm6E7f45kqapNldTBYABqV2cRkA6/CyKZzn2e2hKLNXtdOyjCUz5qlxixpE+iH0ys0DzdEHRhuMkauCwINkFD9U4izURXumvply0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZiLS1zmR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZiLS1zmR"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id F3DA61F00893;
	Fri, 25 Sep 2026 15:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790351723;
	bh=BbxdJRJKCmSlxCiUrW1I1RT7W/tcODHtzyLooBPGjP0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZiLS1zmRbhKXoVxqJJr78nfIUSRefHu2xMw8ZQy3ry19SeuJNDgfVKrGMNxoo6YC6
	 xyikcRz5YRyPy9Q/KJoyoXl1A6CxVmoyw15L8plYQzc9lknltcUqyoLIAGe9L+7Flz
	 pa2dTaakQMRapHNf/0I0sjp3cs616WZsSgSffQVllQDZEBSfiqk0y6StjsqqWqspAK
	 /+qJLB2cFUiw4KDJBNBRE9l3Rw6e7qw7/ol22b6P+PajzNUNq3RmwvnB1hInrOXoAM
	 GrH6yCP4e6glfWmWhhfTYsa8IJJtCO2Th1nZDH51b4RMKbQOoD8Q20BJLfaOnySoOv
	 eAiMDbp1W90Ig==
Date: Fri, 25 Sep 2026 18:55:19 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Surendran Kanagaraj <surenkj@amazon.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	nh-open-source@amazon.com, Alexander Graf <graf@amazon.de>,
	Gunnar Kudrjavets <gunnarku@amazon.com>,
	Josh Levinson <joshlev@amazon.com>
Subject: Re: [PATCH 2/2] tpm_crb: Raise timeouts for Amazon NitroTPM
Message-ID: <araZZzKDqzrPdY9f@kernel.org>
References: <20260923142834.16786-1-surenkj@amazon.com>
 <20260923142834.16786-3-surenkj@amazon.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923142834.16786-3-surenkj@amazon.com>

On Wed, Sep 23, 2026 at 02:28:34PM +0000, Surendran Kanagaraj wrote:
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
> Add support for vendor quirks to the CRB driver. The table is keyed by
> the vendor ID read from the interface ID register. For NitroTPM, set
> busy_timeout_ms to 30s, which covers the longest unavailability time
> along with some headroom.
> 
> Tested on an EC2 instance with NitroTPM by inducing multiple
> unavailability windows with no TPM errors, and in QEMU with swtpm by
> holding the TPM in TPM2_RC_RETRY and stalling command completion for
> longer than 2s with the quirk applied.
> 
> Assisted-by: LLM
> Signed-off-by: Surendran Kanagaraj <surenkj@amazon.com>
> ---
>  drivers/char/tpm/tpm_crb.c | 54 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> index ceb4100ba400..4107203beec9 100644
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
> +#define CRB_INTF_ID_VID(intf_id)	(((intf_id) >> 32) & 0xffff)
> +
> +/* Amazon NitroTPM */
> +#define CRB_INTF_VID_AMZN		0x0ec2
> +
> +/* Longest unavailability seen from NitroTPM */
> +#define CRB_AMZN_BUSY_TIMEOUT_MS	30000

Use TPM_CRB prefix.

> +
>  static const guid_t crb_acpi_start_guid =
>  	GUID_INIT(0x6BBF6CAB, 0x5463, 0x4714,
>  		  0xB7, 0xCD, 0xF0, 0x20, 0x3C, 0x03, 0x68, 0xD4);
> @@ -783,6 +793,48 @@ static int crb_map_pluton(struct device *dev, struct crb_priv *priv,
>  	return 0;
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
> +	return CRB_INTF_ID_VID(intf_id);
> +}
> +
> +static void crb_amzn_quirk(struct tpm_chip *chip)
> +{
> +	/* NitroTPM requires larger timeouts */
> +	chip->busy_timeout_ms = CRB_AMZN_BUSY_TIMEOUT_MS;
> +}
> +
> +static const struct crb_vendor_quirk {
> +	u16 vendor_id;
> +	void (*apply)(struct tpm_chip *chip);
> +} crb_vendor_quirks[] = {
> +	{ CRB_INTF_VID_AMZN, crb_amzn_quirk },
> +};
> +
> +static void crb_apply_vendor_quirks(struct crb_priv *priv, struct tpm_chip *chip)
> +{
> +	int vendor_id = crb_vendor_id(priv);
> +	unsigned int i;
> +
> +	if (vendor_id < 0)
> +		return;
> +
> +	for (i = 0; i < ARRAY_SIZE(crb_vendor_quirks); i++)
> +		if (crb_vendor_quirks[i].vendor_id == vendor_id)
> +			crb_vendor_quirks[i].apply(chip);
> +}
> +
>  static int crb_acpi_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -887,6 +939,8 @@ static int crb_acpi_probe(struct platform_device *pdev)
>  	chip->acpi_dev_handle = device->handle;
>  	chip->flags = TPM_CHIP_FLAG_TPM2;
>  
> +	crb_apply_vendor_quirks(priv, chip);

I.e., all this complexity equals to:

	if (crb_vendor_id(priv) == CRB_INTF_VID_AMZN)
		chip->busy_timeout_ms = CRB_AMZN_BUSY_TIMEOUT_MS;

?

> +
>  	rc = tpm_chip_bootstrap(chip);
>  	if (rc)
>  		goto out;
> -- 
> 2.47.3
> 

Br, Jarkko

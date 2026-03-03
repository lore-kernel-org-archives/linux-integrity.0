Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B93F382F0A;
	Tue,  3 Mar 2026 21:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772574425; cv=none; b=JyN09G9KXWvlvRbUum5AAbNLEcE9Pi1RlxQl9UxcaRVbYyTu/8+ST4GlfVGG4CLyfSVhYHDvLMbTlXmXAOM3hNHhwi5bM8ueSFTZSYvYXJ8MS3F3aJ9pDeK/GMhpyYy+z4qx3qPTBAOVh0lhJSphRuvsrYu8AyJwded7JNDjFpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772574425; c=relaxed/simple;
	bh=Et8WSk5zUBAHmeqHRt3NysOGFmfRJ4m/lYGAcFA1VXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cvi+obXHVz3Cjhy7wR3tx1qXfovByietnOKybmjUqJesYP9knmX3MSV0tV4h98JZbsYXNT2lZkx81tkhpZ3fa7mN2EQl2ZTi0vXHw5/28gDqa0ED0rfscydvVharZ2Kc98DDFfuYxEPZI2hfgaA8InDXZ52RIb5utTRIhgk8US8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=idCyG/hP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="idCyG/hP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D589CC19425;
	Tue,  3 Mar 2026 21:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772574425;
	bh=Et8WSk5zUBAHmeqHRt3NysOGFmfRJ4m/lYGAcFA1VXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=idCyG/hPNBiqFC39Q1ZSmPJpTnpgeLEpnQvHJoNgA7dSHwPZoEXzdiP/APcuq4Muq
	 /7J6bQEQgBwJbAClnVtJYcTYRYWmYW0XIzq3cH/CY+dWSyq2Vb9nn0dTdLBUkJ8A68
	 cKWNtfcdzfK3i545ySFKCa7h1a8k2xjBgC+sywQvb3/mb0BLhNIiHN06ArpIsPzYZq
	 /domKx5lPOD11s6KTBdvVgFalBUdv4vtUlMh/gtAEMgNX/VuB0CADym+rF+zlTgrBT
	 Ju/gA1GQ7L9l3VN0UwPniqUNLu04BkBtPUVJCVxSK27+BjGX6heS61PLgpuuxBq4XD
	 5Bv759/BSeHEw==
Date: Tue, 3 Mar 2026 23:47:01 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v1] tpm_crb: Convert ACPI driver to a platform one
Message-ID: <aadW1RVnBikOy5Q7@kernel.org>
References: <2706178.Lt9SDvczpP@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2706178.Lt9SDvczpP@rafael.j.wysocki>

On Mon, Feb 23, 2026 at 04:55:21PM +0100, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> In all cases in which a struct acpi_driver is used for binding a driver
> to an ACPI device object, a corresponding platform device is created by
> the ACPI core and that device is regarded as a proper representation of
> underlying hardware.  Accordingly, a struct platform_driver should be
> used by driver code to bind to that device.  There are multiple reasons
> why drivers should not bind directly to ACPI device objects [1].
> 
> Overall, it is better to bind drivers to platform devices than to their
> ACPI companions, so convert the tpm_crb ACPI driver to a platform one.
> 
> While this is not expected to alter functionality, it changes sysfs
> layout and so it will be visible to user space.
> 
> Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/ [1]
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/char/tpm/tpm_crb.c | 35 ++++++++++++++++-------------------
>  1 file changed, 16 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> index 6c25305c256e..7d1377e8e616 100644
> --- a/drivers/char/tpm/tpm_crb.c
> +++ b/drivers/char/tpm/tpm_crb.c
> @@ -15,6 +15,7 @@
>  #include <linux/highmem.h>
>  #include <linux/rculist.h>
>  #include <linux/module.h>
> +#include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #ifdef CONFIG_ARM64
>  #include <linux/arm-smccc.h>
> @@ -602,13 +603,13 @@ static u64 crb_fixup_cmd_size(struct device *dev, struct resource *io_res,
>  	return io_res->end - start + 1;
>  }
>  
> -static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
> +static int crb_map_io(struct device *dev, struct crb_priv *priv,
>  		      struct acpi_table_tpm2 *buf)
>  {
> +	struct acpi_device *device = ACPI_COMPANION(dev);
>  	struct list_head acpi_resource_list;
>  	struct resource iores_array[TPM_CRB_MAX_RESOURCES + 1] = { {0} };
>  	void __iomem *iobase_array[TPM_CRB_MAX_RESOURCES] = {NULL};
> -	struct device *dev = &device->dev;
>  	struct resource *iores;
>  	void __iomem **iobase_ptr;
>  	int i;
> @@ -782,12 +783,13 @@ static int crb_map_pluton(struct device *dev, struct crb_priv *priv,
>  	return 0;
>  }
>  
> -static int crb_acpi_add(struct acpi_device *device)
> +static int crb_acpi_probe(struct platform_device *pdev)
>  {
> +	struct device *dev = &pdev->dev;
> +	struct acpi_device *device = ACPI_COMPANION(dev);
>  	struct acpi_table_tpm2 *buf;
>  	struct crb_priv *priv;
>  	struct tpm_chip *chip;
> -	struct device *dev = &device->dev;
>  	struct tpm2_crb_smc *crb_smc;
>  	struct tpm2_crb_ffa *crb_ffa;
>  	struct tpm2_crb_pluton *crb_pluton;
> @@ -867,7 +869,7 @@ static int crb_acpi_add(struct acpi_device *device)
>  	priv->sm = sm;
>  	priv->hid = acpi_device_hid(device);
>  
> -	rc = crb_map_io(device, priv, buf);
> +	rc = crb_map_io(dev, priv, buf);
>  	if (rc)
>  		goto out;
>  
> @@ -901,12 +903,9 @@ static int crb_acpi_add(struct acpi_device *device)
>  	return rc;
>  }
>  
> -static void crb_acpi_remove(struct acpi_device *device)
> +static void crb_acpi_remove(struct platform_device *pdev)
>  {
> -	struct device *dev = &device->dev;
> -	struct tpm_chip *chip = dev_get_drvdata(dev);
> -
> -	tpm_chip_unregister(chip);
> +	tpm_chip_unregister(platform_get_drvdata(pdev));
>  }
>  
>  static const struct dev_pm_ops crb_pm = {
> @@ -919,19 +918,17 @@ static const struct acpi_device_id crb_device_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(acpi, crb_device_ids);
>  
> -static struct acpi_driver crb_acpi_driver = {
> -	.name = "tpm_crb",
> -	.ids = crb_device_ids,
> -	.ops = {
> -		.add = crb_acpi_add,
> -		.remove = crb_acpi_remove,
> -	},
> -	.drv = {
> +static struct platform_driver crb_acpi_driver = {
> +	.probe = crb_acpi_probe,
> +	.remove = crb_acpi_remove,
> +	.driver = {
> +		.name = "tpm_crb_acpi",
> +		.acpi_match_table = crb_device_ids,
>  		.pm = &crb_pm,
>  	},
>  };
>  
> -module_acpi_driver(crb_acpi_driver);
> +module_platform_driver(crb_acpi_driver);
>  MODULE_AUTHOR("Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>");
>  MODULE_DESCRIPTION("TPM2 Driver");
>  MODULE_VERSION("0.1");
> -- 
> 2.51.0
> 
> 
> 
> 

Yep, historical relic, thank you.

Applied.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko


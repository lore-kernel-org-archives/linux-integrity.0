Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425463D4123
	for <linux-integrity@vger.kernel.org>; Wed,  9 Sep 2026 22:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788994612; cv=none; b=NN8g5veRhCaPaYLVN1B8s57h7jsv1s8xWubsMuIsluXmN8sn5mDI+njiwDd+4q/Fcygh+hoIFh+0Mde4OStgcq+uQK+jal5U+g2Fg5/e0CsUmWvPvIChmsO4BJP0FaWkHFJxbZ+NWWfAOVCDP88DmAEiMmmVgPIYuGlr1o6kXGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788994612; c=relaxed/simple;
	bh=RrNsn/9iwA+Hvo1ihuhn/pw1HXEv5o0HogkdeRVQZW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y3PYsBOxfzEyX5YT+9n/Me+ehNu6vBsRqMfqtfi5UatQJliVGd8L7kjTXlYLCJhICTulwjJ+5CjZc+q2hn9vv4KY4/8bCq+YNuJA40+1v25lFFperxxvcyCrU8nZAxdzkG6F4jPT6WuhL5UnCtzzUobFlGHUfkckV4lFyw+KI9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=orUwNeaB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="orUwNeaB"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id D22B91F000FF;
	Wed,  9 Sep 2026 22:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788994601;
	bh=90pI87L+pALO0W1VVhPfhGIo2ovd0A90y4SjRO65dT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=orUwNeaBivsHjhrZUoryRpUebTo4pT2obNz8CGnyo1AbZZ9Z9nyqKfeSVCv32a9R5
	 64LhowIId19dMxra6Jd2Cuh4Zqb/s88utf3JbI/XcEBcYmDJE0cI7m95f0GSMlIfLX
	 RD8utQqmBAZLy+81KHNkiV1z/uvtXsImZwq/P5MLfxwYvt7KM6vFUuVLtO3LZscnT7
	 XVpHQnQ/8XL4ZqxyjdOVf2oo/MT6mgqOg2MBPNVEYva6AFrw7fRfG8tlwkWRf7TKYh
	 R4fkHjdr622dpU3VbGCSfyN3mIRLewpzimhLBYaHYYj/l9RmqQFNKkwiWHOXOUHmIr
	 BPkUGtm9G+jCg==
Date: Thu, 10 Sep 2026 01:56:37 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Li Jun <lijun01@kylinos.cn>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2] tpm: use DEFINE_SIMPLE_DEV_PM_OPS and pm_sleep_ptr()
Message-ID: <aqHkJaAwHvSJdYkN@kernel.org>
References: <20260909082459.796628-1-lijun01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909082459.796628-1-lijun01@kylinos.cn>

On Wed, Sep 09, 2026 at 04:24:59PM +0800, Li Jun wrote:
> Replace the deprecated SIMPLE_DEV_PM_OPS with DEFINE_SIMPLE_DEV_PM_OPS
> and wrap the struct assignment with pm_sleep_ptr(). The old code keeps
> a completely empty dev_pm_ops structure -- all callbacks are NULL --
> as dead code in the object file when CONFIG_PM_SLEEP=n, because
> SET_SYSTEM_SLEEP_PM_OPS() expands to nothing while __maybe_unused on
> the struct only silences the warning without removing the struct.
> Switching to DEFINE_SIMPLE_DEV_PM_OPS() lets pm_sleep_ptr() eliminate
> the callback references at compile time, and wrapping the struct
> assignment with pm_sleep_ptr() drops the entire structure when
> CONFIG_PM_SLEEP is disabled, instead of retaining an empty one.
> 
> Signed-off-by: Li Jun <lijun01@kylinos.cn>
> ---
> Changes:
> -Modify all of them in drivers/char/tpm/*.c.
> ---
>  drivers/char/tpm/tpm_atmel.c         | 4 ++--
>  drivers/char/tpm/tpm_i2c_atmel.c     | 4 ++--
>  drivers/char/tpm/tpm_i2c_infineon.c  | 4 ++--
>  drivers/char/tpm/tpm_i2c_nuvoton.c   | 4 ++--
>  drivers/char/tpm/tpm_infineon.c      | 4 ++--
>  drivers/char/tpm/tpm_nsc.c           | 4 ++--
>  drivers/char/tpm/tpm_tis.c           | 4 ++--
>  drivers/char/tpm/tpm_tis_i2c.c       | 4 ++--
>  drivers/char/tpm/tpm_tis_i2c_cr50.c  | 4 ++--
>  drivers/char/tpm/tpm_tis_spi_main.c  | 4 ++--
>  drivers/char/tpm/tpm_tis_synquacer.c | 4 ++--
>  11 files changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_atmel.c b/drivers/char/tpm/tpm_atmel.c
> index f25faf468bba..2c3f6bdd7873 100644
> --- a/drivers/char/tpm/tpm_atmel.c
> +++ b/drivers/char/tpm/tpm_atmel.c
> @@ -205,12 +205,12 @@ static void atml_plat_remove(void)
>  	platform_device_unregister(pdev);
>  }
>  
> -static SIMPLE_DEV_PM_OPS(tpm_atml_pm, tpm_pm_suspend, tpm_pm_resume);
> +static DEFINE_SIMPLE_DEV_PM_OPS(tpm_atml_pm, tpm_pm_suspend, tpm_pm_resume);
>  
>  static struct platform_driver atml_drv = {
>  	.driver = {
>  		.name = "tpm_atmel",
> -		.pm		= &tpm_atml_pm,
> +		.pm		= pm_sleep_ptr(&tpm_atml_pm),
>  	},
>  };
>  
> diff --git a/drivers/char/tpm/tpm_i2c_atmel.c b/drivers/char/tpm/tpm_i2c_atmel.c
> index 9fd73049821f..dcb91d0497d0 100644
> --- a/drivers/char/tpm/tpm_i2c_atmel.c
> +++ b/drivers/char/tpm/tpm_i2c_atmel.c
> @@ -212,7 +212,7 @@ static const struct of_device_id i2c_atmel_of_match[] = {
>  MODULE_DEVICE_TABLE(of, i2c_atmel_of_match);
>  #endif
>  
> -static SIMPLE_DEV_PM_OPS(i2c_atmel_pm_ops, tpm_pm_suspend, tpm_pm_resume);
> +static DEFINE_SIMPLE_DEV_PM_OPS(i2c_atmel_pm_ops, tpm_pm_suspend, tpm_pm_resume);
>  
>  static struct i2c_driver i2c_atmel_driver = {
>  	.id_table = i2c_atmel_id,
> @@ -220,7 +220,7 @@ static struct i2c_driver i2c_atmel_driver = {
>  	.remove = i2c_atmel_remove,
>  	.driver = {
>  		.name = I2C_DRIVER_NAME,
> -		.pm = &i2c_atmel_pm_ops,
> +		.pm = pm_sleep_ptr(&i2c_atmel_pm_ops),
>  		.of_match_table = of_match_ptr(i2c_atmel_of_match),
>  	},
>  };
> diff --git a/drivers/char/tpm/tpm_i2c_infineon.c b/drivers/char/tpm/tpm_i2c_infineon.c
> index 8b7d32de0b2e..fffa235068df 100644
> --- a/drivers/char/tpm/tpm_i2c_infineon.c
> +++ b/drivers/char/tpm/tpm_i2c_infineon.c
> @@ -682,7 +682,7 @@ static const struct of_device_id tpm_tis_i2c_of_match[] = {
>  MODULE_DEVICE_TABLE(of, tpm_tis_i2c_of_match);
>  #endif
>  
> -static SIMPLE_DEV_PM_OPS(tpm_tis_i2c_ops, tpm_pm_suspend, tpm_pm_resume);
> +static DEFINE_SIMPLE_DEV_PM_OPS(tpm_tis_i2c_ops, tpm_pm_suspend, tpm_pm_resume);
>  
>  static int tpm_tis_i2c_probe(struct i2c_client *client)
>  {
> @@ -723,7 +723,7 @@ static struct i2c_driver tpm_tis_i2c_driver = {
>  	.remove = tpm_tis_i2c_remove,
>  	.driver = {
>  		   .name = "tpm_i2c_infineon",
> -		   .pm = &tpm_tis_i2c_ops,
> +		   .pm = pm_sleep_ptr(&tpm_tis_i2c_ops),
>  		   .of_match_table = of_match_ptr(tpm_tis_i2c_of_match),
>  		   },
>  };
> diff --git a/drivers/char/tpm/tpm_i2c_nuvoton.c b/drivers/char/tpm/tpm_i2c_nuvoton.c
> index c84afb29d548..387661380913 100644
> --- a/drivers/char/tpm/tpm_i2c_nuvoton.c
> +++ b/drivers/char/tpm/tpm_i2c_nuvoton.c
> @@ -640,7 +640,7 @@ static const struct of_device_id i2c_nuvoton_of_match[] = {
>  MODULE_DEVICE_TABLE(of, i2c_nuvoton_of_match);
>  #endif
>  
> -static SIMPLE_DEV_PM_OPS(i2c_nuvoton_pm_ops, tpm_pm_suspend, tpm_pm_resume);
> +static DEFINE_SIMPLE_DEV_PM_OPS(i2c_nuvoton_pm_ops, tpm_pm_suspend, tpm_pm_resume);
>  
>  static struct i2c_driver i2c_nuvoton_driver = {
>  	.id_table = i2c_nuvoton_id,
> @@ -648,7 +648,7 @@ static struct i2c_driver i2c_nuvoton_driver = {
>  	.remove = i2c_nuvoton_remove,
>  	.driver = {
>  		.name = "tpm_i2c_nuvoton",
> -		.pm = &i2c_nuvoton_pm_ops,
> +		.pm = pm_sleep_ptr(&i2c_nuvoton_pm_ops),
>  		.of_match_table = of_match_ptr(i2c_nuvoton_of_match),
>  	},
>  };
> diff --git a/drivers/char/tpm/tpm_infineon.c b/drivers/char/tpm/tpm_infineon.c
> index 7638b65b851b..84a0d3e5f679 100644
> --- a/drivers/char/tpm/tpm_infineon.c
> +++ b/drivers/char/tpm/tpm_infineon.c
> @@ -612,7 +612,7 @@ static int tpm_inf_resume(struct device *dev)
>  	return tpm_pm_resume(dev);
>  }
>  #endif
> -static SIMPLE_DEV_PM_OPS(tpm_inf_pm, tpm_pm_suspend, tpm_inf_resume);
> +static DEFINE_SIMPLE_DEV_PM_OPS(tpm_inf_pm, tpm_pm_suspend, tpm_inf_resume);
>  
>  static struct pnp_driver tpm_inf_pnp_driver = {
>  	.name = "tpm_inf_pnp",
> @@ -620,7 +620,7 @@ static struct pnp_driver tpm_inf_pnp_driver = {
>  	.probe = tpm_inf_pnp_probe,
>  	.remove = tpm_inf_pnp_remove,
>  	.driver = {
> -		.pm = &tpm_inf_pm,
> +		.pm = pm_sleep_ptr(&tpm_inf_pm),
>  	}
>  };
>  
> diff --git a/drivers/char/tpm/tpm_nsc.c b/drivers/char/tpm/tpm_nsc.c
> index 879ac88f5783..764038ba82a9 100644
> --- a/drivers/char/tpm/tpm_nsc.c
> +++ b/drivers/char/tpm/tpm_nsc.c
> @@ -265,12 +265,12 @@ static void tpm_nsc_remove(struct device *dev)
>  	release_region(priv->base, 2);
>  }
>  
> -static SIMPLE_DEV_PM_OPS(tpm_nsc_pm, tpm_pm_suspend, tpm_pm_resume);
> +static DEFINE_SIMPLE_DEV_PM_OPS(tpm_nsc_pm, tpm_pm_suspend, tpm_pm_resume);
>  
>  static struct platform_driver nsc_drv = {
>  	.driver          = {
>  		.name    = "tpm_nsc",
> -		.pm      = &tpm_nsc_pm,
> +		.pm      = pm_sleep_ptr(&tpm_nsc_pm),
>  	},
>  };
>  
> diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
> index 9aa230a63616..737d0fe4bb61 100644
> --- a/drivers/char/tpm/tpm_tis.c
> +++ b/drivers/char/tpm/tpm_tis.c
> @@ -246,7 +246,7 @@ static int tpm_tis_init(struct device *dev, struct tpm_info *tpm_info)
>  				 ACPI_HANDLE(dev));
>  }
>  
> -static SIMPLE_DEV_PM_OPS(tpm_tis_pm, tpm_pm_suspend, tpm_tis_resume);
> +static DEFINE_SIMPLE_DEV_PM_OPS(tpm_tis_pm, tpm_pm_suspend, tpm_tis_resume);
>  
>  static int tpm_tis_pnp_init(struct pnp_dev *pnp_dev,
>  			    const struct pnp_device_id *pnp_id)
> @@ -302,7 +302,7 @@ static struct pnp_driver tis_pnp_driver = {
>  	.probe = tpm_tis_pnp_init,
>  	.remove = tpm_tis_pnp_remove,
>  	.driver	= {
> -		.pm = &tpm_tis_pm,
> +		.pm = pm_sleep_ptr(&tpm_tis_pm),
>  	},
>  };
>  
> diff --git a/drivers/char/tpm/tpm_tis_i2c.c b/drivers/char/tpm/tpm_tis_i2c.c
> index 6cd07dd34507..d55f30fef00a 100644
> --- a/drivers/char/tpm/tpm_tis_i2c.c
> +++ b/drivers/char/tpm/tpm_tis_i2c.c
> @@ -319,7 +319,7 @@ static int tpm_tis_i2c_init_guard_time(struct tpm_tis_i2c_phy *phy)
>  	return 0;
>  }
>  
> -static SIMPLE_DEV_PM_OPS(tpm_tis_pm, tpm_pm_suspend, tpm_tis_resume);
> +static DEFINE_SIMPLE_DEV_PM_OPS(tpm_tis_pm, tpm_pm_suspend, tpm_tis_resume);
>  
>  static const struct tpm_tis_phy_ops tpm_i2c_phy_ops = {
>  	.read_bytes = tpm_tis_i2c_read_bytes,
> @@ -393,7 +393,7 @@ MODULE_DEVICE_TABLE(of, of_tis_i2c_match);
>  static struct i2c_driver tpm_tis_i2c_driver = {
>  	.driver = {
>  		.name = "tpm_tis_i2c",
> -		.pm = &tpm_tis_pm,
> +		.pm = pm_sleep_ptr(&tpm_tis_pm),
>  		.of_match_table = of_match_ptr(of_tis_i2c_match),
>  	},
>  	.probe = tpm_tis_i2c_probe,
> diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm_tis_i2c_cr50.c
> index 7f828fae70d3..6c0ea5ca2b92 100644
> --- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
> +++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
> @@ -816,14 +816,14 @@ static void tpm_cr50_i2c_remove(struct i2c_client *client)
>  	tpm_chip_unregister(chip);
>  }
>  
> -static SIMPLE_DEV_PM_OPS(cr50_i2c_pm, tpm_pm_suspend, tpm_pm_resume);
> +static DEFINE_SIMPLE_DEV_PM_OPS(cr50_i2c_pm, tpm_pm_suspend, tpm_pm_resume);
>  
>  static struct i2c_driver cr50_i2c_driver = {
>  	.probe = tpm_cr50_i2c_probe,
>  	.remove = tpm_cr50_i2c_remove,
>  	.driver = {
>  		.name = "cr50_i2c",
> -		.pm = &cr50_i2c_pm,
> +		.pm = pm_sleep_ptr(&cr50_i2c_pm),
>  		.acpi_match_table = ACPI_PTR(cr50_i2c_acpi_id),
>  		.of_match_table = of_match_ptr(of_cr50_i2c_match),
>  	},
> diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_tis_spi_main.c
> index 61b42c83ced8..727f1c78d6dd 100644
> --- a/drivers/char/tpm/tpm_tis_spi_main.c
> +++ b/drivers/char/tpm/tpm_tis_spi_main.c
> @@ -307,7 +307,7 @@ static int tpm_tis_spi_driver_probe(struct spi_device *spi)
>  	return probe_func(spi);
>  }
>  
> -static SIMPLE_DEV_PM_OPS(tpm_tis_pm, tpm_pm_suspend, tpm_tis_spi_resume);
> +static DEFINE_SIMPLE_DEV_PM_OPS(tpm_tis_pm, tpm_pm_suspend, tpm_tis_spi_resume);
>  
>  static void tpm_tis_spi_remove(struct spi_device *dev)
>  {
> @@ -347,7 +347,7 @@ MODULE_DEVICE_TABLE(acpi, acpi_tis_spi_match);
>  static struct spi_driver tpm_tis_spi_driver = {
>  	.driver = {
>  		.name = "tpm_tis_spi",
> -		.pm = &tpm_tis_pm,
> +		.pm = pm_sleep_ptr(&tpm_tis_pm),
>  		.of_match_table = of_match_ptr(of_tis_spi_match),
>  		.acpi_match_table = ACPI_PTR(acpi_tis_spi_match),
>  		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
> diff --git a/drivers/char/tpm/tpm_tis_synquacer.c b/drivers/char/tpm/tpm_tis_synquacer.c
> index 4927714d277a..eac39730a856 100644
> --- a/drivers/char/tpm/tpm_tis_synquacer.c
> +++ b/drivers/char/tpm/tpm_tis_synquacer.c
> @@ -107,7 +107,7 @@ static int tpm_tis_synquacer_init(struct device *dev,
>  				 ACPI_HANDLE(dev));
>  }
>  
> -static SIMPLE_DEV_PM_OPS(tpm_tis_synquacer_pm, tpm_pm_suspend, tpm_tis_resume);
> +static DEFINE_SIMPLE_DEV_PM_OPS(tpm_tis_synquacer_pm, tpm_pm_suspend, tpm_tis_resume);
>  
>  static int tpm_tis_synquacer_probe(struct platform_device *pdev)
>  {
> @@ -155,7 +155,7 @@ static struct platform_driver tis_synquacer_drv = {
>  	.remove = tpm_tis_synquacer_remove,
>  	.driver = {
>  		.name		= "tpm_tis_synquacer",
> -		.pm		= &tpm_tis_synquacer_pm,
> +		.pm		= pm_sleep_ptr(&tpm_tis_synquacer_pm),
>  		.of_match_table = of_match_ptr(tis_synquacer_of_platform_match),
>  		.acpi_match_table = ACPI_PTR(tpm_synquacer_acpi_tbl),
>  	},
> -- 
> 2.25.1
> 

I pressed g on wrong email in mutt was meant for this:


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

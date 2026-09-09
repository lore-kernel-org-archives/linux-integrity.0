Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EB648EC98
	for <linux-integrity@vger.kernel.org>; Wed,  9 Sep 2026 22:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788994558; cv=none; b=AL3JRhOISn0tmTk4dszhQeJveN4KoUF9fiY/6AeC/WAHWknYgHvJjmb1rtV/op+ldB6JivBQs+JkmnyIXyRY+rAxvY5/s2yerJ3u2c41NPvXamW2IKkKAdrJZb1ARqf05lAufvGjMny8yI1GlazQimlKOVdxcb5lX6C9gNUJXCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788994558; c=relaxed/simple;
	bh=eXWPUgvLogwzAmhEI2SJqpPAwhE5IG/Jd/UCRQAjXbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QhRMlsUdGVm61WsRB8gsYKR5o+fdp4WgnXvf9Sm2StoJyoNqxzzYILnairHUUbgJw/6y1bpemcJEhkGMRmV7Gw//9JPP+pciAapSKMRQ4k3JRC989HTyTSdsbr1owCMYWNlzm7gg+nmQiP0aZTsdl/SMuK1pwb7aio/YR59Siyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SrJMvvuh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SrJMvvuh"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 207981F000FF;
	Wed,  9 Sep 2026 22:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788994541;
	bh=3XKmO4ujKIQOP/vnjJkxxDEMJ9d/777zsC0dGLzpaFI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SrJMvvuh+xdxc6/Az6yI2GcHkaIETJEY6Vad333NZEJsKSGPa5pQ6RVhTPS3qw1Ym
	 cH+lK+MiA348+s2HpLqkQmg0b8xnqsYCoF3C4LrsoUurRXnaxh38OcyHOH9PeBXSSp
	 ioWQz3vYftpIkNcJZlgRYKD4Wlrx/XSPweyjrLO6xmpwjLiC1QlgeaS6oCEovVXaWf
	 UOLT2WWB6KSr9nz39Y2uRvxbZZ/3RHbCnEmxtoB0rEK2bQfHSBCQI423UlVXUhhvuz
	 scEknNMvShOD1ViZIsSv8blNgyLqkj7lRFi8kN8Nd3DitECIeipU/SQ2DAcjasdKi9
	 6/Q7a9K8g2D2g==
Date: Thu, 10 Sep 2026 01:55:38 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Li Jun <lijun01@kylinos.cn>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm: cr50: use DEFINE_SIMPLE_DEV_PM_OPS and
 pm_sleep_ptr()
Message-ID: <aqHj6sV0-vtEps3o@kernel.org>
References: <20260909025857.206617-1-lijun01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909025857.206617-1-lijun01@kylinos.cn>

On Wed, Sep 09, 2026 at 10:58:57AM +0800, Li Jun wrote:
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
>  drivers/char/tpm/tpm_tis_i2c_cr50.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
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
> -- 
> 2.25.1
> 


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

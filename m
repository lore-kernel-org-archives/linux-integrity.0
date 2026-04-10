Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C25E3A7844;
	Fri, 10 Apr 2026 21:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775856128; cv=none; b=MlsZIcyX7YIh6VxaF8du+88wtnGeWOWOu//WWgEpzWGe8i2oklhpEmldM1vAIzCwCpVYXI/aozxiDlw+PhvjBwTlYIr0NIsEsStfhnzkWnTCj3pPDpVzth+p2HSMEy3FN2H8Oy+kU4XoupDMaDyQGqkWWH2niEMLhPh1ALcuzcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775856128; c=relaxed/simple;
	bh=WoNeDqGPNna8+1ZONE7iaFqpncChQUctQshNBds29YU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZRnvgd/SpI6KdU+cElwtKsVaoRTZeKp10PxGaHyZdXxldssghqPfYcjHXaqBWY6G7JEpbBvi/wWtTNONXDg6hbSP06LFK/209KVhh7qV/C6leKHKG5Rsi6jdaJtTDnv7XAHGdiRzpHKR5CEb6n1du64umThOxd9yrmKYE1Kd5k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.1.112] (dynamic-077-011-040-087.77.11.pool.telefonica.de [77.11.40.87])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 32FEA4C2C37D77;
	Fri, 10 Apr 2026 23:21:50 +0200 (CEST)
Message-ID: <6f67d0f9-43bf-42fc-af84-5c24ad560594@molgen.mpg.de>
Date: Fri, 10 Apr 2026 23:21:45 +0200
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tpm_tis: Check for an error after exhausting send retires
To: Jacqueline Wong <jacqwong@google.com>
Cc: peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
 Alexander.Steffen@infineon.com, linux-integrity@vger.kernel.org,
 linux-kernel@vger.kernel.org, axelrasmussen@google.com,
 Jordan Hand <jhand@google.com>
References: <20260410211350.1132611-1-jacqwong@google.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260410211350.1132611-1-jacqwong@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Jacqueline,


Thank you for your patch.

Am 10.04.26 um 23:13 schrieb Jacqueline Wong:
> From: Jordan Hand <jhand@google.com>
> 
> tpm_tis_send_main() will attempt to retry sending data TPM_RETRY times.
> Currently, if those retries are exhausted, the driver will attempt to
> call execute. The TPM will be in the wrong state, leading to the
> operation simply timing out.
> 
> Instead, if there is still an error after retries are exhausted, return
> that error immediately.
> 
> Additionally, add logging to more easily determine reason for transmit
> failure.

Please paste the logs without and with your patch of an effected system.

*Additionally* is often a good indicator to split the patch into even 
smaller pieces. ;-)

> Fixes: 280db21e153d8 ("tpm_tis: Resend command to recover from data transfer errors")
> Signed-off-by: Jordan Hand <jhand@google.com>
> ---
>   drivers/char/tpm/tpm_tis_core.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index e2a1769081b1..b78937841879 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -471,6 +471,8 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
>   		status = tpm_tis_status(chip);
>   		if (!itpm && (status & TPM_STS_DATA_EXPECT) == 0) {
>   			rc = -EIO;
> +			dev_err(&chip->dev, "TPM_STS_DATA_EXPECT should be set. sts = 0x%08x\n",
> +					status);
>   			goto out_err;
>   		}
>   	}
> @@ -491,6 +493,8 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
>   	status = tpm_tis_status(chip);
>   	if (!itpm && (status & TPM_STS_DATA_EXPECT) != 0) {
>   		rc = -EIO;
> +		dev_err(&chip->dev, "TPM_STS_DATA_EXPECT should be unset. sts = 0x%08x\n",
> +				status);
>   		goto out_err;
>   	}
>   
> @@ -552,11 +556,16 @@ static int tpm_tis_send_main(struct tpm_chip *chip, const u8 *buf, size_t len)
>   			break;
>   		else if (rc != -EAGAIN && rc != -EIO)
>   			/* Data transfer failed, not recoverable */
> -			return rc;
> +			goto out_err;
>   
>   		usleep_range(priv->timeout_min, priv->timeout_max);
>   	}
>   
> +	if (rc == -EAGAIN || rc == -EIO) {
> +		dev_err(&chip->dev, "Exhausted tpm_tis_send_data retries\n");

Please also print the number of retries.

> +		goto out_err;
> +	}
> +
>   	/* go and do it */
>   	rc = tpm_tis_write8(priv, TPM_STS(priv->locality), TPM_STS_GO);
>   	if (rc < 0)

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

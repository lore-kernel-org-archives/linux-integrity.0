Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794690692;
	b=Ps+pMIzrvOoWg7izdZo8LBy4+EgQKfe8AA8u2j7nkBBuuiHNwvCPlUzbcmZMqPSpnBCG
	 NJ7rlZU2IIHTb4Qr+X8tUzE92E42x0hXm9+O1c8HWQbWFL3pyCY70ftvMOWy3M3vJfnz8
	 vwJCeyN6orLIMgAI2iPXeuyNewTAhRjT0DbEcdpobBUCMztyUJdlq9UAuHj0qkyDoVUmD
	 wVuP3vQmQyphQOeNh95nG3YqCYwKWGzq6efyyk3KQfC4r9A7COlVWI9TDVazAc9FEkNwE
	 Ff786n+Y2jIhcN3SZqgEcMFij9Q1BSr+rgfl92VFNxNj5+dOErItvI90PneTnTJXqyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794690692;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Ab/t9OlRcWN3zbc3eY5ad8JX/kABGcfzSiIaPltDaFA=;
	b=XyrDACW0GtQxklGS7hgMXoj59wZ3z9NHgX8cszO7LM9GWgpicJof+5biMfLx+65fMQ+I
	 m+2ZAZ7Pv+JkpJhqump9vUR9rZWczSf+PTSib/DvFgT3WyZXXO4t7LRZ2IAgE60692UOG
	 r9N9s2njLBGGD94vr3bm9RlP6HlvdHklhJmGOKGQ9gAgNQapBVvEsHNTuxb6BlcyHI3iD
	 6v2FCPt3IDVRLVbsW4jnliqa5FL9rOruHQcvxoVv3iGQtTda2p4G9m8i+O0xqd6jxHkRx
	 pYprpsypsrKgI+tf9mCtrcYR8GRnGJF9iL3cIwZRf5Pq79Z9xOWuC3dltUr9KFePEuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Epo60wIk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id B343C606A329;
	Sat, 14 Nov 2026 21:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Epo60wIk
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id F3CC61F000C4;
	Sat, 14 Nov 2026 21:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794690692;
	bh=Ab/t9OlRcWN3zbc3eY5ad8JX/kABGcfzSiIaPltDaFA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Epo60wIkMirZbSuxFm2i6OvGJPLDjpxK4I8tjwGqzpNdVC1VYb4sVpiEtJ9w3UsVD
	 /qopc2LRxxbPt2eT/+8B6gAbGKht0K1psVVsuskdwHK0yPK7/cpe22sO5W3ZOJGF1N
	 cGg4LyPSdN/9jlFAlpe2EJtSlkOYgWBLuoj51EJsJh04ZGjzHe5NC/gfGfSEaknhjT
	 30E885Bri4EQ1PkYXzxmlDf0zLt6h9uEuSdZSvDS4mTg5oSz9EuyKrX6+Opl6Bv+Jd
	 249hMrANIWsjTuVQ2hOtMFVXbrk+CyC8zvpxE0PPNlcqNpKkaFh3H5EK7EJxOPnGOM
	 WhjIBtQapX4GQ==
Date: Sat, 14 Nov 2026 23:11:28 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	Stuart Yoder <stuart.yoder@arm.com>, apais@microsoft.com,
	rlmenge@gmail.com, hargar@linux.microsoft.com,
	linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] tpm: tpm_crb: Use cached tpm2_acpi_start_method
Message-ID: <avjOgDySmUiklnN1@kernel.org>
References: <20261114193434.117714-1-sidchintamaneni@gmail.com>
 <20261114193434.117714-5-sidchintamaneni@gmail.com>
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261114193434.117714-5-sidchintamaneni@gmail.com>

On Sat, Nov 14, 2026 at 07:34:34PM +0000, Siddharth Chintamaneni wrote:
> Check the cached tpm2_acpi_start_method value at the start of
> crb_acpi_probe() before mapping the ACPI TPM2 table for CRB-specific
> parameters. This avoids mapping the table when it is absent or when the
> device uses ACPI_TPM2_MEMORY_MAPPED and belongs to tpm_tis.
> 
> Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
> ---
>  drivers/char/tpm/tpm_crb.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> index 4749a9183726..c1c2b72459a2 100644
> --- a/drivers/char/tpm/tpm_crb.c
> +++ b/drivers/char/tpm/tpm_crb.c
> @@ -945,18 +945,23 @@ static int crb_acpi_probe(struct platform_device *pdev)
>  	if (!device)
>  		return -ENODEV;
>  
> -	status = acpi_get_table(ACPI_SIG_TPM2, 1,
> -				(struct acpi_table_header **) &buf);
> -	if (ACPI_FAILURE(status) || buf->header.length < sizeof(*buf)) {
> +	sm = tpm2_acpi_start_method;

sm and also priv->sm should be removed

The global should be accessed across the board when querying start
method. It should be the single source for it post-tpm_init.

> +	if (sm == ACPI_TPM2_NOT_ALLOWED) {
>  		dev_err(dev, FW_BUG "failed to get TPM2 ACPI table\n");

Drop this message.

>  		return -EINVAL;

-ENODEV


>  	}
>  
>  	/* Should the FIFO driver handle this? */
> -	sm = buf->start_method;
> -	if (sm == ACPI_TPM2_MEMORY_MAPPED) {
> -		rc = -ENODEV;
> -		goto out;
> +	if (sm == ACPI_TPM2_MEMORY_MAPPED)
> +		return -ENODEV;
> +
> +	status = acpi_get_table(ACPI_SIG_TPM2, 1,
> +				(struct acpi_table_header **)&buf);
> +	if (ACPI_FAILURE(status) || buf->header.length < sizeof(*buf)) {
> +		dev_err(dev, FW_BUG "failed to get TPM2 ACPI table\n");

Drop this message.

> +		if (ACPI_SUCCESS(status))
> +			acpi_put_table((struct acpi_table_header *)buf);
> +		return -EINVAL;

-ENODEV

>  	}
>  
>  	priv = devm_kzalloc_obj(dev, struct crb_priv);
> -- 
> 2.45.4
> 

Br, Jarkko

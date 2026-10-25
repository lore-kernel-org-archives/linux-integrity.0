Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792961949;
	b=AzHUR7+7njkr5dBgxyO5r0tLz4f9LzhG5tqQbBIvmebfb8geOwqhcuQLt8lT1e2ozlfm
	 zx/6WQEWnp5kYhwut2qauk4QJ/GNjRfhjj5MdGSpiCwSG5zYye2SHk4QK0Kmvxwbnrh8x
	 8rI6tsSnNORpi/lCS37zOzDoPSl9c/PhyPSmMvZBJQQRPzecRD2JSHhb6HpIL0DdtZ1ub
	 DZEEK+bwF4gc3Z1NMBK4SOElgRwTVUrt6xAzxODHeseQcrHWhbMM5tNU95/oldAXYAzWW
	 t6/+obxpigKlEc0ZIrwgXk/uEBhNm6tBPf3tsQkTihzWSNcRg517qd/xhlhp02nep+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792961949;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=KGV9PGyefYQEXPmzyqN4rLFVcnJ/AanP4m6aiT1xkR4=;
	b=ctQAsSg2NsLfNo32D1tFYg2xuJ8fKyPuHVrgGt2AvFMhsWT7/VKGNPLs+0KxQLDU3hyS
	 Ab6yOdfuBbkqArgEfE1E/nKReVJn8fhscKeDHQLaN8xu2BdUY2WHHcrx7HBxloi1tj0oa
	 pov2BC2aTtQY99pK0kY46j5cwQVPdPpUnlOBu3RBelkY+5vtjgfLvj57Zat87hwHcal7R
	 XRfjgYsfPHU6ki1ARKMD4Me6rFblftork1WktQ+aNa2TQol3rDLXCLzLwMRAizT8pgZdi
	 Cr7PN7+z8S5G7r6KomA8eDipFb9MxwUSkuhDgEmvqQ5guynYHeeEjY//QsPbKqbhK4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ewmm4BKG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 23926606A31A;
	Sun, 25 Oct 2026 20:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ewmm4BKG
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 3667C1F01829;
	Sun, 25 Oct 2026 20:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792961948;
	bh=KGV9PGyefYQEXPmzyqN4rLFVcnJ/AanP4m6aiT1xkR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ewmm4BKGrzRwTlQYtOi10aRtz9cED9zEvCczhcx0N+r+gGLDCPcYV/C63Nl7iErNL
	 QrAsK3sbq2zh6EBprLI1jfhQOsPtEaUDuXYET1Iuv6hdhJt2lR3gyZ6IMzPYxyC8L/
	 zFevRJrY6dtOK58yqoi5bvGtlGv4VTtC8SWyQ6LE7cIRSJpgN4xMtym2yRTveaf1Ho
	 cOcoD7wF9FSbdHeqQoDfswVwnheFZDFS0KfZEEBjFkhy+FMmj+/87BUt18R1ALZIfW
	 K3UDORxtp0VrWy5HPp+V496n71OV239xTF+2yGQBIyHZrs974FlWUpSwexutHxECda
	 kEbivq8EnVDUA==
Date: Sun, 25 Oct 2026 22:59:05 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Arun Menon <armenon@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v4 5/6] tpm: Increase TPM_BUFSIZE to 8kB for chunking
 support
Message-ID: <at5tmTYX7ZjO_Q2m@kernel.org>
References: <20261025201859.221991-1-armenon@redhat.com>
 <20261025201859.221991-6-armenon@redhat.com>
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
In-Reply-To: <20261025201859.221991-6-armenon@redhat.com>

On Mon, Oct 26, 2026 at 01:48:57AM +0530, Arun Menon wrote:
> From: Arun Menon <armenon@redhat.com>
> 
> The size of the command is checked against TPM_BUFSIZE early on before
> even sending it to the backend. We therefore need to increase the
> TPM_BUFSIZE to allow support for larger commands.
> 
> For now, 8KB seems sufficient for ML-KEM and ML-DSA algorithms and it is
> also order-1 safe.
> 
> Signed-off-by: Arun Menon <armenon@redhat.com>

In what timeline? Or is it out of spectrum timeline?

> ---
>  include/linux/tpm_command.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/tpm_command.h b/include/linux/tpm_command.h
> index fc446a1282e2..4ad11068b090 100644
> --- a/include/linux/tpm_command.h
> +++ b/include/linux/tpm_command.h
> @@ -434,7 +434,7 @@ struct tpm2_context {
>   */
>  
>  #define TPM_DIGEST_SIZE		20	/* Max TPM v1.2 PCR size */
> -#define TPM_BUFSIZE		4096
> +#define TPM_BUFSIZE		8192
>  
>  /*
>   * SHA-512 is, as of today, the largest digest in the TCG algorithm repository.
> -- 
> 2.54.0
> 

Br, Jarkko

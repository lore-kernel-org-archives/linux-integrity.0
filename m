Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793300109;
	b=0yPJHTrlAatFlLkfrQmphPbESXOHlb3LD6DtTRDaIRCvr/Y/03J9O2iI5mifW98vegyI
	 h708IUvL7vM5eOC7RZZv4/0RivQ6pD/1O5f12bkdTaJMdl31RFsic7FwP2vgaV+WazxF6
	 bFtDRlPKE9Br79QCy7y09zuw7Hemc+bwzUx7Etm5goQTqC6SMSIcmA0BR3FYBhbwC8g6v
	 N8V0hwSSQd8A+lu6bLdsiwu6wnIF7JEsu3i5zybWIg5ZYuXSE4gbawfzgdN1okSlPP199
	 90M6gGEdEYmhDEQ0CbbYrsHJj2D6Z9mASN0z7Hxj3WSwa10AaJb716RADwOnf7oepmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793300109;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=38enHGzZbRMY5MzhDG7NevDj9M9rSop00+ZOozP8nYw=;
	b=pNP2ojDTOLixm3XPojNSQoKE+XTJD0YbS+XaNchiO42bCFhhFkVv0wQ3b0biiQlF7SfR
	 vg2cZnSFTfmoeLhlk+y6ukddIvZODiGEhh4BFfOzXHyV4CPJ0lOfSEXDNLPa8x3m3JFDq
	 jRnhAuqsvZ1JjR/MQ10LANq1d3D/Ckj57aSFaXTEFzoPVEXHdb2+eHkBmAGiAetb68E79
	 hJpyap5eVNssI4s45hQW0llBxFpoebCI5rbaUx637khy3lPYsJmsv6V+pKECTmOfCpN2l
	 wOz5iM0QIHfz3NZ4BqgSAFQQxOOqhQNXo2/4/vSCU6qtFSKlm1w1q5juH64HE6nd9SQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=magOWvZO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id EEE29606A331;
	Thu, 29 Oct 2026 18:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=magOWvZO
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id F3ECE1F01826;
	Thu, 29 Oct 2026 18:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793300108;
	bh=38enHGzZbRMY5MzhDG7NevDj9M9rSop00+ZOozP8nYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=magOWvZO8kqeKhGNN9P1FdOWms45OxtPynyKc1l+h9WHBUNxHDxuxnzqaBvKQ68yB
	 jmW/5fYkMFCOO03pFDtnFaI/LqGwD69cH/savMLZPL/aK19zRXKOKY8sSkvwHqwuzj
	 O4TkUjoLrjQHflq0TOJR6rdsgNTsGlE29/mr2yV5yRUJFX6IuU4JqWWFzz9ZwNTnWz
	 b3XY6lmv3wjJ9MM2n1QAQ8mswIeCWPP312I5Rcd2Aksp/T0da+0roRJLkMmgE/pqzF
	 m7WXyuE4YJVsy37aseJ5RJjLxILIyoFN/cgg5Emk+W2T3Ukj3WCAFj84wmn8FG/3ts
	 3kfG0vRgHsEpg==
Date: Thu, 29 Oct 2026 20:55:04 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Arun Menon <armenon@redhat.com>
Cc: linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
	Peter Huewe <peterhuewe@gmx.de>, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v5 5/7] tpm: Increase TPM_BUFSIZE to 8KB for chunking
 support
Message-ID: <auOWiCsW73yO33Zs@kernel.org>
References: <20261029181541.99505-1-armenon@redhat.com>
 <20261029181541.99505-6-armenon@redhat.com>
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
In-Reply-To: <20261029181541.99505-6-armenon@redhat.com>

On Thu, Oct 29, 2026 at 11:45:39PM +0530, Arun Menon wrote:
> From: Arun Menon <armenon@redhat.com>
> 
> TPM_BUFSIZE limits the TPM2 command the kernel builds before handing
> it to a chip driver's send() callback. TPM 2.0 Library Part 3:
> Commands v185 adds ML-DSA key objects and the ML-KEM
> TPM2_Encapsulate()/TPM2_Decapsulate() commands (sections 14.10,
> 14.11) [1]. NIST FIPS 204, Table 2, gives the largest ML-DSA
> parameter set, ML-DSA-87, a 4896-byte private key and a 2592-byte
> public key [2].
> Loading such a key pair with TPM2_Load, plus header, handle and session,
> comes to roughly 7.7KB - more than the current 4096-byte TPM_BUFSIZE.
> 
> Raise TPM_BUFSIZE to 8192 bytes. It covers this command with
> headroom, and keeps every kzalloc(TPM_BUFSIZE, ...) call in the TPM
> stack at an order-1 page allocation rather than a higher order.
> 
> This matches the largest parameter set defined today. NIST has already
> published PQC families with larger keys and signatures than ML-DSA
> (e.g. FIPS 205/SLH-DSA), so a future algorithm could exceed 8192 bytes.
> CRB chunking, added later in this series, does not change that; it only
> lets an already-built command cross a smaller MMIO window in pieces,
> it does not change how large a command the generic stack can build.
> 
> [1] https://medias.cdn.trustedcomputinggroup.org/production/Trusted_Platform_Module_2_0_Library_Part_3_Commands_Version_185_pub_87a5c10230.pdf
> [2] https://nvlpubs.nist.gov/nistpubs/FIPS/NIST.FIPS.204.pdf
> 
> Signed-off-by: Arun Menon <armenon@redhat.com>
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
> 2.56.0
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Br, Jarkko

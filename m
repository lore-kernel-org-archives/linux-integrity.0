Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB4B30CD85
	for <linux-integrity@vger.kernel.org>; Sun, 12 Apr 2026 23:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776036782; cv=none; b=ahoda78aAl1FRsg7HmC2zEZfOXRs1H5IlI1HLg4eR5fXqskHUFg8bmFq3WwmE+SQP81oMrjTzjpJgDhGwvS56MGCdSdwtqNaae6CaMNDd+JTGIRtFnvyuqX72drbJQwYHCTduWhZmEl4zVwCiL7rMIHCoUDM9dyJREKx8Mvb0eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776036782; c=relaxed/simple;
	bh=UFSlE3UXQ9LEmxvItZMgd83uquNcW9IIfWMBClhc07E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Owudou9K9RC2ZdDno1K1Fo9e4TTdz4QTcof86/RIAYZaDLDC2pPiC+FKMK0kxFnaK8YDDGVBlyhB/nrdWCQarO2MTA6nZOiOFBRovLMivZCG6bgQrSCMaYMndSU/j0Q5+oEeBMVjYpt/H1dtOTikQgWo+Rzjfj6x3QBqBBb1/B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aCH7g6dz; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aCH7g6dz"
Date: Mon, 13 Apr 2026 01:32:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776036776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KKwxsY9Hn8TMNjKzskVbVHGt5GYXbTz+RMB1WacfQ6I=;
	b=aCH7g6dz2aZcYP19MX3HuaVKfgSAPhgShTaMffRPGz4zTqtTPGhdJo2ZK8vOAcw7exkDz5
	ISDYIc2AqPn8a2+06nOVvQRmOgsILlppYH0NphKjvpe63hslwGFUIDR6JqpF/4TSoJ6r7O
	9dx6QPUNBiquV6mda7PW7+FKWDEd6dc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, Matthew Garrett <mjg59@google.com>,
	Bartosz Szczepanek <bsz@semihalf.com>,
	Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: aovid -Wunused-but-set-variable
Message-ID: <adwroOsSnGrGi5OM@linux.dev>
References: <20240322132307.907203-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322132307.907203-1-arnd@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Fri, Mar 22, 2024 at 02:22:48PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Outside of the EFI tpm code, the TPM_MEMREMAP()/TPM_MEMUNMAP functions are
> defined as trivial macros, leading to the mapping_size variable ending
> up unused:
> 
> In file included from drivers/char/tpm/tpm-sysfs.c:16:
> In file included from drivers/char/tpm/tpm.h:28:
> include/linux/tpm_eventlog.h:167:6: error: variable 'mapping_size' set but not used [-Werror,-Wunused-but-set-variable]
>   167 |         int mapping_size;
> 
> Turn the stubs into inline functions to avoid this warning.
> 
> Fixes: c46f3405692d ("tpm: Reserve the TPM final events table")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/linux/tpm_eventlog.h | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/tpm_eventlog.h b/include/linux/tpm_eventlog.h
> index 7d68a5cc5881..6e5be15029fb 100644
> --- a/include/linux/tpm_eventlog.h
> +++ b/include/linux/tpm_eventlog.h
> @@ -131,11 +131,16 @@ struct tcg_algorithm_info {
>  };
>  
>  #ifndef TPM_MEMREMAP
> -#define TPM_MEMREMAP(start, size) NULL
> +static inline void *TPM_MEMREMAP(unsigned long start, size_t size)
> +{
> +	return NULL;
> +}
>  #endif
>  
>  #ifndef TPM_MEMUNMAP
> -#define TPM_MEMUNMAP(start, size) do{} while(0)
> +static inline void TPM_MEMUNMAP(void *mapping, size_t size)
> +{
> +}
>  #endif
>  
>  /**

I just stumbled upon the same problem and found this patch from 2024,
which still applies. I cc'ed the current maintainers - maybe someone can
pick this up? Thanks!

Reviewed-by: Thorsten Blum <thorsten.blum@linux.dev>

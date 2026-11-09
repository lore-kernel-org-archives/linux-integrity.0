Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794237950;
	b=rOIdj3ehEpnlZhi/NAgVPzTIc8cXwyI+wX9n93KN8MCopff7urf5Noc8H3m8OxhJveo6
	 Bmi0RM9GxR2fOGu9t8P+1VZCzNm9nxtHpOr4QJZP96B4yo5vDP73e0I+aziNoao6N8aIz
	 Aibt7/x/omCsli6RZOJqSpXs9vIg4D0zzA8p+0/+ECrMvpz7bOXgNNgkqaBHnI9euVxNi
	 LlWcohg5GDI2MWMFvu+E6AvyUBkOy9zp2aXW1SE70rM92vSqBPXXOpstmKcygrVlGobE3
	 915mt5OuBVzO+0qXErRGe4DM2GsCGWLgx7RW9wcQugxNquUa19nO/kOjy8/XimX2/tQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794237950;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=4263mtKXKKoNqH4huNX2n14ORi1Z79O1WQ7rm0WWYFs=;
	b=uFvb9nASb7Ngd9sftGEAmJ1sK3lEk9QBrg3gAjzP6Yvdw339eaoO/+f1OThlXXybOXiz
	 2jZAzMcg+69SyaIfPq8w/eLUrMhishOoFBO25+2NlCS6W4kPkki9FUA2+5yNm+uax3huU
	 Pj1KU4AmctBinIF7rNYHZV43NJ5tGyiLjOEZdxrTI+v33LYLsNRN2mgsyqmqdyY/keAKt
	 KUKcdllGu4yFvdpeJNUo/PTq9dku3GpX1BjnCwvtCzJbgd4zZv/F9WHtqJrqYSnlgbpxI
	 +nqIisgFI6lVmWB+2Fy2aRne7ZdUaCMUjHzyB1GSAXGgjsLdD+605ELPmfuvCUd5/3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M+y89fNA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id E0F81606A321;
	Mon,  9 Nov 2026 15:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M+y89fNA
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id DE6191F0089F;
	Mon,  9 Nov 2026 15:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794237949;
	bh=4263mtKXKKoNqH4huNX2n14ORi1Z79O1WQ7rm0WWYFs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=M+y89fNAvHoUw9A7TWlhNt85e5LZFvXaHbsSLLaIDbsRUFY5JD+FR2i4M+Ra2zyLw
	 ko7U5zmllvV9qktJgZHLT99akhjvMIvj7Ub6dQopecjB35ydeA6p5pwLX5nSLMeunQ
	 dRwU+XpJ/cEOyndp4qzIJeqE8IrtviODXTErU+KTxvDL/WfyUS8tXBIwPKZKRCV23r
	 Zh1lbE5tqGIwGVkMYiw0If5x5hXyPdBLc/IayiKx94lhCKB9uiIaIb/SfpiSsnnxdZ
	 JYSFw1V3HaDs51WP6SRZyLeoo2xCj7HuZo3533iuQ15655dnhhnX8gPakL5fjxY2f9
	 WnQvGS4+o8paQ==
Date: Mon, 9 Nov 2026 17:25:45 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: acpi: Fix memory leak at tpm_read_log_acpi() error
 path
Message-ID: <avHl-WoBP73QjInD@kernel.org>
References: <20261109082527.541901-1-tiwai@suse.de>
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
In-Reply-To: <20261109082527.541901-1-tiwai@suse.de>

On Mon, Nov 09, 2026 at 09:25:24AM +0100, Takashi Iwai wrote:
> When devm_add_action() returns an error, we do NULL-clear
> log->bios_event_log unnecessarily before calling tpm_bios_log_free(),
> and it would lead to a memory leak of the allocated log buffer.

I don't understand this. "NULL-clear" is gibberish when the actual
bug is just spurious clear of log->bios_event_log. Also we are not
doing anything we are not computers.


> 
> Fix it by simply jumping to the err.
> 
> Fixes: a3a860bc0fd6 ("tpm: Change to kvalloc() in eventlog/acpi.c")
> Cc: <stable@vger.kernel.org>

Put Cc before fixes.

> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  drivers/char/tpm/eventlog/acpi.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/char/tpm/eventlog/acpi.c b/drivers/char/tpm/eventlog/acpi.c
> index cf02ec646f46..50770cafa835 100644
> --- a/drivers/char/tpm/eventlog/acpi.c
> +++ b/drivers/char/tpm/eventlog/acpi.c
> @@ -167,10 +167,8 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
>  	}
>  
>  	ret = devm_add_action(&chip->dev, tpm_bios_log_free, log->bios_event_log);
> -	if (ret) {
> -		log->bios_event_log = NULL;
> +	if (ret)
>  		goto err;
> -	}
>  
>  	return format;
>  
> -- 
> 2.53.0
> 

Br, Jarkko

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=141.14.17.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794307439;
	b=jD09RcLvgbvX5kTLUORfsiOLvMjnB1fHAMEKqFUO3uuSUF802BYJTRGexR1qfh2VQC6q
	 X1rZpcLWtHntFaMSZkMeTXF6fO3TXVFu2P25Lrwa4LZp+m6OWm0NdIasO7jMYeG56zqsI
	 JrFVk025c88Y9Egm+pT4I9kzsNnrWmouIJqrBLFhXqj2AtSBnYYeyZX7QzhDBJc8OM3D+
	 XSBSPqQU0o7XGkGNDH230Y+OYXTyLbI6bXtIagCCcJLgFDZhlVQXVvGPIqdXuhvbM9NZM
	 bKjwO0Ze+5CbiC3noyWAaZCJd0ZePMXDUd4Q+F3ggvz7FiPLCYT78d2s3Cjm0cnctjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794307439;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:DKIM-Signature;
	bh=ZUbmzk8qO4N9no4tHIH3lHXwSekRLbsqMpC5Zn6q6P8=;
	b=iPg5y+mhceXT8y627gQffBRFaiTd4IHbS68DU4BReM+/Zk5Mu1m2JLK2xpnQQEFcfTzY
	 BL8Y3BGt3jhzUnr6JJxY8lCdDHUbOy5tQv6ntKlD8FGFTMNdpnc3l50weyBWkUxp2X/n2
	 zGnkFaSO/POg7kZCT7zygtySpWs70ADa8VqhecK5UzVNKQ48jsHh3c6YbljIx/cKZm+yg
	 g5RuxWnq/fEBIT/y3fdY5/hvWYfheNv66F4w2J9eUkLn4RAUiwTLYqzxBZ0c+IKmarHOI
	 JfAvBjcHFkSFeXpDOb+Wq17K8HcmdlH8zn+IsPFKzCEiiq/9hTLPfXqXjFo0RHOt96g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=molgen.mpg.de;
	spf=pass smtp.mailfrom=molgen.mpg.de;
	dkim=pass header.d=molgen.mpg.de header.i=@molgen.mpg.de header.a=rsa-sha256 header.s=20260906 header.b=L9aJ5f9a;
	arc=none smtp.remote-ip=141.14.17.11
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217DA60A260B;
	Tue, 10 Nov 2026 10:43:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 217DA60A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=molgen.mpg.de header.i=@molgen.mpg.de header.a=rsa-sha256 header.s=20260906 header.b=L9aJ5f9a
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 60F254C4DAFBB6;
	Tue, 10 Nov 2026 11:43:32 +0100 (CET)
Message-ID: <4674faa5-47a6-4486-815e-a5a3a5275d69@molgen.mpg.de>
Date: Tue, 10 Nov 2026 11:43:31 +0100
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tpm: acpi: Fix memory leak at tpm_read_log_acpi()
 error path
To: Takashi Iwai <tiwai@suse.de>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, Peter Huewe <peterhuewe@gmx.de>,
 Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261109173756.742248-1-tiwai@suse.de>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20261109173756.742248-1-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=molgen.mpg.de; s=20260906; 
	t=1794307413; 
	h=from:from:subject:date:message-id:mime-version:content-type:content-transfer-encoding; 
	bh=ZUbmzk8qO4N9no4tHIH3lHXwSekRLbsqMpC5Zn6q6P8=; 
	b=L9aJ5f9a6gYtthCxLRAe7A0MUqXQbpJ9EXdELV/yYRP4HrPG8jZBdJQmbJ1m5LAVgrLKQGaFEq5E
	W5cUb32zkKtTl3l9Vo2EWKQIPdP4DNyNoi6URZY8oT4nrUja7yphchodGG25kdO5cDUjOd/Hbra7u4
	Lp2Lf/L7J6CRad5I5BcFQbH7KpajigIfi8Mn2s9qQue7QLiBOdiSn3kJbrsmx9LqU5Eeu9bjrQGh10
	9WqKq8PLTxYFoMEGld/tZdkdkq2XcoxjbIb5FYy10e+hD3ia3zq8CQLBlvp1c4/+1BTkiLGyrT85qU
	xM0VNsfZN0e+k0yYUf9+WYJc9O+70Ldw==

Dear Takashi,


Thank you for your patch.

Am 09.11.26 um 18:37 schrieb Takashi Iwai:
> When devm_add_action() returns an error, tpm_read_log_acpi() clears
> log->bios_event_log unnecessarily to NULL before calling
> tpm_bios_log_free(), and it would lead to a memory leak of the
> allocated log buffer.
> 
> Fix it by simply jumping to the err.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: a3a860bc0fd6 ("tpm: Change to kvalloc() in eventlog/acpi.c")
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
> v1->v2: minor update of patch description and tags order
> 
>   drivers/char/tpm/eventlog/acpi.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/char/tpm/eventlog/acpi.c b/drivers/char/tpm/eventlog/acpi.c
> index cf02ec646f46..50770cafa835 100644
> --- a/drivers/char/tpm/eventlog/acpi.c
> +++ b/drivers/char/tpm/eventlog/acpi.c
> @@ -167,10 +167,8 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
>   	}
>   
>   	ret = devm_add_action(&chip->dev, tpm_bios_log_free, log->bios_event_log);
> -	if (ret) {
> -		log->bios_event_log = NULL;
> +	if (ret)
>   		goto err;
> -	}
>   
>   	return format;

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

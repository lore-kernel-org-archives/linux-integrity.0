Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793267252;
	b=TVoWJmnf8opYMtDwowih9KVDMnOcFiPodI0kx3m7fJG4gBKWfbtqe2dCIdZxXPprjZNR
	 USkNEDxQbsAgolBHTpYbLYIqtBoDwNFvDl+QawQ5v4g+tbLzdSnVlgcFa/K+SDG8YkgMz
	 tzU2gSgOdO080mr03OSFyAFOXO3dW3Hdl8c23tRd899/2YwgADw0h/T755zUV4/3f54LG
	 5BIOQQ9FfOpDvmcovMvG59NogZGLDZ72jTDk6a2Y+R0769RqSGGGWK4fSSnm7w8XW/e1c
	 REN0TxLdwIOG2dd5YFEfg51E2wPkRLiF7T3U0ZIjDCs1/a5x6gThQvVHJIKPPK/1TEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793267252;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Ycc/PH2cYi+TSN+J+t9gob/x5tzRRSZ7oT2i12vrEeo=;
	b=c2KgAgTVhpwSKx0aHhTz4DE5eSICeqvgSn/d1yN2L2iVJBlCbqFiotbYoliQURgHPdiQ
	 Z7qRH9Ln5TynYuHwEP2Tl6a4G2tZgaO4ChygYSG+38Fc7VjQnMw0vMK24VnJPxbQDr8PB
	 zUk+gO69wdLDOTKocfe+32poNCq3+a6Ei9wlX0kQzHhTCYr1bMBFxEK2tUw5eGe9VYZMF
	 JQLl5/s+cQBeDX+CJ1bFXLmdWuJ9zTiHu1UJSkspmbDD3jGNwH59CW6GTqJMoUfArBlay
	 ncmOxapJZ5hkajnylwG9YHBFcZ47VonQ7DRmy8ZmQvMQccOr2t4NpajMqNCeWffD2WQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Lgyz8mcU;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D63F606A31A
	for <linux-integrity@vger.kernel.org>; Thu, 29 Oct 2026 09:47:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D63F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Lgyz8mcU
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48b001cd92bso1021298f8f.2
        for <linux-integrity@vger.kernel.org>; Thu, 29 Oct 2026 02:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793267250; x=1793872050; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ycc/PH2cYi+TSN+J+t9gob/x5tzRRSZ7oT2i12vrEeo=;
        b=Lgyz8mcUhNcUCDD5IEgfORz4mjRCOlDMVVZwXGyb2XgMasHxukqOAIuKTL2qS/xJIP
         jgZapcJ0sUEYf4GVksTsDeJAqNs6EWdkm8X178i1GQbXOWqA8w8+46IqC0e4+fOnYImb
         1xhcpRSy2WEn5LddmoGNxnkeQz90AC1DU8lRmAbcT19a4zfE6Pr99gA/ZdyZMbarp68x
         DRITRdMplt4ZBZ29SiA3eVqwysyChFxjDrvS+njESvzAgLWWEZFfkZc/PDvU0QwbkcbK
         n+LLceh6Tahq7Tz+dEsN4thuPk7gixUoM9V1KFokDx7Cl6xACPtmGPaxXZirYufIAE9O
         wT0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793267250; x=1793872050;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ycc/PH2cYi+TSN+J+t9gob/x5tzRRSZ7oT2i12vrEeo=;
        b=rXIzIifkjdPIaRnW2xR4nLtX56VCVdUPBe2aOYe8I0wC7zgv4b1eXoNNcVPMEsRoSf
         DzvOuIAA46cLrpa5m1rhQTCrFi7NzPokFjza9Vzg8IHpiCTScalq8gWg5clbVq8RUwyP
         J3QnuOqPuC51cHiJhrDEjzzDl3AVri0flJA7nj+7NSc5awQ8f3hoAKLCMRtVEPYI3vJ5
         oTZ0jsYvfelsuM0XJunNfJBak6Ja+WxwWpRkWu5IeRUzezf4Yt1W7bpR0RxoWFd5xI67
         xjnA2JSVlPB4dyG1rW/Qi6eQZnwTattxQEST0TU11q+SUax4kbdwygEDC6mz4NJMY8WA
         YHDA==
X-Forwarded-Encrypted: i=1; AKwUvBwbsHU0zrupp5TthGyGezIB6n1aU8v1Xazpk62GTiSkHgEaa0fKlfS+Vul/4c0yXVjxpCwlI8on+WbaGgPUr7o=@vger.kernel.org
X-Gm-Message-State: AFq9FYKSV1Sbt/en0DgbeMX1vpE15MdwnlJ73GrQ4Tlj4MQjmh/vZw7m
	QgzapZKRZlGvfRLmoiu4EgNEFiQ61PyntXW0Tq1vYz12iShdTfzb7wr95oKdeleE
X-Gm-Gg: AYBFou0UdcLi+ZKfWLrL3/gO7f0YD6cIBoxyCYT4mVrQbvfCGu5b6GUiHJZUxl+Wldc
	y17u0GBDNXTD2UGUcqxh3vwAD1pKrPcGBKAfuFfIQC9ozQOrtmsBmjiOPvu52MzZFMtkuR2sj9c
	wc+YmrlWA4GwVxeysyIF/6YURXAj4kmwZtCCfvM63ca+EfF8LomRgno0Oajo3lagQaMeJZhGi7f
	reDTk+uZUUmdltaNqAWPo69ZrS3ppmFE08DHhqMYr3J1K7UfoQwVk+CQNBcseXGdQ28+Avz94aJ
	hILnbdK+DPdt0kxN9Owb+BEs01MVkn4bC+wDCqz9czrFTC1BXdR7YBmK3pwtZMtYKBrSoWQ9xjD
	YrxGWHzNEhE205hwWyeADSvl8R8KgpXyB+Oiuxzpl411UIo7hXIuBjuxlLb0UwBv0piJeTblmTg
	ai4bojCf0X57CgkfxtQaMd1zyHCRlfIbFQN4BdQkUt6nyWK5c8XxIFGXkH+LXyLypf3U39wLBGw
	59+K6P+0s0VtpLKNdIBzFj4xj6PMm0W2K286yAj0m1JZ52ew+l05AxLFrS3Lmw2Wc+B0FQK2MwV
	i3hB1w6pQVJDZBs9FavpmrMfb1k+WvrEGReJjY4bmqOu3U9Sb0iFy8MDoIKPrQd0ionVKEOTvQ7
	26u7QLoG9HdHYrMdNG498N4ykO92zXiqF0Y6jNtjgFkwgzxCqrSglBQ==
X-Received: by 2002:a5d:5f92:0:b0:48e:69ed:cb51 with SMTP id ffacd0b85a97d-48e69edcc52mr1562250f8f.38.1793267250355;
        Thu, 29 Oct 2026 02:47:30 -0700 (PDT)
Received: from GLaDOS.station ([187.13.215.67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebcb851sm28853779f8f.26.2026.10.29.02.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 02:47:29 -0700 (PDT)
Date: Thu, 29 Oct 2026 10:47:27 +0100
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-kernel@vger.kernel.org, pierluigi.p@variscite.com,
	Stefano Radaelli <stefano.r@variscite.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org
Subject: Re: [PATCH v1 1/1] tpm: tis_i2c: Add reset delays for ST33KTPM2XI2C
Message-ID: <auMWL5d6gkdRvrks@GLaDOS.station>
References: <20261028094504.4256-1-stefano.r@variscite.com>
 <auJb8drL7rpvNMyK@kernel.org>
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
In-Reply-To: <auJb8drL7rpvNMyK@kernel.org>

On Wed, Oct 28, 2026 at 10:32:49PM +0200, Jarkko Sakkinen wrote:
> 
> "Pull the timings from the matched device entry. If they don't exist,
> fall back to the legacy behavior without delays. Update of_tis_i2c_match
> with the timings for st33ktpm2xi2c."
> 
> I.e. the last paragraph has the language of a white paper.
> 

Hi Jarkko,

thank you for the review, I'm sending the v2.

Best Regards,
Stefano

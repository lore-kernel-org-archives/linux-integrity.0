Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7B1C48BCD
	for <linux-integrity@archiver.kernel.org>; Wed,  9 Jun 2021 12:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1DC161364
	for <linux-integrity@archiver.kernel.org>; Wed,  9 Jun 2021 12:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbhFIMZt (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 9 Jun 2021 08:25:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:44002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229685AbhFIMZt (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 9 Jun 2021 08:25:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1B6FD61287;
        Wed,  9 Jun 2021 12:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623241434;
        bh=inWI//9JpLAIGlQjB5ZUOdhzM6ool718FMWUxj6GKHQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TzyLuqK00ehO2wucGi/ZWBq5eIZWZQJv+DNvVrfpLoaG/Ivo9isTl4gNAOT/04Cnt
         VtBUf/syBdSZa+7eLajRkZzYF4qnAJM6+Y2fd4kNHVVbTwMbyIRHUItu61ENogf/97
         QdsJmGI/8Y+Mqel5UtedL3hf/H0UzGhxpai4zAjRL/J5UjdSvM39kEM+nxrXqh47fs
         dch+udt9cVGNFX0tz9NOS1ogumH7PkPtOcOa05EIUyjY88yxDWfzms9Kn0vF+XtEld
         qZDXTwjH9EZ5d/YYyFpv1+lRwRw7Com8ViF+LmYduTQF1zFOCaQSKpk5Rk1ge+bKH+
         NToF/ps3Uu5jg==
Date:   Wed, 9 Jun 2021 15:23:51 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] tpm_tis: Use DEFINE_RES_MEM() to simplify code
Message-ID: <20210609122351.buld2xgk7z2rrmsf@kernel.org>
References: <20210603074955.11653-1-thunder.leizhen@huawei.com>
 <20210603074955.11653-2-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210603074955.11653-2-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 03, 2021 at 03:49:55PM +0800, Zhen Lei wrote:
> Use DEFINE_RES_MEM() to save a couple of lines of code, which is simpler
> and more readable. The start address does not need to appear twice.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

/Jarkko

> ---
>  drivers/char/tpm/tpm_tis.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
> index 4ed6e660273a414..d3f2e5364c275f4 100644
> --- a/drivers/char/tpm/tpm_tis.c
> +++ b/drivers/char/tpm/tpm_tis.c
> @@ -363,11 +363,7 @@ static int tpm_tis_force_device(void)
>  {
>  	struct platform_device *pdev;
>  	static const struct resource x86_resources[] = {
> -		{
> -			.start = 0xFED40000,
> -			.end = 0xFED40000 + TIS_MEM_LEN - 1,
> -			.flags = IORESOURCE_MEM,
> -		},
> +		DEFINE_RES_MEM(0xFED40000, TIS_MEM_LEN)
>  	};
>  
>  	if (!force)
> -- 
> 2.26.0.106.g9fadedd
> 
> 
> 

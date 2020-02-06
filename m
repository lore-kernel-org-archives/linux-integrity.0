Return-Path: <SRS0=pYUy=32=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3426C2D0B1
	for <linux-integrity@archiver.kernel.org>; Thu,  6 Feb 2020 12:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72D7021741
	for <linux-integrity@archiver.kernel.org>; Thu,  6 Feb 2020 12:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="aw4ldkm8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbgBFMyP (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 6 Feb 2020 07:54:15 -0500
Received: from smtp11.infineon.com ([217.10.52.105]:19969 "EHLO
        smtp11.infineon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbgBFMyO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 6 Feb 2020 07:54:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1580993654; x=1612529654;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=+LOsqSZOwaErmcvYyHE4Zb+x4vf935b6KUHXPd1MNms=;
  b=aw4ldkm8Md1LM7VL5bRQJUDyL5I4e7EgbFkPrSvugGv221KpfDBJK+hD
   Z9dAZ3soQ/5pl/+mUvXdrPiBPdEubNvkKsoKvD3Om2aiYLk4yIakyC1aR
   bAqxIAthONLtztwNbTYWefXlSo/AqZ+FxglgYhPQczG7utA1FiU65ansS
   I=;
IronPort-SDR: 3ajDCj45i+l3AxOjLL+D8zjefXWLzfftgrflXh5BML42yHT+uQB5hSEemkvDpkt0h59+BHxbGi
 KZgI0Rep3ezmoyjdnn6aglQ6UbvOtqS9JiIC1Br+Yk34Sl6gdVzAbIx+1upgK5RunfniBKVjmW
 mkpR5kUBOcQu8StBaArcsOnWUKjFi1PT+GWtjBb8c3/2l0qqIS8KFnKxkQLFCla3GgQZxsoeM3
 lNYhpqfAMd3REvNnDouABWg4Er5OxL+hiMuwR5stp4cQ80qlAI28Oad8XgNdB2FsTo3/r6uHG9
 e5Y=
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6000,8403,9522"; a="148641042"
X-IronPort-AV: E=Sophos;i="5.70,409,1574118000"; 
   d="scan'208";a="148641042"
Received: from unknown (HELO mucxv002.muc.infineon.com) ([172.23.11.17])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 13:54:12 +0100
Received: from MUCSE708.infineon.com (MUCSE708.infineon.com [172.23.7.82])
        by mucxv002.muc.infineon.com (Postfix) with ESMTPS;
        Thu,  6 Feb 2020 13:54:12 +0100 (CET)
Received: from [10.154.32.73] (172.23.8.247) by MUCSE708.infineon.com
 (172.23.7.82) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1713.5; Thu, 6 Feb
 2020 13:54:12 +0100
Subject: Re: [PATCH] tpm: Revert tpm_tis_spi_mod.ko to tpm_tis_spi.ko.
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        <linux-integrity@vger.kernel.org>
CC:     Andrey Pronin <apronin@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>, <stable@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Stuebner <heiko@sntech.de>,
        open list <linux-kernel@vger.kernel.org>
References: <20200205203818.4679-1-jarkko.sakkinen@linux.intel.com>
From:   Alexander Steffen <Alexander.Steffen@infineon.com>
Message-ID: <f865a01e-83a1-b0e2-a9ca-45f874d86b4c@infineon.com>
Date:   Thu, 6 Feb 2020 13:54:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200205203818.4679-1-jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.23.8.247]
X-ClientProxiedBy: MUCSE703.infineon.com (172.23.7.73) To
 MUCSE708.infineon.com (172.23.7.82)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 05.02.2020 21:38, Jarkko Sakkinen wrote:
> Revert tpm_tis_spi_mod.ko back to tpm_tis_spi.ko as the rename could break
> the build script. This can be achieved by renaming tpm_tis_spi.c as
> tpm_tis_spi_main.c. Then tpm_tis_spi-y can be used inside the makefile.
> 
> Cc: Andrey Pronin <apronin@chromium.org>
> Cc: Stephen Boyd <swboyd@chromium.org>
> Cc: stable@vger.kernel.org
> Fixes: 797c0113c9a4 ("tpm: tpm_tis_spi: Support cr50 devices")
> Reported-by: Alexander Steffen <Alexander.Steffen@infineon.com>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>   drivers/char/tpm/Makefile                              | 8 +++++---
>   drivers/char/tpm/{tpm_tis_spi.c => tpm_tis_spi_main.c} | 0
>   2 files changed, 5 insertions(+), 3 deletions(-)
>   rename drivers/char/tpm/{tpm_tis_spi.c => tpm_tis_spi_main.c} (100%)
> 
> diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
> index 5a0d99d4fec0..9567e5197f74 100644
> --- a/drivers/char/tpm/Makefile
> +++ b/drivers/char/tpm/Makefile
> @@ -21,9 +21,11 @@ tpm-$(CONFIG_EFI) += eventlog/efi.o
>   tpm-$(CONFIG_OF) += eventlog/of.o
>   obj-$(CONFIG_TCG_TIS_CORE) += tpm_tis_core.o
>   obj-$(CONFIG_TCG_TIS) += tpm_tis.o
> -obj-$(CONFIG_TCG_TIS_SPI) += tpm_tis_spi_mod.o
> -tpm_tis_spi_mod-y := tpm_tis_spi.o
> -tpm_tis_spi_mod-$(CONFIG_TCG_TIS_SPI_CR50) += tpm_tis_spi_cr50.o
> +
> +obj-$(CONFIG_TCG_TIS_SPI) += tpm_tis_spi.o
> +tpm_tis_spi-y := tpm_tis_spi_main.o
> +tpm_tis_spi-$(CONFIG_TCG_TIS_SPI_CR50) += tpm_tis_spi_cr50.o
> +
>   obj-$(CONFIG_TCG_TIS_I2C_ATMEL) += tpm_i2c_atmel.o
>   obj-$(CONFIG_TCG_TIS_I2C_INFINEON) += tpm_i2c_infineon.o
>   obj-$(CONFIG_TCG_TIS_I2C_NUVOTON) += tpm_i2c_nuvoton.o
> diff --git a/drivers/char/tpm/tpm_tis_spi.c b/drivers/char/tpm/tpm_tis_spi_main.c
> similarity index 100%
> rename from drivers/char/tpm/tpm_tis_spi.c
> rename to drivers/char/tpm/tpm_tis_spi_main.c

Works for me, thank you very much :)

Alexander

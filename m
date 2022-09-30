Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E26BBC43217
	for <linux-integrity@archiver.kernel.org>; Fri, 30 Sep 2022 22:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbiI3WGC (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 30 Sep 2022 18:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232446AbiI3WFx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 30 Sep 2022 18:05:53 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07BE303D3;
        Fri, 30 Sep 2022 15:05:51 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id w13so6079237oiw.8;
        Fri, 30 Sep 2022 15:05:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=e95cVkU1YVsZYYYeZhd6YkazhTnGPp2+jcn6yw8+tqE=;
        b=G3tdnHbU5slcsOZMAJQkgf2HXwg+RcDvoFOz+hQLNnhEoXmLt64f0QcGxUvZta05zu
         h9l+fYzHsQEludlG79Ot4Cn4a8Hr4xj9e/KU470ksiz7DV7k0EP7zN79JQG5b21ugblJ
         dYSbsuMZ2kI/h8A18EdovLT8qAPkhDGREEQV+TOP8q0QyJy2l/J7ZIitO7a7stT7yZq3
         HaNLyOG5ZMiDlm100ST6n5uRr5uQu5sRXfjhkQEiKpMfqDcniaTup8S5MM9/9q0RIN4N
         kS7UY9MII1upTHUpk6TwUI5pKdw5fMpq158ibEbeAWkHuVPLbXfvRmCyfz1KaoCKisFW
         mc2A==
X-Gm-Message-State: ACrzQf0STKfmLQ0sQC0SS/q33+2cxLE1yKnd4Q5NX3AT4h+cAODnkYfM
        50jaeGM7O+kEOK6vCK9GhQ==
X-Google-Smtp-Source: AMsMyM6jvPDYKOu5nnoVUGS5dquPmDjpVw7IBrmQTDGkgGN1eHdIAaU6rv2qekAa2Gs9JeQBCN1aOQ==
X-Received: by 2002:a05:6808:308f:b0:350:55d6:ebbb with SMTP id bl15-20020a056808308f00b0035055d6ebbbmr128224oib.168.1664575550484;
        Fri, 30 Sep 2022 15:05:50 -0700 (PDT)
Received: from macbook.herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 9-20020a9d0f09000000b006594674d4ddsm834733ott.44.2022.09.30.15.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 15:05:49 -0700 (PDT)
Received: (nullmailer pid 1129754 invoked by uid 1000);
        Fri, 30 Sep 2022 22:05:43 -0000
From:   Rob Herring <robh@kernel.org>
To:     Alexander Steffen <Alexander.Steffen@infineon.com>
Cc:     benoit.houyere@st.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, amirmizi6@gmail.com, jarkko@kernel.org,
        peter@pjd.dev, Johannes.Holland@infineon.com,
        linux-integrity@vger.kernel.org
In-Reply-To: <20220930165116.13329-3-Alexander.Steffen@infineon.com>
References: <20220930165116.13329-1-Alexander.Steffen@infineon.com> <20220930165116.13329-3-Alexander.Steffen@infineon.com>
Message-Id: <166457528569.1113018.4558441482039920312.robh@kernel.org>
Subject: Re: [PATCH 2/7] dt-bindings: tpm: Improve documentation of compatibles
Date:   Fri, 30 Sep 2022 17:05:43 -0500
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 30 Sep 2022 18:51:11 +0200, Alexander Steffen wrote:
> Add missing information:
> * Device name, for discoverability
> * Interface, to distinguish otherwise similar devices
> * TPM version, so that outdated devices can be deprecated in the future
> 
> Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
> ---
>  .../bindings/security/tpm/trivial-tpms.yaml        | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


tpm@20: 'powered-while-suspended' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/rk3288-veyron-brain.dtb
	arch/arm/boot/dts/rk3288-veyron-fievel.dtb
	arch/arm/boot/dts/rk3288-veyron-jaq.dtb
	arch/arm/boot/dts/rk3288-veyron-jerry.dtb
	arch/arm/boot/dts/rk3288-veyron-mickey.dtb
	arch/arm/boot/dts/rk3288-veyron-mighty.dtb
	arch/arm/boot/dts/rk3288-veyron-minnie.dtb
	arch/arm/boot/dts/rk3288-veyron-pinky.dtb
	arch/arm/boot/dts/rk3288-veyron-speedy.dtb
	arch/arm/boot/dts/rk3288-veyron-tiger.dtb
	arch/arm64/boot/dts/mediatek/mt8173-elm-hana-rev7.dtb
	arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtb
	arch/arm64/boot/dts/mediatek/mt8173-elm.dtb
	arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dtb


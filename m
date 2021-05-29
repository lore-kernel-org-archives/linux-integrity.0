Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7998C47082
	for <linux-integrity@archiver.kernel.org>; Sat, 29 May 2021 13:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7EFC611EE
	for <linux-integrity@archiver.kernel.org>; Sat, 29 May 2021 13:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbhE2Nvv (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sat, 29 May 2021 09:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbhE2Nvu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 29 May 2021 09:51:50 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314E7C061574;
        Sat, 29 May 2021 06:50:14 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id z12so9612887ejw.0;
        Sat, 29 May 2021 06:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8aQgLERsJ6sV99TXeAuEDVnHyDkmfQ0R3z6KDSFrLow=;
        b=tZOsMeWYHsWH/mloywvdjXa2qYMDueH0f0nd0aKocBFh0q1i9C7t3DrooC0iWjttSD
         Kq329seXad6ra6UzNPbJc6c4rMh0iWFrNswkSgrWIv/AU5kLFERTw6MvFgQpL6Nhj2Xz
         tTIGu+E/1TpVerETj+3HnydvjYzP96l+82lYLa+O0nFPL2QJhJ7g4lxQHjya7l5RKC49
         MQLsvttBajB2xAdzoikEYdEOUeBP3SX/jkOOXy/X7Jsqd94+BuP8+qY88zMxt6FIqlvC
         QkSPAEkvLbPrDuW5kjwbLAs7FFjFH2S6NdtlwtDpl69B3RmqusUI6j2GPxABzvjtd0VN
         Ni+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8aQgLERsJ6sV99TXeAuEDVnHyDkmfQ0R3z6KDSFrLow=;
        b=cgeSDHFJI4HmiGxlxk3JZP/jFEJ1Wwn/0cU539IC46MW0Zg5SFfKSG5bR34MHGyhju
         5+vjf2jpQle9FIH0PqQXB5bfEIOjzNdJO9mSIG8vbPTVPHsoDs8807l32iUSkOkHLqCq
         VmTlhNklCJBmESQCE1ENgiBwfIwqLvQvdNZRKW/Hu3KyMsxKCmaIHnpVfit59jpXDQSF
         S7lK/RW5cgRj0P7p6VKLpAG/NpqNWtuOmJw/go6mOlAFxU+OnF63P7nFS6Pznl/80+wn
         6eO6uka/VaEjlGOVipvg0g6MFSeZF1aV7iRmzYVH31bSwdBdLH+2X7rxBhlWTve00frc
         Ag7w==
X-Gm-Message-State: AOAM531ExhWzXGWOngrWORyfa1rXJk2OiNOrKA6jAJEYC1qnSTNz39Xu
        cJWtaSWbzRDLrYw3lS4PMnai9H4J4FkH88oIiB8=
X-Google-Smtp-Source: ABdhPJwca8AvraegbXFaMc4aWgglMtYniM+vBNKZDMRwnsIgotNDmycyY0lNCpDlwUHdRLyngFQarGINBYaUL7oK1dQ=
X-Received: by 2002:a17:907:961e:: with SMTP id gb30mr14500317ejc.58.1622296212714;
 Sat, 29 May 2021 06:50:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210527152352.3835076-1-javierm@redhat.com>
In-Reply-To: <20210527152352.3835076-1-javierm@redhat.com>
From:   Peter Robinson <pbrobinson@gmail.com>
Date:   Sat, 29 May 2021 14:50:01 +0100
Message-ID: <CALeDE9NKOdA-kA-SgbgiE8+corLBW8bh8he-Xqe+wkmQ9ja-xg@mail.gmail.com>
Subject: Re: [PATCH] tpm_tis_spi: add missing SPI device ID entries
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Wellbrock <a.wellbrock@mailbox.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>,
        linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, May 27, 2021 at 4:24 PM Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> The SPI core always reports a "MODALIAS=spi:<foo>", even if the device was
> registered via OF. This means that this module won't auto-load if a DT has
> for example has a node with a compatible "infineon,slb9670" string.
>
> In that case kmod will expect a "MODALIAS=of:N*T*Cinfineon,slb9670" uevent
> but instead will get a "MODALIAS=spi:slb9670", which is not present in the
> kernel module aliases:
>
> $ modinfo drivers/char/tpm/tpm_tis_spi.ko | grep alias
> alias:          of:N*T*Cgoogle,cr50C*
> alias:          of:N*T*Cgoogle,cr50
> alias:          of:N*T*Ctcg,tpm_tis-spiC*
> alias:          of:N*T*Ctcg,tpm_tis-spi
> alias:          of:N*T*Cinfineon,slb9670C*
> alias:          of:N*T*Cinfineon,slb9670
> alias:          of:N*T*Cst,st33htpm-spiC*
> alias:          of:N*T*Cst,st33htpm-spi
> alias:          spi:cr50
> alias:          spi:tpm_tis_spi
> alias:          acpi*:SMO0768:*
>
> To workaround this issue, add in the SPI device ID table all the entries
> that are present in the OF device ID table.
>
> Reported-by: Alexander Wellbrock <a.wellbrock@mailbox.org>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Tested-by: Peter Robinson <pbrobinson@gmail.com>

Tested on a Raspberry Pi4, with an Iridium 9670 module on 5.12.7 with
tpm_tis_spi built as a module.


> ---
>
>  drivers/char/tpm/tpm_tis_spi_main.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_tis_spi_main.c
> index 3856f6ebcb3..de4209003a4 100644
> --- a/drivers/char/tpm/tpm_tis_spi_main.c
> +++ b/drivers/char/tpm/tpm_tis_spi_main.c
> @@ -260,6 +260,8 @@ static int tpm_tis_spi_remove(struct spi_device *dev)
>  }
>
>  static const struct spi_device_id tpm_tis_spi_id[] = {
> +       { "st33htpm-spi", (unsigned long)tpm_tis_spi_probe },
> +       { "slb9670", (unsigned long)tpm_tis_spi_probe },
>         { "tpm_tis_spi", (unsigned long)tpm_tis_spi_probe },
>         { "cr50", (unsigned long)cr50_spi_probe },
>         {}
> --
> 2.31.1
>

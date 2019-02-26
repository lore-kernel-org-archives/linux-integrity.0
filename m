Return-Path: <SRS0=XaU3=RB=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD76C43381
	for <linux-integrity@archiver.kernel.org>; Tue, 26 Feb 2019 12:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2750C2083D
	for <linux-integrity@archiver.kernel.org>; Tue, 26 Feb 2019 12:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i9RKpQfw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbfBZMjK (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 26 Feb 2019 07:39:10 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:34581 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfBZMjK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 Feb 2019 07:39:10 -0500
Received: by mail-io1-f66.google.com with SMTP id e1so10363898iok.1
        for <linux-integrity@vger.kernel.org>; Tue, 26 Feb 2019 04:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=svtY87tZsg0PU5GQWY0+GupGILMOCdYSf+HJlHG8t6g=;
        b=i9RKpQfwBJSQH3YHIoLlyODJ5+4Y4YZHaPUwlbk27zUHt7H1btUvOK5SE24K2nHZ84
         y+AzeDg6wRCfQRUxqDAdzJM4H7tp+5zgw67Pr8eYhblZH26NkymX7kXD/KYy4DO69QZi
         l1EQNbDnSynRksf/5u3O+0//hwt+UXMMeNwUG90ht2eTsM+VsDzk7wmHan4zjF3tl+lI
         bIvzkPfLj5Nn0HYssLjis+habYy7WLYCKbQhtx43CUgrJU1SuqRjqFRYpyW4v2Tf8zz3
         Q8r4RFCRIyJWwYkbSrgLNIVAeqGCa443o+edwXQ0r+iC++ttsDHAwjQNpy3x/kMhbWuy
         zu3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=svtY87tZsg0PU5GQWY0+GupGILMOCdYSf+HJlHG8t6g=;
        b=K42KLE5Nz9NUzCRBk6CnGr5+CEDH9DBsUVQbY0T+lOBX5uarc3zkFdiax5ib6Cv7Vo
         AM+ruc0jqBJxYQyaGZst3Dnzwlkyhv56dDymDInMWsVqXnZJXtKhSEXp2AFyV9w4z6/x
         i/qqJCrRMMjb1V99zA5HkHo2yIxG3oETTsSvHBxT0ssInKQVCHaTFm5Ad/NkGbfg8Zzm
         GwCqrZ+TVTjnMxtChwp3z5phtWPAuDcAKBnVFpVjW0Et0Xhr4oMUkSEMIXAbEXwaMH1x
         bk6Q3KZ8VR1Ks5F2h9WCXJCqwERZkpkI9tuwGAuz9T720vq3Ui0iyGAeiP+1WEJTkJBT
         jdZQ==
X-Gm-Message-State: AHQUAuaDvktfGMmi7Bp0+KYZIqZ9EsdaTDB1SD//6PzYwiGWMexpRPpi
        4Quc3oLiIUaMN7YGHLTjvWgvfYN/DkRr9zvHzi/5h7qp
X-Google-Smtp-Source: AHgI3IazcU4PDdm2Wh3xldXfCBYz6vJJ02I+6NbfWcwCbiwp1OdLRd86OFtmUXQyFiGpTrhBCwk/gpgWUSx/oAdXvx0=
X-Received: by 2002:a6b:7b02:: with SMTP id l2mr11626186iop.60.1551184749469;
 Tue, 26 Feb 2019 04:39:09 -0800 (PST)
MIME-Version: 1.0
References: <9cd0d399-2b11-779c-f767-660ea61721d9@moth.iki.fi>
 <b9da5231-10b8-0d88-3d90-edfc6fb7b9de@moth.iki.fi> <192719a8-d583-b7cd-07d2-b693e2cc982d@moth.iki.fi>
 <1651d634-9a88-4511-ac51-a69648db8259@moth.iki.fi> <1550753358.17768.85.camel@linux.ibm.com>
 <776f0386-6c4d-9ad4-929c-44ba9fd4c9d0@moth.iki.fi> <88215b47-976c-96d5-1098-40868d28d576@moth.iki.fi>
 <357e44f8-df31-48ec-d2f0-deabd0161fc0@moth.iki.fi> <1551183277.27819.66.camel@linux.ibm.com>
In-Reply-To: <1551183277.27819.66.camel@linux.ibm.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 26 Feb 2019 13:38:58 +0100
Message-ID: <CAKv+Gu9H=yP8McwmsBP5nk-Fc3YHG2GF2zU+00gB4sqtfafyeg@mail.gmail.com>
Subject: Re: IMA fails to see TPM chip (rpi3, linaro optee)
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Markku Savela <msa@moth.iki.fi>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        =?UTF-8?Q?Peter_H=C3=BCwe?= <PeterHuewe@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 26 Feb 2019 at 13:14, Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> On Tue, 2019-02-26 at 10:12 +0200, Markku Savela wrote:
> > In case anyone is interested, I got IMA to accept TPM chip in my special
> > case (linaro optee kernel) by changing
> >
> >    clk-bcm2835.c: core_initcall -> susbsys_initcall
> >    raspberrypi.c: subsys_initcall -> core_initcall
> >
> > At first check, the system seems to be ok. Maybe some combination of
> > initcalls could work, but this is enough for me.
>
> Thank you for sharing this!
>
> Mimi
>

Hi Mimi, Markku,

I am not sure why I am being cc'ed on this thread, or if there is
anything particular you would like my opinion on.

In general, having to juggle initcall ordering like this is horrid, so
while useful as a data point, I'd prefer fixing it properly instead.
I.e., if the firmware driver relies on a clock having been enabled,
this should be reflected in the DT, and supported in the firmware
driver by deferring the probe until the clock becomes available.



> >
> > diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
> > index d6caac9c3..7cdd597f1 100644
> > --- a/drivers/clk/bcm/clk-bcm2835.c
> > +++ b/drivers/clk/bcm/clk-bcm2835.c
> > @@ -2330,7 +2330,7 @@ static int __init __bcm2835_clk_driver_init(void)
> >   {
> >          return platform_driver_register(&bcm2835_clk_driver);
> >   }
> > -core_initcall(__bcm2835_clk_driver_init);
> > +subsys_initcall(__bcm2835_clk_driver_init);
> >
> >   MODULE_AUTHOR("Eric Anholt <eric@anholt.net>");
> >   MODULE_DESCRIPTION("BCM2835 clock driver");
> > diff --git a/drivers/firmware/raspberrypi.c b/drivers/firmware/raspberrypi.c
> > index a82819a78..dfa362e1c 100644
> > --- a/drivers/firmware/raspberrypi.c
> > +++ b/drivers/firmware/raspberrypi.c
> > @@ -457,7 +457,7 @@ static int __init rpi_firmware_init(void)
> >   out1:
> >          return ret;
> >   }
> > -subsys_initcall(rpi_firmware_init);
> > +core_initcall(rpi_firmware_init);
> >
> >   static void __init rpi_firmware_exit(void)
> >   {
>

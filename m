Return-Path: <SRS0=zpiu=QT=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D62C282C4
	for <linux-integrity@archiver.kernel.org>; Tue, 12 Feb 2019 11:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C490B217FA
	for <linux-integrity@archiver.kernel.org>; Tue, 12 Feb 2019 11:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DK5Q1Y+7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbfBLLAp (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 12 Feb 2019 06:00:45 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:42519 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728932AbfBLLAp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Feb 2019 06:00:45 -0500
Received: by mail-yw1-f66.google.com with SMTP id v201so822963ywa.9
        for <linux-integrity@vger.kernel.org>; Tue, 12 Feb 2019 03:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ysrs7O4XTNHbvtUzCcBIUDGeAY1c+7Daeugzgccm8iU=;
        b=DK5Q1Y+7nBvI8ZtpUFCMnauiDQWU4LGZXXrmyHolKdselBSjPMAZPyIN3zU4Iugxrj
         wm6L86CYf8Uj7B78xFCE+7zDPajhYaxRMRHD19O4NLEDsR/6ynB5lR7QOADjBCovIyOS
         iB0PTjk5/4guFzs+ELbTH537Ku/BdLYmC2srDzcU84Y1aXKrDh5g8+q/ohHTwIKJTfEn
         1PKHr40oa/3rhkp3KKAxgPF4ae/KPbs4lF5PmIj8nKSgGfRl6aYOQwS9hRHQFNoocNm7
         pEWnCJJwX/bNKxiVxF4gY6FC1DEMHefSnrmy+gD8QQhVEk4y2OrjE0ZbFtG9O07I2U6k
         93kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ysrs7O4XTNHbvtUzCcBIUDGeAY1c+7Daeugzgccm8iU=;
        b=H+Ddtms4L3GQT3J2k7VeYmUqc46D3dtMLnE/weiqXt+kwXoavj16+NsayQXTpcsPCV
         kUqGzK1ENMGlNVGZYyyS8plonC0eH73K1n8gmFEGFL5KvHf4v42WbeKJ6VEP8S+WPFYp
         Y85xOuRUoB5NywTGPBhgdKrzeouA+J4DVx0laQpe86N9BnM8JU+BQQp2pMN7BAMsfEoW
         l8y/k3Ao/nxHD1te6h7a5n+70yuc4Ij+GaOBvk4cz7XD8OYRZAumCUgainXhoWLUJQOU
         ugnlfw8WBWRaLX3Upwn19WUY1MGvOMTJjk1kptopxF5dB/0VBxY70mnKw+QkJ9sAAt7M
         e1gg==
X-Gm-Message-State: AHQUAubGaZwxSTv7ZVbZbnZhmnO77TXMHC+3WKHhK21NRA+R236XRFPt
        2CPiqHkAj0OgWS7+CBYq1iMOa6CRD6jlZZA36xAPgA==
X-Google-Smtp-Source: AHgI3Iat0eLR89Vj5qnvP5fXsCILWue/IOcwi0dqtOC3wz6hsOR/tNo0wZC63NTaxdN7uVLXhusTAm5vbtDL4ygH94A=
X-Received: by 2002:a81:79d3:: with SMTP id u202mr2247939ywc.56.1549969244337;
 Tue, 12 Feb 2019 03:00:44 -0800 (PST)
MIME-Version: 1.0
References: <20190212100825.9113-1-anders.roxell@linaro.org>
 <CAHp75Vd8yi0u7S6oA=Vr7E9ptYdvBvXBJn=fG2kM-=vS-7oOQg@mail.gmail.com> <CAHp75VcPeKDLOB7vKeSG9+UfsYnPfTPy_omuTgJSUgKzC0caNw@mail.gmail.com>
In-Reply-To: <CAHp75VcPeKDLOB7vKeSG9+UfsYnPfTPy_omuTgJSUgKzC0caNw@mail.gmail.com>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Tue, 12 Feb 2019 12:00:33 +0100
Message-ID: <CADYN=9JhN=x67Jj_L6Jk2ShTJsARUK6rQHWQttvNLJuZ0mfQDQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] ima: fix build error redeclaration of enumerator
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 12 Feb 2019 at 11:23, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
> On Tue, Feb 12, 2019 at 12:21 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > On Tue, Feb 12, 2019 at 12:15 PM Anders Roxell <anders.roxell@linaro.org> wrote:
> > >
> > > Commit a893ea15d764 ("tpm: move tpm_chip definition to
> > > include/linux/tpm.h") introduced a build error when both ima and efi is
> > > enabled. What happens is that both headers (ima.h and efi.h) defines the
> > > same 'NONE' constant, and it broke when they started getting included
> > > from the same file.
> >
> > > We only need one of the two patches applied.
> >
> > I would argue that we need two patches applied. Namespace is a hidden
> > issue in the code.
> >
> > This patch looks good to me, FWIW,
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>
> Oh, did you change ABI? So, I have to say that enum changes are okay,
> but ABI, if any, are not.

urgh, thank you for the review. It looks like I changed a bit too much
in ima_parse_rule() =/
I'll send send out a v2 shortly.

Cheers,
Anders

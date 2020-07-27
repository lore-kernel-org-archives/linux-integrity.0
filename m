Return-Path: <SRS0=p1mE=BG=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56617C433DF
	for <linux-integrity@archiver.kernel.org>; Mon, 27 Jul 2020 14:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33CA62173E
	for <linux-integrity@archiver.kernel.org>; Mon, 27 Jul 2020 14:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ujmHUbDi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730718AbgG0OfF (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732900AbgG0OfE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Jul 2020 10:35:04 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33487C061794
        for <linux-integrity@vger.kernel.org>; Mon, 27 Jul 2020 07:35:04 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id 12so14521614oir.4
        for <linux-integrity@vger.kernel.org>; Mon, 27 Jul 2020 07:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t7X7FPGH5H0c9dZWv197rYgtNXFl+3Ivir3hCBfGjV8=;
        b=ujmHUbDiY47JMXKjG+kx5U4gbKFMJv1IV9PXcPHe+cNKJhyHg+qiAiM6ZKHy+Peb9S
         MCqiwgJjc251e+SXBTbLKKW820BJ2gY9D6IRJaI8zX++CNJJ9ZfYU/88vUSAFFnrnbMG
         cbl+OI57MD5Oe87PBAGfV44EXIhrGww3mRB4OdjAE2x0S5rcdSKWoIANMAyFlbtJyGm4
         QjbG8FNxdiuxO9o5xeYl+gCNVwiqQszEnzZ0WImzPXJUPEQzjR0xrZLa+qkRvZYTst7g
         FIoiEZhQ335wujU0DGnH2zhNRDbFk1LSLlGTsmkGBf5IAR4VrJdOaVoPIfkb4qWEyOir
         3Yiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t7X7FPGH5H0c9dZWv197rYgtNXFl+3Ivir3hCBfGjV8=;
        b=COwcMX+kFAt0a45Wns6Yq+wtVDSFB0WFqZOwBSZGbQV4cEstYqYaqegOdBYFaguOkg
         x3wWoRaVncDKL6k56Ea74MC3jRGm+rv/WcJ/W33XrSvA2E269ovYIGbesiV7IE3FD0pA
         vS4kolNBKWMcHVclmr+8Igzq3HG3xwNyt4ulGCdXV1hSSoEauew8RLPna8WVcRttUD6p
         9uNPekJCgK08XKnPcYlqFpRHDQFgAtNFX6kmvZPEeDyVOHTnkzy09L0GzCm5+VfbkGah
         TOT23TzfA9ZD2GDDdkdBGtAiCBLA0nk0l6JzDPsIYVOhC/53jcovCDjcsmC3KlEQFwoj
         +Pww==
X-Gm-Message-State: AOAM533ZPFmCrhu4OyCezSB+X5+DXtG3YkJ/WRf3wyb66/HLlerVaM/u
        qDoW100Fu30jHbhn6/PyAAixARxg1BM3fczf2us=
X-Google-Smtp-Source: ABdhPJwCJHO/PRG3HvP5qgdYc7vSzpII5sOpN0d6DlDJvT9kLadXXIXjAeXbyM1MQbKyRW1fn+NcK1ykvdMwMReqKDc=
X-Received: by 2002:aca:c4cc:: with SMTP id u195mr17297301oif.160.1595860503596;
 Mon, 27 Jul 2020 07:35:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200727132110.5057-1-stephen.smalley.work@gmail.com> <1595859338.4841.116.camel@kernel.org>
In-Reply-To: <1595859338.4841.116.camel@kernel.org>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 27 Jul 2020 10:34:52 -0400
Message-ID: <CAEjxPJ66--SytmNQpHF-DOkoWsE3ri-Ni6nA0k3YmY1fqU-0qQ@mail.gmail.com>
Subject: Re: [PATCH v4 ima-evm-utils] extend ima_measurement --pcrs option to
 support per-bank pcr files
To:     Mimi Zohar <zohar@kernel.org>
Cc:     linux-integrity@vger.kernel.org,
        William Roberts <bill.c.roberts@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jul 27, 2020 at 10:15 AM Mimi Zohar <zohar@kernel.org> wrote:
>
> On Mon, 2020-07-27 at 09:21 -0400, Stephen Smalley wrote:
>
> > ---
> > v4 updates the usage in the README and usage message, reduces MAX_NPCRFILE
> > to 2 (for sha1 and sha256) and changes the buffer size to
> > MAX_DIGEST_SIZE * 2 + 8 for the lines read from the pcrs file(s).
> >
> > One thing that is unclear to me is correct/expected usage of the
> > --verify and --validate options to evmctl ima_measurement. For an
> > appraisal of a remote attestation, when would one NOT want to use
> > --verify (i.e. doesn't lack of --verify render the result insecure)
> > and when would one want to use --validate (i.e. doesn't use of --validate
> > render the result insecure)? And shouldn't the default in both cases
> > be the more secure case (i.e. verify = 1, validate = 0)?  The naming of
> > --validate is also confusing since one might expect it to mean
> > to validate/check the result as opposed to ignore violations?
>
> Yes, agreed.  Thank you for reviewing and commenting on the code.
>
> While adding support for these features, originally in LTP and the
> standalone version, they should be cleaned up.  Should "--verify" just
> be dropped?

Unless there is some reason to not always verify during
ima_measurement, I'd drop the option and just always do it.

> Without a custom policy, with just the builtin
> "ima_policy=tcb" policy, a few files are read while being opened for
> write (e.g. audit, log, print files).  Perhaps rename "validate" to
> something like "force-validate".

As long as there isn't a backward compatibility concern, that makes
more sense to me. Or "ignore-violations".

> I forgot to add "evmctl boot_aggregate" to the README.  The supplied
> pcrs could also be used to calculate the "boot_aggregate" value(s).

I guess that support is automatically picked up since nothing
restricts usage of the --pcrs option to only ima_measurement and both
call read_tpm_banks(), which includes the pcr file support.  So just a
matter of updating the usage message and README?  That can be done as
a separate patch IMHO.

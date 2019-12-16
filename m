Return-Path: <SRS0=Y7w1=2G=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E08C43603
	for <linux-integrity@archiver.kernel.org>; Mon, 16 Dec 2019 06:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 727212072B
	for <linux-integrity@archiver.kernel.org>; Mon, 16 Dec 2019 06:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jnEb6N2R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbfLPGSH (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 16 Dec 2019 01:18:07 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44799 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbfLPGSG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Dec 2019 01:18:06 -0500
Received: by mail-lj1-f194.google.com with SMTP id c19so5412871lji.11
        for <linux-integrity@vger.kernel.org>; Sun, 15 Dec 2019 22:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tbZNtygmqhnvg+ZFXsiQfCeZj1B6SN2LTdor0Z2QY8A=;
        b=jnEb6N2Rcu3eJP+ucL6iFWhOADRu+iNhsQu/mdITHTTUObkRVQoaGsSCFUeINmsYar
         biKZnp7Wd7/92HnOpAOJi/MeKkpIqnOZE50zfSsrpPY6aZuZVAekIjkcG0uSV+LHf3xO
         Ay88BsvOzfWgLpUjyKuOULFbrbgUt5KnDOW1PVNgbTRrq3WvQZg64m3rxPy07I5pkIJV
         6wyl1h0Tao6r22DihhLcBzaBZGLh/bNGCG7obCQd0fx3Mj2MEPM6EvifqE/DH4LwGhCL
         xeEkONSW40uy/QUynr5kR1z/TmIOhZnkeqVsbR9i5foFitYjQKzdaZQwPbQDDIaVuVQc
         1DJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tbZNtygmqhnvg+ZFXsiQfCeZj1B6SN2LTdor0Z2QY8A=;
        b=K3zQJx4SjT0LjS2BRPM11aTy+oR+bwesM9yj77GM/nVwVp0sIDBi2SqxiiqzeufPTU
         8pSy1Dcy520+RwEs9WdS7gOMfOxzqsHoJTCtLrKGr2twk+A5wMcGq+RYkJBUEMA3fo3s
         1Jb6uTfERXkoOLemrHEiKvIu/VSRfedBW8fKXCKUZr4AVeUyjibejU4DVTPay0Y1hrny
         5ZrbTlGzlvF5JTAhTJtRynwtBAQuUo1np2/EMZtu1F5z+EY0RZFmEi9VDWQg6XOf6ZWW
         vQ3dQ5jcR79volRHcEdO3iY7X+nzdImLNbJkBvbR/89JdE4pcIjzBEs36CNT1vyGzSa6
         Tpyw==
X-Gm-Message-State: APjAAAUQxLQkIz/wm+LWhaKoaaOQxZ8wROEosa9rOhBEuaL7j2TvCnps
        RvGRIhBTdp2RvWi0mNsuSfNdhMLbZqLcuDYYM5u90dxiu1I=
X-Google-Smtp-Source: APXvYqyEiWG9iD8H6qsyauSinq5k+ZUdaG4JbpLoJFSD6wZLRsi8n5UMk96eThjLoZ/mlGKwroBOhfYJHMDMkP6sHfc=
X-Received: by 2002:a2e:6a03:: with SMTP id f3mr18495212ljc.232.1576477083627;
 Sun, 15 Dec 2019 22:18:03 -0800 (PST)
MIME-Version: 1.0
References: <1576173515.15886.7.camel@HansenPartnership.com>
 <CAFA6WYMpVDN9n4aVJQ+UU6gstKJjnPnSmJmkMJ8pS9dsgOcVmw@mail.gmail.com>
 <1576240555.3382.5.camel@HansenPartnership.com> <1576244983.3382.9.camel@HansenPartnership.com>
In-Reply-To: <1576244983.3382.9.camel@HansenPartnership.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 16 Dec 2019 11:47:52 +0530
Message-ID: <CAFA6WYPd1=kAeOPgAdafp83-voXWv3eYi9E6Tu0csxBSKC896w@mail.gmail.com>
Subject: Re: [PATCH URGENT FIX] security: keys: trusted: fix lost handle flush
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     linux-integrity@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 13 Dec 2019 at 19:19, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Fri, 2019-12-13 at 07:35 -0500, James Bottomley wrote:
> > On Fri, 2019-12-13 at 11:10 +0530, Sumit Garg wrote:
> [...]
> > >  Also, I think we need "#else" part for this API as well.
> >
> > No, we shouldn't ... the #else part is only for functions which are
> > called when the TPM isn't compiled in.  That should never happen with
> > tpm2_flush_context, so if it ever does we want the compile to break.
>
> Just on this bit, it looks like we've given insufficient thought to
> what it means to move TPM internals using code outside of the tpm
> directory.  I think we really need two include/linux files, one tpm.h
> for external code that going to do stuff which it would do anyway even
> if a TPM weren't compiled in, like the PCR read and extend.  The other
> tpm-internal.h for code that wants access to TPM internal functions
> like flushing and session handling and will take care itself of the
> case where the TPM isn't compiled in, like the trusted key code does
> through Kconfig dependencies.  The test should be easy: if it was
> originally in drivers/char/tpm/tpm.h it belongs in include/linux/tpm-
> internals.h
>

Your approach sounds good to me. But how about just moving the APIs
that needs to be used independently of TPM compilation to
include/linux/tpm-externals.h from drivers/char/tpm/tpm.h. As the
initial thoughts while I was moving contents to drivers/char/tpm/tpm.h
was to keep a consolidated view of TPM header for a particular user.

> > > +void tpm2_flush_context(struct tpm_chip *chip, u32 handle);

I agree with you that the above API should remain as it is and should
be moved out of the following check:

#if defined(CONFIG_TCG_TPM) || defined(CONFIG_TCG_TPM_MODULE)
...
#else
...
#endif

-Sumit

> James
>

Return-Path: <SRS0=a4os=QS=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C978FC282CE
	for <linux-integrity@archiver.kernel.org>; Mon, 11 Feb 2019 18:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97B9221B18
	for <linux-integrity@archiver.kernel.org>; Mon, 11 Feb 2019 18:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ou1Wfg2g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732413AbfBKShJ (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 11 Feb 2019 13:37:09 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:32787 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732502AbfBKShE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 11 Feb 2019 13:37:04 -0500
Received: by mail-pf1-f193.google.com with SMTP id c123so5672468pfb.0
        for <linux-integrity@vger.kernel.org>; Mon, 11 Feb 2019 10:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nArp1SIyjhYvkr2+dj1tRdHY+8xTs51Con5kosXTkNg=;
        b=Ou1Wfg2gwsp34FXdvlHuufYk5gVul5L2Ro9KR6BvE3BRAlTR790QoyHzGbM/uNVBLQ
         9YbQsoUx68UcTcZbpBEJdvDC3hadlcSJv7Xg1vKzP8v2m/Woxv9Eb9kt3huX2WBijydL
         HBKIukouO2OxxZR6LBpt8Elfp0RTFiktZ9OrPMR4R7QcY9Kqwhiy94Ke4UzHGoT0JCWF
         4HhmEHM4HPUzMODyxMElHSOTS1ngr4ZRrs6DO8nKDS9k1mRnlyC1zqe2H00QqIDMYovU
         cmvXy3LlaAYNyk2VBiwQvdIuLnbTgVIGLxwiqhkyDX4Hd7Z5uJFY22eK7QFPQRnmOMZd
         PvjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nArp1SIyjhYvkr2+dj1tRdHY+8xTs51Con5kosXTkNg=;
        b=sSvr4vuHUuLwM7UU6nCGaZTQTGcrWr5otpui6kObPpPnCl5I2fH9sJ5wU2qUNRl28v
         NoIFjqH7LzutnACVlLr4QJahzH4ktwzVUu1tLQnr1uMKq9wG7maiGyvqSdnHUkxBBA3Z
         +aq9DyJutMX0BcRW7graROZNGFmpIeyyoxD6/kyA9Ldk0Knp7KrCqNEkVS6vsWJVkvpg
         epi5ianI/VrFEZtMTrH/bEcuDBpYSJsk1gIHjvaS8dtRVzjdTOOsljICrha3oSmdZV6M
         ysmOoZRsOW2X6r9cXBVXcax6G8JtDnH2KbmRMMt1HJdjkmFNJ4b/j6BlHiXR7Ze1dp1q
         9irA==
X-Gm-Message-State: AHQUAube1hXHqgVQJ+Xm5tZQA7OBj1wBsNCIEaiqX/HFQU1sKSDxl7R3
        qPHGl5cPLtYJeH+5S9AzvJ/4lTIyOg+bKJjt/O9qhw==
X-Google-Smtp-Source: AHgI3IZRCGIkI4dkr6ro49y2f980ZD58xHLurbFNA4K1NZ1glC4lklDpVIZEEFW6qPAc21qEb2yerPFGg14vIXT2dVw=
X-Received: by 2002:a63:40c1:: with SMTP id n184mr7885032pga.225.1549910222886;
 Mon, 11 Feb 2019 10:37:02 -0800 (PST)
MIME-Version: 1.0
References: <0147a993d4a94426afa469a8dcc4e5d7@AcuMS.aculab.com>
 <20181022234357.82217-1-ndesaulniers@google.com> <alpine.DEB.2.21.1810241136130.3525@jsakkine-mobl1>
 <CAKwvOdn+V8iFJ_V1vr3GBm-NwxzaDbcmK+nW1q3uVky7bRsB3w@mail.gmail.com>
In-Reply-To: <CAKwvOdn+V8iFJ_V1vr3GBm-NwxzaDbcmK+nW1q3uVky7bRsB3w@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 11 Feb 2019 10:36:51 -0800
Message-ID: <CAKwvOdnhDin6TJfBVxm6xsCh_nJeBuA7GqbgJwgLnqc3PrJGxA@mail.gmail.com>
Subject: Re: [PATCH v2] [PATCH] KEYS: trusted: fix -Wvarags warning
To:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        jarkko.sakkinen@linux.intel.com, zohar@linux.vnet.ibm.com
Cc:     David Howells <dhowells@redhat.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        David.Laight@aculab.com, denkenz@gmail.com, jmorris@namei.org,
        serge@hallyn.com, keyrings@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Oct 29, 2018 at 10:54 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Wed, Oct 24, 2018 at 1:37 AM Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> >
> > On Mon, 22 Oct 2018, ndesaulniers@google.com wrote:
> > > Fixes the warning reported by Clang:
> > > security/keys/trusted.c:146:17: warning: passing an object that
> > > undergoes default
> > >      argument promotion to 'va_start' has undefined behavior [-Wvarargs]
> > >        va_start(argp, h3);
> > >                       ^
> > > security/keys/trusted.c:126:37: note: parameter of type 'unsigned
> > > char' is declared here
> > > unsigned char *h2, unsigned char h3, ...)
> > >                               ^
> > > Specifically, it seems that both the C90 (4.8.1.1) and C11 (7.16.1.4)
> > > standards explicitly call this out as undefined behavior:
> > >
> > > The parameter parmN is the identifier of the rightmost parameter in
> > > the variable parameter list in the function definition (the one just
> > > before the ...). If the parameter parmN is declared with ... or with a
> > > type that is not compatible with the type that results after
> > > application of the default argument promotions, the behavior is
> > > undefined.
> > >
> > > Link: https://github.com/ClangBuiltLinux/linux/issues/41
> > > Link: https://www.eskimo.com/~scs/cclass/int/sx11c.html
> > > Suggested-by: David Laight <David.Laight@aculab.com>
> > > Suggested-by: Denis Kenzior <denkenz@gmail.com>
> > > Suggested-by: James Bottomley <jejb@linux.vnet.ibm.com>
> > > Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
> > > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> >
> > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> >
> > /Jarkko
>
> Bumping the maintainers if this isn't already picked up?

James, Jarkko, or Mimi, can you please pick this up (and let me know
what tree it lands in)?
https://lkml.org/lkml/2018/10/23/116
-- 
Thanks,
~Nick Desaulniers

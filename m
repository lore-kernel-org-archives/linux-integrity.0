Return-Path: <SRS0=s/8x=P7=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B500FC282C0
	for <linux-integrity@archiver.kernel.org>; Wed, 23 Jan 2019 18:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 857292084A
	for <linux-integrity@archiver.kernel.org>; Wed, 23 Jan 2019 18:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CcoD2MHx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbfAWSnw (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 23 Jan 2019 13:43:52 -0500
Received: from mail-lj1-f175.google.com ([209.85.208.175]:46055 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfAWSnw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 Jan 2019 13:43:52 -0500
Received: by mail-lj1-f175.google.com with SMTP id s5-v6so2853713ljd.12
        for <linux-integrity@vger.kernel.org>; Wed, 23 Jan 2019 10:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n/RbVbIy1FrX9DKc2Qqyjxp8i9MW2OC3m2BAaX40i8g=;
        b=CcoD2MHx0BvVMq6cIIxGh/1KI/w8wHbGAPvZi+nBqv6bfrYAiHSST+ubmM28mlEPiY
         C0m623qguRpczs1DEIwcwJWtJ/FcwUSxIZ8sJUHWcwUCas0oFX0qugq4pfjS5/FxflnY
         zDZwJpYyY5EIrcACE+fT15Sf8W3X7ocmxX61o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n/RbVbIy1FrX9DKc2Qqyjxp8i9MW2OC3m2BAaX40i8g=;
        b=mysORR5th4xGlRtj48kU5tMWp4/ghIqRFbb58dk5k/Zqd27S/2ypPI4Zij/sOAR8EE
         z/WJk/VaenIr9+96QydF1CGdzVxfJ9tIuoMh+E8uF/IwFMD/ZTUYqDvKC+AwaOgikwm3
         Sy4goY9YW9rHezoQcTbkI4HSUYds70rDKGs5ucrUgmAvg7waNf8w6D2OCI7IW+8tZ7aE
         vKGc5Ys80/EQOJY7VPYSkJmBveiogFT82JZqndj3EvaTtbibNj+kBTZPJ6PCNQ1uSXO6
         ABjkwXZ7l/VSv5xoCMKfC/mhlm7IYAwLk2aPcX4/+ZD4HEOK/Aw4OuVxEQWEI3RFMu7L
         VURw==
X-Gm-Message-State: AJcUukfNhKh2cj04+AJWPHmTDQ4GazIEgq5KbFACGMuo2rzFfgrk4Hpx
        8+SnVf3xfwjm5j6iRudI305Zwk767Sswbw==
X-Google-Smtp-Source: ALg8bN6uHKw9vcHmeGovuk65jCkLgYMwMzVzbS3mN7FlJ1UjMh5WMx+UhjCRnd2UXkbjKj51I3bCGA==
X-Received: by 2002:a2e:9f56:: with SMTP id v22-v6mr3054794ljk.114.1548269029397;
        Wed, 23 Jan 2019 10:43:49 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id x21sm608097lfe.6.2019.01.23.10.43.48
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 10:43:48 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id n18so2364887lfh.6
        for <linux-integrity@vger.kernel.org>; Wed, 23 Jan 2019 10:43:48 -0800 (PST)
X-Received: by 2002:a19:1a14:: with SMTP id a20mr2693766lfa.1.1548269027896;
 Wed, 23 Jan 2019 10:43:47 -0800 (PST)
MIME-Version: 1.0
References: <20190118142559.GA4080@linux.intel.com> <1547849358.2794.90.camel@HansenPartnership.com>
 <20190120160413.GB30478@linux.intel.com> <20190122010218.GA26713@linux.intel.com>
 <20190122025836.GH25163@ziepe.ca> <20190122132910.GA2720@linux.intel.com>
 <CAHk-=wgdOfi+zVVfKDDqJMs2Y7Lq0uufmP8Hx8JzQFA9UzNrBw@mail.gmail.com> <20190123153638.GA8727@linux.intel.com>
In-Reply-To: <20190123153638.GA8727@linux.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 24 Jan 2019 07:43:30 +1300
X-Gmail-Original-Message-ID: <CAHk-=whgoJ8aAYH37hnyFjZ8jbYyswyf9wZZ82tTFL5f2he+6g@mail.gmail.com>
Message-ID: <CAHk-=whgoJ8aAYH37hnyFjZ8jbYyswyf9wZZ82tTFL5f2he+6g@mail.gmail.com>
Subject: Re: Getting weird TPM error after rebasing my tree to security/next-general
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jan 24, 2019 at 4:36 AM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
> >
> > Is it just that this particular hardware always happened to trigger
> > the ERMS case (ie "rep movsb")?
>
> This is the particular snippet in question:
>
> memcpy_fromio(buf, priv->rsp, 6);
> expected = be32_to_cpup((__be32 *) &buf[2]);
> if (expected > count || expected < 6)
>         return -EIO;

Ok, strange.

So what *used* to happen is that the memcpy_fromio() would just expand
as a "memcpy()", and in this case, gcc would then inline the memcpy().
In fact, gcc does it as a 4-byte access and a two-byte access from
what I can tell.

Which is actually exactly the same as memcpy_fromio() should do, just
using a different code sequence.

> memcpy_fromio(&buf[6], &priv->rsp[6], expected - 6);

This one gets turned into an out-of-line "memcpy()" in the old world
order, which depending on size will do different things, but might be
a "rep movsb". Or it might be the software expansion that does
overlapping accesses and/or backwards copies.

In the new world order, it's the "memcpy_fromio()" that willdo first
4-byte accesses for the main bulk of the copy, and then end up with a
two-byte and single-byte move to pad out the end.

> I guess it did in the first memcpy_fromio operation since it is less
> than a quad word, right? Not sure why the 2nd memcpy_fromio() operation
> has worked, though.

The first one seems to do the same thing now as it used to do, so I
don't *think* it should have mattered.

The second one looks like it is unaligned (offset 6) and doing the
4-byte io reads would fail if that device needs aligned accesses. The
old memcpy() *might* have done it with a "rep movsb" that would just
work (?).

                 Linus

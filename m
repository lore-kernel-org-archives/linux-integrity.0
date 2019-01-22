Return-Path: <SRS0=iyby=P6=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CAF2C282C3
	for <linux-integrity@archiver.kernel.org>; Tue, 22 Jan 2019 18:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB4D6217D6
	for <linux-integrity@archiver.kernel.org>; Tue, 22 Jan 2019 18:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CMl+ODFK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbfAVS1D (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 22 Jan 2019 13:27:03 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43635 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfAVS1C (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 22 Jan 2019 13:27:02 -0500
Received: by mail-lj1-f193.google.com with SMTP id q2-v6so21529634lji.10
        for <linux-integrity@vger.kernel.org>; Tue, 22 Jan 2019 10:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XUBcaPRcuqOLEl2SYy/Q6oqpj8zeKWGuZM5V88FmHF8=;
        b=CMl+ODFKCfVLcBaWLY/tCSTTxYCbhG1V/NxINTD3f7ytfFq5M59K9J2K6RH2Pm/OSn
         q7GCuvuWVGKVYV62U5nCjKlbBy782E6y+co8/T6PIdApkhHe0go43LUfYd6CwWmR5Ef5
         WvkZWSVRmstQbxD52e4AK1z18Q87hMRWG808E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XUBcaPRcuqOLEl2SYy/Q6oqpj8zeKWGuZM5V88FmHF8=;
        b=CT+07TqPb9Is/HLOuqW13ZgErzvHg5KRrszdNSpn7nJiTOwJ9Ab2oVcreF3mn6RoIO
         xKYua6nt00cPdIMCYYExVps68g9mTg9QUdBwcuDsQU6QGvk7VpbNuP2B/wOFBFAZi4n/
         qKIGMm2vo8Qt4tmb5fGdtCwbpCKMvS0XpaLgvVYXkSDhLm/NnjVkdbOLG4a8kE7SC1Mv
         pu5i2tHEvpZg5CiS7wKOcRsfDbwezAQcxEqBNaVBlCnEOZ2BbyVYk8YZmuS1Hd9nfZWK
         9RzDRDowECrx1NlclVEtfzjz8PPsfj10SHFMt4RjkwsQWejIwTlTlrLbvOx6/vlpF3Nz
         D3YQ==
X-Gm-Message-State: AJcUukdnSLv2Rckq/k8bKEtz5290SYCWdl1HEQVBN/XLuToRFOerKszj
        v/cjq7rtW9b/PwJt2RSe5G9ko1HibE2q0A==
X-Google-Smtp-Source: ALg8bN5JRPViPozyRtTx5pykyfFfZ8TGlE5MgVz6lxaik13kn8GKPraT5NDRhsoLnwpTlm6wf/Hjcg==
X-Received: by 2002:a2e:4218:: with SMTP id p24-v6mr21206040lja.58.1548181620088;
        Tue, 22 Jan 2019 10:27:00 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id u24sm117892lfi.24.2019.01.22.10.26.58
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 10:26:59 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id v5so18827880lfe.7
        for <linux-integrity@vger.kernel.org>; Tue, 22 Jan 2019 10:26:58 -0800 (PST)
X-Received: by 2002:a19:980f:: with SMTP id a15mr22707685lfe.103.1548181618431;
 Tue, 22 Jan 2019 10:26:58 -0800 (PST)
MIME-Version: 1.0
References: <20190118142559.GA4080@linux.intel.com> <1547849358.2794.90.camel@HansenPartnership.com>
 <20190120160413.GB30478@linux.intel.com> <20190122010218.GA26713@linux.intel.com>
 <20190122025836.GH25163@ziepe.ca> <20190122132910.GA2720@linux.intel.com>
In-Reply-To: <20190122132910.GA2720@linux.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 23 Jan 2019 07:26:42 +1300
X-Gmail-Original-Message-ID: <CAHk-=wgdOfi+zVVfKDDqJMs2Y7Lq0uufmP8Hx8JzQFA9UzNrBw@mail.gmail.com>
Message-ID: <CAHk-=wgdOfi+zVVfKDDqJMs2Y7Lq0uufmP8Hx8JzQFA9UzNrBw@mail.gmail.com>
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

On Wed, Jan 23, 2019 at 2:29 AM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> > >
> > > Fails on commit 170d13ca3a2fdaaa0283399247631b76b441cca2. Still works on
> > > preceding commit a959dc88f9c8900296ccf13e2f3e1cbc555a8917.
> >
> > This changes the IO access pattern in memcpy_to/fromio.. Presumably
> > CRB HW doesn't like the new 4 byte move? Swap each one in crb to
> > memcpy to confirm..
> >
> > If the HW requires particular access patterns you can't use
> > memcpy_to/fromio
>
> Did not have time to look at the commit at all but your deduction
> is correct. I know it without testing.
>
> Memory controller will feed 1's on unaligned read from IO memory,
> and as we can see from the TPM header, this change causes two of
> those:

Funky. But how did it work before then?

The new memcpy_fromio() is designed to have _predictable_ access
patterns. Not necessarily the best, but at least consistent.

Prevously, we used whatever random "memcpy()" implementation we
happened to pick, which *could* be aligned (particularly "rep movsb" -
absolutely horrible performance for MMIO, but by doing IO one byte at
a time it was certainly aligned ;), but most of our x86 memcpy
implementations don't actually try all that hard to align the source.
And the manual version will actually copy things *backwards* for some
cases.

Is it just that this particular hardware always happened to trigger
the ERMS case (ie "rep movsb")?

Anyway, Jason is correct that if a device has particular IO pattern
requirements, you shouldn't use "memcpy_fromio()" and friends, but
it's interesting how it apparently *happened* to work before.

             Linus

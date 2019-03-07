Return-Path: <SRS0=us8B=RK=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7330C43381
	for <linux-integrity@archiver.kernel.org>; Thu,  7 Mar 2019 04:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2A8020661
	for <linux-integrity@archiver.kernel.org>; Thu,  7 Mar 2019 04:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GJ7xlEbA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbfCGETU (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 6 Mar 2019 23:19:20 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:53348 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfCGETU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 6 Mar 2019 23:19:20 -0500
Received: by mail-it1-f196.google.com with SMTP id v2so13219099ith.3
        for <linux-integrity@vger.kernel.org>; Wed, 06 Mar 2019 20:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pANHpglTG0EXv0zbkt3lqfU4TbVSK3i9dNNr/p/EvoE=;
        b=GJ7xlEbA/S0BuFVzMIJtRuGeLubczg8t2u90ZNYC7n4CBdyoAAiGKQzOED42D8BhLL
         uHnoV9/EJOb2S44gjqegMO6NT41AyHiwdSVyk+yGIBLK6VVvCyUbH/rLKEGLB2+tXAHB
         4IHBodGh9xAgYkXBz67z1Y0w9feBYepsBPrENRk5CO+9XaeiA8WZAw9KQ6xyRWUvatx/
         PILFJsIQUsKf4sgoIjsqK4FcLuTug+oX6fsDF44bt12CGW8OEoxV3rfFfVnFNcLgkCJU
         lb3LfKHYsCM4I0+8BYxuG1V7EkiUYKujQa5bvRqlg8SEn23eFhHJFRNJBfEYJ8Y9xTKt
         iq8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pANHpglTG0EXv0zbkt3lqfU4TbVSK3i9dNNr/p/EvoE=;
        b=oUzzqWWotRqvRllEr8B4ImAVogGh/xMt2v5PmxNvAK/AUeNKV/qGC0wyBn4vCQ9Iks
         XXB0E4Qmwoqxwbsnna91XsBxFEvpT2rafMk4EHp7ybYXfzfaxTc5CiLp4Kx6QZsFW/iJ
         h1qLV7vONSzxAbkBj6jDoVBpOuzXW5PCyJm3HbRVZhPE6PyFXsOaoyw89yOncRTExp9S
         c8SKLRA6s85FF1LaMPPthKB+WuRBGHwRPmCxnsK+HoCN4mEf0O5WYJu6bxRFoHEzsze2
         5SyUJuQLq/ybmSOYW8mH4EqqApXlSz/UI7kl4cZgA4RzghHnYLxzSRn3aV1LYobgqVu3
         Lbig==
X-Gm-Message-State: APjAAAXFHzEM+fzIV49d+CQU1HiNHh4bjsUbFlvhepgiI/PB+S7DtFu5
        oDQhtjSHB74r9cKhUbWMhcKSgXRExKeLtE6ZK3u9rg==
X-Google-Smtp-Source: APXvYqzSl3+K0EfEwSmZd5V2F+FwEvnELbWGAhRlYJ1R2cxz8awvEFpHRciH/cboRSw4Cp/HiD/Dwj3Hc6MpgDlcU/0=
X-Received: by 2002:a24:7908:: with SMTP id z8mr4498408itc.16.1551932358556;
 Wed, 06 Mar 2019 20:19:18 -0800 (PST)
MIME-Version: 1.0
References: <20190226215034.68772-1-matthewgarrett@google.com>
 <20190226215034.68772-4-matthewgarrett@google.com> <1551369834.10911.195.camel@linux.ibm.com>
 <1551377110.10911.202.camel@linux.ibm.com> <CACdnJutfCxzQDeFzXmZ9f8UrnqNScErkBJd2Yu+VEoy4nBhBCA@mail.gmail.com>
 <1551391154.10911.210.camel@linux.ibm.com> <CACdnJuuRLDj+6OTohfTVzqXp1K7U3efVXXuFfBfhk3CiUBEMiQ@mail.gmail.com>
 <CACdnJutPWEtDMS6YUXF0ykq7gKgQRNk6Fw=aHivHz6+NTodsgA@mail.gmail.com>
 <1551731553.10911.510.camel@linux.ibm.com> <CACdnJutWRB1up6wO3aWJJah3p8k+FY6xEfjw8ETHT69Vvsz8GQ@mail.gmail.com>
 <1551791930.31706.41.camel@linux.ibm.com> <CACdnJuvfzvZaU3CHtvVAP6vj_-rnWeTyAKjmRj8QGt7WAmjicQ@mail.gmail.com>
 <1551815469.31706.132.camel@linux.ibm.com> <CACdnJuvhu2iepghLm4-w2XVKH+TVT1JAY=vtKtf733UXPSBPaA@mail.gmail.com>
 <1551875418.31706.158.camel@linux.ibm.com> <CACdnJuvRuagNTidkq3d4g_OwfzqcALtd=g1-5LDzr2aBA1zV6w@mail.gmail.com>
 <1551911937.31706.217.camel@linux.ibm.com> <CACdnJut9T0xE-Q+ZAfqaRMUeBX=7w+cYE5Y7Ls1PdH-bJfv8MQ@mail.gmail.com>
 <1551923650.31706.258.camel@linux.ibm.com>
In-Reply-To: <1551923650.31706.258.camel@linux.ibm.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Wed, 6 Mar 2019 20:19:07 -0800
Message-ID: <CACdnJuv+d2qEc+vQosmDOzdu57Jjpjq9-CZEy8epz0ob5mptsA@mail.gmail.com>
Subject: Re: [PATCH V2 3/4] IMA: Optionally make use of filesystem-provided hashes
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Mar 6, 2019 at 5:54 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> On Wed, 2019-03-06 at 15:36 -0800, Matthew Garrett wrote:
>
> > > But they would have to knowingly add "get_hash" to the IMA policy and
> > > have signed it.
> >
> > But in the non-signed case they'd still need to knowingly add
> > "get_hash" to the IMA policy. Why does signing indicate stronger
> > understanding of policy?
>
> Nobody is suggesting that signing the policy is a stronger indication
> of understanding the policy.  Signing the policy simply limits which
> policies may be loaded.

I'm not sure I understand the additional risk, though. Either a
filesystem is already being measured using a full read, in which case
adding an additional rule won't change behaviour, or it's not being
measured at all, in which case there's no incentive for an attacker to
add a new rule.

> > > > I'm happy to add this if there's a real threat model around it, but
> > > > requiring signing for something other than security reasons seems like
> > > > it's conflating unrelated issues.
> > >
> > > A colleague said, relying on the filesystem to provide the file hash
> > > extends the TCB to include filesystems.
> >
> > The TCB already includes filesystems - IMA's measurements are only
> > accurate if the filesystem returns the same data on subsequent reads
> > (assuming i_version hasn't been updated). We assert that this is true,
> > but it the filesystem is outside the TCB then that assertion is
> > invalid.
>
> There is also a difference between trusting the filesystem "read" and
> the filesystem "get_hash" implementation, that have yet to be written.

In both cases we're placing trust in the filesystem's correctness.
It's certainly possible for the get_hash call to be broken, but that's
something we can put additional testing into. The same argument
implies that enabling appraisal is increasing the amount of trust we
place in the filesystem - without it we don't need getxattr() to work,
and without digital signatures we don't need the kernel's RSA code to
work. Most new features result in us relying on more code, and in some
cases we're not even able to audit that code (eg, if you're not using
an encrypted filesystem then we're depending on the correctness of
your disk's firmware, and we know that there are implementations that
don't verify updates or which provide debug commands that allow
modification at runtime in a way that could be used to defeat IMA)

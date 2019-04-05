Return-Path: <SRS0=mqgK=SH=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1445C4360F
	for <linux-integrity@archiver.kernel.org>; Fri,  5 Apr 2019 01:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D854217D6
	for <linux-integrity@archiver.kernel.org>; Fri,  5 Apr 2019 01:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="naTs4Qh4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730739AbfDEBvK (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 4 Apr 2019 21:51:10 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:51201 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729635AbfDEBvK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Apr 2019 21:51:10 -0400
Received: by mail-it1-f195.google.com with SMTP id s3so7066764itk.1
        for <linux-integrity@vger.kernel.org>; Thu, 04 Apr 2019 18:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JSStkX+hl541+USr48KyYLLUouGpY6x1+NlBk/g9Zx4=;
        b=naTs4Qh4uzm9pg9zNgZA1s9LAvHM5FEPD9dJj202Kg7Fv1tZkmmTuMR29i6fpCvZzW
         Iwd6LwJFhEGdADvQTkj9wGjIKv7KJgPcnqHJ3pvMhMzRz+6SiYLbWdiEKDgPnai1nxYG
         2FIN5lUYU/Lg4a13Xi3wmf6s3zVZ/5BzkvuvD8UjicxamSBReIplrBwiNYBWvoNwBpCh
         24l/GdVz84NrGhzumpaJAKc22t5uroMYA6mQJ4oOnXgx4ri9h9H3zEGLUKtG3afllV/5
         PZGZ52nIP46PHWuuFSd72bHb8/FsbYEW9m5k7fazCFX2sr3HMDwq+6K7WRDanGsocPEL
         QZZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JSStkX+hl541+USr48KyYLLUouGpY6x1+NlBk/g9Zx4=;
        b=GV/0RY5fN7khMo6hmIZ+U9DKpkUmZgE/ZlOwHJ+ZUXsUSl7Vrs77hQMbh3xC3kEzlw
         CkdOQAlqruerDa5NtnHT/zg2jgGLF0UK9hlq0/AExA7A9VoZCbmdl3rzo+BixeTDakNg
         7qPjuQKwuh/1Obyn/kfiQW2zy1QZmeHUhVmh6fjxUHmgYLN/Uk1kV5lOsPl0jtviXxVT
         lZJbUC07qyheamXHcAJonWEVvpOG0xd0w+6JxHCaIRPvAzZTLbDbiEHianqwYkfm3Btq
         +5fqffvAA8J1SUuQRtIUUBWLgb5m92ez7+TVqW4FIF/P1HkXk+N6C7SevignJMD0+XKI
         8Oyw==
X-Gm-Message-State: APjAAAUBl2w7v/oGvRc/unYk1lgEU+MbHRZPDFNIHrw13TO0V9+DyISa
        aJX+NBRdJibJWqG6N1IaKZz7FPHOkh33dqJY79AEBg==
X-Google-Smtp-Source: APXvYqy9/lBM2UTrl205ZTj/22HoavSJuFTnYo0JcLIZG98bCa80IHORsqBhSc2D0xvVFrTC3J7YRJuj/BIHiFzu1JQ=
X-Received: by 2002:a02:b053:: with SMTP id q19mr7652600jah.21.1554429068886;
 Thu, 04 Apr 2019 18:51:08 -0700 (PDT)
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
 <1551923650.31706.258.camel@linux.ibm.com> <CACdnJuv+d2qEc+vQosmDOzdu57Jjpjq9-CZEy8epz0ob5mptsA@mail.gmail.com>
 <1551991690.31706.416.camel@linux.ibm.com> <CACdnJuvkA6M_fu3+BARH2AMHksTXbvWmRyK9ZaxcH-xZMq4G2g@mail.gmail.com>
 <CACdnJuv2zV1OnbVaHqkB2UU=dAEzzffajAFg_xsgXRMvuZ5fTw@mail.gmail.com>
 <1554416328.24612.11.camel@HansenPartnership.com> <CACdnJutZzJu7FxcLWasyvx9BLQJeGrA=7WA389JL8ixFJ6Skrg@mail.gmail.com>
 <1554417315.24612.15.camel@HansenPartnership.com>
In-Reply-To: <1554417315.24612.15.camel@HansenPartnership.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Thu, 4 Apr 2019 18:50:57 -0700
Message-ID: <CACdnJuutKe+i8KLUmPWjbFOWfrO2FzYVPjYZGgEatFmZWkw=UA@mail.gmail.com>
Subject: Re: [PATCH V2 3/4] IMA: Optionally make use of filesystem-provided hashes
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Apr 4, 2019 at 3:35 PM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
> Redundant information is always possible, but it can become
> inconsistent and, because the hashes can't be derived from each other,
> it's hard to tell if it is inconsistent without redoing the whole hash
> with each method.

Part of the problem here is that IMA is effectively used for two
related but different purposes - measurement and appraisal. You
generally want measurements to be comparable across filesystems,
whereas appraisal doesn't need to be. So if we don't have comparable
measurements, there's less benefit in performing measurement (we have
no real idea what the expected measurements would be in advance).
That's less important for appraisal, but arguably we don't care about
appraisal of stuff on fs-verity backed filesystems to begin with
because we can just attest that they're legitimate?

> I was more wondering what, if any, problems would follow if we did let
> the filesystem choose the hash method and simply used the top merkle
> hash in place of the usual IMA hash?

We could definitely just pass it through as a separate hash type, and
my initial thinking was that fs-verity might be a reasonable use case
for that, but I'm not sure that it buys us much in the IMA case.

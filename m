Return-Path: <SRS0=2iBq=QI=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A638FC282DA
	for <linux-integrity@archiver.kernel.org>; Fri,  1 Feb 2019 17:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76A02218F0
	for <linux-integrity@archiver.kernel.org>; Fri,  1 Feb 2019 17:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bVWglcuN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730652AbfBARt0 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 1 Feb 2019 12:49:26 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40797 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbfBARtZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 1 Feb 2019 12:49:25 -0500
Received: by mail-lf1-f65.google.com with SMTP id v5so5683876lfe.7
        for <linux-integrity@vger.kernel.org>; Fri, 01 Feb 2019 09:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l7lrexG/S2ZMmYpuKyHJIqG74wkYAVGMQ+BpnsBM9Cw=;
        b=bVWglcuNXEYTcI2DPnNSJ687yDAFVE4LcRlyGlRu7KEiazzElLdp5QEWYsGNIuQGmi
         YR+S8F55RsjKDcMQ3sMl+WG3f/Ikw7suvXaNS091xV3aTRgKeoif4C/YT7Yd3imeJ2LM
         D8CjhFcy9U6Q/hQGqvhp8pBKE19I+a0LgJ04g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l7lrexG/S2ZMmYpuKyHJIqG74wkYAVGMQ+BpnsBM9Cw=;
        b=LFxi1U/1ypO1xTP6ZVLn/mcTFCOIoOfjHlgi5YCWjvCoS9JZduPqtca5THcQYMf0kL
         keXd70xYPuByH48upz8Vv+SMGXq5u0e4twT5ogkBoM4LtClDtAW+jBjYv0hchxFZ797z
         DUW1jPGwzui1lK1U1fgZ8Azp4eqgfYSSvXsQQZUnKphMfUfXdexWWu84ZOjXLByLKwz+
         SfP1vIHqdJrmNa58aPcdgyhE5FhNzMwSXId3xHLGE3hGarIqqcxG//n2EonGt3XXQqoS
         +xVAz0dv8lHpQSr6BZA9RA9K8PoBLDsmTviHTpl+HjUJoiQIUSU+JvLBKZHO9ttPpAyM
         3GEA==
X-Gm-Message-State: AHQUAuZc4IPmRv5PYFg3s9F64WSJ3Cf5BLQmeGBDFZnXA5XrFa1BEd5Y
        zfiwgj+m8nm4iGCUYQ/A735thfgqFYI=
X-Google-Smtp-Source: AHgI3IbiCfKb5qEFAcB8G7qdstGA0rmrNZWqnw7ZiuAgoKIUWQfu9pnQnlSSjdHJODpc3T/eNoEmOQ==
X-Received: by 2002:ac2:5551:: with SMTP id l17mr5986015lfk.24.1549043363204;
        Fri, 01 Feb 2019 09:49:23 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id h82sm1483090lfg.94.2019.02.01.09.49.21
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 09:49:22 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id b20so5652640lfa.12
        for <linux-integrity@vger.kernel.org>; Fri, 01 Feb 2019 09:49:21 -0800 (PST)
X-Received: by 2002:a19:4ed9:: with SMTP id u86mr32303202lfk.78.1549043361378;
 Fri, 01 Feb 2019 09:49:21 -0800 (PST)
MIME-Version: 1.0
References: <20190201111949.14881-1-jarkko.sakkinen@linux.intel.com>
In-Reply-To: <20190201111949.14881-1-jarkko.sakkinen@linux.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 1 Feb 2019 09:49:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=whOU=Ek3C6=r2xkTtdv==He=KxUjz_8x2Jo3nJJiDW3VQ@mail.gmail.com>
Message-ID: <CAHk-=whOU=Ek3C6=r2xkTtdv==He=KxUjz_8x2Jo3nJJiDW3VQ@mail.gmail.com>
Subject: Re: [PATCH] tpm/tpm_crb: Avoid unaligned reads in crb_recv():
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        stable <stable@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Feb 1, 2019 at 3:33 AM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> Thus, it makes sense to fix this also in tpm_crb, not least because
> the fix can be then backported to stable kernels and make them more robust
> when compiled in differing environments.

Ack, looks sane to me, and should help both the backport and probably
generate better code too.

In the meantime, I've committed the iomem.c change with a *long*
commit message. For all we know, there might be other cases like this
lurking somewhere else that just happened to work. Plus it's the right
thing to do anyway.

               Linus

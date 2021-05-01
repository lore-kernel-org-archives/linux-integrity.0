Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B02DC433ED
	for <linux-integrity@archiver.kernel.org>; Sat,  1 May 2021 22:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0C2F6143D
	for <linux-integrity@archiver.kernel.org>; Sat,  1 May 2021 22:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbhEAWux (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sat, 1 May 2021 18:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbhEAWux (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 1 May 2021 18:50:53 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B607C06174A
        for <linux-integrity@vger.kernel.org>; Sat,  1 May 2021 15:50:01 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id x2so2536456lff.10
        for <linux-integrity@vger.kernel.org>; Sat, 01 May 2021 15:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FyUcLRZ0Rt19UEL/ZLBgHf+f8fvCiwACi2cQWFH2R+4=;
        b=WIQvM5n8kzuO83VPn1XaK4ss2X3KkxUzpwTAcspVwQI3/ZUorcYOqLyFfKnr/9fmxS
         XCr8wo3tGgeIhK1S/ZssUeq3S/LesQ0YbtwC5nlCPPLh3nidZfPMIk8CZUmkHcaGAQ5y
         HZ7KOHdUd0BEvG1AKdeUOnn9e92SM75vQdfgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FyUcLRZ0Rt19UEL/ZLBgHf+f8fvCiwACi2cQWFH2R+4=;
        b=uLsyB5bz8ZlVs46GC962Y3eaRq9N922wNYMRKiszFmJsikps33Bp9PVtcb6cs+VT7h
         wnoTrdZ/9msn1SBCxGN6jjm6YhuCRjk9t2de456kAS5EqUdNt4W/msHQKS2yqupA/wTt
         OKXIsOBOM0GZmHnniBl/GkWVegX6IPa7d3243SLBMi4Z56J/2QJvpJKm7xebziGgjDY2
         s4cbRwTI/XcKg2CZ5Hy/vaug8rJ8y+v6gHVgnhdJtQeCelI7A+sz9ArZK0ReAQpex8F+
         eEcBRfErC5vVr9APcvntdlSRK1PneziqiX/xSSq4VsQzd4VFRZ6Pl4TMmk0GqBt0APmC
         zKNQ==
X-Gm-Message-State: AOAM531QHh6dcr3o1ldB9HwzIEihpkYrh/wEb1Kf93si5cNyoIKJ5xUD
        nDzv9szIZkqmdacYGEaW76suvx0jDa7E2qe6
X-Google-Smtp-Source: ABdhPJzxeVFv6kqT6Po0LyAAKkIhj1bvBz6JlZKPDDDujnH9PhCyfYznSXmlEc7r2YDsVze1aNGYUw==
X-Received: by 2002:ac2:5feb:: with SMTP id s11mr7818938lfg.99.1619909399744;
        Sat, 01 May 2021 15:49:59 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id h7sm677655lfu.199.2021.05.01.15.49.59
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 May 2021 15:49:59 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id o16so2468120ljp.3
        for <linux-integrity@vger.kernel.org>; Sat, 01 May 2021 15:49:59 -0700 (PDT)
X-Received: by 2002:a05:651c:44f:: with SMTP id g15mr8049801ljg.48.1619909398916;
 Sat, 01 May 2021 15:49:58 -0700 (PDT)
MIME-Version: 1.0
References: <33e5687f1e4c7becdc41136704fa239f81b82fec.camel@linux.ibm.com>
In-Reply-To: <33e5687f1e4c7becdc41136704fa239f81b82fec.camel@linux.ibm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 1 May 2021 15:49:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjBSomE81D=dXN5Z1r_qTLDeKfOzXH4T+mPK6AeSWhW0w@mail.gmail.com>
Message-ID: <CAHk-=wjBSomE81D=dXN5Z1r_qTLDeKfOzXH4T+mPK6AeSWhW0w@mail.gmail.com>
Subject: Re: [GIT PULL] integrity subsystem updates for v5.13
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Apr 28, 2021 at 6:47 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> In addition to loading the kernel module signing key onto the builtin
> keyring, load it onto the IMA keyring as well.

This clashed pretty badly with the other cert changes.

I think the end result looks nice and clean (the cert updates mesh
well with the _intention_ of your code, just not with the
implementation), but you should really double-check that I didn't mess
anything up in the merge and whatever test-case you have for IMA still
works.

I only verified that the kernel module signing key still works for
modules - no IMA test-case.

              Linus

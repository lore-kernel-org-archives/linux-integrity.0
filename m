Return-Path: <SRS0=xmmr=SI=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CEDC10F06
	for <linux-integrity@archiver.kernel.org>; Sat,  6 Apr 2019 06:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEBE72173C
	for <linux-integrity@archiver.kernel.org>; Sat,  6 Apr 2019 06:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PpJ2nZHi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725913AbfDFGX3 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sat, 6 Apr 2019 02:23:29 -0400
Received: from mail-lf1-f48.google.com ([209.85.167.48]:44748 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbfDFGX2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 6 Apr 2019 02:23:28 -0400
Received: by mail-lf1-f48.google.com with SMTP id v71so5870467lfa.11
        for <linux-integrity@vger.kernel.org>; Fri, 05 Apr 2019 23:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uEd5HqtkCrmzhV8uD60XV6tOAxCTbXINpuF+45nWtFI=;
        b=PpJ2nZHi7E/DZ+6QeFzzHo0EhkVhwFMNyvy/brBBYekIYQfwRNleatq/p4mVW1yMKr
         oV4c3IQcDb8vniUUv99ASBMvk/ogPa+Q7k7uJ3Ml2pL6BsGZKMQxt2kPpwBTmjyQMOGe
         ZMH1ja9ppUFgCA8TkIY4aOG1TGcKE1gYk67zki7rk0gDnU76BF9p8izyPcqdtNsq53Nf
         XIlxyUmNHEw54JdUUs3U40hIwwn2FolMdaZtczITKlH+Ly4P6LHuhgYn8z10viKceBtT
         Vbbcc0MjrEvHw+sdkNIRZmLgdXhHLDHsHUXQU05/K0k0mTMsWmWN3v9sg9WCZUl856fv
         yMoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uEd5HqtkCrmzhV8uD60XV6tOAxCTbXINpuF+45nWtFI=;
        b=roPHYSxmk/XCZudjpNpxZkAyjdcxjpPpaNOeCpNkodUtdGJHUur13PPVxPRslMr+k8
         dbqAP+kwoOXpV0Tvt+xGuTFgFIaSAS+Xxi2mEj6/zs6lcFe7EW1+3Iljgc1YlpC+tLWK
         Z5qLtdsrvHth8kyfaC5iASqSo7rkaAVP8W7M1s69pn1WQGXu/5P7SSUMa0R2dv16u4Ap
         HKZgI/yCsamQU3xopdbbo5UWCZJeQgA7rQWI7J22RufaCrLAdRbwXaGQo0G+EhyCkwJL
         IUiosM8kBva0CUtDNmD+BoBHzlH65iZlz/kLelijOkDoaY9Eq1ukc0Mn9+KzCpkJjVde
         vMqQ==
X-Gm-Message-State: APjAAAVPUk6FRhRGGqBS7QYYlBZlIM3vJjpoAG4VvIk5tdT6Gd7c9/b6
        FfgbcniqZRP+MPGou8jJBl02J8SNFAqSXFGxNWw=
X-Google-Smtp-Source: APXvYqxXxTIfrR1/W2NhegIMqMIIH3CTwV0niZpa59NDULwYo/uP0JOwWNuwwfDoVgDj/b/otehwkTJFasuVPtVDOfk=
X-Received: by 2002:a19:7114:: with SMTP id m20mr9139600lfc.63.1554531427459;
 Fri, 05 Apr 2019 23:17:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAE=Ncrbk9-FLbGYKawdu62iDNKD-HH1QaDC+aDZAWPcf=17R7A@mail.gmail.com>
In-Reply-To: <CAE=Ncrbk9-FLbGYKawdu62iDNKD-HH1QaDC+aDZAWPcf=17R7A@mail.gmail.com>
From:   Janne Karhunen <janne.karhunen@gmail.com>
Date:   Sat, 6 Apr 2019 09:16:56 +0300
Message-ID: <CAE=NcrbR+TzNJ0xqf_ZSPOsm+J+Lbnxi8MMVy_9_2KfdpocgQA@mail.gmail.com>
Subject: Re: appraisal reset safety
To:     Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

Any thoughts on this? I would guess every system with active databases
would need to address this somehow?


--
Janne

On Fri, Apr 5, 2019 at 3:46 PM Janne Karhunen <janne.karhunen@gmail.com> wrote:
>
> Hi,
>
> I've setup an android based mobile device with pretty complete ima/evm
> setup that covers just about all the standard use cases (imasig based
> filesystems, ota support, factory reset support etc). All that is fine
> and ima runs like a clock.
>
> Since this is a mobile device, running out of battery or getting shot
> in the head by something is always a realistic option. The random
> resets seem to be leading into random appraisal failures as android
> seems to be keeping surprisingly many files constantly open for
> writing. So many actually, that I feel somewhat uneasy starting to
> whitelist these files from the ima policy. That sounds like a viable
> route only when it comes to the log files as those files primarily
> move data only one way.
>
> Now, is there any prior art on this how to make this work right? The
> improvements that I can instantly think of are,
> 1) whitelist everything that can be,
> 2) reduce the vfs flush delays,
> 3) make it detect the reset condition and fix the known files when
> that happened. Unsafe and requires a patch (but that seems easy).
>
> Anything else?
>
>
> --
> Janne

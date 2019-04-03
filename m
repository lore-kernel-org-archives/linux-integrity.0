Return-Path: <SRS0=2lTb=SF=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 863B4C4360F
	for <linux-integrity@archiver.kernel.org>; Wed,  3 Apr 2019 16:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B0E6206DF
	for <linux-integrity@archiver.kernel.org>; Wed,  3 Apr 2019 16:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p22/Z5rX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfDCQwH (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:52:07 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:53731 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbfDCQwG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 3 Apr 2019 12:52:06 -0400
Received: by mail-it1-f194.google.com with SMTP id y204so12222836itf.3
        for <linux-integrity@vger.kernel.org>; Wed, 03 Apr 2019 09:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4p9DCgQgsr790KfkgtXSWh2jKym2hVb6FBVl/CH46a8=;
        b=p22/Z5rXqwUBUy0JrXYHxdoMMyOAAwqIblCj/YDxKYkMVW62liKcZyD+6p9enOOlHP
         7IwexsdREYdWII/ppftVvut85IK9ao0NQsXRKLyUX0yI7q+hIMJtglzC5CcQBNMCvWgs
         VAoxkmUtF8ZAdCPyZ25BWbYxFCVS2+miospyY1OvCoQLePbq6Vl3yNg6gKiWQNroexI6
         lCqDY+SLs1Glu9SVxPbrQvEhIJjpUa1AZqT+s5bpTEWE/SdgiMGS29Azo19yZVLKBrqD
         yik3PFjwG3eIzQ7a48ohb6NAqk/BUkZxm2kLo62/II6yCQJBKARnIH9cuhavPVe/FLmm
         rMEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4p9DCgQgsr790KfkgtXSWh2jKym2hVb6FBVl/CH46a8=;
        b=OxuSFtkY3Byj47QJzjbLijE3VxruxcrnQOQ4LEreslPNUu0s9w9w3o6S0ZZ7V10pWS
         9EfTfAZtclxYFEWjMBhy9TtbnbHGAhKcWqkfoHrLh2FVR8pu/6Exb8dI5jySj54YEaXc
         6oQ7Q41wcJmcTeDsRCg2V307v8bJKMidX4bjXZmfQvOY4JAtEf0m2olLXX2UL3LrihEw
         4z9Zc5a1Cg9nKNXrhYNzHwDC+GvdBaL/i3T+20aF7s39ejsh5bRZLQsVrFa0fNR+jThe
         i31Nnh9LURp8ZnTxZmFCEqPuIa1EE1ojxR/lS5JAh/p0SuAD55Tv+O74oMvgQHq9mZdd
         p8hA==
X-Gm-Message-State: APjAAAXfH+6/pcKPoyx5KEiCgStAfv+72NyPafQMgiDkTiRITUF56Exu
        cVOdIEeIG/ucfNyl/F2/RdToUL71GRrcKjZeDXTv1w==
X-Google-Smtp-Source: APXvYqx26i4yUUl0huOB66AMdZnSFnaE7uxqR+E2MYHOlTwmAQvcYY5aoSLY1FczwZhgt8HrbWncfCFuQD35CBrl2H0=
X-Received: by 2002:a02:1a45:: with SMTP id 66mr1086145jai.124.1554310325448;
 Wed, 03 Apr 2019 09:52:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190402215556.257406-1-matthewgarrett@google.com>
 <20190402215556.257406-2-matthewgarrett@google.com> <89e1cf4093d7405987c55f682519f9fc@AcuMS.aculab.com>
In-Reply-To: <89e1cf4093d7405987c55f682519f9fc@AcuMS.aculab.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Wed, 3 Apr 2019 09:51:54 -0700
Message-ID: <CACdnJusiCSH93cz+Q3yH01HBfDbVRQdO6JNCNOJwqt9Uqj_Qsw@mail.gmail.com>
Subject: Re: [PATCH 1/2] efi: Fix cast to pointer from integer of different
 size in TPM log code
To:     David Laight <David.Laight@aculab.com>
Cc:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "roberto.sassu@huawei.com" <roberto.sassu@huawei.com>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tweek@google.com" <tweek@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Apr 3, 2019 at 6:41 AM David Laight <David.Laight@aculab.com> wrote:
>
> From: Matthew Garrett
> > Sent: 02 April 2019 22:56
> >
> > 8bfcff4a6a1d9d7226bb63a7da758b82d9ab4373 introduced a cast from
> > efi_physical_address_t to (void *), which are different sizes on 32-bit.
> > Fix that. Caught by the 0-day test bot.
>
> Casting a physical address to 'void *' seems completely wrong.
> Also you'd need a guarantee that the address was below 4G or the result
> is meaningless.
> Looks to me like something is using the wrong types somewhere.

We're in UEFI here, not the kernel proper - the firmware functions we
call give us back physical addresses, and we're operating with a 1:1
mapping. long is 64 bit on 64 bit systems, and on 32 bit systems we've
already asserted that all firmware resources are under 4GB (obviously
we're going to have a bad time if they're not, but there's not really
anything we can do about that)

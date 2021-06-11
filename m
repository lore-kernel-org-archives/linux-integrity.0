Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC84FC48BD1
	for <linux-integrity@archiver.kernel.org>; Fri, 11 Jun 2021 09:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5A67613C8
	for <linux-integrity@archiver.kernel.org>; Fri, 11 Jun 2021 09:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbhFKJHo (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 11 Jun 2021 05:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbhFKJHo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Jun 2021 05:07:44 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF72C061574
        for <linux-integrity@vger.kernel.org>; Fri, 11 Jun 2021 02:05:30 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id b145-20020a1c80970000b029019c8c824054so8198158wmd.5
        for <linux-integrity@vger.kernel.org>; Fri, 11 Jun 2021 02:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ry2suuzXUcu07KBYOEsb0YWMddgl4sZoFMfa7hKOgms=;
        b=zP33EHoQsf7qLPQMdpBdFo7t8iJNFw2h3mCHTGhZs6q/PNkWYYg6Lj7b/4oKCHxfnc
         PgeM5chi+Q2hdpb0PWjfcfrWfXduRDbn6SHDbUR5I5kDp5EZpJx5mC58hsnSEYi307LR
         RCj3W0r3b6rJDe6LZH0lOoufyqEM+UKiPVAEmHiBY1lHpwqRGcdrPktVAI+y8ZvDMQ+2
         JQLootHAB320n0+/e0lXFYpv+2wOJWGGG6pbel+FSRTZSG9Cwuh2998/wEA1CPCO1PP7
         nZrN/tES0u0uBGJ2bYXyhm4Rh1DSYTXg4imyqZcDbZ50jciSX6AK+TJoeffZbadQZpA7
         q1Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ry2suuzXUcu07KBYOEsb0YWMddgl4sZoFMfa7hKOgms=;
        b=MGGhT5VCWMEdw1q0SGv+cNbmhoQIMpqUr6hRywTYWrMm82s4wUNppy6s88fpWNE0Hc
         oDsqEZc4gHkiC2M1zOVAzEeiJz9IqAiwrT1k15TjMy2XlqalxpN0flaUVwWQJf1MbISl
         6Rqo/LxEpJh3MpmavAT6ha996aQ1Ft0bzvT8Np3HL7f0DrpKxio6Um2dhLRBtK4gwW4R
         YoLT9CkPM5ASGsDHiZVkRlIiI7FqJB8557YZTTmUqxgmr2x3StqYeDbYO3p05zISQ742
         FYOwejyAscAX9oijHQs4S5H+t0SBaM+oTY+LU9FoXN5+udTaf1Eg4pUoUzCf2kJDV8B9
         qumQ==
X-Gm-Message-State: AOAM531ch14+OJCyVZCuiZNM4ED4kkIvJ8j3g6BH7sRqAdYN9Hpl0duL
        NsM59+25tplbMCdc6f/70IOLcssC0cCqzll1yZ8zEA==
X-Google-Smtp-Source: ABdhPJyMlGh/XMRZoKA9ZoOaNrMuesnznrGSeVm7Eiib/+SYCe73p200udVyt5+QPKdB81ZQgtzC6XY+WhMXpi1YZsM=
X-Received: by 2002:a1c:41c5:: with SMTP id o188mr19048807wma.60.1623402329133;
 Fri, 11 Jun 2021 02:05:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210610210913.536081-1-tyhicks@linux.microsoft.com> <20210610210913.536081-2-tyhicks@linux.microsoft.com>
In-Reply-To: <20210610210913.536081-2-tyhicks@linux.microsoft.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Fri, 11 Jun 2021 11:05:18 +0200
Message-ID: <CAHUa44HU+KnqRKnvhK=Xm3WJeYN5HPJ83e0=v+CZ0hztBWh6Fw@mail.gmail.com>
Subject: Re: [PATCH v4 1/8] optee: Fix memory leak when failing to register
 shm pages
To:     Tyler Hicks <tyhicks@linux.microsoft.com>
Cc:     Allen Pais <apais@linux.microsoft.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Vikas Gupta <vikas.gupta@broadcom.com>,
        Thirupathaiah Annapureddy <thiruan@microsoft.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, linux-mips@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 10, 2021 at 11:09 PM Tyler Hicks
<tyhicks@linux.microsoft.com> wrote:
>
> Free the previously allocated pages when we encounter an error condition
> while attempting to register the pages with the secure world.
>
> Fixes: a249dd200d03 ("tee: optee: Fix dynamic shm pool allocations")
> Fixes: 5a769f6ff439 ("optee: Fix multi page dynamic shm pool alloc")
> Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> ---
>  drivers/tee/optee/shm_pool.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)

Looks good.

Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>

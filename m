Return-Path: <SRS0=looH=74=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4774DC433E1
	for <linux-integrity@archiver.kernel.org>; Mon, 15 Jun 2020 14:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2679F207DA
	for <linux-integrity@archiver.kernel.org>; Mon, 15 Jun 2020 14:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LA7C8lBE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730615AbgFOOcx (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 15 Jun 2020 10:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730279AbgFOOcx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 15 Jun 2020 10:32:53 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE348C05BD43
        for <linux-integrity@vger.kernel.org>; Mon, 15 Jun 2020 07:32:52 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id o4so9121086ybp.0
        for <linux-integrity@vger.kernel.org>; Mon, 15 Jun 2020 07:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mBHfWvG1RIV80Qm0vTG/TJJq/QXnEHlxY8x/LtZQxME=;
        b=LA7C8lBEqsjQ76Nh70y54JiN/24onh1bYawDbjiH/G/EwIusxgbI0a0dOIWOlzLRB6
         hwM+CQpIM1prkKYIi8vsGCpZIePsov3HDZyL5+SO5TSLqzFps/Hl1R6hEbrumk0UFAwc
         fRVDxPFoxyxYpDwB7x6slFZMGg+UwqLMDdJqkCaFgdlklrvDBq2S12u5dxb+5O56QdE6
         hQVCyCmlMd8spyhDzpDr9Hbdf85lCcweQKsScofiyB85ACDa+CWRonZLNaDC4bRVJw2H
         uNfBIGqE9CmcqB0p1VBH5yPcev5QvWWmhWAFY4AlFStAH5N37vWrt7LVwfPF/xVMmrBQ
         pigA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mBHfWvG1RIV80Qm0vTG/TJJq/QXnEHlxY8x/LtZQxME=;
        b=Ye+ZVXDEEoVGGUKlyDTwC5LFeErCEZiR2gWPorpiJYPbl5fJ+p/rZmR4cIHktXH2Sj
         I1GoRpGYpt9jb+oN3oM+R/YkZub3XGoqwutC7KKq8HrEFQOo6vFJycMawHULzo81l6+I
         l03OCNsj7zrg3ZzhvCy3YfWZQUJJd9gKshQyxVXdet/FJcQQzn14BY3BFgze35qb/08o
         bhwwlP72aVx67rBcTPoO1a/WJChuTA09eumn/0PEFhDZwPePcM2UmRYuAeMOPjqPMU7d
         Ue8kbqqP1iTFcLeBrhAgw0cvbhseG+DTdrr/u5wWw5nwcMoTjf4b6XyRwhOrmKaBaO2t
         Jflw==
X-Gm-Message-State: AOAM532jXjs2YYxFJ7itqDKNdR1x/K5lQa2h5L4FlJ9rg4CHQzvBklTB
        HFwseyW5tgn8NmBv9NJfLROPMFQW4HyHZCbagS/xbQ==
X-Google-Smtp-Source: ABdhPJwGrXXWQd2EBc9axDU5/+8oIbuJL0wMB+/DzxWcoQO3VSHyYp1eMYpDhLUUD3J+xgtnBmXccm30c6WCmAKQZmk=
X-Received: by 2002:a25:da96:: with SMTP id n144mr43789713ybf.291.1592231571611;
 Mon, 15 Jun 2020 07:32:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200604175851.758-1-maxim.uvarov@linaro.org>
In-Reply-To: <20200604175851.758-1-maxim.uvarov@linaro.org>
From:   Maxim Uvarov <maxim.uvarov@linaro.org>
Date:   Mon, 15 Jun 2020 17:32:40 +0300
Message-ID: <CAD8XO3YTz=xN2k5h8HsrYsLUgmC6dD57XbBj63e+3_xFF1H0rw@mail.gmail.com>
Subject: Re: [PATCHv8 0/3] optee: register drivers on optee bus
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>
Cc:     peterhuewe@gmx.de,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        linux-integrity@vger.kernel.org, Arnd Bergmann <arnd@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

ping.
Patchset was reviewed and all comments are codeverd. Optee-os patches
were merged. These kernel patches look like they are hanging
somewhere...

Thanks,
Maxim.

On Thu, 4 Jun 2020 at 20:58, Maxim Uvarov <maxim.uvarov@linaro.org> wrote:
>
> v8: - fix v7 check.
> v7: - check return value of dev_set_name() (Jarkko Sakkinen)
> v6: - description, comments, patches reorder and destroy workqueue (Sumit Garg)
> v5: - removed pr_err and fix typos in description (Jarkko Sakkinen)
>     - added missed kfree in optee_open()
> v4: - sysfs entry is optee-ta-uuid (Jerome Forissier, Sumit Garg)
>     - added Documentation/ABI/testing/sysfs-bus-optee-devices (Greg Kroah-Hartman)
> v3: - support tee-suppicant restart (Jens Wiklander)
>     - description and comments (Jarkko Sakkinen)
>     - do not name optee drivers by index in sysfs (Sumit Garg)
> v2: - write TEE with capital letters.
>     - declare __optee_enumerate_device() as static.
>
> Maxim Uvarov (3):
>   optee: use uuid for sysfs driver entry
>   optee: enable support for multi-stage bus enumeration
>   tpm_ftpm_tee: register driver on TEE bus
>
>  .../ABI/testing/sysfs-bus-optee-devices       |  8 +++
>  MAINTAINERS                                   |  1 +
>  drivers/char/tpm/tpm_ftpm_tee.c               | 70 ++++++++++++++++---
>  drivers/tee/optee/core.c                      | 27 ++++++-
>  drivers/tee/optee/device.c                    | 38 +++++-----
>  drivers/tee/optee/optee_private.h             | 10 ++-
>  6 files changed, 119 insertions(+), 35 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-optee-devices
>
> --
> 2.17.1
>

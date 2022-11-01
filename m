Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB68AC433FE
	for <linux-integrity@archiver.kernel.org>; Tue,  1 Nov 2022 15:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiKAPxU (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 1 Nov 2022 11:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiKAPxU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Nov 2022 11:53:20 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29ED7167E8
        for <linux-integrity@vger.kernel.org>; Tue,  1 Nov 2022 08:53:16 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id t25so38125796ejb.8
        for <linux-integrity@vger.kernel.org>; Tue, 01 Nov 2022 08:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=krVzZq9tImSVKhNSwmyx5FUkEl3EHfvETEVJbBZ50GQ=;
        b=PIVfLw+rTgZpkZ2RaTHQi9BNWp1og3LoYr7+FOXdy39xK1Za5l/3ctot3PaRfWh+aU
         wCaaRSIG/x0Jgsj8LcpnpZmHJgw/HIuQ6s+BCJ4MgTWLuTL2lo3P2NOgOTJCf/H/yVuU
         9OpfaVv8XuFZekOa5DEdigNEepUR08zz6u1MQ2g2vmzOtZH/UWJv4hJNh4rtvRiW7/nX
         v/FiOpk53/Ff5y1gk0qJKI2Rc3Hgn64oGUkAqDgZ6a72WpIpNL5DFhnYk9b+qG13u+43
         EQ6RcLfC0GG/5FVPuinlzmekI0VCoidzARXR1oTfgGpmqZfM7hzWjQn3uLyXwUjLbeM/
         hvkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=krVzZq9tImSVKhNSwmyx5FUkEl3EHfvETEVJbBZ50GQ=;
        b=c0B1/po8IJ5x4hWMCxdwJbqzSVpgtDIuKZSIfQzg1UALRe74IHRDEuknz5pCHlAJBu
         u/dVxuy0LyG9N1uXHxYZVvZFna/jMwsiwhhIZpeni4+Po4Yc1sYudyUrKuilQEK8yK4m
         ib4pHheiAkH8kCLy1q8X9YwjngJ6O+6fu1Gu/XOw/+8yec+sl4ALPsx96RkC4ZwSZ4NJ
         OKwFMofqs+ikCpNIvSxF1g3o0YNg1P7hEuTQxy3qFmr8KVX5cMWgurvh9J9FrbFK/qvM
         OPanvqOx8K/qTU+vfa8M1Kj3CoDvWYZR2BOKsBdYMgczuDwRkApocuVUip5FYUfJVo32
         k1zg==
X-Gm-Message-State: ACrzQf3E0gWiPMy0nGft9ZPjono2ch7zsQyQ29JnZnS0I4VB0P+6otA8
        CuKBHtDlUtYv3DubenBy7VeW14Zz/ATW8fn7XHD/qA==
X-Google-Smtp-Source: AMsMyM7Eh5+RyNKsX42Iw3wNFJiYktvAWtkOMWKiWKS4BXls2fUYdIk2wnotYEv7K3vhBi2ymX2vGJsUljsDeHR0S9E=
X-Received: by 2002:a17:907:969e:b0:7a6:fe3:6f11 with SMTP id
 hd30-20020a170907969e00b007a60fe36f11mr19217443ejc.501.1667317994392; Tue, 01
 Nov 2022 08:53:14 -0700 (PDT)
MIME-Version: 1.0
References: <20221101020352.939691-1-jsd@semihalf.com> <20221101020352.939691-2-jsd@semihalf.com>
In-Reply-To: <20221101020352.939691-2-jsd@semihalf.com>
From:   Tim Van Patten <timvp@google.com>
Date:   Tue, 1 Nov 2022 09:53:03 -0600
Message-ID: <CANkg5eyWqhReHJd7Bj5EEG5chz89M-PKCnak91qPRWZEzm3NRw@mail.gmail.com>
Subject: Re: [PATCH 1/3] char: tpm: Protect tpm_pm_suspend with locks
To:     Jan Dabros <jsd@semihalf.com>
Cc:     linux-integrity@vger.kernel.org, jarkko@kernel.org,
        peterhuewe@gmx.de, jgg@ziepe.ca, gregkh@linuxfoundation.org,
        arnd@arndb.de, rrangel@chromium.org, apronin@google.com,
        mw@semihalf.com, upstream@semihalf.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Oct 31, 2022 at 8:04 PM Jan Dabros <jsd@semihalf.com> wrote:
>
> -       if (!tpm_chip_start(chip)) {
> +       rc = tpm_try_get_ops(chip);
> +       if (!rc) {
>                 if (chip->flags & TPM_CHIP_FLAG_TPM2)
>                         tpm2_shutdown(chip, TPM2_SU_STATE);
>                 else
>                         rc = tpm1_pm_suspend(chip, tpm_suspend_pcr);

This if-else block is still interacting with the TPM even though
you're not guaranteed to have the lock, which could lead to
racy/inchorent results. Would it be better to just bail out entirely
since we can't safely attempt any recovery at this point. If it's
still worth attempting the shutdown command, it would at least be good
to add a comment admitting that we have no choice but to communicate
with the TPM without a lock.

-- 

Tim Van Patten | ChromeOS | timvp@google.com | (720) 432-0997

Return-Path: <SRS0=3Dhz=SE=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7FCC4360F
	for <linux-integrity@archiver.kernel.org>; Tue,  2 Apr 2019 19:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE4382070D
	for <linux-integrity@archiver.kernel.org>; Tue,  2 Apr 2019 19:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PEbeytWV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729512AbfDBTgP (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 2 Apr 2019 15:36:15 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37950 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbfDBTgP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 Apr 2019 15:36:15 -0400
Received: by mail-io1-f65.google.com with SMTP id v4so11992535ioj.5
        for <linux-integrity@vger.kernel.org>; Tue, 02 Apr 2019 12:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zlRxsviX0XesyuTOpTmBSNbFYjdf1o9JPP/X25S5UL4=;
        b=PEbeytWVtViSAydL5WdHTirzQN4gHa9ndPh7VqRvjuA5k2wU2F2wOZglNt8TgXiMIZ
         iO/s7uaH2MWdhOPNT4DEuk2v2PlXbSPr5n8johK7kinMWy2OozUgLgOxMsxgeIdugFm3
         thBDMQjnXI70ElXcM7/ttNvaLBWpNCDGYm6/ZvSDT3PTuZwndYWhhzB8FEefAhauPxUD
         22iqlekPFRVhasBxX7wQUTmCEWXmPKL7080LY7Z3fzJh52XpGk/nxgxMkwjfq1Cy+6+Q
         v6n3E/4MuyBukippPY0/o47/Ptb07VX2nPTB7SAcEW441L/FMgbv9TFKoqCYT2s+bW4e
         /iOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zlRxsviX0XesyuTOpTmBSNbFYjdf1o9JPP/X25S5UL4=;
        b=rsqjShGw4vWyhILCj1+gEocJVwaeG2pyYOBii/q7AqkdeB/mYqcosg2y+kzr905gTy
         bzXuwKNkUCG7F9rBMRdJmm59x8wP9QG15jKmqjaJ3dA9vsf1/tV8dCms+Pka2KkZOa4i
         Qbc7dAlnmrolV8ydpYo4u6Dt+9EI6C4h3BzpBgOF3ltpjDPhX4BTC0HcLRS2Sh58tkqs
         JzvZcMAXAYrdrrhvKK34yO6DdtD9Ns3kaO59+hyCFLiJAjfxXtwb9gusuMYG4dtIhBGE
         noZu++JD4lN1mexF70NYeZqM1YSkaR4KtbvdO0Jdoyz9nuGfgSMkzvM9keS/mxZOV53R
         XDOQ==
X-Gm-Message-State: APjAAAWjhvKLmY/vFTcuTKMFM/9BE4fv3YzmFPKfjyPrSa0oEBIApU0Q
        yoL46HkMKx6Mz4wVGNnbVX778xAHb9xw8gCGDzTKuQ==
X-Google-Smtp-Source: APXvYqwscRaXroHB1AxWrjj5kHT1xeAOuyDfNgXvFlQkd6aLAI5EcCPflk+ZfStfDPgxifFf/bp5MRKYdgGf5SDI/y4=
X-Received: by 2002:a6b:3106:: with SMTP id j6mr5287705ioa.147.1554233774199;
 Tue, 02 Apr 2019 12:36:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190402181505.25037-1-cclaudio@linux.ibm.com>
In-Reply-To: <20190402181505.25037-1-cclaudio@linux.ibm.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Tue, 2 Apr 2019 12:36:03 -0700
Message-ID: <CACdnJuumhkqTb4+1=QBiLmbW4xd3wW=MZu6Tj_KdaoTMhCN+Tg@mail.gmail.com>
Subject: Re: [PATCH 0/4] Enabling secure boot on PowerNV systems
To:     Claudio Carvalho <cclaudio@linux.ibm.com>
Cc:     linuxppc-dev@ozlabs.org, linux-efi <linux-efi@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Matthew Garret <matthew.garret@nebula.com>,
        Nayna Jain <nayna@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Apr 2, 2019 at 11:15 AM Claudio Carvalho <cclaudio@linux.ibm.com> wrote:
> 1. Enable efivarfs by selecting CONFIG_EFI in the CONFIG_OPAL_SECVAR
>    introduced in this patch set. With CONFIG_EFIVAR_FS, userspace tools can
>    be used to manage the secure variables.

efivarfs has some pretty significant behavioural semantics that
directly reflect the EFI specification. Using it to expose non-EFI
variable data feels like it's going to increase fragility - there's a
risk that we'll change things in a way that makes sense for the EFI
spec but breaks your use case. Is the desire to use efivarfs to
maintain consistency with existing userland tooling, or just to avoid
having a separate filesystem?

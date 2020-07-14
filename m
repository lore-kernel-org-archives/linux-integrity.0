Return-Path: <SRS0=WSLs=AZ=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7BEC433E1
	for <linux-integrity@archiver.kernel.org>; Tue, 14 Jul 2020 15:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BF1E22453
	for <linux-integrity@archiver.kernel.org>; Tue, 14 Jul 2020 15:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMV4wda0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbgGNPDY (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 14 Jul 2020 11:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgGNPDY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Jul 2020 11:03:24 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B374C061755
        for <linux-integrity@vger.kernel.org>; Tue, 14 Jul 2020 08:03:24 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id dm12so7609523qvb.9
        for <linux-integrity@vger.kernel.org>; Tue, 14 Jul 2020 08:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e6hx9e4B8fkpL+kza+H0V8Zb+GT7gg8vgu8VGRW6YxA=;
        b=WMV4wda0ARR/56BJn3bJgv3MqD7AZ2y80Vpo8G8HorP7+N5s+1H8SOplwQKytwj3Qf
         Cru3uTaZv2YO/2ECrJYu1HBvCnv6H8qtNjEYnZ11WOtzXgbmP80scYM0Shv8nspm7uYF
         MqP2K+zOIVctfhFvvFE/svsQNUOSG1Ih+zThK5fBrxzPqsDd8NKwDIoO2XyFa1zaGeFn
         V8vDs1AZQk1fI8jaUcWA8Wvl0rblQrWvsl4QZ1U2U5WxjDmTx3QhJQhamoMWvhhr7xPi
         rBWaLG7rAglpc968q/4ZkiB1tT/SnLPFJqqMdRERGCIaymfuYaXIjl4KcJ/pEl8v5L3N
         XJBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e6hx9e4B8fkpL+kza+H0V8Zb+GT7gg8vgu8VGRW6YxA=;
        b=mKDby8g5lEfj324m8HJFTrJSVYsnCpqFrb+kvcJOLXP6w8Y3xTZCajnH9eNMjKaF1f
         A5HjUW3a+sfahdkgH7dwqO/QWGpgeVEr42dYkQrEP9nSiTW/xoTWw5RVY/HvfW9T9kSH
         ECglPUFyBWVp3iMudcxLeNJ1a8O1rkJeZqCUPLnF86c3AWZr0iwHUY11LotN67riXOM6
         KaHpkVC9tfASZsbj/cKymcU1Jl4tSNTpLy8FjMOADFZzCV+3HudrDWr4sLBJQoBD1nGU
         tNOYP+/YkgXHq+AkVXOxMn9M6foD1JvMpJvzM4/HPnPSkdeqUHwL/yxYkEGHqw1ErwgF
         HlRg==
X-Gm-Message-State: AOAM533+GRbjd7gGdFDHxPABIA7uc29l6gls5dcWkCPJOf0Yq3MnBIzP
        HgoMpWObr4vNng1UsGnIkPv88y17W7tHs/IL06s=
X-Google-Smtp-Source: ABdhPJxTZNxq9a05/qA+FOjAfMqb81GE/zzigepxk614AIGlkqRXtRpvmLyPnvXPJr89B+7Ve+jsXIyC0i+/WABnoTs=
X-Received: by 2002:a0c:dc8c:: with SMTP id n12mr4968632qvk.221.1594739002358;
 Tue, 14 Jul 2020 08:03:22 -0700 (PDT)
MIME-Version: 1.0
References: <CALUj-gu9-0ZKDvTAOFN1jcbYBUXMymPTJmyD=J6C58mVoKi4pQ@mail.gmail.com>
 <1594738607.12900.159.camel@linux.ibm.com>
In-Reply-To: <1594738607.12900.159.camel@linux.ibm.com>
From:   rishi gupta <gupt21@gmail.com>
Date:   Tue, 14 Jul 2020 20:33:10 +0530
Message-ID: <CALUj-gsksfmAgCzhk_b1wjsU-k7JDv-Bz-0vg6zgFWuOsfBC7w@mail.gmail.com>
Subject: Re: Queries regarding portable feature and signing process for EVM
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Thanks a lot Mimi for this exact info.

Regards,
Rishi

On Tue, Jul 14, 2020 at 8:26 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> Hi Rishi,
>
> On Tue, 2020-07-14 at 15:54 +0530, rishi gupta wrote:
> > Hi Matthew,Mimi,
> >
> > Few queries in context of 4.14 kernel:
> > - Does it support portable EVM feature.
> > - For EVM traditionally we need to sign files on the device itself.
> > Can we now use portable EVM as a method to sign files during build
> > itself.
>
> Normally new features aren't back ported to stable, but for some
> reason this was back ported to stable linux-4.14.y.
>
> In the future, using "git blame" will identify the patch in which a
> new feature is added.  From there, you can use "git branch -r --
> contains <commit number>" to see in which release it was introduced.
>
> Mimi

Return-Path: <SRS0=Ey5g=SK=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F48DC282DD
	for <linux-integrity@archiver.kernel.org>; Mon,  8 Apr 2019 09:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6926420883
	for <linux-integrity@archiver.kernel.org>; Mon,  8 Apr 2019 09:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NvicEoGj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbfDHJWZ (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 8 Apr 2019 05:22:25 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]:33190 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfDHJWZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 8 Apr 2019 05:22:25 -0400
Received: by mail-lj1-f181.google.com with SMTP id f23so10580831ljc.0
        for <linux-integrity@vger.kernel.org>; Mon, 08 Apr 2019 02:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tIXnMhcIvSLkFlt188AQ2KaVS50/A5k2jCfBo8NUUYs=;
        b=NvicEoGjLikSQHNJ8hExX99pannC+V2OgKHaHBXeYTRiT2FnO2EZmr3zQ1kqFwsNmH
         EJYQcPXf95qV5UY9p2XnaUrdD2AzkfO6HWX4S81KV6QE8AxIrQ5WfZ8p5V6KvznN3oAi
         yF5rp9J6yNQNJgtRKzbc4keMo6sUvo1yJuRgQErI0aNpKUiV+Zd8b9UAUUMu6H41t3nm
         4r3lMYuq8w8gpnTIMGlnuIOTOPlHlkgAxHT6QKfPQF3aN6KglBhlt5+jkAvvmyP4/ZjI
         0dpRWllEWrlShtF1vQoqnJyFh/NUpNr1ZDPyw+j+RWZ48S/YDvTt5sDKjs6f6MfZda+u
         gZcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tIXnMhcIvSLkFlt188AQ2KaVS50/A5k2jCfBo8NUUYs=;
        b=gInyUgYpmNYpp7Qcz9xn3zdC6DCOiwrndune0pWWXfMGR576TyFKiP8rZbXLRF+g3n
         Yo2zdrXNNqwAirJgKM8ZBfBcndY/YC7CNPWqpIPSBp/PXZXrg516qGBkdwCk0CyVeJdl
         y7Badi2zSXiN7jmt5/9uVG4ELlb4wGpDxLXB//wDEmizo55DzQyUjlcpJGvl8XLzuY29
         sQFI6m+xa2FMVO1A+H7jszDZhQ6Np+G3yk/QQtT1O7F+BGefXnmMnsIIWUhzsDcmzd1N
         0d8UFim9FQxTK/8L8NBqSd/KMu3oYrzE5KntcA4CjhGXU0NsT8O+qnoDmuuHUWCyRhe2
         13nQ==
X-Gm-Message-State: APjAAAXrQ9PTbQxfYSdPGrP7LC1N44lM5S9C1YoYunKbEmV9w6vBTVYc
        9yCgjF/OoM2Yu5aSJ7fbRjP+sELLhMqw7jNjWYC+jAcU
X-Google-Smtp-Source: APXvYqxJTJBYwUWjj/oR18GGwowfUIRc0UltfVtfEDIzraW81gHJph04EAyrns/zuFBfHU14X8FO5DWO6DM1AlRw280=
X-Received: by 2002:a2e:4a1a:: with SMTP id x26mr14937474lja.49.1554715342800;
 Mon, 08 Apr 2019 02:22:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAE=Ncrbk9-FLbGYKawdu62iDNKD-HH1QaDC+aDZAWPcf=17R7A@mail.gmail.com>
 <CAE=NcrbR+TzNJ0xqf_ZSPOsm+J+Lbnxi8MMVy_9_2KfdpocgQA@mail.gmail.com>
In-Reply-To: <CAE=NcrbR+TzNJ0xqf_ZSPOsm+J+Lbnxi8MMVy_9_2KfdpocgQA@mail.gmail.com>
From:   Janne Karhunen <janne.karhunen@gmail.com>
Date:   Mon, 8 Apr 2019 12:22:11 +0300
Message-ID: <CAE=NcrYc3qXU2Y2BWJhbh0kTrCZN9AVmSmz6msqTKTNZR+iBPQ@mail.gmail.com>
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

Hmm, looks to me ima_update_xattr seems to be kicking in only from the
appraisal failure when in fix mode or via fput() delayed work item.
So, no sync() or anything like that will ever help and there is
nothing listening on the i_version updates. Moreover, there is no
integrity hook for write() or sync() to put such update in. Uh. I was
under impression it would somehow see the interim file updates, but I
guess no. Fundamental misunderstanding from my point of view how this
thing works, duh.


--
Janne

On Sat, Apr 6, 2019 at 9:16 AM Janne Karhunen <janne.karhunen@gmail.com> wrote:
>
> Hi,
>
> Any thoughts on this? I would guess every system with active databases
> would need to address this somehow?
>
>
> --
> Janne
>
> On Fri, Apr 5, 2019 at 3:46 PM Janne Karhunen <janne.karhunen@gmail.com> wrote:
> >
> > Hi,
> >
> > I've setup an android based mobile device with pretty complete ima/evm
> > setup that covers just about all the standard use cases (imasig based
> > filesystems, ota support, factory reset support etc). All that is fine
> > and ima runs like a clock.
> >
> > Since this is a mobile device, running out of battery or getting shot
> > in the head by something is always a realistic option. The random
> > resets seem to be leading into random appraisal failures as android
> > seems to be keeping surprisingly many files constantly open for
> > writing. So many actually, that I feel somewhat uneasy starting to
> > whitelist these files from the ima policy. That sounds like a viable
> > route only when it comes to the log files as those files primarily
> > move data only one way.
> >
> > Now, is there any prior art on this how to make this work right? The
> > improvements that I can instantly think of are,
> > 1) whitelist everything that can be,
> > 2) reduce the vfs flush delays,
> > 3) make it detect the reset condition and fix the known files when
> > that happened. Unsafe and requires a patch (but that seems easy).
> >
> > Anything else?
> >
> >
> > --
> > Janne

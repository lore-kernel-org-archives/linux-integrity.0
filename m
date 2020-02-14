Return-Path: <SRS0=NkSX=4C=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E1FC2BA83
	for <linux-integrity@archiver.kernel.org>; Fri, 14 Feb 2020 18:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0C45222C2
	for <linux-integrity@archiver.kernel.org>; Fri, 14 Feb 2020 18:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=guzman.io header.i=@guzman.io header.b="SaqXkxZG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729542AbgBNScw (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 14 Feb 2020 13:32:52 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44906 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729448AbgBNScv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 14 Feb 2020 13:32:51 -0500
Received: by mail-lf1-f65.google.com with SMTP id v201so7357309lfa.11
        for <linux-integrity@vger.kernel.org>; Fri, 14 Feb 2020 10:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=guzman.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Xk2bvgkNDRmIe9nwpYDUp5fxYuKKc9+qzgchVvlkEKQ=;
        b=SaqXkxZGmmWUdgkNEHQWD8YQTUkPQw8Jr/8mnVB08wFja3qzgvp2niqt20NNYfZfhF
         6ScaKahRf2tJEggqrKPghj3Ufaew7jr/tSoJvqgn/w4NOn4OIPH9ERiq2zS3cd42EVWH
         3AZyTlOUyr2hOC0BSXya2g6ovJ+AAz+IkHmp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Xk2bvgkNDRmIe9nwpYDUp5fxYuKKc9+qzgchVvlkEKQ=;
        b=V/Q85vYUGZ5/afeOO1tyS7lB9egFM+koOgRfF0ao8v2Vq07fSLsc5vjuUe+OojDs/y
         TL1/Ro3qL6HA+zW1Os2l1QeKbeNPfZyX1xXzVprovadZ+y6vsFs1Oo7dbzqC1NraUaXD
         LSGalNFi3ZVUDAZt4ZfDdBl9oiczCw1bRTffvJXNcVCbZcf0kT8XsNC6AZyKQD6hN4lC
         LVYwUSOTqlHx+omu6H5RcrWYXHymh3xuEm+UhDPYUd5dzo3OTcpTHBFPbLWas9rEbsAd
         IDqCSV4d2Od1evWfa61rjoanb28LvoFKqz04WTrpMvBaZ8omWOstY0oKbExpaS725UKd
         JMxw==
X-Gm-Message-State: APjAAAWLmp+dnzno3IUY1ZkH/ITuQhF7iv8BJak1jvkopRgkk1ay8XDM
        m3xyhFVaPJpz2aEsE6zwhv/0z/EVREBI/bYMMybAdl9pHB2hVhwB
X-Google-Smtp-Source: APXvYqzgxiJI57GaM/7bOWPdH0oRrj8i2f0dW3C3qD1eji9LTaqKOZ/ZnS7IqF1in4yXCqQqmdV0zc6zx51sThlOZbE=
X-Received: by 2002:ac2:5e29:: with SMTP id o9mr2327740lfg.81.1581705169039;
 Fri, 14 Feb 2020 10:32:49 -0800 (PST)
MIME-Version: 1.0
References: <CAJ7-PMaLw_H8Fc1tyoT95f5EWpS3nvJt1Wx9=xpuiSotJ2h9VA@mail.gmail.com>
In-Reply-To: <CAJ7-PMaLw_H8Fc1tyoT95f5EWpS3nvJt1Wx9=xpuiSotJ2h9VA@mail.gmail.com>
From:   Alex Guzman <alex@guzman.io>
Date:   Fri, 14 Feb 2020 10:32:37 -0800
Message-ID: <CAJ7-PMbJ5fiQAj-5QAzAcFW0eMNkxpQSs=r_wUEfED33XZAPDg@mail.gmail.com>
Subject: Re: Debugging errors with Dell XPS 9560 TPM
To:     linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Looks like someone had a look on the bug tracker
(https://bugzilla.kernel.org/show_bug.cgi?id=206275#c6)
and they figure it's definitely a regression in the kernel and should
be reverted or rectified. They advised me to come ping here once more.


- Alex

On Sat, Feb 1, 2020 at 4:19 PM Alex Guzman <alex@guzman.io> wrote:
>
> Hey there! I reported a bug on the bug tracker a bit ago but haven't
> seen any movement, so I figured I'd drop in here. My XPS 9560 has been
> having issues with its TPM, and all commands will fail with error 1
> when operating on the TPM device. I managed to bisect it back to
> commit 4d6ebc4c4950595414722dfadd0b361f5a05d37e (tpm: fix invalid
> locking in NONBLOCKING mode) though it began failing with error 14
> (bad address) at that point.
>
> I reported the bug at
> https://bugzilla.kernel.org/show_bug.cgi?id=206275 and attached some
> dmesg logs from boot there. Does anyone have any suggestions for
> additional debugging or such to figure out what's happening here?
>
> - Alex

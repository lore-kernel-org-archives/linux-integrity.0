Return-Path: <SRS0=R33m=PV=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8064EC43387
	for <linux-integrity@archiver.kernel.org>; Sun, 13 Jan 2019 10:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E60120657
	for <linux-integrity@archiver.kernel.org>; Sun, 13 Jan 2019 10:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fkJkM4KR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbfAMK6O (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sun, 13 Jan 2019 05:58:14 -0500
Received: from mail-it1-f176.google.com ([209.85.166.176]:38426 "EHLO
        mail-it1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfAMK6N (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 13 Jan 2019 05:58:13 -0500
Received: by mail-it1-f176.google.com with SMTP id h65so8680724ith.3
        for <linux-integrity@vger.kernel.org>; Sun, 13 Jan 2019 02:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uVzVLWD/7TVlxq8KFuTB5Ybm2N21/pSGWVm8GC0LObE=;
        b=fkJkM4KRRpyL0h0Zb/X20zhYImXnrGeRr04VbTVvxdun2EoXnHoDxbqYhn++RNIuAb
         EOAT5qJONXBxczy+2sNVONjf+L2kwEx9pkv3rs+UNy03fPr42QQtjbNrme4RMBCYcGJ/
         qhyr3WllvZC+VBtYF4Zk/c4R7YazI3NFlXlmGuX9m0YNQdIPFbYP9G3rnIq9sb/+tsux
         J4xLAWfYNUJnianMvK+5Hsslw2bX+BAM4y4BfHMeKgWq+M4QIDSOehwIUzk97751eIGX
         gN2q1UOSdlz42Lz6Qg4tam1TcV8xrSBUdPYEpLTE7EWReHnTIpShJyiTytMR4sPc5IgJ
         Kuvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uVzVLWD/7TVlxq8KFuTB5Ybm2N21/pSGWVm8GC0LObE=;
        b=I29YRLwfxfBNsHSPqTPF5bPixkMhoEdIb5U0gU+gSnufPKZmom98S4s3GqhsXEqCRZ
         zmZd6PdN1uMLxT2jl6M4t9wCMzMcpSUlxK4NWdRLxhD9qkD85S5ifcgWQDpk+Zp+k0lp
         mf0sRIYnCkLdyJFIyQtLZEq4SehCM3NgUwyCu6aBiMnxTfEKLt2lyEva20T6bZF2V4oG
         aI+kN0WkJYHyYTLCZWULcoIWyP0arKooDlouj8/pZcgFhsoGS+MvBBfUp33wnz3ts77z
         nASroZ3WijmG4YljPKGitp/eNIbua5tK2dIIFjg3L4STTz9BH8fn7sSsRRrpH4Vaqeek
         VHkQ==
X-Gm-Message-State: AJcUukc4Hon7svGMSGN5+Q1RpgcQiz8q2wh0ds4MwdlSMN8Lbt4nFF7e
        Y3QOVuue42/wELyBH/E1vTRXJLCqV+M4rlLHzRo=
X-Google-Smtp-Source: ALg8bN5+fti6QuEgXW+oJvRJpGSudnJOZC+z5cWczT4I9wN5jAGdVAp70pl0b9CBONavzZQiucdfM4OKdiAHa0PMTOg=
X-Received: by 2002:a24:9e87:: with SMTP id p129mr5270133itd.148.1547377092630;
 Sun, 13 Jan 2019 02:58:12 -0800 (PST)
MIME-Version: 1.0
References: <CALUj-gsiY+_K_PM2kAXvVFU+wntq6tQaqUk+BVzwA3o-7nhCPw@mail.gmail.com>
 <1546981121.19931.130.camel@linux.ibm.com> <CALUj-gvmo8pTGeHB=L+sZaP9a1QPTE2AXNc=vzzfZ+4GtVac3A@mail.gmail.com>
 <CACdnJusByW8ybecgaMRHooi_vhJkuUzmf3MeEsQmNP38TiZkdA@mail.gmail.com>
In-Reply-To: <CACdnJusByW8ybecgaMRHooi_vhJkuUzmf3MeEsQmNP38TiZkdA@mail.gmail.com>
From:   rishi gupta <gupt21@gmail.com>
Date:   Sun, 13 Jan 2019 16:28:01 +0530
Message-ID: <CALUj-gvn5MDLcY-pwh=PBSZwSK41Jv6C6Ay5qx5bRTj5btfNMw@mail.gmail.com>
Subject: Re: OTA does not work with IMA due to xattr not supported by zip
To:     Matthew Garrett <mjg59@google.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Thanks Mimi, I am asking if integrity team is working with zip
community like the RPM. I will have a look at zip code to see if it is
in my capacity to add xattr support or not. A possible solution looks
like replacing zip with tar in OTA solution.

Thanks Matthew, I am at lower version of kernel therefore portable evm
may not be taken in as of now. I will backport it possibly.


On Thu, Jan 10, 2019 at 11:50 PM Matthew Garrett <mjg59@google.com> wrote:
>
> On Wed, Jan 9, 2019 at 10:47 PM rishi gupta <gupt21@gmail.com> wrote:
> >
> > Thanks Mimi. Any plan for zip archive format support.
> > Also when using EVM, the files has to be signed on target. So after
> > new files has been flashed on device during OTA, does private key also
> > needs to be present on system.
>
> This is what the portable EVM format is for - it allows EVM signatures
> to be generated remotely and shipped as part of a package.

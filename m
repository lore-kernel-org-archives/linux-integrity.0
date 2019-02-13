Return-Path: <SRS0=kHfr=QU=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4946BC282C2
	for <linux-integrity@archiver.kernel.org>; Wed, 13 Feb 2019 09:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1767B222C2
	for <linux-integrity@archiver.kernel.org>; Wed, 13 Feb 2019 09:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rZw58Qs2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391245AbfBMJOM (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:14:12 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:40049 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728468AbfBMJOM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 Feb 2019 04:14:12 -0500
Received: by mail-yb1-f194.google.com with SMTP id x13so631990ybm.7;
        Wed, 13 Feb 2019 01:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yvfajkxqYaDydmgEX+PGqtxS47hTCL2W7qVsE0dabew=;
        b=rZw58Qs2Jm8SuNjLY+eglApj/AcpEh4j07f2m1zNPUJU4Nli28fJuNqMY/74UTu+FZ
         aBmknF6VKkHVe045IAx9Q+kRRq3AEAd5rmkEkXnAVaDjM7qlRIzbHTOBUbCl8gY2cS08
         M3X6QIXqiRT1ALRf8tPFM0mEtaIS6u6L5C/GyHby62lSQ09JWdxY6E9ysuKexhUrhjyj
         C6XikonF5qeMZHqWtZuLH+aJ12Seh2h1RHVnGo6z5uxSex9UGRGE4TGGNHriu4YElrdx
         TT9HgLVunL12o2c1KVYtR1oeTM++39AX3jjXdkcSAVzhIOUaXFIjAOmOjdQ+VsD/pWf4
         pETw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yvfajkxqYaDydmgEX+PGqtxS47hTCL2W7qVsE0dabew=;
        b=hEdP8LYufsGHr4WjUaUW3DmuOpUbOIiGGHcrp8egHczt1wkCml97MHvUMoKh5Cm0yx
         YlNQUiED8WQ/1eVKyCdYbybtypTpkbdC/eZ3H8cosJkhwD5IhzzHrWEJwaxrG77xWmze
         HJPIjtaZv9LsRcncmMp7sQX1SGqt34zHW8+IbrmFNYrxw93m8zVVdojrpcpXXlPoSxE7
         M++py51v4HQhvbcYaQ6rrOZuCXGov/dolbgSJ5DPponQDmyWon2GQ9zGE+39AP+WoqwP
         ss9Ukfa+xbkH7NKoRb0BFd4Xj5rP0cFdW2cKuN0PH8qTUMeg5YrwT4/xO2BIHps/kcYf
         NN7w==
X-Gm-Message-State: AHQUAuZw4rVAsGyh5BPmQXd59VJJ0o0OtJoU3z1bhhqhQtNUZvQeqOAi
        VHurJX5o8qJTQcI3s2fdv2xisbMsxbe/S5+aqXk=
X-Google-Smtp-Source: AHgI3Ib6z0Cth2hsGB05avU5Yp9UQECtdfIGRdn12BRDiGb3+nV7gLCZ7CexUizohX2ZD4FLzHZ00ZB/AydyH+s7cHk=
X-Received: by 2002:a25:c087:: with SMTP id c129mr6756355ybf.320.1550049251299;
 Wed, 13 Feb 2019 01:14:11 -0800 (PST)
MIME-Version: 1.0
References: <20190211165323.9369-1-iforster@suse.com> <CAOQ4uxgSZv7t5HznAhsWrzv3e3VwQ7sbZrjgjfRsviq-wsr7EA@mail.gmail.com>
 <1550011897.12743.310.camel@linux.ibm.com> <4472439.nvz8ndpTJa@linux-e202.suse.de>
In-Reply-To: <4472439.nvz8ndpTJa@linux-e202.suse.de>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 13 Feb 2019 11:13:59 +0200
Message-ID: <CAOQ4uxhXjYQ4xfF0itXTRtDEqGqqkgxFBVeeDG2qPyfTXz+kCw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] Fix overlayfs on EVM
To:     Fabian Vogt <fvogt@suse.de>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Ignaz Forster <iforster@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Feb 13, 2019 at 10:05 AM Fabian Vogt <fvogt@suse.de> wrote:
>
> Hi,
>
> Am Dienstag, 12. Februar 2019, 23:51:37 CET schrieb Mimi Zohar:
> >
> > > > > If my assumptions so far are correct, then the effort for making
> > > > > IMA/EVM work with overlayfs should focus around finding the
> > > > > places where overlayfs uses lower level vfs interface (often
> > > > > vfs_xxx helpers) and make sure that the IMA hooks are place
> > > > > in those lower vfs interfaces, just like vfs_create() patch does
> > > > > and like vfs_tmpfile() patch did before it.
> > > >
> > > > So basically turning on NOIMA for overlayfs while ensuring that integrity
> > > > checks and operations still perform as expected?
> > >
> > > Yes.
> > > As far as IMA is concerned, Overlayfs is like a filesystem user from kernel.
> > > Very similar to knfsd in that respect.
> >
> > Fabian, if you're thinking of disabling IMA-appraisal on overlay filesystems,
> > have you tried defining an appraise policy rule based on the overlayfs
> > magic number (eg. dont_appraise fsmagic=0x794c7630)?
>
> Yes, that was one of the first approaches we tested - basically switching from
> a) to b) using configuration. It didn't work: Then IMA was completely
> circumvented and neither were hashes updated for changed files nor were they
> checked on access. That was a few months ago though, so it might have changed.
>

Not very surprising considering the missing IMA hooks in level of
vfs_create() and vfs_tmpfile().

Here is a partial list of vfs interfaces used by overlayfs for you to audit:

For copy up:
dentry_open()
do_clone_file_range()
do_splice_direct()
notify_change()

For file open (since kernel v4.19):
open_with_fake_path()

All around:
git grep "vfs_" fs/overlayfs/

Thanks,
Amir.

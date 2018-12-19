Return-Path: <SRS0=H3qb=O4=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D57C43387
	for <linux-integrity@archiver.kernel.org>; Wed, 19 Dec 2018 16:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A033C217D9
	for <linux-integrity@archiver.kernel.org>; Wed, 19 Dec 2018 16:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6//1uxN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbeLSQis (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 19 Dec 2018 11:38:48 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:33531 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727602AbeLSQir (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 Dec 2018 11:38:47 -0500
Received: by mail-yw1-f68.google.com with SMTP id v20so6998847ywc.0;
        Wed, 19 Dec 2018 08:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tHBSE2A/Lbjq3pIeTIfgoVLcvS3gKlDt+MrRNbiJidY=;
        b=T6//1uxN2fDaKYHLmDup0KC9L3eMImzGdsblCVlk4gKTdifbYLdkuzloJHzGw4WFhy
         xPtgLixijO3+HDkAwTdLorINygDZ9X8Bez7YdrEfD33sgemkc6Dn7Wmxn3p/NYQATQVY
         YU56Kve5qqPW8LbBJ7vu5UJ8pTR/CbTVdWUN8G6rjBZnVtrKypbDru7ASUzMTELBXOkv
         3n+pAkJKSNFndFrvac5toh4joOoBQs5KS6/MJ5ztrq8YxBdW6bop3hWgSjpPafWXNEBl
         4WWKYSWVwQYU3ymZhb8tohp6iGfBKENTUI/R5/29KCHK9eC+vcQvpKoiUdzjeWRIvPt/
         iscQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tHBSE2A/Lbjq3pIeTIfgoVLcvS3gKlDt+MrRNbiJidY=;
        b=dkg9fe9fH1AtVa8GSSTsAH36Ulzq69BtwR4yETXquRLL4ZeBLtEoZkmavbski6Y8Dx
         co2mZQUJvX6HC8H7+xlJ5nTqlnNlv/6voJILgA8fr/FmlauqrzKr8jONHO7NO++cFaVe
         q7Q6eu3527yi79eb2g9QyM180PIPASqtVgsvTJAQMxNLT8UI+Q8tax1xPWcJIKzm/4qy
         DxHO+0uqKXN2NgsRmqfVEmogD2QHneekgTfUhW6TfhqPNwINd1ezaz6Op3UG8TNJMlhh
         sA++uNRQfjIqgkfOHJc4juHXM04brBPrJb7Ow7OUFZFp9RTHOhTzWA9aw62CDuO1dg8C
         S8Iw==
X-Gm-Message-State: AA+aEWbe1by6GQ2z18E2J2UaW74Z+7/7FSqMMypurS+6IHgpXHTSQqjz
        vQ2DzdRFs641y1VAIJ9dTcfSjwhZ9yuFpBvdteY=
X-Google-Smtp-Source: AFSGD/UBZqtYyUsp1PVzUvRsb3qc9sl7ssV/f3+Y0RXrTINutVrAmlnocaRcGmZVDf+9AuzhawgAitdRvZ+x298hNPU=
X-Received: by 2002:a81:2916:: with SMTP id p22mr22631607ywp.176.1545237526609;
 Wed, 19 Dec 2018 08:38:46 -0800 (PST)
MIME-Version: 1.0
References: <12c81a49-efca-d66c-2143-ae04ca248cce@suse.de> <1545174031.4178.8.camel@linux.ibm.com>
 <1545233975.3954.8.camel@linux.ibm.com>
In-Reply-To: <1545233975.3954.8.camel@linux.ibm.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 19 Dec 2018 18:38:35 +0200
Message-ID: <CAOQ4uxgoMntXsxnsxtBOOPLDo3HgcYPWayuCuDzxEx2GJSMZtg@mail.gmail.com>
Subject: Re: EVM: Permission denied with overlayfs
To:     zohar@linux.ibm.com
Cc:     iforster@suse.de, Goldwyn Rodrigues <rgoldwyn@suse.com>,
        linux-integrity@vger.kernel.org,
        Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Dec 19, 2018 at 5:39 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> On Tue, 2018-12-18 at 18:00 -0500, Mimi Zohar wrote:
> > Hi Ignaz,
> >
> > On Tue, 2018-12-18 at 20:49 +0100, Ignaz Forster wrote:
> > > Hi,
> > >
> > > as a follow up to my attempts to use overlayfs on an IMA protected
> > > system[1] I've now tried to also enable EVM. From what I understand this
> > > should - at least in theory - be possible: EVM will call
> > > d_backing_inode(dentry), which I thought would get the inode of the
> > > underlying file system[2], and use that for HMAC verification.
> > >
> > > In practice simply trying to access an existing file will fail with
> > > "Permission denied" already. In the corresponding audit log I can see
> > > the file access (failed with "invalid-HMAC"), but with an inode number
> > > unknown to me - stat returns a completely different number for the file
> > > in the lower and target dir.
> > >
> > > For testing purposes I added a new hashing algorithm to
> > > evm_ima_xattr_type which will not add the file system specific
> > > attributes (inode number, generation, file system uuid) to the hash -
> > > just like EVM_XATTR_PORTABLE_DIGSIG, but with the hashes generated by
> > > the kernel. Files created with this signature can be read correctly,
> > > though writing the files will still fail.
> > >
> > > Unfortunately I'm out of ideas what is happening here. If anybody wants
> > > to have a look at this: Any help would be appreciated.
> > >
> > > Kind Regards,
> > > Ignaz
> > >
> > > [1] https://www.spinics.net/lists/linux-integrity/msg03593.html
> > > [2] https://www.kernel.org/doc/htmldocs/filesystems/API-d-backing-inode.html
> > >
> >
> > After creating a file on the overlay, I wasn't able to access it from
> > the overlay, but was able to access it from "upper".  Both "stat" and
> > "getfattr -m ^security" returned exactly the same things for both
> > pathnames.  However, the ino in the audit log was different.
> >
> > After modifying evm_calc_hmac_or_hash(), replacing d_backing_inode()
> > with d_real_inode(), the hmac properly calculated for both the overlay
> > and the upper pathnames.
> >
> > Something must have changed in d_backing_inode().
>
> Confirmed, in linux-4.18.y d_backing_inode returns the real i_ino, but
> newer kernels do not.  This is a problem for EVM as the i_ino is
> included in the HMAC calculation.
>

Hi Mimi,

v4.19 has a big change that removes many VFS hacks in favor of
overlayfs stacked file operations.

The major implication for VFS code is that file_inode(file) is now the overlayfs
inode and not the real inode. Therefore, file_dentry(file) is also the overlayfs
dentry and not the real dentry.

I am not sure how that change impacts EVM ?
FWIW, d_backing_inode(dentry) was never anything more than d_inode(dentry).

Can you please try to describe in more details for someone who has no clue what
EVM does how exactly the v4.19 change is manifested in the EVM use case.

AFAIKT, evm_calc_hmac_or_hash() would get the overlayfs dentry both in
v4.18 and v4.19 and therefore d_backing_inode(dentry) should be the
overlayfs inode in both kernels (?).

The value of overlayfs inode i_ino can be identical to i_ino of the real inode
under some conditions, but far from always and the value of overlayfs inode
i_generation is almost guaranteed to not match that of the real inode.

Ignaz, can you add some more debug prints to shed some light on what
exactly has changed, between the two kernels?
If the calculated hashes do not match in two different execution paths,
please provide two sample stack traces that see different i_ino, so we can
examine them.

Thanks,
Amir.

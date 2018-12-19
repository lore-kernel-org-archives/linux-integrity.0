Return-Path: <SRS0=H3qb=O4=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AAB7C43387
	for <linux-integrity@archiver.kernel.org>; Wed, 19 Dec 2018 20:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47AEE20873
	for <linux-integrity@archiver.kernel.org>; Wed, 19 Dec 2018 20:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CuKZg9EZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729306AbeLSUkF (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 19 Dec 2018 15:40:05 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:45911 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbeLSUkE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 Dec 2018 15:40:04 -0500
Received: by mail-yw1-f68.google.com with SMTP id d190so8672782ywd.12;
        Wed, 19 Dec 2018 12:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q1FEzzDwsvzXgn3L1zIqytmzfm08ipAyPr0qppSjsXI=;
        b=CuKZg9EZWl/2cPfkW9C/0FyequhJVGB7lc00DmQmdtwvf7TUAEjlqKqPlSdNn2+74i
         CEjOfEOd6cyLwJytd4BxLba4r0s8EqNI6AMVwR+KUS3UeyNCbhlJf7rH5lw5i0rqXvOi
         z5xN/CNJHcO4htnmSpl3Rf8/msMUHqI7JEMSDfaVoPVpAgACjuBne9JxBekXx5wCaviS
         B14+tsXiWfllxkruf1hjCy14QLMcwQ19qdebDGxPXORCmvHJV0R7V9qH/26dGD2xZ12T
         rE0pQSQhtmOZc30ozFd940o9D7E0c4hW8gQb8fF3oRePHu3m+Q+YNiXzgvTSLFfBLkoI
         Ijkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q1FEzzDwsvzXgn3L1zIqytmzfm08ipAyPr0qppSjsXI=;
        b=IIp2jHZtfyt614BNyY5/u9ckFcvv3kskOdQ+Yx5Olnlgcj+ZSTPSkYXtYuRKWZhS0x
         YFZexgJR5AJ0cKDSx3Ej8/Q/XFkRyH+c384CLxeBo7CAEgWWXeHMNwB/tCz9zgvFeN5O
         kKd95tjYoDc5Zmw2UR/1reypKWu2oGKMjqu7rssdo3x8IWHl1TE13WJKtttsbhLu1G92
         cme8RGDfTmFoXcFIQIJ9riIg0iYjdLisnNY/gt3Q4NMyyDq1AJ7ScIWmXRHgylqA+ITh
         uQfBF/UvKATOvCtJrykT2sayM0wlmnad9KAUIvSvbYDA1gSy46va5fhdtNRWgPiPIPko
         56dg==
X-Gm-Message-State: AA+aEWYjP7o1vRuQmmR4dPPfeACh7xZFcCqEzUr7QwCLYxiFSSTlKr2A
        pqkZPb4XbThDHd9Vb+M4A3fGAk0bPxXrj1sPeybYUTS2
X-Google-Smtp-Source: AFSGD/W4nGF7THiQy902gbqOxwNzBJBZwKpth40U5ODl1+Qi59LsK1XY0YL1X+vsXj+n3HbdAFqi3elVZWIlPD/sF/o=
X-Received: by 2002:a81:2916:: with SMTP id p22mr23514564ywp.176.1545252002548;
 Wed, 19 Dec 2018 12:40:02 -0800 (PST)
MIME-Version: 1.0
References: <12c81a49-efca-d66c-2143-ae04ca248cce@suse.de> <1545174031.4178.8.camel@linux.ibm.com>
 <1545233975.3954.8.camel@linux.ibm.com> <CAOQ4uxgoMntXsxnsxtBOOPLDo3HgcYPWayuCuDzxEx2GJSMZtg@mail.gmail.com>
 <1545244479.3954.38.camel@linux.ibm.com>
In-Reply-To: <1545244479.3954.38.camel@linux.ibm.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 19 Dec 2018 22:39:50 +0200
Message-ID: <CAOQ4uxiGoOsON9E6b53DAtPo=JJHx6FT0NiksGdxkeU886JB3A@mail.gmail.com>
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

> > Hi Mimi,
> >
> > v4.19 has a big change that removes many VFS hacks in favor of
> > overlayfs stacked file operations.
> >
> > The major implication for VFS code is that file_inode(file) is now the overlayfs
> > inode and not the real inode. Therefore, file_dentry(file) is also the overlayfs
> > dentry and not the real dentry.
> >
> > I am not sure how that change impacts EVM ?
> > FWIW, d_backing_inode(dentry) was never anything more than d_inode(dentry).
> >
> > Can you please try to describe in more details for someone who has no clue what
> > EVM does how exactly the v4.19 change is manifested in the EVM use case.
>
> IMA calculates and stores a file hash/signature on the file data
> (security.ima).  EVM calculates and stores an HMAC/signature on the
> file metadata (security.evm).  Some data needs to be included in the
> HMAC/signature that binds the file metadata with the file data.  That
> data is the inode's ino, generation, uid, gid, mode and the uuid.
>
> >
> > AFAIKT, evm_calc_hmac_or_hash() would get the overlayfs dentry both in
> > v4.18 and v4.19 and therefore d_backing_inode(dentry) should be the
> > overlayfs inode in both kernels (?).
> >
> > The value of overlayfs inode i_ino can be identical to i_ino of the real inode
> > under some conditions, but far from always and the value of overlayfs inode
> > i_generation is almost guaranteed to not match that of the real inode.
> >
> > Ignaz, can you add some more debug prints to shed some light on what
> > exactly has changed, between the two kernels?
> > If the calculated hashes do not match in two different execution paths,
> > please provide two sample stack traces that see different i_ino, so we can
> > examine them.
>
> Assuming you've created and overlay mounted the lower, upper, work,
> and merged directories, accessing files only in the merged directory
> fails.
>

Mimi,

I think I understand the problem I just don't see how that use case could have
ever worked with overlayfs.
The following patch may make your test pass,
but #1: I am not sure it is safe to do that without ovl_index_all() -
need to think about implications
but #2: For some overlayfs setups that won't be enough to
guaranty consistent i_ino
but #3: Not sure about the role of i_generation

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 30ef69715a81..8d8cd6acd71e 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -560,8 +560,7 @@ static void ovl_fill_inode(struct inode *inode,
umode_t mode, dev_t rdev,
         * ovl_new_inode(), ino arg is 0, so i_ino will be updated to real
         * upper inode i_ino on ovl_inode_init() or ovl_inode_update().
         */
-       if (inode->i_sb->s_export_op &&
-           (ovl_same_sb(inode->i_sb) || xinobits)) {
+       if ((ovl_same_sb(inode->i_sb) || xinobits)) {
                inode->i_ino = ino;
                if (xinobits && fsid && !(ino >> (64 - xinobits)))
                        inode->i_ino |= (unsigned long)fsid << (64 - xinobits);

Thanks,
Amir.

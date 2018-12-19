Return-Path: <SRS0=H3qb=O4=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC9BDC43387
	for <linux-integrity@archiver.kernel.org>; Wed, 19 Dec 2018 20:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0EA820811
	for <linux-integrity@archiver.kernel.org>; Wed, 19 Dec 2018 20:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pn4b44By"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729727AbeLSUMY (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 19 Dec 2018 15:12:24 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:37996 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728638AbeLSUMW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 Dec 2018 15:12:22 -0500
Received: by mail-yb1-f193.google.com with SMTP id d187so8393211ybb.5;
        Wed, 19 Dec 2018 12:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iz5sQVAG6FgqCZwz30HDgFzJuLyfeyOcqIgu3kroAM8=;
        b=pn4b44BywA0bD1+eAB+x0xWONbZzfoVOk2TJCt5I0F6bqOHe1dakWhnC46OF/g2IOg
         HhTO0ABTgN2LNdaMiI+ku//GLPUU5Hv2T6kw4AYkfSIavmHM2aD/NGpSB1wDpTtgvPAa
         2hO8pISyoMe08Z8DCWf8bTlchNInFKef+eMjUMiHpAt4bqZSBjiLtIB97fPU+ZI/svSm
         b6370tsEwWIACv1AbZcN0ARWwH/H3wBtitu0g7RfUn/yNTDXNMPeqtOwvt1zW9ahYMU2
         J5n8DwmaZigSPoROT4tr5sWPdt54EE1Cz1aDIFYkE8lGrJue2rIiCW1XUKiFWRqh0gAf
         c5nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iz5sQVAG6FgqCZwz30HDgFzJuLyfeyOcqIgu3kroAM8=;
        b=G2A0hlKPO8yd9ajOv5Qz8NS4HbUVNeDb+NzJeDPCoiUPT2vtZNuomnY8UhVsR5bXFo
         12CxSBPgbHVKpOh6RSbMm0G7XJTxfcWPvh3+3ZlQ1R39qtSqPOU2AG5ABSZPAn8f2fTL
         LdnY9B067MONaZO6L1ZKFuqDy53V3C9GT6u6xn6niu+ZT/nvMqmKKuAjptZ+eIz13EF8
         EBspBdnkPIT6VORpb5BrrXuV7w8iQLebOCU/iopRT+1jERn69kHOMDKB8JPhu2O+8YT0
         o0RI4SpO/VgXm/eu7NTwWiXYfpo9ZesI7/faZGKfCuYcH8pmU1cn24ysHe5cajohTrsi
         bV/g==
X-Gm-Message-State: AA+aEWb0IFLkZ3om+OmFsCwKBIwsHkUccg4sPo30r6Olju08KcMbTOv8
        nn9NkqSmRMUJJhCvXSsWPrYJwsRSvf8AZQZRnzGW5Q==
X-Google-Smtp-Source: AFSGD/WS8/q2Ug3ZfkIjRrCxCh4V69GUin9fuFQNKmiSNzZd/Uh8HUxspzf3hXJT9YqQL50sWlZuF/Ele7GVJ7iurpY=
X-Received: by 2002:a5b:310:: with SMTP id j16-v6mr22771262ybp.320.1545250339648;
 Wed, 19 Dec 2018 12:12:19 -0800 (PST)
MIME-Version: 1.0
References: <12c81a49-efca-d66c-2143-ae04ca248cce@suse.de> <1545174031.4178.8.camel@linux.ibm.com>
 <1545233975.3954.8.camel@linux.ibm.com> <1545238601.2916.13.camel@HansenPartnership.com>
 <1545243311.3954.22.camel@linux.ibm.com> <1545248096.2916.26.camel@HansenPartnership.com>
In-Reply-To: <1545248096.2916.26.camel@HansenPartnership.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 19 Dec 2018 22:12:08 +0200
Message-ID: <CAOQ4uxhDh3okp1nYgZXxG+2siChfT8Oq3ncH1FFhQW_zBCstzw@mail.gmail.com>
Subject: Re: EVM: Permission denied with overlayfs
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     zohar@linux.ibm.com, iforster@suse.de,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        linux-integrity@vger.kernel.org,
        Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Dec 19, 2018 at 9:34 PM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Wed, 2018-12-19 at 13:15 -0500, Mimi Zohar wrote:
> > On Wed, 2018-12-19 at 08:56 -0800, James Bottomley wrote:
> > > On Wed, 2018-12-19 at 10:39 -0500, Mimi Zohar wrote:
> > > > Confirmed, in linux-4.18.y d_backing_inode returns the real
> > > > i_ino, but newer kernels do not.
> > >
> > > Just so we're clear, this isn't an issue with d_backing_inode(),
> > > which hasn't changed since its introduction in 2015 and which
> > > always returns dentry->d_inode (it was originally a helper for
> > > unionfs which got merged even though unionfs didn't, which makes it
> > > and the comment about upper/lower totally misleading).  The problem
> > > is that overlayfs has changed the inode it places into d_inode.
> > >
> > > >   This is a problem for EVM as the i_ino is included in the HMAC
> > > > calculation.
> > >
> > > Isn't the solution always to use portable signatures for
> > > containers?
> > > It's problematic to include inode and generation with an overlay
> > > because if you change the metadata it gets copied up => new inode
> > > number and generation on the upper filesystem but if we were always
> > > using the underlying inode number and generation, the signature
> > > would then be wrong on the copied up file.
> > >
> > > At base, most container images are sets of tar files, which are not
> > > inode number preserving anyway, so even if we find a convoluted way
> > > to fix the above, the EVM signature has to be portable because
> > > otherwise its always wrong for container images.
> >
> > Ignaz's use case was mutable files, not immutable files with file
> > signatures.
>
> The word "mutable" is problematic in terms of overlays.  Only the upper
> layer is mutable, so if your EVM signed file is anywhere other than in
> the top layer it's technically immutable.  What you get when you mutate
> it is a copy up.  the VFS guarantee is that inode numbers are stable
> only for the current mount and may change on a remount.  Most disk
> backed filesystems have inode numbers encoded in their on disk inodes,
> which is why they have far more stability than the simple VFS
> requirement, but some filesystems can't have long term stable inode
> numbers.  We recognise this problem in EVM with so called "portable
> signatures" that don't include the inode number and generation.
>
> I'm interested in discussing two points
>
>    1. Can we actually come up with semantics where the EVM signature is
>       always valid for overlays?

What you are looking for is a persistent and stable identifier for
the inode object. Such a property already exists for filesystems that
support NFS file handles.

As I wrote, you can *sometimes* rely on overlay i_ino to be consistent
and stable (it will usually have the value of the pre copy up lower inode
even after copy up), bug i_generation is nonsense.

You can *always* rely on overlay file handle to be a unique indetifier
of the inode (even after mount cycle) as long as nfs_export=on and
overlayfs supports NFS file handles (as well as the underlying layers).


>    2. If the answer to 1. is "no" should we not always use portable
>       signatures for overlay cases?

You can determine if overlayfs has exportfs ops and choose portable
non-portable signatures per instance.

>
> I think there are a load of nasty corner cases in 1. that make 2. far
> more preferable, but perhaps we can begin with the use case that
> requires non-portable signatures with overlays, because I don't think
> I've heard it yet.
>
> >   Prior to 4.19, EVM was calculating and verifying the file
> > HMAC properly.  With 4.19, it stopped working because the i_ino used
> > in calculating the HMAC value stored in security.evm, is not the same
> >  when verifying the HMAC value.
>
> Yes, but the same thing would happen on cifs or NFS or any other
> filesystem that constructs inode numbers on the fly.  If we're not
> proposing trying to fix them, why fix overlayfs?
>

NFS file handles as inode identifier would work for those as well.

Thanks,
Amir.

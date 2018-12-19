Return-Path: <SRS0=H3qb=O4=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 999C2C43387
	for <linux-integrity@archiver.kernel.org>; Wed, 19 Dec 2018 19:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F86921841
	for <linux-integrity@archiver.kernel.org>; Wed, 19 Dec 2018 19:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="YMLSl7S6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbeLSTe6 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 19 Dec 2018 14:34:58 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:53712 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727979AbeLSTe6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 Dec 2018 14:34:58 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 726D68EE1CB;
        Wed, 19 Dec 2018 11:34:57 -0800 (PST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lD6GGmG1DJuH; Wed, 19 Dec 2018 11:34:57 -0800 (PST)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id E84CA8EE0D5;
        Wed, 19 Dec 2018 11:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1545248097;
        bh=6RiFcd0+SqqNLgnmeo6zBuvMId/aZFHrj5GX5HZNT1c=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=YMLSl7S6MdWXwRS+2gdgmhUjo6R1Jz28OQohG9fWNujw8CtYCc2fMKNt/AEV6jQXo
         7/s+EItPb91DxO9vy9lhwnfuNPXRNIyhxQ189E7QfQPvKrHInvVAuD0fAElYiJkknr
         4GulxBBhYHCJrL0RvJuQM3BlVQLdG08kqZ5UW54E=
Message-ID: <1545248096.2916.26.camel@HansenPartnership.com>
Subject: Re: EVM: Permission denied with overlayfs
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, Ignaz Forster <iforster@suse.de>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>,
        linux-integrity@vger.kernel.org,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-unionfs@vger.kernel.org
Date:   Wed, 19 Dec 2018 11:34:56 -0800
In-Reply-To: <1545243311.3954.22.camel@linux.ibm.com>
References: <12c81a49-efca-d66c-2143-ae04ca248cce@suse.de>
         <1545174031.4178.8.camel@linux.ibm.com>
         <1545233975.3954.8.camel@linux.ibm.com>
         <1545238601.2916.13.camel@HansenPartnership.com>
         <1545243311.3954.22.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2018-12-19 at 13:15 -0500, Mimi Zohar wrote:
> On Wed, 2018-12-19 at 08:56 -0800, James Bottomley wrote:
> > On Wed, 2018-12-19 at 10:39 -0500, Mimi Zohar wrote:
> > > Confirmed, in linux-4.18.y d_backing_inode returns the real
> > > i_ino, but newer kernels do not.
> > 
> > Just so we're clear, this isn't an issue with d_backing_inode(),
> > which hasn't changed since its introduction in 2015 and which
> > always returns dentry->d_inode (it was originally a helper for
> > unionfs which got merged even though unionfs didn't, which makes it
> > and the comment about upper/lower totally misleading).  The problem
> > is that overlayfs has changed the inode it places into d_inode.
> > 
> > >   This is a problem for EVM as the i_ino is included in the HMAC
> > > calculation.
> > 
> > Isn't the solution always to use portable signatures for
> > containers? 
> > It's problematic to include inode and generation with an overlay
> > because if you change the metadata it gets copied up => new inode
> > number and generation on the upper filesystem but if we were always
> > using the underlying inode number and generation, the signature
> > would then be wrong on the copied up file.
> > 
> > At base, most container images are sets of tar files, which are not
> > inode number preserving anyway, so even if we find a convoluted way
> > to fix the above, the EVM signature has to be portable because
> > otherwise its always wrong for container images.
> 
> Ignaz's use case was mutable files, not immutable files with file
> signatures.

The word "mutable" is problematic in terms of overlays.  Only the upper
layer is mutable, so if your EVM signed file is anywhere other than in
the top layer it's technically immutable.  What you get when you mutate
it is a copy up.  the VFS guarantee is that inode numbers are stable
only for the current mount and may change on a remount.  Most disk
backed filesystems have inode numbers encoded in their on disk inodes,
which is why they have far more stability than the simple VFS
requirement, but some filesystems can't have long term stable inode
numbers.  We recognise this problem in EVM with so called "portable
signatures" that don't include the inode number and generation.

I'm interested in discussing two points

   1. Can we actually come up with semantics where the EVM signature is
      always valid for overlays?
   2. If the answer to 1. is "no" should we not always use portable
      signatures for overlay cases?

I think there are a load of nasty corner cases in 1. that make 2. far
more preferable, but perhaps we can begin with the use case that
requires non-portable signatures with overlays, because I don't think
I've heard it yet.

>   Prior to 4.19, EVM was calculating and verifying the file
> HMAC properly.  With 4.19, it stopped working because the i_ino used
> in calculating the HMAC value stored in security.evm, is not the same
>  when verifying the HMAC value.

Yes, but the same thing would happen on cifs or NFS or any other
filesystem that constructs inode numbers on the fly.  If we're not
proposing trying to fix them, why fix overlayfs?

James


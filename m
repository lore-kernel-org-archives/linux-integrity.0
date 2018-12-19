Return-Path: <SRS0=H3qb=O4=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC60C43387
	for <linux-integrity@archiver.kernel.org>; Wed, 19 Dec 2018 16:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85E0A214C6
	for <linux-integrity@archiver.kernel.org>; Wed, 19 Dec 2018 16:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="rYEccX51"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbeLSQ4o (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 19 Dec 2018 11:56:44 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:52522 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727544AbeLSQ4n (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 Dec 2018 11:56:43 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 2F5098EE1CB;
        Wed, 19 Dec 2018 08:56:43 -0800 (PST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mii2kRwKqCvu; Wed, 19 Dec 2018 08:56:42 -0800 (PST)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 7725E8EE0D5;
        Wed, 19 Dec 2018 08:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1545238602;
        bh=cTWdJ5AHjJrjLzD52Nk9LSxKkPQhNq0wNrkrWZo8LbY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=rYEccX51DcZ4S/zZpw8Q5OhoUyDWn7EVPdOaMgYSrfKy9O/3W+N4ZcHkrblGp/kVe
         vnesExmYiFhQD5T1fI9n89kF/rCn36QZKtx+E/d/aeXoGnZZ0SbJHmrlkdhVP3qwND
         QmskVh9l9welLg67VlbgQY699PUM/uAJjcwL3JAc=
Message-ID: <1545238601.2916.13.camel@HansenPartnership.com>
Subject: Re: EVM: Permission denied with overlayfs
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, Ignaz Forster <iforster@suse.de>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>,
        linux-integrity@vger.kernel.org,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-unionfs@vger.kernel.org
Date:   Wed, 19 Dec 2018 08:56:41 -0800
In-Reply-To: <1545233975.3954.8.camel@linux.ibm.com>
References: <12c81a49-efca-d66c-2143-ae04ca248cce@suse.de>
         <1545174031.4178.8.camel@linux.ibm.com>
         <1545233975.3954.8.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2018-12-19 at 10:39 -0500, Mimi Zohar wrote:
> Confirmed, in linux-4.18.y d_backing_inode returns the real i_ino,
> but newer kernels do not.

Just so we're clear, this isn't an issue with d_backing_inode(), which
hasn't changed since its introduction in 2015 and which always returns
dentry->d_inode (it was originally a helper for unionfs which got
merged even though unionfs didn't, which makes it and the comment about
upper/lower totally misleading).  The problem is that overlayfs has
changed the inode it places into d_inode.

>   This is a problem for EVM as the i_ino is included in the HMAC
> calculation.

Isn't the solution always to use portable signatures for containers? 
It's problematic to include inode and generation with an overlay
because if you change the metadata it gets copied up => new inode
number and generation on the upper filesystem but if we were always
using the underlying inode number and generation, the signature would
then be wrong on the copied up file.

At base, most container images are sets of tar files, which are not
inode number preserving anyway, so even if we find a convoluted way to
fix the above, the EVM signature has to be portable because otherwise
its always wrong for container images.

James


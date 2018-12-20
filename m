Return-Path: <SRS0=gF99=O5=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50071C43387
	for <linux-integrity@archiver.kernel.org>; Thu, 20 Dec 2018 19:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 265A021902
	for <linux-integrity@archiver.kernel.org>; Thu, 20 Dec 2018 19:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="JiGLS2+w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730311AbeLTTYz (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 20 Dec 2018 14:24:55 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:38022 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730237AbeLTTYz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 20 Dec 2018 14:24:55 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id BFF5B8EE1CB;
        Thu, 20 Dec 2018 11:24:54 -0800 (PST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Yt0eJH1Ss1Tz; Thu, 20 Dec 2018 11:24:54 -0800 (PST)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 34D998EE121;
        Thu, 20 Dec 2018 11:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1545333894;
        bh=fJTUXbzU87pWUaJV1bBdtUb/JY8MKkOAxQB4BiYpEio=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=JiGLS2+wCMvgLMbT5rW1b/Da9fiL3i22VuBbDYnosN7ljNS/A3lMgiPgJyrvXQ8ww
         ur9FS3cTP7WW5Ukw5JxYXijjvgPtP8GbR6rX6+C3BR3meTYzZnAVO6PSP4N5yZPK1l
         n6w0wXRtkPv3CWHnuOeZFl4iHbRQesx1X2f9h+vs=
Message-ID: <1545333893.18986.3.camel@HansenPartnership.com>
Subject: Re: EVM: Permission denied with overlayfs
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     iforster@suse.de, Goldwyn Rodrigues <rgoldwyn@suse.com>,
        linux-integrity@vger.kernel.org,
        Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>
Date:   Thu, 20 Dec 2018 11:24:53 -0800
In-Reply-To: <1545317716.4077.33.camel@linux.ibm.com>
References: <12c81a49-efca-d66c-2143-ae04ca248cce@suse.de>
         <1545174031.4178.8.camel@linux.ibm.com>
         <1545233975.3954.8.camel@linux.ibm.com>
         <1545238601.2916.13.camel@HansenPartnership.com>
         <1545243311.3954.22.camel@linux.ibm.com>
         <1545248096.2916.26.camel@HansenPartnership.com>
         <CAOQ4uxhDh3okp1nYgZXxG+2siChfT8Oq3ncH1FFhQW_zBCstzw@mail.gmail.com>
         <1545253341.3954.83.camel@linux.ibm.com>
         <1545257296.2916.42.camel@HansenPartnership.com>
         <1545317716.4077.33.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2018-12-20 at 09:55 -0500, Mimi Zohar wrote:
> On Wed, 2018-12-19 at 14:08 -0800, James Bottomley wrote:
> 
> > > For portable signatures, to bind the file metadata with the file 
> > > data, we've replaced the inode number and generation, with the
> > > "security.ima" xattr.  Do we want this requirement/limitation for
> > > overlays?
> > 
> > Well, that's my question, yes.  I think there's a reasonable case
> > for it, but I was wondering what value the inode number and
> > generation brings.  Is there some reason to bind the EVM signature
> > to a more mutable file container (which is what inum/generation
> > provide) rather than a hard hash of file content (which is what the
> > ima xattr provides)?
> 
> As only files in the IMA policy are labeled with security.ima, to
> protect other files and directories, requires including the inode
> number, generation and the UUID.

OK, so you want to protect the container (essentially file name and
place in the tree) not the contents?  In which case, as Amir said, you
need to be using the filehandle got from something like
exportfs_encode_inode_fh().  That's guaranteed to be an immutable and
stable representative of the container not the contents.

> > > The existing EVM portable signature is an asymmetric algorithm
> > > based signature.  Would we define a "portable" HMAC?
> > 
> > Well, a signature is just an encryption of a hash.  Whether you do
> > HMAC with symmetric key or RSA/EC with an asymmetric one is more an
> > operational question.  HMAC is certainly much faster but EVM only
> > has a single hmac key which is problematic for the
> > containers.  Without a use case I can't really say.  Instinct tells
> > me asymmetric is more suitable to the container use case, but
> > that's really just a guess.
> 
> One of the differences between the EVM portable signature type and
> the original signature type is that the portable signatures aren't
> replaced with an HMAC.  They're considered portable & immutable.
> 
> Adding kernel support for signing mutable files using an asymmetric
> key is going to blur the lines between mutable/immutable files.

So don't do that ... have an additional type that simply doesn't
include the inode/generation (or move to a v2 that uses the filehandle
instead).

James


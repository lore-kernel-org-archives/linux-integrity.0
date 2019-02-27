Return-Path: <SRS0=nfu5=RC=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B6EC43381
	for <linux-integrity@archiver.kernel.org>; Wed, 27 Feb 2019 22:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 694442133D
	for <linux-integrity@archiver.kernel.org>; Wed, 27 Feb 2019 22:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="j4UXhpx0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729412AbfB0WXC (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 27 Feb 2019 17:23:02 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:51320 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728397AbfB0WXC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 Feb 2019 17:23:02 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 868728EE47D;
        Wed, 27 Feb 2019 14:23:01 -0800 (PST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Ud9i-lbO1oQx; Wed, 27 Feb 2019 14:22:57 -0800 (PST)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 2BA908EE0EF;
        Wed, 27 Feb 2019 14:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1551306171;
        bh=Xr01/AeBuk32WZ1CROy54r2uwhQufq7zIIVxYza52Hw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=j4UXhpx0QegqcW1t8KDGxu+imY/7CrM0uhHk14ofUIFNHzPuE9D3IYlndrBnei852
         bJ6auMvUDxD/id84YveUJJEO+FYBgLTHExxbrWUNkg2YnlkaJScz1fxokkaCGODp7z
         BvEkuJuAuzoLKClYA/bzu/lSHKZlU2XtFQAYEKEg=
Message-ID: <1551306168.3105.22.camel@HansenPartnership.com>
Subject: Re: [DISCUSSION] IMA Signature Measurements
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jordan Hand <Jordan.Hand@microsoft.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Cc:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>
Date:   Wed, 27 Feb 2019 14:22:48 -0800
In-Reply-To: <MWHPR21MB075192F589A7AA4E8B89F8B9F0740@MWHPR21MB0751.namprd21.prod.outlook.com>
References: <MWHPR21MB075192F589A7AA4E8B89F8B9F0740@MWHPR21MB0751.namprd21.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-02-27 at 22:02 +0000, Jordan Hand wrote:
> Hello,
> 
> I have been looking into how IMA policies work for
> measuring/appraising in specific scenarios such as kexec. IMA has
> specific policies for these scenarios (i.e. setting func to
> KEXEC_KERNEL_CHECK). While these policies do exist, in practice it
> seems that IMA treats these files the same way it treats any other
> file; it will validate and measure (in the case of ima-sig) based on
> the IMA signature in the file's inode.

Not in the inode, in the security.ima extended attribute.

> It seems that this policy is mostly a placeholder in case there is a
> desire later to do some different behavior based on the file type
> (correct me if I'm wrong and there's another reason for having the
> KEXEC_KERNEL_CHECK function).
> 
> I wanted to get feedback on the possibility of IMA measuring a
> different signature type during kexec. In general kernal images are
> signed as PE files, with the signature embedded in the file image.
> Normal kexec (not the IMA path) validates this type of signature. I
> would like to use IMA to both appraise and measure based on this
> signature instead of the IMA signature (this could have a Kconfig
> flag). Alternatively it could look for both. I think this makes sense
> because it means folks can make use of IMA's measurement capabilities
> while still signing the kernel image in the same way they have always
> signed it for kexec. This also makes the signing/packaging/installing
> story simpler for kernels wishing to make use of IMA as they don't
> have to ship with IMA/EVM signatures.

Um, this is already upstream.  The slight problem is that kernel
bzImages are arch specific, so the file you're looking for is 

  arch/x86/kernel/kexec-bzimage64.c

You'll find the signature verifier for x86 bzImages is the PE one.  The
current problem is more that the kernel keyring doesn't trust the
secure boot keys, so the issue isn't with the signature format its with
keyring trust.

IMA is also doing some further work for attached instead of xattr
detached signatures, but, being PECOFF based, authenticode is pretty
useless there since all our executables are ELF.

James


> I know that currently IMA only handles IMA/EVM signatures (makes
> sense) so this would deviate a decent amount from how IMA currentl
> works. I want to get general thoughts on this proposal before I start
> work on this to ensure this is something the community/maintainers
> are supportive of.
> 
> Thanks,
> Jordan
> 
> (sorry for the clutter Mimi, I forgot to make the first one plaintext
> so it didn't post)
> 


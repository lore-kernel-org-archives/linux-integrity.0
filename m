Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B426C433E0
	for <linux-integrity@archiver.kernel.org>; Mon,  1 Feb 2021 11:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C031064DDB
	for <linux-integrity@archiver.kernel.org>; Mon,  1 Feb 2021 11:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbhBALbC (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 1 Feb 2021 06:31:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:48330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229753AbhBALay (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 1 Feb 2021 06:30:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A07A264D90;
        Mon,  1 Feb 2021 11:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612179013;
        bh=QQz4O2D5S55JH+J3HkSd4DfftLbA8u+Bn7/UfRzp8wE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gvAfdnzgD+vtmhm21xrYJNu7rRgdRW2+a+IcbwrXcqUj9utrHCu0jFNIxkHMZrec7
         d6I9Auy1V5vGVdKmS9Lbkei1tmbEiK60iRBQcbt5LjBpUJuLwogQeNzoO7KE63sgx3
         CzE5IA7cKQwaIASkDtohipUnYGNlqE4QyscO28OChe/wW6FHYI+nXccZ766U7n9imK
         dioFM3Hr1BDon91LDxE8WaiVhKloz2uBse/a4fMOsqz8fAwBBqh8i1wC2Lnk3nnB2X
         +swMa0Ctfex/cj6f6J71CHH+6vGLkNe5j55RqPoKog9H5rUjl7o6L+aGVRpT39h9j5
         IQkDO/jXnYjdQ==
Date:   Mon, 1 Feb 2021 13:30:07 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        James Morris James Morris <jmorris@namei.org>,
        David Howells <dhowells@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [GIT PULL] tpmdd updates for v5.12-rc1
Message-ID: <YBfmP2qKmsFg4Tfj@kernel.org>
References: <YBNcv8jLEDE8C/IW@kernel.org>
 <CAHk-=wjk7zEOFEjGWZmGF8_dcitBQ_dPUMSkr-g7B7cYcXGvSQ@mail.gmail.com>
 <YBWUHkbNt6OLoeUq@kernel.org>
 <e9e8a184f482d7f826659427764a7612ab775c3e.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9e8a184f482d7f826659427764a7612ab775c3e.camel@HansenPartnership.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, Jan 30, 2021 at 09:33:47AM -0800, James Bottomley wrote:
> On Sat, 2021-01-30 at 19:15 +0200, Jarkko Sakkinen wrote:
> > On Thu, Jan 28, 2021 at 07:38:21PM -0800, Linus Torvalds wrote:
> > > On Thu, Jan 28, 2021 at 4:54 PM Jarkko Sakkinen <jarkko@kernel.org>
> > > wrote:
> > > > This contains bug fixes for tpm_tis driver, which had a racy wait
> > > > for hardware state change to be ready to send a command to the
> > > > TPM chip. The bug has existed already since 2006, but has only
> > > > made itself known in recent past.
> > > 
> > > Hmm. Is this for the next merge window? The subject line implies
> > > that, as does the addition of the cr50 driver.
> > > 
> > > But the commentary about fixes implies that at least part of it
> > > should be in 5.11?
> > 
> > This was meant for 5.12 but the timing was *way* too early. I'll take
> > this one back. Just to unambiguity reasons I'll use tpmdd-next-v5.12-
> > rc1-v2 tag for my final v5.12 PR, once I send it.
> > 
> > I considered a bit, and I really think that it would make a lot of
> > sense to do a late 5.11 just containing the two commits from James,
> > namely:
> > 
> > 1. tpm_tis: Fix check_locality for correct locality acquisition
> > 2. tpm_tis: Clean up locality release 
> > 
> > James: Does this make sense to you? 
> 
> Yes, that's fine with me.  It will quiet the warning we've had several
> bug reports about, so it's definitely a bug fix.

Thanks, this is exactly what I wanted to sanity check. I figured that
those should be enough, but unfortunately I do not have any hardware
triggering the issue in my possession.

> James

/Jarkko

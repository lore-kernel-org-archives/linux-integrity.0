Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE6EC433E0
	for <linux-integrity@archiver.kernel.org>; Sat, 30 Jan 2021 17:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF5FE64DE4
	for <linux-integrity@archiver.kernel.org>; Sat, 30 Jan 2021 17:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbhA3Reb (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sat, 30 Jan 2021 12:34:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbhA3Rea (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 30 Jan 2021 12:34:30 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5529C061573;
        Sat, 30 Jan 2021 09:33:50 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 9003B128062A;
        Sat, 30 Jan 2021 09:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1612028028;
        bh=tO9HQA1I6yDQ9viwFdXCB4Zw6gBnp4U5u/NUWVw4QLo=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=PXhZ03TTGfFbbGpFmP7uKO7mGsrB9F10HiHIIKDlmBacXsgXQiydAvP4kFmB2GruC
         kyoqhe/zHgX3unmh0slh+IYxuYGRVFnWMBIVQSrNY/ViQd8mQ13KtqksESQ1rH2PFe
         wsLpLQ4DYot/VPUISpGRq4nfkt2v1VE5ZL4s2j7s=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Ix_Cf7kpZTMS; Sat, 30 Jan 2021 09:33:48 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:600:8280:66d1::c447])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 09FC31280602;
        Sat, 30 Jan 2021 09:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1612028028;
        bh=tO9HQA1I6yDQ9viwFdXCB4Zw6gBnp4U5u/NUWVw4QLo=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=PXhZ03TTGfFbbGpFmP7uKO7mGsrB9F10HiHIIKDlmBacXsgXQiydAvP4kFmB2GruC
         kyoqhe/zHgX3unmh0slh+IYxuYGRVFnWMBIVQSrNY/ViQd8mQ13KtqksESQ1rH2PFe
         wsLpLQ4DYot/VPUISpGRq4nfkt2v1VE5ZL4s2j7s=
Message-ID: <e9e8a184f482d7f826659427764a7612ab775c3e.camel@HansenPartnership.com>
Subject: Re: [GIT PULL] tpmdd updates for v5.12-rc1
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        James Morris James Morris <jmorris@namei.org>,
        David Howells <dhowells@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>
Date:   Sat, 30 Jan 2021 09:33:47 -0800
In-Reply-To: <YBWUHkbNt6OLoeUq@kernel.org>
References: <YBNcv8jLEDE8C/IW@kernel.org>
         <CAHk-=wjk7zEOFEjGWZmGF8_dcitBQ_dPUMSkr-g7B7cYcXGvSQ@mail.gmail.com>
         <YBWUHkbNt6OLoeUq@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, 2021-01-30 at 19:15 +0200, Jarkko Sakkinen wrote:
> On Thu, Jan 28, 2021 at 07:38:21PM -0800, Linus Torvalds wrote:
> > On Thu, Jan 28, 2021 at 4:54 PM Jarkko Sakkinen <jarkko@kernel.org>
> > wrote:
> > > This contains bug fixes for tpm_tis driver, which had a racy wait
> > > for hardware state change to be ready to send a command to the
> > > TPM chip. The bug has existed already since 2006, but has only
> > > made itself known in recent past.
> > 
> > Hmm. Is this for the next merge window? The subject line implies
> > that, as does the addition of the cr50 driver.
> > 
> > But the commentary about fixes implies that at least part of it
> > should be in 5.11?
> 
> This was meant for 5.12 but the timing was *way* too early. I'll take
> this one back. Just to unambiguity reasons I'll use tpmdd-next-v5.12-
> rc1-v2 tag for my final v5.12 PR, once I send it.
> 
> I considered a bit, and I really think that it would make a lot of
> sense to do a late 5.11 just containing the two commits from James,
> namely:
> 
> 1. tpm_tis: Fix check_locality for correct locality acquisition
> 2. tpm_tis: Clean up locality release 
> 
> James: Does this make sense to you? 

Yes, that's fine with me.  It will quiet the warning we've had several
bug reports about, so it's definitely a bug fix.

James



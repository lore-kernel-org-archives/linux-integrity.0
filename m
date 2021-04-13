Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCBEDC43461
	for <linux-integrity@archiver.kernel.org>; Tue, 13 Apr 2021 12:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B28D161278
	for <linux-integrity@archiver.kernel.org>; Tue, 13 Apr 2021 12:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244737AbhDMMvD (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 13 Apr 2021 08:51:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:49012 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346199AbhDMMuV (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Apr 2021 08:50:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3500FAF26;
        Tue, 13 Apr 2021 12:50:00 +0000 (UTC)
Date:   Tue, 13 Apr 2021 14:49:56 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: Re: [PATCH ima-evm-utils] travis: Fix openSUSE Tumbleweed
Message-ID: <YHWTdNEmLpYKxu9g@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20210312114152.20475-1-pvorel@suse.cz>
 <b65400f3c4c54f74724247d111c46fbfea3183d4.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b65400f3c4c54f74724247d111c46fbfea3183d4.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

> Hi Petr,

> On Fri, 2021-03-12 at 12:41 +0100, Petr Vorel wrote:
> > openSUSE Tumbleweed build fails due broken permission detection due
> > faccessat2() incompatibility in libseccomp/runc used in old docker with
> > old kernel on Ubuntu Focal on hosts in Travis CI together with guests
> > with the newest glibc 2.33.

> > Fixing Tumbleweed required switch to podman and downloading newest runc
> > release (v1.0.0-rc93) which contains the fix [1], because proposed glibc
> > fix [2] aren't going to merged to upstream [3] nor to Tumbleweed
> > downstream glibc [4].

> > Using podman requires --no-same-owner tar option to workaround
> > running out of subuids/subgids:
> > tar: ./LICENSE: Cannot change ownership to uid 339315, gid 578953: Invalid argument
> > (sudo would also work)

> > Sooner or later it will be required for more distros (Fedora, Debian
> > Ubuntu), but don't waste build time until required.

> > [1] https://github.com/opencontainers/runc/pull/2750
> > [2] https://sourceware.org/pipermail/libc-alpha/2020-November/119955.html
> > [3] https://sourceware.org/pipermail/libc-alpha/2020-November/119978.html
> > [4] https://bugzilla.opensuse.org/1182451

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>

> The mismatch seems to be when compiling with clang, at least on our
> internal travis.  Compiling opensuse/tumbleweed with gcc works
> fine.  Compiling opensuse/leap with clang is fine too.  Does that make
> sense?
Thanks for info. I have no idea now, I'll have a look.

Kind regards,
Petr

> Mimi




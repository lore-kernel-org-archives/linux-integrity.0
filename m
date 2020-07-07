Return-Path: <SRS0=Ev+g=AS=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5567DC433DF
	for <linux-integrity@archiver.kernel.org>; Tue,  7 Jul 2020 21:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ECC120720
	for <linux-integrity@archiver.kernel.org>; Tue,  7 Jul 2020 21:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594157106;
	bh=ezYuCml9YFOZcm7NYpRCW0QkHrIIUL1+qEasWM0Mnqo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=s3KB31YTpJN5SSL2VeFbrOASziJihizJmX7o7o8OG84Vc8PKIZvOie6fLBaiG7YMG
	 NJrzjyLctGXR/MBg7M4Tj7mTHJo3H73HY/SKT8ILG0lTff50AWlOpOHYOuBt1qy2Ew
	 VHyqoc2Z/uAaxW+IGzeIovCvt/8MMfO1MFi4AmCM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbgGGVZC (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 7 Jul 2020 17:25:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:34184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729085AbgGGVZC (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Jul 2020 17:25:02 -0400
Subject: Re: [GIT PULL] tpmdd updates for Linux v5.8-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594157101;
        bh=ezYuCml9YFOZcm7NYpRCW0QkHrIIUL1+qEasWM0Mnqo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=cm8qajq+j3kYITSvedlMz0dL9zrBaajXGrypXzuLPkM9oy7gItqefNc782KjU1xBq
         3drHM9FnNhn4NHQtjLscVjw9V4P85HqpRcXlbDmFHEbhWJnDF0PuVxO1ipFnK0IzJK
         qq+FUr4vo417IXHJgVQbwibOTpcJ/HrH58ynbHnM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200707022114.GA112019@linux.intel.com>
References: <20200707022114.GA112019@linux.intel.com>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200707022114.GA112019@linux.intel.com>
X-PR-Tracked-Remote: git://git.infradead.org/users/jjs/linux-tpmdd.git
 tags/tpmdd-next-v5.8-rc5
X-PR-Tracked-Commit-Id: 786a2aa281f4c4ba424ea8b8ea1e85ab62c4a57c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a6bc851ffe0b246ab4f8aa0d01620fbc08d0441f
Message-Id: <159415710170.29940.15254200557486878529.pr-tracker-bot@kernel.org>
Date:   Tue, 07 Jul 2020 21:25:01 +0000
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, jmorris@namei.org,
        dhowells@redhat.com, peterhuewe@gmx.de
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The pull request you sent on Tue, 7 Jul 2020 05:21:14 +0300:

> git://git.infradead.org/users/jjs/linux-tpmdd.git tags/tpmdd-next-v5.8-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a6bc851ffe0b246ab4f8aa0d01620fbc08d0441f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

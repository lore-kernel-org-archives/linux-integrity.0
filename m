Return-Path: <SRS0=oZFa=EM=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BA8C2D0A3
	for <linux-integrity@archiver.kernel.org>; Fri,  6 Nov 2020 21:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4018C20B80
	for <linux-integrity@archiver.kernel.org>; Fri,  6 Nov 2020 21:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604697227;
	bh=g/0tITjlKhXWV7bBiuGKrhqxg8yXFOQ6MjnngtQmOsk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=KN5iwgfzNZWbY/Kt6tenlVLZd2lshEyC93DUZZRQYoG/8MwqESj8O4ZP5T6UPpPJD
	 gJIZyVMT+F5+TMu1AIUS1MG9v7hUbfMHDjoNkVH88aV+/zREBpr4Q27jKmd6u3xKXO
	 rNJRQ3bERjiUxl2onL7BQZ/xjwkGVmVHX122PBqk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbgKFVNb (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 6 Nov 2020 16:13:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:47334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728131AbgKFVN0 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 6 Nov 2020 16:13:26 -0500
Subject: Re: [GIT PULL] tpmdd updates for v5.10-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604697205;
        bh=g/0tITjlKhXWV7bBiuGKrhqxg8yXFOQ6MjnngtQmOsk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=jI2HRILGOxTurdH1o1swy/Z7LVdfU/2GOsIay0SNH36S2xwHuY8HmIo66z39DRmKN
         zJ0CIXNVSyfEBlY1EIT/EaEjKWQoDg2t9etomlsYkHuVrILCcRPsl8QA1D8PJHW5DO
         h+y3Y5RJ9z+03VgHykKR7U8j6IqjU/ao/UEhwl6E=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201106162552.GA50264@kernel.org>
References: <20201106162552.GA50264@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201106162552.GA50264@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-next-v5.10-rc4
X-PR-Tracked-Commit-Id: 8ffd778aff45be760292225049e0141255d4ad6e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 28ced768a4262bc81c61c8244e0e57048afc18d1
Message-Id: <160469720546.14190.13296096196953432263.pr-tracker-bot@kernel.org>
Date:   Fri, 06 Nov 2020 21:13:25 +0000
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, jmorris@namei.org,
        dhowells@redhat.com, peterhuewe@gmx.de
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The pull request you sent on Fri, 6 Nov 2020 18:25:52 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-next-v5.10-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/28ced768a4262bc81c61c8244e0e57048afc18d1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

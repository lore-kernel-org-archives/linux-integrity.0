Return-Path: <SRS0=inTu=4G=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5A2C34031
	for <linux-integrity@archiver.kernel.org>; Tue, 18 Feb 2020 23:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92F3A2173E
	for <linux-integrity@archiver.kernel.org>; Tue, 18 Feb 2020 23:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582067103;
	bh=QmUnoPymKKoqwRvV6Lcu38T+58tkGng7qoSaChK5uZc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=1PF4DgFmk9Wd0FVEnXSPSiv7iOmkekeyeUBv0Epm8vPL6g/dbOfcNCIs3SM8u1ifZ
	 dUKICHfplvsXxKJj4rVVpvRZ/5cITgttpWscJ8UckmV1oBYAriEUG+Lmg67cz0OU6b
	 VbJLWNrTAVroQP6K9R6+494vq8+A7QHFC3RjazsU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgBRXFD (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 18 Feb 2020 18:05:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:37378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726820AbgBRXFD (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Feb 2020 18:05:03 -0500
Subject: Re: [GIT PULL] tpmdd updates for Linux v5.6-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582067102;
        bh=QmUnoPymKKoqwRvV6Lcu38T+58tkGng7qoSaChK5uZc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=gSfrACUoqCeem7Ci0f4iknZV7VAVTLXsekPGxRSJY31rIAOEMV1L+mMuXEib1Q6/p
         rXnoQPMnjUPshomQhlgNM8aleSkLPs2QqCmkF+LkdD609MoJb6iQHuIEz1kt4R9mTq
         hf2JlVME99qVe0zRYC0BuEzBpWiyuWJqJoIw8xyo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200217185044.GA7180@linux.intel.com>
References: <20200217185044.GA7180@linux.intel.com>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200217185044.GA7180@linux.intel.com>
X-PR-Tracked-Remote: git://git.infradead.org/users/jjs/linux-tpmdd.git
 tags/tpmdd-next-20200217
X-PR-Tracked-Commit-Id: dc10e4181c05a2315ddc375e963b7c763b5ee0df
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2b72104b8c12504176fb5fc1442d6e54e31e338b
Message-Id: <158206710266.5982.13455580152886456927.pr-tracker-bot@kernel.org>
Date:   Tue, 18 Feb 2020 23:05:02 +0000
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, jmorris@namei.org
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The pull request you sent on Mon, 17 Feb 2020 20:50:44 +0200:

> git://git.infradead.org/users/jjs/linux-tpmdd.git tags/tpmdd-next-20200217

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2b72104b8c12504176fb5fc1442d6e54e31e338b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

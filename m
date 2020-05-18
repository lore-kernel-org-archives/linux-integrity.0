Return-Path: <SRS0=+IDv=7A=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0476C433E0
	for <linux-integrity@archiver.kernel.org>; Mon, 18 May 2020 18:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72ED0207F5
	for <linux-integrity@archiver.kernel.org>; Mon, 18 May 2020 18:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589828103;
	bh=4btdnUDZKtSjiUjC2dUR+3nLvzFmMXPnFFKB4s9bMeU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=0S9sB90NkJYQn1HXxo3iNXnz2CGZrrsIS6U8SjpyWf0mVp70vTlwZcFra+XduS/iL
	 zGMvaoEDXRPdlejBseK+DTVQG7bRXMT7ZI3pSrJoSxTgE+3BAXdl3eeJroqov15BPM
	 3MmMpdNULK1VLJ6lueHDVlpnnhkHS1VamjpYc1eo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729287AbgERSzD (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 18 May 2020 14:55:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:58954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728830AbgERSzD (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 18 May 2020 14:55:03 -0400
Subject: Re: [GIT PULL] integrity subsystem fixes for v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589828102;
        bh=4btdnUDZKtSjiUjC2dUR+3nLvzFmMXPnFFKB4s9bMeU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=GQhKT3q01gs40Ze7Y7CtGwZPXPHdWHgi/+inPxrawBHduQuZ547diGa0Y7v6XJ++l
         BsYAtdBGW4JTzgLS5jIavZeh3cY79jbpdo2lAN5Bn4R223anmRSWTigqc9faQrSRQG
         PpOOLGzWGHFoMsSnko4dA9YAGW3vxZ/9oQ6IUKZE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1589816971.5111.113.camel@linux.ibm.com>
References: <1589816971.5111.113.camel@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <1589816971.5111.113.camel@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
 next-integrity.fixes
X-PR-Tracked-Commit-Id: 8433856947217ebb5697a8ff9c4c9cad4639a2cf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 642b151f45dd54809ea00ecd3976a56c1ec9b53d
Message-Id: <158982810253.23134.7314950463770880232.pr-tracker-bot@kernel.org>
Date:   Mon, 18 May 2020 18:55:02 +0000
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The pull request you sent on Mon, 18 May 2020 11:49:31 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/642b151f45dd54809ea00ecd3976a56c1ec9b53d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

Return-Path: <SRS0=4u2G=5S=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DDBC43331
	for <linux-integrity@archiver.kernel.org>; Thu,  2 Apr 2020 22:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D8C520784
	for <linux-integrity@archiver.kernel.org>; Thu,  2 Apr 2020 22:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585867504;
	bh=c9ETl+9+WA3T/vW2Fwgn72DysCMVBso1ewme4KBGaIg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=z9xvAYSgj39n2q2CnSXIlJGZAtfTGwjyARrmFIh9y0RT/bNAFPz6nJ0m6ekXn8J9U
	 PILPr4XZn8yojKziFqbMnrMscyPiuhqg1bp91V0Gp8jrMoWi9gdDPH8vnRpR5WgS0V
	 608My7ZLErBy7N4IOIbvhHkeDyx1PRK9tCPprcg0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390311AbgDBWpE (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 2 Apr 2020 18:45:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:37174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390316AbgDBWpD (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Apr 2020 18:45:03 -0400
Subject: Re: [GIT PULL] integrity subsystem updates for v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585867503;
        bh=c9ETl+9+WA3T/vW2Fwgn72DysCMVBso1ewme4KBGaIg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=rhheg33LUVg31zIEQdmJEuufZrQ87JAiMIm6wSIE1dRZ7RsiaJMHm0FYlONwSd2tS
         46J0saAD6t4wbeyaVXQYbhBSacqthMNV4wTs4y9kwpj+A8Uxx1yDdvZQfV5x/ckELW
         z3qV//G/jYKhEaR3aArhpHcigxqqH6GnDvMpohjo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1585778597.5188.665.camel@linux.ibm.com>
References: <1585778597.5188.665.camel@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <1585778597.5188.665.camel@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
 next-integrity
X-PR-Tracked-Commit-Id: 9e2b4be377f0d715d9d910507890f9620cc22a9d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7f218319caaaf6f2a43b22d8c82b898f32b4ec70
Message-Id: <158586750335.2810.1251219729592050514.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Apr 2020 22:45:03 +0000
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The pull request you sent on Wed, 01 Apr 2020 18:03:17 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7f218319caaaf6f2a43b22d8c82b898f32b4ec70

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

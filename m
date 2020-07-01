Return-Path: <SRS0=jfc/=AM=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B317C433E0
	for <linux-integrity@archiver.kernel.org>; Wed,  1 Jul 2020 19:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6657120853
	for <linux-integrity@archiver.kernel.org>; Wed,  1 Jul 2020 19:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593630603;
	bh=KSzNcvkSZ2fcrLzdKJeEuHsZ7IwBwv1LiSYsa4NZWFg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=n8/IDr44okdEDokE82PjvzHHxqqAqlKO7zaT2LWNA2SJE40ymoEqpG2WAZ9630/1H
	 w8OXieWTmLuZSMcUzZMq0cfbr86/Xp2wIBXLqxmn8yzlMKrtykpfmXZG4HXYyU0SO4
	 SyPSxM3qon+ckz/nyxM/xEG/Iraf9xuV2hFGo52U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726021AbgGATKD (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 1 Jul 2020 15:10:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:34642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725915AbgGATKC (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 1 Jul 2020 15:10:02 -0400
Subject: Re: [GIT PULL] integrity additional change v5.8 (#2)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593630602;
        bh=KSzNcvkSZ2fcrLzdKJeEuHsZ7IwBwv1LiSYsa4NZWFg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=oWFj7PQhAniSqkKYKtn1npTAZDIqGYcTHfalrE7x9yBKIsEfzWh8zI3moy/IJxQDi
         tW+Roch2kEB9nLzyCsJW+jlL5YvDf5V+pUw5JXNhLL8ZBV3+XatO7kdH9vzWyRUn/D
         Cgm0Kp5LQdanN4/9M0m3l2hNs+7OrYhmn0bQu4Sw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1593444433.5085.15.camel@linux.ibm.com>
References: <1593444433.5085.15.camel@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <1593444433.5085.15.camel@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
 tags/integrity-v5.8-fix-2
X-PR-Tracked-Commit-Id: 20c59ce010f84300f6c655d32db2610d3433f85c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b13f40bc69a16e465d21e23ca5adf4bf26365815
Message-Id: <159363060238.32760.8714686643697642393.pr-tracker-bot@kernel.org>
Date:   Wed, 01 Jul 2020 19:10:02 +0000
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Maurizio Drocco <maurizio.drocco@ibm.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The pull request you sent on Mon, 29 Jun 2020 11:27:13 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v5.8-fix-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b13f40bc69a16e465d21e23ca5adf4bf26365815

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

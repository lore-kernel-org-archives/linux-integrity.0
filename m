Return-Path: <SRS0=ghDQ=BN=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B7BC433DF
	for <linux-integrity@archiver.kernel.org>; Mon,  3 Aug 2020 17:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82AB522B45
	for <linux-integrity@archiver.kernel.org>; Mon,  3 Aug 2020 17:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596477324;
	bh=s6c5QfQxq1QUlzYHr4+jYy8dE8fKWC6Ch8rzwqnZxh4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Vo87ga3qC77+GtA/U4tc7ntewLcEIg2RHMRyIulGcj8gvpEUgmbHEp9gXthNaL1b4
	 CLd7AltOW6wfereCid9ZPibJmK0hvBl/WV6ZCGcMeQBC2oEtqDFfKAEfjJjeh+bkrv
	 9vDQMcYNk8OzqujSrU7LpfGDxrbjsGwXCKVcP24Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbgHCRzF (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 3 Aug 2020 13:55:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:52100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728596AbgHCRzF (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 Aug 2020 13:55:05 -0400
Subject: Re: [GIT PULL] tpmdd update for Linux v5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596477304;
        bh=s6c5QfQxq1QUlzYHr4+jYy8dE8fKWC6Ch8rzwqnZxh4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=inEFCAZnmIQOB0olG4H8ebdN7N1WCrVvU/Y3OrZ9VMQhoJprGANOI6TFrJP4j0TnO
         TR0CZqHszLOCgjL9REWGNMaiqRJhZYSJqldKGouUVtxT+bknoNJU4ydyfwtpCIPWUf
         F7DwIHlMICXDhvCMR3Ps6bl9tUcuSELHh/glXyNk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200724064212.GA1871046@linux.intel.com>
References: <20200724064212.GA1871046@linux.intel.com>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200724064212.GA1871046@linux.intel.com>
X-PR-Tracked-Remote: git://git.infradead.org/users/jjs/linux-tpmdd.git
 tags/tpmdd-next-v5.9
X-PR-Tracked-Commit-Id: 85467f63a05c43364ba0b90d0c05bb89191543fa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 92b7e4923fdbeda9b86b1398127449d5353f9123
Message-Id: <159647730393.19506.15252934479107896206.pr-tracker-bot@kernel.org>
Date:   Mon, 03 Aug 2020 17:55:03 +0000
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, jmorris@namei.org,
        dhowells@redhat.com, peterhuewe@gmx.de
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The pull request you sent on Fri, 24 Jul 2020 09:42:27 +0300:

> git://git.infradead.org/users/jjs/linux-tpmdd.git tags/tpmdd-next-v5.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/92b7e4923fdbeda9b86b1398127449d5353f9123

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

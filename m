Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED2B1C7EE29
	for <linux-integrity@archiver.kernel.org>; Wed, 24 May 2023 02:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239113AbjEXCWN (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 23 May 2023 22:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjEXCWM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 May 2023 22:22:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FB99E;
        Tue, 23 May 2023 19:22:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2766F637EE;
        Wed, 24 May 2023 02:22:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 886C9C433EF;
        Wed, 24 May 2023 02:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684894925;
        bh=/BsYJOn4xpPnqUiZOaB6g0pWXrGA/KOcr/pnU7lMPYE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=oye/2xg3mtkVPrgVCJY8+OicElMKqluRB+VTyN4/tOiqA04EgYxWiZEPIfHasdfMx
         WYuowlxMXDR8dmj6R9s4LypNVfmB0LThjGnFkZGrC9LXO+4dI2SOlBQN/bpJy4JcVe
         3y2BtGFIHUtq4fZi0FhrNsqyqni/4/YzOFUvqmFDBAbueAFDPtXxBNKG27Lo5mx9Ci
         SPGX+ViPns+/0m5EU/656ooTb7mVSfHLwmbOhPuDr6dDtsMNQdFAKv3zv4Vmm6ZYCb
         32YzjHXnC2aLBJab3OtiLtIWfhNXyOC171vUN7Guu4Xuon//pxdFlPp8oA4tvm364A
         Q14Cqpoh5jRyw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 73B39E22B06;
        Wed, 24 May 2023 02:22:05 +0000 (UTC)
Subject: Re: [GIT PULL] tpmdd changes for v6.4-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230524020322.252360-1-jarkko@kernel.org>
References: <20230524020322.252360-1-jarkko@kernel.org>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230524020322.252360-1-jarkko@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/ tags/tpmdd-v6.4-rc4
X-PR-Tracked-Commit-Id: 95a9359ee22ff2efbad6b090fcfa3a97f5902f95
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9d646009f65d62d32815f376465a3b92d8d9b046
Message-Id: <168489492545.496.212322420956210018.pr-tracker-bot@kernel.org>
Date:   Wed, 24 May 2023 02:22:05 +0000
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The pull request you sent on Wed, 24 May 2023 05:03:22 +0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/ tags/tpmdd-v6.4-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9d646009f65d62d32815f376465a3b92d8d9b046

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

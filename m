Return-Path: <SRS0=xYmq=VG=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99741C606B0
	for <linux-integrity@archiver.kernel.org>; Tue,  9 Jul 2019 03:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E43F21707
	for <linux-integrity@archiver.kernel.org>; Tue,  9 Jul 2019 03:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562644203;
	bh=bSpee7tgEC/rC+AguQRL/7GowSvvZiLyLDUK2NBpCoo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=feynmEhETrZH6q38fdUvNhdd4rylE5edQl/a9eDSd+XkomIu42/p39vyrQXuEwtAe
	 jMHIAMnL1nsxhGFE3i0R6CvQRN/yVFjBAu0qt6JhaEiNr7yhq30qhK7EoxQpAsKA7Z
	 8EbN7kRFiAZHKl4/4FBjIqloU+FfQAVfT7QWtXLk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbfGIDuD (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 8 Jul 2019 23:50:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:41106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725905AbfGIDuC (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 8 Jul 2019 23:50:02 -0400
Subject: Re: [GIT PULL] integrity subsystem updates for v5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562644201;
        bh=bSpee7tgEC/rC+AguQRL/7GowSvvZiLyLDUK2NBpCoo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=QNvkychssA+TYO3qiLvQRRlfWCduktTCilXvSbhkayP7VknKY8HOUtRrD8Oj87OHg
         UzQPik22A7ljpKl8mA6dV5esCrfGw/YmxQ2vD9WhVdTMkey8AW71zZyVpJgj76w4Sw
         mr7H3OIOyqiITNkDSt+I4U7ixbfNd5yh2rNfNFqA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1562590738.11461.9.camel@linux.ibm.com>
References: <1562590738.11461.9.camel@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <1562590738.11461.9.camel@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
 next-integrity
X-PR-Tracked-Commit-Id: 650b29dbdf2caf7db27cdc8bfa8fc009b28a6ce3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8b68150883ca466a23e90902dd4113b22e692f04
Message-Id: <156264420177.1489.11656108173683014565.pr-tracker-bot@kernel.org>
Date:   Tue, 09 Jul 2019 03:50:01 +0000
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The pull request you sent on Mon, 08 Jul 2019 08:58:58 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8b68150883ca466a23e90902dd4113b22e692f04

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

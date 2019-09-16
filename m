Return-Path: <SRS0=mlK8=XL=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9C3C49ED7
	for <linux-integrity@archiver.kernel.org>; Mon, 16 Sep 2019 21:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80B2C216C8
	for <linux-integrity@archiver.kernel.org>; Mon, 16 Sep 2019 21:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568669710;
	bh=+F1xCInSoH8jPabgFo7VXRnWpEmT5b8DeYTZvQTlDmc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Wjvv093dMB7orKoBh/KHyKpVnnkFINM7AvP9WBRfXsigqKTzmF1+zr9suxhctFiwY
	 ArrM/zR9Zbvh2Uqrb8bVbiekmNg9Ri0XU0jL9+2AHU5w7U4scrjqdVL1ZWXNwxbjhV
	 9AQ0JRO+vglPUNnv4Ju3vtpxIGahyhTZIr/UsA/Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbfIPVfD (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 16 Sep 2019 17:35:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:41924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725971AbfIPVfD (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Sep 2019 17:35:03 -0400
Subject: Re: [GIT PULL] tpmdd updates for Linux v5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568669702;
        bh=+F1xCInSoH8jPabgFo7VXRnWpEmT5b8DeYTZvQTlDmc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=2SISj/9aUaCMtvMTPcJT3HiNKd9wIoZ1lhsH9wP9I46W6La+BkM/KN4R9yGc9Hgp8
         KJrH9RzCwRzmssp0Ihw1ZFzovVamVuOLv8aI9bEy1Jr/8idWBoKWXFbvBWHUAa80t1
         7PaS2wJ5Jp/bWBbXOTELxTiice9NWmFlz4/xHbWE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190902143121.pjnykevzlajlcrh6@linux.intel.com>
References: <20190902143121.pjnykevzlajlcrh6@linux.intel.com>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190902143121.pjnykevzlajlcrh6@linux.intel.com>
X-PR-Tracked-Remote: git://git.infradead.org/users/jjs/linux-tpmdd.git
 tags/tpmdd-next-20190902
X-PR-Tracked-Commit-Id: e8bd417aab0c72bfb54465596b16085702ba0405
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a7bd4bcf138e7ec95c00d55fee158f6be378029b
Message-Id: <156866970264.13102.5431330668367755202.pr-tracker-bot@kernel.org>
Date:   Mon, 16 Sep 2019 21:35:02 +0000
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, jmorris@namei.org
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The pull request you sent on Mon, 2 Sep 2019 17:31:21 +0300:

> git://git.infradead.org/users/jjs/linux-tpmdd.git tags/tpmdd-next-20190902

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a7bd4bcf138e7ec95c00d55fee158f6be378029b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

Return-Path: <SRS0=l+Hy=3Q=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E0DC2D0DB
	for <linux-integrity@archiver.kernel.org>; Mon, 27 Jan 2020 17:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BFEB2087F
	for <linux-integrity@archiver.kernel.org>; Mon, 27 Jan 2020 17:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580146503;
	bh=1xliGvsBOcWpopxp1jdAXo5BLBHgmV8GPJ+RFhbyJZM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=rNgKbI1tCH2R1DmUxh/Xo9B4fszaOMFMGJA84jYCMdVSMvxjYus3dAC8KvVVT/ZLl
	 yEi7iEGE+hwsSK7i48DNv3xhrfcLedb+naU5Eb5eZEjIEvo+ytvMStkBzVYeDZKESL
	 RsxT5slPClTwyGOv6jrsz8vdvixe1mRVvtS6fNrI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbgA0RfC (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 27 Jan 2020 12:35:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:36118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbgA0RfC (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Jan 2020 12:35:02 -0500
Subject: Re: [GIT PULL] tpmdd updates for Linux v5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580146502;
        bh=1xliGvsBOcWpopxp1jdAXo5BLBHgmV8GPJ+RFhbyJZM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=uWFj8Pg0+yXIbKokxkxV64Rlwp3c8PHB5A3akAOh6Mrcp6CJSSJJWooeaQsn/zNHD
         +HFr99Q7jheOLdlqmGUoGu5kaWFakId5uG9c2mcf0JyqywlBw/AmnsWJ36FMxXS4gU
         MZXaeP2KGSwFMKjx5pGRkF77L8ysw3X8RCwVdt1s=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200122085335.GA9383@linux.intel.com>
References: <20200122085335.GA9383@linux.intel.com>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200122085335.GA9383@linux.intel.com>
X-PR-Tracked-Remote: git://git.infradead.org/users/jjs/linux-tpmdd.git
 tags/tpmdd-next-20200122
X-PR-Tracked-Commit-Id: 7084eddf6be94e73f8298c1a28078b91536f2975
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 189fc98efe59b9b0a49a4f29ee3d91eeded4e4d4
Message-Id: <158014650223.9177.123216930003214309.pr-tracker-bot@kernel.org>
Date:   Mon, 27 Jan 2020 17:35:02 +0000
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, jmorris@namei.org,
        jsnitsel@redhat.com
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The pull request you sent on Wed, 22 Jan 2020 10:53:35 +0200:

> git://git.infradead.org/users/jjs/linux-tpmdd.git tags/tpmdd-next-20200122

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/189fc98efe59b9b0a49a4f29ee3d91eeded4e4d4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

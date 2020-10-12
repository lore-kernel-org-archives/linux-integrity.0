Return-Path: <SRS0=clxO=DT=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D618C43457
	for <linux-integrity@archiver.kernel.org>; Mon, 12 Oct 2020 18:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9DF122227
	for <linux-integrity@archiver.kernel.org>; Mon, 12 Oct 2020 18:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602526865;
	bh=vnZDg8jSo+sa2BeLBe4d0PRQEwin/sgTFKHotrKyMYg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=hAxaAXMs/1EtLnrAhj0bDcPd9dTmiY9dDXl3V0ZZuERwB+pLQYrfSuXJ1qHYFhzc+
	 iEkBRbzsbSss7RD8Dj61GDt+pVXnS3DEkEORj4yOERGe/8uSebdvUtnyKA7ec/aR+D
	 frXRUCNAek2qowvF28CWkI8yQhJzieFgVF7Df2R0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390878AbgJLSVE (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 12 Oct 2020 14:21:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:39106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390868AbgJLSVD (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 12 Oct 2020 14:21:03 -0400
Subject: Re: [GIT PULL] tpmdd updates for v5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602526863;
        bh=vnZDg8jSo+sa2BeLBe4d0PRQEwin/sgTFKHotrKyMYg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=LPuXdjTxQrlQrsw2Y9XQUtH6N8Z4ywR3e0pH6TDRS90uDVZqi3bEabvTc9JDyIzwQ
         UylvOUKGK/6rtuK062Cd0e+VHrqW35GllYMYx1UkWVIP7Yh1Hz0d4pO3z1x8mEkx9r
         t+FOIdDUTPFPlcJFDE87UHjluKUNWNGr3iCH1k1k=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201004210121.GA41675@linux.intel.com>
References: <20201004210121.GA41675@linux.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201004210121.GA41675@linux.intel.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-next-v5.10
X-PR-Tracked-Commit-Id: 7b9be800756f60bf5bb7baf39c7d221ecb877863
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d04a248f1f6cb4bcd8e38b6894bd4f9dc64b6aa8
Message-Id: <160252686356.3643.17735478866910483181.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Oct 2020 18:21:03 +0000
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, jmorris@namei.org,
        dhowells@redhat.com, peterhuewe@gmx.de
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The pull request you sent on Mon, 5 Oct 2020 00:01:31 +0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-next-v5.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d04a248f1f6cb4bcd8e38b6894bd4f9dc64b6aa8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

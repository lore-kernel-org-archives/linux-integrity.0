Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BD5C432BE
	for <linux-integrity@archiver.kernel.org>; Mon, 30 Aug 2021 19:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2034E60FD9
	for <linux-integrity@archiver.kernel.org>; Mon, 30 Aug 2021 19:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233986AbhH3TrI (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 30 Aug 2021 15:47:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:44104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233845AbhH3TrI (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Aug 2021 15:47:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id E198760462;
        Mon, 30 Aug 2021 19:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630352773;
        bh=PvaT27lZtqs9bitwXzznuUAps+ObzbAt0uEUwY3We3s=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=LIY4wGy37RbZr+v+mKIsNKYMlLtIDOognjSBDhNs5TRlh+4ZZadeEWas5L5ZVVdYK
         GJGBpWYGj8QKN7oMJ64Ab4c+NvcnHLtHMnLf3GH0EF30X/hhy8Tg27RVHQNXceaUj8
         OmZAJhvjZbCphCjFV8S8P2lgS6U3eXqPYxi8nbRmku027Q8t5bHz7LXqQwMSHdBG8G
         Yd2s6NxvxNk75fi0aQpTgtO5KLvoiNiagNuQhphj0IruTHfPQOJXQg6YYjLl2p7IT3
         YzXyFNN8qGAnZV/VARj4PCrw15ILS6VubeFjTO3oXf2AZij8ZCe73CaZeX9ge8vkfn
         SKX9tGLF1tL3A==
Subject: Re: [GIT PULL] TPM DEVICE DRIVER changes for v5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <dbb37ec13b79573e1223161383c222a6ab7ac15e.camel@kernel.org>
References: <dbb37ec13b79573e1223161383c222a6ab7ac15e.camel@kernel.org>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <dbb37ec13b79573e1223161383c222a6ab7ac15e.camel@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/ tags/tpmdd-next-v5.15
X-PR-Tracked-Commit-Id: f985911b7bc75d5c98ed24d8aaa8b94c590f7c6a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 451819aa5ad0a22b23f0eb178816dc72b73ab903
Message-Id: <163035277378.30336.12109422444290071212.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Aug 2021 19:46:13 +0000
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        jmorris@namei.org, dhowells@redhat.com, peterhuewe@gmx.de
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The pull request you sent on Mon, 23 Aug 2021 20:31:25 +0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/ tags/tpmdd-next-v5.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/451819aa5ad0a22b23f0eb178816dc72b73ab903

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0011C84BC;
	Fri, 17 Apr 2026 22:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776466719; cv=none; b=W3R9OyipA3ZhkWEz2/E0UKJJ/8zUlpAxKYtP+9E+VWQ0jMsBTwFXBK7Wxkbop/16pogGKC1nhaKuZqUrzbcOlmnC4rEPz0PBuPK8+2DNxieNdPBN6s/EiaKMgqSqs51IbsL9i9J0mytxyFuHiDKrnxe8T3NymaTDs865fjcZVUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776466719; c=relaxed/simple;
	bh=oMV8E+S9JlTt5Tg1DdtkjAualGhtTe7raWO/BGuGf0o=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WRECCCUhQujCrhDyqNjt1zlRVy2zBzI+8aMs8nhjb/7zRytEDQW3lGWD1j8WdlhiaLP2SLCcyBmUe/FXWWRjUGZOTsX3UtXSzoSN1JUBEKdgoy7ZvAWpuJhIDVIzsGIenOD0EXsMYDOAaFzdfjziAay/PsXMu5D3KGTWasuunNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+qtN3yF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+qtN3yF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF91CC19425;
	Fri, 17 Apr 2026 22:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776466718;
	bh=oMV8E+S9JlTt5Tg1DdtkjAualGhtTe7raWO/BGuGf0o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=h+qtN3yFsX1YGS714Ymc76kf0XwotoWmPkON2MsCeqco94TsBF08kC7c5vU/INn0C
	 xJgOgjCZJBrBTIjKSi/+gYXP+9zARVqmAv2WKAEif9jr4I+HhVV34Qa4l7rNRsrMit
	 KjzD8wMjnAhrluPcJtMY8P9dZmVR3JdvijCPTVnsPDc7RsmiSWJZ+fg7DM81ZsFxZx
	 uuk75sxooOfAkkg0NvTzP0C28KDWskerC5qSfWMnK9j+nFlpN6TVxb44nWVnXMEs+I
	 vLZ3HAt5hzCE2n1V5o+rwqY/cSHpG2CFVHkltNdbZ8Ao5uRFHJwKO+G6L5THvQOu82
	 kjDBtgd4JSlHQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE07380CEEC;
	Fri, 17 Apr 2026 22:58:07 +0000 (UTC)
Subject: Re: [GIT PULL] integrity: subsystem fixes for v7.1
From: pr-tracker-bot@kernel.org
In-Reply-To: <67d7f2aba75660bf44478e5718820061390b080e.camel@linux.ibm.com>
References: <67d7f2aba75660bf44478e5718820061390b080e.camel@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <67d7f2aba75660bf44478e5718820061390b080e.camel@linux.ibm.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git/ tags/integrity-v7.1
X-PR-Tracked-Commit-Id: 82bbd447199ff1441031d2eaf9afe041550cf525
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9cdca336677b4d15579ec462e33c8a330ab3a9de
Message-Id: <177646668590.187646.18250842633780608365.pr-tracker-bot@kernel.org>
Date: Fri, 17 Apr 2026 22:58:05 +0000
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-integrity <linux-integrity@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Roberto Sassu <roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 16 Apr 2026 09:18:49 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git/ tags/integrity-v7.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9cdca336677b4d15579ec462e33c8a330ab3a9de

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

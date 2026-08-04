Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716DE26FA60;
	Tue,  4 Aug 2026 18:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785866802; cv=none; b=NWo0mVvGHhLC9P2sDzOBTzGi3GQsNNpFItLBOdo+1Tfm7WSbp9thJ7GjbauPFfv6g+opw3RD+Tp3OiQyTaploHnbkTnb4JMD2hfhDE/OS8p/7QDTODdwRA1Gc3kOeImLZVI/NWzT61uwgWzcDtKRiTqVzJK2Xw7muz6HVjM3ioQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785866802; c=relaxed/simple;
	bh=TIio76VILZxujn6WCYkRdeljLFhYcqVy2jpHLUA1Y4Q=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=SicnI3HxjPJJIPKvDSGP0Slwsm2t5Ls+JiEyV4dW2aPxdd1b3XlDALOEnjgcFeX9jIe6zk2OXTO5Wgq1AfJ/Y2vqfBwUrrkIYFKnZehbMt+oH+kimKbfm2FGDJ33Us2z9zQJsktrly5aVWyplfmd6xcNaGwzvY8k3Gq2mKmm/Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0f8V0FI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0f8V0FI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21CEC1F000E9;
	Tue,  4 Aug 2026 18:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785866801;
	bh=LyxMBvBAiTauzJHsHYxOj7mhF0qHsAUbPVSIIuCof8k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=o0f8V0FISWprjkfO6IQafJ/fWxENB+eTztJMxt+f4GngFKo2qifMhyG6zDmYJb8V6
	 cuDNZAY0WmCamlM0mOA53HDE95OzS6hgnjeu6HBqicTeu0pYRUDA+VQDTSiexplVOL
	 bNIheZEZdNq3JczfH33VQhxcDY1X+gWC/NK7ORU9nTls10oAvQWQIZjUzM69Z5jZe6
	 AM/5ubS5xhWQyHVMMqeTWNKIAmA+55n4RQKfUSo0Yeg4+eN4U/78gOFEaTFGsAgbu7
	 nPuTKPtbbZm3igKc7rkphavPwLPJFho8wz12q+3VoARaRAWikIXXwOzA5AZBWh9HFg
	 pNPiOULaUV/0A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B8C3926398;
	Tue,  4 Aug 2026 18:06:02 +0000 (UTC)
Subject: Re: [GIT PULL] integrity: subsystem fixes for v7.2-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <1ace49db9726d140de8e4cc4c91ae53b0a060bea.camel@linux.ibm.com>
References: <1ace49db9726d140de8e4cc4c91ae53b0a060bea.camel@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <1ace49db9726d140de8e4cc4c91ae53b0a060bea.camel@linux.ibm.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git/ tags/integrity-v7.2-rc7
X-PR-Tracked-Commit-Id: b80bed5c871a80151351342c065579405ce77145
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 562bfb501c54a4d676528fbb70552f520fe6603b
Message-Id: <178586676153.3716517.1634670629311092250.pr-tracker-bot@kernel.org>
Date: Tue, 04 Aug 2026 18:06:01 +0000
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-integrity <linux-integrity@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Roberto Sassu <roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 04 Aug 2026 12:53:08 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git/ tags/integrity-v7.2-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/562bfb501c54a4d676528fbb70552f520fe6603b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

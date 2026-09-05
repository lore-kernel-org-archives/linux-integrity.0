Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28262D5408;
	Sat,  5 Sep 2026 02:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788577176; cv=none; b=rv1TfwET3VilBwuYcyU99UCL8Yvg1sTWC/Avch6f0rQIUnJcH2/GRdZO1P+4ZiEsiKQKY2miA0h/inc1np0Q5L5SE/jJ6VuSFvt4F0q+sQOg8YqOJY99+eUN0WY3HO85AzGVufgj4fFkG80KmFTXuMs2p9/Yxh5i97A3yuxr77I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788577176; c=relaxed/simple;
	bh=ThM7HHQClN3UQHyyg5RgpWRI46U8h7OCqXr8gssM2ps=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=usoXPx6x++UX0z/8lFHQrh2Pc1fcHN3WdQJBvRUTkegkpKoTc/FNOT9JWmdc49mz34Crvzs4mIbM5ss+uBYiPjHmo9V6SKrmlQmQHx4TcT0tF2HH8j+wk1jTvdSha52GyjVwwVk3t/wppPTiNsPtjPfuqDHouY3d0qp3rqNQOgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=genWiFrZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="genWiFrZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9078E1F00A3D;
	Sat,  5 Sep 2026 02:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788577175;
	bh=7fTc3VCot3QEmP1gvRpPCvEUVEUcYIZmA9d6BHXI6Ww=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=genWiFrZtVbn266zSE9L8UkNqUGNCTuU5ADtDT6IFPa2v2zyWd8OgFddu5apu+Sta
	 bS71H4U/rG1JiS7LtFndPQcqYJJ5xQUXzPZVEuM/YXC6mJh8WtsfQwFRSJyMunEYQd
	 1iAAdTyA006d7ADvHtJYXAjgHranbpFvPxqZYD4Im1xw7dl8UH9tKHwve1kMCtVLqu
	 6S8/mXu/QFujx0WmDyQQ622WwvhdKsRb/Cmz2kO5Zr9N3C1GxAUXyzIl9WqsCbf8in
	 5j0KrR51x0DGTsO3dLZ1dwrp0izMW0j+jHVBEHJF1Pcx4XpFOiK9OZChGnQqmMLlk5
	 Hv0/iqAdugTcA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A4B3924FC0;
	Sat,  5 Sep 2026 02:58:37 +0000 (UTC)
Subject: Re: [GIT PULL] integrity: subsystem fixes for v7.3-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <0e98c262ca18fb67d9a9a4556010378b332882e7.camel@linux.ibm.com>
References: <0e98c262ca18fb67d9a9a4556010378b332882e7.camel@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <0e98c262ca18fb67d9a9a4556010378b332882e7.camel@linux.ibm.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git/ tags/integrity-v7.3-rc2
X-PR-Tracked-Commit-Id: 6903878d4654bdef4e08e38cdf1ae306ce7de5f9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4d7d9486c04d917265f64c55bd23b2cc4fe7749c
Message-Id: <178857711591.1069514.4637826044773286659.pr-tracker-bot@kernel.org>
Date: Sat, 05 Sep 2026 02:58:35 +0000
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-integrity <linux-integrity@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Roberto Sassu <roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 04 Sep 2026 16:47:47 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git/ tags/integrity-v7.3-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4d7d9486c04d917265f64c55bd23b2cc4fe7749c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

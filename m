Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A1327732;
	Thu, 20 Aug 2026 00:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787187390; cv=none; b=j4VN1iN6VvG82rj8WR6E0S0Mxk7/1iF+HQayxny6UAl4knZMnkfv5O9W41V/3ywKkxmFE2wlu3irPFExefiD9xiBusGBHZWqqGVQ8E1scUTSwNg2amK/UfLczTrz5lQSoa1NPHIzQa5T5riudmLiCYmMwizDS/WEDuaIAdzWliY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787187390; c=relaxed/simple;
	bh=AZRTt94mFFpGjcnCaHGxdmqQdGqvhpCgp8mL1n+z3KI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=KY4B35HQarp8ctWORnJOFOk51dr6rdoW/cR4w4qGrPrjvGmFQSkUeh5X/9Tr+zxtAD9bz0fHBYwwtSvppDKCl4UMBhGFN6bMjJnKV47DGscFJqVuoeFg33ULuB4Y2bfoHIjENqTwtcOLYVRgvRIm07YbvTjcmgQDVWz4SP01CiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6IQZCqD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6IQZCqD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F2D51F000E9;
	Thu, 20 Aug 2026 00:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787187389;
	bh=x324Thf7WR7cMckcvG2kWOQUPx6xhkvcba+Go+CPFs8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=T6IQZCqDgHLNBEDFm6CI8tb6B9CGuCp+pyzIXeb00hPe0tOyfHJkH0897kqd+rMbM
	 84fbiiWWg0c3N6I+hJMH5vmeY4OyQE+DPl2rcLK/NNVfBK0iuZ35mueblCdXtpEbIP
	 Kjm8Dm6nA7hb66A0Gsoizk9D+Q1VL2Z31603G7u+8VxktLlmeJcARpAKiegiJgRcQS
	 C7HYNkGBsAyPJaU2YqiHEA63l0iyO6UdXSpCxcPm8OuRN5yQjU8585wFE4vpA4qqV0
	 Xww8Om3dRG4QZdXBRcvszCBgsY2LMiivRMGRlF62TYzM4EELKRs2qOANwQ416xQBF6
	 FpdkM1q9TbVig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A2D3811A50;
	Thu, 20 Aug 2026 00:55:41 +0000 (UTC)
Subject: Re: [GIT PULL] integrity: subsystem fixes for v7.3
From: pr-tracker-bot@kernel.org
In-Reply-To: <6246d8de26d1cce22b4c2e5f53891fff44af02ca.camel@linux.ibm.com>
References: <6246d8de26d1cce22b4c2e5f53891fff44af02ca.camel@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <6246d8de26d1cce22b4c2e5f53891fff44af02ca.camel@linux.ibm.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git/ tags/integrity-v7.3
X-PR-Tracked-Commit-Id: f1e10b10874051e4d99911dae0dd7b75a9f8ae66
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a51ec5e8e5dae80824239f0344210060cb92a4b0
Message-Id: <178718734012.3758847.15726162431965082493.pr-tracker-bot@kernel.org>
Date: Thu, 20 Aug 2026 00:55:40 +0000
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-integrity <linux-integrity@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Roberto Sassu <roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 19 Aug 2026 20:10:38 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git/ tags/integrity-v7.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a51ec5e8e5dae80824239f0344210060cb92a4b0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

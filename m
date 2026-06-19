Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16810343D7B;
	Fri, 19 Jun 2026 19:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781897104; cv=none; b=KpYDYwV+5Qi5/Mw0yVe7pXfGEBjtFr7FvHb4+sWqBK284P8Qmo8XIEXIdJi3OXF/Epwig2DDJir9v9oL3t1dImf05KKMOfcANwQTi801pUkDSb2qNVMzHAHQs4IW6TQF8M0aERYI9gvp8mA+A/lsVL+F4eALjwaJWLx2hrHY5Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781897104; c=relaxed/simple;
	bh=6N19KjCQA3e3C/yvz1V/+p4cgWE/QN6EsUNeS5iC5/U=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jGwRRbFZYtyaezq7TCAp43ctmH0mgGwheYgGrc3JqG1WgVEwHyC7S0DjhyV8usWAXOql5gs155GHBxRdUCHvt23CBBHYcta8YpW8ifKi11B4owybDowVNh5qbrzfmITQg5XcRQsy9M1sBcwR3j8QP+cpGGb7Vs0KD9USCil8wqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WK69Rno4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WK69Rno4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F18011F000E9;
	Fri, 19 Jun 2026 19:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781897104;
	bh=kDjfA20/ngjPYsSdjNQMWOcUxyzGk4HcXsstUvZcXQQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=WK69Rno415a9DDLHmX5LnDHKIR2mzJmaI/LaiF0RmIYrOeNmhsivKzqDfP9pQwWdr
	 ut4zyMzIOA78+oeRVqxHbNh9qA0M/K9xQuGf19RxBGLJ9Mp0hEzHPGZzrriuFw7JKm
	 kmtSBGEI4Yli7jfI0+mldCAJLbqnR0e2hfBYMsQevkoaaCiS0UP6Kj3rFVljbHxmZN
	 fv+0GD2BPRlshNb9ADbGmHKILI90Xo/ujV2oN+MbY254ua+rpnMOPGiMZA/nI/hNSv
	 UlvjrfQGuaE1y/HWyXwNqB3xP1Fnn5iadI6X3MThLJrwAJMrw6+kEt5ojalz240LSI
	 Ww2GbF5S4rHDw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199F73AAA0F6;
	Fri, 19 Jun 2026 19:24:58 +0000 (UTC)
Subject: Re: [GIT PULL] integrity: subsystem fixes for v7.2
From: pr-tracker-bot@kernel.org
In-Reply-To: <2a5a07ef24454c295c3a63ae8cedcd6c47578101.camel@linux.ibm.com>
References: <2a5a07ef24454c295c3a63ae8cedcd6c47578101.camel@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <2a5a07ef24454c295c3a63ae8cedcd6c47578101.camel@linux.ibm.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git/ tags/integrity-v7.2
X-PR-Tracked-Commit-Id: 35d6f5e788dae0dcc4c42d1280360f19aef9ab52
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0798268aa4c26ece25020b3ddeeef9a5941209c0
Message-Id: <178189709668.4037507.12635092401561450213.pr-tracker-bot@kernel.org>
Date: Fri, 19 Jun 2026 19:24:56 +0000
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-integrity <linux-integrity@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Roberto Sassu <roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 18 Jun 2026 10:06:01 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git/ tags/integrity-v7.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0798268aa4c26ece25020b3ddeeef9a5941209c0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

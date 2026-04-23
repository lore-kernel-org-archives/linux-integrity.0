Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E182566E9;
	Thu, 23 Apr 2026 16:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776962626; cv=none; b=lYKrvJfVQ5UKiTbXg38YqzuMXGqRYHfVonh7F10sG/mPJY9MTwNNmbHrlzZ2JA1cKlbo2/XjtnUu6eID2NsejZOTwhdt58X+gpzs4R7k9VtwtZ+h+8coYLPAOuHlfHmQusf4US3uDju12/biWiNMJZ1zJBeIlGU4rwOldkQ9njM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776962626; c=relaxed/simple;
	bh=F7m+/F2K/J/K5ydXXygHQR0cSFZnDQvjH0PaRr+CD54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VYk6wMBRNAgwNtjLGj6Lw9u3u20d90lb3+a8cbJzq0WY4KJF1b5+jskOZYUYySfmtPaOqQcP1LSrCjZUzLyVgKwF4MNaNMCl/OTvfn4wYQ/xhfLkriY02S8jUT0ca+FVsba1lZwKjChTw/l0S0NDrORXnbCTZq6XWOUL6RVCS9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VzmGQNgT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VzmGQNgT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5BB4C2BCAF;
	Thu, 23 Apr 2026 16:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776962626;
	bh=F7m+/F2K/J/K5ydXXygHQR0cSFZnDQvjH0PaRr+CD54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VzmGQNgTUw/Vx7WS6UEqkK7lcJ/XOSsaa+BwcQqn0nmAnyYcEBwNX1sagm09Bi2E7
	 ddeKpF5inLkHFvhIjBIbQk204X2Ev2BK73Qd3SxpzMzdcKaVHxjGLDuW+uLbDhRcpz
	 B+u4NpWu78Ekv38D+6ZvopdL8aEbNMlfhvIIxwjvE6CjP0ppjmxZ4kDovoBx1gOsL/
	 mqXhWmY5Ds2kEj5wlyTAKJllvHiXWGRekHOOm+x6IzKtaiNxRpYEji5whSHzBGHhIk
	 T7/NtkG7okkPXW0pOr5X/fUgrpHWkOS5K9bY+2/APrlGP4MyUlIRjkaLwR6Anloy6/
	 YcmK3Q887NglA==
Date: Thu, 23 Apr 2026 19:43:41 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jacqueline Wong <jacqwong@google.com>
Cc: Axel Rasmussen <axelrasmussen@google.com>,
	linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
	jhand@google.com, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/2] tpm_tis: fix retry exhaustion and add logging
Message-ID: <aepMPRLq7RJXAEbw@kernel.org>
References: <20260415160006.2275325-1-jacqwong@google.com>
 <CAJHvVcgnsh-PeSsemRd6crAUP85sqzMSZ1mcS08ATJr7cAvAaA@mail.gmail.com>
 <aenyoxT8ITZ6NBDk@kernel.org>
 <CAK8FdkqPzOiZZHsZPbMQg0s_=+rU6ENtBx-6YtuekyiqG8cvPw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK8FdkqPzOiZZHsZPbMQg0s_=+rU6ENtBx-6YtuekyiqG8cvPw@mail.gmail.com>

OK cool, thanks for heads up.

I'll most likely address this mess I'm having ATM by doing rc2
PR with the bug fixes.

BR, Jarkko

On Thu, Apr 23, 2026 at 08:29:47AM -0700, Jacqueline Wong wrote:
> Thanks Jarkko, the patches look correct to me.
> 
> Thanks,
> Jacqueline
> 
> On Thu, Apr 23, 2026 at 3:21 AM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> 
>     On Wed, Apr 22, 2026 at 04:00:17PM -0700, Axel Rasmussen wrote:
>     > On Wed, Apr 15, 2026 at 9:00 AM Jacqueline Wong <jacqwong@google.com>
>     wrote:
>     > >
>     > > The Fix:
>     > > - Patch 1: Adds error logs to identify the specific hardware status
>     mismatch.
>     > > - Patch 2: Stops execution immediately when retries are exhausted.
>     > >
>     > > v3 changes:
>     > > - Improved code alignment to pass checkpatch --strict.
>     >
>     > Thanks for sending the v3 Jacqueline!
>     > I suspect this may have slipped under folks' radar by not CC'ing
>     +linux-kernel@.
> 
>     Please check that I carry the correct version of patches:
> 
>     https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/log
>     /?h=for-next-tpm
> 
>     This is related to:
> 
>     1. https://lore.kernel.org/linux-integrity/aeVSbVIFaCDRXf7C@kernel.org/
>     2. https://lore.kernel.org/linux-integrity/CAHk-=
>     wiPWCUHsNvzKep7z4VGaL-Brx6Zmh7Efn28WWTPbwn5dA@mail.gmail.com/
>     3. https://lore.kernel.org/all/aee_mCW8p2J6IbIO@kernel.org/
> 
>     I will try to send PRs after my split next branches are sync to -next.
> 
>     BR, Jarkko
> 

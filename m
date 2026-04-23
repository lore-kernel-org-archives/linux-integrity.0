Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6F23921F0;
	Thu, 23 Apr 2026 10:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776939687; cv=none; b=pB2SszpjHFdeu12FWoiyk5Xnc3ReTFJTUhwBRmqcCyHCktm36n4MRrbyNu0Idj21AU4Og2V+dh0y69c+izoadWzGe6LqhPW/MGsYSZ9/QZbFneNFF1EcuOI0pC5R25vbCi6rSxofdtcfJfRvKJqFM1wyiJi9h+lacB62RagTx/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776939687; c=relaxed/simple;
	bh=o10aJeP/FSnfRpIIicu5BiobapOYRf5+LDtyL6ifjCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJWLBpInfNecyySb00wQjig47e+Ii2J34VJeLLpaTThKsU1iEPKb0mDqANGhsXxkNQVM7WDW9AIqXwE2cb2YqjNC+d4Ewk8pLUHdBZng+rCB8RwE2zP4qFdwvJIReZrNXFI6V/6R1yTmOQGaInV3MOs2UAYlV9vtSfdV7b0b9zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VVvlNj3P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VVvlNj3P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA35CC2BCAF;
	Thu, 23 Apr 2026 10:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776939687;
	bh=o10aJeP/FSnfRpIIicu5BiobapOYRf5+LDtyL6ifjCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VVvlNj3PhPHNqsyw1SNvFzUHaYA7KNuxDr+exnS3pttByPcLKOkaDhHOKrVNLLsa8
	 sE4FaBs0/9W1/i/VkAhFufcDZjP8SzHA8EmACELNWrgICl+nCkmaybXOUWUQy6nbWE
	 fJ7DUa8rqVcDa98MZuLVkwo9YTelUyEWULoEQPah6cS6MAZn0bMkMpu36JBL2MEfWA
	 Vor7sWs5TD5OQArsvgyruqmH/YGm0kxt/k0Yvg+myreatUsLNUQEEeZJw59fhmD5Wm
	 7zyNLGx+30Uk4ow8QMhDpdVss4j7eA6vgwMYzJK/6BS9WYJIRcfvAgEcfmT01osiht
	 xzUCa4BRIUZtQ==
Date: Thu, 23 Apr 2026 13:21:23 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Axel Rasmussen <axelrasmussen@google.com>
Cc: Jacqueline Wong <jacqwong@google.com>, linux-integrity@vger.kernel.org,
	peterhuewe@gmx.de, jgg@ziepe.ca, jhand@google.com,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/2] tpm_tis: fix retry exhaustion and add logging
Message-ID: <aenyoxT8ITZ6NBDk@kernel.org>
References: <20260415160006.2275325-1-jacqwong@google.com>
 <CAJHvVcgnsh-PeSsemRd6crAUP85sqzMSZ1mcS08ATJr7cAvAaA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJHvVcgnsh-PeSsemRd6crAUP85sqzMSZ1mcS08ATJr7cAvAaA@mail.gmail.com>

On Wed, Apr 22, 2026 at 04:00:17PM -0700, Axel Rasmussen wrote:
> On Wed, Apr 15, 2026 at 9:00 AM Jacqueline Wong <jacqwong@google.com> wrote:
> >
> > The Fix:
> > - Patch 1: Adds error logs to identify the specific hardware status mismatch.
> > - Patch 2: Stops execution immediately when retries are exhausted.
> >
> > v3 changes:
> > - Improved code alignment to pass checkpatch --strict.
> 
> Thanks for sending the v3 Jacqueline!
> I suspect this may have slipped under folks' radar by not CC'ing +linux-kernel@.

Please check that I carry the correct version of patches:

https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/log/?h=for-next-tpm

This is related to:

1. https://lore.kernel.org/linux-integrity/aeVSbVIFaCDRXf7C@kernel.org/
2. https://lore.kernel.org/linux-integrity/CAHk-=wiPWCUHsNvzKep7z4VGaL-Brx6Zmh7Efn28WWTPbwn5dA@mail.gmail.com/
3. https://lore.kernel.org/all/aee_mCW8p2J6IbIO@kernel.org/

I will try to send PRs after my split next branches are sync to -next.

BR, Jarkko

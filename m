Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6B5409122;
	Fri, 22 May 2026 12:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779453438; cv=none; b=rc8SMNexAx3IIaYLjAECCP7CVG0GbU0mD/EWeU/NrQ5fMare+e52D30rja5odC3hcK3gukEUIKpSnOz/9+TrVLaU3+iFhiGiiK6Hmn2jnE4izbabOs78Qf9cUdPeFFi3Ep+f8fRvuGQvtPHu15o2hB6GvoT8FR4qvl1OwdeVVqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779453438; c=relaxed/simple;
	bh=z/wBZ6rbyuMTWugSS9poVsDj1SFNDY2m6jZ0V23nYb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F2ieA3fcI8JwRR8rgnAK4Tyw4qAEPHiHZTnxtSCZ7rvS7U/it57NpLNeQcBfCuFo1OQklG5UWNNmpNbwn2TQpuCQdi+4i6nlbMeH1Me5UlV1IVyZP2wtpZfX6itK+/pZxY3z2G2YQLHdG9ve78+V6YBEHOp+pGpJkxR3hvb7AUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KTsY5EDE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTsY5EDE"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id A2ECD1F000E9;
	Fri, 22 May 2026 12:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779453434;
	bh=1Ohm8Cnet1iHKIpq9I4c5hHxdXomr/kAibOP9DNQw9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KTsY5EDE2O290Azc1pmR7FcktXOVjPiA7t7ATYu8KCcB1CiAB9VfuBEPZ/0JJF8pQ
	 mlZn8Pmn2XeJng8xI7useBwGCHVbmcl4id9mfGSkJ/CtpaU6vUrz6h3dTGy5igR3rd
	 bpxwTiLn0utLCzW2Of7qW967UOOUKXpKXTPrKfku/wUVCPAky1GeMpApklLJ0NY25J
	 x0AcoHTeI9Gqyfz5G0tj6noyVF9xHOctBNDebe8WsPmLkIZwnWUFlgJQ5b4aqVRRby
	 23suY2q9y3rn7s3X7AFBo6D2nygHr+OYJAx6jjBvRccd5NhInLRvCQvxIvdgqMi4Vo
	 z0Lbb3H3DhDVA==
Date: Fri, 22 May 2026 15:37:10 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jim Broadus <jbroadus@gmail.com>
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca
Subject: Re: [PATCH] tpm: tpm_tis: Add optional delay after relinquish
Message-ID: <ahBN9vCLmHLBqnch@kernel.org>
References: <20260519060926.103727-1-jbroadus@gmail.com>
 <ag-ZuEt4uXnrO8AK@kernel.org>
 <CAKgEEwswj4in29_hoy_dQQ18+GF=Uwf0LnwS=w7bwZCSW=mwjw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgEEwswj4in29_hoy_dQQ18+GF=Uwf0LnwS=w7bwZCSW=mwjw@mail.gmail.com>

On Thu, May 21, 2026 at 11:03:29PM -0700, Jim Broadus wrote:
> Thank you Jarkko. I'll do that.
> 
> Jim

Yeah, in this form it is quite unsable e.g., for any Linux distribution,
and somewhat involved for the user :-)

Conditionally on is much better with appropriate detection. Also, this
way the change improves the code base a bit given that chip->did_vid is
much more applicable than chip->manufaturer_id.

BR, Jarkko

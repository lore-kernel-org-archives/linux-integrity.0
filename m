Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBED30C345;
	Thu, 24 Sep 2026 11:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790249258; cv=none; b=tfeJEgTWEzVG7daKP1H3EiaF6nPQd1P5Heuf8nCo84fKy0IGIw7GnfU7eXTchtQoefdbGKFB6mFS/pLd1loMFvLQMqUWpIiBig0UZ3Zfz47+7TLLOk/KpfS3IBtPwzoSwCel57ZobxBpNv2NCOAwqGHSD6oGLWdKBXDAs0fdtXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790249258; c=relaxed/simple;
	bh=my6DpkZnBQtVPsMZV958YS2Tf7S/W8fX5yNlP388xko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n04sPaLKFT3o9OkQrRZNPoW/iW5InAaHiT+5RXAwmhb80gTghpANMgsHsYnGVxt3ANfJLxDyTnwgTiOfyoOmh2rVJrDDnjKnIzKI0bKHCALVNgSjml+VCZTaZFCZ5czKLBj3+jtxA3Sqp2q23YEd3rrDSYbKp8N4e7NTIR6a6+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ecn7jO/n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ecn7jO/n"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 3D9971F000FF;
	Thu, 24 Sep 2026 11:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790249256;
	bh=iABVPZWcBTmmLrZa/3dbULJ4srFGX/7UR65lciVwmhY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ecn7jO/nYvPKT3dB6gSYhIzWf5LY8dMuY+MRYbecv0RYyJCYvGNVVi+yThqx0uuKK
	 pJEd47+Tfa14imJGNZMcChV3qIvCfZrxM+CqOr8GbNriUayBWsxvl2Ham87btG3rxn
	 3Vvp0vLguUniUsJ+nzPsxdve9vkjD/bdl/fA9Y9ew3j0vsAOQn+i7Enkaf4g5fjhyk
	 Upba6zeAdi0Z5pFbJ2DWNRVLEQEQ5nGyl3vJbk7gWNyeEdJLsCnEz92vL5gadq9eJ3
	 CqMM6fFdB4q002qVr4xOj2J85NrN+Y3iJLiw7f9VrHIvhotrWzJ+k/npXSXhH6RVMm
	 diatNt0Oneu0Q==
Date: Thu, 24 Sep 2026 14:27:32 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Arnd Bergmann <arnd@kernel.org>, Peter Huewe <peterhuewe@gmx.de>,
	Li Jun <lijun01@kylinos.cn>, Arnd Bergmann <arnd@arndb.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: remove extraneous #ifdef
Message-ID: <arUJJNMbXLucUZph@kernel.org>
References: <20260915201305.3529682-1-arnd@kernel.org>
 <aqyMnwklQX3ciUzf@kernel.org>
 <aqyNgA5NdSTdrP_6@kernel.org>
 <aqyOUgIa4lsUwO0I@kernel.org>
 <aqzOnj9-35h3gAPD@monoceros>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aqzOnj9-35h3gAPD@monoceros>

On Fri, Sep 18, 2026 at 07:44:30AM +0200, Uwe Kleine-König wrote:
> Hello Jarkko,
> 
> On Fri, Sep 18, 2026 at 04:05:22AM +0300, Jarkko Sakkinen wrote:
> > On Fri, Sep 18, 2026 at 04:01:57AM +0300, Jarkko Sakkinen wrote:
> > > I pushed this to for-next-tpm, which mirrors to linux-next.
> 
> I don't spot it in
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git for-next-tpm
> 
> , do I look at the wrong tree?
> 
> > > However, since this is -next only bug, I guess I should squash these to
> > > the original commit?
> > > 
> > > Just sanity checking before taking action :-)
> > 
> > My suggestion would be to amend Co-authored-by to the original commit
> > message as two bug fixes is significant amount of effort to make the
> > change right.
> 
> I don't care much about my Tested-by: tag, so feel free to drop it.
> Promoting that to a Tested-by: on the squashed commit is wrong for sure.
> 
> Best regards
> Uwe

Sorry I had my tree in bad state as per syncing with remotes.

I now squashed fix to the original commit from Li.

Br, Jarkko

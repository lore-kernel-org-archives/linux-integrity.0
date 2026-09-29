Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522CB1917CD;
	Tue, 29 Sep 2026 22:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790720728; cv=none; b=ZB9uqkfnBo+DPZCUROoiyHfDwDicuFWfK9hYpM9VqKFjwKR9VHiI1N02oevUMvTE5Xavbk6rWbZ7kpJbsRYtTeYArS/QRvMfBwLoFZ0h/RYm/GtboT1B/Jy+EfSEMw6c5WwiTt5yxLLoAogDGBcAKg5azuLVnrYTSqsmoSgBNh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790720728; c=relaxed/simple;
	bh=vDOPVQN8b1p8lmYnEVIbK2Q9J47ViR/ntcYltsxD2TQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kij5+oUrmLhkyxRvBORWTCIif8YvejvIqagaUJ2RXg23YCtUZb8y2F2ZUh1aPR+De3pe5uDDUZ4DCl030ppO2vIxniLu8P3JCkMlsWUlvgSrvn6jU3MPFzuCjnCgmnxNOO2TWlDf4hjh+lyiOwzrUS8OQUlJOgmXSrCPEdG1uuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0V0z091; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0V0z091"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 6217D1F000FF;
	Tue, 29 Sep 2026 22:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790720726;
	bh=3SZuw5cQDBPZfrMBfSK7dageK4m/f3nOjUwtVB4JX1E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=n0V0z091s23MgsIIFYrO9om50tjzUJBaMVWKSb9jdVvKz35jmoCjdE8kUkgWmzYuO
	 hS21Fko4CkYMU0tigikTph27WjaKLnatKjgxbNtLHUQfGp5fSBM7FhcY8aY2dhEyMm
	 7DiTS5u6v74GECC0h1JQ/LEnxq8EgnnuvQF2CQRwWnDon8ku34vayiuRrSxZPNWFat
	 W81zDckv3TM6+3A2+WPFHYo6rXGmxIvBGje7jgxkVpkKdZFEDFRzOxY9qhgjroXK3A
	 bjstIG0AZci9J0Xk7D3tgGYfMmCCneHlfyxtdWCT7T6b3SkmQKW4bKfILhJ0VXt4gR
	 AwPz5puuIgw0A==
Date: Wed, 30 Sep 2026 01:25:23 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Sean Meadows <Hellfire@unspacy.com>
Cc: linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
	rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
	Adam Alves <adamoa@gmail.com>
Subject: Re: [BUG] tpm_crb/Intel PTT: Late S3/S5/Reboot ACPI power management
 deadlock
Message-ID: <arw609M6mDiqhQwJ@kernel.org>
References: <bf3a9544-6e49-4d5d-a01a-f1912b717d08@unspacy.com>
 <aqyTpzk3jcarEMVS@kernel.org>
 <54425edf-3ca1-4f99-9166-40f9cc3dfff6@unspacy.com>
 <araNsEodZ3NXf9qT@kernel.org>
 <0e8f93d0-3da9-4af0-ac12-b3670acdcf79@unspacy.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e8f93d0-3da9-4af0-ac12-b3670acdcf79@unspacy.com>

On Tue, Sep 29, 2026 at 01:44:29PM -0400, Sean Meadows wrote:
> 
> On 9/25/26 11:05, Jarkko Sakkinen wrote:
> > 
> > Thanks for providing the information.
> > 
> > Bugzilla bug under discussion: https://bugzilla.kernel.org/
> > show_bug.cgi? id=217890
> > 
> > I also found fix attempt of which 3rd version somehow went past me:
> > 
> > https://lore.kernel.org/all/20240308145313.40932-1-adamoa@gmail.com/
> > 
> > Does this or disabling hwrng sort out the issue?
> > 
> > I got one other idea too with no empirical basis (just hypothesis): perhaps
> > release memory mapping on suspend could help firmware.
> > 
> > 
> > Br, Jarkko
> 
> Acknowledged.
> 
> Disabling HWRNG via kernel cmdline failed, and since my research implied
> that path would require a custom kernel, I shifted my efforts toward
> forward-porting Mr. Alves's 2024 patch to 7.2.7. It took some work, but
> I have successfully compiled it and got it booting on my machine.
> 
> The patch appears to sort out the issue so far, but I'm only 43 hours
> into the test. As we discussed previously, this bug can take days to
> manifest, so I will reply again once I cross a week of sleep cycles
> without a crash.
> 
> I also have a USB3 debug cable on the way in hope of capturing the
> hardware state during the power transition. That said, if Mr. Alves's
> patch continues to work as well as it has so far, there may not be any
> need for that.
> 
> Sean

There's a commit with title "tpm: Call cmd_ready/go_idle for each command
transmission", which is strongest contender to make a difference to this
long running issue.

I.e. I think it will improve firmware behavior given full release of
resources per TPM command.

I'm including it to v7.4 pull request.

Br, Jarkko

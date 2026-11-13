Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794600362;
	b=qXJ11d6SENW8vgDhXdCTq8rkzxToi3CpC9GADKAGQHkJQ+wJ+Ixbbqd728wSMirq3F5A
	 JGsFWUJ3gEZ0KuwppKu49ZN+0e2yrFFtjPfxNGeABXnQmHddpz2nk5stvX/h5VRxnqtUZ
	 hWMMWc60/Bx7KQv2RIKzrd6mc2erdHDHyPdwcze4SeW05j+Km6v88IkQAjfp2J9VXYntf
	 M4muLy6+h8nQI9HNtzFG0JVQkmaNVlDGKvKDSRlIw9MaSFwXDj5vfg7fFhMlrRAmzUNYu
	 xQKvcyU0uboS9SSWwXN+yzOId26mbIRH8wQCMthd04CNPn52wlc9KspZ0Obf7GOLuyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794600362;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=bLHiJFzIdxGLYNFRvyQEcnpmT3HXGkY10NTe1+6z9oA=;
	b=AaPhsJIZ2vJ6UUQUSBtg+Lv7pYonNCWvTl9vG0/2F5JTyZzIJs98G7ESkBx+Jf5cUb0B
	 oDbA5p5Kt4miASoAMxIEkYl6ei8r41FdZR0VzH64Y084/ZlB4DVHeDmflkUkx3lfbC2IQ
	 dX+adQv0km5cNV/lLcqQhTB59PFT8FWehwKos+9WTbCrI/gcI+4geKy360vsnEa02Ni/I
	 7YG0+oPmISs/IGzH4wH3gbYzX1ZOLPbNwXu1iiDwzIek4SRsYrCw8OSFb1sBTYWpFs5SN
	 GRsRgjHHCmyDfoYkIIZpkIGpIFGFKXU9nsfxVYbU1T2VMumHaKC74yeE8eIG08pgTgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DqgHSkyV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 2CCCF606A330;
	Fri, 13 Nov 2026 20:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DqgHSkyV
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 668361F000C4;
	Fri, 13 Nov 2026 20:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794600361;
	bh=bLHiJFzIdxGLYNFRvyQEcnpmT3HXGkY10NTe1+6z9oA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DqgHSkyVKUffL54pgWYpUiXYhb+aX6GY9LCrcdlRtlAr6KQu9+hw1aQgi2r9U3/hc
	 mgTkEfw9D6cGA2TljQ1c8P/uzoQGCb9OZnYZA3E4UAEeerJc1Jyo3diRUTlHSv2zK/
	 x9mAihruZRCjw4Jv7ESrNCFIE5djXO+r4EZY6Oj/bAKhsSkx01U6eDNLSM4LtiXZww
	 d06xfpTKJfBN/CAQ3dGw3FlaENqIQpeDSr1HJGb+aP+BsCLdQwfm1vq37qP41rcjw4
	 EE1GJfqfB1JaXf+lHudm0MGGiKqFpFb7bheyJREpJY6ftLHWiatkyNSc2Q9PaW4R18
	 WPzk0PNpMCgSQ==
Date: Fri, 13 Nov 2026 22:05:58 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Surendran Kanagaraj <surenkj@amazon.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	Jonathan McDowell <noodles@earth.li>,
	Breno Leitao <leitao@debian.org>, nh-open-source@amazon.com,
	Alexander Graf <graf@amazon.de>,
	Gunnar Kudrjavets <gunnarku@amazon.com>,
	Josh Levinson <joshlev@amazon.com>
Subject: Re: [RFC PATCH v3 1/8] tpm: Add a single table for all TPM wait
 limits
Message-ID: <avdtplYZFvisXD9v@kernel.org>
References: <20261112163846.97654-1-surenkj@amazon.com>
 <20261112163846.97654-2-surenkj@amazon.com>
 <avdoybHEoRd0Fhie@kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avdoybHEoRd0Fhie@kernel.org>

On Fri, Nov 13, 2026 at 09:45:17PM +0200, Jarkko Sakkinen wrote:
> This is a great starting point.

I skimmed the other patches but it does not pay off to nitpick the
details up until the very first patch is more or less settled.

Br, Jarkko

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794526777;
	b=Ietjefn1Cb8QKVLD6MHPhd8sGOtcJjgA4F8EmZK9MqK6o/eRzBRordMCO141IfSVKT3P
	 jel5b6U6nXRJgBscVSJrKtbL6mAYE9q4zoYSs0ixFVm09XpfiKT9r51hpuil7eqhXRGg9
	 ObIUAlmSt/VJyiqC3MMHWBe3LyGai1MjYTmuKnh21VwsZc6PDQtSH7UO+DW74soKoE7Te
	 dGsCPqq2XV0XJWuQXsX+DYgeVrHCYrLnu180bIR8KmBnmcX3uVI3c5ZVn1cpZUnVa7wkS
	 4afPcWT/N8CpP7toKfCTLiX7KzluyyqmzbrGijl5Vrk4SGPEZVQPWkC0jZF0iG3jUZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794526777;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=HPidEKJVpyateKLYCJwiGwuCGDMNYMEDcVTo1zQ0uLk=;
	b=LbND8BYeGEjp6BudfjsasSf9UiJ2V49J6OogRjW3RDZAEc9hUIIw3eD8JgnTgx9qClCM
	 dabLLiPzcedzrc9u7HNZq2zKSLPRth+rROzCW+7PKzmUT2Q5VpyLyvIQGdVLT4pa2WlYZ
	 P7/KMLZln7ikoBLSbGVtSsk6iSQmFl+T+0iDPNSGPweKV7+r4E4gS/nGuU7nMTTBYtz4H
	 eVvGgAVvBjXEMa73rMjFQKDwp7jxbTQpHtRaBk7nc0Gd+uzgca+QnwvEsxTkHqTELZyV7
	 n7gZpSpZ+bkEla8Mdpiz67+A+IFzlEuzULbJSgsQJnQnQgvSH/h6OKY0bo581UVBD5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="nq04xoU/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 0E362606A31C;
	Thu, 12 Nov 2026 23:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nq04xoU/
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 2509F1F000C4;
	Thu, 12 Nov 2026 23:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794526776;
	bh=HPidEKJVpyateKLYCJwiGwuCGDMNYMEDcVTo1zQ0uLk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nq04xoU/STifZQdfKCIOtXKdCgzBZ3M5AFONiyo0v4Kdeseblm9iVD38OcVV67+Wd
	 AFPrvz6wiK8YmsKyAudZz09XHxanApmVIGvImcbhebv0ziB9vMllyp3NAAP13hzD5C
	 XqykJPiPkMr7r1MPNAwXx1hLn+yxGrhXsSGce3+RU6xWUf88vh5MdUSvZ5745chFwg
	 tzkwX6YjU6pTTA46ECYtFHtosXOXwQf4HEgJ9rz7orEqE705g6Vx7hvTwarhmUtXSN
	 pt+R+Ou7ubpGsUfHaIP7qGLDH+mcKeYnN1mv7VwEgEgf0NEI3yakCtK0TsPi6iAAPW
	 qi7PqWXtOogng==
Date: Fri, 13 Nov 2026 01:39:33 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Breno Leitao <leitao@debian.org>, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org, surenkj@amazon.com, noodles@meta.com,
	kernel-team@meta.com
Subject: Re: [PATCH v2 2/2] tpm: Disable TPM on TPM_RC_INITIALIZE
Message-ID: <avZONTqgc6nTlihy@kernel.org>
References: <20261112-tpm_unresponsive-v2-0-7454d2c899ef@debian.org>
 <20261112-tpm_unresponsive-v2-2-7454d2c899ef@debian.org>
 <20261112225759.67730166@pumpkin>
 <avZMPeUtzV3JyAX0@kernel.org>
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
In-Reply-To: <avZMPeUtzV3JyAX0@kernel.org>

On Fri, Nov 13, 2026 at 01:31:13AM +0200, Jarkko Sakkinen wrote:
> On Thu, Nov 12, 2026 at 10:57:59PM +0000, David Laight wrote:
> > On Thu, 12 Nov 2026 04:30:18 -0800
> > Breno Leitao <leitao@debian.org> wrote:
> > 
> > > From: Jarkko Sakkinen <jarkko@kernel.org>
> > > 
> > > If the TPM has been spuriously disabled, the game is over. Let's reflect
> > > this truth with TPM_CHIP_FLAG_DISABLE.
> > 
> > Shouldn't it be completely 'game over'?
> > (aka panic time...)
> 
> There's nothing pointing to that direction. Nothing is really broken
> except likely firmware bug or similar situation. We don't want to brick
> the machine because of that. Neither security is endangered as
> anything that  was sealed with TPM, it is inaccessible.
> 
> It's also useful for us that any possible user has a chance to run e.g.,
> acpidump without kernel pulling the carpet.

And fTPM tripping has been reoccuring theme since they first arrived in
2014; not something extremely rare that "almost never" would happen.

Br, Jarkko

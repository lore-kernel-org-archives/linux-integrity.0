Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795165099;
	b=dn/VfxHfeujzW2rIN5Ckd0KsfHYp+PPRNWnpAGxqtBB1kR4kKiVjApJQTvnAquiQgAq0
	 jIZOQXXRymXYhwxTV1GolR/jv9taFg8lImckvdmRc7+as/qwnkiv30o/FwXK5mb/ikXT4
	 X8m8JGswstTwQAl0uuiXJjamBl+QchUtAa1j1Q3B/KOpdoE2/TLEonJYoELFYu0I9s//T
	 WtxHsGbNPwGS154fQWJDCqWJsDTDxVCeWadm6qwGEqpq2eH6IvDqAWIIJLznkTT8E+sjO
	 JgBJmdLq3b3QYnu9A3YIQ3hUbRnaBQzKL1Ls3grIyb9Jx7SYo9hYkxGyyBxKgEJK//A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795165099;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=wJJ66nNQpcMyefwThqFqyGAbNuFBfeb0zsYpY7qs5v4=;
	b=ecHCuJH/hkgMqBrLQ2hXN5KXJPiuux3BfoF10fJ0vd/t4vVCw17WhnfSa3et0pTKUpEL
	 YSsljqARljm2J9gALpjPC0gcIiyUqyNkJatsvTt1cx3xky+h+5cI3OigCNkx9G/yhByzO
	 Tgg+yNps+FDkSGuJ7H14lCyUmtYjzX39zJ6oaXF6f+t5xCTaSBeB63ng1iJX2dnWHv2n2
	 aUBCDmLOtnwYWXs2JILQq6cFkw/DKA6qV+pxNuButJ/9nFuJJ6VTYt/VRgjy36oR+uAi9
	 V761bdUnQzQSOy83VCiuY6DqcajJyygy0G94A1H77qroHWaZxLrTdUTOO1S+nsjgBdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FEOtZUSA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 32321606A32C;
	Fri, 20 Nov 2026 08:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FEOtZUSA
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 6392D1F000CA;
	Fri, 20 Nov 2026 08:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795165099;
	bh=wJJ66nNQpcMyefwThqFqyGAbNuFBfeb0zsYpY7qs5v4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FEOtZUSAm6tMQHi5f4rO2i0R+ytSrgTxut/s2rZj69rnTpXQtslaS8K3SVMa4WurC
	 5dUthyPbpAdg2RKAYdBzCw10xq/IxmZ+UFLUqe0NVWXwDdZ42b8UftiELTxeRMLczY
	 GYZ7QqnVQQNSrcGZSPEqrbB0l9toG61oAYVutLMujEiYVNImtTUZ77K4dyjgUJ2h1g
	 NSPxNi84moaVHy9B29yifH0lGjMHgHIrpEZdIHonzFA3N/uFt83rKQSHFOfa4yCn5y
	 OFNDoFgIe2cZ2v2QXh4NOlYZk2sHAGkhdjTxfg36df1VLwSYiRhKb7ACRI2y60xn5s
	 eFKRQ5/sdP+mQ==
Date: Fri, 20 Nov 2026 10:58:15 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: shyckless@gmail.com
Cc: jgg@ziepe.ca, sstabellini@kernel.org, jgross@suse.com,
	xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org
Subject: Re: [PATCH v3] tpm: xen-tpmfront: fix use-after-free in
 backend_changed()
Message-ID: <awALp-m9n07zxwfj@kernel.org>
References: <20261120-xen-tpmfront-v3-1-3ea2e3fd8611@gmail.com>
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
In-Reply-To: <20261120-xen-tpmfront-v3-1-3ea2e3fd8611@gmail.com>

On Fri, Nov 20, 2026 at 04:26:16AM +0000, Suyuan Wang via B4 Relay wrote:
> From: Suyuan Wang <stevewong@hust.edu.cn>
> 
> When the backend moves to Closing or Closed, backend_changed()
> unregisters the device and then keeps using it:
> 
> 	device_unregister(&dev->dev);
> 	xenbus_frontend_closed(dev);
> 
> The xenbus watch callback that calls backend_changed() does not hold a
> reference to the device. The tpm_chip registered by xen-tpmfront has dev
> as its parent and holds a reference to it, but tpmfront_remove() drops
> that reference when it unregisters the chip. So device_unregister() can
> release the last reference and free the xenbus_device, and
> xenbus_frontend_closed(dev) then accesses freed memory.
> 
> The stubdom based vTPM backend, the only one in use today, never
> switches to Closing or Closed, so this path is not reached with it. It
> is reached with any backend that follows the normal xenbus state
> machine on shutdown.
> 
> Take a temporary reference before unregistering and drop it after
> xenbus_frontend_closed(). This keeps dev alive for the last access and
> keeps the existing order, in which TPM operations are stopped before
> the frontend is marked Closed.
> 
> Found with a static analysis tool and checked by hand.
> 
> Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
> Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
> Signed-off-by: Suyuan Wang <stevewong@hust.edu.cn>
> ---
> Changes in v3:
> - Drop the Fixes tag (Jarkko). No code change.
> 
> Changes in v2:
> - Say that the stubdom vTPM backend never reaches this path, and don't
>   ask for a stable backport (Juergen, Jarkko). No code change.

There's no use-after-free to fix.

Br, Jarkko

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795125421;
	b=nLunsBuRTwMvdM5LZ9U41Qqetu3akpdgVhAJdHrhdb2ctEc3W2r5q93nuWMr2Ff4cKzO
	 9sFrLkvwVglcES4T3NhK2ZdI2/zeHImFliIGxrtLWiRUD73mcHzYSOeDmKyX/NtLq0LLW
	 O/96bKIF3iKqd1VRczOt104XaVU70yGA7alZBMaSlrVWrq0iwUr6pcT1fgK4QM571ezw4
	 s6hrglXOtKAy55RzXXKy5wnsU3yROGxBesaUSbUwCczsgeyuRujcHYAd2Vfo7kVagHEKz
	 D79aMRIcUmvB8ftmCu7HVQEXfkN4zH6xWAXZcie82RtW5NvhYnfpXNyBVFeYtPSJcpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795125421;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=VpqsGc+T35woZ/9RFQSmMof8XlqRoyY6yDjeJFEmX+8=;
	b=mCADMu9PPZUXIZ7F8Qs0h9/DLe6/IaezKAVhuNkRMMQ/dufJuSZc1qxtidGlegi9MHPO
	 F52yOa5vMyB8BJUzuz6mGHvxLNZxI5wknE3uaVScrFhmPNbJ3FzBE7pmjyclCH5eEgAD+
	 Hbb2SMMzYFYGWUxP/6TnBzxroYXufT3E1yPtRYF1OuIUMj0ASqfbBYN0txOGFbY8zCb3e
	 dHe9xDFudk/a6T2Trdhs7NagywGgWqNjHEDMepCa1+aM7deASLZ39Jyqsc07F9E36iUbX
	 iYdF1Dl8di0fH82ZkAEpU90p9uBq3hYIkptmKRbxREgTDLjBsiaUtnnXChdEdUq+YWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="eMHt/lV8";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 0A6DA606A325;
	Thu, 19 Nov 2026 21:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eMHt/lV8
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 1639A1F000C0;
	Thu, 19 Nov 2026 21:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795125420;
	bh=VpqsGc+T35woZ/9RFQSmMof8XlqRoyY6yDjeJFEmX+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eMHt/lV8RKHshp6iibV7q9GzLNJmfkgxO6NM49SSIWDiVynFw2MsU0jZn/oQDnBD0
	 MWdnGIKPe+dFL601NpqIEWK/Btf3UUToiAANJViwgCo6oa+i+znALOknmmbm2HNy97
	 gIR9gDg9a3v7zCYfou9QHx5/kGTDIWAREWfLrT364A/dIIP8CO+aOdGq5T5gZDbImq
	 UBM0xfwuDqlvyiNE6HmJj27C6JGoLph/rDwuGs8duXWbEGbluuoxckkELcg5hHrlGb
	 fGF2/dlzTx1osDdUiAxJdNVB0o/dt91zARFi9YWM6/9+6OwKjMy+tYZ+EKtlbI6ACX
	 /NZllpbWYOVJA==
Date: Thu, 19 Nov 2026 23:56:56 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: shyckless@gmail.com
Cc: jgg@ziepe.ca, sstabellini@kernel.org, xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
	jgross@suse.com
Subject: Re: [PATCH v2] tpm: xen-tpmfront: fix use-after-free in
 backend_changed()
Message-ID: <av9wqIwiZRUywhNU@kernel.org>
References: <20261119-xen-tpmfront-v2-1-e0e51c36360d@gmail.com>
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
In-Reply-To: <20261119-xen-tpmfront-v2-1-e0e51c36360d@gmail.com>

On Thu, Nov 19, 2026 at 09:36:02PM +0000, Suyuan Wang via B4 Relay wrote:
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
> Fixes: e2683957fb26 ("drivers/tpm: add xen tpmfront interface")

This should not have a fixes tag.

Br, Jarkko

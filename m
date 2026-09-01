Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337A8480DF5;
	Tue,  1 Sep 2026 16:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281733; cv=none; b=PQJBpywB9dfD+/oZWaDYO8voCAg+evVDb+8beJJcwjm2103OJmGqzwCP27Za6by8Tx+06G+PuEJJg2EvP5tO1UbDBZvpqL1p/N5myW3bMncjENS67vCKlR9BZOYaly/hX5xTNS/F+KV86vsg8e6BCGQ2AGhIHhiWKGZGHVwkKH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281733; c=relaxed/simple;
	bh=+8cX2VISL3D28pdHd7mlIRuE3Puy9+0GqNMgL4O1ZMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nziYT+coRVCRiDBQneIsAcA7/fVGjj3cdfTZLEvyQj+flfVBvidpBIGdo4/orUBhMMsK4z/K572XfrX9Ikw9xn0sVeG8V1PqPhp5MteYi0KBGsh96rH2fEOv73YzLwjd3eNnWsx061Th+CrvZa9b1rW8XgFW+NzcontPy8b2fxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0QLqG1a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0QLqG1a"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 424691F00A3A;
	Tue,  1 Sep 2026 16:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788281731;
	bh=CcKuHE1MY+VOLZ2Y+0jjDQcFhLj1YcmPhv+ZklB7o7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=a0QLqG1aHAQg3ckuWWVLplroIZTU72Tcs6bb1wohPN7J6W8CGwlniJA1/LVfZNgsM
	 74sE1iYX/aZ1wiURhtOLNGmMtJh87i5SNBv62Ywjq1GEQROZkaudFZZUHy9EfFBRM0
	 WpmGTgSn/4JPqFrNm+klT25q9L5qame+SC8HoBRIiuSiEzALWdT3nY71YK/pKtWDQS
	 oE8wsnQmSniiMwjbFTp51IYDkGM59WcPpeAUYqrLUO9KQ1TTmHziU4B86g9Y+7trFB
	 MuOuThHbKZmUDKW9opee5y6dv6xVx9vpy7AdIG950wR1p563Sug56kujMhamm1i4uf
	 RLIE5cDEVXrvg==
Date: Tue, 1 Sep 2026 19:55:27 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Stuart Yoder <stuart.yoder@arm.com>,
	Chu Guangqing <chuguangqing@inspur.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm_crb: Remove dead code from crb_map_res()
Message-ID: <apcDfzVRBtwghIuN@kernel.org>
References: <20260901142955.187856-1-jarkko@kernel.org>
 <apb2LdIAqUHROYBt@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apb2LdIAqUHROYBt@sgarzare-redhat>

On Tue, Sep 01, 2026 at 06:06:40PM +0200, Stefano Garzarella wrote:
> On Tue, Sep 01, 2026 at 05:29:46PM +0300, Jarkko Sakkinen wrote:
> > In all the pre-existing call sites both @iomem and @iobase_ptr are
> > either NULL or non-NULL.
> 
> I don't know this code, but I'm a bit worried about iobase_ptr and
> *iobase_ptr. IIUC it is true that iobase_ptr and iores are either NULL or
> non-NULL, but here we are removing the case where *iobase_ptr is NULL.
> 
> Now looking at crb_map_io(), IIUC iobase_array is initialized with NULL
> pointers and the code we are removing was the only one initializing those
> pointers IIUC, or am I missing something?

crb_map_io() sets both to non-NULL value, or leaves both as NULL.

crb_map_pluton() explicitly calls both explicitly with NULL.

If anything else will arrive too crb_map_res, that'd be unexpected
input, which without this patch will go unnoticed and will lead to
undefined behavior.

Not sure what is the argument here really.

> 
> Thanks,
> Stefano

BR, Jarkko

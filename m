Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F7813FEE;
	Tue, 29 Sep 2026 22:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790720130; cv=none; b=aFpo9E7SixRFgApTuMrpN+zy7vtGC2lNOUNjPH0dZHL6AMuD2Xq8RsUnkGEcl7zrpxQbY1aHJ1kiHSsti3+e2Oc83ZYVWUGNCEWMAvs9UueWdeQ2KCa0gA4AioXKAciRn++sQVAWHKfHM8xqhaJPSS+WOOgygbN3VcgafQ0BHwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790720130; c=relaxed/simple;
	bh=8acDcPsK+cbX0KTWUhv/znMzZ0/v3H8paQdGuw8ifPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UZuPsfCf7gbEjY9u0e/0xcs0GWK7mkIBQ2v8FCtjxoAwzTCr70ERY42FHe1wYU+b5l90lvja077OzaoZq/j9Dwrp5CAJOO6iclmb/xKdpPyCu3OjbWURxCH0ll6qzKQpY05jF+/cvsaEU5o1lDZkgGJJdGuMhKDnwfB3dlZxjr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e15oOwR1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e15oOwR1"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 844381F000FF;
	Tue, 29 Sep 2026 22:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790720129;
	bh=Y45OK83vPgyTTlhKLftcNgjZ3rLBQfIkwL1nh19Fpbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=e15oOwR1fNwRWJOBcPNeFTsfqHxcVeV0dzxrrcVRD0ftHWQNoTnQWCH4Rp2i9zSR8
	 miNlMNVctW+71l/oMlNPMc2OHE5y1ovKydrtDWR28vH7U0Uvf5eINe9hnXQK238UIy
	 LwdI8jFi8rd2wYF1+msq1z8TxtkusQ68OQRdqX69YXoMd4o7w1SmS24WdrILkVjz3r
	 IAjeMpOuWeF2MnIT5wA38Hcr7w7C7gTg9Bzv+vvB1sI0sKHySoazA97s5isfLDmtf3
	 JtAUZHscbCQcGhwIFp0+2iQrKBQ9GFjppfXZSoVXBoVn+4GH6E5qOYSw7lMVQ8a/+5
	 l7UdvAktN0CVQ==
Date: Wed, 30 Sep 2026 01:15:25 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Surendran Kanagaraj <surenkj@amazon.com>
Cc: leitao@debian.org, graf@amazon.de, gunnarku@amazon.com, jgg@ziepe.ca,
	joshlev@amazon.com, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org, nh-open-source@amazon.com,
	peterhuewe@gmx.de
Subject: Re: [PATCH 1/2] tpm: Add per-chip timeout for transient
 unavailability
Message-ID: <arw4fd_uzHMFucTz@kernel.org>
References: <arY2qHhjv97W7WvK@gmail.com>
 <20260928195020.27969-1-surenkj@amazon.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928195020.27969-1-surenkj@amazon.com>

On Mon, Sep 28, 2026 at 07:50:20PM +0000, Surendran Kanagaraj wrote:
> On Fri, Sep 25, 2026, Breno Leitao wrote:
> > On Wed, Sep 23, 2026 at 02:28:33PM +0000, Surendran Kanagaraj wrote:
> > > Devices that have different timeout requirements than the TPM2 spec
> >
> > Can you help us understand why this device doesn't follow the spec,
> > and why the quirk belongs in the kernel rather than being fixed in
> > the TPM2 itself?
> >
> > Is NitroTPM a virtual TPM? If so, could the virtualization software
> > be fixed instead to follow the spec?
> 
> Thanks for taking time to review my patches. Yes, its a vTPM. We are
> also working on shortening the window on our side but its really hard
> to keep it under the budget for all the cases. I also came across
> a similar implementation in tpm_crb_ffa which retries a busy TPM based
> on module param busy_timeout_ms. Should we adapt this param to crb in
> general?

Module parameter is generally a bad way to resolve anything. I don't
have knowledge actually why busy_timeout_ms needs to be a module in
tpm_crb_ffa and it is not possible to resolve busy_timeout_ms at
run-time.

I think tpm_crb driver should simply patch chip->duration table and
on TPM driver side we should start acquiring duration values by indexing
that table.

E.g., consider:

	unsigned int delay_msec = TPM2_DURATION_SHORT;

We want to instead:

	unsigned int delay_msec = chip->duration[TPM_SHORT];

I.e instead of adding new fields let's take better advantage of what we
have. I think this issue tells that duration table is underused and
these direct assignments from constants does not scale.

Br, Jarkko

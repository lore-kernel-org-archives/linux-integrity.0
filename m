Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBBF4EC665;
	Mon, 19 Oct 2026 13:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792415557; cv=none; b=Wy0YM56VqqC1qwxQfH9yK/77tURn451shsRzGfSbBvrz+dpDa2Zv0crpjaCIJU2k+KYGLC0k/QejPDvlQhxwuXQBH3ZDKoWlAvf9+x7CHQDVIeL0ejFludbr69l1rb+AYTx8K/8Fb34hqPP8AuYvmWcZB5WwsANDhhVVc/P9LZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792415557; c=relaxed/simple;
	bh=odzFymFz98XdH2rVjddDufFkvKVVlBD5K9QVTchdDhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f2I6Vest4rK2uJecFmVMnxNg4hPOqBclNTOErtFweSHWKLcwVCnl2ikT0I7a268yEn5n+S9b7R51AtV5GEYOjDuOw5EMW4/+xyIYrYaThkczN1trT1BxbnN9JzVl2zT5iudyxSzmCdKD4dyMpnrG93CaSIU6vWKrgIRk+7y9b9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PiJCjhso; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PiJCjhso"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 4424D1F000C4;
	Mon, 19 Oct 2026 13:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792415555;
	bh=PDZO6ZUZ9dPn9nc2jnwVKTXnRmt7E2e4VwZk+WnthNI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PiJCjhsoidTunUUjZJWh1tHJd3EJwms2CTCTo3cv6C1a5tV61yPOfJJ/HUGZBVg08
	 35q7iCZWoPZO+UZD3ijN94IaQ3HCUPXLJnMwkAKbItm8p6nR1fuoGnqx63S7x5d0X2
	 LReB/unyIMvIGupOxmHva33X63TKBPaS18F2sVhyP0i9/x3cCxRQ7n88uJvz+qCdQK
	 gdFJFKDmaU7XJaUSv82240r6pBCXTgrebHmkcS7MFdIh798Sw97r0F9FzAOda8b97H
	 LAGLUKa+c2qpn09CTWcA1SdPcntMVqhi4gozgORbf1a10pTLeB9taOQcnuakLD90ao
	 GPcU8VwAxDSpQ==
Date: Mon, 19 Oct 2026 16:12:32 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Sean Meadows <Hellfire@unspacy.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
	rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
	Adam Alves <adamoa@gmail.com>
Subject: Re: [BUG] tpm_crb/Intel PTT: Late S3/S5/Reboot ACPI power management
 deadlock
Message-ID: <atYXQF68D_SL4fGT@kernel.org>
References: <araNsEodZ3NXf9qT@kernel.org>
 <0e8f93d0-3da9-4af0-ac12-b3670acdcf79@unspacy.com>
 <arw609M6mDiqhQwJ@kernel.org>
 <723ff551-7852-4d57-ab1e-787a1a195759@unspacy.com>
 <asfXObGNaZ9Z8CwN@kernel.org>
 <ca2d299b-4153-4b0b-a60e-7fe64f9dbdef@amd.com>
 <2db92c1a-815c-4db2-adfa-3708152ec8f2@unspacy.com>
 <asqUgaKpEJbo8g87@kernel.org>
 <24255490-d0b6-4793-aa7c-2954bd52383e@unspacy.com>
 <atYWR_DUQlYupk03@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atYWR_DUQlYupk03@kernel.org>

On Mon, Oct 19, 2026 at 04:08:27PM +0300, Jarkko Sakkinen wrote:
> On Mon, Oct 19, 2026 at 03:05:42AM -0400, Sean Meadows wrote:
> > 
> > On 10/10/26 15:39, Jarkko Sakkinen wrote:
> > > 
> > > So the gist why I believe that this might have effect is that every
> > > transmit reverts the state to the initial state. That should erase any
> > > weird state that firmware might be in (usually not that great quality
> > > code).
> > > 
> > > I think Mario's patch is good overall for the stability. It looks to me
> > > that we are catching some weird state inside firmware where we don't
> > > have direct visibility. Or this is my guess at least.
> > > 
> > > Br, Jarkko
> > 
> > 7.3.0-rc6-g587527648af0 with cherry-pick
> > 9154aa6c4b789d23e59d599c330cab2c4e915401
> > 
> > strings /lib/modules/$(uname -r)/build/vmlinux | grep "cmd_ready"
> > Used to validate crb_cmd_ready responses.
> > 
> > The patch failed at 201 hours, on the ninth drop into S3. While this
> > represents an all-time high for uptime, the failure demonstrates that
> > the Intel PTT can still enter a corrupt state.
> > 
> > Where do we go from here?
> 
> I don't know. I'd even consider finding the channel to report the
> possible firmware bug to Intel.
> 
> I don't have resources to do this but getting Windows CRB register
> state captured could help. And then writing perhaps bpftrace script
> to dump the live register state of tpm_crb (because you should
> never trust reading code when you measure).

This leaves room open though on whether Windows does something with
TPM on suspend. Probably nothing but just mentioning for completeness
to point out where there is room for error.

Br, Jarkko

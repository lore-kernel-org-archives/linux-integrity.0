Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD554F55B0;
	Mon, 19 Oct 2026 13:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792415308; cv=none; b=LIVGm8cuxAYzbL+rlxpZCeoJxN/NKf3p221XtmzC1QwOx2HW2kMHNvxp3Q/IlhaZqBmA6JLvKvgDhWmUveS9fqkjrIqYlpFzorP4f63CCxEnXi4qobfFF9sqg/gVorsBFkwSWskdZr3cfTCvOrEidZRkZorRx2rRdJPtksq8ttY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792415308; c=relaxed/simple;
	bh=IwBfwxAh29DHJuu9NUCl5YnXVN2N+Fxj9yfceS4A5yQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WgzNuqoxSFDzPOQM+c8CL4+OIIbi+pcv2wKjwSU9H7aVOkrPLXCgD1+952CIc5kAHCKcZmELoQ5Tovmpniy9f2mhUyMlkmRi5jFM3wOn5t08FsvFsVUDdGksrB97xsN9R9Gx5cETYkJxAmfFmKO63tqTOnxD2oaXHVBBV1zdt/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L8ISjEHH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8ISjEHH"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 7FD341F000C4;
	Mon, 19 Oct 2026 13:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792415307;
	bh=QTzvWFgfqP7K1Kk6a2wMFLHYnkfCLLgQida+/b6KbU4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=L8ISjEHHvggEldLGQ4JNJrkrSX4t9notjC09X9xBxWCz2YeTbXn15Owm6+5JsGl1H
	 M+XrvLkeMoEd7vOjHSc5zapbnecFzEVuFeD1KYrPYumJsgpb/HOqxOonPkILiwMaa1
	 weRRN685ySSnbI1yww+lFTWS3mi+Ix6NwXXjM7JtmMSvGI7LSQ2OEwGoPV6rVP0t62
	 XsAhpBqNeayRSGZ3Vahy9/CSKRFqDd7USEDGbpMtxqtqqPd9GscY4UYTWYkHEK9G0A
	 CXPvdx5bmbN/D3uR0Ulb/JlgX7LWzoajTiRdgTo+/EdnYSEPOPv2NJSOXzFgtstGZq
	 84S+vtka3hj3A==
Date: Mon, 19 Oct 2026 16:08:23 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Sean Meadows <Hellfire@unspacy.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
	rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
	Adam Alves <adamoa@gmail.com>
Subject: Re: [BUG] tpm_crb/Intel PTT: Late S3/S5/Reboot ACPI power management
 deadlock
Message-ID: <atYWR_DUQlYupk03@kernel.org>
References: <54425edf-3ca1-4f99-9166-40f9cc3dfff6@unspacy.com>
 <araNsEodZ3NXf9qT@kernel.org>
 <0e8f93d0-3da9-4af0-ac12-b3670acdcf79@unspacy.com>
 <arw609M6mDiqhQwJ@kernel.org>
 <723ff551-7852-4d57-ab1e-787a1a195759@unspacy.com>
 <asfXObGNaZ9Z8CwN@kernel.org>
 <ca2d299b-4153-4b0b-a60e-7fe64f9dbdef@amd.com>
 <2db92c1a-815c-4db2-adfa-3708152ec8f2@unspacy.com>
 <asqUgaKpEJbo8g87@kernel.org>
 <24255490-d0b6-4793-aa7c-2954bd52383e@unspacy.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24255490-d0b6-4793-aa7c-2954bd52383e@unspacy.com>

On Mon, Oct 19, 2026 at 03:05:42AM -0400, Sean Meadows wrote:
> 
> On 10/10/26 15:39, Jarkko Sakkinen wrote:
> > 
> > So the gist why I believe that this might have effect is that every
> > transmit reverts the state to the initial state. That should erase any
> > weird state that firmware might be in (usually not that great quality
> > code).
> > 
> > I think Mario's patch is good overall for the stability. It looks to me
> > that we are catching some weird state inside firmware where we don't
> > have direct visibility. Or this is my guess at least.
> > 
> > Br, Jarkko
> 
> 7.3.0-rc6-g587527648af0 with cherry-pick
> 9154aa6c4b789d23e59d599c330cab2c4e915401
> 
> strings /lib/modules/$(uname -r)/build/vmlinux | grep "cmd_ready"
> Used to validate crb_cmd_ready responses.
> 
> The patch failed at 201 hours, on the ninth drop into S3. While this
> represents an all-time high for uptime, the failure demonstrates that
> the Intel PTT can still enter a corrupt state.
> 
> Where do we go from here?

I don't know. I'd even consider finding the channel to report the
possible firmware bug to Intel.

I don't have resources to do this but getting Windows CRB register
state captured could help. And then writing perhaps bpftrace script
to dump the live register state of tpm_crb (because you should
never trust reading code when you measure).

> 
> Sean

Br, Jarkko

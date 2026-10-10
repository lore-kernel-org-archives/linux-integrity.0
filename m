Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297EA3AC0C7;
	Sat, 10 Oct 2026 19:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791661192; cv=none; b=IYLE8FNy3vmXzdDjDL7vW3JWJ+iJhNhSmT2utc1jmvZG7NKIUXBzooMNzxPAfQx2cnOu+Xj6ZlkeSiOKlTtttOrE9f7QdiKfurAgtqTCl/6DpA82Ja3lKfXFO2E4KDtWKfq4oPChlAORsI+7l/ir1gkSn7zAcFrfHJqY8n8G1aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791661192; c=relaxed/simple;
	bh=iGMy9enOx+BTKgwp1/8l029b+Wumi67NriI0g300cxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=laTqmrvvPWPRWY3QoBGq41muvLgsUwhSnvU7x+HzRy+KxJtUI1KfQt5ILXrAw76OgkOJEoI73o6XveE182VcJRZv0h3LhLWFUtXh1UqAN7z+b+O8Pt2ME9S6BKaFM1WDotoIqyzLLZKuwDMPKHWv5pIgLX07EC5uEQ04zvrwQ04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aGwVzcXl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGwVzcXl"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id CFC7B1F000FF;
	Sat, 10 Oct 2026 19:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791661189;
	bh=tXbN/9hLFylAPC7SUbP8nwWT95vIm1INIDPcU0xOsCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aGwVzcXl8NLeLivaSQnMQhhNFHEUTRieaOPpEvk0G31Q8Vi9amdD9NQv8TvetUiGh
	 rWm8mYHTLsazo4q7zQV83F2XLanHfkqaoKDW6vqRNfkGay9jpOtdfDI0T6TrNIJ7ka
	 a1g1mZwQwQ7riAOS9ZHVIYXWjOCwevpFAWFIEF42eOboah7Q0n01ldT0qqYynxHuM8
	 FrCuLTrAiPB27wXlXdH8SY9nZRt7R+Di+Y9B9IYwNz5tknMmjNpbMXS5wr9XWjXGzZ
	 1BdJO/ibiYrWkrLSuI7dLuQ1uA2x+971rB2gfdIx0t2tEGjqfYT4oV08SGxXtRD6ik
	 pRWUJ1WljiMxA==
Date: Sat, 10 Oct 2026 22:39:45 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Sean Meadows <Hellfire@unspacy.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
	rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
	Adam Alves <adamoa@gmail.com>
Subject: Re: [BUG] tpm_crb/Intel PTT: Late S3/S5/Reboot ACPI power management
 deadlock
Message-ID: <asqUgaKpEJbo8g87@kernel.org>
References: <bf3a9544-6e49-4d5d-a01a-f1912b717d08@unspacy.com>
 <aqyTpzk3jcarEMVS@kernel.org>
 <54425edf-3ca1-4f99-9166-40f9cc3dfff6@unspacy.com>
 <araNsEodZ3NXf9qT@kernel.org>
 <0e8f93d0-3da9-4af0-ac12-b3670acdcf79@unspacy.com>
 <arw609M6mDiqhQwJ@kernel.org>
 <723ff551-7852-4d57-ab1e-787a1a195759@unspacy.com>
 <asfXObGNaZ9Z8CwN@kernel.org>
 <ca2d299b-4153-4b0b-a60e-7fe64f9dbdef@amd.com>
 <2db92c1a-815c-4db2-adfa-3708152ec8f2@unspacy.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2db92c1a-815c-4db2-adfa-3708152ec8f2@unspacy.com>

On Thu, Oct 08, 2026 at 05:56:10PM -0400, Sean Meadows wrote:
> On 10/8/26 16:00, Mario Limonciello wrote:
> > > The patch I pointed out this in bugzilla but the patch I had in mind
> > > is:
> > > 
> > > "tpm: Call cmd_ready/go_idle for each command transmission"
> > > 
> > > Link: https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-
> > > tpmdd.git/commit/?id=9154aa6c4b789d23e59d599c330cab2c4e915401
> > > 
> > > The reason is that the commit message highlight a bit similar issues
> > > as reported in the bug.
> > > 
> > > Note commit IDs do change in my master branch so best is to look it
> > > up from:
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux- tpmdd.git/
> > > log/
> > > 
> > > Right another reason is that then the driver always the TPM in the
> > > state as it is when the driver starts.
> > > 
> > > I'm not sure about Windows but neither disregard it as sometimes we
> > > do pick behavior basing it on how Window does it. I'd still try
> > > Mario's patch at first.
> 
> Checking my notes, I cherry-picked commit
> 19931faa1d75fb858d86aaf5b0e79d34a2379094, which I understood to be v3 of the
> patch.
> 
> Assuming I made a mistake there, I've started from scratch and applied
> commit 9154aa6c4b789d23e59d599c330cab2c4e915401 instead, which should be v6.
> 
> Once the compile and install are complete, it will take at least a couple of
> days of testing to determine whether it prevents the corrupted state.

So the gist why I believe that this might have effect is that every
transmit reverts the state to the initial state. That should erase
any weird state that firmware might be in (usually not that great
quality code).

I think Mario's patch is good overall for the stability. It looks to
me that we are catching some weird state inside firmware where
we don't have direct visibility. Or this is my guess at least.

Br, Jarkko

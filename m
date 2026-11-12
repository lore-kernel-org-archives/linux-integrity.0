Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794518218;
	b=SLbdb/DZUhTBfW5znhieU4bmVnV/D9kxjg53MEmTVrwgd0M2l1wouy766lg3A1JAHQYJ
	 x1zaRiCCPi6aGzqNtdRdtlhUbGAmmRTahw1fQDqOXdohoR2rEeVgo6VFKb88rgE0eAcba
	 aCoVJkGPLLF71cq9zBDU8+vaqwG3rBm7KeNqT/0j3omKR3XqVsGc9KS7R3HmkssMl8tdU
	 Kgw1iGaYdZrqRh4pSVs6it2Vf2cyyZUeByBQHL98zpT5xSQ8ws/PiOkHoBUx8uoUtKpLv
	 xKYiujyzvPlaHg5VriSfGZfbTRfeCRtGcIVIcnafIjz6Qt/Q8Ly9PRbUZC1/VmJRo0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794518218;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ujAk93P/ddstQytFXysbnpeTSxXJ6wzE0WB+zGhu9MM=;
	b=bPLOBf2o/foZHI3R3VYLZYLf4VyfTjut2GwWO19qT7aRytAv19fTfpBI1PFfAV61sigF
	 hZy9yzrtgKy/L3PzW7Kj80av7D3YEedT6oqXlHa6p/shoK18IafNOL0+iSsYGwIDtKeuR
	 4ehdBxx/xR9ztkzQPYe7xeBdtj14kLHrT50P3sgFKfdStOna1UyyF13rxoCmlM/OlgFeh
	 dgbncajXeskgaUrbaLyl79PgIVJY5YFBh2CLlt1FLl2Nme7KHO+KCqs/oVWuyz0KAalJh
	 1HOhzWnFllC7BQAVFfmAfyMTkcUAdL694YkSc+U9KIh917WGNLnOD/uYDlZABjeSjwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q2AIzMHN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 18CF4606A31C;
	Thu, 12 Nov 2026 21:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q2AIzMHN
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 494A61F000C4;
	Thu, 12 Nov 2026 21:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794518217;
	bh=ujAk93P/ddstQytFXysbnpeTSxXJ6wzE0WB+zGhu9MM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Q2AIzMHNEp3I/jGwubmY8egi2bg2yRWTrkGD/HAESxPdlHnoRYBueLdaVQco/jIAA
	 IMvMc2Ha//HdfmlOGkAD/hwzNL6Ys01P/6ajcIQbcSP+7cFs2FHdSveWjIP+BBU/4Q
	 lu/2xPhs+vOw6nS0B6AkrdKVjmFtrxZ10XiuRsdajd6UPgbErzyXVEGHmvjlHkVXAK
	 porXyBqijrCZ40+T8I3FHS6htUL5A5q+AYQO3cCc20gwnGfxx4e1Dzyf9qxaB7N5j6
	 DCH2h+TONle2biSeBjx46ykCfNWu4odzy5EXFOWbvh2480WDEapaDkv4sxTWync6Wr
	 hmWKSuZMKLjSA==
Date: Thu, 12 Nov 2026 23:16:53 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	surenkj@amazon.com, noodles@meta.com, kernel-team@meta.com
Subject: Re: [PATCH v2 1/2] tpm: Disable a TPM that stops responding
Message-ID: <avYsxRFYV17WzX5c@kernel.org>
References: <20261112-tpm_unresponsive-v2-0-7454d2c899ef@debian.org>
 <20261112-tpm_unresponsive-v2-1-7454d2c899ef@debian.org>
 <avXGjiejK2ZlldKs@kernel.org>
 <avXHGmmdY-CVgxEf@kernel.org>
 <avYkGKXOP2-hhewz@gmail.com>
 <avYqgDjJYw-UjaZi@kernel.org>
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
In-Reply-To: <avYqgDjJYw-UjaZi@kernel.org>

On Thu, Nov 12, 2026 at 11:07:16PM +0200, Jarkko Sakkinen wrote:
> On Thu, Nov 12, 2026 at 12:40:45PM -0800, Breno Leitao wrote:
> > On Thu, Nov 12, 2026 at 04:03:06PM +0200, Jarkko Sakkinen wrote:
> > > > 
> > > > This would be then nr_lost_responses.
> > > 
> > > Oops sorry.
> > > 
> > > I mean nr_missed_responses (and I would prefer "missed" over "lost").
> > 
> > Would you hate if I go with max_missed_responses?
> 
> It's a great question. Here I think asymmetry defines things better,
> and makes sense also few months from now.
> 
> So I think this would be most consistent:
> 
> 1. kernel command-line: tpm_max_missed_responses
> 2. tpm_chip: nr_missed_responses.
> 
> The first defines the modulo and second counts up to that.
> 
> Can't recall (and too lazy to check) how it exactly was in your code
> change but I would formalize all this along the lines of:
> 
> 	if (!(++chip->nr_missed_responses % tpm_max_missed_responses)) {

Ugh, sorry that is broken as hell :-)

I mean:

   if (++chip->nr_missed_responses > tpm_max_missed_responses) {

   }

Probably was already something like similar anyway in your changes. I
just wanted to highlight how the naming makes in code-level a lot of
common sense...

Br, Jarkko

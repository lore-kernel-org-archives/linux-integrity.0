Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793043178;
	b=i4JEv7SPNRtRcAm6pPTpWUe5IH6OjGl0Mo+qWDpMKcTk2EE0JWUDdwLSsaNcFsVMENU0
	 hx4onMEeA0l5v5HkeIxBR96uZbEMcRLuNkSjuxCy6EA75RVOjgMaujMLMiddN2W2V0di+
	 DYTPSFD8F+/qOnN5JEA1XXQtKekBA6mBBBIMFvoV1aUA15u4H24jstXeF1iUv8guyv0jD
	 DNNu9QBwBg2xtAyCMdNNHMcnWtcrIVKfFizPWuxw1mlr80vTyMhmamqoxtszdMlnMERJ/
	 1lDI8YLVC1zGub/tNxo1BLlb72n4FSrmeHHaNxlUg2iki7p5eR+t4/IpHtehtTkrvOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793043178;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=LcVgbP/OWL1u/yAYMGvZfj5yrZNF0qq/LaBt6eimjFE=;
	b=NiQFx12HXaS+aUutA7khBHlvHscIO6k7cou1iHkMJBdFRs3Dya/Og9+zbfKdyJmsL2a+
	 aUfIRdVQ9f4pzzvPCT9IdXG4ltNdP/AgsnlZfXw65mViPHx9am9UvLGpsbjn4jc/5Tx7v
	 VCRjVpHTvWlJDLd1FxIO4DpP8ahZG/9ENOk2xw3Ka4ghQoIdeOnVneVSqPUAt3XZwLgdZ
	 KLWzmVefsX9b50Bzng6zc4BUAj/GGAtN5LsAePyYrE0Yx8rX1vVHJ/JgDCHNbm1Q1HEkp
	 le+nojQA0IIAz4hZm87lxir5rQJNrAORTmq7gk1E/+ulK2LBITVZiiSF8Xw00+3cMsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j4PW2Iy1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id B198A606A31A;
	Mon, 26 Oct 2026 19:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j4PW2Iy1
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id C01B21F01825;
	Mon, 26 Oct 2026 19:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793043177;
	bh=LcVgbP/OWL1u/yAYMGvZfj5yrZNF0qq/LaBt6eimjFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=j4PW2Iy1TH02ftfx5zdmu9bL133z5vHTyMnXz8WpZVz4T+DGVwvL4yHyUxzXbo+xy
	 wX7gk/yjYmpOQO93BMUq1qyd9w1jE86VBS/meEEd4CnM2IEi5J0BRpS+PZBDR3PBqj
	 0r004qVCUsZsRYHmk9Q/UVg8DbwRV7EUK44GtbDWY9lUH7uTeJ3onTYCwKMW04gHYJ
	 0nKcDHwnhEV6rz70WaRlHoZNtW4TBuKVBZqgD8UR4+tJGuBybXuWbS6vdomSS8x6B+
	 xu2qgqWy4gk9qTCt7w48vvlpDq3oDdLYEyHFsKWxnYa4V+r8s/BuxJUmVVGQrKrRXG
	 VJiWaMdmp+qhA==
Date: Mon, 26 Oct 2026 21:32:53 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Arun Menon <armenon@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v4 5/6] tpm: Increase TPM_BUFSIZE to 8kB for chunking
 support
Message-ID: <at-q5WanCcf_DFb5@kernel.org>
References: <20261025201859.221991-1-armenon@redhat.com>
 <20261025201859.221991-6-armenon@redhat.com>
 <at5tmTYX7ZjO_Q2m@kernel.org>
 <at5t-u3h1sHGJFmk@kernel.org>
 <at9j8iDp2ozx9y5z@fedora>
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
In-Reply-To: <at9j8iDp2ozx9y5z@fedora>

On Mon, Oct 26, 2026 at 08:00:10PM +0530, Arun Menon wrote:
> Hi Jarkko,
> Thank you for the review.
> 
> On Sun, Oct 25, 2026 at 11:00:42PM +0200, Jarkko Sakkinen wrote:
> > On Sun, Oct 25, 2026 at 10:59:09PM +0200, Jarkko Sakkinen wrote:
> > > On Mon, Oct 26, 2026 at 01:48:57AM +0530, Arun Menon wrote:
> > > > From: Arun Menon <armenon@redhat.com>
> > > > 
> > > > The size of the command is checked against TPM_BUFSIZE early on before
> > > > even sending it to the backend. We therefore need to increase the
> > > > TPM_BUFSIZE to allow support for larger commands.
> > > > 
> > > > For now, 8KB seems sufficient for ML-KEM and ML-DSA algorithms and it is
> > > > also order-1 safe.
> > > > 
> > > > Signed-off-by: Arun Menon <armenon@redhat.com>
> > > 
> > > In what timeline? Or is it out of spectrum timeline?
> > 
> > "For now" part concerns me and I'm not educated enough on topic to
> > know better.
> > 
> 
> TPM_BUFSIZE needs to hold the largest command the stack will ever
> build. TPM 2.0 Library Part 3: Commands, v185, adds ML-DSA key
> objects and the ML-KEM TPM2_Encapsulate()/TPM2_Decapsulate() commands
> (sections 14.10, 14.11) [1].
> 
> NIST FIPS 204, Table 2, gives the sizes for each ML-DSA parameter
> set; the largest, ML-DSA-87, has a 4896-byte private key and a
> 2592-byte public key [2]. Loading an ML-DSA-87 key pair carries both
> (4896 + 2592 bytes); add the command header, a handle and a session,
> and this comes to roughly 7.7KB. 8192 covers that with headroom and
> keeps the kzalloc(TPM_BUFSIZE, ...) calls in the TPM stack at an
> order-1 page allocation - something I figured after sashiko review.
> 
> This is sized to the largest parameter set defined today, not a
> timeline, and there's no guarantee it stays sufficient. For example,
> FIPS 205 (SLH-DSA), Table 2, already defines a 49856-byte signature for
> SLH-DSA-SHA2-256f -- six times the current buffer. If a future
> algorithm or parameter set needs more than 8192 bytes, this will need
> revisiting again [3].
> 
> I will add this detail in the commit message.

Thanks!

> 
> [1] https://medias.cdn.trustedcomputinggroup.org/production/Trusted_Platform_Module_2_0_Library_Part_3_Commands_Version_185_pub_87a5c10230.pdf
> [2] https://nvlpubs.nist.gov/nistpubs/FIPS/NIST.FIPS.204.pdf
> [3] https://nvlpubs.nist.gov/nistpubs/FIPS/NIST.FIPS.205.pdf
> 
> 
> > Br, Jarkko
> > 
> 
> 
> Regards,
> Arun Menon
> 

Br, Jarkko

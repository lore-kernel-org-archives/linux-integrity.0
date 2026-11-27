Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795822219;
	b=KJXTW1g2dmO6sxwxXF2QWtcYAbBcwf8KPgYu6Rw3aCPARkefKi8I6qyMuP5gu3OKKIjX
	 t0rlpOKlLXUAOcDhegXAfqKDU/xM5ULz3FvI3vxpHCTX73CYPsuAnvOqslWrYcWhRSXfR
	 l09A7wCwXSYtR1VwrNYHpXxbE5wGNT8IWFPlLGkcrz8qFG3YSQL6E27u9MktDncD9JLub
	 FXUhp29cYUWhCoccoTZWATysMMtc3bpbE7DfQo65O8x/nJ4D3JBuNrkcb2Wael5SqdN6S
	 d6M0/KNlwrKmS5sWrQ3oNVFDXTZ1FuwawsAPD3Vd7BABa5xPz75yOPlp4o9Jpq57DOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795822219;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=LTbOmtY1jVypodoG90MeRsudgDy75kX7Bk9EACSq0as=;
	b=DGdl25kzvxLnag49FmZAiffNqjg7izBsH35g85LUIpFbrib8+iGMXvx8aAwqJibON1LO
	 U7H2CXXa+XoLYKvnwqU9cztFds7BMtj+jLAhzvE8pWkMdrjc+dCvH0myFuQiSMKtdJqw6
	 HuJe20Twaczu9+XJj97+qPUjRQ/UvECXaubpSMmkUc8ULQXxIJaRgiYm6duL8417f2KsH
	 WUxTia+WrLm1hN89NFvFdGJ1fbwp45r9mfcJVbhVL9EGjLmzZ7TVewTmHhkBbnx2z8VWy
	 pI5mYGczPWJMsNBLYVg9dBDhZBAhlUkUwGuxTc17P4ewgeYugYzoAk6vOM2gbxW+5Lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AqbEN0UX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 4E302606A32F;
	Fri, 27 Nov 2026 23:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AqbEN0UX
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 358831F00898;
	Fri, 27 Nov 2026 23:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795822218;
	bh=LTbOmtY1jVypodoG90MeRsudgDy75kX7Bk9EACSq0as=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AqbEN0UXHIqreMF8Bdnfd8UqtRAVPkSAQIGTpsVb2SNyBPbf/yS0hCXKf2fwnMIsd
	 LCM+9KMnh/yfA7Ud2syvlsZrbUFB4a94IYumVUjZYSC1tH0IiA+3WOvwzGlVdgmFFd
	 NhOjTWt33x+bkobqiVV4PCLpeN7agZjuymNY1KidcbbmNGNpySs8H+bzV5NgrGP/F+
	 4B+jjXllArcfx1RWbclkKK3DgjtFlEysOcsSSqKn9b3lO/XSsk7KD4/Ir7mXzy20D8
	 xmAIdoPQF501f0NGH8+55Xt+3ZFNC0uTePP5Y+v+CSIaYb0DGRcCBSu4RH3Nnvmt+X
	 fVia2TT7fZ8pg==
Date: Sat, 28 Nov 2026 01:30:15 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Surendran Kanagaraj <surenkj@amazon.com>
Cc: corbet@lwn.net, graf@amazon.de, gunnarku@amazon.com, jgg@ziepe.ca,
	joshlev@amazon.com, leitao@debian.org, linux-doc@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	nh-open-source@amazon.com, noodles@earth.li, peterhuewe@gmx.de,
	rdunlap@infradead.org, skhan@linuxfoundation.org
Subject: Re: [RFC PATCH v4 1/8] tpm: Add a single table for all TPM wait
 limits
Message-ID: <awoSh_ke8Si3Kxvf@kernel.org>
References: <awiCQCU-h8MQc6bQ@kernel.org>
 <20261127222347.92729-1-surenkj@amazon.com>
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
In-Reply-To: <20261127222347.92729-1-surenkj@amazon.com>

On Fri, Nov 27, 2026 at 10:23:47PM +0000, Surendran Kanagaraj wrote:
> On Thu, Nov 26, 2026 at 09:02:24PM +0200, Jarkko Sakkinen wrote:
> > On Wed, Nov 25, 2026 at 11:00:34PM +0000, Surendran Kanagaraj wrote:
> > > 2) Keep the chip durations in a union of TPM1.x and TPM2.0 durations.
> > >
> > >      union tpm_durations {
> > >              unsigned long tpm1[TPM1_NUM_DURATIONS];
> > >              struct tpm2_ordinal_duration tpm2[TPM2_NUM_DURATIONS];
> > >      };
> > >
> > >    struct tpm_chip holds the union tpm_durations in place of
> > >    chip->duration[]
> >
> > It isn't possible to have single struct tpm duration that is partially
> > used by TPM1?
> 
> Yes, that should work. Something like this:
> 
> 	struct tpm_cmd_duration {
> 		/* TPM 2.0: command code or TPM 1.x: duration class */
> 		u32 cmd;
> 		u32 duration;	/* msecs */
> 	};
> 
> 	/* in struct tpm_chip, in place of chip->duration[] */
> 	struct tpm_cmd_duration durations[TPM_MAX_DURATIONS];
> 
> eg:
> 	/* TPM 1.x */
> 	chip->durations[0] = { TPM_SHORT, 750 }
> 
> 	/* TPM 2.0 */
> 	chip->durations[2] = { TPM2_CC_GET_RANDOM, 2000 }

Hmm... in theory TPM 1.x commands could be "normalized" to have same
format. Is that because of sysfs files?

> 
> Does this match what you had in mind?
> 
> Thanks,
> Surendran


Br, Jarkko

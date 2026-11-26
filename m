Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795719749;
	b=S5rDiuAbfkK2zxCKoWQ0p2BnjOIsoKKBEZvvybnkhvVLWJfF0KWepHholJrMAMKcjaH3
	 o8KDwy/nhoPujbBfju1chqHnAq8vnE3GDhkZ0bDF9Ito7e2pAWH/yeYflgH7UQ2aZQ4VJ
	 SdTcbvEB0h68yV3e8gWGCf9BQ1lbvt0TpCWVCK/t7c6j+Koc2468kJ53W9ENE/VibfXy4
	 4DVMBDAizBNRm6at322NDwLTCBjMjvod3Dk9WaxpeERUmHjKQBfNc5wM9y06Oe4OyqFkR
	 r0c4L/r3RMI9ZFtjv7twtAm+EbaCkO0xg197skE+f+NXghOjij+0lg7C58BjL2h/fuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795719749;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=sgsm41cVrYVXRN/ZczPr+NXSABYCL273lk2seEqIQI0=;
	b=DFwrZZnoHNrcGeB0476RaJ/D0iDpDgS2HAXY9qXGrX33f5+gS4X4n6tniBawWH5WCV3G
	 UaehvHkr36QgxamMv/+5Rz+aTYoZQC422a1uN2Wj1LWh19KxDUtHnZoRwpFLw64/+MJCq
	 x0ZH4DcxxIBJruk+N5tIDvvfvk0EYWkImDlJajq+xczYMlLTHIE6l2HlCcmtMYQlhoa+G
	 vMk9bmk4D7e9jk/tJo9+2mfAFtpuiRNJAgE8upKsp3N17yEptiJk+2K5+/S5Wu0aeXCgw
	 FMeX26F6L5ZVxwVdnB5JA7iI6h24S8nrSyb0MkWtOU6juoeD8eQRJ8UnkHb5kIMQRzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fh+ol2ez;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 13C7D606A31C;
	Thu, 26 Nov 2026 19:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fh+ol2ez
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id D27131F000C6;
	Thu, 26 Nov 2026 19:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795719748;
	bh=sgsm41cVrYVXRN/ZczPr+NXSABYCL273lk2seEqIQI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Fh+ol2ezWUjyMhmE1tsESBXMONPu3gXFMuSY5sDYEdFAddpNy5P9x0P+dBQFZGML8
	 b5VQRb6ASyBFBPVSoTjO5jqaWR7ArsBc/+KdYqv0FCmoMKZH5LMGl0ABaGVVM/fyO1
	 rC1+BTag7S4+/Vu5SCqt00RtywNl+YAlY2cL1bfwvHNfD/3LvCVa+caMCVgrUfNUh8
	 Yn0LqIMceBO4G7GyJvbsgTqc8Azw/UnHzQKLSVfp51j2kdJjs5HDy63u5pjq9BjLLW
	 k4TYGBqvyb8w/9LhZJqerxeQzjmBViT6ImiFNR9fRVF7Or0Qogqtl/6VW3yaiAQ9P3
	 5ltYe/aTG/g9w==
Date: Thu, 26 Nov 2026 21:02:24 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Surendran Kanagaraj <surenkj@amazon.com>
Cc: corbet@lwn.net, graf@amazon.de, gunnarku@amazon.com, jgg@ziepe.ca,
	joshlev@amazon.com, leitao@debian.org, linux-doc@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	nh-open-source@amazon.com, noodles@earth.li, peterhuewe@gmx.de,
	rdunlap@infradead.org, skhan@linuxfoundation.org
Subject: Re: [RFC PATCH v4 1/8] tpm: Add a single table for all TPM wait
 limits
Message-ID: <awiCQCU-h8MQc6bQ@kernel.org>
References: <20261118073852.81107-2-surenkj@amazon.com>
 <20261125230034.24726-1-surenkj@amazon.com>
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
In-Reply-To: <20261125230034.24726-1-surenkj@amazon.com>

On Wed, Nov 25, 2026 at 11:00:34PM +0000, Surendran Kanagaraj wrote:
> Hi Jarkko,
> 
> On Wed, Nov 18, 2026 at 07:38:45AM +0000, Surendran Kanagaraj wrote:
> > +static const u32 tpm2_defaults[TPM_NR_LIMITS] = {
> > +	[TPM_LIMIT_A]		= TPM2_TIMEOUT_A * USEC_PER_MSEC,
> > +	[TPM_LIMIT_B]		= TPM2_TIMEOUT_B * USEC_PER_MSEC,
> > +	[TPM_LIMIT_C]		= TPM2_TIMEOUT_C * USEC_PER_MSEC,
> > +	[TPM_LIMIT_D]		= TPM2_TIMEOUT_D * USEC_PER_MSEC,
> > +
> > +	[TPM_LIMIT_SHORT]	= 750 * USEC_PER_MSEC,
> > +	[TPM_LIMIT_MEDIUM]	= 2000 * USEC_PER_MSEC,
> > +	[TPM_LIMIT_LONG]	= 3000 * USEC_PER_MSEC,
> > +	[TPM_LIMIT_LONG_LONG]	= TPM2_DURATION_LONG_LONG * USEC_PER_MSEC,
> > +	[TPM_LIMIT_DEFAULT]	= TPM2_DURATION_DEFAULT * USEC_PER_MSEC,
> > +};
> 
> The TPM2_SelfTest duration bump [1] made me realize that mapping the
> TPM 2.0 durations into these TPM 1.x style classes may not hold up long
> term. A spec update to a single command turns into a change that
> affects all commands under the class. I think it is better to keep the
> existing maps as they are and let the driver modify the map if needed.
> This is also what you suggested in commit 207696b17f38 ("tpm: use a
> map for tpm2_calc_ordinal_duration()"): keep a per-chip copy of the
> map and let the leaf driver patch it.
> 
> At a high level, the series would become:
> 
> 1) Set default interface timeouts and duration at chip allocation.
> 2) Keep the chip durations in a union of TPM1.x and TPM2.0 durations.
> 
>      union tpm_durations {
>              unsigned long tpm1[TPM1_NUM_DURATIONS];
>              struct tpm2_ordinal_duration tpm2[TPM2_NUM_DURATIONS];
>      };
> 
>    struct tpm_chip holds the union tpm_durations in place of
>    chip->duration[]

It isn't possible to have single struct tpm duration that is partially
used by TPM1?



> 3) update_durations() now gets the union which TPM1.x and TPM2
>    drivers can adjust.
> 4) Show the durations sysfs file for TPM 2.0 chips.
> 
> With this, I would drop the limits table, poll APIs and tpm.limits=
> parameter for now and keep the series focused on duration handling.
> 
> Does this sound reasonable to you?
> 
> [1] https://lore.kernel.org/linux-integrity/20261125182251.19360-1-surenkj@amazon.com/
> 
> Thanks,
> Surendran

Br, Jarkko

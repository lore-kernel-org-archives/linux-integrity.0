Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794663004;
	b=mQfgQHmtrATTIF7WjujGlbz6Axalp2nwsvS0p8QWqzXo/YxJG6ZaKcL/1DAA1qJfxXJZ
	 gE6Kfcl69pI9Z73t3scf6FvaJj8peHxF0kDwbDZ8x3bkJndAN1d69DdZcRv29LxAWdLSK
	 C9UvEy+T+5VSAFEiDK/U+H4p30ikaisafiSdqWjnbJyzqA1sdDQFWxQg27SRT97NJgseb
	 3qbZTPN5WlXZ4N0BHad20LWj3m/DqWvksoXq0aIcsmTsOqYbRpEXpfO3/CKw/PobgW7fW
	 gLVWJOw2kKXZSu4jznDVVXQyXK4Zls/r+bvcfG55QKai063lu8cVXI1JR9F6iTYMyIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794663004;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=PS9TvDBXQVtQgMTEtAs1iIarDWFkdeN/XOLD113yD88=;
	b=BPsf10eYewZKIq8gMYWmPRrPrypMHX7at7sjzgGzlYe0ArGCrEv9jg12SAvRoZIc72u2
	 GLXk2CkYw2oTZrq9/uAzPIemgXKLnR3ff8pFzpUfeEQaWVwEn/Eh6bO7vZrIN3nQWFJV2
	 7+80gnG4G044WRSE6LP3A6kuLFNpCyXe0wW5z0jd8RinyotZAQrafdX9+YldGXrbDMJ11
	 o48GkSUSUW+uBADHzVpgB1E/m6Us7/Mz1g2Us2EaTgRU4ZIWx+N0sBtxqY5P56yHIcYUP
	 eEGwEAPwgdd1nauOCl8VrdCIzfMG5+LIuodsEhi+z39nthmJFFkGLUZb+x/fbCftadg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KvClaJWh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 0B808606A32E;
	Sat, 14 Nov 2026 13:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KvClaJWh
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 845251F000C4;
	Sat, 14 Nov 2026 13:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794663003;
	bh=PS9TvDBXQVtQgMTEtAs1iIarDWFkdeN/XOLD113yD88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KvClaJWhSIR9vVBtdHnMtb2blz2H09Y2HN6qkcsTB0GLfMfnqmo9P+NULK/Wm/Jod
	 4qMRvxTgpsQmtHy6TJamU4hWn2wdPPY1xC6qfU3S6neZEILxtkCGR2J1fjg+ghlLpX
	 pH5RA3JZNcQl9BgNovLaeLJjBqmzUUmFtqWYQT/nZR1ucLhSQcEbtMLcU0tzVUoW2g
	 Q9mfR0FyoOExlQh+yUesJqww3oUV8lA0KclamByohK2fIpK64Jj9VPHCWxdrLnNIce
	 EDVT91anK4CzAShmeX8GINEgVHF/eU3WwmN56PZuuMVG5b/uhOliWO6MxChywNEuWU
	 znmQ+Xu8NWckg==
Date: Sat, 14 Nov 2026 15:29:59 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Surendran Kanagaraj <surenkj@amazon.com>
Cc: corbet@lwn.net, graf@amazon.de, gunnarku@amazon.com, jgg@ziepe.ca,
	joshlev@amazon.com, leitao@debian.org, linux-doc@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	nh-open-source@amazon.com, noodles@earth.li, peterhuewe@gmx.de
Subject: Re: [RFC PATCH v3 1/8] tpm: Add a single table for all TPM wait
 limits
Message-ID: <avhiV9fU1FbIC_ef@kernel.org>
References: <20261112163846.97654-1-surenkj@amazon.com>
 <20261112163846.97654-2-surenkj@amazon.com>
 <avdoybHEoRd0Fhie@kernel.org>
 <20261114091222.32721-1-surenkj@amazon.com>
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
In-Reply-To: <20261114091222.32721-1-surenkj@amazon.com>

On Sat, Nov 14, 2026 at 09:12:22AM +0000, Surendran Kanagaraj wrote:
> Makes sense. The quirk table is just a convenience, a common table fmt
> for drivers, and the chip still owns the table. Without it the driver
> calls tpm_limits_driver_set() for each limit it changes. I am happy to
> drop it in the next rev.

Yes as a general principle optimizing here "data redundancy" at the cost
of more complex code does not pay off. 

> 
> Thanks,
> Surendran

Br, Jarkko

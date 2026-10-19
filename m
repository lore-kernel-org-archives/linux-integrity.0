Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792435520;
	b=XSuDIEU6wIYsgz2Dac4MSkaZZ2hYOBlLLaWw+ZdcKx/yLGynvdZ3ZEwq4g8x+wSRldml
	 NLYSWacCj8eHFyX23PIo6Ti8cgV79y3uRwH+WFWsqmZYnCMQ+9wX8BHGes+SK32qit+WV
	 YtTj1bJPd3vlJkXGucnzFkaUaa1hPUo801aDAZjToomS4XGrCoBpYCDmQ/SwFOvh1sw+w
	 VSylKnk6i9kf5vWjzO2CIRM08EWIGWQMioN92ZZpejaPHUOAO49QIKtdHlynDqPejtmzM
	 FtNWSigerfIAPul0j0fmUtYVwu6ac+lUrSzm/r0RmwQ/B1wRtIeZLnA8Af0a1W9yQjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792435520;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=s/T1s2CCsEuXrYo/AzxbOqCnGIG9SfM4k94mbOT4AhM=;
	b=Jz5ARxc60D3l25gMQ267KUJ/kWpm4bV5+veYhKANdW6k5IinAluI03kI0GWVo3pWtg7v
	 ankFCw7Rw5m7hUuXX8WwqH/i1MdYAHBpwusaXCNnpOR++eIc9IAlMd3HiRoLXK1bX4OPL
	 lT7j5oUodJlCaTS/e1KBRsNXm5q4hnfrCvNr7iJP5esBxnGEx6hH7+uUJLVN2MggC/qXN
	 yYFUGzKyVqUhWgdVOCKutOdw7dqfteejAorIpxAMcbPQaCO4UVPK+XypMYlh5XD+MgGhY
	 5qskrqU1uH/BlCqkwoIriCpTtshtVrzIt9UCcLpTPvumAPRPNvQqbIGukcjpq0fx+Bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IYtfNyWG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 47E4B606A336;
	Mon, 19 Oct 2026 18:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IYtfNyWG
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 706B21F000C4;
	Mon, 19 Oct 2026 18:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792435520;
	bh=s/T1s2CCsEuXrYo/AzxbOqCnGIG9SfM4k94mbOT4AhM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IYtfNyWGw4IkQIy02rLV1L4maOIJuFFtDG3+XEGznH16h3EwTH1MpKmxxgCIFjwu2
	 jqG4t7jskr0xIzqQpiP/OKVwNLbsf4H/wNUFI2MkuM1m9rrfM8VEbBmtugB7Z3E1UR
	 M0eGi/QXoZGTN2/UqqgSAw9RdZW8rrgJ1VMGbM7g0QEiR9vH62Ipw/eM+wx2na5ZQu
	 1lVFTQIKrBDNMG0f20jnIgnTx3VQm400RqhB4XC1JUL/LWaQ+EndhoI31kNcisYLkd
	 AeY0OwjIhkgAK5x/ATNWAXqt5Dxxg3yHFjfq0mnPWAkbrCxf1FmWbfUymLB35ILQ/g
	 rlBv8sElQMSUg==
Date: Mon, 19 Oct 2026 21:45:16 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Surendran Kanagaraj <surenkj@amazon.com>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org, leitao@debian.org,
	nh-open-source@amazon.com, graf@amazon.de, gunnarku@amazon.com,
	joshlev@amazon.com
Subject: Re: [PATCH v2 2/2] tpm_crb: Raise durations for Amazon NitroTPM
Message-ID: <atZlPHQH9c4akiKl@kernel.org>
References: <atLD-d1v1B8ARv7x@kernel.org>
 <20261019182713.57308-1-surenkj@amazon.com>
 <atZjPERR854RL0Yk@kernel.org>
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
In-Reply-To: <atZjPERR854RL0Yk@kernel.org>

On Mon, Oct 19, 2026 at 09:36:48PM +0300, Jarkko Sakkinen wrote:
> Yeah, this is also a theme, as generally the tone of kernel development
> has changed to be slightly more intrusive than before in the sense that
> addressing architectural issue is often better strategy than doing
> minimal effort as per code changes.
> 
> This is because it is the way we actually decrease the LLM bug fix
> activity. Implementation mistakes caused by the more bullish approach
> has factors lower price tag, if it can affect the rate and density
> of LLM storms.
> 
> This is why e.g., I've put out a patch set that departs assoc_array
> from kernel, and replaces it with rhashtable. This way we destroy
> nests instead of mosquitos.

Within limits and not over the top of course but like if something is
not working out for you look at one factor more generic problem and
solve that. This way many quality issues get gradually addressed
and it is actual antidote for LLM infections :-)

> 
> > 
> > Surendran
> 
> Br, Jarkko

Br, Jarkko

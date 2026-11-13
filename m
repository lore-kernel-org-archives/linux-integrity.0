Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794584419;
	b=PuuIpMs83IwD7DrBs5Jn45uYclmFTm4Qgs1QIBQaIgO3I6PYc9TgPGAv+XDBlUAfQi+3
	 BrELHovcbODsiH4UBCxQf2jZW/HjxoiXAoqAS1m2F1ObKeC+tVXnuTl4006iOklP32ssb
	 iMfBwkA9X65W73+ar//GPqTAPy4xsV2uoSJsOLmaAST7hIBeyJ/jxOxTXwr/3j/IbY8x8
	 Acy/ujcBjvYCOJhAg9vBq7Mo24U1+4Fnzu7+d4mJZFocWQY9Nr/BR/uMSFurBfjA6VPGI
	 Z8WI8kTwgl8j3FHYHr+nXWcwDMMzW7ir3t96Bb0DSWlXj9Z0+xpaQ5hhFB1KV4GK91Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794584419;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=mHchkc+i3m3/kNWz27BIotBWVw1HxYTF3vT+5QXs7GE=;
	b=1jj0Rrf6z1Iqg60s8GYgPPjbqCYU6pR4FVK+mfUY2FrXc8vSmoFD0mM2NT0XzIO30mcY
	 PLHUVVbbh61W6Xp6bxyCRVob5sAU4GTyXhrlTvhj+z2iqrRZeXknMKveORlMYRo7psGmW
	 hQMbYhd8ikbM6e1uGLs+hRg5qj666dSOMAuANoB69VoaLkWvkDjh1FUyfh/ITgoB/0/hW
	 w3JF69bya6vIS3XCZ6n2b3ZEEz76K/pmiIlwK3bARj10c9G4qfaSBt1sQmJVCSe8lldxW
	 LbzD+AXBHkLIoBl2DqxM+yZmR8BIdMFAnVfMz8ITtOEaCtHOSZSeCn23FoITQBAUkOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=adzkssnM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 29D54606A323;
	Fri, 13 Nov 2026 15:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=adzkssnM
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 761881F000C4;
	Fri, 13 Nov 2026 15:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794584419;
	bh=mHchkc+i3m3/kNWz27BIotBWVw1HxYTF3vT+5QXs7GE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=adzkssnMniVs7TpMNzEjl8mo34JNiD/1UXooZX4wsir8cA6AmaikpgyofXf9s3FjS
	 JXL1PunfRzx57sJxVWAndSGYtD0wGX0suiG4wJbDcIdVmtpWSIq7hm5biF5SKMg5Cm
	 SAkz16fstIAIoJgf4pCnxK6nNIfF8J3kU+zp5yiS/GK0mwfTe8rcO8SsIfKDW2FzDb
	 CQgsZUbF1vkWSFKVMZOQVuvht+7Kburln9JPxB2oqC/T3hQMyLiZ2JgghY54UYigbX
	 tXE2yixc2uyni8SpqG5AKMJMH2deAV58TSwZ39CCWhO6KNSMw1ezFy8lq9D6v2LXsP
	 cJ1o7T4ynTL2g==
Date: Fri, 13 Nov 2026 17:40:08 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Breno Leitao <leitao@debian.org>,
	Stefan Mahnke-Hartmann <stefan.mahnke-hartmann@infineon.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	surenkj@amazon.com, noodles@meta.com, linux-doc@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v3 1/2] tpm: Disable a TPM that stops responding
Message-ID: <avcvWJMidN7p0LUM@kernel.org>
References: <20261113-tpm_unresponsive-v3-0-8138c8e283b8@debian.org>
 <20261113-tpm_unresponsive-v3-1-8138c8e283b8@debian.org>
 <avchzL3uEXHbvNv_@kernel.org>
 <avconeIiDzMIq40n@gmail.com>
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
In-Reply-To: <avconeIiDzMIq40n@gmail.com>

On Fri, Nov 13, 2026 at 07:14:39AM -0800, Breno Leitao wrote:
> On Fri, Nov 13, 2026 at 04:42:20PM +0200, Jarkko Sakkinen wrote:
> > On Fri, Nov 13, 2026 at 02:38:58AM -0800, Breno Leitao wrote:
> > > @@ -40,6 +40,11 @@ module_param_named(suspend_pcr, tpm_suspend_pcr, uint, 0644);
> > >  MODULE_PARM_DESC(suspend_pcr,
> > >  		 "PCR to use for dummy writes to facilitate flush on suspend.");
> > >  
> > > +static unsigned int tpm_max_missed_responses = 60;
> > 
> > This looks good but I started to think this number. I guess it is high
> > because there's never reset-to-zero for chip->nr_missed_responses.
> >
> > I think three or four trials at most should be enough, and when there 
> > is a successful transmission chip->nr_missed_responses should reset.
> 
> It does reset. Any command that gets an answer, whatever its return
> code, sets the count back to zero:
> 
> 	if (ret >= 0) {
> 		chip->nr_missed_responses = 0;
> 
> so the TPM is only disabled after 60 timeouts with no answer in between.

Oops, sorry had a blind spot.

This made me thinking that it is unlikely that there would be a sequence
of -ETIME's and then things started suddenly working. It is not a likely
world scenario.

So really TPM_CHIP_FLAG_MISSED_RESPONSE could be the counter: it is set
when -ETIME happens, allowing a single -ETIME failure but not a sequence
of them.

Sorry, this simply did not cross mind earlier.

Second open question: do we want to disable or move into firmware
upgrade mode?

Stefan, could you review this patch set from this angle? I don't feel
I have enough expertise on this topic.


>     Some TPMs stop responding at runtime, hours to months after they
>     passed probe. The first sign is usually "invalid TPM_STS.x 0xff",
>     and from then on every command fails only after the transport
>     timeout. A TPM that is already dead at boot fails tpm2_probe() and
>     never registers, which is not affected by this patchset/feature.

This is much better. It is as accurate as possible, which is good
enough.

> 
> Thanks,
> --breno

Br, Jarkko

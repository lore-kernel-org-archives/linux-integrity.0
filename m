Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794582893;
	b=nr6RsBQWoZ9wzbBGYKKZah3nQWRWMkkyVtkJs3ixCbixlt9dec2Ym+EBHK2aWtT688Dt
	 sm32mJ1QEH/SZWcP3uIMfVdvWhy5F4YVXwTBow1+MNmx5J0sN1AvGZ0ly6RwLMOBhQ4tJ
	 w236IOPO7HQEe+VAWZve9l9fBg6gxx08trWwJntau1cFijDwpaQCieApKzFhFtcUqTAxb
	 jNi7IME2N5ikjTr/4WYOrjWp4Z+KVqm6Md2chm7DR4PB9vVOwsHEIGJXi+PebmOzxPcjW
	 3UddrU0Ld/sroSwJ2fNMj8Q2U//WTqtIQZhG8axJB+FSP8ysWeNKwp+GbsJJrRW12zA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794582893;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Debian-User;
	bh=9e4OVi/eaNWz/Fx07Lz3gfuoJZdzaGjsRXlGNvLO0Jw=;
	b=duh+cNJZsf9upxetBvM0cGeQaR2Km7RM9/gwduYeemEMr7jr/s0/BM7RgSjD1OJ3awbW
	 D/UNJA+MCTtuHb6g3ikTk7Xj7YPqqq//2qsQXvzXYPyGq8JNrDnlnUayKID7w8gQ6DMok
	 +vRMLd6ZYbbcRwLQCEto+W4yMVS0PDTe0WfToYSg3HdCEynh4RqGaWPSM0HcScsRj4+UR
	 CN9gObVEoedYcGMRGpkl53RA1TXioCM/86JvfsPwxQ4GqdYK6wzmspuXnue+olmA0QNZd
	 0en9eYTI1iYgrVOIhxiJMVGOIfKCz5OLn27ggIzY+xQ1lzrpcliRocRMoOfVEScLZEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=tyPQ9KMm;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D19606A32D;
	Fri, 13 Nov 2026 15:14:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4D19606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=tyPQ9KMm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9e4OVi/eaNWz/Fx07Lz3gfuoJZdzaGjsRXlGNvLO0Jw=; b=tyPQ9KMmPTCfCFbQrTMZCE9p+H
	+kjiiWCYBGY87NRYaxPJZiYxBZpTZl4O76x2+SzjtluWbQ0pb70GFhrA8KYsLSUiR8IbL6dijPI8H
	qauXhk1OTIHZ5WnRFHPFZDmZpcWsWV7Fgu4idq2MaEbV8kP2OSCquVGld4bG2USVh/PQH4XR0A/34
	H9l8TBGqNGprd6En+NGUWiaOLUOd75fjRybQ+Lzjop1Tg1uizrLr06S+jIXFZgI80YeoTfQqnwqqB
	VXl9j86FiC0pD749tt+8b0t1grLfmxnDTpIsVnJodNhp0BmB5mtnrh8cYDSbkLyOiHqT+ceXdnDtg
	5+T5RWgg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xRszE-00EqGk-0T;
	Fri, 13 Nov 2026 15:14:44 +0000
Date: Fri, 13 Nov 2026 07:14:39 -0800
From: Breno Leitao <leitao@debian.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	surenkj@amazon.com, noodles@meta.com, linux-doc@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v3 1/2] tpm: Disable a TPM that stops responding
Message-ID: <avconeIiDzMIq40n@gmail.com>
References: <20261113-tpm_unresponsive-v3-0-8138c8e283b8@debian.org>
 <20261113-tpm_unresponsive-v3-1-8138c8e283b8@debian.org>
 <avchzL3uEXHbvNv_@kernel.org>
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
In-Reply-To: <avchzL3uEXHbvNv_@kernel.org>
X-Debian-User: leitao

On Fri, Nov 13, 2026 at 04:42:20PM +0200, Jarkko Sakkinen wrote:
> On Fri, Nov 13, 2026 at 02:38:58AM -0800, Breno Leitao wrote:
> > @@ -40,6 +40,11 @@ module_param_named(suspend_pcr, tpm_suspend_pcr, uint, 0644);
> >  MODULE_PARM_DESC(suspend_pcr,
> >  		 "PCR to use for dummy writes to facilitate flush on suspend.");
> >  
> > +static unsigned int tpm_max_missed_responses = 60;
> 
> This looks good but I started to think this number. I guess it is high
> because there's never reset-to-zero for chip->nr_missed_responses.
>
> I think three or four trials at most should be enough, and when there 
> is a successful transmission chip->nr_missed_responses should reset.

It does reset. Any command that gets an answer, whatever its return
code, sets the count back to zero:

	if (ret >= 0) {
		chip->nr_missed_responses = 0;

so the TPM is only disabled after 60 timeouts with no answer in between.

> One thing that bothers me in the commit message is a piece of
> information that is missing: when does it start to return error?
> From the get go?
> 
> I mean based on provided information one could presume that this
> could be also fixed at driver init by doing a few smoke tests
> and don't let it fully ever initialize.
> 
> "A TPM that stops responding fails" is not very locked in scenario.

I cam update the commit. What about something like:

    Some TPMs stop responding at runtime, hours to months after they
    passed probe. The first sign is usually "invalid TPM_STS.x 0xff",
    and from then on every command fails only after the transport
    timeout. A TPM that is already dead at boot fails tpm2_probe() and
    never registers, which is not affected by this patchset/feature.

Thanks,
--breno

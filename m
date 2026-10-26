Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793025024;
	b=sB21Dbf7hLkm1CeTYZL2vYl+IUSHnz4di5Xn2v2GfosURoIO6crCFqgOnhxs4uUp010j
	 +66w68qzmI5BMWRNlxCmbvgYWXv8FAL4yAfRIH+GGvczDntsl9q2CwTSk/5gJRBTam3IF
	 swyb+eUcRwD0RMbPdSYQU/Bw6csItuQQCovKzr9vdeRYYUvSOqyVZj8bUxLYTdGYBRsff
	 43YtoLlYHxWLuqM3BMsWW0Lm8a8/3E8vKmNaLwCl+VHsuJH5yAkWJGO4jutQR/RXJe8y5
	 C2uhEkNiQSwLA2jrjTpWof/IQyzS0MBb9fy+07aHfX6fgec6GuQpykJh1Tz2o1d6TsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793025024;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=3X/et2VMx7NqD+upBr88LG7gROvWjrGp1J/8ySaQ3hI=;
	b=xFqBp6PUUfnX5cxP3Fn4V+a0XERDCqTgmdKUjt9Cr3k5aY1rh81cEQcZ5962aagNH8Uy
	 RGBpZoYZG2u4+qijLICV0JuJDvJ9tkLNIp9RsqYh44t7z72/InQcKsxMtg2m+kq1uWkG3
	 TNgXIBAYFsEyxoLZ4h7y/Xt60U8nCKHss9UG6Lh06yD+J9zMj/GazZcvhjk+TFFZUQNNQ
	 Oh49RVflqFjfjgcjqxKhGsgGniCG+y7KKqMgdVtXWkFK0qIHQOrIjBFmGvY17XTQV9yX/
	 +4P81D5xVzLbaUwV1IoUVCP5D202vHYfo09mLb/3mNUA73PpyQbWsLdKgW2xywSX7Ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=II4NBoL0;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=qDbm1fIP;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27DC606A31A
	for <linux-integrity@vger.kernel.org>; Mon, 26 Oct 2026 14:30:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F27DC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=II4NBoL0;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=qDbm1fIP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793025023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3X/et2VMx7NqD+upBr88LG7gROvWjrGp1J/8ySaQ3hI=;
	b=II4NBoL0/UxIYYQRQ2rlFOUBj5Dk91vG/6PugLj13KLX2dfnShgbYCPpltJm4cInk11/FF
	L82YQu83u64y1R4rrRUJOg2hkCoE9U0Cu6ssJ90zQzCfe6mXKaS2si72n2zzUXAdhM35nk
	uVMv3lbvxtLG5UiciWKhYkaDFdrFhMw=
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com
 [74.125.82.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-3ScOthz2MZy1IO6jSq0zeQ-1; Mon, 26 Oct 2026 10:30:21 -0400
X-MC-Unique: 3ScOthz2MZy1IO6jSq0zeQ-1
X-Mimecast-MFC-AGG-ID: 3ScOthz2MZy1IO6jSq0zeQ_1793025021
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1383723dfddso5592946c88.0
        for <linux-integrity@vger.kernel.org>; Mon, 26 Oct 2026 07:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793025020; x=1793629820; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3X/et2VMx7NqD+upBr88LG7gROvWjrGp1J/8ySaQ3hI=;
        b=qDbm1fIP5t/u/ATU1SXAkby45+GhUqp8VUVuvUJs3j+kmY2ivkPmXpVO2lpUXrhgRy
         V3r3VpQwrGDv0BvsIaGveBY3I+gAbmag0fW5J/2/ff3AwqV/CaqpebD87jrg3J6dNfft
         unvVGxlMZ4fqZzR2slz7N0F9NuQi5MwnO1iDYnNzNlmtN1KvMmcfBxSRTmMRSo/WcjMm
         rRcfjlYNIdvfGj3KxRXelWbu7pj8CJ2p2ofHbUlI6ShECd4pEw+ZIzsUjs78tEvMB1e0
         T/KCcGwbYY6ku3YWHSGLmqaRLVuYREZLm8cZdczIpjvU8c1LVBG2vmomxOUj3rg5Qwoo
         lJuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793025020; x=1793629820;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3X/et2VMx7NqD+upBr88LG7gROvWjrGp1J/8ySaQ3hI=;
        b=yfGnpq9aW8pys1ikROM3IHZExxDdY8keaxqWykyoZy/q6wRrbytXwXukihePkmC2kp
         3GVDL9IesyiFu5LF+IdKTUE3ZkWlO36iQo9Q0D1J4ujuxu4Ish0FKB1LnsAKN6hFe9b8
         GgLnjUZUe/RAUQhQZK+ik27ad5uORe+yZlsYTeIB5Aq1Ci0IrgeEqxqr/dPnCWeTPG9L
         ouOK0J4oMARJcVECVn0LLjD+KOaaTv4QGFxK/qykMMKTpOj5ZWE37pm8JeDwsEJV78A2
         U5D0iar8aPVcTLzUNsU5Fc8i42PkcsZgMpY8el/xbJEBgvyfDhguGs27eBI+25f0ZcOE
         F9XA==
X-Forwarded-Encrypted: i=1; AKwUvBxM7FZoFz9vY9bHOrC80vsbHJpXayIQ2L9fb/pgcrrejULY16HQ0veFJ0k65x1xoNYg5s9f4i0T+eFxENZVXwE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJCl62QS96eG9j5eddmidRTutzsrrg3rmVA5GoUCnez0m8/XEww
	CjbnMOw5UJGPitQMReYbYM6se4dXTJ+jJPS2VWEcE+j5dMGgJddVhIStY9SoBZvH4onGdlYxuML
	hh/YLapLXzG05i8VYI3wBo3KhlCLjbDFk6v82XQ2dAHI/OQZzrZh0U0DBMrX2CQOM9+Kf8A==
X-Gm-Gg: AYBFou1304GhXwDWiSrfusk5RFiIcx6iTHhS2Lj3TYfXZjQHEPU3T6WLfeCQqlbSeW/
	ELMyShPnqXqCGOJchmxPaZq6T2buBZVOCzK6IIkHsU77bSv8Xw41BH3ogKL6ucAsoYrC2Drhag0
	9q7QDUDWKTForcg91sLXokDio7uoprUO2knPkrqR5StVyaBeKtO1ie7S+Tk4tMHf/3We0muT8Ne
	3IlC/SgUrhsuDmJ3kNkDLixXXqe3RZne4JaV1u5CLhDE5cIPTkB4SAmX5OQsQcHMoMhnxW/XHHf
	W+lV2V4NWg9HKw7M9E/Uv5qQAqbCLS8j8tQPatXY9erjvsp97gnzLFcZx8MArVMgmw==
X-Received: by 2002:a05:7022:2229:b0:149:1feb:6dae with SMTP id a92af1059eb24-19937abcc34mr16272759c88.39.1793025020191;
        Mon, 26 Oct 2026 07:30:20 -0700 (PDT)
X-Received: by 2002:a05:7022:2229:b0:149:1feb:6dae with SMTP id a92af1059eb24-19937abcc34mr16272666c88.39.1793025019336;
        Mon, 26 Oct 2026 07:30:19 -0700 (PDT)
Received: from fedora ([49.47.195.13])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a0f81ea9sm29706896c88.11.2026.10.26.07.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 07:30:17 -0700 (PDT)
Date: Mon, 26 Oct 2026 20:00:10 +0530
From: Arun Menon <armenon@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v4 5/6] tpm: Increase TPM_BUFSIZE to 8kB for chunking
 support
Message-ID: <at9j8iDp2ozx9y5z@fedora>
References: <20261025201859.221991-1-armenon@redhat.com>
 <20261025201859.221991-6-armenon@redhat.com>
 <at5tmTYX7ZjO_Q2m@kernel.org>
 <at5t-u3h1sHGJFmk@kernel.org>
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
In-Reply-To: <at5t-u3h1sHGJFmk@kernel.org>

Hi Jarkko,
Thank you for the review.

On Sun, Oct 25, 2026 at 11:00:42PM +0200, Jarkko Sakkinen wrote:
> On Sun, Oct 25, 2026 at 10:59:09PM +0200, Jarkko Sakkinen wrote:
> > On Mon, Oct 26, 2026 at 01:48:57AM +0530, Arun Menon wrote:
> > > From: Arun Menon <armenon@redhat.com>
> > > 
> > > The size of the command is checked against TPM_BUFSIZE early on before
> > > even sending it to the backend. We therefore need to increase the
> > > TPM_BUFSIZE to allow support for larger commands.
> > > 
> > > For now, 8KB seems sufficient for ML-KEM and ML-DSA algorithms and it is
> > > also order-1 safe.
> > > 
> > > Signed-off-by: Arun Menon <armenon@redhat.com>
> > 
> > In what timeline? Or is it out of spectrum timeline?
> 
> "For now" part concerns me and I'm not educated enough on topic to
> know better.
> 

TPM_BUFSIZE needs to hold the largest command the stack will ever
build. TPM 2.0 Library Part 3: Commands, v185, adds ML-DSA key
objects and the ML-KEM TPM2_Encapsulate()/TPM2_Decapsulate() commands
(sections 14.10, 14.11) [1].

NIST FIPS 204, Table 2, gives the sizes for each ML-DSA parameter
set; the largest, ML-DSA-87, has a 4896-byte private key and a
2592-byte public key [2]. Loading an ML-DSA-87 key pair carries both
(4896 + 2592 bytes); add the command header, a handle and a session,
and this comes to roughly 7.7KB. 8192 covers that with headroom and
keeps the kzalloc(TPM_BUFSIZE, ...) calls in the TPM stack at an
order-1 page allocation - something I figured after sashiko review.

This is sized to the largest parameter set defined today, not a
timeline, and there's no guarantee it stays sufficient. For example,
FIPS 205 (SLH-DSA), Table 2, already defines a 49856-byte signature for
SLH-DSA-SHA2-256f -- six times the current buffer. If a future
algorithm or parameter set needs more than 8192 bytes, this will need
revisiting again [3].

I will add this detail in the commit message.

[1] https://medias.cdn.trustedcomputinggroup.org/production/Trusted_Platform_Module_2_0_Library_Part_3_Commands_Version_185_pub_87a5c10230.pdf
[2] https://nvlpubs.nist.gov/nistpubs/FIPS/NIST.FIPS.204.pdf
[3] https://nvlpubs.nist.gov/nistpubs/FIPS/NIST.FIPS.205.pdf


> Br, Jarkko
> 


Regards,
Arun Menon


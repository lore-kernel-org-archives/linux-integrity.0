Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D244E40DFB6
	for <linux-integrity@vger.kernel.org>; Fri,  1 May 2026 02:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777602778; cv=pass; b=NwY0dIOomJfhNVBM0VntI2rp5XEkK3Ll1JWbqNxvsS7ADpMqusWiEJtK6RnqtuvJcdZydQxWJp84tBvipXKzAz3Abj7CiJj+8j5yzDH+nm0u4Aa6Z04Jvv2jxOCcOZV6uEaiEpOjdqD6Zi4mcf7BJlvj5u08U5q3LgPbmCf4Pmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777602778; c=relaxed/simple;
	bh=2nV5xI55GZNPGgHxu11iGGf4DVqzNlton0KtJrkbBYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=irCNIVldArgDSnjAHE4CynFsfREoV5F2k5sJkyrTQCOSwrH5fwKfkULl9A3J4k3sigNYamLUfolYNlRIBJw7WuoCNCuyzA4UnVxNyWIfOxOSEJXyu/AtXAhY+ApfZOZHVX7kSLUdDNF1ESqbhk9OqIvQnFwcd4i05uTAI/w8JIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=EBxEQ34T; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="EBxEQ34T"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-67389cf78b0so2974175a12.2
        for <linux-integrity@vger.kernel.org>; Thu, 30 Apr 2026 19:32:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777602775; cv=none;
        d=google.com; s=arc-20240605;
        b=h07JFTqJMyoa8bPqwCNRz/ANs2XlffrWcuqYWkisu7O9XW0x1lXqSKmS7WwCv8vVYc
         prZF1GZ44wvjZnwoivbeky4Gg+dmxSS0UYssdI7C2/qJB2co00wvTQ4KTKOLyqoj6rMR
         Qr47vR2SlyskDd5AJKP75/BgdL1xkYTdxnoLaW8uqiEXaxqse8SIVsO4ho6ZiKqcpD9B
         JUHmKuLJMCAN1sYPz4R1JOs7RPKh5IJwhc18dgzzFrQK71PvQTz/WmcKfODdX8NaILfV
         bRDSIEWN8iz6oSOBOmCx8itW3hRPkVckBB24nwbDU1dORq3I1X248Sn1XXrEmN73b/hU
         NpOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=2nV5xI55GZNPGgHxu11iGGf4DVqzNlton0KtJrkbBYY=;
        fh=dpn88ZNWaMQTrtAGjdBlstMALomhgni5nSm38VcTk0w=;
        b=WOwAJE5ldJE9NyQeSK2B+AEbANaYVtSRXwg5uwUx7K+BuC9ysEbb+UXXPn7GRAgosJ
         o1eKQMeWVBZ+yr6j4Ve0XIww47fIFCb+GF1buX4nk4ZwFrVFd/cUgx0x4AwfcIa6SZKq
         bE4pXQYd6nKWDFPkWnkiFtTvv/3d3Q6hM0S8i18dnBrG05fCW76CZovzfPSzPlv3SPRC
         vAucnkwJsnwHtywqIrrIJjbyEBM2vU3DA21gy1e+6aqpbwpeiDyVMgi1l8yZkP85crjz
         XvAwE0eXrKD6PNTsoNowjP9YBqJEvKx24UMKgoN+5ZutUr1rArYd0fmnef4n1Xd1IBr+
         x9dQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1777602775; x=1778207575; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2nV5xI55GZNPGgHxu11iGGf4DVqzNlton0KtJrkbBYY=;
        b=EBxEQ34TZyMlSvECXm0nY0oR8LO3xCKrqY72wDSH2vRaSxaGO+q+J3RyK2hvcSuWDV
         Hy2FC8rSH2TPto5mCJNXa0EIAAnKJH1b06OHTQwD53rpot1NKkj8/Bh+bW2mn64bSoK2
         Og7wi+cbI1236bQ0m0jZU0vk9QKkG5HK3Wh5ue4amHFJGXkpqLsKQcfoGt3nMgxPy3/b
         4OtfdsaSXIqL1R91KZldfDgGf4vdJ/WHhzQfrcbRuZ9szNn+pYb/SnTHWcRBHwG3+Cg/
         QYDeh8qdwkoz/jDe5iHU1kP+KNdr5G3n+1KdvvFHWtk3zAJ2OkZYqL2mHvqXsq8kqxfV
         jK1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777602775; x=1778207575;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2nV5xI55GZNPGgHxu11iGGf4DVqzNlton0KtJrkbBYY=;
        b=U7G4UqFCmSk9/bBsBp6VJ1sMzHbghxM6N2rxVqlf4qz+QECyZHxqibyl3xBLyY8ZN9
         q541GSb59kKl5Qfe8ss1RgEVUdBCmvmSUe2AkCIayIvAllkzfCwOgBFEbYmiruBnkme6
         pts+gDlZb+6z5w3Tw+XfoMYsH1SNxWfIVsodFYqrxqwnQxx5EkugswGNKyDXVLZiqI97
         JT2oOMbopkNY7EnzH3Bl6sfBdlgvJPiZi1pns7FxT2DSsDl38rfR+R7eh01eU1F7n15U
         VGJQxibN98qaAm5BkwgjWTExNxeimK28+Mc4sKFWQ+V1YGBq4y3Cn+TrRbfaEi/eVCo2
         0eJw==
X-Forwarded-Encrypted: i=1; AFNElJ+h4V/UCo5j5G5WSUNA5NdBAtI6VzZOCtY6RVr048G75gg08XPztheRGRT6dW2eneUbRRStWFruJt6PJ816ZDw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws4KkqAyi3g3uxvG0+OznGRJk6pZluQtJ1Vn02v9FiWGZKgZVs
	Dzb6zUWmXvjjGmGAd1CkpBvpA5McVg2qe/eRYWdz2duFxvIoJbWv2zaXYZLH2gAAutND2ll82Ws
	RIODc81NBN/2LNyvGCnONnDmSrsR3aTV/N0/P7rEaqxvU+Gz3i8RXyQ==
X-Gm-Gg: AeBDiesF7G3e4CVOZrP41bXfk3gREdZZPvo8FdjIgNx3oZQ/xSHVPdJ5jgacoCDvoPi
	VMClNBbrHuu7mlpLv68YzJqf+FfSNfE/RNYBb5mG2Vb5c3sjOra0qVeNgoX+0yQN4mqfPEWBe1A
	Z4TChRYorSdkASA2mttRvqECW5grZl/8bO2LQrfNgWNWyz7VNjVhFXZsbVh32gG0p9e42RNXxcS
	KrCEGhi1TqQCeO5TLMMw/SyFZ6RExFs5kOXHyJT+e+csI8sHS5rgEMQwqub+dLiYOac7Irt+SkC
	rW8wOZMuWjzmfxEDN8kaMTegQuzKitv7ttEze67/n3Omyld3K3x/
X-Received: by 2002:a17:907:7b8b:b0:bab:1839:cc61 with SMTP id
 a640c23a62f3a-bbb788b06c7mr290359066b.40.1777602775198; Thu, 30 Apr 2026
 19:32:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFn2k5DJNv5SDsx_-odHd3sB0Fw7r8FqhO8fWdXrraZn_vbpDw@mail.gmail.com>
 <2b3c93a69e70b6fdf637bf9fb921d5e737a79e8e.camel@linux.ibm.com>
In-Reply-To: <2b3c93a69e70b6fdf637bf9fb921d5e737a79e8e.camel@linux.ibm.com>
From: Sahil Gupta <s.gupta@arista.com>
Date: Thu, 30 Apr 2026 21:32:44 -0500
X-Gm-Features: AVHnY4KiltXNe09eAfSM8PEJe5yZLMT5DNfDPvdW19MiC8SQp8Ys17-qFgy8PQU
Message-ID: <CABEuK14__XuRO2KOd3w+qx5_nw4iB2yPcF2R68a09A4hcJkyFw@mail.gmail.com>
Subject: Re: IMA: Avoid redundant rehashing on stacked filesystems backed by
 structurally immutable filesystems
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Danny Hu <dannyhu@arista.com>, linux-integrity@vger.kernel.org, 
	Julien Gomes <julien@arista.com>, Pierre De Abreu <pierre@arista.com>, 
	Kunal Bharathi <kbharathi@arista.com>
Content-Type: text/plain; charset="UTF-8"

> Have you considered using IS_RDONLY(real_inode)?

OOC are ima caches invalidated on fs reconfigure? If that is the case,
then IS_RDONLY ought to do the trick.

Sahil

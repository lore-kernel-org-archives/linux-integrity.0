Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076E6423E9C
	for <linux-integrity@vger.kernel.org>; Sun, 11 Oct 2026 10:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791714215; cv=none; b=cwK2T0z8tVrE3yKwfncHD5eyZHXHZXpIEq9jylIxPC1ZWBAKIK0dft5uVd+a6ttpynHeqeVMt/Z6t8OKFQPRJv33RqK9GnYwiIuy2qVnvkTWD8e8ovJebXrr+NjicEbRZ3MvJAhXtWKcoJXAw9F/9yEE/GO34JHfYSeV74hjSfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791714215; c=relaxed/simple;
	bh=vpW8/KkGJ7bWQM1agx07Nvt0sF65rPu6xz06pQZazSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tjMLrZi35Cvu+Uu+o96NtY90XEMx70lZhsYvkADwME09G9KGFvmHwpPzBXk25qWSK+2gznE79gTUTUK7AuPS0keQz+ZfDq+x7G5Ubp3Wm6jr0HuieRBFZCT9lK3H38CpPQcyCucH4VK7nHgZ618b0nZkR7E+AMbOYSneVjZV7TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=srcf.ucam.org; spf=pass smtp.mailfrom=cavan.codon.org.uk; arc=none smtp.client-ip=209.85.216.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=srcf.ucam.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cavan.codon.org.uk
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-3a4b3ac8fb7so355024a91.0
        for <linux-integrity@vger.kernel.org>; Sun, 11 Oct 2026 03:23:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791714213; x=1792319013;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GCrU7gKGl9q2lr9szhaNlgI07chMKDnbiy6n8axucp8=;
        b=a6ce4lxmCeeTgwgu+05512f3c1rd3b9WK1dDbfZqlddaORwiCVHge6lHRDeaBHNrtD
         3MOubUa8+I1qfA3Kf9rrjjolTSriUTJ/5bNZu+XEkoLyIrjVZ3zaSLw3+a/RzKfll9rZ
         UTeBuE4sod3UIkOnSyBK7ZPue5uXx+CwNrlTdysIUIilxS7f1y/KCffIND9hG7IN2H7z
         77JwoTjUOkeqWUaFugCAjpmpyRs74N2J1LlhTaByQAsQelS7RxHhEJgVRVByU+ZPkaNl
         uEMnCFXOGCIpywJa5bs9iDysoW3xL8miOoLSvVWJwDEYMAQ3Fk5sYkqyaCBOvrwWasM0
         C7vg==
X-Forwarded-Encrypted: i=1; AKwUvByvKJKbWsSVWGTtTLw0ERE7BDRJtRTkPiq0iJUkP4kPWsPV5ALbY20SRxFnMK+wuEVohal86v5hXOT0wcWIC7Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYJPW8B6Vhc1he27r2JshFR2xE186IdtzxGbnoxHnWlwCKTU3Ab+
	fKm5zfyGrvtdHeRMv5/VfqwjTDWU8N+z/QFDThG2C+KICMF0xCQbWxR7eqgjRl2PmDb/6yfhdxN
	FllYHiO2h6LtLLW4Og3ar0yOlpYTGowBqcqypgDmuLwT7+blm34x8
X-Gm-Gg: AYBFou3Gqy7T/hf69Y45tZwmsnuQQlUM9MojYDToQaNfLpaLBrI36cXc+qnGMjayAec
	fA4e7cXc74nHhYX5CD6FLPxJeCV9UJZmmFVbb8QeEkhFnpwd9g7P+ZJdMQvO9bi4Y7mosl7wFJ3
	4MT3i39hjbd/MHpie1ahhaahXQtvNUhWApDKzBi9aPQsHPxPTz3jDI9QUL2CKESdEW7drJgXr/x
	DpHPu4HJIXmfFdC08SqtWPLGftxxhOe90pCF1Xrfpvid6ZCQB2iGsgm+gmwlSDQeQFwchMdFywb
	u3BOy6POwdxoXyM4B0NZf/E4m/o342sS2QAeO8nQVmbLSBxq8JLgeKH1wBt03rv4+aXHNI/xDl0
	BHV8=
X-Received: by 2002:a17:90b:2d86:b0:3ab:3437:554f with SMTP id 98e67ed59e1d1-3ab3a746d73mr5664315a91.29.1791714213229;
        Sun, 11 Oct 2026 03:23:33 -0700 (PDT)
Received: from cavan.codon.org.uk ([2607:f598:b99a:160:8a88:88ff:fe88:8788])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ab36d3f9c8sm4193873a91.0.2026.10.11.03.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 03:23:33 -0700 (PDT)
X-Relaying-Domain: codon.org.uk
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
	id 6F3CB18A4492; Sun, 11 Oct 2026 03:23:32 -0700 (PDT)
Date: Sun, 11 Oct 2026 03:23:32 -0700
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Matthew Garrett <matthewg@nvidia.com>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org, rafael@kernel.org,
	linux-pm@vger.kernel.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH 01/17] tpm: Define a kernel-owned TPM NV index that can't
 be modified by userland
Message-ID: <astjpI65VOyU8xvI@srcf.ucam.org>
References: <20261008132532.1155166-1-matthewg@nvidia.com>
 <20261008132532.1155166-2-matthewg@nvidia.com>
 <435907614242e82ecde1767a967a3110fca6fb37.camel@HansenPartnership.com>
 <asqthz69ohnMVCye@srcf.ucam.org>
 <059384e86fd256618498b9a7214b6421d38fdf1f.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <059384e86fd256618498b9a7214b6421d38fdf1f.camel@HansenPartnership.com>

On Sun, Oct 11, 2026 at 08:04:27AM +0200, James Bottomley wrote:
> On Sat, 2026-10-10 at 14:26 -0700, Matthew Garrett wrote:
> > Does your log replay correctly for PCR 5? It's *extremely* common for
> > the extension to happen without logging, since logging needs to be
> > done  into the late events table and almost nobody got that right
> > until a few years ago (hence 
> > https://github.com/google/go-attestation/blob/master/attest/eventlog_workarounds.go#L70
> > )
> 
> It seems to.  This is what tpm2-eventlog returns (edited only to show
> PCR 5):

Hmm. Well, that's irritating. Which year's XPS is this?

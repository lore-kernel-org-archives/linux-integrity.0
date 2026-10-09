Received: from mail-qk1-f227.google.com (mail-qk1-f227.google.com [209.85.222.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407483DCDA3
	for <linux-integrity@vger.kernel.org>; Fri,  9 Oct 2026 08:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791534694; cv=none; b=XCslN5gnHcD8P7b5rWLQhaVeOJjfQcL43w4Wtt9e0LPmmINAjphLVYe216yQBAW1MZiP3MCPlRrPzQ9dXk3Aac7SuwanbN4UM2P58NYOkZTePhkjFYJcque1Mw5dltGXSTsSu1Ug+QZmQWyaU8HLk1tePpMUM0/idFeOofIalFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791534694; c=relaxed/simple;
	bh=WATkgCQ/kmtG5HulqnoTUl0JCJKYR2K92PtDB5Opiv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f3WU1HnJz/MBc/It1a2k2cFAiIf3mW20aLpMv/brF8p/gPc46uxNsbgZxFk1ZMO8kPS8Gx97/NzZ4RNo/fTecp1gVNgvZT2Lq+VpA2bmRRa0ATdPuY44ZYQQ4hW8sJuz85yi2bdlVVMhGu/GweK7hS+erjc7FeSr6oD3NLScjTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=srcf.ucam.org; spf=pass smtp.mailfrom=cavan.codon.org.uk; arc=none smtp.client-ip=209.85.222.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=srcf.ucam.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cavan.codon.org.uk
Received: by mail-qk1-f227.google.com with SMTP id af79cd13be357-93e635220b4so369042485a.1
        for <linux-integrity@vger.kernel.org>; Fri, 09 Oct 2026 01:31:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791534692; x=1792139492;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W+Ti0O2O4lnX/hVbcn12QwKSuhI8bbGy+WYpeuSvKe4=;
        b=MR+IgtH3QCvk3aiCOmGDhsPTq8hQJmi8vEkU97FzNfphV5bKAfreDgGcbXqGjXmNKZ
         HtMHXSCpZG0L56GHpAGrVJ4nGObmBShtHQ2Z7k4C55cbiZcAawkpB0YiuiVU2Rpf0hKT
         zSTefd3VSVynusC8WrhRRGQX5Q1UOnrs4stGcrDnCE6SheX6u1D8KiNjZLVvoMsI6Nf9
         owrffoSbpe7yJeKNxMxdokjdoxKvCRBCDdezhj7yrl52bzlvBT4PuV8uvN45dc03WB34
         l7ZyqTjfAIaHjKoXWSrZfQ6IvLwJifIeJmLguLVYp6rcxsMw+0avD0jGow2wmecx9O4G
         a7lQ==
X-Forwarded-Encrypted: i=1; AKwUvBwgtX3K6ADWi0lFIbGf9LJjNBGEEs4K1U5HL6RAVtPaLjsHBcvkK5SuEkmgpI6FShTwVuauHqwTdRfghILc5VE=@vger.kernel.org
X-Gm-Message-State: AFuF++nx7f5NORLuo2CxEJ4ysr0U8bB8aawad8S5zOHkQRDHRA7cgoR3
	uio68TTAON0ZHQjMEMlImgxgoTOFOpaSwo03W+iTvzolOCGBRyrqwZnzpAurTNmOegvvv/0A8Ns
	XgxlSfBDCk0xC5Usz2Z0Oyyn7VYMeqvBBpaRb2rrBall5Z915juUa
X-Gm-Gg: AYBFou1yQYImXynvZ3nkwsDoSGlbQd0pVgcYU0z+0q5tBbvqv6Lmn1oXqBZ6cxgMnIk
	VqMV30AJ6RXA8+Ldf50Veuu3Jq/6MvYlGJlAt0Z0YOpqzoM+EGpwalD6t373zLPpWV7wPni7VWr
	Wz1NlSgEoz49xYVuEIqpWOcraxQ6mwIpx31ZKb/tLZvp0z0ZiPr1Cb/aMj73v4979WRXulVTqTf
	Jn6PauhbYQ7vOPDbvv7MS3dWa7OClr//Q75RZKPw2UJg7NvSf6JD0sHUG7o33SPfi5svhe0co9y
	6WQBqSwDRBi6ahxwfp7d0haaiuO3NFDniYEQJ5Hr9CiXDOcmdnRyGfGppAetkl0b+x8HIk8qqQw
	ndRg=
X-Received: by 2002:a05:620a:4013:b0:937:27fb:96f8 with SMTP id af79cd13be357-93ebd25c85bmr177526785a.41.1791534692184;
        Fri, 09 Oct 2026 01:31:32 -0700 (PDT)
Received: from cavan.codon.org.uk ([2607:f598:b99a:160:8a88:88ff:fe88:8788])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-93eb986adf7sm29407285a.9.2026.10.09.01.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 01:31:32 -0700 (PDT)
X-Relaying-Domain: codon.org.uk
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
	id D784A12862D5; Fri, 09 Oct 2026 01:31:30 -0700 (PDT)
Date: Fri, 9 Oct 2026 01:31:30 -0700
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Matthew Garrett <matthewg@nvidia.com>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org, rafael@kernel.org,
	linux-pm@vger.kernel.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH 11/17] tpm: Add kernel signing key creation with audited
 provenance
Message-ID: <asimYsZxxGvPAFiZ@srcf.ucam.org>
References: <20261008132532.1155166-1-matthewg@nvidia.com>
 <20261008132532.1155166-12-matthewg@nvidia.com>
 <bd131221bca29b5f8ba348adadf1e3930a5b57fe.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd131221bca29b5f8ba348adadf1e3930a5b57fe.camel@HansenPartnership.com>

On Thu, Oct 08, 2026 at 07:00:28PM +0200, James Bottomley wrote:
> On Thu, 2026-10-08 at 06:20 -0700, Matthew Garrett wrote:
> > Add tpm2_kernel_key_create(), which creates an ECDSA P-256 signing
> > key for the kernel along with evidence that the kernel, rather than
> > userspace, created it. The key is created with TPM2_CreateLoaded
>  
> I don't think you want to do this.  TPM2_CreateLoaded was added in spec
> version 1.38.  A lot of current TPMs on the market today have spec
> versions lower than this and would reject the command (The spec version
> of the Nuvoton in my Dell XPS-13 is 1.16). Since it's really just a
> shorthand for TPM2_Create followed by TPM2_Load, you can simply do that
> instead, which would save us from a load of complaints about this not
> working.

This is what I get for working to the spec instead of reality. Thanks, 
I'll split that up.

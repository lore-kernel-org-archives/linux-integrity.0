Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9760836D9EB
	for <linux-integrity@vger.kernel.org>; Sat, 10 Oct 2026 21:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791667594; cv=none; b=tnx98sg0blQRysHpmsMw5rAubDvIPqz+EYEQrKV+/TmnnJ8G7EI5zamv9o2AtPKQXvC6DIhQDBgeEDO88A/ulJ+kzywBXxhtMsjaAvty49asiyrBeFQRewhAI0g+d8LlR0WJFJtplcy4DvF+fyZaH/KgTOIhMqnM1Cy0gm4obMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791667594; c=relaxed/simple;
	bh=cd6DBvfY/V0vH3X7czk1rG4Fa13vQUKczFzwYCCmz+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NBZxBqT22II1NYUlLNGldsP9msGPEV6rtCKf17bvLFYOc05tAty77OgouX2iEmTUhon6TLMHCvQHxG6u2C71mO+OSpw61M2JqPkrISsRuoRmogYyvLU8RVnPu6XG5VZHSSA2j/agmVEChUv48uv5B7vxb+H7TrVVPwhYvI22fK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=srcf.ucam.org; spf=pass smtp.mailfrom=cavan.codon.org.uk; arc=none smtp.client-ip=209.85.216.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=srcf.ucam.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cavan.codon.org.uk
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-3ab3260b35dso464867a91.1
        for <linux-integrity@vger.kernel.org>; Sat, 10 Oct 2026 14:26:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791667592; x=1792272392;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xQ+BvwTajbJuDLtdFxXsbhV1xx7cCxJdnpKMHHdw0X0=;
        b=yGa2UWhLwsujbaYfCzgQxEsacQUxxaiuwaXZhLVSHZis2EFIvA09ZKaj5rp4T8Ywm7
         p/CZ7jkhGP56M24qWyoV3l99fgoxzpnQ0l3XEUf58/1hLHjusNosFcROmXnPXcj9C4Uu
         8nDSDwBovVpGbgmKfRYacSBbDBAH7qW7wZ1zmqkOXQW6fKwyP3pkeC/PlfmVAIeQgOss
         SIrYyCpD8B56FU9FcPzxdsPZjuH5OdXhPFhaW/C/5BlZUpfCe0zjBkv0+/nJ7AVDDlcN
         DOl5r+IVAZgSm/LrrV2+W4/P8MIN1JO2aN+Wps/MZWX2EiXIKuXLBURv2fstygYYIAhg
         EBnQ==
X-Forwarded-Encrypted: i=1; AKwUvByAwyepFAGHMY8pHXkCj93iNTaZdLJX55qR560Z/htBVSETDhXCBb8R2I2xNlTcl45I4IPea0G0CoQ16ROnIt8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIMieqyX8hepMVaUsbdvdWNb+aEvC5RvlgOXhmGqW8G+e37K1Vw
	7wmE0PhcnUc/Kt/mgUTUh2F2CjRvUob+W3tMddv4a5moXkqqH6VNbNGmgM9X0PoSiPukquL7uvx
	3t9dOpYmoIzkTRjZtupV3TGH64zY7CR/42E2R22StvAloVgt8d6N0
X-Gm-Gg: AYBFou1rRq+xrGv5klDGdr8R11S266QyAoEhyeee+wNyVuAMiGy0JhRrvIzZxpjAooe
	IPdnvaTU5aATloB2Fu5+Rgqi9XVN9d0s2vcaYiZCXN19u4s7obzHnPffXP4XAkGsZpFEGkUfYLj
	QY2eP8nxYb1/5/y9Gbf+lW+UcywK6h7JH1mXLTSNXBNaaJMX7/o1uASP/wEnXuhsEWCgJrHDR/s
	uRFK8Lkj8g/SYYFl0YqAFRr+VOYLwTD3nKB4u5BxxP87Id1SkDr16MM9SazwxKkJq+UpCHfQn5R
	WzzEsBSEhE/73m/fiCwyQzaWKmx3zoXHM3jYe+8ul0pFchWafYgfu8KCLvqSS2MAyDwvPzbjZGp
	R/Ro=
X-Received: by 2002:a17:90a:e7ca:b0:3a4:f75d:d194 with SMTP id 98e67ed59e1d1-3ab3a8ce801mr5220265a91.36.1791667591856;
        Sat, 10 Oct 2026 14:26:31 -0700 (PDT)
Received: from cavan.codon.org.uk ([2607:f598:b99a:160:8a88:88ff:fe88:8788])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ab39631932sm1330977a91.2.2026.10.10.14.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 14:26:31 -0700 (PDT)
X-Relaying-Domain: codon.org.uk
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
	id 1A99E1287AF5; Sat, 10 Oct 2026 14:26:31 -0700 (PDT)
Date: Sat, 10 Oct 2026 14:26:31 -0700
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Matthew Garrett <matthewg@nvidia.com>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org, rafael@kernel.org,
	linux-pm@vger.kernel.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH 01/17] tpm: Define a kernel-owned TPM NV index that can't
 be modified by userland
Message-ID: <asqthz69ohnMVCye@srcf.ucam.org>
References: <20261008132532.1155166-1-matthewg@nvidia.com>
 <20261008132532.1155166-2-matthewg@nvidia.com>
 <435907614242e82ecde1767a967a3110fca6fb37.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <435907614242e82ecde1767a967a3110fca6fb37.camel@HansenPartnership.com>

On Sat, Oct 10, 2026 at 11:22:34AM +0200, James Bottomley wrote:

> The reason I never really proposed such a scheme is the rollback
> problem (old version of OS or non-Linux OS can create the NV index from
> user space bypassing the kernel only block) which you try to solve with
> PCR5.  Do you have any data for how widespread measuring
> exitbootservices is?  I know edk2 does it, but I just looked on my
> XPS13 and I only have two PCR5 events: a separator and the GPT table,
> so it's definitely in violation, but if Dells don't do this then it's
> indicative that many other manufacturers might not as well.

Does your log replay correctly for PCR 5? It's *extremely* common for 
the extension to happen without logging, since logging needs to be done 
into the late events table and almost nobody got that right until a few 
years ago (hence 
https://github.com/google/go-attestation/blob/master/attest/eventlog_workarounds.go#L70)

> If we do have a problem with lack of manufacturer compliance, one other
> way I've got on my todo list is fake trusted launch: now that
> Trenchboot is heading upstream, we have the real trusted launch, but
> that's usually too fiddly for most people, so I was thinking if we
> could get enough of the TXT launch to happen to open the localities
> (without bothering too much about anything else) that might be easier
> and give us the ability to run the Kernel in locality 2.

Remember that many consumer devices don't implement TXT, it's only the 
enterprise SKUs that tend to. But that would be funny - it's the same 
sort of shape as an awful hack that's used on some of the Qualcomm 
laptops to get access to EL2. Localities are very clearly the Right Way 
to deal with this and ugh if we'd been having this conversation 20 years 
ago instead.
 
> > Reserve NV index 0x014c4853 for use by the kernel, and filter
> > commands submitted through /dev/tpm* and /dev/tpmrm* so that
> > userspace cannot undefine or modify it. Blocking definition is more
> > awkward so let's allow that for now, not being able to modify
> > ithttps://www.bbc.co.uk/sounds/play/p0pfxh72
> > means there's nothing interesting they can do there. The filter
> > simply validates which handle the relevant set of commands is
> > referring to and returns -EPERM if it's the kernel one.
> 
> As you say there are several other use cases, including mine above and
> NV PCRs, that can only be extended by the kernel, so I think this
> should be a range from the get go.

I've got a single index from the UAPI people's range right now, if we 
want more the easiest thing would probably be to ask TCG for our own 
carve out. I don't think the process would be difficult.

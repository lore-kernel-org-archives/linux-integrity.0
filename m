Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com [209.85.219.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5ECE304BB2
	for <linux-integrity@vger.kernel.org>; Sat, 10 Oct 2026 21:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791667124; cv=none; b=Os+LgdpQgUUhmei12IAu/y1q7EX/VuWwbpTNIpSph4BWodaX43+jyAR+3RH568v0UEoorYBbHm8js+fOiZCN4ryp6QnnAqy5vnPcgAUqdAWQu91fyDok77lXC6CSoUfhcTct3RH+tv9LSPX4Nm5OD5cDRqewsl3BolZFo2w0sT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791667124; c=relaxed/simple;
	bh=tcL6A5SoUYWty+VXbzXNe06G0pu698TmKup8qJ97Wco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vky+b96gkMHcmdOZHT0ZM0RHiTZEzqDNSEyNLdb+jFQgObV+aVXzoWQhqJHjnIvZkwHhcOWQ3+o5iq1gQPGSJq6G9OG1uz7OVMMKayTEgyIfs7RsLzF4EEysCzoxO0OCsWDOWHgf7EfXPmlnpiUiD6NyY97VOisoSwo1I+QpNvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=srcf.ucam.org; spf=pass smtp.mailfrom=cavan.codon.org.uk; arc=none smtp.client-ip=209.85.219.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=srcf.ucam.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cavan.codon.org.uk
Received: by mail-qv1-f100.google.com with SMTP id 6a1803df08f44-91986c5cb75so11633726d6.0
        for <linux-integrity@vger.kernel.org>; Sat, 10 Oct 2026 14:18:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791667121; x=1792271921;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WXTNApq6aSI569pIUAzzE6jSpAQWrYRivHcZV0gC9AQ=;
        b=SVWP5GnY2B3WuA+B/eDKIe5YB2LsChzvtWuOObZlJhpzx4zGSHTmz+9yENcROKLmW+
         6zGBAhQhF2DqOHfsRmRQLqVGk8/G6nMcDb2zwq7KmZgyQFwDaEVgzEe8PG2T3C1kv0lc
         34JotimkIFhs4gpBYCNWTQESPZg376Y/sLny8Q5AGcWKZL+Afo/gEemOlYVtbEab+Dcn
         2Uo4kiv7k3RsOHMRuLMHbGcywW+DYZ7c9PUYTlkR80GM0Feexj5V8evaQIzmFCCH4Wtl
         vDV4pIDCoJ5xkgMVoZkSEDVskEKJgNkO69iWFf4So0B3yyqCtWwePQzDnXJQLTuS8t+u
         QLUg==
X-Forwarded-Encrypted: i=1; AKwUvBy1F4uHWe6wFvv6QVjit3eDqeafn2i4nZNDcwnxghjg1/sXkmxIGtCUjYmhWUdOcnUupwCfvgaiPYCz6rnTgMo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLZlkunxYcqeFiqV+brkBz2VxIPRScibUWvMrz/XILzpfcNXy3o
	PpJQZPq5b5gWUSwPjtB7ZDs/rl4xY8VpJG1WaGRWe4xP5pcEK9QzMWPxyhMem0JWgBuaOb/bx92
	u9FLfVTu6paw5i44ZK49a4r28pP3guvvyhRSe
X-Gm-Gg: AYBFou3c369Vxatw1CTKqhnEXOATivK6mqmX0FdAY6Q5yZUnOoEL/BXlPZaCMLiAOog
	5VjVX2mMP4fuQ7JhmbyvA+Q6mMB1xIGA3WQGg6OZqTdVsW0loCGxxa18yBX1J28fpvFKeYxjPjm
	IsM075JrrqJT8eyI3Gd0/mPtlkuKB/sF3Owl1qQH349L2I9ZY3Czr8OOE8lRzjtv6e5nSUgVTQP
	ap1fWzT1oWZwwiBGV/FRQdifFRiPPjeQF4o0Gy9f0X2Z7B7N6IsRxRdMxLIqtYBFhnM3QN+6yrZ
	yzJ6uN3l7HRS4mx9XndieDdr60yeKwOIiQChz2MnFG0cy/hO8i8JcHnv4uwZ7y6sfvId2CpTFk9
	+z6yyq1ehotnZnzs8f0FZnztaxq3mtfDU/3D9Y3Zj
X-Received: by 2002:a05:620a:2b49:b0:93e:83a9:d59f with SMTP id af79cd13be357-93ebd23f1ddmr876491385a.57.1791667121467;
        Sat, 10 Oct 2026 14:18:41 -0700 (PDT)
Received: from cavan.codon.org.uk (207-53-253-74.PUBLIC.monkeybrains.net. [207.53.253.74])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-93eb986adf7sm109798385a.9.2026.10.10.14.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 14:18:41 -0700 (PDT)
X-Relaying-Domain: codon.org.uk
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
	id 273C51287ADC; Sat, 10 Oct 2026 14:18:40 -0700 (PDT)
Date: Sat, 10 Oct 2026 14:18:40 -0700
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Matthew Garrett <matthewg@nvidia.com>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org, rafael@kernel.org,
	linux-pm@vger.kernel.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH 13/17] tpm: Add verification of kernel signing key
 provenance
Message-ID: <asqrsIij3KjUWQev@srcf.ucam.org>
References: <20261008132532.1155166-1-matthewg@nvidia.com>
 <20261008132532.1155166-14-matthewg@nvidia.com>
 <0e47c22afbce2f94673bcc77d640cd9da410c2f2.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e47c22afbce2f94673bcc77d640cd9da410c2f2.camel@HansenPartnership.com>

On Sat, Oct 10, 2026 at 11:34:10AM +0200, James Bottomley wrote:

> I get that PCR 5 measures boot configuration and isn't supposed to
> change from boot to boot, but what about across things like firmware
> upgrades ... do you have any idea how brittle it actually is?

It is likely somewhat brittle, but: firmware updates may also change the 
memory map, at which point we'll bail out of resume and lose user data 
anyway. I think the appropriate guidance is for userland to unstage any 
pending updates before allowing hibernation.

> If it is brittle, one way out of this might be only to care about the
> last log entries, so make sure the log hashes to PCR5 then find your
> EFI_ACTION and the exit boot services mark in the right order rather
> than caring about exact value match.

So include the old event log as part of the hibernation image? We 
wouldn't be able to trust the event type because that's not part of the 
measured payload, but altering that should fail safe so that shouldn't 
be an issue. My gut feeling is that this makes things more complicated, 
but all of this is opaque to userland so if it turns out to be a problem 
we could revisit it?

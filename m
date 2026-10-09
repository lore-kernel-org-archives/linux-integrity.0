Received: from mail-qk1-f226.google.com (mail-qk1-f226.google.com [209.85.222.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FE13D7D65
	for <linux-integrity@vger.kernel.org>; Fri,  9 Oct 2026 08:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791534595; cv=none; b=t4uqlm+7AhkR2HipFFxol9v/xf4KxsLcdFGqAztfiJAVsbzK2CrjJwF3nH1H+gpaaN8KEtb6UciAmZNLg2Tyulxj729KnLHQQ1jLX8kwfKB8hhXtY2f3KNdap/734rpcSI8oAYylZNuDBKYWKKMBRBoo2Oz/RK8XxNL1gnxLSxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791534595; c=relaxed/simple;
	bh=KdOxe03RJFJSOXfBnXYN+A603ShkIe/cWcsUKZ0d0NU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p9JbpOIJCRQcCy/MzefVeTtki1LunG5JoDIXzKpg/0WOXRzBKH0kv04s91x3bMcsLSrBxNs0/T+2B6jHXZiYcGGbk9xWlav+7Fbs/YsHbSv7AxEpJdlj9RXr8nd/sbHqj/0Lc4iaTxkdpeYrJtJJLg18ETleL4MHydIQn6HsnLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=srcf.ucam.org; spf=pass smtp.mailfrom=cavan.codon.org.uk; arc=none smtp.client-ip=209.85.222.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=srcf.ucam.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cavan.codon.org.uk
Received: by mail-qk1-f226.google.com with SMTP id af79cd13be357-93e55db58cfso548486085a.1
        for <linux-integrity@vger.kernel.org>; Fri, 09 Oct 2026 01:29:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791534592; x=1792139392;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cq8gQSDpD+5YFxqUsScItWyxOjZQR+1g4Dz/3bcOwAM=;
        b=rjZAIRyva1sZz9WfYaUwmK0rGe8cB+41xomDsIm1qBKjHyHBQ26C0cQzZCJuOG+57+
         UWfGFDBIwMS54tqhkHP3vwYzw/w+P4fRcujXr1ndsv+YenCoitHCJvZ3phngJbkdabJ9
         go5KWH5v9FXyYcI7I76VsU+SDfv7pyPYwcEE7wnZSRy4dppKU/lfSFBhdtWIWrCi7qoZ
         tIAdCyWIDDMEpuAAVFjtEjnHc5zI3TYby4TDhjtCZf9iFvoppKohn+7g279nam0sMc9Q
         QeJ3o8O/8RydRDxH/LdHS9S0dteizU7xm/e6G2gQ8toXo2+PsNWS4viOKB0Q/nhW5wNs
         3stw==
X-Forwarded-Encrypted: i=1; AKwUvBzbIaOmgJsEmNV1mr+FAhLh48E6X87V+Xyizm3N7lZ1dEI28eSeRK0YYymhhNY3cGmKZaJX4ZLg8cuHih0a8C8=@vger.kernel.org
X-Gm-Message-State: AFuF++mVDVRi3fVbal+jy8x2PekaRrV6eEBaq3PAtDm+HYV7GDzuWxqq
	6+rFNRhKjS+BH8O48zPbxu6kpgTMsEF0W6Ro4qnnz49+no0ANAkjVBi2wPuyMeHpOCIaZf5Duzp
	DZZncrl0AUsSwHw7XasR8OGCh0QcN19PtACbM
X-Gm-Gg: AYBFou1oqziYyFcRq+jTfwalflEkUrHVqplvIXlGXowiC3mcEbskgm+yu6isCt38tAF
	klKQ7cqpY12VL1W4JGarCZWg/YOIgn+0Qy9yeMy4jw98c+4XmTRqJ8io658S3LblgB+4j0ubxFT
	7ag92y0VN0KLJ/Z060LbPWt82oEDQIJzpiRfzGrEdWthukGHrSlodeL5HjZOJWnmHeCIj2xgTO9
	RUwDQb5/N6dkqJOJHjKPJd8KS6k996IVoTeXCwGHHh0Me8ZVefKv3rfNNxIRed7VjAAR4pZufhe
	sQf54wts93K7DALGnt/UYtiJTG58V+4CQ/xGc5PrmLipfZchICaNfjOs//hEZaNWnSWWpJjJMC8
	6WhoPrBbnV4UNb//tKuFcAAnmUQmL2ENPffW6/Fn9
X-Received: by 2002:a05:620a:471f:b0:93c:2c15:e510 with SMTP id af79cd13be357-93ebd2085ddmr144845685a.37.1791534592672;
        Fri, 09 Oct 2026 01:29:52 -0700 (PDT)
Received: from cavan.codon.org.uk (207-53-253-74.PUBLIC.monkeybrains.net. [207.53.253.74])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-93eb9811a3csm31984285a.3.2026.10.09.01.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 01:29:52 -0700 (PDT)
X-Relaying-Domain: codon.org.uk
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
	id 72C7C12862CC; Fri, 09 Oct 2026 01:29:51 -0700 (PDT)
Date: Fri, 9 Oct 2026 01:29:51 -0700
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Matthew Garrett <matthewg@nvidia.com>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org, rafael@kernel.org,
	linux-pm@vger.kernel.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH 05/17] tpm: Add a kernel attestation key and signed audit
 digest retrieval
Message-ID: <asil_22hdNKBXH2p@srcf.ucam.org>
References: <20261008132532.1155166-1-matthewg@nvidia.com>
 <20261008132532.1155166-6-matthewg@nvidia.com>
 <c5d1b69763362db8a681d00d3325dd673c4db08b.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5d1b69763362db8a681d00d3325dd673c4db08b.camel@HansenPartnership.com>

On Thu, Oct 08, 2026 at 06:45:15PM +0200, James Bottomley wrote:

> Oof, there's a lot of duplication in here.  Basically you're creating a
> signing primary key (technically it's not an attestation key because
> they're supposed to be non-primary; this isn't a criticism because the
> only consumer is the machine owner who doesn't need to use privacy
> preserving AKs because they know all about the TPM in their own
> machine).  The primary generation routines that exist in tpm2-
> sessions.c:tpm2_create_primary() et al. already does most of this.  The
> only real current difference is that it creates an encryption key not a
> signing key, but that could have an additional bool argument
> (signing=true/encryption=false) rather than duplicating the entire
> routine set.

ACK, that's fair. I'll respin with that in mind.

Received: from mail-pf1-f225.google.com (mail-pf1-f225.google.com [209.85.210.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA633451CD
	for <linux-integrity@vger.kernel.org>; Sat, 10 Oct 2026 21:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791667230; cv=none; b=gzN2reaDwXpY8/aFhd51sdkb+rqZNbIIssI5Rcw+fYzNfFYeRvLrJ4o6TNoVO5NqhSDEkoqBJs4zRPEF/FQhMOadn1KnAZ4eOaxa6tZouaQTAaqooZRGh0zGGhBJf5JmaEwajkOQOTBMhSvsrEgHuWmcIz1nJFwM+eouG2a00RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791667230; c=relaxed/simple;
	bh=l2Rg6OHGxNhrquADY2PNe8wejzKKsSn3puAVABR9uw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fshiUCzqrDpJ8L0tuzIlsKMr9cWMTykWb7kRgm2arj21pG3WdwNHLh7Rx/RFPeC61wsKnGEpO4Tn072vXAq6sqhYwyAAG2++JZDtKmpc7m9MecqIGEldyMyCUwWSWPA8uUTnorHK6eP1/ZIwRs353QHC3JqjZVZSzwAgzenzS+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=srcf.ucam.org; spf=pass smtp.mailfrom=cavan.codon.org.uk; arc=none smtp.client-ip=209.85.210.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=srcf.ucam.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cavan.codon.org.uk
Received: by mail-pf1-f225.google.com with SMTP id d2e1a72fcca58-887beafb714so335767b3a.1
        for <linux-integrity@vger.kernel.org>; Sat, 10 Oct 2026 14:20:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791667229; x=1792272029;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FpfqyCSTiDIx8bI640+p9clkC+s+ooT/bqQ5SHe1jVs=;
        b=LeDsTK4h0i4MLz2GFEsAAyOkWKzxaTbNIuPAmnwLssE4hwYrmxOjaQc09fgXm9h/FW
         i0sFb+qPgdf1q+xQQw18e3exWi4rrGH7oqDrrJFRZCaN7lEPMDuacmAcdsSrYchHmJMC
         i5X2NKoRyxZXc6dgr+YIfbUoViHavsmyuU3EwDeaILhl1DGgXkrZCz7W1i2NvynZVDv/
         J1pW+Qt6DIT8SjrDHhDeZzw3h6CZXsN5AQdSnmmspYlIF+YG+AIguY1DYILUi8Q0X7Nj
         xlgGS6I+MRmT70oqYGtG/JN4NDUjQ2YqkAyYxUgCaq/URA6vYkXShwtuBAp/oCC1j7xI
         Tl6Q==
X-Forwarded-Encrypted: i=1; AKwUvBzU5MnWERJzSpxh11mrIE0Y2ooVFvKJjG3kxdq6TEW9b3836T1B1iLFJOPyAG9RESqwtCjMGl0y2eguOabXa0E=@vger.kernel.org
X-Gm-Message-State: AFq9FYKy4XQAaxUIyrJ9KwFZT0anM7M62kIzUvT4gfziVwlsteQ1NHtH
	B5iW9y5q4XnCDJeiM3M/Z3USeFKfg97QnpP9x7DtG1It0TGz/z/NsURAmk9tTrSWLW6hBgPyzMS
	M+egWrKet8Mpq6H1iIqdXOX3qAMqaHfmswK4HnsaWj/cwlZ1p9ORq
X-Gm-Gg: AYBFou1CCGIfOSW5Zd5/fZwm3kRrLk2nKiQEAA/y6zqx+u3+X2POyK4IeqCGxOd221q
	zrscFA9bVzbIQsK0+p2ifpxsCGVwRbk1bLdIfXvfLHV1w2k202cqHVWpowwLjleON9265keK+v6
	lFlxMR0e6GqP9KsaNzDB1i/mbUpHmM49jW9o/weu5nzOCu+qDkpbIPMnnx9bzLisQJHiX4piZxh
	ZS06xJutk9Njj2scSTS5bYIzwuWIbI7p8X+b8zxMUe58uQfTQYE2QteUjUTtWSF/1O/nlZlkKN8
	OlSNFXldDdV+rKB61YWTGx3gJVtA6yjKJFnEE1WtXnhuzGf1XpZ0cV9hjB5RVzNUMjbFaqmNynr
	hrco=
X-Received: by 2002:a17:90b:3d89:b0:3ab:c6d:2bf9 with SMTP id 98e67ed59e1d1-3ab3afdaaacmr5631535a91.57.1791667228755;
        Sat, 10 Oct 2026 14:20:28 -0700 (PDT)
Received: from cavan.codon.org.uk ([2607:f598:b99a:160:8a88:88ff:fe88:8788])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ab3780a473sm3281598a91.4.2026.10.10.14.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 14:20:28 -0700 (PDT)
X-Relaying-Domain: codon.org.uk
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
	id 0568D1287ADC; Sat, 10 Oct 2026 14:20:28 -0700 (PDT)
Date: Sat, 10 Oct 2026 14:20:28 -0700
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Matthew Garrett <matthewg@nvidia.com>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org, rafael@kernel.org,
	linux-pm@vger.kernel.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH 13/17] tpm: Add verification of kernel signing key
 provenance
Message-ID: <asqsHMX1YUUDdy75@srcf.ucam.org>
References: <20261008132532.1155166-1-matthewg@nvidia.com>
 <20261008132532.1155166-14-matthewg@nvidia.com>
 <aeedde06c51910afe5231d9f359bb8767c01b5bd.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeedde06c51910afe5231d9f359bb8767c01b5bd.camel@HansenPartnership.com>

On Sat, Oct 10, 2026 at 11:42:58AM +0200, James Bottomley wrote:

> This does strike me as very elaborate, especially the ephemeral key
> bit; would you countenance a simplification?  Since all you want is
> proof that the hibernate image hash matches the one the creating kernel
> made, you could simply create your kernel only NV index as a PCR and
> measure the hash directly to that.  Since user space is barred from
> writing, all you need is an audit of the measurement going into the NV
> register (indeed, it could be an ordinary NV index you simply write the
> hash value to), coupled with a read of PCR 5.  Then your audit log
> directly verifies the hibernate image hash and you don't have to bother
> with the ephemeral keys.

Just to be clear, "ephemeral keys" here refers to the ephemeral signing 
keys and not the generated AK, right? I /think/ that would work, but let 
me ponder that some more.

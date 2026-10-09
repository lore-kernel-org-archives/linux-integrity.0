Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900A8370ADB
	for <linux-integrity@vger.kernel.org>; Fri,  9 Oct 2026 08:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791534789; cv=none; b=a9qnQLUCvyrjsVF3PTDEW2SGHcS6hKZvy2cZW4SI8i6xqY6andDfLipbHLjvVdHup0gVpyDy9f1jm+sxtiEzU2+PzuuX5uzfm2bFO6SinQS7bprlTdZlhG3m5tr/JE4Ecit3kknc6X6RYC+A2N6Q322XORxaDhDdXDWwj4x7sqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791534789; c=relaxed/simple;
	bh=J4a7upmFwO+cU/sHwsmNf67cBdZkLVJd4Qid6QJFvAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Evt1ZCGUG0aVtByzMZJej/mzex31qQQtxGAJEqZjFr5tMnGm7Re2hzJp3+zrmegwGQrT9POrEtut0Jbztcwlop2OEBXH7eDnSsx36lCJsoq9Gxe1KaZevzEOsUTRxGe6lWnfZ9rjovQPfLjrwFgu/9uy+ER32MegmpwA1/RzFIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=srcf.ucam.org; spf=pass smtp.mailfrom=cavan.codon.org.uk; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=srcf.ucam.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cavan.codon.org.uk
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-2e5fb79ce82so16066015ad.0
        for <linux-integrity@vger.kernel.org>; Fri, 09 Oct 2026 01:33:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791534788; x=1792139588;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5SJdflHLsTV8n6Eka/t1oY8KzfLbWWcjpATxg+lrvcw=;
        b=0npqTafEgtZDiosh1OKDoSArpBtWnQyhgdaPx28WOYv99f7TBkYOqcrP3gubnqrei6
         iLjf5U173tvGpbPuS3sMdc5nR1qboFsHWVHNj0N1BkQo92RyvF6NpALfD84vhdoIBvH1
         npq1O2yNMxhVEglEIVG9SNu7f6RAuHHOhOBJPoIuEPg6rXyVkcSDtYh0d8RoZs6IYS3l
         dpx97DtJhZZJJqh4mBrP26rsxM0dSuehVTbqHNqMQtnG7Y9HCSGiaxkGEbMXZEskCWm9
         yMdhlJVTjrQ1qgsHIRoVlm6+CtSIjDhFQvHyEZK5sAnWmUukmpoRAyXGDrg5ptSmoXIK
         3gTw==
X-Forwarded-Encrypted: i=1; AKwUvBxDkiUex+MMP09SfRD8ShEUacnXJ1zGtdMmsnvQOPM2OVF4G+ZUQ0am8SjQMToly3osxlDliboTHGbMJf0YFdU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIqQziAlOzVNkFDll8imnmhvu/q1uLUkIf10INfgEFI58tIJmCC
	1+SBrpEz+bBGoNfhXdZ/+3pA2qKmzOOPt4ry2gagnofyGlxEAuazt/xq/foilhbY8KzGYar0KS5
	yM8IHXa5ONfKHMt8QIdow1+eqWLEmqlrs+5Ug
X-Gm-Gg: AYBFou0f7q2brQsO1bBuV3jF7V3qALqg5ib4cxG73e6DOzfXpRPu6Po8ECFmUkEfv0s
	059yFFpfizxRzX4/Poam8x0YZhf7xPZkm/zdvaRoQE5tu3s7ZjAQJ0vYxf1sg1X/oSbT8fC2qav
	ACc+4K7NNUML3MeGRWHNvWRID+WP+6K9cf7V7wXbi6k9ZD/KsH/2BlobPUEya2mGDHlp3FAEUqx
	MTAObzBHkRVgW0DImPbDYU2yzRxPWR6bvIKPJ13M03R0DifHkJKAJ2AXL5UjOZPNtqtFOCxYZOS
	xACghcWk++rGeHVThyLC3nSVLn9YYXzZeAAw5V4UZHYQpLh1UPAtM0z+Fg6EB4SVWKf9OhzQnPW
	E+iauA54e7XQvpcJGAMMRQhstKgjAijYlxVTdpM2X
X-Received: by 2002:a17:903:32cd:b0:2e2:d7d6:6563 with SMTP id d9443c01a7336-2e842ce162fmr8538245ad.43.1791534787870;
        Fri, 09 Oct 2026 01:33:07 -0700 (PDT)
Received: from cavan.codon.org.uk (207-53-253-74.PUBLIC.monkeybrains.net. [207.53.253.74])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2e841f88d23sm606575ad.22.2026.10.09.01.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 01:33:07 -0700 (PDT)
X-Relaying-Domain: codon.org.uk
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
	id 2332C12862DD; Fri, 09 Oct 2026 01:33:07 -0700 (PDT)
Date: Fri, 9 Oct 2026 01:33:07 -0700
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Matthew Garrett <matthewg@nvidia.com>, keyrings@vger.kernel.org,
	James.Bottomley@hansenpartnership.com,
	linux-integrity@vger.kernel.org, rafael@kernel.org,
	linux-pm@vger.kernel.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH 01/17] tpm: Define a kernel-owned TPM NV index that can't
 be modified by userland
Message-ID: <asimw1D5J0ZqM4i3@srcf.ucam.org>
References: <20261008132532.1155166-1-matthewg@nvidia.com>
 <20261008132532.1155166-2-matthewg@nvidia.com>
 <asfDZiuFKCuuRysC@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asfDZiuFKCuuRysC@kernel.org>

On Thu, Oct 08, 2026 at 07:23:02PM +0300, Jarkko Sakkinen wrote:

> > +static bool tpm2_dev_cmd_is_blocked(const u8 *buf, size_t bufsiz)
> 
> This function could have less generic name.
> 
> tpm2_dev_is_kernel_nv_change?
> 
> I'm not a huge fan of this name either but it does say quite clearly
> what the function does at least. Just a suggestion.

I left it that way on the assumption that it might get extended at some 
point - maybe that's not a big concern.

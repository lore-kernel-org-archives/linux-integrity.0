Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C883F49552B
	for <linux-integrity@vger.kernel.org>; Thu,  8 Oct 2026 13:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791466886; cv=none; b=EtDxLxIQUh9ccI/eRMiEI7QHWLFjoADT/iR6aBianGcAuzJO86UA4XEmE5G3LEDR0wm3W+v/3yrgvnTy/8/bgtm5LZZO+bPFMAzz7d9GQMNHmkb6Bo4GDrSPdRhFRM5eaatK53+plH1gH/u0YdsAs/cOpHD2e4XxxQw6gbDz6X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791466886; c=relaxed/simple;
	bh=XezWRLY9lxI5ComY59DgZ5KT78+aaYpBiaD6Ktv8gIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VsUYvJDqDw05fbUChPAL2ePg8uNkW63GrYOyTM3NM56YjDpJpvhZ0dpijVJ3WK80fgdmdKBL0tFD1mc8Vj+mYHtCjVt+BW2/NX9IZY+M4jbIhKijxpO6ceLHSVhQqIOGDTJAtIUDXW2OZoQztTJQVxudAO8Y43ih/2ziZtd/lJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=srcf.ucam.org; spf=pass smtp.mailfrom=cavan.codon.org.uk; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=srcf.ucam.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cavan.codon.org.uk
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2e6038cebefso16392355ad.0
        for <linux-integrity@vger.kernel.org>; Thu, 08 Oct 2026 06:41:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791466884; x=1792071684;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1j9k5OlTGty7BZhrOeehSiHjb4OZRtbs/bCekRUx6wI=;
        b=mnWCQ9VWk9B7NSbhx15pTxQA0a+Xbi2zPTWDyCNWgG6hJ9ydbVsyZcTs1jEoZwU/4O
         CkDpMb5T3sVyummuS7pXVvyLr7DQG1wbeCGW1hsQsTkC5ms7rshCZnrHAoiV+lJW8pIk
         0iAj+IrguLFahQSuMUYmgAdDS92t+LlaJ7TBFaNJUWW8MqH/GnSvIhn5+HLkk3JzPsVk
         bG57ujSDtKCMiC7mOdF8d5CQcPS7RiF3Xjavz1y2NtU5pTK4Yue1G9RB5fWCQ2GMYVCC
         S1xedtlIIRRpyuCx27LrP8388OzeryFCqSKuZ0W7RgI4C2/H23wB6ucMIwtrwV8r2dGP
         FevA==
X-Forwarded-Encrypted: i=1; AKwUvBzRJ5hTkRpi1TXPRR9EmE2jjBRm5FqNHycyxzKhAvmEMeQ6XFL6UTQB6gGTLQTE3yRv+Wr3DGw1SoHPRA1xEwU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIFZbpyGPDzf36y/GvklJpvDv3qRsky25lP1CkjVkvOuGbD/5ja
	axpCLibACg+CaXlHbD78qtS2uNGNwS09fYe8rNUrA9gNDVrxANstMIlD8glDsR9DCFQ2/iO24Qk
	7SR64OMaZl6ilTLxrxEZpVAGDiYignlD1ytVUVQLlx4gXjmRyposH
X-Gm-Gg: AYBFou0G5VwnwA2/dV06Bn+ia6FPhUGxmV5gjiTpSY8l5SqMvvIafGbl8UQ9Ka5jAUb
	yKLUk1DMGJWd5l2Qbh7dHOXRCxRVkJKteV+c+AD7zTc72QIduCnYsy814gRIhkHYn/mZ2hLyzcA
	3A51Bo8RbyxUzgiAUJsEXknDjyUlFV3uUafDOI9RTyG/La876ODXyZSCXzuDvT8QabPnI1ohviq
	0HY8Aab4lYha1OBYFfhJwlwjbtWfzCw1J7zqDKcgxb9vnOKgQ1CQcuyKoLrNrzGzz4bjPyID+nH
	NZxJfeuGdAwj7egGlJxjv8fHL0ot/wDqyLZD3wYQIkN0c7xMK9+TBEiyz/15dLXCT472EFgct79
	Ik7Q=
X-Received: by 2002:a17:902:ce07:b0:2df:7fe1:72b8 with SMTP id d9443c01a7336-2e60038d0e2mr50963895ad.16.1791466884035;
        Thu, 08 Oct 2026 06:41:24 -0700 (PDT)
Received: from cavan.codon.org.uk ([2607:f598:b99a:160:8a88:88ff:fe88:8788])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2e6048443f6sm2131865ad.51.2026.10.08.06.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 06:41:24 -0700 (PDT)
X-Relaying-Domain: codon.org.uk
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
	id 37B8D1285603; Thu, 08 Oct 2026 06:41:23 -0700 (PDT)
Date: Thu, 8 Oct 2026 06:41:23 -0700
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Matthew Garrett <matthewg@nvidia.com>
Cc: keyrings@vger.kernel.org, James.Bottomley@hansenpartnership.com,
	linux-integrity@vger.kernel.org, rafael@kernel.org,
	linux-pm@vger.kernel.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH 01/17] tpm: Define a kernel-owned TPM NV index that can't
 be modified by userland
Message-ID: <asedg6XdGkOaQJ_E@srcf.ucam.org>
References: <20261008132532.1155166-1-matthewg@nvidia.com>
 <20261008132532.1155166-2-matthewg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008132532.1155166-2-matthewg@nvidia.com>

On Thu, Oct 08, 2026 at 06:20:17AM -0700, Matthew Garrett wrote:

> Reserve NV index 0x014c4853 for use by the kernel, and filter commands

I should emphasise that this value is very much a placeholder - please 
don't deploy this patchset anywhere until we've decided whether this is 
something that should live inside the Linux UAPI group range or whether 
the kernel should own an independent range.

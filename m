Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C283AE194
	for <linux-integrity@vger.kernel.org>; Wed, 19 Aug 2026 14:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787150407; cv=none; b=N1B7yebkqxC+bKX4UONdW1Xu/XcOpDilc2JduglV/29FrrxY6evdLDlUkS+m11/BDGPdP3vp7WUIbS6s2KD3mTvvBxjz492/1qQeXSV2tcGcmyQWuGXg271pX4XL388EL0WcK6bho2AzxCbOhkrmaAkguaaz51I/f2Dg839CAjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787150407; c=relaxed/simple;
	bh=59VIFuHIEPnIpLqOvW7ZZ27FmwMymtX6CNna+u/WLZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oFJwYs7kZ9zaCQlRV0mZu1YoQa8v3nb/q6ogQF6t3Yge759auGfDBaRY9thot9XWPHSNn3KPvxHicob7ac9bL2EJLQd8j4jqJ1e7aIBYxyg/jno4axa9PV1Pm8OEYwHD13SpAlXRmOEZgdSPWgRKyfDzxcmrpv7zF5f0jstlthk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=cQmhGe8Y; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="cQmhGe8Y"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6a168dc590cso904131eaf.0
        for <linux-integrity@vger.kernel.org>; Wed, 19 Aug 2026 07:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1787150405; x=1787755205; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XXzcZsy7hW4pGsTmoBSQRX5B4jq8GHlbDv+EwOBktmw=;
        b=cQmhGe8YyoVUc9PPTRh88wDS302ztv4mQpdl94dbyZkpYyRMcSMmUi5oZJZVkyhQZe
         qiwsF159OQsQ6buOVEE0866EDnCEXm1K/kChE4N98427ueVtyUfGB+96OTDah1WoV8nl
         SLLdWOQu91knGTzIEixTXKpO7CfKTbJ//Abp3DM/lVCwLEHffVGP9MnCqPO2vNGvxXS/
         yR3Eqhhtg1Naz8YhDFyjkjJ7RS78o/V0hYCMzmQHDVpenXbzxWFKiperOdBXXsEJIDTc
         KkYJeW1GY5SFR8ZrfQmGzK3pA7WaqDapNkTECuUsjPaZdEflprLH7cwceG5az55x94LV
         mzRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787150405; x=1787755205;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XXzcZsy7hW4pGsTmoBSQRX5B4jq8GHlbDv+EwOBktmw=;
        b=W7XZ/ME6zgFnvSYoOLlTPmeQLi3OrW2ptFPO/XqJWWS24MLInvzSc78bx0kAKjnlRJ
         wwlSYar/cPhiwJd4/+9LSOVv7+ntsRGCi004Kis1ZaqDGjD2xNmkttcHOJT/ETRC3fpk
         4y7sBFcIGUuwy0TfkpUdqRqvYdb8neAMZ3pzrJKVlcjB9da4/uvvXYYKb+0OSDdTeanm
         4hfR2iC64LMZRqTE+nViKTSBbjZKk9klezOaNEO5XH5b1gSQ+L35Ow1gqviEuxUIqmzF
         5aoxHG7kuOOrMEd1SRrFbGKdcXREiCNn78r0feg48vCQRI1dPgH7h1zNb/RCUhQwwrvr
         Jajw==
X-Forwarded-Encrypted: i=1; AHgh+Rrcncx9gdkUQwMJJOB+m5xWeZkT5lSul5G1RtloM0nwlEjhL+YI37iREHWcsbiwTqzoKtfJrrInHB6Ge+etdf0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbDKBEWyC4doHqKfXNvtiOXR91ceGI4+Tss7VCo9MO7ItgGwRt
	PilhXZIUzVyKW1fPkINdoqpnrcWGIOs+/FAZHM8IVtCUEgr4lMeMxYPeOhmgHesbLA0=
X-Gm-Gg: AR+sD10rLGCeiIqxAnpoCWnaBtwAs9pN8h9uUWQ7uIp4BATxsHhk7OphaqdyfVjNqiL
	PsVWOuyHY3/iUhVGTB+MgfNcAxhiQ0LHp2ui2L6MA1UQFTCbRSnjNUUQOqVFQ49VOJ9l5mc6Dkf
	ka9ayDS25YIySEpWXbcEofDvNHSQMDLrbuaUuD64mNdw+Loq8+/2x7+2FNbsFe+CEOziaZF33Zm
	08/d19MS9ingRLhdB2fAJTQztFZJUbm8jdVribHhG1Te09QaBy1QfSyRvXJtv6UPc3V0xmmOJ9r
	ZnnHcjUIKiqSIwXndNpo3kOr45F8B1kxNJ9gMxW+qVt5FhVcAPGw72tszxIikMfOtqVygU9mZ3n
	Rm8n5Mzlgx87N2uyVmpvbZBA/DORQNJONZJNOjzoUDro/dnHxFYfuooPD9N3MjkT5btfWr+kdJD
	YtPzA1nrV7irgljvqNsX3HxFkGnO9ND2oeOK09zI0Cv2oU
X-Received: by 2002:a05:6820:1988:b0:6a1:80a7:2c8d with SMTP id 006d021491bc7-6b13c611146mr5172325eaf.32.1787150404578;
        Wed, 19 Aug 2026 07:40:04 -0700 (PDT)
Received: from CMGLRV3 ([2a09:bac6:947f:3af::5e:84])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b13c90d160sm2123919eaf.0.2026.08.19.07.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 07:40:02 -0700 (PDT)
Date: Wed, 19 Aug 2026 09:39:59 -0500
From: Frederick Lawler <fred@cloudflare.com>
To: Breno Leitao <leitao@debian.org>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH 1/2] configfs: move CONFIGFS_MAGIC definition to magic.h
Message-ID: <lr2ysbkhe6nk4bf4roguv3x4lau76clypwc4gkpebfx5wgm3qb@qpxxabipfzmg>
References: <20260818-configfs-v1-0-a2329043cf86@cloudflare.com>
 <20260818-configfs-v1-1-a2329043cf86@cloudflare.com>
 <aoV1hRKX1yb5vKrW@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoV1hRKX1yb5vKrW@gmail.com>

On Wed, Aug 19, 2026 at 02:21:58AM -0700, Breno Leitao wrote:
> On Tue, Aug 18, 2026 at 02:35:15PM -0500, Frederick Lawler wrote:
> > IMA shouldn't measure or appraise configfs, but currently does because
> > it's missing from the default exclusion policies. Move CONFIGFS_MAGIC to
> > magic.h to expose the file system's magic to IMA, as well as other userland
> > applications.
> > 
> > Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> > Signed-off-by: Frederick Lawler <fred@cloudflare.com>
> 
> Reviewed-by: Breno Leitao <leitao@debian.org>
> 
> > +#define CONFIGFS_MAGIC		0x62656570	/* some random number */
> 
> 0x62656570 is ASCII "beep", I didn't know that :-)

I can't tell if it's a better joke to leave "some random number" as the
comment, or to change the comment to the more interesting fun fact about
the number.

Best,
Fred

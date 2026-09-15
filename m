Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683C5282F10
	for <linux-integrity@vger.kernel.org>; Tue, 15 Sep 2026 21:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789506510; cv=none; b=Osyzem6eTgBRXo1hQR4LxquKknsHKYk1H3gxE8W8bPQl1Mr44fUrbxEC5CCmwNvgNfizdWOpYSQNYstfrSC1zFf8G68MHv6X1ixTC/9ySu+0QSmdj1o3jEaAyJ+/rftDf1Q94yHLCuZGnq+zJMR6cWFaNbh4M0FjZ8VpdsLzfDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789506510; c=relaxed/simple;
	bh=OVt7rF2uYXd5FqrcxZJpOUDanDLfPylOQanuOssiHlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dt8qmNC8JLvTSq1t0lTYv13EVCh/1ZaEE5fND72DhgVo+pvqL0CK3wr11BvzQpudXdX/FRbEKUHuc3R7jXvxVoxKNpyK/YSJHf6Eet6cjp+JK6QkgeP2AMsDYmRNVI2Xf5IlvLfgJTjffhdfTTpqTYAHaDeKYqBCkBoUGl3W6N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=T+O0YTZv; arc=none smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="T+O0YTZv"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-466cc9b2f02so65095fac.1
        for <linux-integrity@vger.kernel.org>; Tue, 15 Sep 2026 14:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1789506508; x=1790111308; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0ZAGGN3eayfShEQqBKliqu7mRVw6xYFjSDe0eN2CZjA=;
        b=T+O0YTZv/scLmh99eR7Qpp2zdQv83w8txdifPfjRGkSBLYbD+P7eDNE6aOMuYDkLtL
         ZOjzOWftGiF7Aiu4zdADCezcUGPKD3sxfD0BoFhPGqSB2y51h8PJL/xj0Ry77lisCZVH
         XEHR2J1nt0dslheQPFK1q2A79VnxXvl/pGesnFpPlimkj3cPpcxHaVY/wrmT+8AifDBP
         DQXb4TnZ9nLWnRxfgFjWPYCFBPd/uBvMUUaSD7/aTW8JkGtD8+mZz+4vjTB6E7TCy85i
         ychwv7G2lLL4Af1ivG0zt4PlKKrheiMi66NY4TLSFeiF1OtlZ5nW9cJsaJYaTlvQ0U3v
         LduA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789506508; x=1790111308;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0ZAGGN3eayfShEQqBKliqu7mRVw6xYFjSDe0eN2CZjA=;
        b=kFJjcnT9T20zKbWiVrua/KzS3AB4NUBUlekp+Q8y4AytvcNOzZBNSYp1wZwxIlUBEn
         /oOjukTev5msZO0F4nnTPfVFJdr72rdmTh2+LOIiNKsMD1cpUPqdUEEI8tJopFzcV3NT
         DLDE003tmwYpKYFaTBjSEV0q9XZQ/3eyJkM756Y44m7Jz6tz0IXhKGIfIbG6rJDhGjFi
         gAriObgw9spjQMfNybIK/snQCKbkyB18il/GGxnf1TKftPbe5yq9eVjKsaO9rbbUgUbh
         Wz4OQaEx3p9w/mD9S9KmYCD+8xlFGKoHYap0Ro/9wwasEt3JPtRrbO8dhtTeM43GiuWO
         IOWg==
X-Forwarded-Encrypted: i=1; AKwUvBzeFN52kSwCtPastuRlCSol1Qp2aMmPJBO5Gfu2hFnod0NLA1cjv4dPPmN+gkVwLZ9FgSRiwCHCHDaV8IVC8Zw=@vger.kernel.org
X-Gm-Message-State: AFuF++nIFZzl9fnKQPj99gVCeAIPNiHggPp07ox0dOJ0U8M/MQRQ5hus
	iLnb/0jLgv0KR9sZ5uDKl7HC+v5zF2svRP5vA50gSRXq0y/UocV30c0+YC67+KbJBF8=
X-Gm-Gg: AYBFou088zE3cpnZjyXYp+9YawXWxPcpeRnG/qWWxRQo0juT4fZQr3mk4gl/+jApXhC
	+4JT8vAghPrYdIGJ/hTXOxvVKJwR6t5QJIA8Y+ybWS4LGTXiH3G6v2wGGq9vfx6z70W8k2/+voL
	mhlu154rHYbBKSWd8prCDmh5C1CdxMNxonjtVKyNNJ3kRMCfPFkOvQ/gKwuYVBjQHXgoVoLvpks
	hfMrZKjJ9+epoHXQWgMCxcXig7wFSKNw/B1kYxa0JGzDUAtwa5VScnpwN7ML7sFYeKjyV/I1oVK
	NNNYUCciQ39ONFY45MybR3a4hJNlakQLWe3xwjPCQJFvSKaOsRbVQESn0imXgoM1mtFt+OrMpp4
	huqbduH8jppwclvttky/GCkCPmftA5YiAuy9tSxc6E0Qr3rSRZRKH/xnUYK5TKmTVsQcLGL9iJi
	DSRfphmHuhcV+pJKXKTr7ZrdYhrBwgYo79L7yalcGR1dEtsdv0kj+z
X-Received: by 2002:a05:6870:e0c7:b0:470:e96b:43e3 with SMTP id 586e51a60fabf-482e56fb3d1mr3685772fac.15.1789506508396;
        Tue, 15 Sep 2026 14:08:28 -0700 (PDT)
Received: from CMGLRV3 ([2a09:bac6:947f:1800::264:ac])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-48429a91b9asm997942fac.6.2026.09.15.14.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 14:08:27 -0700 (PDT)
Date: Tue, 15 Sep 2026 16:08:23 -0500
From: Frederick Lawler <fred@cloudflare.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH v2 1/3] integrity: Replace all uses of
 integrity_audit_msg() with integrity_audit_message()
Message-ID: <ykq6awewbz2f4ckgwrwnubcprlta2trm24by6bw3z2q6u6mr43@gn6ajl46tc6r>
References: <20260727-report-hash-error-v2-0-30e394f524fc@cloudflare.com>
 <20260727-report-hash-error-v2-1-30e394f524fc@cloudflare.com>
 <1214eed319ccb441ba0cd26ce168a0383a3e41c6.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1214eed319ccb441ba0cd26ce168a0383a3e41c6.camel@linux.ibm.com>

Hi Mimi,

On Tue, Sep 15, 2026 at 04:00:34PM -0400, Mimi Zohar wrote:
> On Mon, 2026-07-27 at 17:21 -0500, Frederick Lawler wrote:
> > integrity_audit_msg() wraps integrity_audit_message() such that
> > error codes are hidden by passing an additional parameter to
> > integrity_audit_message(). Since this is a wrapper, we can replace
> > this function with integrity_audit_message() introduced in commit
> > 2f845882ecd2 ("integrity: Add errno field in audit message")
> > 
> > No functional change intended.
> 
> There's an unintentional change in ima_write_policy(), which replaces the
> existing '1' with result.

Oof. Good catch. That was intended for the later patch.

> 
> > 
> > Signed-off-by: Frederick Lawler <fred@cloudflare.com>
> 
> Is renaming integrity_audit_msg() to integrity_audit_message() actually the
> right approach here?  integrity_audit_message() currently has only 2 callers vs.
> ~20+ for integrity_audit_msg(), and the rename forces re-wrapping of every
> multi-line call site since integrity_audit_message is 4 chars longer, bloating
> the first patch.
> 
> Why not simply add errno to the integrity_audit_msg() definition and callers.  
> 

I can switch that around. I assumed we'd want to keep _message() since
that was wrapped by _msg(). And not dealing with the line-wrapping is
better.

Best,
Fred

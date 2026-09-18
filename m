Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFC6524AE0
	for <linux-integrity@vger.kernel.org>; Fri, 18 Sep 2026 21:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789765925; cv=none; b=oM6za16dUgwtnDaxIm7kCEuLKm/cVs0p0/qzbXPUg/lZzCyF6FRziQiJCcKHuHFZjoyPhYbt7wZ4mGutKPbN56zBjSu0H8hUwyO70Dk3jDv3cIB7kGNdW8p506nb5dtTF5a3dfOlHCnJOIo0oRvQdlEIYyAVAFHHDGFZGmNLlU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789765925; c=relaxed/simple;
	bh=g4lx2u+ot1L81/J/UgHU7Wj2kq/pV6QiVmT+UZI0pAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aA4tzy/Os6uXejdZTBT5QcXMCT4NP/y9lJAZAZb+bRrvwbb2ft32H437c9By4eqfBBHyUNYjvYFDUxllXafocIMGe/p3ShUrIfau9Qtif0Q68FzbOd8Q1L2gbKGahzd/vhBdcKU/GR/kWRO1OuO99eZKMyw8eKnooSRze5tzWEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=fklhwivi; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="fklhwivi"
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-85d45ae011cso12844787b3.2
        for <linux-integrity@vger.kernel.org>; Fri, 18 Sep 2026 14:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1789765923; x=1790370723; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yhKm/9XBDPOEFCi2fB4i14ffVbBzYqLX1m78dQNPvjk=;
        b=fklhwiviuJLyeud7FMEOqT+J16Me7ZwSdZtasmj9pYBQFXnlw6hQLLGh0xNjHlIvGJ
         9jlgEa6fkIemuMYOeENpFCCiDCMFSRTxkrj1HSTCYqpl2dJhSiyDZ/k9wK36011+0SnN
         d4/M8aGVGSgRrw17YaauFEvnJYIVZPqoe8L0R0yXciDC2Bvv2QPcjz0/fDtiJ48E7rB5
         SIhico+J2c7Vc2ca9TUPJT0ZYCqfahYHo9tWc7p3YmcSl27sZU9r7Pl9p/X4/ki9P/O8
         hG0oHe84oyOcrWc8eFrLlaRviUJ2EzN4e24nBFQMmHfMfQhoKjnvcLh4LHrraPs6Z/VR
         /Clg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789765923; x=1790370723;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yhKm/9XBDPOEFCi2fB4i14ffVbBzYqLX1m78dQNPvjk=;
        b=2QXKJPz6TpBSik6MwiRmEpaz02gIxnuGxPXTRVqGcmuZLAj2+c8LtZyuhKw8rhrpRN
         TEFSNszlcHo2FHbGzqOr4orL7QLFKXcW4TXnovEZNQq3eSA7scrbS18MVlVepv7YJG3C
         JpUk0ymRbntElzxjM5F670RBzKCbMskWocL4QWZLYw3+vsMPQF5gKIG+eJcsgGvKjmd0
         fbKqTTRD+V+LmxKmhwHDCP6rq20Xv8cRaPnE+ymZxvzITeljLsLuf0X0jIcpZieeD/En
         vDDSjNMk0oWGkHphoOagi5PPoFwlzAjpCFHTMMWJoU9+XQgMOSl4RBYcmIuK4OYgm8RE
         nkYQ==
X-Forwarded-Encrypted: i=1; AKwUvBxiWEi21+oX/51QSfH1JkXiD6sxpS2nE2AsQmbO20Gi0L/26P+/UHfvTc5EGXAyNBFwQ+yI/y+x7bJywQqmPoE=@vger.kernel.org
X-Gm-Message-State: AFuF++nKPNgpgN9OeqlDQ2cy3JZYNDMfFmKTiXFaAG21IowFjhx7bAgW
	e1MX7noEY45YrtmYpXofQKcwz6UY76pLUygrcPyeRRp6tPd9rXZG05skqPf3RERaLWQ=
X-Gm-Gg: AYBFou0m7mgnddzhEWrjeSP6XitQN8zLy8NNqsMN6KveDqN6jik0Ittg6M6M/dGO400
	PhbMdJqOE9cOj3F2Rfjgx8cDpKt/kZqoFlYkdjPbsHiXM+EDwsZYEQmWdshjrvFA5lkGPFBrveo
	ngKYLX65yBWAed2l86rXB98nk0RBvNxuttF189IYIyPWKRyNPwEmuXToa3e7bjXGd+2tGKEhj7n
	oaQLnD8ap2ZHffyBU0CJEcBwDakoJoUk6eiW524eRTwZYx3AyEAsi5/Gi8/7KCIo4yNU/NPwlRf
	MYemPhd2JlKXHC9s0XUfDApKSWSy2wc66b9EYKEdLQWPXqVMaINqrKKn/DpjTpOwCbgRhmeN6zX
	vjPUQP1st3rCNqfWsr5To9O+AEPbi4TRTNIYBne/8/1y/apBdIXCHydZmWIERj9VwyMHKukgHbD
	Iq7dzZOWp4I6ESi9qHnfrr9birOaKj8/FccwNMrQuaEizKA8v+4Q==
X-Received: by 2002:a05:690c:81:b0:89a:63bc:8cb with SMTP id 00721157ae682-89a63bc0bdamr3178557b3.85.1789765923383;
        Fri, 18 Sep 2026 14:12:03 -0700 (PDT)
Received: from CMGLRV3 ([2a09:bac6:947f:3af::5e:5a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-89a4152081bsm3995547b3.2.2026.09.18.14.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 14:12:02 -0700 (PDT)
Date: Fri, 18 Sep 2026 16:11:59 -0500
From: Frederick Lawler <fred@cloudflare.com>
To: Enrico Bravi <enrico.bravi@polito.it>
Cc: "zohar@linux.ibm.com" <zohar@linux.ibm.com>, 
	"roberto.sassu@huawei.com" <roberto.sassu@huawei.com>, "eric.snowberg@oracle.com" <eric.snowberg@oracle.com>, 
	"paul@paul-moore.com" <paul@paul-moore.com>, "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>, 
	"serge@hallyn.com" <serge@hallyn.com>, "jmorris@namei.org" <jmorris@namei.org>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, 
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"kernel-team@cloudflare.com" <kernel-team@cloudflare.com>
Subject: Re: [PATCH v3 1/2] integrity: Report error code in
 integrity_audit_msg() call sites
Message-ID: <zu2rdshqwc6t72q22nayydud222ecic4ca5inzvte5lqtbnkfu@mcq7ta422era>
References: <20260916-report-hash-error-v3-0-73e5d95e9efe@cloudflare.com>
 <20260916-report-hash-error-v3-1-73e5d95e9efe@cloudflare.com>
 <132d83cb5dcfb6fa7024480626a829b4e03309f9.camel@polito.it>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <132d83cb5dcfb6fa7024480626a829b4e03309f9.camel@polito.it>

Hi Enrico,

On Thu, Sep 17, 2026 at 10:58:22PM +0000, Enrico  Bravi wrote:
> Hi Frederick,
> 
> On Wed, 2026-09-16 at 16:36 -0500, Frederick Lawler wrote:
> > integrity_audit_msg() hides error codes by wrapping
> > integrity_audit_message() which obfuscates the underlying reason for the
> > failure.
> > 
> > Update integrity_audit_msg() call sites
> 
> here it could be mentioned that also integrity_audit_msg() itself is
> updated.

Good point. I can see that I may have not been clear about that.
  
> > diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
> > index
> > 2a0bca5543161912abe2a0236c9fcae7055e62bc..6d2ef44b21f8d40b4981a6a441cf7c3d69f9
> > 4dee 100644
> > --- a/security/integrity/ima/ima_fs.c
> > +++ b/security/integrity/ima/ima_fs.c
> > @@ -595,7 +595,7 @@ static ssize_t ima_write_policy(struct file *file, const
> > char __user *buf,
> >   pr_err("signed policy file (specified as an absolute pathname) required\n");
> >   integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL, NULL,
> >       "policy_update", "signed policy required",
> > -     1, 0);
> > +     1, 0, -EINVAL);
> 
> Here it could be put -EACCES as errno, being the value returned for this case.

Sashiko said the same. I kept going back and forth on this one because
of what the message actually says. EACCES is the result, but the string
itself + pr_error() implies that it's an input error. Similar to
ima_release_policy() below, I should probably keep this zero, and
follow up.

> >   result = -EACCES;
> >   } else {
> >   ima_measure_raw_policy(data, datalen);
> > @@ -745,7 +745,7 @@ static int ima_release_policy(struct inode *inode, struct
> > file *file)
> >  
> >   pr_info("policy update %s\n", cause);
> >   integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL, NULL,
> > -     "policy_update", cause, !valid_policy, 0);
> > +     "policy_update", cause, !valid_policy, 0, 0);
> 
> Here maybe it could be put a conditional errno, based on the validity of the
> policy, instead of hardcoding a zero.

I can see that making sense to throw a -EINVAL on it. The function
is designed to always succeed, but it might be worth pulling out the
error code from ima_check_policy() for this case.

Best,
Fred

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C56E305688;
	Mon,  5 Oct 2026 06:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791180326; cv=none; b=PcLSkEuj5KZ2SQY3nLOUzhSoRAgZ0jpYNqyG+2GjGHaL4I6Hj6PMPAGTc9Gu0Tlx4ElVeMj1LOJs37BhEGcRCFbcbSPgdWn4yvRw1hYjmmLt1NFdZv+FsQ1pEBMjWwy/G+ulrWzxVqY20Pi3jM+G9P+A2yzk50swvjsKDkRgm9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791180326; c=relaxed/simple;
	bh=f5sxASX+r/nf24tWYtHXoCoWhjvTL7dVqzyJPQqjbZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VwT0p0fOIP5yvlLUgr7CGd/L5j4v5EoLJR5oB4HP3Rjj16+nKVSAQh4tmhHyMR+Bt/Kb2wHbU2unGHEhGOV0eAvrd6CB6SZLIZnbUnmEP+XeCbFA2pGkTC2cC3qZiJY7EGoUB5fC41d0l0XKxugxISk+cSRRzS86CZwmgJpOOns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DggYEA8c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DggYEA8c"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 418001F000FF;
	Mon,  5 Oct 2026 06:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791180324;
	bh=f+pt56rWm5hGQsNT+V+bU3++Dq6w9hAmof9jEbwdPNo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DggYEA8cOg0ngvTP595y4TJkFpp0EBU8XfUpoHB0XN/8XLdy1UMosGtVjwVTJ7SzS
	 aYw4fAVoigMk8hxGKQpg/KFICiwnTA1PDvCMFLGTyKnVMkEDTdiH+fQlAkyACDX7De
	 L0XL2nC8Rux4j30NFZ+834O/UiXjp8QrmC78PPjeuUgAmSUYncGuLZ15jUz/AR1iK9
	 GJ43656CT6OvhJaS3etrWTd0BnL7GQNpYmYZZSlT3ppGEVAs6IDWp0wp0dbNumc+kv
	 d21arLYPhR7Jt6+n8uHq6JXahIgHqnzUDS2+cIeffWB4/6yrB1kdXG2kSNDD83tLRJ
	 oABKLQStLRkvw==
Date: Mon, 5 Oct 2026 09:05:20 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Pei Xiao <xiaopei01@kylinos.cn>
Cc: Jarkko Sakkinen <jarkko.sakkinen@iki.fi>, peterhuewe@gmx.de,
	jgg@ziepe.ca, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] tpm: fix log messages in tpm_init()
Message-ID: <asM-ICLM-C0ADrAL@kernel.org>
References: <cover.1791015549.git.xiaopei01@kylinos.cn>
 <de8bafc78e84dc6abc6f11e8eaa1b91c17e0c368.1791015549.git.xiaopei01@kylinos.cn>
 <asMdetm05nGIBbyn@iki.fi>
 <aa976135-27f4-4c4a-a9e0-a5a3347b514e@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa976135-27f4-4c4a-a9e0-a5a3347b514e@kylinos.cn>

On Mon, Oct 05, 2026 at 12:23:31PM +0800, Pei Xiao wrote:
> 
> 
> 在 2026/10/5 11:46, Jarkko Sakkinen 写道:
> > On Sat, Oct 03, 2026 at 04:27:55PM +0800, Pei Xiao wrote:
> >> Make the error messages consistently prefixed with "tpm: ", and fix
> >> the tpm_dev_common_init() failure message which was wrongly copied
> >> from the previous step.
> >>
> >> Assisted-by: GLM-5.3
> >> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> >> ---
> >>  drivers/char/tpm/tpm-interface.c | 6 +++---
> >>  1 file changed, 3 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> >> index 1ccdbde98b69..666a1c654c02 100644
> >> --- a/drivers/char/tpm/tpm-interface.c
> >> +++ b/drivers/char/tpm/tpm-interface.c
> >> @@ -524,13 +524,13 @@ static int __init tpm_init(void)
> >>  
> >>  	rc = class_register(&tpm_class);
> >>  	if (rc) {
> >> -		pr_err("couldn't create tpm class\n");
> >> +		pr_err("tpm: couldn't create tpm class\n");
> >>  		return rc;
> >>  	}
> >>  
> >>  	rc = class_register(&tpmrm_class);
> >>  	if (rc) {
> >> -		pr_err("couldn't create tpmrm class\n");
> >> +		pr_err("tpm: couldn't create tpmrm class\n");
> >>  		goto out_destroy_tpm_class;
> >>  	}
> >>  
> >> @@ -542,7 +542,7 @@ static int __init tpm_init(void)
> >>  
> >>  	rc = tpm_dev_common_init();
> >>  	if (rc) {
> >> -		pr_err("tpm: failed to allocate char dev region\n");
> >> +		pr_err("tpm: failed to allocate TPM workqueue\n");
> >>  		goto out_unreg_chrdev;
> >>  	}
> >>  
> >> -- 
> >> 2.25.1
> >>
> > 
> > I NAK this one. It is not fixing anything.
> Hmm, this is a cleanup, not a fix—just a very minor change to an error
> log/print. I noticed it was duplicated (with the alloc_chrdev_region
> error print), which made it impossible to tell which function call had
> failed (it might actually never be executed). So I just brought up this
> cleanup along the way.

If there is patch that is coming along the way, it is patch that should
not be sent because:

1. It wastes also everyone else's time.
2. Lack of understanding of cause and effect because by definition
   you have no idea what you are submitting. E

Pure clean ups per se are already something that is usually best to NAK
but this patch is not a clean up.

I mean the path is doing arbitrary log message changes. That is not
harmless change as you enforce your arbitrary preferences also for few
billion other users. 

Br, Jarkko

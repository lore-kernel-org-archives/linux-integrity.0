Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33417330D23;
	Mon,  5 Oct 2026 06:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791180673; cv=none; b=uDozZD/Gi2hdPQZbsX7qLMYt1rehVFtiw3KEiCryAV33eRbiv66mUvrR9jjGPhJd9kqilfJyORIW9MXGKGoUxBakjheJ+yOveyRCUJqaV4SoCif/7LZG/Iptrqw3V5bc25JdSKz8gWv1vIxCK73WnqlfNiq6lYsVbHCUWPu/OQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791180673; c=relaxed/simple;
	bh=8zs15e5/Mr8o+vsyskBxb2vXVRC4+eeJnZVtfr2eEk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JEfwT04zplGl0ug3z9QAylDuf75ly7y2S/eXU3W0EQBOyoh9c256V4+9VPG5lB768lib04aFr0IyAsQvZlhUJVw8RF4fsmM0ZSVyz1E5vaNK0ZqbYZzdU5MT3LAYIQ3xvLKHYd/eyHJCLdXzJIIb88VaD8mA7I6vn5x9QWlvI30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NHTMYy6K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NHTMYy6K"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 2E2431F000FF;
	Mon,  5 Oct 2026 06:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791180671;
	bh=nlxnRJxOH90GEUi41R4JqS5v1Dy6OKqRlffqBLxP7oU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NHTMYy6K0l1PTQSLzEFhIsUZ445mhNO1gJkLq+2wDiAHDDGupLWkOut41Wtca7OJ9
	 DYD8GVD+UrKEm2fo2lndW5QKdWfGRPs90ZQHXKG3fIyEzqgU0rd1DIZCZ0uo0l24wi
	 OsH4WcKVCJiJMCyZOsaQ4+NgV9hm+5JPg0/P9awXdGicJPgDMOd4WxWkLOu8aQeaz7
	 33WR4xHjaIFfeZS+tebObK1Fbe/MKuSldsXDyJqk+gk+SYnzX5BSng79FnrbDKVL6c
	 gYSQxmM7+rTiFpxY07LExq7FahPsAWfv5nOaJiltEeMtaS1ucyG1cjoie3KZMA+L1e
	 W02+Vgk9OPF1A==
Date: Mon, 5 Oct 2026 09:11:07 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Pei Xiao <xiaopei01@kylinos.cn>
Cc: Jarkko Sakkinen <jarkko.sakkinen@iki.fi>, peterhuewe@gmx.de,
	jgg@ziepe.ca, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] tpm: fix log messages in tpm_init()
Message-ID: <asM_e08v18eyXx2s@kernel.org>
References: <cover.1791015549.git.xiaopei01@kylinos.cn>
 <de8bafc78e84dc6abc6f11e8eaa1b91c17e0c368.1791015549.git.xiaopei01@kylinos.cn>
 <asMdetm05nGIBbyn@iki.fi>
 <aa976135-27f4-4c4a-a9e0-a5a3347b514e@kylinos.cn>
 <asM-ICLM-C0ADrAL@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <asM-ICLM-C0ADrAL@kernel.org>

On Mon, Oct 05, 2026 at 09:05:25AM +0300, Jarkko Sakkinen wrote:
> On Mon, Oct 05, 2026 at 12:23:31PM +0800, Pei Xiao wrote:
> > 
> > 
> > 在 2026/10/5 11:46, Jarkko Sakkinen 写道:
> > > On Sat, Oct 03, 2026 at 04:27:55PM +0800, Pei Xiao wrote:
> > >> Make the error messages consistently prefixed with "tpm: ", and fix
> > >> the tpm_dev_common_init() failure message which was wrongly copied
> > >> from the previous step.
> > >>
> > >> Assisted-by: GLM-5.3
> > >> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> > >> ---
> > >>  drivers/char/tpm/tpm-interface.c | 6 +++---
> > >>  1 file changed, 3 insertions(+), 3 deletions(-)
> > >>
> > >> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> > >> index 1ccdbde98b69..666a1c654c02 100644
> > >> --- a/drivers/char/tpm/tpm-interface.c
> > >> +++ b/drivers/char/tpm/tpm-interface.c
> > >> @@ -524,13 +524,13 @@ static int __init tpm_init(void)
> > >>  
> > >>  	rc = class_register(&tpm_class);
> > >>  	if (rc) {
> > >> -		pr_err("couldn't create tpm class\n");
> > >> +		pr_err("tpm: couldn't create tpm class\n");
> > >>  		return rc;
> > >>  	}
> > >>  
> > >>  	rc = class_register(&tpmrm_class);
> > >>  	if (rc) {
> > >> -		pr_err("couldn't create tpmrm class\n");
> > >> +		pr_err("tpm: couldn't create tpmrm class\n");
> > >>  		goto out_destroy_tpm_class;
> > >>  	}
> > >>  
> > >> @@ -542,7 +542,7 @@ static int __init tpm_init(void)
> > >>  
> > >>  	rc = tpm_dev_common_init();
> > >>  	if (rc) {
> > >> -		pr_err("tpm: failed to allocate char dev region\n");
> > >> +		pr_err("tpm: failed to allocate TPM workqueue\n");
> > >>  		goto out_unreg_chrdev;
> > >>  	}
> > >>  
> > >> -- 
> > >> 2.25.1
> > >>
> > > 
> > > I NAK this one. It is not fixing anything.
> > Hmm, this is a cleanup, not a fix—just a very minor change to an error
> > log/print. I noticed it was duplicated (with the alloc_chrdev_region
> > error print), which made it impossible to tell which function call had
> > failed (it might actually never be executed). So I just brought up this
> > cleanup along the way.
> 
> If there is patch that is coming along the way, it is patch that should
> not be sent because:
> 
> 1. It wastes also everyone else's time.
> 2. Lack of understanding of cause and effect because by definition
>    you have no idea what you are submitting. E
> 
> Pure clean ups per se are already something that is usually best to NAK
> but this patch is not a clean up.
> 
> I mean the path is doing arbitrary log message changes. That is not
> harmless change as you enforce your arbitrary preferences also for few
> billion other users. 

Well, maybe just machines but anyhow :-)

Br, Jarkko

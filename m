Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA50F13AA2D;
	Wed, 15 Apr 2026 02:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776221338; cv=none; b=Qm79A4seIiyDbSsFSn133/omSqCtiNtK6WOqGxhhoPXoA2lbuwNrJtDs7GtlrbVQeFBfFkkUyVJuxvLjAjVzQ/dZflzh2ZIE3TFDEiP07wQHDAVyw5YblJXICOwug8/WLyijM6rja0T4xdOrgIc8a5N5J7kzhiKNWHIRbbZDyxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776221338; c=relaxed/simple;
	bh=j4Natby971hfp9kCKWEBwp2f+7TlNoo25m/o+tMdqv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gpGHYRBSqzpV6zBMtJYoViRSRnkOmEGZ0iniiJ6h/jbUWCoUnX5kVt22XInAGhwRoIlPykfnHcyySCzjKLxtRfFsSc39KtJaJfx6vMo3sV9+YsyWARu7IIB8wvgzlQhfIpUr4zI2FHfNC2BJO1Pm+ptuP0ablizGgJN9SFfvxq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zd66KtQ3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zd66KtQ3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C323C2BCB3;
	Wed, 15 Apr 2026 02:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776221338;
	bh=j4Natby971hfp9kCKWEBwp2f+7TlNoo25m/o+tMdqv8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zd66KtQ33syVXjMYRQEWLsSMHegqGPjsTeY9Pabs39nU43uuw0olxJF5DC3hJbzyB
	 AWMSFMjW96jvwQXWqS4D/SrZGyOb7xq9kYjoaa8D3/n3k+YQTB0rw5DyG9wSnKTajA
	 Z9e1YpYQ7lHk3W8/cnq68kSWsWikqSi5WEW2BImNE7Vf7bN3EQslBjKe5ts0W6hmQS
	 X67ldVoiywK/fpWb4OiBXTfWCMqgw2neHgXP04mvpU3Pw6SrGxyuaa9Km8lAxyLDL1
	 VcXgLiAXK/zvDqYAOUeIdlh1FPR4p8TTw4s/IPFqvkOLDX9aXQkwf32iaOfPDQOf9i
	 lfjiaWlZKCWXQ==
Date: Wed, 15 Apr 2026 05:48:55 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Arnd Bergmann <arnd@kernel.org>, Matthew Garrett <mjg59@google.com>,
	Bartosz Szczepanek <bsz@semihalf.com>,
	Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: aovid -Wunused-but-set-variable
Message-ID: <ad78lwWVkWpoYXQr@kernel.org>
References: <20240322132307.907203-1-arnd@kernel.org>
 <adwroOsSnGrGi5OM@linux.dev>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adwroOsSnGrGi5OM@linux.dev>

On Mon, Apr 13, 2026 at 01:32:48AM +0200, Thorsten Blum wrote:
> On Fri, Mar 22, 2024 at 02:22:48PM +0100, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > Outside of the EFI tpm code, the TPM_MEMREMAP()/TPM_MEMUNMAP functions are
> > defined as trivial macros, leading to the mapping_size variable ending
> > up unused:
> > 
> > In file included from drivers/char/tpm/tpm-sysfs.c:16:
> > In file included from drivers/char/tpm/tpm.h:28:
> > include/linux/tpm_eventlog.h:167:6: error: variable 'mapping_size' set but not used [-Werror,-Wunused-but-set-variable]
> >   167 |         int mapping_size;
> > 
> > Turn the stubs into inline functions to avoid this warning.
> > 
> > Fixes: c46f3405692d ("tpm: Reserve the TPM final events table")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  include/linux/tpm_eventlog.h | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/tpm_eventlog.h b/include/linux/tpm_eventlog.h
> > index 7d68a5cc5881..6e5be15029fb 100644
> > --- a/include/linux/tpm_eventlog.h
> > +++ b/include/linux/tpm_eventlog.h
> > @@ -131,11 +131,16 @@ struct tcg_algorithm_info {
> >  };
> >  
> >  #ifndef TPM_MEMREMAP
> > -#define TPM_MEMREMAP(start, size) NULL
> > +static inline void *TPM_MEMREMAP(unsigned long start, size_t size)
> > +{
> > +	return NULL;
> > +}
> >  #endif
> >  
> >  #ifndef TPM_MEMUNMAP
> > -#define TPM_MEMUNMAP(start, size) do{} while(0)
> > +static inline void TPM_MEMUNMAP(void *mapping, size_t size)
> > +{
> > +}
> >  #endif
> >  
> >  /**
> 
> I just stumbled upon the same problem and found this patch from 2024,
> which still applies. I cc'ed the current maintainers - maybe someone can
> pick this up? Thanks!
> 
> Reviewed-by: Thorsten Blum <thorsten.blum@linux.dev>

Thanks.

Arnd, I fixed typo in short summary and applied with that modification.

BR, Jarkko

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B2442050;
	Thu,  8 Oct 2026 17:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791481895; cv=none; b=CRnLYRNiSt3a2O4Flo7z6qbWZpMSFbuheMnG6mL2K8wQed3ghL/M78nIQqt3p9tKckN/ly+/9xrrkypATQVT7gmBMMxQ62Xx8iE6vVjew6AHkbqL3wPLMY3/X/rZ20OjLpCgUfKG6oIDHSsQKTuksyXarVOJtsLj9TPFKrI/0AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791481895; c=relaxed/simple;
	bh=coEOf7VvstEN+/puSQtK5DzsqaxuGoLDYFgfQ/StXZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AeKsFrnV+k976xcfCga9a3Y4nqwwabRdVROQ7OY/a9hY9PVIGSOp0Axc4j0Lnkx8zAMoKjpRFx2LQ2j07Al6zkEQonZtNrrY9n1aAMMkx6kVnUugFLCObhgoOo2JQ0MLCnOaGycYPKzQP7x9Ux16a9zimC4idJRncGyv/j7UMhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dZtr2hYl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dZtr2hYl"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 3B50B1F000FF;
	Thu,  8 Oct 2026 17:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791481893;
	bh=K8IULXfDl+3FFz8mk7/ic31KXQ0P/QtgfW1f4yI2uUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dZtr2hYl/G9Zj0V9+bivYtXserEJY8G3THJTp6Isi76gsw1mwuiN/1Szc3uuOiE5K
	 I+uIgpG2Kan4Z/x04ikjyqRK7QvDcV2J62PWcDuUqF52sog633qXM0ow6NWhLCu5BS
	 QWLrKKGelNsELC6HKu4v36tQLi4lG3SrxpVPNQfAfPpDig4K2bdwv+VoHpWy0nhPNe
	 U6nQlcB2HMIGgpDCP6KqFhb6upBhXLhXRW7yPImmrbtkF+jrvd0m6eAGNTmvzBN2h9
	 m1N1nw/NH+UF9+y7TJNegAt2rmLGE/lZI3JMrP5OBSLh1em8TG52kE33pJH397+j+e
	 PvIptDETInFjA==
Date: Thu, 8 Oct 2026 20:51:30 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Pei Xiao <xiaopei01@kylinos.cn>
Cc: peterhuewe@gmx.de, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] tpm: some tpm small fixes.
Message-ID: <asfYIg95-qQ4JrL_@kernel.org>
References: <cover.1791421672.git.xiaopei01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1791421672.git.xiaopei01@kylinos.cn>

On Thu, Oct 08, 2026 at 09:16:19AM +0800, Pei Xiao wrote:
> This series fixes several small issues found during a code review of
> drivers/char/tpm:
> 
>   1. tpm_ppi: tpm_show_ppi_response() stores its return value in an
>      acpi_status (a u32 typedef), so error codes such as -EINVAL reach
>      user space as huge positive values.  Declare the variable as
>      ssize_t to match the show callback's return type.
> 
>   2. tpm_nsc: tpm_nsc_remove() doubles as the release callback of the
>      hand-created platform device and dereferences the chip drvdata
>      unconditionally; init failures before tpmm_chip_alloc() crash
>      module load.  Return early when the chip has not been created.
> 
>   3. tpm_nsc: the cleanup runs twice on module exit because
>      tpm_nsc_remove() is both the explicit cleanup and the device
>      release callback; the second run operates on an already freed
>      chip.  Stop overriding the release callback, which also stops the
>      platform object allocation from leaking.
> 
>   4. tpm_dev: a zero-length read() discards a pending response,
>      breaking the command/response pairing of the TPM character
>      devices, although POSIX requires zero-count reads to have no side
>      effects.  Return early on a zero count.
> 
> chhanges in v2:
> 1.add reviewed-by tag
> 2.remove patch 5: 
> make the tpm_init() error messages consistently prefixed with "tpm: " and
> report the actual failure of tpm_dev_common_init().
> 3.modify patch 1 git commit information.
> 
> Pei Xiao (4):
>   tpm: tpm_ppi: fix zero-extension of negative error codes
>   tpm: tpm_nsc: fix NULL pointer dereference on init failure
>   tpm: tpm_nsc: stop using the cleanup callback as dev.release
>   tpm: fix zero-length read discarding the pending response
> 
>  drivers/char/tpm/tpm-dev-common.c | 3 +++
>  drivers/char/tpm/tpm_nsc.c        | 8 ++++++--
>  drivers/char/tpm/tpm_ppi.c        | 2 +-
>  3 files changed, 10 insertions(+), 3 deletions(-)
> 
> -- 
> 2.25.1
> 

Right, so I've already applied some of the patches so I'm a bit 
confused what to do with this.

See:

https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/log/

Is there something wrong in the ones that I already applied?

Br, Jarkko

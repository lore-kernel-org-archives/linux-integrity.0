Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4FF3491D0;
	Tue, 21 Apr 2026 18:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776795899; cv=none; b=X6G1nnvnLwpCfw99RYwWllfNLc6PE7r8vs4UXs7HFJUVwAygltFms9nQ/ki9mZg3CFjpRgY/SpOxZhSoC3iRjXc2zPjEVQ8vCgcxUEwO7l3kdff/28UXgkhQlRsQi8whTQItEMFh5eCfJAlbaQAkCrkVIx+UPHEPxyrHh/Aljvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776795899; c=relaxed/simple;
	bh=FXrcHXGPPzN4CG0CocolDjh3xpdM551N8TdL7CwWXzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pGRcFBhxA/aqwdGvKy54UFcyuF+BXb+D3zq77fviY2H7gP5ZEzdt9cooBXshrGaBIRvry8w3mo1P1ktA1ZLdf+D1YPZgqHoyHxu7DtO74vZPUvFXnPPKLVDzy89d6mWOVA9ldUWeG52/J4CrzZMgYV6FFtQAEjEH5JwYS+9o0Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQoKMxtC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQoKMxtC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0BB8C2BCB0;
	Tue, 21 Apr 2026 18:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776795897;
	bh=FXrcHXGPPzN4CG0CocolDjh3xpdM551N8TdL7CwWXzQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cQoKMxtCUl8l5b5mbTPiSQxWtGp96jSrIvsXWotlEy9lrv1W9HBivoYWtDwC84bcJ
	 b8QaXfLz6NU6N7HtvW7O3DUWPpFWQDRSj2Q82w5XuZTYLfK1TLQqXQbIK+EXRYAs2Y
	 wedF3vQ3MVXbf6mKmdCKpAjbuvfBq/wl5OdZA1sUlrOonxqPUlNSQA3B/ErYAAicbj
	 x/5sv1PhxMK8JEd5lT/eYrRB8x/HZrpSj0tS6m146ikLbR3lrsbt1XjF1IVcyF4FtQ
	 2xO4dKAmp667kRZbHi4YDFMvUNa0UVXwpi6frby8NiBMi6O/gRuQAjqFl3HxRTi0z2
	 hGzO38+5zRTJQ==
Date: Tue, 21 Apr 2026 21:24:53 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Baoli Zhang <baoli.zhang@linux.intel.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Serge Hallyn <serge@hallyn.com>, Lili Li <lili.li@intel.com>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tpm: restore timeout for key creation commands
Message-ID: <aefA9RxVgilxTH96@kernel.org>
References: <20260421005021.13765-1-baoli.zhang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421005021.13765-1-baoli.zhang@linux.intel.com>

On Tue, Apr 21, 2026 at 08:50:20AM +0800, Baoli Zhang wrote:
> From: "Baoli Zhang" <baoli.zhang@linux.intel.com>
> 
> Commit 207696b17f38 ("tpm: use a map for tpm2_calc_ordinal_duration()")
> inadvertently reduced the timeout for TPM2 key creation commands
> (`CREATE_PRIMARY`, `CREATE`, `CREATE_LOADED`) from 300 seconds to 30
> seconds.
> 
> This causes intermittent timeout failures, with several failures observed
> across hundreds of test runs on some Intel platforms using Infineon
> SLB9670 and SLB9672 TPM modules. Restore the timeout to 300 seconds to
> avoid spurious failures.
> 
> Fixes: 207696b17f38 ("tpm: use a map for tpm2_calc_ordinal_duration()")
> Co-developed-by: Lili Li <lili.li@intel.com>
> Signed-off-by: Lili Li <lili.li@intel.com>
> Signed-off-by: Baoli Zhang <baoli.zhang@linux.intel.com>
> ---
> Changes in v2:
> - Add description of intermittent nature of the timeout issue.
> - Fix Co-developed-by and Signed-off-by tag ordering.
> 
> v1: https://patchwork.kernel.org/project/linux-integrity/patch/20260410014940.3557934-1-baoli.zhang@linux.intel.com/
> 
>  drivers/char/tpm/tpm2-cmd.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index 3a77be7ebf4aa..430022f695f24 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -71,9 +71,9 @@ static const struct {
>  	{TPM2_CC_HIERARCHY_CHANGE_AUTH, 2000},
>  	{TPM2_CC_GET_CAPABILITY, 750},
>  	{TPM2_CC_NV_READ, 2000},
> -	{TPM2_CC_CREATE_PRIMARY, 30000},
> -	{TPM2_CC_CREATE, 30000},
> -	{TPM2_CC_CREATE_LOADED, 30000},
> +	{TPM2_CC_CREATE_PRIMARY, 300000},
> +	{TPM2_CC_CREATE, 300000},
> +	{TPM2_CC_CREATE_LOADED, 300000},
>  };
>  
>  /**
> -- 
> 2.43.0
> 


Much better! I'm fine with this and it is a regression.

On travel right now but I do have one SLB9670 connected to RPi4.

I'll do peer testing once at home (next week).

BR, Jarkko

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC15A8632B;
	Mon,  1 Jun 2026 20:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780344873; cv=none; b=QE/e8VHUltsjWTRjEfSUUuqQ0sMyV6599oLiXuIQQ67FUo53Pgcr7Me0MKcw1T4dAF35gdIM9zhjvr7OjrougdUDzax4+lEc30iqGpFDBTzK8qo7ZILTV3lvH0VwvbKGWoaokT+6iZOTxzLrXc1ASUyFF+b93dT0Y+peKFgM90w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780344873; c=relaxed/simple;
	bh=SKET0r/ta+2ZqWlMSAsUteUS87NoCR+t85ojDhMedog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DMGXouS9PnGZGKYItqHY6tmiOteuz8qPwASiXgGtR7avrJpK1y7Wgy7n/z0b9WBZQijs/h6FJSrixdTno0jT4bo4/0HnJWRg6W7r9guX4sJvloE7SQNZ/N64n/I29D5gjmUkvdfqdXr2HQnPoF4e89VZ9ZAulc4rGz4Dj/1K+Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jVeP+akc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jVeP+akc"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id D4C121F00893;
	Mon,  1 Jun 2026 20:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780344872;
	bh=RgDtcCDw6JHLq5xVs9U6WL+faIP32/U6ZqupTyR9VpI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jVeP+akcfzv4TmmSQ2of8Q3I2GIJuernqxgx/liyK4YVLH7oTdqKGsmjicZ6R/tiR
	 BSU1AxrKuo7of+B7JAOQBGqawtFrw2riJdTh15gGE9HL/CfX1fD8KUDt1p5K7pQenX
	 yyJxT4baFBVl7plWefbLz8/AcPYloDWRwVDDEsE/cVF8VOXSyZFO93ug+xhUCIBWsc
	 xV5NPTjSeykGMK3lYxbcIQpYIPz/AAo9rFI1Kb0F2vnYZT3sZWtVwwuKULVcJiXhY3
	 fnZtDjDS2D78qkHAOpXMD5KYAkoDfrS6b5zeC5uVa1zcNPUvmbpkL4H92jVJb0L4ws
	 GJbnRexhm2tfQ==
Date: Mon, 1 Jun 2026 23:14:28 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jim Broadus <jbroadus@gmail.com>
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	peterhuewe@gmx.de, jgg@ziepe.ca
Subject: Re: [PATCH v3 0/2] tpm: tpm_tis: Fix probe of some older TPMs
Message-ID: <ah3oJH-cxBndWWVH@kernel.org>
References: <20260519154530.6386-1-jbroadus@gmail.com>
 <20260526232245.5409-1-jbroadus@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526232245.5409-1-jbroadus@gmail.com>

On Tue, May 26, 2026 at 04:22:42PM -0700, Jim Broadus wrote:
> Changes v3:
> - Renamed the series from "Add optional delay after relinquish" to
>   "Fix probe of some older TPMs"
> - Addressed review comment, saving entire did_vid in priv structure.
> - Use did_vid value to identify problem TPM and apply quirk.
> Changes v2:
> - Move delay from tpm_tis_relinquish_locality to
>   __tpm_tis_relinquish_locality.
> 
> Link to v2: https://lore.kernel.org/all/20260519154530.6386-1-jbroadus@gmail.com/
> 
> Jim Broadus (2):
>   tpm: tpm_tis: store entire did_vid
>   tpm: tpm_tis: Add settle time for some TPMs
> 
>  drivers/char/tpm/tpm_tis_core.c | 28 ++++++++++++++++++++--------
>  drivers/char/tpm/tpm_tis_core.h |  3 ++-
>  2 files changed, 22 insertions(+), 9 deletions(-)
> 
> -- 
> 2.54.0
> 

Applied.  Thank you!

BR, Jarkko

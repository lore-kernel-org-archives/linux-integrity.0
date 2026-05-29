Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA278360751;
	Fri, 29 May 2026 23:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780095711; cv=none; b=mCIwVsvAU2ywG8ExBCjykXVxYBt7tW0zlDXFON3wCBqCMB9fAuIwv5s+AvKfLGnJs8et1HzkJVX4zYKhYjctehJDqFZVFFhbH/eTrpNW0/9qmHC2G7bliqLoGwRde8omMwXpm5thCgKGfGzYjK5E6a0sdP0LBlN5p7FzWLP2D94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780095711; c=relaxed/simple;
	bh=ii38ZSmKsDVlPZAbujyb8Hxn9+FNqpS8n/F87GKkMp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=px+DC/r6AeCcYR1TfbS/hvGCvtdy67TLeBVVHXKfziuwmquxfHQPXB11G9G67WpqUURz55Nm4nHDNgMb6KRukA9FkWoEhWxhB/yYl0liDp7Sx0C6H8hWYEWDlqexsGhlxOX8NB6v8O1Tsf91eU+hiyKJ0EGA7uFscqqcB4vyyTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y5GcoDha; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y5GcoDha"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id C57A61F00893;
	Fri, 29 May 2026 23:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780095710;
	bh=EjUgsy/T9O/KcziuszcgcAirLPSLIH6eFC8qtkJOoDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y5GcoDhaEvUvdm8NhunNSmHRUdSSX9PD3nUioK+7JiHfHQeUkC/g7pi82W4rQv+eG
	 v1waZT6Nccd9+B0dZdg6WK3qpeYG3merKJjZtxf+MXYpPr9WV08iEoxuNs1F6L4MYM
	 ZBW45gdK/OlTvcVfoMjAvwRKey096ukn86Irt4citeoDW9NEIcJ7F9js0Zfst0FV4u
	 ++5kQ9+0GQ+kOV1kqOSBcSH+EgiQ/Wj4wTLXYwcTQ4Fq7N8cBGTDCe+25VsIpYC3Ci
	 2LvSHSfdHFKaTex3CfbC2tvv3hyY+7M6mYSx43qpqKWjJ4TXf3u8CLcTLKrQqj2qQb
	 6B+HWzJNYhaBA==
Date: Sat, 30 May 2026 02:01:46 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jim Broadus <jbroadus@gmail.com>
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	peterhuewe@gmx.de, jgg@ziepe.ca
Subject: Re: [PATCH v3 0/2] tpm: tpm_tis: Fix probe of some older TPMs
Message-ID: <ahoa2s9NXW_gU0e9@kernel.org>
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

I think this now much better structured, thank you. I'll add this thread
to my TODO folder and try it out before any further feedback.

BR, Jarkko

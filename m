Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F03415B6A;
	Tue,  1 Sep 2026 10:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788258607; cv=none; b=Ovronlm4Zfbx7SsLBA1XNbZ3Lraf/PHxViOvqbBgu3VQI638yAdP1byRy347z3xrx4A8fMXpAO55iLm7wlSyhTiVea2CMAiHfU7h6Xw7N1COgqWypjW4IxdfgVACL1V+FiPgu7i+19np9CjRzvUqeVlZfQbfjLp+syo1G9/tQdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788258607; c=relaxed/simple;
	bh=LLG9esgPyGt/ECHxsGz85ERZ4ei7xeanmi/ZS375Ai8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zi+XL2osqlAmrG+pFFhLShs3Kv8ejyOXpXD3oAKsxEnqTABGbyOHzmpdH5ikgcSEnK49E1q4bPEmzsHdyeVA+5ubrLrkZ3vzxSXrOJUcdexUztxHK8Le2RJcpXc5L5ZX6IPZoIFzhZHNIaeIqkcC0hvfvMZfWpNgaW2lHywxgJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZc7hdUT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZc7hdUT"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 283921F000E9;
	Tue,  1 Sep 2026 10:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788258605;
	bh=UyX8W8JduGrbzCqkYtntKVY5wRM2S/yJbaCMtXi9lOU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DZc7hdUTJS99xXgiBg90OkuIA1ZKmujXk9A3dNqIx1b8jZSD71HbhozK+DkLcH4rJ
	 dax8jRiF0B0rh9t0QVD3l2MTqJMX5aumUCYcUHJQcayxwEB+n05HYeFOCpLESf5tTA
	 o7jqYQeOhUWdWNuLsFXHJEtwt1v6gSh1+ez0rIRdlDXOodd6z4X2TC6nSC+jGi3OOC
	 s39/QBnaK7gcVe+jqmkGQkYh57HBATgn8HhIZpIBR73tlwUD/T5a7JPA0PEO+yeriT
	 BnyDun8c+xP0mM3effafRc/t8zGp2Y+PodksARwGo/OnCvGMOMmqrJZD7y9JyLP89Y
	 tJRbhSvmfkyBg==
Date: Tue, 1 Sep 2026 13:30:01 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Farhad Alemi <farhad.alemi@berkeley.edu>
Cc: Peter Huewe <peterhuewe@gmx.de>, falemi@asu.edu,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] tpm_tis_plat_probe -- maps a borrowed MEM resource by its
 own size, then reads at a FIXED 0xF00 offset
Message-ID: <apapKZSytIX19glD@kernel.org>
References: <CA+0ovCjBrrU0H0Z-fqBZ_mat4toQM_z2=+NC-9ONSXn=bD8mmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+0ovCjBrrU0H0Z-fqBZ_mat4toQM_z2=+NC-9ONSXn=bD8mmg@mail.gmail.com>

On Thu, Aug 27, 2026 at 10:37:00PM -0700, Farhad Alemi wrote:
> Hello,
> 
> As part of the kernel research at ASU's SEFCOM
> lab, we hit the crash below. Crash reports can be found here:
> 
>   https://github.com/farhad-alemi/public_bug_reports/tree/main/154-tpm_tis-borrowed-resource-fixed-offset-read/

Please describe instead in plain Enligsh what is going. Hopping into 
random Github links is not the best possible way to communicate.

> 
>   BUG: unable to handle page fault for address: ffffc90000a17310
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
>   Oops: Oops: 0000 [#1] SMP KASAN NOPTI
>   RIP: 0010:ioread32+0x1c/0x80
>   Call Trace:
>    ioread32+0x1c/0x80
>    tpm_tcg_read_bytes+0xec/0x270
>    tpm_tis_core_init+0x48c/0x1830
>    tpm_tis_init+0x420/0x540
>    tpm_tis_plat_probe+0x118/0x1a0
>    platform_probe+0xf9/0x190
>    really_probe+0x267/0xaf0
>    device_driver_attach+0xe0/0x1d0
>    bind_store+0x1d0/0x220
>    kernfs_fop_write_iter+0x3af/0x540
>    ksys_write+0x150/0x270
>   Kernel panic - not syncing: Fatal exception
> 
> Our reproducer.c is available upon request.
> 
> Happy to test a patch if that would help.
> 
> Regards,

BR, Jarkko

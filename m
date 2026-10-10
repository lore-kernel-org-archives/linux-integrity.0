Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C513451CD;
	Sat, 10 Oct 2026 04:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791607066; cv=none; b=rnb45ouQueaCIA3sJQeNvT/v6KM7ZWUmZGtAvxql4TsifQodJFJs6joBHLQHoAGTUVwngOBc292u2qyx5U9GjBDtI8Lexu+DrmsyszzQmO+tOPW8IsklJ4v3S5An4M7sdaa3b8j67pyjUA/B/7o4Wv4DOZUmRkMIasqO5wVNKOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791607066; c=relaxed/simple;
	bh=IrHjKkj+D8DU5ckKYWgKnh1RN9L06X//M7q9ZNvM934=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b3+/ywdvK1OZOkOowvimKtPqksM8LOzKEFFifhEROWtsua8mbalEqt2pmmPd+W/XzP50fupFx+mKtwLIv3P8lca6luZov+iil4WUFl5E2Duic0An/4m/XCT1NrlBUmGNmGppwqqMAeF4P+yW/dCiz59C8JPHknsvHkLSwL+qGK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0z9Dtj1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0z9Dtj1"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 809131F000FF;
	Sat, 10 Oct 2026 04:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791607065;
	bh=DphHsZp1KEB4Zq1MHO6l6LHNE4Q8dWYRthKIspYwFY8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E0z9Dtj1BwdO6ikmfavrG8BDcuWX7zdSrl4/TFEdsZUaFmdEvTi3UvAGUBf3CJSL5
	 jDnnUSDTboKSsvEGgasJoTshsIMl2ZQZBkvHBoyqPHTmGG0nx1hAGQoXFisfBiXsY9
	 QGQbhTzaGX4YvvPBk93Xw3G55+jOZkD9upNHiGfscYrFclLYqL4XTh6fxTE2AjYQjF
	 mMsQn5iFrJIYzKSugV3yKNzvq39QeSzUIBbKzxj5CVVFxQNb9k5lEKHUEnA0CkHRp0
	 EpV5BKBYYmPypz2JzqUIkIEjZyiW3wzytbbUMExAEeVdezR2ZvcwniTIalEh3utqwh
	 z7X/o91eHk69g==
Date: Sat, 10 Oct 2026 07:37:40 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Pei Xiao <xiaopei01@kylinos.cn>
Cc: peterhuewe@gmx.de, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] tpm: some tpm small fixes.
Message-ID: <asnBFP1jo1g82ZHQ@kernel.org>
References: <cover.1791421672.git.xiaopei01@kylinos.cn>
 <asfYIg95-qQ4JrL_@kernel.org>
 <c74c47b0-e1e6-48f4-8997-ef264fcbf977@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c74c47b0-e1e6-48f4-8997-ef264fcbf977@kylinos.cn>

On Fri, Oct 09, 2026 at 09:01:05AM +0800, Pei Xiao wrote:
> 
> 
> 在 2026/10/9 01:51, Jarkko Sakkinen 写道:
> > On Thu, Oct 08, 2026 at 09:16:19AM +0800, Pei Xiao wrote:
> >> This series fixes several small issues found during a code review of
> >> drivers/char/tpm:
> >>
> >>   1. tpm_ppi: tpm_show_ppi_response() stores its return value in an
> >>      acpi_status (a u32 typedef), so error codes such as -EINVAL reach
> >>      user space as huge positive values.  Declare the variable as
> >>      ssize_t to match the show callback's return type.
> >>
> >>   2. tpm_nsc: tpm_nsc_remove() doubles as the release callback of the
> >>      hand-created platform device and dereferences the chip drvdata
> >>      unconditionally; init failures before tpmm_chip_alloc() crash
> >>      module load.  Return early when the chip has not been created.
> >>
> >>   3. tpm_nsc: the cleanup runs twice on module exit because
> >>      tpm_nsc_remove() is both the explicit cleanup and the device
> >>      release callback; the second run operates on an already freed
> >>      chip.  Stop overriding the release callback, which also stops the
> >>      platform object allocation from leaking.
> >>
> >>   4. tpm_dev: a zero-length read() discards a pending response,
> >>      breaking the command/response pairing of the TPM character
> >>      devices, although POSIX requires zero-count reads to have no side
> >>      effects.  Return early on a zero count.
> >>
> >> chhanges in v2:
> >> 1.add reviewed-by tag
> >> 2.remove patch 5: 
> >> make the tpm_init() error messages consistently prefixed with "tpm: " and
> >> report the actual failure of tpm_dev_common_init().
> >> 3.modify patch 1 git commit information.
> >>
> >> Pei Xiao (4):
> >>   tpm: tpm_ppi: fix zero-extension of negative error codes
> >>   tpm: tpm_nsc: fix NULL pointer dereference on init failure
> >>   tpm: tpm_nsc: stop using the cleanup callback as dev.release
> >>   tpm: fix zero-length read discarding the pending response
> >>
> >>  drivers/char/tpm/tpm-dev-common.c | 3 +++
> >>  drivers/char/tpm/tpm_nsc.c        | 8 ++++++--
> >>  drivers/char/tpm/tpm_ppi.c        | 2 +-
> >>  3 files changed, 10 insertions(+), 3 deletions(-)
> >>
> >> -- 
> >> 2.25.1
> >>
> > 
> > Right, so I've already applied some of the patches so I'm a bit 
> > confused what to do with this.
> > 
> > See:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/log/
> > 
> > Is there something wrong in the ones that I already applied?
> hi Jarkko，
>   Because this patch ("tpm: tpm_ppi: fix zero-extension of negative
> error codes") did not pass review, I resend a v2 version that includes
> the patches that have already passed review and carries their
> Reviewed-by tags.

Hey, no worries, I'm just sanity checking (and thus asking, that's
all). Nothing you did particularly wrong.


> Pei.
> thanks!>

Br, Jarkko

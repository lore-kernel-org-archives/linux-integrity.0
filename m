Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93FE360EF7;
	Mon,  5 Oct 2026 07:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791186172; cv=none; b=kldtiyB0Onzh/Aaa8vv2QufB9KpVeTFTrNQfYCGAab9ovT5m4Jc4jNHvvSdgGmW+noHEFiPTnRMEDPv0d1iWpNCsFgkaY+RH0lVD1BVHrHgtWyH13GdyyPO9tYM3/fp4bhjVIQIdnZF4AHVZfHWdn1mr+3PcaVW5gJkYl/Nf7oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791186172; c=relaxed/simple;
	bh=ZlAKPfrllWGBvl3Ss2bKqHO0PomKSysRCOqXRszE6XM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l5bE95ACd4s1F+FIgm4pzK7F84+7KyAg+4VD4gnYDnC85G3fmod2fM3YwDfJwTTm34wJfHIbM0prEDQuLN9D+zNKgHDgRS6FH5wg0r0S0DH7tA/0K2FKT4ONdxCrssJWMEKlpoyFGRbkT8eXsyjZXiQRzn3ZFq+/xgfyYvrPZ/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bOLUQ17J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOLUQ17J"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id D7CB71F00893;
	Mon,  5 Oct 2026 07:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791186171;
	bh=LQCof4ppfHtoJQlbxYOMHqWUIhHy13oM7f8A6scxOYg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bOLUQ17JAM1t1GkRD/PJrz4zDpauaigE+zJjr5SHle8B11h/8LmLXQiqKw8xj3oIW
	 e0fAvbGsNlrsgeuWHJqMxqAFY+MhMm7FLHcoXK9ijLpCvwDE8fhSqFtkXZ1BYtInJk
	 CmCCvopewG9oIneEeys27fn0OSS3Gy/7zxwaNOsSv2MnMgJeh6aKvzM93D7zzfXywS
	 OBcu20dv1a/uKBCspoZuB9xs27m9A49/bwzaLnJX8WmToI7/ik9f2tAPmbQqoqH5tl
	 WYPy9VyY6YWOli/QpnCAB0LNy5zK9FTC+kYjMqMGALO9qK+5H45uluHZRay4zq0au+
	 MdqhiH2RGqevw==
Date: Mon, 5 Oct 2026 10:42:47 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Pei Xiao <xiaopei01@kylinos.cn>
Cc: Jarkko Sakkinen <jarkko.sakkinen@iki.fi>, peterhuewe@gmx.de,
	jgg@ziepe.ca, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] tpm: tpm_ppi: fix wrong error code returned to user
 space
Message-ID: <asNU92oQXJcolDdy@kernel.org>
References: <cover.1791015549.git.xiaopei01@kylinos.cn>
 <16ff8f5a35246d5932068ce1b01438bc2895a46a.1791015549.git.xiaopei01@kylinos.cn>
 <asMkuS55pG_q8RsT@iki.fi>
 <42828ffb-d2c4-4f31-88d0-c4b939631ab8@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42828ffb-d2c4-4f31-88d0-c4b939631ab8@kylinos.cn>

On Mon, Oct 05, 2026 at 02:17:23PM +0800, Pei Xiao wrote:
> 
> 
> 在 2026/10/5 12:16, Jarkko Sakkinen 写道:
> > On Sat, Oct 03, 2026 at 04:27:51PM +0800, Pei Xiao wrote:
> >> tpm_show_ppi_response() stores its return value in an acpi_status,
> >> a typedef of u32.  Both error paths of the function (-EINVAL on a
> >> malformed _DSM package, -EFAULT on a non-zero operation return
> >> code) end up as huge positive values when returned as ssize_t, so
> >> user space cannot detect the failure with the usual "ret < 0"
> >> check.
> > 
> > I have no idea what you mean by huge value and why that would be
> > a problem, and overall this is disconnected from the code change.
> > 
> > Two's complement value is correctly stored in status up until the
> > ssize_t cast, which results the value to be zero-extended, and
> > as a result corrupt the negative values.
> How does the following Git commit message look：
> 
> tpm: tpm_ppi: fix zero-extension of negative error codes
> 
> tpm_show_ppi_response() keeps its return value in an acpi_status,
> a typedef of u32.  The two's complement of the error code is stored
> correctly there, but on return the value is converted to ssize_t and
> zero-extended, so the sign is lost: user space receives 0xFFFFFFEA
> (4294967274) instead of -EINVAL, which breaks the usual "ret < 0" error
> check.
> Declare the variable as ssize_t so that negative values survive the
> conversion.

Works for me. It does not have to be perfect as long as it points out
to the right direction.

> > 
> >>
> >> Declare the variable as ssize_t to match the show callback's
> >> return type.
> >>
> >> Fixes: 84b1667dea23 ("ACPI / TPM: replace open-coded _DSM code with helper functions")
> >> Assisted-by: GLM-5.3
> >> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> >> ---
> >>  drivers/char/tpm/tpm_ppi.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/char/tpm/tpm_ppi.c b/drivers/char/tpm/tpm_ppi.c
> >> index c9793a3d986d..949fb7055bea 100644
> >> --- a/drivers/char/tpm/tpm_ppi.c
> >> +++ b/drivers/char/tpm/tpm_ppi.c
> >> @@ -234,7 +234,7 @@ static ssize_t tpm_show_ppi_response(struct device *dev,
> >>  				     struct device_attribute *attr,
> >>  				     char *buf)
> >>  {
> >> -	acpi_status status = -EINVAL;
> >> +	ssize_t status = -EINVAL;
> >>  	union acpi_object *obj, *ret_obj;
> >>  	u64 req, res;
> >>  	struct tpm_chip *chip = to_tpm_chip(dev);
> >> -- 
> >> 2.25.1
> >>
> > 
> > Br, Jarkko
> 

Br, Jarkko

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8A042050;
	Thu,  8 Oct 2026 17:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791481749; cv=none; b=UQU04DMZh6r3N6bJzCz9j+xtpePnGWN8wke2qGb0+Drkf6W09n8wfQe+nsrblWjJAZJ/CvJ+krJQMHgzs3P/OuEmxRt2Vb0t2HlE1SfWSnYWk5BYLTAVd0Q0DjohPU4Zk2RJkIkDGY5ULTS+5goXxrVc5G58+D6Q72+2y7De3YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791481749; c=relaxed/simple;
	bh=s2GFRtIFktHY+2NKyvPmowbNfGa8MQBleT3TFaaAo1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZ1TDD7oKZk1vH4+njxTYeVF/O9h3IuObvL8YhEbwaBobZmZGSckyEqto2xkrQSPw4qWe8zJdIQ0+vnUBN8oe8wJ0KH/o+T5ErDJoij+pbVRbqAYVFObOIhahlK4f+bebfCtMvcBwAwWPBrAAOQa5CNAW2hvQANuCpFzHDbObk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ioikkTCO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ioikkTCO"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 0C44F1F000FF;
	Thu,  8 Oct 2026 17:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791481748;
	bh=pISTZqbDUUvYoQiyRN6CYHeE1YtsI6/nydkRNvBlFO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ioikkTCOTq4eb9VW7iP55yExN0xukKsZJ/U9Vzj4+NFYHCb1ZYqlkmUE92JD/jquG
	 j2rG9JHMO+hLJUIuWiIhw8ZSQ+I12O1GNdfVEb+Gly34v0QyUfZ7O4BAGm5Bb2Wky/
	 j7FKQqDEc07Yu837VwHfR6CXge7y0s+/p5oM6OCefvCU7LZ2YxR0g9yWjA6g6r1kB7
	 YPReVXMIqr8G9PsNtnqJtMXGN+lBehx1TjMh5daLIlckXEzTKUii9bgIK/UQNRqJMK
	 vpDyODE0wTFqzmi2he6OU0ePTXjGE3fgEDQSHjT4OlLfX3ZRAofkygS6hNoR5Rf1Y9
	 hJXyLk7C7/Kxg==
Date: Thu, 8 Oct 2026 20:49:05 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Pei Xiao <xiaopei01@kylinos.cn>
Cc: peterhuewe@gmx.de, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] tpm: tpm_ppi: fix zero-extension of negative
 error codes
Message-ID: <asfXkXCEYewJVyYb@kernel.org>
References: <cover.1791421672.git.xiaopei01@kylinos.cn>
 <654d1a02c0720a37ae38382a71f0b8c0f5f9b6a0.1791421672.git.xiaopei01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <654d1a02c0720a37ae38382a71f0b8c0f5f9b6a0.1791421672.git.xiaopei01@kylinos.cn>

On Thu, Oct 08, 2026 at 09:16:20AM +0800, Pei Xiao wrote:
> tpm_show_ppi_response() keeps its return value in an acpi_status,
> a typedef of u32.  The two's complement of the error code is stored
> correctly there, but on return the value is converted to ssize_t and
> zero-extended, so the sign is lost: user space receives 0xFFFFFFEA
> (4294967274) instead of -EINVAL, which breaks the usual "ret < 0" error
> check.
> Declare the variable as ssize_t so that negative values survive the
> conversion.
> 
> Fixes: 84b1667dea23 ("ACPI / TPM: replace open-coded _DSM code with helper functions")
> Assisted-by: GLM-5.3
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> ---
>  drivers/char/tpm/tpm_ppi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm_ppi.c b/drivers/char/tpm/tpm_ppi.c
> index c9793a3d986d..949fb7055bea 100644
> --- a/drivers/char/tpm/tpm_ppi.c
> +++ b/drivers/char/tpm/tpm_ppi.c
> @@ -234,7 +234,7 @@ static ssize_t tpm_show_ppi_response(struct device *dev,
>  				     struct device_attribute *attr,
>  				     char *buf)
>  {
> -	acpi_status status = -EINVAL;
> +	ssize_t status = -EINVAL;
>  	union acpi_object *obj, *ret_obj;
>  	u64 req, res;
>  	struct tpm_chip *chip = to_tpm_chip(dev);
> -- 
> 2.25.1
> 

OK, cool we went through this so

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Br, Jarkko

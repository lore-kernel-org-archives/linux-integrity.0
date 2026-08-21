Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B0728505E
	for <linux-integrity@vger.kernel.org>; Fri, 21 Aug 2026 01:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787274998; cv=none; b=hb5W+8YPeYsRkuxzuApj/cFLTlKttuwmpDuYIMWgR26Q8I85VQ8WK6l06oUcGQjtuUbF31UwOBXKhkFGvZRmBEmJinbpagfgknli6ybKYuw666ANbhwPtePSsxOuFokSkZQ7BMkDhnM+JWnBfiIwR/91t/spnweXrS7eaMsGi+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787274998; c=relaxed/simple;
	bh=Gyfn1hLnE23C33shljpJcML9KY7hd5JZfTm86yKnoRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KXq4S3Dn400nM3C8DBxdcCfn3we9562upWcT9Yq2q1j6CZj1ycEBoMxqN1DiJn8nWIQ0yEHDnwiOR1UoSXNaCPXDXUmkFnmFMp8hHLaTBdPS02VUvvJUXInGDwDvENvFBkySQZZCw3fKqLewcZy/YUVL3LlCzSSlSQ5qhg1nsi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WIM8U8Jv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WIM8U8Jv"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 71ED61F000E9;
	Fri, 21 Aug 2026 01:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787274997;
	bh=ugQBOyFlZHE/AYxVsjIfj1b739XLxm2ahI6d8cBcsxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WIM8U8JvxLPhUSFhnl5sJ8ra6ChLW8lgQ25J2d0Qda64btmbzOntBgxxJIKg9LF9n
	 +c6AsAATr36C88tYXxmUBGUfJIV//spaTGCquumFtWHy6PITeTDUrCekJhBOjrpfAM
	 eg5kTBeEwGRr/h6wkis5teyMD/QObyLHW/917EekGfjdPAL3lWexd7iMzdVfBIF0qu
	 qtH3lNNdOBjQBv6TNv4zOOceKh6HMoSc/lM8LP0On156I637HdAOGq3z3TZZEYTxr7
	 ViqHJvypRKLq+uJWjcVP1g4zF5fsGtLcjmd4jkYUDjyWjevHgmqhlGxvdVNXm4tiwx
	 45qLPqJwUHAug==
Date: Fri, 21 Aug 2026 04:16:33 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Li Jun <lijun01@kylinos.cn>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
	chleroy@kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
	linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH] char: tpm: Use SIMPLE_DEV_PM_OPS for ibmvtpm power
 management
Message-ID: <aoem8QbOVD7QVwiG@kernel.org>
References: <20260819083547.2703228-1-lijun01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819083547.2703228-1-lijun01@kylinos.cn>

On Wed, Aug 19, 2026 at 04:35:47PM +0800, Li Jun wrote:
> Replace the manually defined dev_pm_ops structure with the
> SIMPLE_DEV_PM_OPS macro to simplify the power management code.
> This macro automatically handles CONFIG_PM_SLEEP configuration,
> generating the same suspend/resume callbacks while reducing
> boilerplate code.Add the value of 'thaw,freeze,poweroff,restore'.
> 
> Signed-off-by: Li Jun <lijun01@kylinos.cn>
> ---
>  drivers/char/tpm/tpm_ibmvtpm.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
> index 6fb4d30eb6f6..51c7e2add3d2 100644
> --- a/drivers/char/tpm/tpm_ibmvtpm.c
> +++ b/drivers/char/tpm/tpm_ibmvtpm.c
> @@ -462,10 +462,7 @@ static const struct tpm_class_ops tpm_ibmvtpm = {
>  	.req_canceled = tpm_ibmvtpm_req_canceled,
>  };
>  
> -static const struct dev_pm_ops tpm_ibmvtpm_pm_ops = {
> -	.suspend = tpm_ibmvtpm_suspend,
> -	.resume = tpm_ibmvtpm_resume,
> -};
> +static SIMPLE_DEV_PM_OPS(tpm_ibmvtpm_pm_ops, tpm_ibmvtpm_suspend, tpm_ibmvtpm_resume);
>  
>  /**
>   * ibmvtpm_crq_get_next - Get next responded crq
> -- 
> 2.25.1
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1F13A5E70;
	Fri, 18 Sep 2026 01:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789696184; cv=none; b=dgsrAs69Y+GkR6JDa2ontR588EDx94xBVXmcROQkimbvbNi++aZ/y9TAAJISd2xzjpZNzTSFmsLiOr5mny3oZd5AChiAT9wyjmUy1aCS/zkW83h9csynQ9ZK4XJPfESXNCGCjGJ27GJFvE7QIp3DPggxtPLHviVRrU94jWmsDE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789696184; c=relaxed/simple;
	bh=CaC1JZDiBUQGBz+v18RtejpXUNx5ZvC8M1PInZMKVEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mr0xxIdktPvRh5CdTrc6Yyt6wYT25F7Yj+zigYMWdoRr5nRt15SOALC2xHhfs04Nd5J/9E0JbCu/tmliSvQzxg715i+aN/Y+x4CFD2CVz5QU4V+ADWRJ8AesizpwefkOGWsMq150Ru5HHph2lDcEg1ZfkVoYF2ZRUSUY12aAOfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dDxl1whZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dDxl1whZ"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 866E21F000FF;
	Fri, 18 Sep 2026 01:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789696179;
	bh=nFSTUGhm0bEabhyxlgtAtGNKFez8m79aroI8FqNsttA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dDxl1whZW6/aWkT6V4Vr8dHiSZCj8k4/nYuZ8Q0cKmDDXJzQqwVxgfgpQw8jxqXM/
	 8F6rfAOmCFVApjjwBiK3NEPIk1TxLP5gp6PaJ9pZX1j3ZGHovBGPOUTBAQhJ6IUqIL
	 FMIGE1KozNAaTWefStLaMR0/EnX1TJrIMjNuCFaiu3WToT5C55YuXcL/C8bl0dEuHJ
	 pym5Zdz9EkCmPIf+qqoblYMhWTzHHUqJ4kIAtlBdHlmLeX94xI9pfkMTMzG1D6CYJT
	 48CylJ0SJ2qf6ikObKk89G+LYCHYQEmiV1JKqqa5WFBtgEGkxztA1gOp7x6kuLSafj
	 1BlkqjElJNOpg==
Date: Fri, 18 Sep 2026 04:49:35 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Cc: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
	Jens Wiklander <jenswi@kernel.org>,
	Sumit Garg <sumit.garg@kernel.org>, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-arm-msm@vger.kernel.org,
	op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2 3/3] MAINTAINERS: Add Qualcomm TPM driver entry
Message-ID: <aqyYr6SCip8Xgpd3@kernel.org>
References: <20260907-tpm_qcom_driver-v2-0-71a6b1752da8@oss.qualcomm.com>
 <20260907-tpm_qcom_driver-v2-3-71a6b1752da8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907-tpm_qcom_driver-v2-3-71a6b1752da8@oss.qualcomm.com>

On Mon, Sep 07, 2026 at 02:58:43PM +0530, Kuldeep Singh wrote:
> Add a dedicated MAINTAINERS entry for the Qualcomm TPM driver, which
> uses the Qualcomm TEE interface (qcomtee) to communicate with a TPM
> Trusted Application running in TrustZone.
> 
> Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 47b04968e79a..cfa5b66823c7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22636,6 +22636,13 @@ S:	Maintained
>  F:	Documentation/tee/qtee.rst
>  F:	drivers/tee/qcomtee/
>  
> +QUALCOMM TPM DRIVER
> +M:	Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
> +L:	linux-arm-msm@vger.kernel.org
> +S:	Maintained
> +F:	drivers/char/tpm/tpm_qcom.c
> +F:	drivers/char/tpm/tpm_qcom.h
> +
>  QUALCOMM TRUST ZONE MEMORY ALLOCATOR
>  M:	Bartosz Golaszewski <brgl@kernel.org>
>  L:	linux-arm-msm@vger.kernel.org
> 
> -- 
> 2.34.1
> 


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

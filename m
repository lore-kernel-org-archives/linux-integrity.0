Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78465540A7;
	Wed,  9 Sep 2026 16:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788969781; cv=none; b=VwTRJYkqtrcbsGHsLjrzJ9Nut3rVuXnj7Iyd64rb8ytnDtDsYHjhveu7w5wO+W9GjAZbWKmucMj151vCJbYKJYItLRNwFwoPweK6ltvDKkJmx3ThqBs9z0dxekj8/xRfEsYg8pIDPWK+EpmL4BLVqHJmN0NDG6WGAW8c/4fjarU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788969781; c=relaxed/simple;
	bh=ze/7Z0bu8ix+pxZoxnVSm4HhW9KxxkbdWmFN1BdD4UQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a+sYU21ZFdB4bzmYF16fWgH75wkXVGolcSjKcsrP5cWmyvFs3kZbq2zDD3eexAY1TuaZFBoB1MSoTKt3Y0hLrc3qlhi29doZYBCXeGnisup8/HrlwBt0H/6iSeIivjmaypPdyHTAwnMhMOEIp+gLJzaPHiBIDk6rJGZHwisrljs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fr9yx7Ku; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fr9yx7Ku"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 1E2401F00A3D;
	Wed,  9 Sep 2026 16:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788969779;
	bh=fvpaif8SiWxOgwwNCHVu5uatFd8pM8O7cXEt4RsdiJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fr9yx7KuD6gJJ3pwJLcI1mMlIDce4aem0AHTM6I5CB4yG1ajj4hm6ji9PPSL2FcYx
	 trc1tIvAblHO634KnPmwSdr4Ofz9CEXL/ZiEpRHVZ480JUhhr3QwN6zbluW4VmiQb6
	 DH33xZ4HD82WnvyQhcgKCDlXTKlNANMD8zuGrNUs4QqTsUUBlNLz6lEuUqGB365Eme
	 rpGJviGTHqIIZBu64RNFbfjYhlT+IK30PxuEdX3qx/9PqKPWzCnHerUuINJxApJ5w7
	 VX4lIUU14n8TPx+xpGXzuLEFqKBxzeoH+mMW429y6rnX7q5mEAGIUwbtRpG9KhcduE
	 zrGUFMZ2hqD3w==
Date: Wed, 9 Sep 2026 19:02:55 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Cc: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
	Jens Wiklander <jenswi@kernel.org>,
	Sumit Garg <sumit.garg@kernel.org>, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-arm-msm@vger.kernel.org,
	op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org
Subject: Re: [PATCH 2/2] firmware: tpm: Introduce tpm-qcom driver
Message-ID: <aqGDL2qZ0sZNMG0f@kernel.org>
References: <20260831-tpm_qcom_driver-v1-0-6f16fa6924fa@oss.qualcomm.com>
 <20260831-tpm_qcom_driver-v1-2-6f16fa6924fa@oss.qualcomm.com>
 <apbXKZrjFdK1vrny@kernel.org>
 <38984608-4b5c-4355-ad85-8c5a1fb78cb2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38984608-4b5c-4355-ad85-8c5a1fb78cb2@oss.qualcomm.com>

On Wed, Sep 02, 2026 at 02:52:17PM +0530, Kuldeep Singh wrote:
> On 01-09-2026 19:16, Jarkko Sakkinen wrote:
> > Short summary has a different driver name that is implemented i.e.,
> > it should has "tpm_qcom", not "tpm-qcom".
> 
> True, let me make more generic like "Introduce Qualcomm TPM driver"
> instead of having driver filename in commit title for any confusion.
> 
> >>  MAINTAINERS                 |   7 +
> >>  drivers/char/tpm/Kconfig    |   9 ++
> >>  drivers/char/tpm/Makefile   |   1 +
> >>  drivers/char/tpm/tpm_qcom.c | 371 ++++++++++++++++++++++++++++++++++++++++++++
> >>  drivers/char/tpm/tpm_qcom.h |  82 ++++++++++
> > 
> > Rename it as tpm_qcom_tee just to be aligned on how Microsoft's fTPM
> > driver is named.
> 
> I'd say firstly microsoft ftpm driver should be renamed.
> For example, MS ftpm is based on optee(session based context) whereas
> Qcom tpm driver is based on qcomtee(part of same TEE subsystem but uses
> completely different mink-ipc based sharing mechanism).
> So, it's completely different driver compared to MS.
> 
> My suggestions:
>  - Rename MS driver i.e tpm_ftpm_tee.c -> tpm_microsoft.c
>  - Rename Qcom driver i.e tpm_qcom.c -> tpm_qcom.c

This goes for argument using tpm_qcom.c but we don't rename ko's in
normal circumstances (unfortunately so).

> 
> I see pattern like tpm_{loongson/atmel/ibm} etc. so better to follow
> this convention?
> 
> If ever need optee/qtee to specify, more namings can be tpm_ftpm_optee.c
> and tpm_qcom_qtee.c?
> Personally, I don't prefer tpm_ftpm_tee.c as it's all generic name with
> no optee specification.
>  >
> >>  5 files changed, 470 insertions(+)
> >>
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index 47b04968e79a..cfa5b66823c7 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -22636,6 +22636,13 @@ S:	Maintained
> >>  F:	Documentation/tee/qtee.rst
> >>  F:	drivers/tee/qcomtee/
> >>  
> >> +QUALCOMM TPM DRIVER
> >> +M:	Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
> >> +L:	linux-arm-msm@vger.kernel.org
> >> +S:	Maintained
> >> +F:	drivers/char/tpm/tpm_qcom.c
> >> +F:	drivers/char/tpm/tpm_qcom.h
> >> +
> >>  QUALCOMM TRUST ZONE MEMORY ALLOCATOR
> >>  M:	Bartosz Golaszewski <brgl@kernel.org>
> >>  L:	linux-arm-msm@vger.kernel.org
> > 
> > this change should be a separate patch.
> 
> Ok, let me make MAINTAINERS entry as separate patch.
> Also, i noticed none of other driver are being even compiled as 'M' like
> atmel, ibm etc.
> Any obvious reason behind this?
> Should i enable tpm_qcom as Module in this patch only.
> 
> >> +	print_hex_dump_debug("tpm_qcom req: ", DUMP_PREFIX_OFFSET,
> >> +			     16, 1, req, req_len, true);
> > 
> > Please don't do this. It can put production systems at risk.
> 
> Ok. I want to dump some contents on failures which makes debug easier.
> Instead of dumping entire req/rsp buffer, dump tag, reqlen, rsplen etc?
> >> +static struct tee_client_driver tpm_qcom_driver = {
> >> +	.id_table	= tpm_qcom_id_table,
> >> +	.probe		= tpm_qcom_probe,
> >> +	.remove		= tpm_qcom_remove,
> >> +	.driver		= {
> >> +		.name	= "tpm-qcom",
> 
> Whatever naming we'll decide, I'll update same here too.
> 
> >> +
> >> +/* dTPM SPI transfer optimization:
> > 
> > Block comments AFAIK should be
> > 
> > /*
> >  * <TEXT>
> > 
> 
> Let me fix it.
> 
> -- 
> Regards
> Kuldeep
> 

BR, Jarkko

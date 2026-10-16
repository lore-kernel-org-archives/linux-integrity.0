Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9934C3D813C;
	Fri, 16 Oct 2026 21:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792184723; cv=none; b=JizAuUxZoCgSQOhg7u65TYGUZzmYKX9Z+g4g8q/FC1KfYJIhx5+27k3/YA/aXn75nM0qL0MCvElJW/jzabLGRj3uW+zNJEqhnjdpwqdVcWCmn4FQM0J+yN6cz525ShCXy0+41JdMkHCPU8uDwvCKbuA1Esee/cfdm+MZTqpgqvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792184723; c=relaxed/simple;
	bh=ks/of912DXGLZeNr2Rqj2o6KM4Mb2blY0/P0eNXimIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W7whTvXaAQ3L1JrVOaN6bQPJDiAVJIDtjFWg47XPBUeRXgF4jcDKB+DOv35r45grNHVIWE1ll8XBwNB+zsyHCJqtGdKFMdWYssEmUV5EiDG6nLtaILRqfI0MJ8N75QaKJZAG3M11ElKFRdeFYDlutcfpr6kT9M1m/2XRdrrO5MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ep5qit5y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ep5qit5y"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 929B41F000C4;
	Fri, 16 Oct 2026 21:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792184722;
	bh=FOYNtMSvDn7pBJVRwLvlkqM8Xp7WR/Z4rsPYrSx+TgI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ep5qit5ytcUQGQs6HzQX5vZLEoPypglHqMJrXT6mbxVQbFUU2/IQCbzA297ANrbXR
	 QV1syvA42YuKiu4W8pZN1R/wZb6HcM0yU7ePPKUJrl1ZMudmE0Oo72IWxauSD+S5Ru
	 0A4/VQ8qapE7cKHvSEvmlhhkwpcp3b/7wgULchyioMPHv1UWnnhZiWbA9uq487d/9x
	 XbAB/s+WSkK2dVPwZAOoQGFte6HhqRnCiHawomo1mZ4RvZZnqwcp+iUgEcxiTlzfdS
	 y4NlIRtTdoE7DgxRQ2juEgOByUpnt59Z4UYtxvY8gGjTGAOEOr9vlEfsa0CFy8umBe
	 fByQk3JEGqgwg==
Date: Sat, 17 Oct 2026 00:05:18 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Cc: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
	Jens Wiklander <jenswi@kernel.org>,
	Sumit Garg <sumit.garg@kernel.org>, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-arm-msm@vger.kernel.org,
	op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Add TPM support via Qualcomm TEE TPM TA
Message-ID: <atKRjiZEMIx3hhxI@kernel.org>
References: <20261015-tpm_qcom_driver-v3-0-247c8e50250e@qti.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015-tpm_qcom_driver-v3-0-247c8e50250e@qti.qualcomm.com>

On Thu, Oct 15, 2026 at 12:07:45PM +0530, Kuldeep Singh wrote:
> Qualcomm platforms with a discrete TPM (dTPM) talked to it directly over
> a non-secure SPI channel from the kernel. Arm's Base Boot Security
> Requirements (BBSR) v1.4 require that access to go through TrustZone
> instead, so on affected Qualcomm platforms the TPM 2.0 instance is now
> fronted by a Trusted Application (TA) running inside Qualcomm's Trusted
> Execution Environment (QTEE), which talks to the dTPM (or implements an
> fTPM) on the kernel's behalf.
> 
> This series adds a kernel driver for that TA, built on the QCOMTEE
> object-IPC transport (drivers/tee/qcomtee/) already used to reach other
> QTEE services.
> 
> This patch series functionally depends on below(first 5 changes specially)
> for qtee service discovery.
> - https://lore.kernel.org/lkml/20261006-qcom_uefisecapp_migrate_qcomtee-v4-0-bf1c8e2a64ab@oss.qualcomm.com/
> 
> Tested on Glymur-crd target with tpm2-tools utility.
> 
> Validations:
> - Get capabilities
> - Random number generator
> - RSA key creation, encryption and decryption.
> 
> Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
> ---
> Changes in v3:
> - Merge tpm_qcom.h into tpm_qcom.c(Amir comments)
> - Update return values of functions and drop certain error prints.
> - Define locality_arg as default value.
> - Add Jarrko's tag on all but drop from 2/3 as significant changes done.

I get this because I have hard time to write "catppuccin" correctly ;-)

Br, Jarkko

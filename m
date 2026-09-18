Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA153546D7;
	Fri, 18 Sep 2026 01:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789696450; cv=none; b=AglH1f9VCbyAeOq6EDqeKCkM85SfGwgCrb0CjNqcNWq8aOu5HxLVBxo+ZEMbrIdP8bV5pPT/o93LPHtjBSMSZNI9ItEAsuXAxBrrmIA6VS6Y7wVxIe0CSUoXO7iPs+ICeSbRcrL7MzP/PXBJNnFl4WjT2jD7GfHi/FY9wehSZ3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789696450; c=relaxed/simple;
	bh=+GM0ZXBoL6s6IRT85tvqIGHYcZKvWd1OuJJsWsQfXCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L5nb9bmJPQFRAwlcVxypkI44efjS7kdj9r7veO4WamIAVxeo2B/a2AhtLBqCaUdHfqhjbeB8MGIpFVLOBdOxCgb+lfw7OMvmZfx3Nc+pLyeUBsUlz0sUgOmjDVhHDGUmmNGV+hOqDjNNg+xBRSj33zlms13NK3SEVF+X1hIejwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dIjAPzLw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dIjAPzLw"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 55F4E1F000FF;
	Fri, 18 Sep 2026 01:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789696439;
	bh=obV/ac6ej+fVGQtRoYSjypa70vcPU57Q0Ik4AGQOcqc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dIjAPzLwwEdoq3LpBwUIj8dKrNHe60hIpOlLugbcD1QtiP/dZdWyzgfun1xhVGEgt
	 dkQtOV//iQjkFZhF2NJl9nl5E/gEoFFUqJmH6/Ck09/wHhGHKi8lO65nMYlsHPo4oU
	 458D3fF2otwRwADTk/WYGMI5840gPCLyg5oNcAIPFsHz+3CQpvT+6FssuYq9Xj+7fT
	 yvgZMqVoG5mCVvyRI2c3nkLYs3RPXR7+FxhWU7Dc8vLtSNkSsShKwC3xbsvzZeMRE0
	 9NXcDFXyVfD+uwHaDXMWBZY5x81vsO1o2gU51WpfIytLPbJ4p7t0BgzC2EGiOew60I
	 cRmUGyyDsW3Xg==
Date: Fri, 18 Sep 2026 04:53:56 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Cc: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
	Jens Wiklander <jenswi@kernel.org>,
	Sumit Garg <sumit.garg@kernel.org>, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-arm-msm@vger.kernel.org,
	op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Add TPM support via Qualcomm TEE TPM TA
Message-ID: <aqyZtHynb2nuQT-P@kernel.org>
References: <20260907-tpm_qcom_driver-v2-0-71a6b1752da8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907-tpm_qcom_driver-v2-0-71a6b1752da8@oss.qualcomm.com>

On Mon, Sep 07, 2026 at 02:58:40PM +0530, Kuldeep Singh wrote:
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
> This patch series functionally depends on below(patch 5/6 specifically)
> for qtee service discovery.
> - https://lore.kernel.org/lkml/20260722-qcom_uefisecapp_migrate_qcomtee-v2-0-b8a8fcbe4211@oss.qualcomm.com/
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
> Changes in v2:
> - Use QCOMTEE_TPM_UID as 81 for service discovery in patch 1.
> - Use FIELD_GET, zero initialised array and log improvement (Konrad)
> - Improve commit title and other fixes (Jarkko)
> - Split MAINTAINERS entry as separate patch.
> - Link to v1: https://patch.msgid.link/20260831-tpm_qcom_driver-v1-0-6f16fa6924fa@oss.qualcomm.com
> 
> To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
> To: Jens Wiklander <jenswi@kernel.org>
> To: Sumit Garg <sumit.garg@kernel.org>
> To: Peter Huewe <peterhuewe@gmx.de>
> To: Jarkko Sakkinen <jarkko@kernel.org>
> To: Jason Gunthorpe <jgg@ziepe.ca>
> To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: op-tee@lists.trustedfirmware.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-integrity@vger.kernel.org
> 
> ---
> Kuldeep Singh (3):
>       tee: qcomtee: Register qcom.tz.tpm service for discovery
>       tpm: Introduce Qualcomm TPM driver
>       MAINTAINERS: Add Qualcomm TPM driver entry
> 
>  MAINTAINERS                       |   7 +
>  drivers/char/tpm/Kconfig          |   9 +
>  drivers/char/tpm/Makefile         |   1 +
>  drivers/char/tpm/tpm_qcom.c       | 354 ++++++++++++++++++++++++++++++++++++++
>  drivers/char/tpm/tpm_qcom.h       |  83 +++++++++
>  drivers/tee/qcomtee/call.c        |   4 +-
>  drivers/tee/qcomtee/qcomtee_msg.h |   2 +
>  7 files changed, 459 insertions(+), 1 deletion(-)
> ---
> base-commit: f3e6330d7fe42b204af05a2dbc68b379e0ad179e
> change-id: 20260831-tpm_qcom_driver-d21c720e73b2
> prerequisite-change-id: 20260408-qcom_uefisecapp_migrate_qcomtee-13869d45e014:v2
> prerequisite-patch-id: 4dc81445c9baf36f420da8c2e2bed96e71b31a5b
> prerequisite-patch-id: b487dfe2fbc076f4815dc6c73b9e68b0b78c961f
> prerequisite-patch-id: c5df2b3696520a96f95b2d3535ed84cdc21cc315
> prerequisite-patch-id: bbdd5327c15aeaa99ce9b74bab324a98f084ed48
> prerequisite-patch-id: 07d9c4e9fe9fd61f60e3f35b30b9d81716f0734c
> prerequisite-patch-id: 10ff88d87586f21f3cff3f72dbd21c27adbfbbcc
> 
> Best regards,
> --  
> Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
> 

Causes merge conflicts with my tree when applied with git am (actually
b4 shazam).

BR, Jarkko

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389CF305E1F;
	Mon, 19 Oct 2026 13:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792416098; cv=none; b=AHZ5Ze8j0NzWVHgwoTEcpcCjgS9M7KSheVrps7JU+2xWOqMYAlpzDtTbVpEAgqQBMsvdHlGKvUQ5jXaqR6Uneu8KKeny9IAWgJhQ6qinU3RygMruuA53AEZ5gNklVhNOD60fnVmO1uqM3L3WJtPmfkTybdxMUV6vAX9HPJKDrTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792416098; c=relaxed/simple;
	bh=t4RaAAhNDQW3GB2qxUGxvNCOVBzhA7WxA8Ad4wHd6Hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qhTJNUDnD+PlEkxhUfssnOqzAqIu0UrIp6EGDeZrmNaw1TxJcxjsHqPB6rz+WJaxiuKbaxchneE95WkljfmKfE/K9GK3tP2jQ56MKiuIU6dIGlHS+8xUIdHkFXF59vJmNoySxAbdAr0UIVFQ4HD/euGCX2Pk8l1pgNVtOMJ1mkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=df9wefRH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="df9wefRH"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 4F7201F000C4;
	Mon, 19 Oct 2026 13:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792416096;
	bh=MXOM9p/pv64oF7UY6qVlVeA0Fpe+myj4kNdbvKDYSSY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=df9wefRHKN7HcsxehaBfVkpCllAkofbk31C7StyYCzJCTtEvn+OEDvuskhLBPC3O8
	 mCeq5bIAvLJ6C32izh2R0tGtBKZStfA0M4T4pOR0F0nezQ7UjeZATLCA0ucyD0MnsH
	 M8oz5YIetuxAVGR33ZOWeq724veYJMzh+0EdpGZLnhb9MPBU62XjTfGBPVr7fMoulw
	 iU9Ho6lGYus8cNwtmQ9VhAxsNzmfNMAcOpGfDefWpScyna0kUHkReIdvC3EUfbezjI
	 98po9zaNuMCKNWlr3inxT0a3J6X0Z/OwhKCO7PgvT7qpESBbQ0FXEZ2ABUmn979mMY
	 HptIF3N6caM2Q==
Date: Mon, 19 Oct 2026 16:21:33 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Cc: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
	Jens Wiklander <jenswi@kernel.org>,
	Sumit Garg <sumit.garg@kernel.org>, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-arm-msm@vger.kernel.org,
	op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4 0/3] Add TPM support via Qualcomm TEE TPM TA
Message-ID: <atYZXRLf3YPZhiNB@kernel.org>
References: <20261019-tpm_qcom_driver-v4-0-6889b9804ba7@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019-tpm_qcom_driver-v4-0-6889b9804ba7@oss.qualcomm.com>

On Mon, Oct 19, 2026 at 02:51:45PM +0530, Kuldeep Singh wrote:
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
> - https://lore.kernel.org/lkml/20261015-qcom_uefisecapp_migrate_qcomtee-v5-0-1460691b35d3@oss.qualcomm.com/
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
> Changes in v4:
> - Add new line before goto label(Jarkko).
> - Link to v3: https://patch.msgid.link/20261015-tpm_qcom_driver-v3-0-247c8e50250e@qti.qualcomm.com
> 
> Changes in v3:
> - Merge tpm_qcom.h into tpm_qcom.c(Amir comments)
> - Update return values of functions and drop certain error prints.
> - Define locality_arg as default value.
> - Add Jarkko's tag on all but drop from 2/3 as significant changes done.
> - Link to v2: https://patch.msgid.link/20260907-tpm_qcom_driver-v2-0-71a6b1752da8@oss.qualcomm.com
> 
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
>  MAINTAINERS                       |   6 +
>  drivers/char/tpm/Kconfig          |   9 +
>  drivers/char/tpm/Makefile         |   1 +
>  drivers/char/tpm/tpm_qcom.c       | 414 ++++++++++++++++++++++++++++++++++++++
>  drivers/tee/qcomtee/call.c        |   4 +-
>  drivers/tee/qcomtee/qcomtee_msg.h |   2 +
>  6 files changed, 435 insertions(+), 1 deletion(-)
> ---
> base-commit: 2efb7a11f1aa4d2dc285fe2680cca22cb9f72f64
> change-id: 20260831-tpm_qcom_driver-d21c720e73b2
> prerequisite-change-id: 20260408-qcom_uefisecapp_migrate_qcomtee-13869d45e014:v5
> prerequisite-patch-id: faf4520d818abf0d7533f71d9c8b9a8aade34626
> prerequisite-patch-id: b487dfe2fbc076f4815dc6c73b9e68b0b78c961f
> prerequisite-patch-id: 9f2c4ee37ba173bdc860f253d44974379f2cf125
> prerequisite-patch-id: e86905ac6289821db30fd9a17f73e276e0a88363
> prerequisite-patch-id: 8777bfa2ef8344715bf972d049acb0a6ef49b136
> prerequisite-patch-id: 1c7f946e770a1cbc1599f9571282c9265a6af9cd
> prerequisite-patch-id: 7be993abea2ca36057d9352381a5890f50996dda
> 
> Best regards,
> --  
> Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
> 

Applying this pulls tons of TEE patches:

Applying: tee: qcomtee: Track the object invocation context
Applying: tee: Add kernel client object invoke helper
Applying: tee: qcomtee: Allow object invokes from kernel clients
Applying: tee: Export uuidv5 generation for TEE backends
Applying: tee: qcomtee: Add support for registering QTEE services on TEE bus
Applying: firmware: qcom: Add support for TEE based EFI-var client driver
Applying: arm64: defconfig: Enable UefiSecApp TEE client driver for Qualcomm SoCs
Applying: tee: qcomtee: Register qcom.tz.tpm service for discovery
Applying: tpm: Introduce Qualcomm TPM driver
Applying: MAINTAINERS: Add Qualcomm TPM driver entry

Br, Jarkko

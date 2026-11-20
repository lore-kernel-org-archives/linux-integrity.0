Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795179716;
	b=mQioeNFX9jEhcQpcJ6TZ3nmA1JgBQnNooBfVtXu5EQV+HIzD0tcLkJTEdddHfOZvVu8J
	 EEzuQGbJJNIzgZxzsBX4ciYi5EqUE5ElqN8aFbxvnk/EhIF8SKP5MniwcpfvJCroVhulU
	 UgNKRzPFmkDR5raABxqXrV0C73xMRi1IzD/GwZlq/txFo5DXPAP/LVyJQO0+wBGbZpbTG
	 G39vZ2XnOOnw5VdjBEXSlj/o3PXa0dTkwAI8jsl0d6l4JMAUTydPy4frk/UqdU7SGughd
	 sW3j8EJqD1ZqjzIdCyblsnjVEGJp4dWh3ae8ihbgbD/DeETTt4QWSeRX77HYEEQV1FA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795179716;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=cYsdqs4y232JPLuAEoAJ25nOUZJElAEMEA3xsIxpxkM=;
	b=NljDn77F8WUitGG6WP5QLWkqJ26j+qgtGUQHNVyJUa8F3fjrxRaWk8xhiFaIXhDkYEkl
	 WMuOqibGo7XtXEqTsZQ/1b2vz+Tc56A1JwKFSlqsB8NVyBiz9NHOTKh/+Da5a0vLG2Lpc
	 YTpajnD0brQzKO0LvK7eWQkoNpJoV+z4KldV2c9M6HYjs2VTMIhpknajZzliM+/3WYYbR
	 sZVgqOm5Q0B5x/PDUMRHZYMj8j7qks1/KwK1ApgoUsaThz2exM+hWMjnbvQPxCsplVnmO
	 jLQs7WCfJE3GPtOeGqCXr0eabV1QYd3hlBRTspPTBEQp/hg8rJnaSOzLisjNff1Claw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hs0nlq9C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id EAFD0606A320;
	Fri, 20 Nov 2026 13:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hs0nlq9C
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 472B21F000C6;
	Fri, 20 Nov 2026 13:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795179715;
	bh=cYsdqs4y232JPLuAEoAJ25nOUZJElAEMEA3xsIxpxkM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Hs0nlq9CX1tHPc6W09WRShiUTPcfyAvkwJlCfjKI7TYxn+t8Q/aP2TUoCYARmANMA
	 4BQ87lqlXVv2qruQ0wbMfzyX5DRzA/wACHorYkehbMxMX3vn6Yz7D+shJ0PSm16r7w
	 K20Wq7agCxBEt3jBRYG4WZmw2siy6zshIwcFZ1dSVeVpvf9d4ahXXeFQFLKMLLL2bH
	 BHTKa6kYB1e5j5I/FF/ndiR+kewDs/5n2GVda1zNzdPWCY4AXkg23p5al8zvLmZKbF
	 rGKW9dp15GAXjXGqvVQUJXu/+U7mGfRtYv7UBR0hAZb+HL7kEkMYbdMgVO4Ru3eufC
	 gSFBulHJbEefg==
Date: Fri, 20 Nov 2026 15:01:52 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Cc: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
	Jens Wiklander <jenswi@kernel.org>,
	Sumit Garg <sumit.garg@kernel.org>, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-arm-msm@vger.kernel.org,
	op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org
Subject: Re: [PATCH v5 0/3] Add TPM support via Qualcomm TEE TPM TA
Message-ID: <awBEwJf3CIjTvtid@kernel.org>
References: <20261120-tpm_qcom_driver-v5-0-3d9321ace107@oss.qualcomm.com>
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261120-tpm_qcom_driver-v5-0-3d9321ace107@oss.qualcomm.com>

On Fri, Nov 20, 2026 at 04:23:31PM +0530, Kuldeep Singh wrote:
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
> - https://lore.kernel.org/lkml/20261105-qcom_uefisecapp_migrate_qcomtee-v6-0-c7d68ce05c51@oss.qualcomm.com/
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
> Changes in v5:
> - Rebase on next-20261119.
> - Fix qcom_send_command resp_len computation(Amir)
> - Use dev_err_probe in _probe and return appropriate failures.
> - Propagate dtpm transfer/end error to callers.
> - Fix drv_data after tpmm_chip_alloc call.
> - Link to v4: https://patch.msgid.link/20261019-tpm_qcom_driver-v4-0-6889b9804ba7@oss.qualcomm.com
> 
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
>  drivers/char/tpm/tpm_qcom.c       | 410 ++++++++++++++++++++++++++++++++++++++
>  drivers/tee/qcomtee/call.c        |   4 +-
>  drivers/tee/qcomtee/qcomtee_msg.h |   2 +
>  6 files changed, 431 insertions(+), 1 deletion(-)
> ---
> base-commit: adcad7f4e6332cff3d6d7165f41584899f598534
> change-id: 20260831-tpm_qcom_driver-d21c720e73b2
> prerequisite-change-id: 20260408-qcom_uefisecapp_migrate_qcomtee-13869d45e014:v6
> prerequisite-patch-id: faf4520d818abf0d7533f71d9c8b9a8aade34626
> prerequisite-patch-id: b487dfe2fbc076f4815dc6c73b9e68b0b78c961f
> prerequisite-patch-id: 9f2c4ee37ba173bdc860f253d44974379f2cf125
> prerequisite-patch-id: e86905ac6289821db30fd9a17f73e276e0a88363
> prerequisite-patch-id: 09a86ee4de34e0c9cd2e4664c54a6473d7998299
> prerequisite-patch-id: a940a0624f1e130d1fe5213952965aa469bf9547
> prerequisite-patch-id: 7be993abea2ca36057d9352381a5890f50996dda
> 
> Best regards,
> --  
> Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
> 


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Br, Jarkko

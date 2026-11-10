Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794320371;
	b=VzHejze+9sZgmPmmKjqDqPBrr99WNGJeHpWezO/8v49LZBuJoq3rGuVYVT+d4OYJKxUg
	 o9lfrEcgVMY0wNXDgKXjUU6G5ixKxu+sAvubguhF6DxphMHwg0mC/46FmLHlimWK3rn3e
	 49lQoUt1J0j2GdIfr9/P+TKADl1iLfDOqDRd5Omv7i6QE20+IT8TnP6qwmIl7vXjBQkZr
	 sxRicAW9inhDsJZLaEaupH2CTFbfbGHv2plG1BYJb8siWA1kyugMezIs9aNvrxQ4siX88
	 FCmv5v/P+sLCtzvP72JcZTZ+9j904FMMjcRYqtXiwi4nE23F1xAdaRqn5aiFGlkdOoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320371;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=SOmC8+52QuEKRXpTW+Je0JIByHwi7+mD7gdJtxS54hM=;
	b=CIwxB3VmIYiZKBqX9zkAJt5s1cFM40a8L/ztnKHQ0XB2gSzZomlFzOgepmb8VmLUyq2K
	 Zftu4Tw9TSEpJbdhf6XBLqtiBQRwqQBXZYV55xL67CH5puHaFYfd1yrU2DB1yuZhiDs05
	 KpIpe+d+Yb2eWg9sl3zJia/yYAnfAhfOvM5UeXcVVgvLOzFnz6P7qAS9Ti38Yf5wOW4VC
	 kTA9tDRMTpA1h/laUJQcLVfXRXI2Bq2fe2vj8lyaGljVowmM80wppGA+EFd+cbeAWopg3
	 Dp+ARlcMOJJ2jGLwhYBWOT3yfygeSzyJtlm9C0pAjUu2FInQsYgrcUrEFRrGx2MQk6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=f97xuXUw;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=drjGgTmD;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3DB606A31C
	for <linux-integrity@vger.kernel.org>; Tue, 10 Nov 2026 14:19:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF3DB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=f97xuXUw;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=drjGgTmD
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AABAHlO2688078
	for <linux-integrity@vger.kernel.org>; Tue, 10 Nov 2026 14:19:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=SOmC8+52QuEKRXpTW+Je0JIByHwi7+mD7gd
	JtxS54hM=; b=f97xuXUw0RkSxkuNBi6U2xV8L7mlCxLZaKuO9w9he6slJvkZiEV
	S1Nb/I4AQgbENcVYeeqpOV+oMF+7LRlHCdJxayxAKO7r71Jrczn7jHkNTiKZQKhg
	RVEfqT6NAJhQ7MNV7OCYycqmM2vWQW5D6ufKywUglSetoH48XV+uLX5i9GXNY5CY
	xQc7hs60lBItKFq/tU95NyrCDIg8ST9tY7MEf/HcpQYwNjIksmOb8GwqIKZC79cz
	wkq94Mv+GfsmYdQi0VmgXxcoxuRwGASPgIC2PE1mPih9pqateO1mfmsYE1/ad0iT
	PGBFSHhi1PQ+XL+pl6fm6AWt+2Ooe2uyC5g==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4huucp29t2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Tue, 10 Nov 2026 14:19:30 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-7b206156cc6so1493945137.1
        for <linux-integrity@vger.kernel.org>; Tue, 10 Nov 2026 06:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794320369; x=1794925169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SOmC8+52QuEKRXpTW+Je0JIByHwi7+mD7gdJtxS54hM=;
        b=drjGgTmDh9I5RvLGuzoKzO6cyOfc40Y4J78qi/N3bFDcGcKOm1wV6Vf9BiSBlh47uH
         byK76KgICLRDfOnXm5G7WZUv9G+zccQlQ75lodTVZDcRzmgfaqlpI7JF+847CY7RGT0U
         vlQaj6ks4NqUKNhqq+zn11fEjV/tv6KcqpnvKVBflLM5/gixJsEzbrRzfv9eE2tw8Iq0
         pyXQV7AG3tn7zOreq6jgcJz86jDTq0jHD42fCSxY6aqSskidOGQSc+L0At8Yb1YP6zcH
         3ELX0YQHsqDZ6+d+qJLPTQovh0diQWNDVC/7bY7eUU0DzAvYtpKl+ftZ0pnW5C0KHcMh
         MFDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794320369; x=1794925169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SOmC8+52QuEKRXpTW+Je0JIByHwi7+mD7gdJtxS54hM=;
        b=belMCQsVun3Ek121758Fmv8pOeI/19K2SJeUR72wl3/Xey439HfJHWXsDlgIMaFwNs
         h1B+6icn5lqTIfb1OqEHgIyG/RYEccl44m5/669v3SkGa+zwJVM1X9Ep6EckJP9dzZrv
         bN4TWWh0xkE7TF0gpA7e1+3rs3JwHNVHlZD9UH91Nil7CglRGbgb58LiFYUD6zYQ/xRj
         /imyUPd+P51aaV03+usIY+5bdAmF6EurvNB5/rDi0bmSyO//0Zq0uGt+3B5DT8qpmm33
         IMBDq0fpofxOx1fmGt5riWuiJYWstB1cfyFApzQIkHkANqWu9WTXF3WJtA0TPpDOCk+8
         isjQ==
X-Forwarded-Encrypted: i=1; AL+hErGwrHkMeKRb0pfMNpcZYLR/MHnHLxQdi4foso7psnBDwPrj5uEkNIPSE5EYW9uSp1ncCe6Wl2tlnJtEEZF+j2g=@vger.kernel.org
X-Gm-Message-State: APuU4Z+UT3mwaq05z2skRGBn5OncaxqoOo8xDYe7cUUfCnb96ykDuAVZ
	ygAXde/2tCdD9/dSk3a5PNEVqZjfprzYPHVPUEbV6uaK/NN7OiY7z/ITZvVU1ZrnLNjjO1K0oxL
	yNf2xf9VAga8MwbOEH+LzI168zss4byvIhluqFdwtUa6s+U7/WOgD4723oXkHTBH0CxP+HXw=
X-Gm-Gg: AYBFou0yaOn3f5tOTDDU6v4+YJ+zQCCykv9NePJ9mx5TvXWFzvRY+PT1FC6LrVKl6SH
	STuTz8RLp3vWm8ZPWGqqsNG+Dqb8gTtxJFIspwvMsisP6pWFCcwoNRkIGhGx50x+mkbNFHK1fLr
	YQ/E6VHHbulIrdU+siVRZ7MYZCpRb24h/+TsyUf+6c4bgo/vO3u/uM/dri5L1fTWlCcpvZJA8D/
	2Rcc6sZ1Mqncy87CKcsnaSQrApmfgoZ+SGvD4wbXSA0u/SfvG/ezYXX9/FD7epq7Zp674kmvPvj
	1SY5V535cfWOBv6QB0HHB6wA6vgsOqAluV7n2e8q4EdmD+o9WfaGuJ/NDOVzAPvsOd0OKFKUkwV
	76VejgSmKguGXVMpBP16AR3EjXMvQkjGRxT+wnmIUr3JsZgVPjVi9EqabWy9bDpilnxHK93DOjz
	mlPYdsgIgHG8t7DLa+1g==
X-Received: by 2002:a05:6102:418f:b0:7b3:32fe:77b6 with SMTP id ada2fe7eead31-7d301ab6ca3mr1046747137.3.1794320368739;
        Tue, 10 Nov 2026 06:19:28 -0800 (PST)
X-Received: by 2002:a05:6102:418f:b0:7b3:32fe:77b6 with SMTP id ada2fe7eead31-7d301ab6ca3mr1046715137.3.1794320368239;
        Tue, 10 Nov 2026 06:19:28 -0800 (PST)
Received: from trex (50.red-81-37-172.dynamicip.rima-tde.net. [81.37.172.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4983284c99bsm5418133f8f.7.2026.11.10.06.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 06:19:27 -0800 (PST)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, peterhuewe@gmx.de, jarkko@kernel.org,
        jgg@ziepe.ca, sumit.garg@oss.qualcomm.com
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: [PATCH v2 0/2] tpm: OP-TEE transport core for discrete and firmware TPMs
Date: Tue, 10 Nov 2026 15:19:07 +0100
Message-ID: <20261110141923.3100770-1-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: i-epEISdfkxyZxX7N0P5f022P-_3jGmv
X-Authority-Analysis: v=2.4 cv=U4oHnuru c=1 sm=1 tr=0 ts=6af327f2 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=VbO86HPdXvN82gCvB8O6pw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=NEAV23lmAAAA:8
 a=McN5tr3TAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=OUebXRtQ7c3ikY1XWJ0A:9
 a=qcg49hLlgF0N60+LroqrWnV/Vu4=:19 a=gYDTvv6II1OnSo0itH1n:22
 a=OiMWn5MEmObRqTLTTlUg:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA1NiBTYWx0ZWRfX68eykvjDQSO0
 Z7GIZ6vVbGI6XIx3XpZa1G4tT2K2NMBMjRex1v1UjSRZe5M1UGPiWIeSbsB6E05q7OBt+YPBvCn
 h6F8NoNO4lBugn77sN3K3K+okL4BH/cldUzTAzYUJ+mppqrxZpVgYsr1VlM66KK7RhvLC4PduU4
 rYIDKp9GhWDucvrIsfSdgsR314YzieQH32BnUAbUqmYxK/a8v4LbUUiYYsvi+DyXAu1vVM+CRF4
 tA9ji9k3gj9GMyuPaj+Y1fBZMuDmFgvouPFfuJUSNo2K+AdNgX6MXwoAphWdUTJk8HhObARRtXy
 iDO+vhp2B9jxq3/NvEj0GJaUgCAVI5bUE0s7vtEQPeYdPAzNSZLINU4eaAnq4GdmaRJ9XJW3xYM
 lM5BiWEkSJ7NKU3I/3kelIbrGh7DI19Uq9HYrzDEGk8Lt0eiqiWti5qiGU7nsvf6KfPy0aqMffE
 meCAL3/AAiicbi3EqaA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA1NiBTYWx0ZWRfX//CBwpunI1WR
 dfMKcmlt9F/6MfHq+FUF648a973nNVJV/THp4gJ32Arqtp+Kgr7//xm5D0GuRIkNnZOmJujArD/
 zoC6J/OpvReac4rBAZRaDVllgDzUHPE=
X-Proofpoint-GUID: i-epEISdfkxyZxX7N0P5f022P-_3jGmv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 spamscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100056

This adds a driver for a discrete TPM that OP-TEE owns and the normal
world cannot reach directly, and factors the shared OP-TEE TEE transport
into a small core so the existing fTPM driver uses it too:

  - a transport core shared by the OP-TEE TPM front-ends;
  - a new discrete TPM front-end;
  - the fTPM driver converted onto the core, keeping its name, its
    platform/OF binding and its shutdown path.

Patch 1 is the feature; patch 2 is the fTPM conversion that justifies the
core. Both front-ends were exercised on the Qualcomm Lemans EVK over the
shared core: the discrete ST33 TPM (patch 1) and the MS-TPM-20 firmware
TPM TA (patch 2), each presenting a working /dev/tpm0 (tpm2_getrandom,
PCR read). The fTPM TA is the same MS-TPM-20 reference the existing
tpm_ftpm_tee platforms use.

This is the normal-world half. The secure-world OP-TEE support it binds
to -- the in-core TPM2 SPI (TIS) driver and the mediator pseudo TA that
relays commands to it -- is under review separately:

  OP-TEE support: https://github.com/OP-TEE/optee_os/pull/8155
  locality 4:     https://github.com/OP-TEE/optee_os/issues/8160
                  (design follow-up: the secure world policing
                  normal-world locality access to the shared chip)

Build and test it on the Qualcomm Lemans EVK (a discrete ST33 TPM on
SPI, owned by OP-TEE):

  https://qualcomm-linux.github.io/qcom-buildroot/lemans/quick-start.html

v1: https://lore.kernel.org/linux-integrity/20261026163259.1900439-1-jorge.ramirez@oss.qualcomm.com/

Changes since v1:
 - split the shared TEE transport into a core; the discrete chip is now a
   thin front-end, the tpm_tis_core-style solution that was asked for.
 - convert the fTPM driver onto the same core instead of duplicating it.
 - use an optee-prefixed name for the new modules; the fTPM driver keeps
   its name, no module rename.
 - rewrite the commit message with a plain description of the components
   and the rationale for a separate front-end.
 - drop the explicit zeroing in favour of initialisers, and reword the
   module description.

Jorge Ramirez-Ortiz (2):
  tpm: add OP-TEE transport core and a discrete TPM driver
  tpm_ftpm_tee: use the tpm_optee transport core

 MAINTAINERS                       |   8 +
 drivers/char/tpm/Kconfig          |  28 +++
 drivers/char/tpm/Makefile         |   2 +
 drivers/char/tpm/tpm_ftpm_tee.c   | 295 ++----------------------------
 drivers/char/tpm/tpm_ftpm_tee.h   |  35 ----
 drivers/char/tpm/tpm_optee.c      | 253 +++++++++++++++++++++++++
 drivers/char/tpm/tpm_optee.h      |  32 ++++
 drivers/char/tpm/tpm_optee_dtpm.c |  67 +++++++
 8 files changed, 408 insertions(+), 312 deletions(-)
 delete mode 100644 drivers/char/tpm/tpm_ftpm_tee.h
 create mode 100644 drivers/char/tpm/tpm_optee.c
 create mode 100644 drivers/char/tpm/tpm_optee.h
 create mode 100644 drivers/char/tpm/tpm_optee_dtpm.c


base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
-- 
2.55.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793032392;
	b=vrXIG8cd73KQv1RhUNWkIMTTEi/733fcB5dQy0q0YowBB9gyW/bsdXFdbYqe+XNN6L1B
	 1Kkg3ih3RSO17PfAt0VDcI9dC1b5wt8n8cqRd8GlDwa55BYQykG9tWu4bmpwRnnLaczob
	 OjXdqp3fbiMCF0YbBelbLEu8weikcnjpR2ACYEv/0ek0l+CleKS6cLU3vaIWC99PrYyWM
	 5AoGPVJDjPPB19mR+B71seKYkTfKD+aOey3ss4fGybqjVGVxyPWSj5Ux+lkH4X/ycKQ+f
	 QMt2Ha71Ek+eXbJXgkSBgWLxE60NtgckoAWJn3dVzBtJYIdw8FWv7HTJ/OXQNhkVPrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793032392;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=7XdhxEjq8Nz8ocgVSxevlMoJ8CO2/+GV0khQz8G/fPQ=;
	b=oaG/aRsuahnRsLQyv7w+0kH3etrtWry+RXVLNgLzldMxWeCpRC70iOkytpY3cjecDeL5
	 HUJDAIZHwiampig06+gWXG95v07LW6Jz83GPO/ta4+mLMTi+7QsZEXioJVsK70Kcm/hrJ
	 JeG4m0NuWC7AGKd9Up4rNpqIDaZS0CeVMzrfk1zzmopMG/vKrX8deoA6V5flI6LvI04J7
	 81ltZGoBUAwxiKw7r97MqwVvqs7Y0c60XkyOfRB5ZMVrAe8JMTNzGmkxfFGTxtn8vibUd
	 jripMmgimnYNURPKu41oWkX1R1ZFMJuHhtIgSCdv2+RdOdKPAzw30CsBL0vohya22Sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=O3yKfInn;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WM4XEGsO;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F40A606A322
	for <linux-integrity@vger.kernel.org>; Mon, 26 Oct 2026 16:33:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F40A606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=O3yKfInn;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WM4XEGsO
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QEwHqX3075213
	for <linux-integrity@vger.kernel.org>; Mon, 26 Oct 2026 16:33:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=7XdhxEjq8Nz
	8ocgVSxevlMoJ8CO2/+GV0khQz8G/fPQ=; b=O3yKfInnkb63shxleVEjE6hSiwS
	sgg0eTMgAlMNN56qUwENstC0/BycxxsZ6tHzP3f14yf7i0hDnmMX6ZmEnCJsrkNN
	Durx6+2FnRcuxoqJQ0TK2f5ZoVfAW1HoJ6Pmz5i110bxeMp+4PPrnaEkFTBseLrg
	Uw/hxaV/KE7VRm23HFLmNg8UwdJFmCcRFGqI9wa0e8Gfm2kvp2BhXO5TVkp4RDsS
	JB4J1BogNFZv1qPFy3XQm4zOC11ItT3p6MvrdVusgdKZ+eZruh8TmB9AQVCgnNAN
	7VGupTW1Kq0yXUT+ZmbU9ysxRGtJybkiz47vZ29TD21g7eOjfnWpCRBae5Q==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hhsjdbcdx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Mon, 26 Oct 2026 16:33:10 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93cb93c874bso13791085a.0
        for <linux-integrity@vger.kernel.org>; Mon, 26 Oct 2026 09:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793032389; x=1793637189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7XdhxEjq8Nz8ocgVSxevlMoJ8CO2/+GV0khQz8G/fPQ=;
        b=WM4XEGsOzo/+CiSCc3qww6f5omeC6YupAMVM/Su8C95oIMlAWzQiLrZz0srIq824Ka
         nRi2uJ3QvZjoFztodZqJ8BlruoRjNHoczlQgg5rxHQOIf+vPVS9rdIHAp+Y0rXSidwdK
         0sk+WpHMqr87jtsDOsHMgQPKd4nSLSVdCwVgOu2yEHfertFlLWWVb9GZ0Yp9+JBmYC0d
         MZb7V7w4sP+XFPgNep/v3Pc4AviECRtpiQbqdxK+4fxw0qQ8GYh0YzfpCvoo9/yTBoB7
         UcqtXuJE9yXDiYG644NiIbNAuEHAPbPn1j+g77OQnCCDafHeoz8zicXMeM4Mkae/VqPD
         gVZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793032389; x=1793637189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7XdhxEjq8Nz8ocgVSxevlMoJ8CO2/+GV0khQz8G/fPQ=;
        b=T7J9Qapepd5MnxQBHltNTQJ1H2XVZgQ8LAKHT79LF+S18JalASPlpAhSf079eBUjHu
         9ykVWPNvVmuc0pVBUv+QbncEUKlf/V2FtQ0n21Y5uEQrRRDEXfk31l9lKWi8LtqRaZmV
         pdjb+bNA78r6981JzRE1YksdMS4kT642OZqSBWfhWlpBpHkrnLD0JDWnxxnwWtqqgwEg
         F4emIMBWDufP+ka2/1pa842oqDOF24reOCLGs1A5L+4lE7wamLryAdW74DtXvaGcUQeK
         mu96wqgr7nb3NOoSvXp/QhvJfQ3JhCzYMCQkTi6GP01G0CCop/YJsArvil+vRkxDpP8E
         2p8A==
X-Forwarded-Encrypted: i=1; AKwUvBz72U15EIS6x8Jb4kpxEglbd38nRnub9VzIIF+NwbzRVfKBr2rEC4zlR/E8uVotqUKixjH32ZjxkmzQF02C970=@vger.kernel.org
X-Gm-Message-State: AFq9FYJZXzxilCcODi1CFYFp0GnrI16cKCoRJKE7ynm9WlWMVcnalUpZ
	vLFpQg/caY6fPEBc+xDuWsS5MIdFxHibzlKkkZWIp1RKUyIFgHharc1XHMYp42lYMatSGdo7h7E
	bjkkzelOp8j2Px4873833JKZ2J7LwQSan3MP3+29idglsUy7YAs8diOSlhOGzeow3NMgCiSk=
X-Gm-Gg: AYBFou0/CLkXAc9YbnPUAbj7TJ+EqR+X5v9w7K1a8Ii/7hkCaJNiTaR+LjDwcRDptX6
	YM8K6Jk5IwsO2J88iUl6sliZ09athMW4H6BJfYNOkD3mk6xOKzsL8U/Umkt3q6JjgX/oZtAN/19
	7yWnuBK4nKbywFi9nrX4ePUgHqosWrZaTEyp2MxJpsWfOrXX7o4Ln/Bn3yl7/6ghx/evei1qe+U
	V7MEfNwsH2WFwB9va9pYW44Buxh9azh93OyhL7B/dSLm2PpsjMDa1eqKEZX8x1iyIiCYy56Zkw/
	dD9pSu+diTR9S9vWll1J871/WwLNt77TpUoGjzslMy01Z4y80vu38CkYZd5kIchjAqjAXlmr8gh
	7wLeaNi+iy9qV2E0JZHyW/yWCk1YydI8aLNjn/uKLWZYj
X-Received: by 2002:a05:620a:269f:b0:939:b053:ce44 with SMTP id af79cd13be357-943f4b8daf9mr29250685a.22.1793032389042;
        Mon, 26 Oct 2026 09:33:09 -0700 (PDT)
X-Received: by 2002:a05:620a:269f:b0:939:b053:ce44 with SMTP id af79cd13be357-943f4b8daf9mr29239285a.22.1793032387879;
        Mon, 26 Oct 2026 09:33:07 -0700 (PDT)
Received: from trex (50.red-81-37-172.dynamicip.rima-tde.net. [81.37.172.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc3932sm18589629f8f.18.2026.10.26.09.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 09:33:07 -0700 (PDT)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, peterhuewe@gmx.de, jarkko@kernel.org,
        jgg@ziepe.ca, sumit.garg@oss.qualcomm.com
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: [PATCH 1/1] tpm: add TEE driver for a discrete TPM behind OP-TEE
Date: Mon, 26 Oct 2026 17:32:48 +0100
Message-ID: <20261026163259.1900439-2-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026163259.1900439-1-jorge.ramirez@oss.qualcomm.com>
References: <20261026163259.1900439-1-jorge.ramirez@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: oYXXjwYzjFngi_IxaoByTHt6Ev4axl_M
X-Proofpoint-GUID: oYXXjwYzjFngi_IxaoByTHt6Ev4axl_M
X-Authority-Analysis: v=2.4 cv=a4elZkSF c=1 sm=1 tr=0 ts=6adf80c6 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=VbO86HPdXvN82gCvB8O6pw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=YYtI6MHMq6Vl5AE-ZLQA:9
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA2NSBTYWx0ZWRfX2i4sbu7LRn/j
 fqwTNY3Ln1AcIGUn0xwXYRK/ke7euksW5CFz3TSvxOfORGyfVP8S1oDEOBmEifNKwjoWMcD9ac5
 eqKw+CcWkW46iMGb1KvafpAdvC4msjA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA2NSBTYWx0ZWRfX9y7vma0gCkrD
 PINpds7pYHyH4jCKVDuLbbSS7vb5u1TlvwBRHuCThnttSDKUVEGNnjryRSaKa6E5YWVC1DGp0yg
 lIrIm6mn5HD1SVz/2bCftUO1LYdyi8PISMiZgx/nzB37SkO45SIeh+srxNtuXv5MnhXaAjZh7t2
 V5nt5FMXhdj5EeEvcMgaAkNWORm272M7+VMMNYY3EIYcM0wRylwvCVmoaAmotl3xPTapHADXHwB
 rcE9Mf20x0J9dBuLBgE9FozM+emZ/X6XZ08sN8i9FTkhUhEbHnaPnbOQaBluENwthtLc77TbRCg
 coTE9/3s6tcvhy4Jff9xVZPWFA2Mbib6g4DCGz+0J+VEH4obfXeWB7tb9sbdt+BHrP11u/Er9oo
 BJC0zFx3uMCcxRwgZzk9wPk98TmXP8uKOBcSQ4gOFp7BOuA7l29p3eF3VYfH3aJ3P4UJVbs+rqu
 AKrT2Jw/WNOU728Zu/w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1011 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260065

Add tpm_dtpm_tee for a discrete TPM that OP-TEE owns and the normal world
cannot reach directly (e.g. an SPI TPM on a bus driven by OP-TEE). The
driver binds to OP-TEE's passthrough pseudo TA by UUID and forwards TPM2
commands through it, presenting a standard TPM2 character device.

It is a separate driver rather than a reuse of tpm_ftpm_tee: the TEE
transport is the same, but that driver is tied to the Microsoft fTPM TA
and opens a public-login session, whereas this is a distinct TA for a real
chip, gated to REE-kernel access so that user space and other TAs cannot
reach the TPM. Sharing the fTPM identity would conflate two different
devices and collide on a platform that has both.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
---
 MAINTAINERS                     |   6 +
 drivers/char/tpm/Kconfig        |  18 ++
 drivers/char/tpm/Makefile       |   1 +
 drivers/char/tpm/tpm_dtpm_tee.c | 282 ++++++++++++++++++++++++++++++++
 4 files changed, 307 insertions(+)
 create mode 100644 drivers/char/tpm/tpm_dtpm_tee.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 782389bd5cd3..2d279f45fcea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27710,6 +27710,12 @@ F:	include/linux/tpm*.h
 F:	include/uapi/linux/vtpm_proxy.h
 F:	tools/testing/selftests/tpm2/
 
+TPM TEE DRIVER FOR DISCRETE TPM
+R:	Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
+L:	linux-integrity@vger.kernel.org
+S:	Supported
+F:	drivers/char/tpm/tpm_dtpm_tee.c
+
 TPS546D24 DRIVER
 M:	Duke Du <dukedu83@gmail.com>
 L:	linux-hwmon@vger.kernel.org
diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
index 5f672f2c01b0..8293e43e4bc0 100644
--- a/drivers/char/tpm/Kconfig
+++ b/drivers/char/tpm/Kconfig
@@ -243,6 +243,24 @@ config TCG_FTPM_TEE
 	help
 	  This driver proxies for firmware TPM running in TEE.
 
+config TCG_DTPM_TEE
+	tristate "TEE based discrete TPM Interface"
+	depends on TEE && OPTEE
+	help
+	  This driver proxies for a discrete TPM that is owned by OP-TEE and
+	  reachable only from the secure world (for example an SPI TPM behind
+	  OP-TEE's TPM TIS driver). OP-TEE exposes a passthrough pseudo TA and
+	  this driver pipes TPM commands through it, presenting a standard
+	  TPM character device to the normal world.
+
+	  The secure world is the sole owner of the TPM and of the bus it
+	  sits on. That bus/controller must be disabled in the non-secure
+	  device tree: disabling only the in-kernel TPM driver (e.g.
+	  tpm_tis_spi) is not enough, because the normal-world bus controller
+	  would still drive the engine in parallel with OP-TEE and corrupt
+	  its transfers. With the bus disabled, the TPM is reached only
+	  through this driver.
+
 config TCG_SVSM
 	tristate "SNP SVSM vTPM interface"
 	depends on AMD_MEM_ENCRYPT
diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
index 5b5cdc0d32e4..5c5e20001cac 100644
--- a/drivers/char/tpm/Makefile
+++ b/drivers/char/tpm/Makefile
@@ -45,5 +45,6 @@ obj-$(CONFIG_TCG_CRB) += tpm_crb.o
 obj-$(CONFIG_TCG_ARM_CRB_FFA) += tpm_crb_ffa.o
 obj-$(CONFIG_TCG_VTPM_PROXY) += tpm_vtpm_proxy.o
 obj-$(CONFIG_TCG_FTPM_TEE) += tpm_ftpm_tee.o
+obj-$(CONFIG_TCG_DTPM_TEE) += tpm_dtpm_tee.o
 obj-$(CONFIG_TCG_SVSM) += tpm_svsm.o
 obj-$(CONFIG_TCG_LOONGSON) += tpm_loongson.o
diff --git a/drivers/char/tpm/tpm_dtpm_tee.c b/drivers/char/tpm/tpm_dtpm_tee.c
new file mode 100644
index 000000000000..755429ff8a3f
--- /dev/null
+++ b/drivers/char/tpm/tpm_dtpm_tee.c
@@ -0,0 +1,282 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * TEE driver for a discrete TPM owned by OP-TEE and exposed to the normal
+ * world through a passthrough pseudo TA. The chip sits on a bus only the
+ * secure world can reach (e.g. SPI behind OP-TEE's TPM TIS driver); the driver
+ * binds the TA by UUID and relays raw TPM2 commands as a standard tpm_chip.
+ */
+
+#include <linux/module.h>
+#include <linux/tee_drv.h>
+#include <linux/tpm.h>
+#include <linux/uuid.h>
+
+#include "tpm.h"
+
+/* Must match the discrete TPM passthrough pseudo TA in OP-TEE */
+static const uuid_t dtpm_ta_uuid =
+	UUID_INIT(0x50568cd9, 0x370a, 0x46b8,
+		  0x9f, 0x2c, 0x6f, 0xd9, 0x06, 0x64, 0xd2, 0xee);
+
+#define DTPM_TEE_TA_SUBMIT_COMMAND	0
+
+#define DTPM_MAX_COMMAND_SIZE		4096
+#define DTPM_MAX_RESPONSE_SIZE		4096
+
+struct dtpm_tee_private {
+	struct tpm_chip *chip;
+	u32 session;
+	struct tee_context *ctx;
+	struct tee_shm *shm;
+};
+
+/* Validate the response header the TA wrote back, return its length or -EIO */
+static int dtpm_tee_resp_len(struct tpm_chip *chip, const u8 *resp,
+			     size_t bufsiz)
+{
+	size_t resp_len = be32_to_cpu(((struct tpm_header *)resp)->length);
+
+	if (resp_len < TPM_HEADER_SIZE || resp_len > DTPM_MAX_RESPONSE_SIZE ||
+	    resp_len > bufsiz) {
+		dev_err(&chip->dev, "bad response length %zu (buffer %zu)\n",
+			resp_len, bufsiz);
+		return -EIO;
+	}
+
+	return resp_len;
+}
+
+/**
+ * dtpm_tee_tpm_op_send() - relay a TPM command through TEE shared memory.
+ * @chip:	the tpm_chip description
+ * @buf:	command on entry, response on return
+ * @bufsiz:	size of @buf
+ * @cmd_len:	number of command bytes to send
+ *
+ * Return: number of response bytes on success, -errno on failure.
+ */
+static int dtpm_tee_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
+				size_t cmd_len)
+{
+	struct dtpm_tee_private *pvt_data = dev_get_drvdata(chip->dev.parent);
+	struct tee_shm *shm = pvt_data->shm;
+	struct tee_ioctl_invoke_arg transceive_args;
+	struct tee_param command_params[4];
+	u8 *temp_buf;
+	int rc;
+
+	if (cmd_len > DTPM_MAX_COMMAND_SIZE || cmd_len > bufsiz) {
+		dev_err(&chip->dev, "command length %zu (buffer %zu)\n",
+			cmd_len, bufsiz);
+		return -EIO;
+	}
+
+	memset(&transceive_args, 0, sizeof(transceive_args));
+	memset(command_params, 0, sizeof(command_params));
+
+	transceive_args = (struct tee_ioctl_invoke_arg) {
+		.func = DTPM_TEE_TA_SUBMIT_COMMAND,
+		.session = pvt_data->session,
+		.num_params = 4,
+	};
+
+	/* memref[0]: command in, memref[1]: response in/out */
+	command_params[0] = (struct tee_param) {
+		.attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT,
+		.u.memref = {
+			.shm = shm,
+			.size = cmd_len,
+			.shm_offs = 0,
+		},
+	};
+
+	temp_buf = tee_shm_get_va(shm, 0);
+	if (IS_ERR(temp_buf)) {
+		dev_err(&chip->dev, "tee_shm_get_va failed for transmit\n");
+		return PTR_ERR(temp_buf);
+	}
+	memset(temp_buf, 0, DTPM_MAX_COMMAND_SIZE + DTPM_MAX_RESPONSE_SIZE);
+	memcpy(temp_buf, buf, cmd_len);
+
+	command_params[1] = (struct tee_param) {
+		.attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT,
+		.u.memref = {
+			.shm = shm,
+			.size = DTPM_MAX_RESPONSE_SIZE,
+			.shm_offs = DTPM_MAX_COMMAND_SIZE,
+		},
+	};
+
+	rc = tee_client_invoke_func(pvt_data->ctx, &transceive_args,
+				    command_params);
+	if (rc < 0 || transceive_args.ret != 0) {
+		dev_err(&chip->dev, "SUBMIT_COMMAND invoke error: 0x%x\n",
+			transceive_args.ret);
+		return (rc < 0) ? rc : -EIO;
+	}
+
+	temp_buf = tee_shm_get_va(shm, command_params[1].u.memref.shm_offs);
+	if (IS_ERR(temp_buf)) {
+		dev_err(&chip->dev, "tee_shm_get_va failed for receive\n");
+		return PTR_ERR(temp_buf);
+	}
+
+	rc = dtpm_tee_resp_len(chip, temp_buf, bufsiz);
+	if (rc < 0)
+		return rc;
+
+	memcpy(buf, temp_buf, rc);
+
+	return rc;
+}
+
+static const struct tpm_class_ops dtpm_tee_tpm_ops = {
+	.flags = TPM_OPS_AUTO_STARTUP,
+	.send = dtpm_tee_tpm_op_send,
+};
+
+static int dtpm_tee_match(struct tee_ioctl_version_data *ver, const void *data)
+{
+	/* Only GP-compliant OP-TEE is supported */
+	if (ver->impl_id == TEE_IMPL_ID_OPTEE && (ver->gen_caps & TEE_GEN_CAP_GP))
+		return 1;
+
+	return 0;
+}
+
+/*
+ * Open the TA session as the REE kernel: the TA gates the shared TPM on
+ * TEE_LOGIN_REE_KERNEL so user space and other TAs cannot submit raw commands.
+ */
+static int dtpm_tee_open_session(struct device *dev, struct tee_context *ctx,
+				 u32 *session)
+{
+	struct tee_ioctl_open_session_arg sess_arg;
+	int rc;
+
+	memset(&sess_arg, 0, sizeof(sess_arg));
+	export_uuid(sess_arg.uuid, &dtpm_ta_uuid);
+	sess_arg.clnt_login = TEE_IOCTL_LOGIN_REE_KERNEL;
+	sess_arg.num_params = 0;
+
+	rc = tee_client_open_session(ctx, &sess_arg, NULL);
+	if (rc < 0 || sess_arg.ret != 0) {
+		dev_err(dev, "tee_client_open_session failed, err=0x%x\n",
+			sess_arg.ret);
+		return -EINVAL;
+	}
+
+	*session = sess_arg.session;
+
+	return 0;
+}
+
+static int dtpm_tee_probe(struct tee_client_device *tcdev)
+{
+	struct device *dev = &tcdev->dev;
+	struct dtpm_tee_private *pvt_data;
+	struct tpm_chip *chip;
+	int rc;
+
+	pvt_data = devm_kzalloc(dev, sizeof(*pvt_data), GFP_KERNEL);
+	if (!pvt_data)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, pvt_data);
+
+	pvt_data->ctx = tee_client_open_context(NULL, dtpm_tee_match, NULL,
+						NULL);
+	if (IS_ERR(pvt_data->ctx)) {
+		if (PTR_ERR(pvt_data->ctx) == -ENOENT)
+			return -EPROBE_DEFER;
+		dev_err(dev, "tee_client_open_context failed\n");
+		return PTR_ERR(pvt_data->ctx);
+	}
+
+	rc = dtpm_tee_open_session(dev, pvt_data->ctx, &pvt_data->session);
+	if (rc)
+		goto out_tee_session;
+
+	pvt_data->shm = tee_shm_alloc_kernel_buf(pvt_data->ctx,
+						 DTPM_MAX_COMMAND_SIZE +
+						 DTPM_MAX_RESPONSE_SIZE);
+	if (IS_ERR(pvt_data->shm)) {
+		dev_err(dev, "tee_shm_alloc_kernel_buf failed\n");
+		rc = -ENOMEM;
+		goto out_shm_alloc;
+	}
+
+	chip = tpm_chip_alloc(dev, &dtpm_tee_tpm_ops);
+	if (IS_ERR(chip)) {
+		dev_err(dev, "tpm_chip_alloc failed\n");
+		rc = PTR_ERR(chip);
+		goto out_chip_alloc;
+	}
+
+	pvt_data->chip = chip;
+	pvt_data->chip->flags |= TPM_CHIP_FLAG_TPM2 | TPM_CHIP_FLAG_SYNC;
+
+	rc = tpm_chip_register(pvt_data->chip);
+	if (rc) {
+		dev_err(dev, "tpm_chip_register failed with rc=%d\n", rc);
+		goto out_chip;
+	}
+
+	return 0;
+
+out_chip:
+	put_device(&pvt_data->chip->dev);
+out_chip_alloc:
+	tee_shm_free(pvt_data->shm);
+out_shm_alloc:
+	tee_client_close_session(pvt_data->ctx, pvt_data->session);
+out_tee_session:
+	tee_client_close_context(pvt_data->ctx);
+
+	return rc;
+}
+
+static void dtpm_tee_remove(struct tee_client_device *tcdev)
+{
+	struct dtpm_tee_private *pvt_data = dev_get_drvdata(&tcdev->dev);
+
+	tpm_chip_unregister(pvt_data->chip);
+	put_device(&pvt_data->chip->dev);
+	tee_shm_free(pvt_data->shm);
+	tee_client_close_session(pvt_data->ctx, pvt_data->session);
+	tee_client_close_context(pvt_data->ctx);
+}
+
+static const struct tee_client_device_id dtpm_tee_id_table[] = {
+	{UUID_INIT(0x50568cd9, 0x370a, 0x46b8,
+		   0x9f, 0x2c, 0x6f, 0xd9, 0x06, 0x64, 0xd2, 0xee)},
+	{}
+};
+MODULE_DEVICE_TABLE(tee, dtpm_tee_id_table);
+
+static struct tee_client_driver dtpm_tee_driver = {
+	.probe		= dtpm_tee_probe,
+	.remove		= dtpm_tee_remove,
+	.id_table	= dtpm_tee_id_table,
+	.driver		= {
+		.name		= "optee-dtpm",
+	},
+};
+
+static int __init dtpm_tee_mod_init(void)
+{
+	return tee_client_driver_register(&dtpm_tee_driver);
+}
+
+static void __exit dtpm_tee_mod_exit(void)
+{
+	tee_client_driver_unregister(&dtpm_tee_driver);
+}
+
+module_init(dtpm_tee_mod_init);
+module_exit(dtpm_tee_mod_exit);
+
+MODULE_DESCRIPTION("TPM Driver for a discrete TPM behind OP-TEE");
+MODULE_LICENSE("GPL");
-- 
2.55.0


Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821BC3DDB1D
	for <linux-integrity@vger.kernel.org>; Mon, 31 Aug 2026 09:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788169414; cv=none; b=gDLIb5TkI275klcujTkLGD+nNM7COpEvk/1HTSbjJjuK6hAjzNyt23GK7Enmwl1/zJpHr8zfoFiVNvWnNLo9oLwMTh5c7mrJag7j5JF96dsWhDI3bmiB0uxPjJ2i/cwwV1j+Xnk5mDx+zX1ByjCoosvqY5e7JBOGyyJHteE2y34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788169414; c=relaxed/simple;
	bh=lODo1ncGezF+5O1pU0Dmw33i4gi6Vg1twM9dzgHGILY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RajLFLwAzcRkJHYNKZL8AvA8XUVnTOcg8aBCsP6n2w7hbXGmm3Oc8V4wHr65lGumOUuHiWbENfnbciWBoPJ7Q/ldyAvUmmgLDUyUHY13OTcjYeExntm8G+f/cRNHrQCaCdx4f4I+gGth3taHxazmCaR8qaZVdNjlTtkop0J4pFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ffXHWoYG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GRlmGWUe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ffXHWoYG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GRlmGWUe"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V9IjBp2516054
	for <linux-integrity@vger.kernel.org>; Mon, 31 Aug 2026 09:43:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tkKQYEdU2otSQ16uLjlwJhpUcwTRXJcL7OKIS4TBoYk=; b=ffXHWoYGRD4mEK8t
	cigs74FSAvQv2psNWKL4MZsTF40UhVHa/K4VsbVpcsPAKSEyNpcotvFxSW0eQJDW
	l+FJXHIuSgT+IqutnsDP1WQaGSVF5fs4LAJdIVtjrTTZIx8OUMbbDUuO00Af9mIS
	IuyvfTIQ0Gyb17Gwj43Bs7ffkPwqABorLTkc9osoeaCfWe0eKq8Y5sDitniUqXSb
	0RpCaPu8CJaeBeHwtDnpEBFqfqUzZysJK0sTVXtZnBXcVNIb8OyLCuV/rL5DBB+Y
	WjuztSz+KG/p4k7b85G4xLAyE2GuEMz1BX1gWe56yWReEXqK2cR1t+mF/2LeRmG6
	JL3ozA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd6vcr36p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Mon, 31 Aug 2026 09:43:31 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-398ba5404d2so2212139a91.1
        for <linux-integrity@vger.kernel.org>; Mon, 31 Aug 2026 02:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788169411; x=1788774211; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tkKQYEdU2otSQ16uLjlwJhpUcwTRXJcL7OKIS4TBoYk=;
        b=GRlmGWUeqEKIvee0k9b+xTDZEuYrSXUTt1EYHC8e7+BqBN56zLWDYeTQvRG4tTHrB4
         oDHrlXIvXVVEMmw8Q2RWChxf8O7d5YmQJtWzvLzKkBfSpU6A3Eouq8XDgCN+0HVBdxnc
         mL8yT6gyAohNETU4shjb1lCAGMZNhsr37GWAn8LEApEGjP8GENYw5r6BAPHymzCqx74H
         obWDFxt61+2VheneRgOYvhCMaIiFDOoObqblNvnNSmYcif2dbDZgSPjhUoReYkjpkbY7
         nNDqTonxTrfQuKrKVydXGsR/RRzMbPXeWRlj1q5+UMCzX4JVXu/LWpqaqK5k5M1qoV4f
         euZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788169411; x=1788774211;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tkKQYEdU2otSQ16uLjlwJhpUcwTRXJcL7OKIS4TBoYk=;
        b=rrJIbprZelSreC9RuCfEhGvbeABzT8z5AjRwVw4+nXQLI5qCkCvilotGqYAmUVwFim
         D5E9k9wKW+Br7hGTtz3zh3VY61FLGhbv6XZ3jOb6yc151EAkQ/VueRorXswzKymdTNzG
         /mjuhbF0HYksKgpJ0RAQGGk52an1t8NXLeWv+WzsHSZEINdTi9w0bVNkuewGKyU8F1ka
         M1o7gShDgGDZDqO+m/hL5HqP/rQUHLCE1uQJPi4THlVjqg+67vMOgdCWskIge7W5pf+1
         +9mHHvEcqeqUlk5yecVwAtdX1jtjDfHv91cYeZijPzRHLpYCxTPqz3ptiAJ5S5yScugz
         /5IQ==
X-Forwarded-Encrypted: i=1; AKwUvBy0CO2nPM6iow7N22ELyiS0dcot/NrSOhB7609P322dTXk6wrzWK2jSKc7TEjStFgHuUN1+zjeGOHtapDbyNZQ=@vger.kernel.org
X-Gm-Message-State: AFuF++n+O5S8VuSV7ObBsuIj3kMD2YOePfmxNExnSAKe2px5w/4nrZU5
	QpHH9l5OYgUha/aa0ACBsBbFAr+R5LZ0OBfdySFNSVzrpLGbawp7BtkaF1IUyGcipZylRPF8zmI
	fUMvwdSrIqmW0ktKKa46Ab0IrYc2VXw2OwbjNhfZCDM8Fm7qBmCN2jG1NbBo7B8Y1rVenj3g=
X-Gm-Gg: AYBFou3bdyWw405NWtAEcmjRnKKAA38EMxcAnsVB12KPnTi55Oopg45GNlW1lcqKgLd
	4erxGKFvdnmfyxt0GUhLEd9u5JRJoiGgAw+QAuO0WtvM9MpLT5T0Z/+J6ZIzgAok5Vj9JIaeZDA
	mTJojR8CjEf0phChdxdXc/MMBhw+Cskw5DEsoZdV2h+i92ci0DjZ1pYFsf57JdZBcgtu3sgH9jS
	do74HIZNrs+ZCdgDFzSisjneSW2pNd28RRZZ8L+Sybx6O7WmiwKRNigdScawQfOkczOMlZs4RqN
	YKO1wo+pjat0lQbDbLPEsYvlxKHE4NSW3KLLBopfAQ7lMEjD6l3uxweFbhoyFwSCUkyi7SFyo/l
	YbSTlANtEE5hD9KcNWj8Zh/UlfW3QCtihYw==
X-Received: by 2002:a17:90b:3904:b0:37d:f206:a2ac with SMTP id 98e67ed59e1d1-398f82c2a56mr2965101a91.7.1788169410524;
        Mon, 31 Aug 2026 02:43:30 -0700 (PDT)
X-Received: by 2002:a17:90b:3904:b0:37d:f206:a2ac with SMTP id 98e67ed59e1d1-398f82c2a56mr2965049a91.7.1788169410034;
        Mon, 31 Aug 2026 02:43:30 -0700 (PDT)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0bf8a13sm40782983c88.0.2026.08.31.02.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 02:43:29 -0700 (PDT)
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 15:13:01 +0530
Subject: [PATCH 2/2] firmware: tpm: Introduce tpm-qcom driver
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-tpm_qcom_driver-v1-2-6f16fa6924fa@oss.qualcomm.com>
References: <20260831-tpm_qcom_driver-v1-0-6f16fa6924fa@oss.qualcomm.com>
In-Reply-To: <20260831-tpm_qcom_driver-v1-0-6f16fa6924fa@oss.qualcomm.com>
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA4MyBTYWx0ZWRfX5o3DRV7VBdyl
 /6TddH33vaPxIXpxc9b7T4uITBQ9vuuF/GDpQs7Do+qac/iQxzFIY6dtSt33lTYB/JRxUoB2LZ1
 Eml1xF2nUri1eYNiGD3JbVt6LbNjae8v0xbqUIwtJHo6PPKLfIlOS/7DbWzpi//hhOXPeBZjHVX
 jtG0s/f5b2Xmz9TZ91J5M6Bb5+JBq3J3HJO1Dv0nGBJ07Qu+DfLj+WOArf8wkFesyZ25Ouq3q4b
 oOsHds8IBc+oTei+Ar5/B1RpmIt5v+obPQA3vhx9UThO6sW3W2DXjmotRxqNBQDXxXiPPapdeGg
 UP6DZm8TFhm5KT4KDWC7rngjeKmWeoJUgmXJZ4uofHbdjb157qepEpyAqxIOAyUjGOfJlo+DbKl
 gsiElV+1ynHVw0v3eQcfyWcC9wLE+lqlt1Tu4hAGOJTmM/VAfGOYp9xiyFXq5AbvKKnAjllpn+4
 ymrVfuLu3nXCG7wG4dA==
X-Proofpoint-GUID: Xvkm9K7-axKil7rW5bmRiYSPdX2Vh83K
X-Proofpoint-ORIG-GUID: Xvkm9K7-axKil7rW5bmRiYSPdX2Vh83K
X-Authority-Analysis: v=2.4 cv=Eo7iaycA c=1 sm=1 tr=0 ts=6a954cc3 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=I8NnU1fDfo0zDGw4fWQA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA4MyBTYWx0ZWRfX/MpODubfJROk
 8y80B2s4cuFIaT6U1P+Bzk3NazLSlbztrW+PSqBtlSjCnR3C9w8c8ZAea8GxcZU4gMWUZcNpP3V
 F3j6OLusJsUqVxcp7YbBgmpHT3k5/A4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0
 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310083

Add a TPM chip driver for platforms where a TPM 2.0 instance is
implemented by a Trusted Application (TA) running in Qualcomm's Trusted
Execution Environment (QTEE), reachable over the QCOMTEE object-IPC
transport.

The driver discovers the qcom.tz.tpm TEE-bus device, opens a session
with the TPM TA, and register with tpm interface. This exposes the TA
through the standard /dev/tpm interface and the existing tpm2 command
layer. OS need not be aware underlying TPM instance is dTPM or fTPM.

Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
---
 MAINTAINERS                 |   7 +
 drivers/char/tpm/Kconfig    |   9 ++
 drivers/char/tpm/Makefile   |   1 +
 drivers/char/tpm/tpm_qcom.c | 371 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/char/tpm/tpm_qcom.h |  82 ++++++++++
 5 files changed, 470 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 47b04968e79a..cfa5b66823c7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22636,6 +22636,13 @@ S:	Maintained
 F:	Documentation/tee/qtee.rst
 F:	drivers/tee/qcomtee/
 
+QUALCOMM TPM DRIVER
+M:	Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
+L:	linux-arm-msm@vger.kernel.org
+S:	Maintained
+F:	drivers/char/tpm/tpm_qcom.c
+F:	drivers/char/tpm/tpm_qcom.h
+
 QUALCOMM TRUST ZONE MEMORY ALLOCATOR
 M:	Bartosz Golaszewski <brgl@kernel.org>
 L:	linux-arm-msm@vger.kernel.org
diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
index 5f672f2c01b0..05d704ed3632 100644
--- a/drivers/char/tpm/Kconfig
+++ b/drivers/char/tpm/Kconfig
@@ -243,6 +243,15 @@ config TCG_FTPM_TEE
 	help
 	  This driver proxies for firmware TPM running in TEE.
 
+config TCG_QCOM
+	tristate "Qualcomm TEE based TPM Interface"
+	depends on QCOMTEE
+	help
+	  This driver provides interface to run TPM instances with Trustzone
+	  having Qualcomm TPM TA running in Qualcomm TEE.
+	  The mechanism uses the object-IPC based transport provided by
+	  QCOMTEE.
+
 config TCG_SVSM
 	tristate "SNP SVSM vTPM interface"
 	depends on AMD_MEM_ENCRYPT
diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
index 5b5cdc0d32e4..471cbf49afd2 100644
--- a/drivers/char/tpm/Makefile
+++ b/drivers/char/tpm/Makefile
@@ -45,5 +45,6 @@ obj-$(CONFIG_TCG_CRB) += tpm_crb.o
 obj-$(CONFIG_TCG_ARM_CRB_FFA) += tpm_crb_ffa.o
 obj-$(CONFIG_TCG_VTPM_PROXY) += tpm_vtpm_proxy.o
 obj-$(CONFIG_TCG_FTPM_TEE) += tpm_ftpm_tee.o
+obj-$(CONFIG_TCG_QCOM) += tpm_qcom.o
 obj-$(CONFIG_TCG_SVSM) += tpm_svsm.o
 obj-$(CONFIG_TCG_LOONGSON) += tpm_loongson.o
diff --git a/drivers/char/tpm/tpm_qcom.c b/drivers/char/tpm/tpm_qcom.c
new file mode 100644
index 000000000000..00ee61204056
--- /dev/null
+++ b/drivers/char/tpm/tpm_qcom.c
@@ -0,0 +1,371 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ */
+
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/tee.h>
+#include <linux/tee_drv.h>
+#include <linux/tpm.h>
+#include <linux/uuid.h>
+
+#include "tpm.h"
+#include "tpm_qcom.h"
+
+/* UUID of the QTEE-bus device representing the TPM TA. */
+static const uuid_t tpm_qcom_uuid =
+	UUID_INIT(0xaabcb593, 0x7083, 0x5536,
+		  0xac, 0x27, 0x3d, 0x2d, 0x89, 0x41, 0x9d, 0xdb);
+
+static void tpm_qcom_release_object(struct tee_context *ctx,
+				    struct tee_param_objref object)
+{
+	struct tee_ioctl_object_invoke_arg inv_arg;
+
+	memset(&inv_arg, 0, sizeof(inv_arg));
+	inv_arg.id = object.id;
+	inv_arg.op = QCOMTEE_MSG_OBJECT_OP_RELEASE;
+	inv_arg.num_params = 0;
+
+	tee_client_object_invoke_func(ctx, &inv_arg, NULL);
+}
+
+static int tpm_qcom_get_client_env_obj(struct tee_context *ctx,
+				       struct tee_param_objref *client_env_obj)
+{
+	int ret;
+	struct tee_ioctl_object_invoke_arg inv_arg;
+	struct tee_param param[2];
+
+	memset(&inv_arg, 0, sizeof(inv_arg));
+	memset(&param, 0, sizeof(param));
+
+	inv_arg.id = TEE_OBJREF_NULL;
+	inv_arg.op = QCOMTEE_ROOT_OP_REG_WITH_CREDENTIALS;
+	inv_arg.num_params = 2;
+
+	param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_INPUT;
+	param[0].u.objref.id = TEE_OBJREF_NULL;
+	param[1].attr = TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_OUTPUT;
+
+	ret = tee_client_object_invoke_func(ctx, &inv_arg, param);
+	if (ret < 0 || inv_arg.ret != 0)
+		return ret ?: inv_arg.ret;
+
+	*client_env_obj = param[1].u.objref;
+	return ret;
+}
+
+static int tpm_qcom_get_svc_obj(struct tee_context *ctx,
+				struct tee_param_objref client_env_obj,
+				struct tee_param_objref *tpm_svc_obj)
+{
+	int ret;
+	struct tee_ioctl_object_invoke_arg inv_arg;
+	struct tee_param param[2];
+	u32 tpm_uid = QCOMTEE_TPM_UID;
+
+	memset(&inv_arg, 0, sizeof(inv_arg));
+	memset(&param, 0, sizeof(param));
+
+	inv_arg.id = client_env_obj.id;
+	inv_arg.op = QCOMTEE_OP_CLIENT_ENV_OPEN;
+	inv_arg.num_params = 2;
+
+	param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INPUT;
+	param[0].u.ubuf = (struct tee_param_ubuf){ .addr = &tpm_uid,
+						    .size = sizeof(tpm_uid) };
+	param[1].attr = TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_OUTPUT;
+
+	ret = tee_client_object_invoke_func(ctx, &inv_arg, param);
+	if (ret < 0 || inv_arg.ret != 0)
+		return ret ?: inv_arg.ret;
+
+	*tpm_svc_obj = param[1].u.objref;
+	return ret;
+}
+
+static int tpm_qcom_send_command(struct tpm_qcom_private *pvt_data,
+				 void *req, size_t req_len,
+				 void *rsp, size_t *rsp_len)
+{
+	int ret;
+	struct tee_ioctl_object_invoke_arg inv_arg;
+	struct tee_param param[2];
+
+	memset(&inv_arg, 0, sizeof(inv_arg));
+	memset(&param, 0, sizeof(param));
+
+	inv_arg.id = pvt_data->tpm_svc_obj.id;
+	inv_arg.op = QCOMTEE_TPM_OP_SEND_COMMAND;
+	inv_arg.num_params = 2;
+
+	param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INPUT;
+	param[0].u.ubuf = (struct tee_param_ubuf){ .addr = req, .size = req_len };
+	param[1].attr = TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_OUTPUT;
+	param[1].u.ubuf = (struct tee_param_ubuf){ .addr = rsp, .size = *rsp_len };
+
+	print_hex_dump_debug("tpm_qcom req: ", DUMP_PREFIX_OFFSET,
+			     16, 1, req, req_len, true);
+
+	ret = tee_client_object_invoke_func(pvt_data->ctx, &inv_arg, param);
+	if (ret < 0 || inv_arg.ret != 0) {
+		dev_err(pvt_data->dev,
+			"send_command invoke ret: %d, err: 0x%x\n",
+			ret, inv_arg.ret);
+		return ret ?: inv_arg.ret;
+	}
+
+	*rsp_len = param[1].u.ubuf.size;
+
+	print_hex_dump_debug("tpm_qcom rsp: ", DUMP_PREFIX_OFFSET,
+			     16, 1, rsp, *rsp_len, true);
+
+	return ret;
+}
+
+static int tpm_qcom_get_ta_details(struct tpm_qcom_private *pvt_data)
+{
+	struct tpm_qcom_ta_version_req ver_req = {
+		.command_id = QCOMTEE_TPM_GET_TA_VERSION_ID,
+	};
+	struct tpm_qcom_ta_version_rsp ver_rsp;
+	size_t ver_rsp_len = sizeof(ver_rsp);
+	struct tpm_qcom_type_req type_req = {
+		.command_id = QCOMTEE_TPM_TYPE_ID,
+	};
+	struct tpm_qcom_type_rsp type_rsp;
+	size_t type_rsp_len = sizeof(type_rsp);
+	int ret;
+
+	ret = tpm_qcom_send_command(pvt_data, &ver_req, sizeof(ver_req),
+				    &ver_rsp, &ver_rsp_len);
+	if (ret || ver_rsp_len < sizeof(ver_rsp) || ver_rsp.status != 0) {
+		dev_err(pvt_data->dev,
+			"failed to query TA version: ret=%d, status=%u\n",
+			ret, ret ? 0 : ver_rsp.status);
+		return ret ?: -EIO;
+	}
+
+	dev_info(pvt_data->dev, "TPM TA version %u.%u\n",
+		 QCOMTEE_TPM_TA_VERSION_GET_MAJOR(ver_rsp.version_num),
+		 QCOMTEE_TPM_TA_VERSION_GET_MINOR(ver_rsp.version_num));
+
+	ret = tpm_qcom_send_command(pvt_data, &type_req, sizeof(type_req),
+				    &type_rsp, &type_rsp_len);
+	if (ret || type_rsp_len < sizeof(type_rsp) || type_rsp.status != 0) {
+		dev_err(pvt_data->dev,
+			"failed to query TPM type: ret=%d, status=%u\n",
+			ret, ret ? 0 : type_rsp.status);
+		return ret ?: -EIO;
+	}
+
+	switch (type_rsp.tpm_type) {
+	case QCOMTEE_TPM_TYPE_FTPM:
+		dev_info(pvt_data->dev, "TPM type: fTPM\n");
+		pvt_data->is_dtpm = false;
+		break;
+	case QCOMTEE_TPM_TYPE_DTPM:
+		dev_info(pvt_data->dev, "TPM type: dTPM\n");
+		pvt_data->is_dtpm = true;
+		break;
+	default:
+		dev_err(pvt_data->dev, "unsupported TPM type: 0x%08x\n",
+			type_rsp.tpm_type);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/*
+ * fTPM does not implement this command, so this is only ever called in case of
+ * dtpm only.
+ */
+static void tpm_qcom_transfer(struct tpm_qcom_private *pvt_data,
+			      u32 transfer_state)
+{
+	struct tpm_qcom_transfer_req req = {
+		.command_id = QCOMTEE_TPM_TRANSFER_ID,
+		.transfer_state = transfer_state,
+	};
+	struct tpm_qcom_transfer_rsp rsp;
+	size_t rsp_len = sizeof(rsp);
+	int ret;
+
+	ret = tpm_qcom_send_command(pvt_data, &req, sizeof(req), &rsp, &rsp_len);
+	if (ret || rsp_len < sizeof(rsp) || rsp.status != 0)
+		dev_warn(pvt_data->dev,
+			 "transfer state=%u hint failed: ret=%d, status=%u\n",
+			 transfer_state, ret, ret ? 0 : rsp.status);
+}
+
+static int tpm_qcom_cmd_ready(struct tpm_chip *chip)
+{
+	struct tpm_qcom_private *pvt_data = dev_get_drvdata(chip->dev.parent);
+
+	if (pvt_data->is_dtpm)
+		tpm_qcom_transfer(pvt_data, QCOMTEE_TPM_TRANSFER_START);
+
+	return 0;
+}
+
+static int tpm_qcom_go_idle(struct tpm_chip *chip)
+{
+	struct tpm_qcom_private *pvt_data = dev_get_drvdata(chip->dev.parent);
+
+	if (pvt_data->is_dtpm)
+		tpm_qcom_transfer(pvt_data, QCOMTEE_TPM_TRANSFER_END);
+
+	return 0;
+}
+
+/*
+ * The raw TPM2 command in @buf is sent directly as send_command's UBUF-in
+ * param and the raw TPM2 response is read back from its UBUF-out param.
+ */
+static int tpm_qcom_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
+			 size_t cmd_len)
+{
+	struct tpm_qcom_private *pvt_data = dev_get_drvdata(chip->dev.parent);
+	size_t rsp_len = PAGE_ALIGN(MAX_RESPONSE_SIZE);
+	size_t copy_len;
+	int ret;
+
+	if (cmd_len > MAX_COMMAND_SIZE) {
+		dev_err(&chip->dev,
+			"%s: len=%zd exceeds MAX_COMMAND_SIZE\n",
+			__func__, cmd_len);
+		return -EIO;
+	}
+
+	u8 *response __free(kfree) = kzalloc(rsp_len, GFP_KERNEL);
+	if (!response)
+		return -ENOMEM;
+
+	ret = tpm_qcom_send_command(pvt_data, buf, cmd_len, response, &rsp_len);
+	if (ret < 0) {
+		dev_err(&chip->dev, "%s: failed: ret=%d\n", __func__, ret);
+		return ret;
+	}
+
+	copy_len = min_t(size_t, bufsiz, rsp_len);
+	memcpy(buf, response, copy_len);
+
+	return copy_len;
+}
+
+static const struct tpm_class_ops tpm_qcom_ops = {
+	.flags = TPM_OPS_AUTO_STARTUP,
+	.send = tpm_qcom_send,
+	.cmd_ready = tpm_qcom_cmd_ready,
+	.go_idle = tpm_qcom_go_idle,
+};
+
+static int tpm_qcom_ctx_match(struct tee_ioctl_version_data *ver,
+			      const void *data)
+{
+	return (ver->impl_id == TEE_IMPL_ID_QTEE);
+}
+
+static int tpm_qcom_probe(struct tee_client_device *tee_dev)
+{
+	struct device *dev = &tee_dev->dev;
+	struct tpm_qcom_private *pvt_data;
+	struct tee_param_objref client_env_obj;
+	struct tee_param_objref tpm_svc_obj;
+	struct tpm_chip *chip;
+	int rc, err;
+
+	pvt_data = devm_kzalloc(dev, sizeof(*pvt_data), GFP_KERNEL);
+	if (!pvt_data)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, pvt_data);
+
+	pvt_data->ctx = tee_client_open_context(NULL, tpm_qcom_ctx_match, NULL,
+						NULL);
+	if (IS_ERR(pvt_data->ctx))
+		return -ENODEV;
+
+	rc = tpm_qcom_get_client_env_obj(pvt_data->ctx, &client_env_obj);
+	if (rc) {
+		err = -EINVAL;
+		goto out_ctx;
+	}
+
+	rc = tpm_qcom_get_svc_obj(pvt_data->ctx, client_env_obj, &tpm_svc_obj);
+	if (rc) {
+		err = -EINVAL;
+		goto out_client_env;
+	}
+	pvt_data->tpm_svc_obj = tpm_svc_obj;
+	pvt_data->dev = dev;
+
+	err = tpm_qcom_get_ta_details(pvt_data);
+	if (err)
+		goto out_svc_obj;
+
+	chip = tpm_chip_alloc(dev, &tpm_qcom_ops);
+	if (IS_ERR(chip)) {
+		dev_err(dev, "%s: tpm_chip_alloc failed\n", __func__);
+		err = PTR_ERR(chip);
+		goto out_svc_obj;
+	}
+
+	pvt_data->chip = chip;
+	pvt_data->chip->flags |= TPM_CHIP_FLAG_TPM2 | TPM_CHIP_FLAG_SYNC;
+
+	err = tpm_chip_register(pvt_data->chip);
+	if (err) {
+		dev_err(dev, "%s: tpm_chip_register failed with rc=%d\n",
+			__func__, err);
+		goto out_chip;
+	}
+
+	tpm_qcom_release_object(pvt_data->ctx, client_env_obj);
+	return 0;
+
+out_chip:
+	put_device(&pvt_data->chip->dev);
+out_svc_obj:
+	tpm_qcom_release_object(pvt_data->ctx, tpm_svc_obj);
+out_client_env:
+	tpm_qcom_release_object(pvt_data->ctx, client_env_obj);
+out_ctx:
+	tee_client_close_context(pvt_data->ctx);
+	return err;
+}
+
+static void tpm_qcom_remove(struct tee_client_device *tee_dev)
+{
+	struct tpm_qcom_private *pvt_data = dev_get_drvdata(&tee_dev->dev);
+
+	tpm_chip_unregister(pvt_data->chip);
+	put_device(&pvt_data->chip->dev);
+	tpm_qcom_release_object(pvt_data->ctx, pvt_data->tpm_svc_obj);
+	tee_client_close_context(pvt_data->ctx);
+}
+
+static const struct tee_client_device_id tpm_qcom_id_table[] = {
+	{ tpm_qcom_uuid },
+	{}
+};
+MODULE_DEVICE_TABLE(tee, tpm_qcom_id_table);
+
+static struct tee_client_driver tpm_qcom_driver = {
+	.id_table	= tpm_qcom_id_table,
+	.probe		= tpm_qcom_probe,
+	.remove		= tpm_qcom_remove,
+	.driver		= {
+		.name	= "tpm-qcom",
+	},
+};
+
+module_tee_client_driver(tpm_qcom_driver);
+
+MODULE_DESCRIPTION("TPM driver for Qualcomm TPM TA");
+MODULE_AUTHOR("Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/char/tpm/tpm_qcom.h b/drivers/char/tpm/tpm_qcom.h
new file mode 100644
index 000000000000..0f3756944768
--- /dev/null
+++ b/drivers/char/tpm/tpm_qcom.h
@@ -0,0 +1,82 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __TPM_QCOM_H__
+#define __TPM_QCOM_H__
+
+#include <linux/bitfield.h>
+#include <linux/tee_drv.h>
+#include <linux/tpm.h>
+#include <linux/uuid.h>
+
+#define QCOMTEE_ROOT_OP_REG_WITH_CREDENTIALS	5
+#define QCOMTEE_OP_CLIENT_ENV_OPEN		0
+#define QCOMTEE_MSG_OBJECT_OP_MASK		GENMASK(15, 0)
+#define QCOMTEE_MSG_OBJECT_OP_RELEASE		(QCOMTEE_MSG_OBJECT_OP_MASK - 0)
+
+#define QCOMTEE_TPM_OP_SEND_COMMAND		0
+
+/* UID of the "qcom.tz.tpm" service */
+#define QCOMTEE_TPM_UID			489
+
+/* Max buffer size supported by TPM TA */
+#define MAX_COMMAND_SIZE	SZ_4K
+#define MAX_RESPONSE_SIZE	SZ_4K
+
+#define QCOMTEE_TPM_GET_TA_VERSION_ID		0x0001000
+#define QCOMTEE_TPM_TA_VERSION_GET_MAJOR(ver)	((u32)(ver) >> 16)
+#define QCOMTEE_TPM_TA_VERSION_GET_MINOR(ver)	((u32)(ver) & 0x0000ffffU)
+
+struct tpm_qcom_ta_version_req {
+	u32 command_id;
+} __packed;
+
+struct tpm_qcom_ta_version_rsp {
+	u32 status;
+	u32 command_id;
+	u32 version_num;
+} __packed;
+
+#define QCOMTEE_TPM_TYPE_ID		0x0080000
+#define QCOMTEE_TPM_TYPE_DTPM		0x6454504dU
+#define QCOMTEE_TPM_TYPE_FTPM		0x6654504dU
+#define QCOMTEE_TPM_TYPE_NONE		0x4e6f6e65U
+
+struct tpm_qcom_type_req {
+	u32 command_id;
+} __packed;
+
+struct tpm_qcom_type_rsp {
+	u32 command_id;
+	u32 status;
+	u32 tpm_type;
+} __packed;
+
+/* dTPM SPI transfer optimization:
+ * TRANSFER_START before a burst of commands, TRANSFER_END once done.
+ */
+#define QCOMTEE_TPM_TRANSFER_ID		0x0000002
+#define QCOMTEE_TPM_TRANSFER_END	0
+#define QCOMTEE_TPM_TRANSFER_START	1
+
+struct tpm_qcom_transfer_req {
+	u32 command_id;
+	u32 transfer_state;
+} __packed;
+
+struct tpm_qcom_transfer_rsp {
+	u32 command_id;
+	u32 status;
+} __packed;
+
+struct tpm_qcom_private {
+	struct tpm_chip *chip;
+	struct device *dev;
+	struct tee_context *ctx;
+	struct tee_param_objref tpm_svc_obj;
+	bool is_dtpm;
+};
+
+#endif /* __TPM_QCOM_H__ */

-- 
2.34.1


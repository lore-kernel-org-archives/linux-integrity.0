Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BAA3E49C7
	for <linux-integrity@vger.kernel.org>; Thu, 15 Oct 2026 06:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792046309; cv=none; b=cDdRrKzLuyNPBj9wRAbo/jKEgTlHNBwVIcZ80xNx2ifsXBzzjdEd1m8OApWBJphpoJ02QHuVlzqK/HGeNUd9GyO05jNeOD8JYwdn8uqT57KGeLDjQJE8SUr+/mdW/Dxq9lEUWI2hFqTpEdVr2GyGr6PPoySOSHHqPCbuuqK9U+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792046309; c=relaxed/simple;
	bh=iu9ow/Dww1U8wIR68CWGt9vajOZm7L/X0pT71+I+tC8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YTJeOj1YhVnY+qDdCJ5CB9GvKuyJtUyxLM5O5ihpCrdOsIueHXAMht4w9f7gCODXZaKJrzKXOrNPl2Y7q/7Z0kVbD/ZJg/XK0DL6sqRAfSnSQKpP7yYd+j31BtG22CvhatEjT2WQixPXL9Y/RfnHpzfdVaYa3Tb7ZYAdZL44lVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QDdaaPPB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ebPHpIrg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QDdaaPPB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ebPHpIrg"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F6UDTq644597
	for <linux-integrity@vger.kernel.org>; Thu, 15 Oct 2026 06:38:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2BCWqMF16SBPs4Rd3G9mQPXuRFvaonrqwB5WUmv8hBw=; b=QDdaaPPBRJbBIjhX
	3oV66Mc+68lTdgZW/5kVUXji9Mzz/FaqkOCBLwc8F8Fcy8CqJVWll6TtCa+TLoYk
	1qk0yTi6e6v2HK9OiRfE9fZPCX+WZi9yVUKRpZv0hJlsZ4jCLERkgkP98h8w5m18
	3/kRVKUsy/XvJe5+FZCHwC8XQMn334leVyvmM09tP/Yvz7Cyp2M6IiQLNMb48g4F
	7gInItcNXtUVePvC5gB4CtVZLV8BAlb0Fn2hD0cFmq9zmyiup/ZSTuaM0faMzC7O
	gdGT4OeDyVDKDWaQBo5BwE/zNrlurMRvE2QU+w/vnyyZG4vDI1kSbtzHbg1hce/X
	VmFZIg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hajmy9h2g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Thu, 15 Oct 2026 06:38:26 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3a8ae5154e7so6486364a91.1
        for <linux-integrity@vger.kernel.org>; Wed, 14 Oct 2026 23:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792046306; x=1792651106; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2BCWqMF16SBPs4Rd3G9mQPXuRFvaonrqwB5WUmv8hBw=;
        b=ebPHpIrg/lUZZPc2osjd4fPrXMU6bPkzxEVd6O9CDDgbLpMtClCNz5GEZY+reX4OEU
         0UY1omXTegJAmdTL1H64NLvdd/K8G2+iXxSSHFhlVueDf/C4cJ0/crcZxPy0I1DomiuM
         19YmwzWyB6Y4uxQITDj+vA74XTS+OEZcfv+9s1yfalwLVRp9kvdYnx+2VU9jmcP55mUc
         pWvshiFzk2b6bZ5nRpmImxX0BNAI1Fy/eZpo9lsp7SZ2UPWwK350m0CKymxztHhX8gZR
         KaqgHY12cqHLD7n/UIs93YuG6EEgczKCed0QzwMTxbGBdzBpkJHIZ+qoS+8ZFYB6uHus
         n0Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792046306; x=1792651106;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2BCWqMF16SBPs4Rd3G9mQPXuRFvaonrqwB5WUmv8hBw=;
        b=Rykye5NBZu8IU9kudMoFhphABpmdIVbSliuUYPo+rKUyXtjyDdMiG9tZm7cmFxcr4O
         yWruXgTBSSw4UTemDOPxs312SZauSQoBZkKoar2zVauwMR4Ut7+ddoRwYBMHaHcOXcvA
         hU84C8ilQCV6t++ePXjjQ6GiUt0+ieP5qxA/fkyCsqXJozTZXHip2pdIb62UMeJpjSrM
         Am1MOIWr69D+X7NLeTq53q8btTWVwQqxJonC8qeK1f9OqVjYQgGyV8hl8q5CmNC0mxdV
         c0tNjF5r1EFTlJUae+6/KG5byMG6vFakfeHFX3akgDb0WUHLoD/SqaPSnKbeXuwIkBXR
         z20g==
X-Forwarded-Encrypted: i=1; AKwUvBykVT2QRCR+XvOrr2emLINHbWBnuJzNlZ1ClH1mwSeG64hvDocCrE+DcQnfw9xaxgJ9ED2Q8VZFy0jfhri0W+Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYLzpsg8nmqvzAFXy/FnsqZfXXyJMHk1IOXoqkz1YJJZ9++Decaw
	h/FFPSIXLpO7W4vrR6QnsfnA71j3lIesSxYThK9yxse/QiKidFXNQ8sND6zv8Hrs6BjqNYYDJPt
	NfApCafWe5J1679aAdGJN2m/afWaT1iDrRswIcUlNiYxG3mPBm1cYed9FJ203jaf/H4XT4as=
X-Gm-Gg: AYBFou3yinNfgULaWYzfIFuDic+IdZFxnC+/ENGOPDAogOaHMHwHTtZQFyGKjXuOkN1
	G9+BOjBs+WeGR5bb8noiZPx16Nvd8+mA9snWXpWMuQI5F9PSVkrmotZhBchkBQtNrVB7IGR/FpI
	eBllUkVuEeykr38+Mlr8C02CI2skh+7xRuL6ctHokAZENh2Su4c6tba1FzKCxw7e0n8SbLwrXEs
	4C9XZfFN53PjN60dxo0tOf2P0rXB1y1z9wNCfi806RtUfqeIk/CDPyZ5zbQ8FZgPld53hdv6rYw
	P83Kcg2SsfKEiwuqe5V8c6h/85Y0/rgS0S9EgUmROwaBUhiQUsT34+FtbpS++60qzpbuVe/NUo8
	NKjMfM+RIf9eFCN4Hau8u29UaRYrMYPsl
X-Received: by 2002:a17:90b:384b:b0:3a4:ca46:840f with SMTP id 98e67ed59e1d1-3ab3a94ff18mr15242025a91.8.1792046305653;
        Wed, 14 Oct 2026 23:38:25 -0700 (PDT)
X-Received: by 2002:a17:90b:384b:b0:3a4:ca46:840f with SMTP id 98e67ed59e1d1-3ab3a94ff18mr15242005a91.8.1792046305006;
        Wed, 14 Oct 2026 23:38:25 -0700 (PDT)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac93ff4474sm2844429a91.0.2026.10.14.23.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 23:38:24 -0700 (PDT)
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 12:07:47 +0530
Subject: [PATCH v3 2/3] tpm: Introduce Qualcomm TPM driver
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-tpm_qcom_driver-v3-2-247c8e50250e@qti.qualcomm.com>
References: <20261015-tpm_qcom_driver-v3-0-247c8e50250e@qti.qualcomm.com>
In-Reply-To: <20261015-tpm_qcom_driver-v3-0-247c8e50250e@qti.qualcomm.com>
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
X-Mailer: b4 0.15.2
X-Proofpoint-GUID: 23PlJIedwpMvMd7aJf4GqpA1uryMIn8z
X-Proofpoint-ORIG-GUID: 23PlJIedwpMvMd7aJf4GqpA1uryMIn8z
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAyNiBTYWx0ZWRfX3pidkTdZhjCO
 G5In6pQ47vVxGMGPsF+lCx2E65q67H8W03TwHj3GivowE/dfkcbOpFYQ10EAn1W6sZaorMdsGMD
 mpqHLUz8lZQHjscNpnAhvx5gHKLaIIk=
X-Authority-Analysis: v=2.4 cv=TbQDJhQh c=1 sm=1 tr=0 ts=6ad074e2 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=fRNFA8eTS_BfqSrSx7UA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAyNiBTYWx0ZWRfX5TToLFMp3Hv/
 l0WE250D9roGdQ4IvGFrbrjSWwsHJoV1dFaKnZRx+FV8mHBsYJiET7CnolPxHRdncHTBp252s8u
 yytisK4hzxhmw9tjePrB7avoZ7B/DE+mDPFidzuAOqX/XW7XGz2u9AbQw6ZLt1TfNSpitWCWA/C
 1OKCM7qeZcB6A1tXqpT68ouXu+o5GZqAeSYF0kCMsUu5gjlavTh3l61FiUB9LNF27YLhWV1m8fX
 NvO1FpD0m4OFDZKTyWRdx9fu6edIjnAH9jQyNNtU+N1lEtsgPb1xiJbJBOj7xF5xdRZz49zDRfC
 IFKSuwKntbjUc1ccGw9gqqldmatj5al4AuaIxq1OiWRuiZCrG5t9W8K6W709AiqnWBN0VWxecD4
 LYKNjUERACTcNPJmHVKU8Kw233O6d4TnFYrU5izBPwfmywwT9Jc4b2qc8yvTxbS3eqYELAMLYGW
 nKQW8fgXw23+PtDQTEg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150026

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
 drivers/char/tpm/Kconfig    |   9 +
 drivers/char/tpm/Makefile   |   1 +
 drivers/char/tpm/tpm_qcom.c | 413 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 423 insertions(+)

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
index 000000000000..0fe0104e8b5a
--- /dev/null
+++ b/drivers/char/tpm/tpm_qcom.c
@@ -0,0 +1,413 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ */
+
+#include <linux/bitfield.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/tee.h>
+#include <linux/tee_drv.h>
+#include <linux/tpm.h>
+#include <linux/uuid.h>
+
+#include "tpm.h"
+
+#define QCOMTEE_ROOT_OP_REG_WITH_CREDENTIALS	5
+#define QCOMTEE_OP_CLIENT_ENV_OPEN		0
+#define QCOMTEE_MSG_OBJECT_OP_MASK		GENMASK(15, 0)
+#define QCOMTEE_MSG_OBJECT_OP_RELEASE		(QCOMTEE_MSG_OBJECT_OP_MASK - 0)
+
+#define QCOMTEE_TPM_OP_SEND_COMMAND	0
+
+/* UID of the "qcom.tz.tpm" service */
+#define QCOMTEE_TPM_UID			81
+
+/* Max buffer size supported by TPM TA */
+#define TPM_QCOM_MAX_COMMAND_SIZE	SZ_4K
+#define TPM_QCOM_MAX_RESPONSE_SIZE	SZ_4K
+
+#define QCOMTEE_TPM_GET_TA_VERSION_ID	0x0001000
+#define QCOMTEE_TPM_TA_VERSION_MAJOR	GENMASK(31, 16)
+#define QCOMTEE_TPM_TA_VERSION_MINOR	GENMASK(15, 0)
+
+struct tpm_qcom_ta_version_req {
+	u32 command_id;
+} __packed;
+
+struct tpm_qcom_ta_version_resp {
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
+struct tpm_qcom_type_resp {
+	u32 command_id;
+	u32 status;
+	u32 tpm_type;
+} __packed;
+
+/*
+ * dTPM SPI transfer optimization:
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
+struct tpm_qcom_transfer_resp {
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
+/* UUID of the QTEE-bus device representing the TPM TA. */
+static const uuid_t tpm_qcom_uuid =
+	UUID_INIT(0xaabcb593, 0x7083, 0x5536,
+		  0xac, 0x27, 0x3d, 0x2d, 0x89, 0x41, 0x9d, 0xdb);
+
+static void tpm_qcom_release_object(struct tee_context *ctx,
+				    struct tee_param_objref object)
+{
+	struct tee_ioctl_object_invoke_arg inv_arg = {};
+
+	inv_arg.id = object.id;
+	inv_arg.op = QCOMTEE_MSG_OBJECT_OP_RELEASE;
+	inv_arg.num_params = 0;
+
+	tee_client_object_invoke_func(ctx, &inv_arg, NULL);
+}
+
+static int tpm_qcom_get_client_env_obj(struct device *dev,
+				       struct tee_context *ctx,
+				       struct tee_param_objref *client_env_obj)
+{
+	struct tee_ioctl_object_invoke_arg inv_arg = {};
+	struct tee_param param[2] = {};
+	int ret;
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
+	if (ret < 0 || inv_arg.ret != 0) {
+		dev_err(dev, "get client env obj failed: ret=%d, invoke_ret=0x%x\n",
+			ret, inv_arg.ret);
+		return -EINVAL;
+	}
+
+	*client_env_obj = param[1].u.objref;
+	return 0;
+}
+
+static int tpm_qcom_get_svc_obj(struct device *dev,
+				struct tee_context *ctx,
+				struct tee_param_objref client_env_obj,
+				struct tee_param_objref *tpm_svc_obj)
+{
+	struct tee_ioctl_object_invoke_arg inv_arg = {};
+	struct tee_param param[2] = {};
+	u32 tpm_uid = QCOMTEE_TPM_UID;
+	int ret;
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
+	if (ret < 0 || inv_arg.ret != 0) {
+		dev_err(dev, "get TPM service obj failed: ret=%d, invoke_ret=0x%x\n",
+			ret, inv_arg.ret);
+		return -EINVAL;
+	}
+
+	*tpm_svc_obj = param[1].u.objref;
+	return 0;
+}
+
+static int tpm_qcom_send_command(struct tpm_qcom_private *pvt_data,
+				 void *req, size_t req_len, void *resp,
+				 size_t *resp_len)
+{
+	struct tee_ioctl_object_invoke_arg inv_arg = {};
+	struct tee_param param[3] = {};
+	u8 locality_arg = 0;
+	int ret;
+
+	inv_arg.id = pvt_data->tpm_svc_obj.id;
+	inv_arg.op = QCOMTEE_TPM_OP_SEND_COMMAND;
+	inv_arg.num_params = 3;
+
+	param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INPUT;
+	param[0].u.ubuf = (struct tee_param_ubuf){ .addr = &locality_arg,
+						   .size = sizeof(locality_arg) };
+	param[1].attr = TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INPUT;
+	param[1].u.ubuf = (struct tee_param_ubuf){ .addr = req, .size = req_len };
+	param[2].attr = TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_OUTPUT;
+	param[2].u.ubuf = (struct tee_param_ubuf){ .addr = resp, .size = *resp_len };
+
+	ret = tee_client_object_invoke_func(pvt_data->ctx, &inv_arg, param);
+	if (ret < 0 || inv_arg.ret != 0) {
+		dev_err(pvt_data->dev,
+			"send_command invoke ret: %d, err: 0x%x\n",
+			ret, inv_arg.ret);
+		return ret ?: -EINVAL;
+	}
+
+	*resp_len = param[2].u.ubuf.size;
+
+	return 0;
+}
+
+static int tpm_qcom_get_ta_details(struct tpm_qcom_private *pvt_data)
+{
+	struct tpm_qcom_ta_version_req ver_req = {
+		.command_id = QCOMTEE_TPM_GET_TA_VERSION_ID,
+	};
+	struct tpm_qcom_ta_version_resp ver_resp;
+	size_t resp_len = sizeof(ver_resp);
+	struct tpm_qcom_type_req type_req = {
+		.command_id = QCOMTEE_TPM_TYPE_ID,
+	};
+	struct tpm_qcom_type_resp type_resp;
+	int ret;
+
+	ret = tpm_qcom_send_command(pvt_data, &ver_req, sizeof(ver_req),
+				    &ver_resp, &resp_len);
+	if (ret < 0 || resp_len < sizeof(ver_resp) || ver_resp.status != 0)
+		return ret ?: -EIO;
+
+	dev_info(pvt_data->dev, "TPM TA version %u.%u\n",
+		 FIELD_GET(QCOMTEE_TPM_TA_VERSION_MAJOR, ver_resp.version_num),
+		 FIELD_GET(QCOMTEE_TPM_TA_VERSION_MINOR, ver_resp.version_num));
+
+	resp_len = sizeof(type_resp);
+	ret = tpm_qcom_send_command(pvt_data, &type_req, sizeof(type_req),
+				    &type_resp, &resp_len);
+	if (ret < 0 || resp_len < sizeof(type_resp) || type_resp.status != 0)
+		return ret ?: -EIO;
+
+	switch (type_resp.tpm_type) {
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
+			type_resp.tpm_type);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/* fTPM does not implement this command and to be invoked via dtpm only. */
+static void tpm_qcom_transfer(struct tpm_qcom_private *pvt_data,
+			      u32 transfer_state)
+{
+	struct tpm_qcom_transfer_req req = {
+		.command_id = QCOMTEE_TPM_TRANSFER_ID,
+		.transfer_state = transfer_state,
+	};
+	struct tpm_qcom_transfer_resp resp;
+	size_t resp_len = sizeof(resp);
+
+	tpm_qcom_send_command(pvt_data, &req, sizeof(req), &resp, &resp_len);
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
+	struct tpm_header *header = (struct tpm_header *)buf;
+	size_t resp_len = PAGE_ALIGN(TPM_QCOM_MAX_RESPONSE_SIZE);
+	size_t copy_len;
+	int ret;
+
+	if (cmd_len > TPM_QCOM_MAX_COMMAND_SIZE) {
+		dev_err(&chip->dev, "len=%zd exceeds TPM_QCOM_MAX_COMMAND_SIZE\n",
+			cmd_len);
+		return -EIO;
+	}
+
+	u8 *response __free(kfree) = kzalloc(resp_len, GFP_KERNEL);
+	if (!response)
+		return -ENOMEM;
+
+	ret = tpm_qcom_send_command(pvt_data, buf, cmd_len, response, &resp_len);
+	if (ret < 0) {
+		dev_err(&chip->dev, "TPM command failed: cmd_len=%zu, tpm_cc=0x%08x, ret:%d\n",
+			cmd_len, be32_to_cpu(header->ordinal), ret);
+		return ret;
+	}
+
+	copy_len = min_t(size_t, bufsiz, resp_len);
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
+	int err;
+
+	pvt_data = devm_kzalloc(dev, sizeof(*pvt_data), GFP_KERNEL);
+	if (!pvt_data)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, pvt_data);
+
+	pvt_data->ctx = tee_client_open_context(NULL, tpm_qcom_ctx_match, NULL, NULL);
+	if (IS_ERR(pvt_data->ctx))
+		return -ENODEV;
+
+	err = tpm_qcom_get_client_env_obj(dev, pvt_data->ctx, &client_env_obj);
+	if (err)
+		goto out_ctx;
+
+	err = tpm_qcom_get_svc_obj(dev, pvt_data->ctx, client_env_obj, &tpm_svc_obj);
+	/* Release client_env object irrespective of service obj return status */
+	tpm_qcom_release_object(pvt_data->ctx, client_env_obj);
+	if (err)
+		goto out_ctx;
+
+	pvt_data->tpm_svc_obj = tpm_svc_obj;
+	pvt_data->dev = dev;
+
+	err = tpm_qcom_get_ta_details(pvt_data);
+	if (err)
+		goto out_svc_obj;
+
+	chip = tpmm_chip_alloc(dev, &tpm_qcom_ops);
+	if (IS_ERR(chip)) {
+		dev_err(dev, "tpmm_chip_alloc failed\n");
+		err = PTR_ERR(chip);
+		goto out_svc_obj;
+	}
+
+	pvt_data->chip = chip;
+	dev_set_drvdata(dev, pvt_data);
+	pvt_data->chip->flags |= TPM_CHIP_FLAG_TPM2 | TPM_CHIP_FLAG_SYNC;
+
+	err = tpm_chip_register(pvt_data->chip);
+	if (err) {
+		dev_err(dev, "tpm_chip_register failed with rc=%d\n", err);
+		goto out_svc_obj;
+	}
+
+	return 0;
+
+out_svc_obj:
+	tpm_qcom_release_object(pvt_data->ctx, tpm_svc_obj);
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
+		.name	= "tpm_qcom",
+	},
+};
+
+module_tee_client_driver(tpm_qcom_driver);
+
+MODULE_DESCRIPTION("TPM driver for Qualcomm TPM TA");
+MODULE_AUTHOR("Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>");
+MODULE_LICENSE("GPL");

-- 
2.34.1


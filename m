Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16104AA1DD
	for <linux-integrity@vger.kernel.org>; Mon, 19 Oct 2026 09:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792401748; cv=none; b=D+U1oN1EN72Ws6uI7NrPB+cp2vZA1mwedSWK3vz7bF2y2N0DKrKb/CdEYdvwUPfTzC3IkrwH6GnmdMriQsxc29JJE7YofTDVFxndn2pbb+PBiBcXBgEz0jII2mePrF0OqgXDBFW7d+sqq248/HseX8WbbmEoATf/5A6X4NNYZ6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792401748; c=relaxed/simple;
	bh=gV5KN5Zm7fQjcSWfwU2nH5feZRNKiCvZoszC5a2aVMQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ckmmzpzk+xhTNve9swBwMgLeKqluplQ+JqrUslRGnA3aDSIUenAirDzhr7ZXWuYexo3zifZB/U+fbq7JUbqlwdPTxPhTtqoSjNL035QNg8JdJUeRZ3ZFJQPKBkPjNrpl5TiW0JO4UISmDR5OUp3vzuGKbnz6WpCDFE3zfeUCcQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=inKBm7dA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P3FDmAil; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="inKBm7dA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P3FDmAil"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J8P7bB1896627
	for <linux-integrity@vger.kernel.org>; Mon, 19 Oct 2026 09:22:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	W14KmFOdJoa7pCoAY9piALiA9RYY45QOzgo4ZT23jpM=; b=inKBm7dAhxo3XMDD
	XDpI6sm+uQc2WAH/PKy6dX9uS/Z3xrAEhLLjkTGOnDtOAINjf0oNl6I77oEgGp27
	gmc9GiXtmEVYWubJhBcnFjNFzvK0yfX0J1XW/K9kN50Fp/ktO4lUGMxR9grOtfOc
	v5Gr/Ys6mCRAv4rQuu5F5el9AUT2CY+MTxCFQRPVHGTk8yWqodTZYsl8Cr+K0Tnx
	cWVzO/ZfBbRKQiP466BU5mBe7ka3dFkA89b6Soz9+zZ8DfrV1qQdN2yutaTGWNdV
	DB+v+dDKVslwCO7jt2QEClek9KIPUITIDQF06uOGKj2idFdCFTk/wFKY8ECWJir+
	/qN+UA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdbvr95pc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Mon, 19 Oct 2026 09:22:25 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-35cbea41088so3347273eec.1
        for <linux-integrity@vger.kernel.org>; Mon, 19 Oct 2026 02:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792401745; x=1793006545; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W14KmFOdJoa7pCoAY9piALiA9RYY45QOzgo4ZT23jpM=;
        b=P3FDmAilq1bPGh7ZtoDmebrYM0TDGS+sXTinPwCv5WLXvMvWEnPFjBp6HAWBqf8Gg8
         ZyoabnkSVr4cYLt0nuLZnOHco03tujFiqu65MEl3S08tgeINtkd1szhcJmWYME2U5vXN
         3+IjeO/QBUCyqzxqP6Y5StK7RHRl/1Qj3LOGNUNXfBRFvzS8XrTWRf2Tfoeh9jPPcijc
         KUJKwE6GA34GxEQ/oQbP6vWz/wW3gdtOYRbCGaH+lxHNpB/IKco4mN/U2SD481XjwsdE
         zBGIajh5xmo5mfcchHnoUsLicg7RgQWUwx/RFa6L3hK1Jzlt6sSiSw1Du+0R2902vGEv
         rAlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792401745; x=1793006545;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W14KmFOdJoa7pCoAY9piALiA9RYY45QOzgo4ZT23jpM=;
        b=QjE7xPnFy2Anx912NXonI7+u3bWy/GtQdTiXv/WcvSwvh9SnFZqK/AEVcXvtSe0pfW
         zdf2AaZx3BiMEc/LLhe2B5rvBLrPaUDNE0Zy/kchps1sWTNIYMmJr0ojNeHVOBdFvFT4
         iOjhC3WB+4H5KXawIGjZTvGkyBj0qllBsn3rHbIWmqDAiGkBAlPOrcyVhr3HG4rPSfIu
         cO+MBB57DDviEXj/nIYPvVDWsJTPlsjesvEbuZBbRUiaGvpa4ZDufL1yrk/W5Z7nK3Fr
         86yowdA3ftWrlNkO+rFU0e33zqGS0NSZhLbeXZ5oFhE8gcENzTIxdVm/OsFChv1xGL9H
         2gQQ==
X-Forwarded-Encrypted: i=1; AKwUvBzdqVEjBbsRrPilVlyT0mUCLGR4jChYvvwsdvspTOwnRZvK/47kzvu0dmzkTsLAA/Tvybu32WAgi9qCb11lXTY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIh+1vPU07+tbcCkOUDIvLgpFcPPpG0mU9Jh/UxCCTgV5w1t4WD
	P56S78JnToSU2xIc00bDWnFyuwmu4t2qlT8EDad72YtjmXgAKdCS85F/xJoL/fn/Gx6RCvt6nNH
	oyPfvQj4JJYRqZr/DiGbscg++8/imGrU/b54awpC3fk7KCRgIGHxS5EibRS8wuG6vCxbrhBY=
X-Gm-Gg: AYBFou30fYLhwDSYW2NLe/GygaGvgv9r+H3+UgMiagROy6Km8v4xJE/+NDGsgERmAhs
	kt5ut0VcY1Af0xlJv6tyKZ1HgRbDdX3ItVYo3BPEk6r0SlMo7X+zhDIMJNjygeUJeIW1MwUXMj8
	LMjMn140j39l0IKHBp6uo6CCpqf1GLV9bZuDeMdoMqWoLZsjJKc+BuwLZ/7HEHHoDMi5I/Ujf0D
	LdtGcUX2gTwExotEwPcNM5MKQOydx1r9mEkws5QzMusprB5sQ2yudSOD+a3Azp68hFIzoG9jkkL
	zmC0pJOqVTU6c19XA/2HtlljvtgsWOKNjN2sNtQg/GqwWxno3RlEhGZ8CkLFchH59TkirT58mCc
	FP5+3EqY0Nn2xGv2BlZsncrTL5k9HOSoQ
X-Received: by 2002:a05:7301:4615:b0:35c:8ce0:63dc with SMTP id 5a478bee46e88-361a1f522b5mr9290330eec.20.1792401744598;
        Mon, 19 Oct 2026 02:22:24 -0700 (PDT)
X-Received: by 2002:a05:7301:4615:b0:35c:8ce0:63dc with SMTP id 5a478bee46e88-361a1f522b5mr9290296eec.20.1792401743740;
        Mon, 19 Oct 2026 02:22:23 -0700 (PDT)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36082a7b33bsm56225094eec.24.2026.10.19.02.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 02:22:23 -0700 (PDT)
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 14:51:47 +0530
Subject: [PATCH v4 2/3] tpm: Introduce Qualcomm TPM driver
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-tpm_qcom_driver-v4-2-6889b9804ba7@oss.qualcomm.com>
References: <20261019-tpm_qcom_driver-v4-0-6889b9804ba7@oss.qualcomm.com>
In-Reply-To: <20261019-tpm_qcom_driver-v4-0-6889b9804ba7@oss.qualcomm.com>
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAzNyBTYWx0ZWRfXx32q4t6nIznn
 6/ovmK+pFg9cRquPOTS9SQkkgnsQ6U+W/FrT7kjseQIlIr9PWv6hPI88ATFdpXs44X2HHTldPkn
 2IcVtjUw8HY3RxuTU46jyJdXHzDtTZ9pnYj1nEz6PwGwuT61+RiMIRwcT8Rl4yqub7vWNsjZMat
 9/+i8DnxY5hd2u7aVwDVmt1gSH3YM5PgAGbt6jlmC/RACAlSd6iu4jgxCBCVNHCKhJmVGV2AEyk
 hoWiF7HatOs9iUKrXuqtKlcyE02UNzsPI3bL7w2W78xX8QdALI+UY/palq791WLEAUll/ygLg+p
 hi/pYohxSXsE4gm+EfnuNPtNJPccIEzUh1jJH+G2x0ZejbcLEcaIjlwRv/iSYjacawbJ2RUfKgr
 SswzEFFexac9fYkpgRhuzm1ZCBvODHuzapV4BVvwtSfmH69JG6IehhWyrmy7oLKg4JfAlKQKNfU
 L8xZaC4lCTSA/KzWyTA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAzNyBTYWx0ZWRfX+u3/9PeJjQ/H
 v3eW2d576z2v7b6maEMZH8Zinyv1e56gdlv/7A+9T2waJ2f4tQvSwsmG1BnKeU5jhulKMRUckhJ
 bI/fcoLcsBS9omwHAqPPiq8KP102rIg=
X-Proofpoint-GUID: C630NThh4NZUPnjUIhtxw3sW8dN1arUn
X-Authority-Analysis: v=2.4 cv=K/+3jCWI c=1 sm=1 tr=0 ts=6ad5e151 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=fRNFA8eTS_BfqSrSx7UA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: C630NThh4NZUPnjUIhtxw3sW8dN1arUn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190037

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
 drivers/char/tpm/tpm_qcom.c | 414 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 424 insertions(+)

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
index 000000000000..e9e4746f0004
--- /dev/null
+++ b/drivers/char/tpm/tpm_qcom.c
@@ -0,0 +1,414 @@
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
+
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


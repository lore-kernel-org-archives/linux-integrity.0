Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794598610;
	b=eBvv7htveWWMBDBmhhaaz8NXiCWR60omxAYUlbogcTLub1vfeBS9T19qJPKICjHPpUIY
	 2Rdjz2Ra3KR41gTWtU4yowfuwbL42GIYxIc8jtqKrHfruOGbB5EqqwFaX3Uj0EDrij++r
	 TFrKZ7tSwcv6J8MEAZ6T87Esq0eTkaHtVNLOQww0iFFWujKbVWO2BBgTMbAJNEaQF8Ee/
	 KS0OAEkhL6y95OUVkWqOjt6IiwjDzkznLX2izaf3OBCVEE8z4zxfs+nPGGNhJr227ZKxp
	 6VJssdaQbKKxBB34o+0eHxcyo2omloPmJwFIrTAR7thy8andDuC/NhWjuiMVFsHZfJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794598610;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=7a/BOOYVA8+aYd3dIJ6rz4xghG/CN3gEEzRrakAvdFQ=;
	b=zWGKOsKYoBhcPBvY85umeLyVQD9f6IuzoDjfUCyvckUVgo9TxGGdaNAHMXQkNZ2ACo4G
	 6d2qD3leKHlInrsnFHa0OqwCz5j9PSBfWrOVuSzzba4cdgmZRqAmX/GxTEko1YVQ5yPAT
	 ZvwZzA8xEICY9rKDsX7a4JJ594RvpfXuHm8vtKnNQWRzq1bRKFf9YmG32lBn9snN9efm1
	 sTzJ6bbIqN8BBkEc//riQ86twa0w+0hxgynspHQjZWsA1QlE1P0W472gsqgBlzkDuX0W6
	 G27DsBPmhDHFHelG+CnejYHx3JtNebrmxCq+QIyiicLM4WpN5BOgvMSP9oOlzTyzFLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PKvZ1kPo;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iB5wLPDd;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928C3606A885
	for <linux-integrity@vger.kernel.org>; Fri, 13 Nov 2026 19:36:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 928C3606A885
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PKvZ1kPo;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iB5wLPDd
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADJ0KWZ4168727
	for <linux-integrity@vger.kernel.org>; Fri, 13 Nov 2026 19:36:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=7a/BOOYVA8+
	aYd3dIJ6rz4xghG/CN3gEEzRrakAvdFQ=; b=PKvZ1kPo9aumDk2mUchEphi2Xal
	3B1cjsXsP4FA1x7svA9nyvJZTKg1RNOKL7/TReeIxHKDzsjzsJUAk/t9pCJc2LjG
	5wCTgev4444Ab8FYbjHUSl8IXklvKqTvx8VjtF3ktxsu9RbXnK3S3hj00N8Z54U3
	7r2FruX0VYSJkg3AdYkNvU//d6cXhjmXlP1Cslv53+UFQRaFYuHSUMWPw9u9IX4K
	RCZNhKnnO61PmWpn9xOCll76bzUzhIPnAPvfT1/Ok5YcduuiZpsRqie0/HDUqJME
	UsUtU4/YE4TRNUxaz/DgYAIeMVK4amc9+HsKk6diz+IdngUEAJs5IdpYwJQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hx6ma8kah-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Fri, 13 Nov 2026 19:36:48 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f6f4fe531so250772185a.0
        for <linux-integrity@vger.kernel.org>; Fri, 13 Nov 2026 11:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794598608; x=1795203408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7a/BOOYVA8+aYd3dIJ6rz4xghG/CN3gEEzRrakAvdFQ=;
        b=iB5wLPDdDYSyNMBR1fJ8yxpdLBFF6mA4rMhM4I3frrvYLrkub2MGWJFDGUxSWQARHF
         KKayn3TDMxMHrHhXWnC6geSnPi4xeo2e0I6HuV/b/0gY4wrr6WKofOQNhwnCfLyNmx+v
         Z6dsjcQ6hv/8Qm3NHN960AOg8wmVzwsRXJIPsZ5dQsiQmLAuyjIKIBjm88yQKST/mG4j
         uUGvFlxkLf2n7z2xIrn3zOxlzliVd4rMMQs7C+usOeOaEHMpjyRzkL78/B7sjRZkXdLJ
         IU6ZmpW33b/rO0PPzj/7lhdJDwkRaAaENnJEjbKSzFlqBd866aB8GvDhaWKm0Xa9npzg
         D+sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794598608; x=1795203408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7a/BOOYVA8+aYd3dIJ6rz4xghG/CN3gEEzRrakAvdFQ=;
        b=S8ThNlk+1lR9R2Lz8ZvAxpvG98Z0scjKtVqDJhjI51GRDD1YqNOsvz0IOaOFsIJ1Wi
         Nug4RmstT3vzxIX0/d3cmJ+Wxl/e+2tDvYneK2o3Jno0KjNsMCbl/LFL6k1vNgyxm354
         7dqD3M3Nk38gWW0M6vzl/9HRgcODxG/hNBVenfvI/KsoJFHubhmdORPfaUxjBFw+3oGL
         O3ffBOrSPhODdZOc40/A3UqvfSEO7XNLMR19UXejKm6XJq72A3Q4/BDKjgyH8wK96hX1
         LKJQSPb5CYS0QV+gAtyP14JcYhICFPQMTlb4JKlkt2epk9FydXGhTeR5kobIA3tyZuDN
         p8dQ==
X-Forwarded-Encrypted: i=1; AL+hErHEXdKgB6mOtTnxoyBPGxjxx+Zo8bydXOZ2F43w9zmmx6eUxXEuhS+MfiQf06bW5YQvHNNSWcHfxN2h0UftWpE=@vger.kernel.org
X-Gm-Message-State: APuU4Z92VRBBLayseRrm1EBz5ZWoZv0KRhZpBj6V8KlgDSWQ0TcisjZi
	J7GLAGhIAddDy1qT718Fm7PN9QqXlKdoa809PVW96J/NujDVD0BIpsetfKKnxZ8nOp/m32U+iAw
	9NywVkqxSAAujTUaNfobjsM0c8nnnN9dH90CnAzZmE3zgiV4QZw4hXDcCRWkCPmxdROtRTCkjtv
	fRbIo=
X-Gm-Gg: AYBFou0DYPg03rWNcLXJ18Yjs36aiHjwl9AdC9Vpjm8V1iSl9HUAULtcFa0wRswWGjK
	rb2czbgIVJITBIjP91kdEJChe3HbAK3P4VrAsyDoA9OgrArhM5BlP9aCIaAYrpi3njpJyTXU6WV
	ZfnNX9tuqeiROQeVb6TGnQ9W0wRYfxjHtxfZcjLGnMaxpREwFrosbJjfdUE/kcBoMFUfK3J/BmJ
	MZ2cWauQ07qUo24y7adLUo5d5Zr5pstJhWvXUY60zypPutS7GjDlzX1FS9FXV0OlFnxQs4dvMUw
	lg37k9QfqvYux3Ut/0kido1Pl89Ik/7fGN/Bqe4q8olNSWi3UdJW8MrQ6rakLUgfZrpUhAlahan
	JDV5/5faOxXe2fRb/1q6sNjRidRWJ1tkFsvh0My1fMzs4Klvup9TghNXG01N1eFS4pb/xFt7cyM
	sITdjCk7e/oWG8cucz2Q==
X-Received: by 2002:a05:620a:4503:b0:93f:2e08:6420 with SMTP id af79cd13be357-9494bb52812mr607094785a.38.1794598607440;
        Fri, 13 Nov 2026 11:36:47 -0800 (PST)
X-Received: by 2002:a05:620a:4503:b0:93f:2e08:6420 with SMTP id af79cd13be357-9494bb52812mr607091585a.38.1794598606927;
        Fri, 13 Nov 2026 11:36:46 -0800 (PST)
Received: from trex (50.red-81-37-172.dynamicip.rima-tde.net. [81.37.172.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c60da11c5sm6268876f8f.54.2026.11.13.11.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 11:36:45 -0800 (PST)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, jarkko@kernel.org, peterhuewe@gmx.de,
        jgg@ziepe.ca, sumit.garg@oss.qualcomm.com
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: [PATCH v4 2/2] tpm_ftpm_tee: use the tpm_optee transport core
Date: Fri, 13 Nov 2026 20:36:34 +0100
Message-ID: <20261113193639.4020859-3-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261113193639.4020859-1-jorge.ramirez@oss.qualcomm.com>
References: <20261113193639.4020859-1-jorge.ramirez@oss.qualcomm.com>
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
X-Proofpoint-GUID: -hRV5jottdku5vM0aHOdcuaFsO0PPzcM
X-Authority-Analysis: v=2.4 cv=RbcFmFtv c=1 sm=1 tr=0 ts=6af766d0 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=VbO86HPdXvN82gCvB8O6pw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=NEAV23lmAAAA:8
 a=p5XVOwWNAAAA:20 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=DtFL08XvnnzGsi3Z16wA:9
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA3OCBTYWx0ZWRfX0MDFuJdj7ibQ
 8oefT6WJGxo4zRpR6+8XZaB5jnHeScwr7ZAg3DrRWN9LrP6ACFiQUWZEeUr7hJ1FjcH+DLtWUpe
 FQFqzix5MVPwjfAFAdCDpPODnk+OlUAbYCcUEYLa8W76o/+hANesS5zD7qMzrZvYK985rkMXHLU
 SBGN2kXTDNiw5NY9PVk3QjCGJOP79r4iHzTy6Q7sVFpfRzx6RfOt4RdziS+e01R7QopKt2B9A24
 MK+QKi1/IzBiCb62rTd2ApMhKE6EZPBXN8HPperWGlfX7IKEcKMIrpE5gnZP3snGn78Sf1GAsP0
 pOUlZeEGlIK4pUevR/DkcHHYcQWEohmzWROv44Tz1nK4AyfQ+f34BBgjceFZdR9i7WhCKhN0s0a
 dipo0xOmPUibp/Azr+mAQtSzxsHHRt3gQ3em8ZGwZ7ENoyEo7UMBvlmr7UO93ss4OLxUYOu8k3y
 HCdN0GPhd1KjMSIWqaA==
X-Proofpoint-ORIG-GUID: -hRV5jottdku5vM0aHOdcuaFsO0PPzcM
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA3OCBTYWx0ZWRfX4fKzM4TDD/2z
 /CMIJCgWMMwf7ZDpKD09P6b0Rd9+oSyKhmx/HkYyxBt+PDEhUX2U4XQNyakh0wq5qKtFDiLNHiS
 QC97emv6F1qyR+oiVPI0vLSxvUBXZJY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_06,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130078

The firmware-TPM driver and the new discrete-TPM driver share the same
OP-TEE transport, now factored into a common core. Move the firmware-TPM
driver onto it so the transport is not duplicated. The driver keeps its
name, its platform/OF binding and its shutdown behaviour; only the
transport is shared.

Two functional changes come from sharing the core: a command longer than
the caller's buffer is now rejected (it was previously only checked
against the application's maximum), and a failed command submission
returns -EIO instead of the raw error code from the secure world.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/Kconfig        |   1 +
 drivers/char/tpm/tpm_ftpm_tee.c | 294 ++------------------------------
 drivers/char/tpm/tpm_ftpm_tee.h |  35 ----
 3 files changed, 19 insertions(+), 311 deletions(-)
 delete mode 100644 drivers/char/tpm/tpm_ftpm_tee.h

diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
index 779154e05204..35aff3003a32 100644
--- a/drivers/char/tpm/Kconfig
+++ b/drivers/char/tpm/Kconfig
@@ -240,6 +240,7 @@ config TCG_VTPM_PROXY
 config TCG_FTPM_TEE
 	tristate "TEE based fTPM Interface"
 	depends on TEE && OPTEE
+	select TCG_OPTEE
 	help
 	  This driver proxies for firmware TPM running in TEE.
 
diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_tee.c
index 340b4884835c..1665e9b584a7 100644
--- a/drivers/char/tpm/tpm_ftpm_tee.c
+++ b/drivers/char/tpm/tpm_ftpm_tee.c
@@ -7,17 +7,22 @@
  *
  * A reference implementation is available here:
  * https://github.com/microsoft/ms-tpm-20-ref/tree/master/Samples/ARM32-FirmwareTPM/optee_ta/fTPM
+ *
+ * The TEE transport is shared with other OP-TEE TPM front-ends and lives in
+ * tpm_optee; this file only carries the fTPM identity and its platform/OF
+ * binding.
  */
 
 #include <linux/acpi.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/tee_drv.h>
-#include <linux/tpm.h>
 #include <linux/uuid.h>
 
-#include "tpm.h"
-#include "tpm_ftpm_tee.h"
+#include "tpm_optee.h"
+
+/* The TAF ID implemented in the fTPM TA */
+#define FTPM_OPTEE_TA_SUBMIT_COMMAND	0
 
 /*
  * TA_FTPM_UUID: BC50D971-D4C9-42C4-82CB-343FB7F37896
@@ -26,298 +31,36 @@
  * Defined here in the reference implementation:
  * https://github.com/microsoft/ms-tpm-20-ref/blob/master/Samples/ARM32-FirmwareTPM/optee_ta/fTPM/include/fTPM.h#L42
  */
-static const uuid_t ftpm_ta_uuid =
-	UUID_INIT(0xBC50D971, 0xD4C9, 0x42C4,
-		  0x82, 0xCB, 0x34, 0x3F, 0xB7, 0xF3, 0x78, 0x96);
-
-/**
- * ftpm_tee_tpm_op_send() - send TPM commands through the TEE shared memory
- * and retrieve the response.
- * @chip:	the tpm_chip description as specified in driver/char/tpm/tpm.h
- * @buf:	the buffer to send and to store the response.
- * @bufsiz:	the size of the buffer.
- * @cmd_len:	the number of bytes to send.
- *
- * Return:
- *	In case of success, returns the number of bytes received.
- *	On failure, -errno
- */
-static int ftpm_tee_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
-				size_t cmd_len)
-{
-	struct ftpm_tee_private *pvt_data = dev_get_drvdata(chip->dev.parent);
-	size_t resp_len;
-	int rc;
-	u8 *temp_buf;
-	struct tpm_header *resp_header;
-	struct tee_ioctl_invoke_arg transceive_args;
-	struct tee_param command_params[4];
-	struct tee_shm *shm = pvt_data->shm;
-
-	if (cmd_len > MAX_COMMAND_SIZE) {
-		dev_err(&chip->dev,
-			"%s: len=%zd exceeds MAX_COMMAND_SIZE supported by fTPM TA\n",
-			__func__, cmd_len);
-		return -EIO;
-	}
-
-	memset(&transceive_args, 0, sizeof(transceive_args));
-	memset(command_params, 0, sizeof(command_params));
-
-	/* Invoke FTPM_OPTEE_TA_SUBMIT_COMMAND function of fTPM TA */
-	transceive_args = (struct tee_ioctl_invoke_arg) {
-		.func = FTPM_OPTEE_TA_SUBMIT_COMMAND,
-		.session = pvt_data->session,
-		.num_params = 4,
-	};
-
-	/* Fill FTPM_OPTEE_TA_SUBMIT_COMMAND parameters */
-	command_params[0] = (struct tee_param) {
-		.attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT,
-		.u.memref = {
-			.shm = shm,
-			.size = cmd_len,
-			.shm_offs = 0,
-		},
-	};
-
-	temp_buf = tee_shm_get_va(shm, 0);
-	if (IS_ERR(temp_buf)) {
-		dev_err(&chip->dev, "%s: tee_shm_get_va failed for transmit\n",
-			__func__);
-		return PTR_ERR(temp_buf);
-	}
-	memset(temp_buf, 0, (MAX_COMMAND_SIZE + MAX_RESPONSE_SIZE));
-	memcpy(temp_buf, buf, cmd_len);
-
-	command_params[1] = (struct tee_param) {
-		.attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT,
-		.u.memref = {
-			.shm = shm,
-			.size = MAX_RESPONSE_SIZE,
-			.shm_offs = MAX_COMMAND_SIZE,
-		},
-	};
-
-	rc = tee_client_invoke_func(pvt_data->ctx, &transceive_args,
-				    command_params);
-	if ((rc < 0) || (transceive_args.ret != 0)) {
-		dev_err(&chip->dev, "%s: SUBMIT_COMMAND invoke error: 0x%x\n",
-			__func__, transceive_args.ret);
-		return (rc < 0) ? rc : transceive_args.ret;
-	}
-
-	temp_buf = tee_shm_get_va(shm, command_params[1].u.memref.shm_offs);
-	if (IS_ERR(temp_buf)) {
-		dev_err(&chip->dev, "%s: tee_shm_get_va failed for receive\n",
-			__func__);
-		return PTR_ERR(temp_buf);
-	}
-
-	resp_header = (struct tpm_header *)temp_buf;
-	resp_len = be32_to_cpu(resp_header->length);
-
-	/* sanity check resp_len */
-	if (resp_len < TPM_HEADER_SIZE) {
-		dev_err(&chip->dev, "%s: tpm response header too small\n",
-			__func__);
-		return -EIO;
-	}
-	if (resp_len > MAX_RESPONSE_SIZE) {
-		dev_err(&chip->dev,
-			"%s: resp_len=%zd exceeds MAX_RESPONSE_SIZE\n",
-			__func__, resp_len);
-		return -EIO;
-	}
-	if (resp_len > bufsiz) {
-		dev_err(&chip->dev,
-			"%s: resp_len=%zd exceeds bufsiz=%zd\n",
-			__func__, resp_len, bufsiz);
-		return -EIO;
-	}
-
-	memcpy(buf, temp_buf, resp_len);
-
-	return resp_len;
-}
-
-static const struct tpm_class_ops ftpm_tee_tpm_ops = {
-	.flags = TPM_OPS_AUTO_STARTUP,
-	.send = ftpm_tee_tpm_op_send,
+static const struct tpm_optee_config ftpm_tee_config = {
+	.ta_uuid = UUID_INIT(0xBC50D971, 0xD4C9, 0x42C4,
+			     0x82, 0xCB, 0x34, 0x3F, 0xB7, 0xF3, 0x78, 0x96),
+	.login	 = TEE_IOCTL_LOGIN_PUBLIC,
+	.cmd_id	 = FTPM_OPTEE_TA_SUBMIT_COMMAND,
 };
 
-/*
- * Check whether this driver supports the fTPM TA in the TEE instance
- * represented by the params (ver/data) to this function.
- */
-static int ftpm_tee_match(struct tee_ioctl_version_data *ver, const void *data)
-{
-	/*
-	 * Currently this driver only support GP Complaint OPTEE based fTPM TA
-	 */
-	if ((ver->impl_id == TEE_IMPL_ID_OPTEE) &&
-		(ver->gen_caps & TEE_GEN_CAP_GP))
-		return 1;
-	else
-		return 0;
-}
-
-/**
- * ftpm_tee_probe_generic() - initialize the fTPM
- * @dev: the device description.
- *
- * Return:
- *	On success, 0. On failure, -errno.
- */
-static int ftpm_tee_probe_generic(struct device *dev)
-{
-	int rc;
-	struct tpm_chip *chip;
-	struct ftpm_tee_private *pvt_data = NULL;
-	struct tee_ioctl_open_session_arg sess_arg;
-
-	pvt_data = devm_kzalloc_obj(dev, struct ftpm_tee_private);
-	if (!pvt_data)
-		return -ENOMEM;
-
-	dev_set_drvdata(dev, pvt_data);
-
-	/* Open context with TEE driver */
-	pvt_data->ctx = tee_client_open_context(NULL, ftpm_tee_match, NULL,
-						NULL);
-	if (IS_ERR(pvt_data->ctx)) {
-		if (PTR_ERR(pvt_data->ctx) == -ENOENT)
-			return -EPROBE_DEFER;
-		dev_err(dev, "%s: tee_client_open_context failed\n", __func__);
-		return PTR_ERR(pvt_data->ctx);
-	}
-
-	/* Open a session with fTPM TA */
-	memset(&sess_arg, 0, sizeof(sess_arg));
-	export_uuid(sess_arg.uuid, &ftpm_ta_uuid);
-	sess_arg.clnt_login = TEE_IOCTL_LOGIN_PUBLIC;
-	sess_arg.num_params = 0;
-
-	rc = tee_client_open_session(pvt_data->ctx, &sess_arg, NULL);
-	if ((rc < 0) || (sess_arg.ret != 0)) {
-		dev_err(dev, "%s: tee_client_open_session failed, err=%x\n",
-			__func__, sess_arg.ret);
-		rc = -EINVAL;
-		goto out_tee_session;
-	}
-	pvt_data->session = sess_arg.session;
-
-	/* Allocate dynamic shared memory with fTPM TA */
-	pvt_data->shm = tee_shm_alloc_kernel_buf(pvt_data->ctx,
-						 MAX_COMMAND_SIZE +
-						 MAX_RESPONSE_SIZE);
-	if (IS_ERR(pvt_data->shm)) {
-		dev_err(dev, "%s: tee_shm_alloc_kernel_buf failed\n", __func__);
-		rc = -ENOMEM;
-		goto out_shm_alloc;
-	}
-
-	/* Allocate new struct tpm_chip instance */
-	chip = tpm_chip_alloc(dev, &ftpm_tee_tpm_ops);
-	if (IS_ERR(chip)) {
-		dev_err(dev, "%s: tpm_chip_alloc failed\n", __func__);
-		rc = PTR_ERR(chip);
-		goto out_chip_alloc;
-	}
-
-	pvt_data->chip = chip;
-	pvt_data->chip->flags |= TPM_CHIP_FLAG_TPM2 | TPM_CHIP_FLAG_SYNC;
-
-	/* Create a character device for the fTPM */
-	rc = tpm_chip_register(pvt_data->chip);
-	if (rc) {
-		dev_err(dev, "%s: tpm_chip_register failed with rc=%d\n",
-			__func__, rc);
-		goto out_chip;
-	}
-
-	return 0;
-
-out_chip:
-	put_device(&pvt_data->chip->dev);
-out_chip_alloc:
-	tee_shm_free(pvt_data->shm);
-out_shm_alloc:
-	tee_client_close_session(pvt_data->ctx, pvt_data->session);
-out_tee_session:
-	tee_client_close_context(pvt_data->ctx);
-
-	return rc;
-}
-
 static int ftpm_tee_probe(struct tee_client_device *tcdev)
 {
-	struct device *dev = &tcdev->dev;
-
-	return ftpm_tee_probe_generic(dev);
+	return tpm_optee_probe(&tcdev->dev, &ftpm_tee_config);
 }
 
 static int ftpm_plat_tee_probe(struct platform_device *pdev)
 {
-	struct device *dev = &pdev->dev;
-
-	return ftpm_tee_probe_generic(dev);
-}
-
-/**
- * ftpm_tee_remove_generic() - remove the TPM device
- * @dev: the device description.
- *
- * Return:
- *	0 always.
- */
-static void ftpm_tee_remove_generic(struct device *dev)
-{
-	struct ftpm_tee_private *pvt_data = dev_get_drvdata(dev);
-
-	/* Release the chip */
-	tpm_chip_unregister(pvt_data->chip);
-
-	/* frees chip */
-	put_device(&pvt_data->chip->dev);
-
-	/* Free the shared memory pool */
-	tee_shm_free(pvt_data->shm);
-
-	/* close the existing session with fTPM TA*/
-	tee_client_close_session(pvt_data->ctx, pvt_data->session);
-
-	/* close the context with TEE driver */
-	tee_client_close_context(pvt_data->ctx);
-
-	/* memory allocated with devm_kzalloc() is freed automatically */
+	return tpm_optee_probe(&pdev->dev, &ftpm_tee_config);
 }
 
 static void ftpm_tee_remove(struct tee_client_device *tcdev)
 {
-	struct device *dev = &tcdev->dev;
-
-	ftpm_tee_remove_generic(dev);
+	tpm_optee_remove(&tcdev->dev);
 }
 
 static void ftpm_plat_tee_remove(struct platform_device *pdev)
 {
-	struct device *dev = &pdev->dev;
-
-	ftpm_tee_remove_generic(dev);
+	tpm_optee_remove(&pdev->dev);
 }
 
-/**
- * ftpm_plat_tee_shutdown() - shutdown the TPM device
- * @pdev: the platform_device description.
- */
 static void ftpm_plat_tee_shutdown(struct platform_device *pdev)
 {
-	struct ftpm_tee_private *pvt_data = dev_get_drvdata(&pdev->dev);
-
-	tee_shm_free(pvt_data->shm);
-	tee_client_close_session(pvt_data->ctx, pvt_data->session);
-	tee_client_close_context(pvt_data->ctx);
+	tpm_optee_shutdown(&pdev->dev);
 }
 
 static const struct of_device_id of_ftpm_tee_ids[] = {
@@ -342,7 +85,6 @@ static const struct tee_client_device_id optee_ftpm_id_table[] = {
 		   0x82, 0xcb, 0x34, 0x3f, 0xb7, 0xf3, 0x78, 0x96)},
 	{}
 };
-
 MODULE_DEVICE_TABLE(tee, optee_ftpm_id_table);
 
 static struct tee_client_driver ftpm_tee_driver = {
diff --git a/drivers/char/tpm/tpm_ftpm_tee.h b/drivers/char/tpm/tpm_ftpm_tee.h
deleted file mode 100644
index 8d5c3f0d2879..000000000000
--- a/drivers/char/tpm/tpm_ftpm_tee.h
+++ /dev/null
@@ -1,35 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (C) Microsoft Corporation
- */
-
-#ifndef __TPM_FTPM_TEE_H__
-#define __TPM_FTPM_TEE_H__
-
-#include <linux/tee_drv.h>
-#include <linux/tpm.h>
-#include <linux/uuid.h>
-
-/* The TAFs ID implemented in this TA */
-#define FTPM_OPTEE_TA_SUBMIT_COMMAND  (0)
-#define FTPM_OPTEE_TA_EMULATE_PPI     (1)
-
-/* max. buffer size supported by fTPM  */
-#define MAX_COMMAND_SIZE       4096
-#define MAX_RESPONSE_SIZE      4096
-
-/**
- * struct ftpm_tee_private - fTPM's private data
- * @chip:     struct tpm_chip instance registered with tpm framework.
- * @session:  fTPM TA session identifier.
- * @ctx:      TEE context handler.
- * @shm:      Memory pool shared with fTPM TA in TEE.
- */
-struct ftpm_tee_private {
-	struct tpm_chip *chip;
-	u32 session;
-	struct tee_context *ctx;
-	struct tee_shm *shm;
-};
-
-#endif /* __TPM_FTPM_TEE_H__ */
-- 
2.55.0


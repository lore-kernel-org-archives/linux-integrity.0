Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794320375;
	b=t+5ya/GbQhuk+T6/HLgS4RxlfT7O2gV0FGmrmFRNZu6hkB58Wtzhh+KPvSBg927FPa/p
	 nk8NDN59VKNheShtlDVfRtgc99Xz9bCC8e+LwASwss7FmjEgM0But870JzKnX1cXOn2MQ
	 ysqAKvaI1JnP8mXLpV8TVCwSgEc+IFJp3wlRRWO13XzT3AVs5WrNTdKaQLwuMhZaq4CPF
	 qJtXKffJSJhTCqyskdzhsYFAAVSmOJGw822oPEEXbYmBGoyCeLwZcgq93cZwZb9nwEA7i
	 7h7vhXu7KDQk+faW2sPzmWIvWkq6ADtRud3bIYXhelS/lbsY+si08QYYEXW+Egu46bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320375;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=wyNeL4ZQdh8/kVnu434MYHZvxUgADZfcW1FXoVHK6dA=;
	b=qoYfdP+Qi3ATCXmREyEde9AyL4uG1Owl1QItKCFQblTW/2D3taLJs17OnRsxKwjqjK9F
	 XV91PnWYDk45h4MB9myXeI4TU/Dc+t3qQK34zY5UXRjFzjuWJzI5wIRLIrLeNFlC/i4Lh
	 aQ6EG1szF8Gs4n+09W3FBBA4c8qvB6hOCiZk/nOxyjGtRLod04L6bgEll/XIFtjrlMSbr
	 GZIi1zcOLUHmJOGkMneF8ej3mUfJyXy28M+acTwKqwstkmENFb5Mroe7XYfneUyLy1L8O
	 fkwFctffipKN6Luje1ODJNepIwH+cNfL6yZ9DL9fH+1ZrR5jbqHIVCsK4+yQJx4MMQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="B6R/9dB3";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=G3phfJLn;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCCD60A2615
	for <linux-integrity@vger.kernel.org>; Tue, 10 Nov 2026 14:19:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FCCD60A2615
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=B6R/9dB3;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=G3phfJLn
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AAB9pLq3228340
	for <linux-integrity@vger.kernel.org>; Tue, 10 Nov 2026 14:19:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=wyNeL4ZQdh8
	/kVnu434MYHZvxUgADZfcW1FXoVHK6dA=; b=B6R/9dB3GP+UYobybD+9+ARgOBn
	Fau+YkqCgoAhuc9106A+IdoyfSqKe7uTzdxPj5TC7PjDpqjZkSoEUuJOACqrBXSD
	Q2NGUFGwM01XRF2APyw1iJjehhyOBfBaD9InlVqZMv9bg3+oALb4Mq6jb5HYaTZu
	/pfIVnizOz0ASThDh1jmPwUoXXIRjikNIq5y09wIZF+0ewq4EIand84OD8t/dmXk
	bl8VO93vQ4rlPWK9WaJ7B/55KsRwOJnyG/+jP4AHsrm0V7HqVyDH0+GOc5KuUVpb
	1sVfwyfotrTJMvhWKfDZLCD051YTrnkpPF3JdX9IX4mVNKV433Kmh6LM92g==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4huy5d9bhr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Tue, 10 Nov 2026 14:19:33 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-91e98b67c0fso42191446d6.3
        for <linux-integrity@vger.kernel.org>; Tue, 10 Nov 2026 06:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794320373; x=1794925173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wyNeL4ZQdh8/kVnu434MYHZvxUgADZfcW1FXoVHK6dA=;
        b=G3phfJLn6Imw7aIHW78b1GC2DUvElcFSwunx5Q3Q1XotSsuM4zbEXVVrDMxlYVV44y
         JDUTBeeRpzfqVuEC2bQOQoV3GSD/A8pnovl+NSHLRk1EXUaaWO5s2TQk3YyYy+yBik20
         ma3L0WOJ5PneGNEAC59oSJ/QJxUxptQR9cq9XTtav54A4wtcgk+PZs3+PCigXEcVSdbT
         3KZouhDdQ0xMp4BiqhgqBv5VeKjIEYhIb6lEXWovjm6bwBJSZnz/zENLJHPW5chZyKpv
         maL0UN51qk8/NipHNMG418AYVoduxNuY++fceIuOYGJnH5IIbWJOOBhtJqWuHLYK/Fpb
         NH3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794320373; x=1794925173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wyNeL4ZQdh8/kVnu434MYHZvxUgADZfcW1FXoVHK6dA=;
        b=noEJnSSK8gTyq2/vOQzbutQpzjfQr5nHWal7YNoxC/uW0cwbLz+2v6DVCrvCG7bTEA
         zG2DJWBORGVkOGX3QVsuDyBLl6SMLpN0UdUOZCDqJy84bdCYj485af0JqBS2JWanCcjt
         9A5dWLZ2XIp9rjHJZwJNLvQKhqoP4sCIQ1aNb0QbmfvEVIw+F1nDUu5P+WkIxkkF1d+5
         do3ABJxHeX4Yzlg6IAlVwP/CSl2EykZOsGZCVEZ1ZAt6Dura8P8nheIvBpWsCVGnWkp0
         gxDabASIoAuBQrzl4AW/vT+kVqBstvJIhq1GAHv0KU11NQSXBvoplJ1D9F9w0xAfMTM8
         A0MQ==
X-Forwarded-Encrypted: i=1; AL+hErGnuTr9kOtLi3nb4rZaAHwEsPOOvYPwNVzWDtnHRRjpGuzTy7LrulePOEJJjXBE6h0qFpIfg2pVpsD6+3nz6ss=@vger.kernel.org
X-Gm-Message-State: APuU4Z8EuhWr4DL4vIZm9ptRkpJSbzO4tmFptLctApwcp1FBtCdIF7PM
	9H5bJiHu+EjlhabQcOOINtcq1zu9ZAPIefyObaxlfuL6UqQvhLEwVkHVf/XvFIMNhTxEU/vFZZ9
	gSS5zZ92UDppaLNj6DGIAEpXkMlm85vmey9J2XxaouazatlEHTvgKD4RtEovs0/c5TEhqBzslRp
	O8MNk=
X-Gm-Gg: AYBFou3wt+0KJGn3p1IGjVncHyW70d8WE3f72TKo4JwaGCcyU7ThHy55364qAIckLNq
	A8g4R/9sLKfCOP1jGd+R1RBHCR2GcZN7MEPumyWITGZ/IbYCVLYqsBGKejyIrXKNj7l3huKCDmr
	D6Q6hX+QIaLkPeRPAiCjDzcl5/WEu295Z3LPw9QNrtPuzhqwsaDP7V3W4wdmcAebH6bqlRLk4tn
	lpxgtM8VNDGJQ6mvQ5KNxlKwFbXCaC81LVnn7KKpOWrLPhNEwc82aHz/3hSeSV0cFU9KJDlJ4Ie
	uZ8ITaXROaBiYaEzZhG0B1LN3Cre0MWSoKsmMMZZtAEjzz0zZyD9ghE5PXHPoWNYlTXEXkqOYpd
	6t7LVNzvA8gHn4A8oMcKPA0fEjn6Wrip5ug4GjB6Cxae6G8Cxg9yAaHNA1/UeQ1Z0kVdWQDIzzp
	7QzGvJcCLO0owNnskssA==
X-Received: by 2002:a05:620a:439e:b0:93f:1ed3:a9d7 with SMTP id af79cd13be357-9479f2f0ecbmr400410685a.27.1794320372441;
        Tue, 10 Nov 2026 06:19:32 -0800 (PST)
X-Received: by 2002:a05:620a:439e:b0:93f:1ed3:a9d7 with SMTP id af79cd13be357-9479f2f0ecbmr400405985a.27.1794320371889;
        Tue, 10 Nov 2026 06:19:31 -0800 (PST)
Received: from trex (50.red-81-37-172.dynamicip.rima-tde.net. [81.37.172.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4983284c99bsm5418133f8f.7.2026.11.10.06.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 06:19:30 -0800 (PST)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, peterhuewe@gmx.de, jarkko@kernel.org,
        jgg@ziepe.ca, sumit.garg@oss.qualcomm.com
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: [PATCH v2 2/2] tpm_ftpm_tee: use the tpm_optee transport core
Date: Tue, 10 Nov 2026 15:19:09 +0100
Message-ID: <20261110141923.3100770-3-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261110141923.3100770-1-jorge.ramirez@oss.qualcomm.com>
References: <20261110141923.3100770-1-jorge.ramirez@oss.qualcomm.com>
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
X-Proofpoint-GUID: NBoVw6TZLrWel1IN8IPA_5taocJGjz5R
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA1NiBTYWx0ZWRfX8gKslxJvhUOA
 iWrbzLyMfusUmPndzyb+SaD/o3lWuFsSOsb0etflctXnXi9HSfaJYkR73PPGhgC6m5JbOAkQNNl
 Rrg2Dj/eTtEgXDGJh9T9ijuK3mxj5i8=
X-Authority-Analysis: v=2.4 cv=d+9gWhjE c=1 sm=1 tr=0 ts=6af327f5 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=VbO86HPdXvN82gCvB8O6pw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=NEAV23lmAAAA:8
 a=p5XVOwWNAAAA:20 a=EUspDBNiAAAA:8 a=2-tU7BYwHWlFsm3ryKcA:9
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: NBoVw6TZLrWel1IN8IPA_5taocJGjz5R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA1NiBTYWx0ZWRfX3cPYicXe1Udm
 mcTeJTBlW4dQSIwFWMVE2XvjmsOxogymL9f4SjsVvuKHe9B7w5WcpSqyS98An7X0YRepBqBKoxT
 evayEEZ5jlGp1IapMtAeGg1gcQfXtaC4yHs3YI1rYeMmIkx0Ay0nPSsBnNuqv8qlZIgKV4KXxhF
 s5+3iduI6iPk7N/WgG8/Uedd4j4Lc3ZjdvsVff2VoA+mw1THZtebQqEl5JcnrT9ilbNAWkaZ40K
 ePhRN9bZCofwdjYFMyQFoz2y13nicQBRQGSMiyQP4Qv1l6ugyhTNijHq78LQv0C+44AFkPNa1rf
 /S/T+8D0n5/xL7nSr7SvvrFYPu628REM2vt7WvwAm7pJ4/Kpg/Z2CL74arn5MhcMRvWNYvQyfVu
 blnQqYkPxxY0xPPVnFsDnz9ww1wh4A7jeageMg4Ybq4/ZXpilw1LO6oxj7JPqJ/cisSen89xw1r
 KoKxQ5xZIXeL7P7L6/g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100056

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
---
 drivers/char/tpm/Kconfig        |   1 +
 drivers/char/tpm/tpm_ftpm_tee.c | 295 ++------------------------------
 drivers/char/tpm/tpm_ftpm_tee.h |  35 ----
 drivers/char/tpm/tpm_optee.c    |  11 ++
 drivers/char/tpm/tpm_optee.h    |   1 +
 5 files changed, 31 insertions(+), 312 deletions(-)
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
index b82490439633..1665e9b584a7 100644
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
@@ -26,299 +31,36 @@
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
-	pvt_data = devm_kzalloc(dev, sizeof(struct ftpm_tee_private),
-				GFP_KERNEL);
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
@@ -343,7 +85,6 @@ static const struct tee_client_device_id optee_ftpm_id_table[] = {
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
diff --git a/drivers/char/tpm/tpm_optee.c b/drivers/char/tpm/tpm_optee.c
index c251626ae395..e2223242327e 100644
--- a/drivers/char/tpm/tpm_optee.c
+++ b/drivers/char/tpm/tpm_optee.c
@@ -238,5 +238,16 @@ void tpm_optee_remove(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(tpm_optee_remove);
 
+/* Release the TEE resources on shutdown, leaving the chip registered. */
+void tpm_optee_shutdown(struct device *dev)
+{
+	struct tpm_optee_private *pvt_data = dev_get_drvdata(dev);
+
+	tee_shm_free(pvt_data->shm);
+	tee_client_close_session(pvt_data->ctx, pvt_data->session);
+	tee_client_close_context(pvt_data->ctx);
+}
+EXPORT_SYMBOL_GPL(tpm_optee_shutdown);
+
 MODULE_DESCRIPTION("OP-TEE TPM transport core");
 MODULE_LICENSE("GPL");
diff --git a/drivers/char/tpm/tpm_optee.h b/drivers/char/tpm/tpm_optee.h
index 11193b5dc284..a3a2ea2a951d 100644
--- a/drivers/char/tpm/tpm_optee.h
+++ b/drivers/char/tpm/tpm_optee.h
@@ -27,5 +27,6 @@ struct tpm_optee_config {
 
 int tpm_optee_probe(struct device *dev, const struct tpm_optee_config *cfg);
 void tpm_optee_remove(struct device *dev);
+void tpm_optee_shutdown(struct device *dev);
 
 #endif /* __TPM_OPTEE_H__ */
-- 
2.55.0


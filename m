Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794320374;
	b=LO7bgJKoZDRq89ggOn3GMM1ZDAcllsLI1ba7E/SB/qVjm3Q/J6yXq+tgRBScxd3bBma0
	 doYTniHGnNfnYUaL7SFCleHtRRV9ShQYsre/YQkN/UD5RK8fDKHMQ1/7lm+uIzagOT2+B
	 0p5LBzWYBv/IOk/18iGlEc2VY4bbtWTYMKJC28XaaroczJSPSdTBvD1wzEuGzUBGH3Vrk
	 bjUMPdZo7SKs10JSREsHOyE0ElVechu/SIP4I9fo5IwHfdgFr59ttzRlhYOONBlOf94x0
	 S/BX5rb2K3DcLNkI0+aoHqL22nRRvIyNkok95yMK1xD2++PwUeqPaYNbU9AR1oxCBRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320374;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=aZ+96FCnaQr0oQnhlJ8IeVmww/y0V6phyQXyCAjrSTE=;
	b=srp/lIsasQTExBtD1G4lpNA5N4okKXWc5qt06Z5J1CAM9dOwoEHZrAi+y9Qvvufqmeh6
	 vIWH3THwbuWknnJxNKgVA1tnkNt68ZBBfRfZHoHmzi4Lk1SEKMupNWSHE/ialKnbXLfNk
	 iwGv0QMxfD+h6mAOIc9WQgKHpQKWdm3v6oFJqlI/O14d6NhzKpUY3QDJNG7xr03GZHaCT
	 7SlCu/PTXXf80jhZop3OANV4bLUiXgzG+kFmFgGdtNu3Xv6i0AH96ERpdMCMJcATudhnA
	 GU7s02o43CtU4wYSbWnkfnVWqz7yjGoFNkKMoapnVH/t+6tHbh4KHOgPOHuZilB6qkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pRJKdlE4;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=glJwckRK;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED7560A2607
	for <linux-integrity@vger.kernel.org>; Tue, 10 Nov 2026 14:19:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6ED7560A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pRJKdlE4;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=glJwckRK
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AAB9uV12253402
	for <linux-integrity@vger.kernel.org>; Tue, 10 Nov 2026 14:19:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=aZ+96FCnaQr
	0oQnhlJ8IeVmww/y0V6phyQXyCAjrSTE=; b=pRJKdlE4AdIAQFTYBLbLb5h2u1n
	clDyYJJWImMXOX3pfW2/jsYJefRxs7H/AcxYKk4e1yhjJtQK6IStaJc9v/a2g1p7
	JV8gE1HGQsC/A5f6qbvO8eDZQqMGVtkz0FYBkHsDPTs6tIo/MDfNC72i3F8Xcj3I
	bmPgR/6aM4jh+sGHASvY0Y5C8nLT6UjFTXkeuHvhGV/pAbqPWc7TyY2SmdywNAcY
	RVOcokFZNN5PPZVGKXcZIJxQmzK+T6T98ok/BiL55FvHQMgEHHlyYO0wdRCJZLjl
	8oCk/ETDib4atZjLG7VpkY+uoBsG6Hk8wG6X4TprJiUi8Y0ba2zCMppCpwQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4huyw495c3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Tue, 10 Nov 2026 14:19:32 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f2373e9b4so244047985a.1
        for <linux-integrity@vger.kernel.org>; Tue, 10 Nov 2026 06:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794320371; x=1794925171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aZ+96FCnaQr0oQnhlJ8IeVmww/y0V6phyQXyCAjrSTE=;
        b=glJwckRKDE5XRU/AFZPJxszMrIi0COqsNRTRhbxZyi81ARXE3uBsQbK7jzOPL0407y
         FxQhzn1ZJZC3SgzeP8TFaQTuGoWivc7VHEq6r4k8xtqR++820x2guTKVlI/4edbp0MQT
         0hwZKoSibs1fb97uI7XsGFnJ+lrgQGf547XKtrODPIH91Dp5cvv7umigCJK3UI2XZ7jb
         huo01aQfrBIbhYynWBQBdT5qfV+tvgNDBGQe2YD2ffc0loc5MzoFT+sL0Rk1kZDeZYds
         46+Ibjy6DpaC7TgnudtEnbNiin+Ui0pR2zxNh4NocDvfpszT6bUEwPsbvZRnYq2i2sc3
         O8ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794320371; x=1794925171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aZ+96FCnaQr0oQnhlJ8IeVmww/y0V6phyQXyCAjrSTE=;
        b=d24vb9KDIOLBEZME6EYJbMV/Clzc+zrkev6UXlTfrqVir5YtBRPx8Ep8TL8t7hyu4c
         I4ZlHBh7z4PmDD/rQPkrT0F6wCspoW9vG6Ji4dUVays6IHDZDRrSXuw1mONWne5r4Dgl
         x+sxyE+4zjIOWthdIuLUAtmxqPpvj7/V9SutVTppbbPt/3b3vH9QGfTTeGsPxbPHuNaj
         WOsZkFlqoBsRG0DON4tCJsANKdRu4DE+iJ4YDZ6tLOMBmitAaS7wkacvHZG9gn/+BS+P
         WDEnnxUoLlkYUYOkGefeg0O74oCDZXpuVZ+5QDoTWUJwQE/vZSxMGYu0LiXLJp35yyVP
         DgLw==
X-Forwarded-Encrypted: i=1; AL+hErGgzR8S2jK6AWFuQzb2mUEEibr0i2A6LsCyeBJLd7uPKKVLaK5BVvWWIuoCGWMfvIfgitdyMenvmgVLg14Ad7g=@vger.kernel.org
X-Gm-Message-State: APuU4Z/qhVetfyE84JDUZ/iVzb7ap3lYfI/kkEr2oucDK+ixKwZWaYhG
	ApjUABzWWJYu5uHCbUUuWlBHWOM/DiZNSQyo2aTHGFbZXSFFpaxQZWBCc1ZHnSZoqlclMvZcWTl
	A/DhJSOQtKKEfNE87eUMDNubeE4sS6Mqq97K4KzqFLujcZh0NTsDlwJvpQtF7Nc/nWrW/6Rc=
X-Gm-Gg: AYBFou1Kq7DVBCydobeFv5OcYrugdG04AbjAlFkOn1B4LciZSquRbggI18olecUZJAx
	+gKdrsBblSemRCcDCVQsFgpyZxLA+Wsr3lBlNX2To2Ryt76AQPrTCq/vdRP1tqnkES/+S1tGGiz
	UxrQvdUIFVD7hk5FJr9GmMz5MmknPWkmN+l5eceppEzCNZapcbFgTwVGitlbe1GNYEkYXpC2OS0
	xpt3uKZI0vXeV2vyjrOW5XnTsnEXk8J6SVPwM6O1oMy5c15zgr2L5unIEOC1XRexdRuvWB71fvX
	rWVmPvBjZhKZ/LXurS+FYgWrchL27TbDrFF6Ackbpp81dNfGoozCORc/0J5nK63GRxUIv2EM17J
	UrhyKWcNIhiJu0uQ5i70wch0N1sCutGt6xeTRgnLfpIVASDtlmBA5sZAhzFzLw8Qf/T6/XHQKj1
	IdJ6WpIcRTrqLuYBpTTw==
X-Received: by 2002:a05:620a:410c:b0:93c:62c4:e2e2 with SMTP id af79cd13be357-9479f1d77a3mr405144785a.12.1794320370740;
        Tue, 10 Nov 2026 06:19:30 -0800 (PST)
X-Received: by 2002:a05:620a:410c:b0:93c:62c4:e2e2 with SMTP id af79cd13be357-9479f1d77a3mr405136685a.12.1794320369896;
        Tue, 10 Nov 2026 06:19:29 -0800 (PST)
Received: from trex (50.red-81-37-172.dynamicip.rima-tde.net. [81.37.172.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4983284c99bsm5418133f8f.7.2026.11.10.06.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 06:19:28 -0800 (PST)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, peterhuewe@gmx.de, jarkko@kernel.org,
        jgg@ziepe.ca, sumit.garg@oss.qualcomm.com
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: [PATCH v2 1/2] tpm: add OP-TEE transport core and a discrete TPM driver
Date: Tue, 10 Nov 2026 15:19:08 +0100
Message-ID: <20261110141923.3100770-2-jorge.ramirez@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA1NiBTYWx0ZWRfX5oA/lN7Qhkyx
 PsUvsLULhg9gfOWdWCwi86s0To8CzOqGtHFYzwOaXH4agpZqHFTUOXlWLanQxQwCEmQimmBJfzR
 RpHzwXtdEYDarAnNQiPmk3vsv2EkzCz3SMfSzi+wrxB4xns4ZZp9Y4vNww5khkCUPadT0SDW5qO
 j+4gfGhIY+k6fQKlUGFz/Dtcsmu1WmRcodCs+x0K2OT8e1b61iQCV7gApjfa98gU8saOuV/aWto
 kHKHmTjm/TD15OPCfVV7Iak9NMa/oBZGLXukLgmK/3+U/5WxsLZyXo3fcuzcUQHQtDL/1UwqoIv
 vdlgBx4VtD27VUgp8Vn7DME/HaDCbg14D9tggoUp2+ST6eucSpGaYaExN6qpZs88OVRzM7i/2le
 2T1KCYIvC+FCWZSf4SdUakytPFDx0TI535uzaGFFdWjSfzUogup+Kc0ZoRRnGhrL61zeuqMz3et
 RXsOxlruU80M6mNjpRA==
X-Authority-Analysis: v=2.4 cv=Ee1d0/mC c=1 sm=1 tr=0 ts=6af327f4 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=VbO86HPdXvN82gCvB8O6pw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=eWAozK0ZnoFYOt3N-tIA:9
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA1NiBTYWx0ZWRfX4sIPDiRfD48x
 T5S7sKZ+rkAWKufd7kcodHnN2MlXZrIyF5TphIkNZoOEK0JrbjeEW4RxKv6UgLlDIFsdvwEJ3PZ
 t5nkWWL/aDy3rNpK8MGeEPKzRjERunk=
X-Proofpoint-GUID: 58CJXo4l_4AILCibUAIs1pjQbhagVItZ
X-Proofpoint-ORIG-GUID: 58CJXo4l_4AILCibUAIs1pjQbhagVItZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 suspectscore=0 clxscore=1015 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100056

Some platforms place a real (discrete) TPM on a bus that only the secure
world can drive. OP-TEE owns that bus, so the normal world cannot reach
the chip directly; it instead exposes a mediator trusted application
that relays TPM2 commands. Add a driver that talks to that application
and presents the chip as a standard TPM2 character device, so the
normal-world TPM stack works unchanged.

This is a separate driver from the firmware-TPM one rather than a reuse
of it. The TEE transport is the same and is shared through a common
core, but the device identity differs: the firmware TPM uses its own
application and a public-login session, whereas a discrete chip needs
its own application and is restricted to kernel access so that user
space and other applications cannot submit raw commands to it. Folding
both into one driver would also break on a platform that has both.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
---
 MAINTAINERS                       |   8 +
 drivers/char/tpm/Kconfig          |  27 ++++
 drivers/char/tpm/Makefile         |   2 +
 drivers/char/tpm/tpm_optee.c      | 242 ++++++++++++++++++++++++++++++
 drivers/char/tpm/tpm_optee.h      |  31 ++++
 drivers/char/tpm/tpm_optee_dtpm.c |  67 +++++++++
 6 files changed, 377 insertions(+)
 create mode 100644 drivers/char/tpm/tpm_optee.c
 create mode 100644 drivers/char/tpm/tpm_optee.h
 create mode 100644 drivers/char/tpm/tpm_optee_dtpm.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 782389bd5cd3..7c39a060ced2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27710,6 +27710,14 @@ F:	include/linux/tpm*.h
 F:	include/uapi/linux/vtpm_proxy.h
 F:	tools/testing/selftests/tpm2/
 
+TPM TEE DRIVER FOR DISCRETE TPM
+R:	Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
+L:	linux-integrity@vger.kernel.org
+S:	Supported
+F:	drivers/char/tpm/tpm_optee.c
+F:	drivers/char/tpm/tpm_optee.h
+F:	drivers/char/tpm/tpm_optee_dtpm.c
+
 TPS546D24 DRIVER
 M:	Duke Du <dukedu83@gmail.com>
 L:	linux-hwmon@vger.kernel.org
diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
index 5f672f2c01b0..779154e05204 100644
--- a/drivers/char/tpm/Kconfig
+++ b/drivers/char/tpm/Kconfig
@@ -243,6 +243,33 @@ config TCG_FTPM_TEE
 	help
 	  This driver proxies for firmware TPM running in TEE.
 
+config TCG_OPTEE
+	tristate
+	depends on TEE && OPTEE
+	help
+	  Shared transport for TPMs reached through an OP-TEE trusted
+	  application. It is selected by the front-end drivers and is not
+	  meant to be enabled on its own.
+
+config TCG_OPTEE_DTPM
+	tristate "OP-TEE based discrete TPM Interface"
+	depends on TEE && OPTEE
+	select TCG_OPTEE
+	help
+	  This driver proxies for a discrete TPM that is owned by OP-TEE and
+	  reachable only from the secure world (for example an SPI TPM behind
+	  OP-TEE's TPM TIS driver). OP-TEE exposes a mediator pseudo TA and
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
index 5b5cdc0d32e4..431d1351c2e3 100644
--- a/drivers/char/tpm/Makefile
+++ b/drivers/char/tpm/Makefile
@@ -45,5 +45,7 @@ obj-$(CONFIG_TCG_CRB) += tpm_crb.o
 obj-$(CONFIG_TCG_ARM_CRB_FFA) += tpm_crb_ffa.o
 obj-$(CONFIG_TCG_VTPM_PROXY) += tpm_vtpm_proxy.o
 obj-$(CONFIG_TCG_FTPM_TEE) += tpm_ftpm_tee.o
+obj-$(CONFIG_TCG_OPTEE) += tpm_optee.o
+obj-$(CONFIG_TCG_OPTEE_DTPM) += tpm_optee_dtpm.o
 obj-$(CONFIG_TCG_SVSM) += tpm_svsm.o
 obj-$(CONFIG_TCG_LOONGSON) += tpm_loongson.o
diff --git a/drivers/char/tpm/tpm_optee.c b/drivers/char/tpm/tpm_optee.c
new file mode 100644
index 000000000000..c251626ae395
--- /dev/null
+++ b/drivers/char/tpm/tpm_optee.c
@@ -0,0 +1,242 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * Shared transport for TPMs reached through an OP-TEE trusted application:
+ * open the context and session, relay raw TPM2 commands over TEE shared
+ * memory, and register the result as a standard tpm_chip. A front-end driver
+ * supplies the per-device identity (TA UUID, client login, submit function
+ * ID) and binds the TA.
+ */
+
+#include <linux/module.h>
+#include <linux/tee_drv.h>
+#include <linux/tpm.h>
+#include <linux/uuid.h>
+
+#include "tpm.h"
+#include "tpm_optee.h"
+
+#define TPM_OPTEE_MAX_COMMAND_SIZE	4096
+#define TPM_OPTEE_MAX_RESPONSE_SIZE	4096
+
+struct tpm_optee_private {
+	struct tpm_chip *chip;
+	struct tee_context *ctx;
+	u32 session;
+	struct tee_shm *shm;
+	const struct tpm_optee_config *cfg;
+};
+
+/* Validate the response header the TA wrote back, return its length or -EIO */
+static int tpm_optee_resp_len(struct tpm_chip *chip, const u8 *resp,
+			      size_t bufsiz)
+{
+	size_t resp_len = be32_to_cpu(((struct tpm_header *)resp)->length);
+
+	if (resp_len < TPM_HEADER_SIZE || resp_len > TPM_OPTEE_MAX_RESPONSE_SIZE ||
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
+ * tpm_optee_op_send() - relay a TPM command through TEE shared memory.
+ * @chip:	the tpm_chip description
+ * @buf:	command on entry, response on return
+ * @bufsiz:	size of @buf
+ * @cmd_len:	number of command bytes to send
+ *
+ * Return: number of response bytes on success, -errno on failure.
+ */
+static int tpm_optee_op_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
+			     size_t cmd_len)
+{
+	struct tpm_optee_private *pvt_data = dev_get_drvdata(chip->dev.parent);
+	struct tee_shm *shm = pvt_data->shm;
+	struct tee_param command_params[4] = { };
+	struct tee_ioctl_invoke_arg transceive_args = {
+		.func = pvt_data->cfg->cmd_id,
+		.session = pvt_data->session,
+		.num_params = 4,
+	};
+	u8 *temp_buf;
+	int rc;
+
+	if (cmd_len > TPM_OPTEE_MAX_COMMAND_SIZE || cmd_len > bufsiz) {
+		dev_err(&chip->dev, "command length %zu (buffer %zu)\n",
+			cmd_len, bufsiz);
+		return -EIO;
+	}
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
+	memset(temp_buf, 0, TPM_OPTEE_MAX_COMMAND_SIZE + TPM_OPTEE_MAX_RESPONSE_SIZE);
+	memcpy(temp_buf, buf, cmd_len);
+
+	command_params[1] = (struct tee_param) {
+		.attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT,
+		.u.memref = {
+			.shm = shm,
+			.size = TPM_OPTEE_MAX_RESPONSE_SIZE,
+			.shm_offs = TPM_OPTEE_MAX_COMMAND_SIZE,
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
+	rc = tpm_optee_resp_len(chip, temp_buf, bufsiz);
+	if (rc < 0)
+		return rc;
+
+	memcpy(buf, temp_buf, rc);
+
+	return rc;
+}
+
+static const struct tpm_class_ops tpm_optee_ops = {
+	.flags = TPM_OPS_AUTO_STARTUP,
+	.send = tpm_optee_op_send,
+};
+
+static int tpm_optee_match(struct tee_ioctl_version_data *ver, const void *data)
+{
+	/* Only GP-compliant OP-TEE is supported */
+	if (ver->impl_id == TEE_IMPL_ID_OPTEE && (ver->gen_caps & TEE_GEN_CAP_GP))
+		return 1;
+
+	return 0;
+}
+
+static int tpm_optee_open_session(struct device *dev, struct tee_context *ctx,
+				  const struct tpm_optee_config *cfg,
+				  u32 *session)
+{
+	struct tee_ioctl_open_session_arg sess_arg = {
+		.clnt_login = cfg->login,
+	};
+	int rc;
+
+	export_uuid(sess_arg.uuid, &cfg->ta_uuid);
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
+int tpm_optee_probe(struct device *dev, const struct tpm_optee_config *cfg)
+{
+	struct tpm_optee_private *pvt_data;
+	struct tpm_chip *chip;
+	int rc;
+
+	pvt_data = devm_kzalloc(dev, sizeof(*pvt_data), GFP_KERNEL);
+	if (!pvt_data)
+		return -ENOMEM;
+
+	pvt_data->cfg = cfg;
+	dev_set_drvdata(dev, pvt_data);
+
+	pvt_data->ctx = tee_client_open_context(NULL, tpm_optee_match, NULL,
+						NULL);
+	if (IS_ERR(pvt_data->ctx)) {
+		if (PTR_ERR(pvt_data->ctx) == -ENOENT)
+			return -EPROBE_DEFER;
+		dev_err(dev, "tee_client_open_context failed\n");
+		return PTR_ERR(pvt_data->ctx);
+	}
+
+	rc = tpm_optee_open_session(dev, pvt_data->ctx, cfg, &pvt_data->session);
+	if (rc)
+		goto out_tee_session;
+
+	pvt_data->shm = tee_shm_alloc_kernel_buf(pvt_data->ctx,
+						 TPM_OPTEE_MAX_COMMAND_SIZE +
+						 TPM_OPTEE_MAX_RESPONSE_SIZE);
+	if (IS_ERR(pvt_data->shm)) {
+		dev_err(dev, "tee_shm_alloc_kernel_buf failed\n");
+		rc = -ENOMEM;
+		goto out_shm_alloc;
+	}
+
+	chip = tpm_chip_alloc(dev, &tpm_optee_ops);
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
+EXPORT_SYMBOL_GPL(tpm_optee_probe);
+
+void tpm_optee_remove(struct device *dev)
+{
+	struct tpm_optee_private *pvt_data = dev_get_drvdata(dev);
+
+	tpm_chip_unregister(pvt_data->chip);
+	put_device(&pvt_data->chip->dev);
+	tee_shm_free(pvt_data->shm);
+	tee_client_close_session(pvt_data->ctx, pvt_data->session);
+	tee_client_close_context(pvt_data->ctx);
+}
+EXPORT_SYMBOL_GPL(tpm_optee_remove);
+
+MODULE_DESCRIPTION("OP-TEE TPM transport core");
+MODULE_LICENSE("GPL");
diff --git a/drivers/char/tpm/tpm_optee.h b/drivers/char/tpm/tpm_optee.h
new file mode 100644
index 000000000000..11193b5dc284
--- /dev/null
+++ b/drivers/char/tpm/tpm_optee.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * Shared transport for TPMs reached through an OP-TEE trusted application.
+ */
+
+#ifndef __TPM_OPTEE_H__
+#define __TPM_OPTEE_H__
+
+#include <linux/types.h>
+#include <linux/uuid.h>
+
+struct device;
+
+/**
+ * struct tpm_optee_config - identity of a TPM reached through an OP-TEE TA
+ * @ta_uuid:	UUID of the trusted application to bind
+ * @login:	TEE_IOCTL_LOGIN_* client login used to open the session
+ * @cmd_id:	TA function ID that submits a TPM command
+ */
+struct tpm_optee_config {
+	uuid_t	ta_uuid;
+	u32	login;
+	u32	cmd_id;
+};
+
+int tpm_optee_probe(struct device *dev, const struct tpm_optee_config *cfg);
+void tpm_optee_remove(struct device *dev);
+
+#endif /* __TPM_OPTEE_H__ */
diff --git a/drivers/char/tpm/tpm_optee_dtpm.c b/drivers/char/tpm/tpm_optee_dtpm.c
new file mode 100644
index 000000000000..b1a26158ca44
--- /dev/null
+++ b/drivers/char/tpm/tpm_optee_dtpm.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * Front-end for a discrete TPM owned by OP-TEE and exposed to the normal
+ * world through a mediator pseudo TA. The chip sits on a bus only the
+ * secure world can reach (e.g. an SPI TPM behind OP-TEE's TPM TIS driver);
+ * this driver supplies the TA identity and binds it, the shared transport in
+ * tpm_optee does the rest.
+ */
+
+#include <linux/module.h>
+#include <linux/tee_drv.h>
+#include <linux/uuid.h>
+
+#include "tpm_optee.h"
+
+#define TPM_OPTEE_DTPM_SUBMIT_COMMAND	0
+
+static const struct tpm_optee_config tpm_optee_dtpm_config = {
+	.ta_uuid = UUID_INIT(0x50568cd9, 0x370a, 0x46b8,
+			     0x9f, 0x2c, 0x6f, 0xd9, 0x06, 0x64, 0xd2, 0xee),
+	.login	 = TEE_IOCTL_LOGIN_REE_KERNEL,
+	.cmd_id	 = TPM_OPTEE_DTPM_SUBMIT_COMMAND,
+};
+
+static int tpm_optee_dtpm_probe(struct tee_client_device *tee_device)
+{
+	return tpm_optee_probe(&tee_device->dev, &tpm_optee_dtpm_config);
+}
+
+static void tpm_optee_dtpm_remove(struct tee_client_device *tee_device)
+{
+	tpm_optee_remove(&tee_device->dev);
+}
+
+static const struct tee_client_device_id tpm_optee_dtpm_id_table[] = {
+	{UUID_INIT(0x50568cd9, 0x370a, 0x46b8,
+		   0x9f, 0x2c, 0x6f, 0xd9, 0x06, 0x64, 0xd2, 0xee)},
+	{}
+};
+MODULE_DEVICE_TABLE(tee, tpm_optee_dtpm_id_table);
+
+static struct tee_client_driver tpm_optee_dtpm_driver = {
+	.id_table	= tpm_optee_dtpm_id_table,
+	.probe		= tpm_optee_dtpm_probe,
+	.remove		= tpm_optee_dtpm_remove,
+	.driver		= {
+		.name		= "optee-dtpm",
+	},
+};
+
+static int __init tpm_optee_dtpm_init(void)
+{
+	return tee_client_driver_register(&tpm_optee_dtpm_driver);
+}
+
+static void __exit tpm_optee_dtpm_exit(void)
+{
+	tee_client_driver_unregister(&tpm_optee_dtpm_driver);
+}
+
+module_init(tpm_optee_dtpm_init);
+module_exit(tpm_optee_dtpm_exit);
+
+MODULE_DESCRIPTION("OP-TEE driver for a discrete TPM");
+MODULE_LICENSE("GPL");
-- 
2.55.0


Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4128448392
	for <linux-integrity@vger.kernel.org>; Mon,  7 Sep 2026 09:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788773352; cv=none; b=mF2N4doOT80lGhex4kjHbnvky32AhY46ryrBJIaaX4EkxJnIJSsE2tgwoffGONIvIeATtNzLTgbx3JFDsSbB3LXG4A6a0uDUsGfXoR8ZrClQv8CTUtVWUCHx5vAHVVW8/fHPZ6fATkTmdtJysEbnnF91qtogBDm7udiMIb3kVs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788773352; c=relaxed/simple;
	bh=/641rSFJqk+A2coyP6IDIBjMXKeOeOTWdP93+c2wrZ0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HHW1HIWM4keAuZODtXw3sdVj28xDw1BDkOTrh+09BC+CSMuD9PzIFELxnloxcKfvZXE7bs3lnbUDyAXRcLDsmY868oD4xpL6/wWRKVwXSEIjyjw2cE0tvqIpxSwnrmCoLqJyoAD6rPGJF9zGlwZCF1ofxe6l8dPS+5jSoahJBow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mO5KZGKu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dY01fimy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mO5KZGKu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dY01fimy"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6878Rkor3872894
	for <linux-integrity@vger.kernel.org>; Mon, 7 Sep 2026 09:29:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=N+eqVYkWN7iBc+S8+D+lXg
	SWPZNjoTpe9sgjlidsNzI=; b=mO5KZGKu4bI3zscoPDDBbtjQBVNeNV4edRELmb
	LNDSRNUC+9H2x/PQbRAGl+40PqGYwovB1dcdac7oSrq4EASUCdWVz18TFJ7L9x6r
	+qN4LPTOTkEuPQUEKWOfyzoDPD0/yBn8MzFDMUbXtOVPfgYPZxeUGTtHlyWAntf6
	4AF/kMI1YPSDIwVL205+0jOaVK5IIwjvDYxcZbev0L1KIK6/+q9rjJo645OCDUJp
	ZN/TcN3o5k11I5KaeByvMAxPnwTDpiJctJtGRD2GljWqzXSBErYorTachRj+cnQQ
	q02Kwp/e3DmBXKwFkyqDZauZjsew6koIpdh7dbQvfw0Skc5Q==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghssg09uk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Mon, 07 Sep 2026 09:29:09 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-396b9ef3070so5365751a91.3
        for <linux-integrity@vger.kernel.org>; Mon, 07 Sep 2026 02:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788773349; x=1789378149; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=N+eqVYkWN7iBc+S8+D+lXgSWPZNjoTpe9sgjlidsNzI=;
        b=dY01fimyGiReU58K6rsa2CQuXOs7QucyVpLr+grwS1YHqlZTLa3mXFbfVhjAv+cDsV
         Dhv0S+mvZx0SwkPjTNpnbiuEiaKX0JBvJAqgqrUAlgFJPrD4QTQ45TxJNRKAkmdzyIMU
         B730ZvPUfsI1+r00PJjliXCX1xQAQNUw/e9/lfU0gwNFobPElpAvjhv4fH5LrV7Pfua5
         DPIl0z9mGhOdBnUeOWVl8O2rUaJuEihszXU4UF1/UXWHwgIFKigBr5MqrXeQvfogNq6P
         KDMZv5yD6YrOX3UC3kbU6enXI6GV5LbYsgfq7KjVmBWJ54U51gUl8fkgoYJpEdkMNqhB
         lpMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788773349; x=1789378149;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=N+eqVYkWN7iBc+S8+D+lXgSWPZNjoTpe9sgjlidsNzI=;
        b=OBNdt8E+YX/6/TeQB3Ijwu7ZWotgWtW3G/VyNAAAbTUqkKPVAgerNxX+FkgdgoRVLt
         g+OqPNyklOB5GKSNb2YSbtjz5QY3rG06Q+ov4D6GIk35ab0r+PBAgqdxzz4+XLNMf7EJ
         fFdjUd+ZRgUs5Gx/2K9WQqw851XFMIcj8jDaIAP2SqwgoCbUFIeO8MLMhiVj0SIVvFia
         wrvuDSPVxlBXtRhJckzO88xk/450eU6D38s7XsG2dSFDobWP0CE0jGb8/Y6xmSXe+aZe
         ogPFJVD3xHm9eRS1U8BhGti/F0bOS0VEWlGZRpxFp5tJm52AHXv5k4XCnVgOc8Q4ylOw
         V8jw==
X-Forwarded-Encrypted: i=1; AKwUvBxGjwC9yHtItjDjawIbB/70+uCc58zQNl/E/txXtCx5hCZ5RvxrgYOM6VTBkwHwSVOic3+lcixOq7+/upzP48g=@vger.kernel.org
X-Gm-Message-State: AFuF++n5XtpdXFK7gxg/OtGxrNEDtgDrmcUDyOFarKyIPAINtaApqF2i
	euoei2mTHzyeLOGOsBCyGfqI5pSTAAdMTSWBRCAfRvysyYfWrWxoMgGroXJjFQtkUsZjxpyPPxd
	eZaebupLsXyadFasfoaSC94+myvzzbbi7K7oxRxR/UeRe01YX3+YwgKFF3nY2ZzVE2x9PeZM=
X-Gm-Gg: AYBFou1nWMq/rO3g5Mux7Ozl14YLT8zYvFMnc1AQiGzKij3Us0KBCP2FFyXAfjhLJH8
	ZKjHT3b/JhFsVb3lPtTb0S71ydIvDpLMiaYha1bW+asj2MnMz0WaVfJgHOyE6uBNbFYlUvvO8c0
	QxJY9Z8u7QLRfsptWEWchrDRw71XYvcBJs+OYxIXRr1P/OtCv88TdcTYHx056YOa/6BiiesrR07
	cNEph+aIfJs6runPz2hxJhCnkIzdgn4i5fAHPEI9LLI3LqH+g1tRQBLblYZS2/rWDeWt0N8o49V
	raVj/GwIWdUeHX387ZB5JBJsQbBgYGj5URT/QjP9hywpxTk8+6+jgL++JTyzqK2iuVHEU8G345r
	cU3ZVFJC+GyWlIyQGJwdKb6sSIlIOz6JJIA==
X-Received: by 2002:a17:90a:e7cb:b0:398:9bd4:d12 with SMTP id 98e67ed59e1d1-39b2624a3famr31843220a91.17.1788773348786;
        Mon, 07 Sep 2026 02:29:08 -0700 (PDT)
X-Received: by 2002:a17:90a:e7cb:b0:398:9bd4:d12 with SMTP id 98e67ed59e1d1-39b2624a3famr31843165a91.17.1788773348325;
        Mon, 07 Sep 2026 02:29:08 -0700 (PDT)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-338778fb926sm1627830eec.31.2026.09.07.02.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 02:29:07 -0700 (PDT)
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Subject: [PATCH v2 0/3] Add TPM support via Qualcomm TEE TPM TA
Date: Mon, 07 Sep 2026 14:58:40 +0530
Message-Id: <20260907-tpm_qcom_driver-v2-0-71a6b1752da8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMmDnmoC/3WQSW7DMAxFr2JoXQWaIg+r3KMIDA1UoqKObUkWW
 gS+e2WlQFfdkPgg+R/JJ4oQPEQ0NE8UIPvo50cR7K1B5q4eN8DeFo0YYZJ0nOK0TONq5mm0wWc
 I2DJqWkag5ZqhMrUEcP6rOr5fXzpu+gNMOmx+OwKsW0GlV9sfqYAPjiAdroyteEUwalnGyd+CS
 lDZCQBT3sneijMQKoZc0VpFwKU8+TQ0joPknNjWgWCaEaEcOStmtZGd5m0PRFlaEjqWvPuY5vB
 dv5Bp3enfgzPFBEtHpVOyZ8Kpyxzjad3U54E+lYCu+77/AOPQhoFaAQAA
X-Change-ID: 20260831-tpm_qcom_driver-d21c720e73b2
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDEwMyBTYWx0ZWRfX+qdXCjTrn0k4
 X8FMngQ47lJmzhyayIiov4NqifjLUApRGjUZ6tdLBSZXtTBZ3rj6wXmA9JBtQnXkffRC1Tg2VSH
 ZB5LxpABbvpij10kgJiGqOwC1HYNk7XqYKN6xR7YPbf70jDi8nAs9x/M7WbsxyRH7nyKDJ+D1da
 rUa9xOlil4NrhBfUNCUtxm/taJe9PUYAuMOwVtS2WB7o5aN+SBXSqeh59pvcaszYoYkGTSblWoU
 NDOEYOxgfF5hnVRoy/X7WPXsTOZtJwxUOgbihNagVd21wiZDUnO1uNb9USow90EQgUQKkQr67xX
 KqxCsLIjdonBTg+Bmbz2btJDxZOe9yPktqfwxCHo8lziSOqsirBkUcVB0Oj0VQxzWuMamCPImXG
 cn7zNEvmEgEFDx8720VzDLrju1leUK7dKjnnA3YFMdPmTBJbYW6ZEcz1eTiGDOAwRD5/AcyBH/U
 Hhb2s+e6KdwePRWS3Dw==
X-Authority-Analysis: v=2.4 cv=MrJiLWae c=1 sm=1 tr=0 ts=6a9e83e5 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=bC-a23v3AAAA:8 a=9jRdOu3wAAAA:8
 a=b45o4kL6AAAA:8 a=-uCDDUUr1LpqqybkBuUA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=FO4_E8m0qiDe52t0p3_H:22 a=ZE6KLimJVUuLrTuGpvhn:22
 a=dhdsR-PFWuPJUldTnwXm:22
X-Proofpoint-ORIG-GUID: wt6fhC_vcf77cNhg9h_wlO2aE99YhAiu
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDEwMyBTYWx0ZWRfXzYDWjDAGnt59
 eL6YsY+AG8tfzqWgrplfHBygocy3pzRCl5wZrnI88kykhBjBJxtyo3GeLdQcKSnpZavVO2kBarQ
 JrZ0bKT65N5JH2V4ZHRackNsNZQK+aI=
X-Proofpoint-GUID: wt6fhC_vcf77cNhg9h_wlO2aE99YhAiu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 suspectscore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609070103

Qualcomm platforms with a discrete TPM (dTPM) talked to it directly over
a non-secure SPI channel from the kernel. Arm's Base Boot Security
Requirements (BBSR) v1.4 require that access to go through TrustZone
instead, so on affected Qualcomm platforms the TPM 2.0 instance is now
fronted by a Trusted Application (TA) running inside Qualcomm's Trusted
Execution Environment (QTEE), which talks to the dTPM (or implements an
fTPM) on the kernel's behalf.

This series adds a kernel driver for that TA, built on the QCOMTEE
object-IPC transport (drivers/tee/qcomtee/) already used to reach other
QTEE services.

This patch series functionally depends on below(patch 5/6 specifically)
for qtee service discovery.
- https://lore.kernel.org/lkml/20260722-qcom_uefisecapp_migrate_qcomtee-v2-0-b8a8fcbe4211@oss.qualcomm.com/

Tested on Glymur-crd target with tpm2-tools utility.

Validations:
- Get capabilities
- Random number generator
- RSA key creation, encryption and decryption.

Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
---
Changes in v2:
- Use QCOMTEE_TPM_UID as 81 for service discovery in patch 1.
- Use FIELD_GET, zero initialised array and log improvement (Konrad)
- Improve commit title and other fixes (Jarkko)
- Split MAINTAINERS entry as separate patch.
- Link to v1: https://patch.msgid.link/20260831-tpm_qcom_driver-v1-0-6f16fa6924fa@oss.qualcomm.com

To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
To: Jens Wiklander <jenswi@kernel.org>
To: Sumit Garg <sumit.garg@kernel.org>
To: Peter Huewe <peterhuewe@gmx.de>
To: Jarkko Sakkinen <jarkko@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org
Cc: op-tee@lists.trustedfirmware.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-integrity@vger.kernel.org

---
Kuldeep Singh (3):
      tee: qcomtee: Register qcom.tz.tpm service for discovery
      tpm: Introduce Qualcomm TPM driver
      MAINTAINERS: Add Qualcomm TPM driver entry

 MAINTAINERS                       |   7 +
 drivers/char/tpm/Kconfig          |   9 +
 drivers/char/tpm/Makefile         |   1 +
 drivers/char/tpm/tpm_qcom.c       | 354 ++++++++++++++++++++++++++++++++++++++
 drivers/char/tpm/tpm_qcom.h       |  83 +++++++++
 drivers/tee/qcomtee/call.c        |   4 +-
 drivers/tee/qcomtee/qcomtee_msg.h |   2 +
 7 files changed, 459 insertions(+), 1 deletion(-)
---
base-commit: f3e6330d7fe42b204af05a2dbc68b379e0ad179e
change-id: 20260831-tpm_qcom_driver-d21c720e73b2
prerequisite-change-id: 20260408-qcom_uefisecapp_migrate_qcomtee-13869d45e014:v2
prerequisite-patch-id: 4dc81445c9baf36f420da8c2e2bed96e71b31a5b
prerequisite-patch-id: b487dfe2fbc076f4815dc6c73b9e68b0b78c961f
prerequisite-patch-id: c5df2b3696520a96f95b2d3535ed84cdc21cc315
prerequisite-patch-id: bbdd5327c15aeaa99ce9b74bab324a98f084ed48
prerequisite-patch-id: 07d9c4e9fe9fd61f60e3f35b30b9d81716f0734c
prerequisite-patch-id: 10ff88d87586f21f3cff3f72dbd21c27adbfbbcc

Best regards,
--  
Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>


Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762E849D595
	for <linux-integrity@vger.kernel.org>; Mon, 19 Oct 2026 09:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792401739; cv=none; b=NkOzRsMTe9MPcBeHu/YtktkRAAebIuIe16xDKpLgaQyA2xQtsKjJtBLQcdjadc0DScELv0KiC5D19XI/nM1LfFbMX4YdrH2TFlZ8cPlCCZ8HzbrR6fmuh72MvraqvFDpocpGFJrqwSNFPa6985yGTny+sdrqU+NwxABRP7M+UXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792401739; c=relaxed/simple;
	bh=sZfaHMM3n5qSlA534Y36U/L686G77F0urff/+V3Q0fA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bNFRsRK/1DwRWVvoOPtiNf8rdBYuimgTT/ZfbIqR3cHYx9BnyCWkBz6In3JXh3XxOeU3wiCJKiuhKmZ3Iz63Z4ZhZXIJcY05XqatLlbqgfvBNNTH5ROZJCak6KLHc/17X8e1mZAXJTuBbTJlNYX0FTZyasWcQwBjq8mX3p6wy7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WN1XRgXR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MLXkZtzZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WN1XRgXR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MLXkZtzZ"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J8OuFg2752281
	for <linux-integrity@vger.kernel.org>; Mon, 19 Oct 2026 09:22:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=6Dvi7s/V+FGzGTPgCS3Pqm
	rFxqHvRCvEqGteKv+AEng=; b=WN1XRgXR+1Zrz1gF1B+0zHkKHb7cbWLXtdiXCy
	wQvR383uO5sTAdbmMHwL7fEzs9HWsaob1vmtsH36L/Ncjof4URqknsMyb5jqT22q
	zciX/HSpeiIi3S6lM9AQXJhfovcbcDzhNffa2cWs0PM5hYYDx0QyKm2jp3hiKFMO
	ey2ma+nTi7+vfd8TmvuyxwXEJsagsMum8ksOnSUy3ml9BLN9H5mFsNp0HMGTFu0N
	/cs4U5xXLqQ26uFcEEuZKfw7jJBL+ln29QUZ1GTXNcc+7ZvzBtbJ2P77fgK5Yxl9
	JiSMS/k8aRZU16IT6aFAn1ZKSQY80qHS9Vr4B7jb8yAScSxA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf48gbr9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Mon, 19 Oct 2026 09:22:17 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-341eff9e381so6007591eec.1
        for <linux-integrity@vger.kernel.org>; Mon, 19 Oct 2026 02:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792401736; x=1793006536; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6Dvi7s/V+FGzGTPgCS3PqmrFxqHvRCvEqGteKv+AEng=;
        b=MLXkZtzZWPxKYUsovdmXwtryqb5LXQCFc/0e/3SYKqvswLJquxhwBXPxVCodyBHAwX
         tXl7eNA+dkZxkJDi68Bh6eiQMECqyFoiMN9W1NpAJM9LOkI/7C7zg1MtMfNLTFmXpVdq
         qfqIgzItZV/2KAhm+hRMEwcd0o3x6egS9qTnWxH+cEzX3iqq9qqyq60PUGzz5WKc5NuP
         qhHVMTf7MHy2SkgkMguwS01H6iLJz8AEeI2TfM3afdlNKZ7DLLn6zBDOQZAN4amsqrWx
         QX4QzLhZ5lEPPBIKfUgq/M66R+sv8Q1dVTogUat+bPOF8qFt297jMHhNmrPpRXkTrMPU
         Sqrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792401736; x=1793006536;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6Dvi7s/V+FGzGTPgCS3PqmrFxqHvRCvEqGteKv+AEng=;
        b=GW+vFigVN8JWqYgpaPNYgi5Do0jK2vE9mCZ1GxWmKM8RWR3YvxeUHAFUyasVJC+Q74
         GcdybX+7pRlHZCVCZ7Ikx0HYDepqfcFdQeOAj/AktTgcq6EIXXNCBP6fT6SC6CRdqZNe
         iOfYCMlM5EpIltHZgnzk3e2IA9dHskGFzI0txjQGOuJkUqI+4YG9tfAuj9nBb4KAabJK
         80uvyQHLFaFzp4N4uvy7QtcUz/USzJF9pfSjJGULOgYB+/Th5nayBouvvO99Fa3UFBQ/
         h9tf49ubJgdFkbxfzdvgp+g2EKDC6s2tvzSvgubh/h0AgfmihJK952EqSNJMaIP/Pm5s
         0UHA==
X-Forwarded-Encrypted: i=1; AKwUvBx4G9zbLuJEJA9Izl7Oq5EqFctd++zeWLooZMkCbt2gFs79XU1dOZ7tniaFZIYgWki4OLQM74z58XqnJ6qa9as=@vger.kernel.org
X-Gm-Message-State: AFq9FYLw5Xy/7VecK4s9nrYjDTtNWNt4mUN+Cwe1xEL4PJh0kHJ0/ry6
	Zg/+PnutNTXuaUO3N60WX7FXJvtk685ksFi6d7zXlX8o43ehYY+4wamlZuGKPzROTRfA+QinXCz
	IwM2wpuSxHUiuJFUvg7E8dapPWYchmQD+yiJo7v9iUxFX/BtjjrSnOpcaavAyYUP66YuzagA=
X-Gm-Gg: AYBFou2bcX7XCGhbM9zCx0dyt/Zre89lFs2cuadJUCSIp3BvEUOxtPLWNVRaLveig58
	BBz1kSO59eU3mlLNGWmCMDwwKOAois5Q4opHuYfB70zP0XmT7aovCKg5ln1MFJGgpIRgSlbxAVH
	BNnpZm6HE3PMHvS6lpoSZNWv1SnJnGAVnw3n+Qa5ZvpZLozoeNHcMd8JOtvlrl4BH3VFURraT5h
	1vaXuW6ZypZQGPxpZyXp1HfB2w9jNN4IyRT7h6CSRTX9kgQSc6zAOeWHXEGjtIUwVhBznymb9wA
	KqPpxLVPHmf9fF83Q7OZqKgoN2uS5DLiyWiXzJTzSp9k0DUeGA5RmRusecS4CSgEmnjnGyJlPMO
	XSzkM9LCeqNCxlZbqJoZUi/o5FIm7//i1
X-Received: by 2002:a05:693c:6311:b0:360:73dc:1e13 with SMTP id 5a478bee46e88-361a196004cmr11484997eec.17.1792401735972;
        Mon, 19 Oct 2026 02:22:15 -0700 (PDT)
X-Received: by 2002:a05:693c:6311:b0:360:73dc:1e13 with SMTP id 5a478bee46e88-361a196004cmr11484921eec.17.1792401734445;
        Mon, 19 Oct 2026 02:22:14 -0700 (PDT)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36082a7b33bsm56225094eec.24.2026.10.19.02.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 02:22:13 -0700 (PDT)
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Subject: [PATCH v4 0/3] Add TPM support via Qualcomm TEE TPM TA
Date: Mon, 19 Oct 2026 14:51:45 +0530
Message-Id: <20261019-tpm_qcom_driver-v4-0-6889b9804ba7@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACvh1WoC/3XQUWvDIBAH8K9SfJ5FL0ZNn/o9yijGnK1jaRI1Y
 aP0u8/YscJKX4TD8/e/80oiBo+R7DZXEnDx0Q+XXIi3DbFnczkh9V2uCTCQTFecprE/Tnboj13
 wCwbaAbcKGKqqBZJfjQGd/yri4f1ex7n9QJtW5rcj4DTnqHRveyTtNiVHME1LxpytiNaM47H3p
 2ASluyESHmlZdOJGhkXu6Ve4dZEpPm69ylD6FplOHfcGNFBZ0HXDkFqZq0BsG3jFDgpyDrk2cc
 0hO/yCwsvM71ceOGUUem4dEY2IJzZDzFup9l8rtHbfBRygQfTMPXMQGYUN7LlqobO6BdM9cdwx
 utnpsoMCGU11gxqhvsp+X/M7Xb7AeMikvPoAQAA
X-Change-ID: 20260831-tpm_qcom_driver-d21c720e73b2
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAzNyBTYWx0ZWRfX4Pz9hEbY+GFS
 pCv6kKKEFHavVwkQYr095NU4IC7YqFO/Y9B2W2XYuCJAHGySDWouaW9DZH+zC6tgDlxYdiiHB71
 GrL0CmZxQ6TMEH2uZK9h1MfiWh5Ut34XWZ8gQZGuZGFHcIj449pg3GETtUpG5Y5jOX23PAoShcB
 fKLwQMNyCaZT9HHy1VL1gpBlXcTJaxl512ZfQWJUVqT03oOjLk5yzcy2rkqLcgJ3+Vx6jdGvkZ2
 smqEggDS15/BstyUynBVRYmEFu72tkjNKyv1ED82HL6avkXxv3P1X4deQjN1mFVFT1aa18Wg/6a
 V09dAmOEFdCJLsYFLEmju3RNstcfN+y21ID+CyMLyHSA9Cs6CqTN9WqInQh1lY+91WWMbOpxIql
 mcVzrsR3KxXz2MZChsWfSCdoESzNbscpm/o/tym8krZagEp/9ExRQSHxIZU+MOBu8ynnf++wRj6
 k6zyWu4l2K1CpjhMNog==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAzNyBTYWx0ZWRfX7OjUrkpIQCBJ
 +sI+NtGdp07BAaLeMpaQb7WcIdD64ugTdTsV709uG9SH/kOITEW2TFAn20uueyBVfKTDm/ov5nS
 QJxwKecZmKdYkT3gRwXo16Ul5rxKey8=
X-Proofpoint-ORIG-GUID: 9rHQEIg8PlhZ2nvLAc9pxAW1jWNTYJDN
X-Authority-Analysis: v=2.4 cv=Qr/LTlyd c=1 sm=1 tr=0 ts=6ad5e149 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=bC-a23v3AAAA:8 a=9jRdOu3wAAAA:8
 a=b45o4kL6AAAA:8 a=xG2GeFPYwsRGK1jMldgA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22 a=FO4_E8m0qiDe52t0p3_H:22 a=ZE6KLimJVUuLrTuGpvhn:22
 a=dhdsR-PFWuPJUldTnwXm:22
X-Proofpoint-GUID: 9rHQEIg8PlhZ2nvLAc9pxAW1jWNTYJDN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 impostorscore=0 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190037

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

This patch series functionally depends on below(first 5 changes specially)
for qtee service discovery.
- https://lore.kernel.org/lkml/20261015-qcom_uefisecapp_migrate_qcomtee-v5-0-1460691b35d3@oss.qualcomm.com/

Tested on Glymur-crd target with tpm2-tools utility.

Validations:
- Get capabilities
- Random number generator
- RSA key creation, encryption and decryption.

Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
---
Changes in v4:
- Add new line before goto label(Jarkko).
- Link to v3: https://patch.msgid.link/20261015-tpm_qcom_driver-v3-0-247c8e50250e@qti.qualcomm.com

Changes in v3:
- Merge tpm_qcom.h into tpm_qcom.c(Amir comments)
- Update return values of functions and drop certain error prints.
- Define locality_arg as default value.
- Add Jarkko's tag on all but drop from 2/3 as significant changes done.
- Link to v2: https://patch.msgid.link/20260907-tpm_qcom_driver-v2-0-71a6b1752da8@oss.qualcomm.com

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

 MAINTAINERS                       |   6 +
 drivers/char/tpm/Kconfig          |   9 +
 drivers/char/tpm/Makefile         |   1 +
 drivers/char/tpm/tpm_qcom.c       | 414 ++++++++++++++++++++++++++++++++++++++
 drivers/tee/qcomtee/call.c        |   4 +-
 drivers/tee/qcomtee/qcomtee_msg.h |   2 +
 6 files changed, 435 insertions(+), 1 deletion(-)
---
base-commit: 2efb7a11f1aa4d2dc285fe2680cca22cb9f72f64
change-id: 20260831-tpm_qcom_driver-d21c720e73b2
prerequisite-change-id: 20260408-qcom_uefisecapp_migrate_qcomtee-13869d45e014:v5
prerequisite-patch-id: faf4520d818abf0d7533f71d9c8b9a8aade34626
prerequisite-patch-id: b487dfe2fbc076f4815dc6c73b9e68b0b78c961f
prerequisite-patch-id: 9f2c4ee37ba173bdc860f253d44974379f2cf125
prerequisite-patch-id: e86905ac6289821db30fd9a17f73e276e0a88363
prerequisite-patch-id: 8777bfa2ef8344715bf972d049acb0a6ef49b136
prerequisite-patch-id: 1c7f946e770a1cbc1599f9571282c9265a6af9cd
prerequisite-patch-id: 7be993abea2ca36057d9352381a5890f50996dda

Best regards,
--  
Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>


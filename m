Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964483DFC74
	for <linux-integrity@vger.kernel.org>; Mon, 31 Aug 2026 09:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788169405; cv=none; b=fCZeEiA8UJFwM/JEhr2Yb7rD9Rh04mdtdO+VumU6Z+6CPXsGB28xXG0RAhDGhhyH106P4QagwN0UsF6+OI2yDcJxX7ci+/l4PaUTGiFhX6CrWiie409VgWAwkHta8gBV+nOU/DwQmpsOSGZ7gDQLl9WneS3kiCYPSVaTrb3mAv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788169405; c=relaxed/simple;
	bh=Uz8K52ckdSGPXQ7DIRli6aJZfuZvAmohNlhPwXu3mR8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TSs0kC42jP7ghfyk0F57tc2soeFeNf8EF2F5pg93lsYS1XmPRxUb0dZdSn6LsAcPKzIFX2uqJrlhIrpPYBtjFo0oiDBXGPxb262+u9YaoS56ykp1F52pnzToAefI0blDd7R2D5D2pcSZxC06qwCyDIOSXHcHtr60I+9n2GJO5xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jCNrJKHq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JIt93nLc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jCNrJKHq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JIt93nLc"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V9Ip2b2516682
	for <linux-integrity@vger.kernel.org>; Mon, 31 Aug 2026 09:43:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=R8skzQrcTOFob5OgyU8esN
	NdOJgcF5QRwXdZN6hrzvQ=; b=jCNrJKHqSFy/sVcK+6sqY1TgMZwmOnm/8N3x7e
	LF0D5eWUi5Ca3eRaTQN2bSdKPpaA0J6FD+0LXK3FMMHqchLXP9deRKWjvMdGwRJ0
	OcVlXeYFyH+mqJj558h0Fk58vLC49/P5kpMRn3qOOxZRrmQkN3+ksQA2Gx+kTFiZ
	PwIQmcBiz1FkrXoWsSN/1qWvFlAYVTWww/biv6geJzucRyuMJKmK5wja9m+RV0Cs
	eUExGzQDmOBxkpAw0SxqKs2wFJvvoNY/7zyz4snyLpBTLb+BVs15tXPfVAVhEsww
	dGO4ScAej5p1cU4guswFJqimMwlz5/DWbj9GZNw2QrhBA3YA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd6vcr35x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Mon, 31 Aug 2026 09:43:22 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e1118e4abso6060785a91.0
        for <linux-integrity@vger.kernel.org>; Mon, 31 Aug 2026 02:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788169402; x=1788774202; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=R8skzQrcTOFob5OgyU8esNNdOJgcF5QRwXdZN6hrzvQ=;
        b=JIt93nLcSWgLvowHi9kL1W6NLA5ubsHmiPobqYzWLbolX7ku0WWTSNaHK2e9hFuFAx
         9sC+If7PvzgpMy4534acTqBEXUGqPEUxWvRrK9rdssIeJffTnHEp3fk3oVIp180rM/x6
         ad7Z+Z3gHH7HnU8Zngc8YRpd+YJNm38T6zf+jGabb1X9uBT/UKF96o6xCGepTaoRfmoy
         udX9F4C6UmNnrtn74eEYC4WfPFbXNBELCFcx0MeRjn/dVx8q8O97mpqP2tNmXR93kRB6
         xG4YFkKNzCycyl0FMAweI/4f1Ot884RNKbuy33QYXylTTa+ZbECBRu5BVgeF5mpl5AvX
         o6Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788169402; x=1788774202;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=R8skzQrcTOFob5OgyU8esNNdOJgcF5QRwXdZN6hrzvQ=;
        b=Wm0fOtlu9HS35NzonZCU2aw4imHYefmiN6bTnXpBhK99ebz8IxyFG93CwKmVLnZByL
         X4zpwNTeEWWq89XCU7601X7PA9V3ngcttmmynoCm0UwXhwqAyfqtTGaM8s8/7QmSYsl+
         QxCkDytpuivsimSHBs2WAd2RZsBP89kI1CFQ/mibvp1UVPBCcwI6SOA+gFwHxMmc5VUU
         pzIrCZGpeDm+zP6TJN5dxUYzFFbLR5ObGwHzAl4QVoarTVH4BC3LXK31rXaM8Wh2/LVX
         Pr6qfT4IGBNDx3/nLJVH9hwUmmT5YnKpz+Qjv8I2JTni/vNJJwNAhYsmu/NXCGSy5jgt
         m7Xg==
X-Forwarded-Encrypted: i=1; AKwUvBwWUaDrWYa27B1J9dTeL0Ojqc5RUvbQgHAXfn5l1lg28eEZ5C5d5yBzLanzkVwjNBwk4EjrXO1f9MmcLY7MGfk=@vger.kernel.org
X-Gm-Message-State: AFuF++moDnaeSFzXG7+mQPLml5XEhgeAidyt2yBB6o2UA2B6SfOejRnw
	VCjAEZ3ImmShiIrhC8xaB6PAaRBMHgd/nw30FNTJCrLdYIyxMgX+eXcRXmJ2529M6Rc0qbA8py8
	EOca5CxOMPCUhyUtZTzAWoPuGP2cfVzj00IjgY/c3wEa+F9HURmtmHgMTEggRH4cdBQOFGLU=
X-Gm-Gg: AYBFou1JNvPIgyB7KVtPrVaxcawMYrW3uN1+fyGMSpK4PaDfmwjlFPa+QtH1EqxlFsr
	xkYkrO6kgTWZwpu5Zs2aXpx9EGV540AyAKtuZEsp+nd92siRYzSkcyuaVxORxdPra509EE4AqWd
	ZZbPp2JNwmCMYCinS01dS5kI+9mYixbJjSSZU/JdEuFx9bG0LbARNzxKspdgM1c+z9YArZbDrMF
	uFdFuPCNzPHo1o47T3b7n8MytClniASJ0ibA+F8mVPVgy845jUaROlBfhIcDFWPCEEo4bF71osB
	1y7A73L9jGIsSgZ09btAhX0JOY5ZfgGlOGWN+jCaQLpvLmA5Brmy8XRONyOwaIylztCGGD4Qoz2
	f5LqtzuD4zS3Uz/V6cq6+BZA9ohfRP9hYSg==
X-Received: by 2002:a17:90b:5443:b0:396:4cbf:45bc with SMTP id 98e67ed59e1d1-396d100313fmr38943817a91.16.1788169401976;
        Mon, 31 Aug 2026 02:43:21 -0700 (PDT)
X-Received: by 2002:a17:90b:5443:b0:396:4cbf:45bc with SMTP id 98e67ed59e1d1-396d100313fmr38943775a91.16.1788169401471;
        Mon, 31 Aug 2026 02:43:21 -0700 (PDT)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0bf8a13sm40782983c88.0.2026.08.31.02.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 02:43:21 -0700 (PDT)
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Subject: [PATCH 0/2] Add TPM support via Qualcomm TEE TPM TA
Date: Mon, 31 Aug 2026 15:12:59 +0530
Message-Id: <20260831-tpm_qcom_driver-v1-0-6f16fa6924fa@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKRMlWoC/0WN26rCMBREf6Xk+QR2Lra1vyJScplqDlRrkhZB/
 HdjFHzaLPbMrAdLiAGJDc2DRWwhheulgPhrmDubywk8+MJMkmypV4LnZR5v7jqPPoYNkXspXCc
 JnbKSldYSMYV7XTwcP5xW+w+X3zPfRMRtLar8if1MQ1M9mnpeHWvZSnBmWcY5nKLJqO4McKH6d
 u/1DiT0sFW1NQm8vOeQh2ZSaJUi303Q0krSZqKdkd66treq24OMF+Ww4/P5AksywzAGAQAA
X-Change-ID: 20260831-tpm_qcom_driver-d21c720e73b2
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA4MyBTYWx0ZWRfX8jglKYxqff0R
 54nFvk7cTynaLaU3xX5Va9BFyEW41db2LPwh2Cc7cDMNk8Yfq4dxZKXXZX/baYcc77jvUA/Uoi7
 hJOPkGS+5yLDzopccGQJ52cS5EiW+XPejLW5npyO4T1ZhdFCe6sj25jZ7BEtjJFH2oQ0yIhP5wr
 uwb1+DgZQU146JGyepktyXSYevEcCusmGEleLVtATq/aGjcDJSPRMwS4vKmbMVuA6iHCezoyhQB
 C9WzVb1dET7q2YY5evq7kg9BB8cuSQ9MPU8XLrG1jy3skhwGAmfybMY/KI8jsCmNriGE7HrGuIY
 QaLQ+eHvC2lxDzYJHBp9b6S5wxuZUSy9yvsQq7nNTzK6vWAYyjp17PlgnFYeuHjNkmtHwLQKi+M
 UyAwFale11eo+TN1rPZahrAVwkuLClNvWNcRbNPypW6+vPLuiPDaqYbjAITJeQZbljjtNyNadCd
 9UL+H1aUXucK2eSj/Bg==
X-Proofpoint-GUID: JHoE21qJmUPifGq1XZeZtVe_YhStz5cm
X-Proofpoint-ORIG-GUID: JHoE21qJmUPifGq1XZeZtVe_YhStz5cm
X-Authority-Analysis: v=2.4 cv=Eo7iaycA c=1 sm=1 tr=0 ts=6a954cba cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=EAapQlX8VUJyPtJC71QA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA4MyBTYWx0ZWRfX0/dXEUzgOWpJ
 V6Zd07Jbr2ZVjpBZd/N5GuHZOW8BtbFLRXkRiHEGCaKs6lBqpQv0DOf38cZNzFltlVBiKhGgA2f
 jXpuEVjYvQjQ4P+rRO2PxmUfD81y7fA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0
 suspectscore=0 phishscore=0 clxscore=1011 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310083

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
Kuldeep Singh (2):
      tee: qcomtee: Register qcom.tz.tpm service for discovery
      firmware: tpm: Introduce tpm-qcom driver

 MAINTAINERS                       |   7 +
 drivers/char/tpm/Kconfig          |   9 +
 drivers/char/tpm/Makefile         |   1 +
 drivers/char/tpm/tpm_qcom.c       | 371 ++++++++++++++++++++++++++++++++++++++
 drivers/char/tpm/tpm_qcom.h       |  82 +++++++++
 drivers/tee/qcomtee/call.c        |   4 +-
 drivers/tee/qcomtee/qcomtee_msg.h |   2 +
 7 files changed, 475 insertions(+), 1 deletion(-)
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


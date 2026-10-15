Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE1B414428
	for <linux-integrity@vger.kernel.org>; Thu, 15 Oct 2026 06:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792046299; cv=none; b=Ljn/lqNQJPmXGBqTfLnX2zuut1Oqvljb5ybtUX+fn38a0QMnapN3lUmNOKnVO9lJ3P72+uK/RyaclX9Zx2W18XXHO/w5F4lIepZa19FBwW6aUyj++EQXAgFUcbALZDpkUN3IueoaTTj9jUv+Didat1q9nIlzPISCvbkL4IRq4vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792046299; c=relaxed/simple;
	bh=M0bO5pV7rOWhaoU6+z7kLmEATwugnVvfR+Tk3mM83CU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=A2xPlHWidOWA89QlAdlX7MhUhzJoXx9OUSrvjz6g5l01njQ58SbiMP35VP4c4zc1DJL40RsPiPZLUPLBTArrAAVY8+6HV43PCRb6i12bTdC1235OLAzDrTcC5Uf6Zpuf/2iDqF1PZoslg0W1Ktj1KfJ5OUqXaVIjEiQquKeAdjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=giRqNbQJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Z9OGCEqi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="giRqNbQJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z9OGCEqi"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F1UhkB3468832
	for <linux-integrity@vger.kernel.org>; Thu, 15 Oct 2026 06:38:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=1gwU0tcX13myESEjxMHLTQ
	2r/QSifosTvZ0kTue5VFs=; b=giRqNbQJYawxS/9sjUldbIgXPHx5WjkeK2pjT9
	EKxIer3TV65dvlPftDAG9DzN8PxjrUWphhzBbPzmJewRC1vCWI4RyNXfC/iwC/4B
	x0UoLVdoxw4K3XZDL0TFTLdPt1Jmsixn23tNNEqZLlceS3LdiU5P4IAS71ZJhlkh
	zV5VuW8b3BWePQdthn7RnOXLsJ5nAPDMVHqkxXoE/s9Vn49xViuMvOAvAWhK7il/
	XzdxEqF1qI4dZ/KStJqIaw+45m+EuQmReGFAeVQccB2xPgfRZTibz3gDL1+WsRyt
	gDif+omN/9CFuZJLqTugqCavNFySaE7L2Ymi3rfx0vLOkNqw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hadd7asas-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Thu, 15 Oct 2026 06:38:17 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d02df2bf09so41122735ad.0
        for <linux-integrity@vger.kernel.org>; Wed, 14 Oct 2026 23:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792046297; x=1792651097; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1gwU0tcX13myESEjxMHLTQ2r/QSifosTvZ0kTue5VFs=;
        b=Z9OGCEqiOjoas2PrkSqxfx19cl/bSy/i4S3bBx+cn3JZi1lVb/H1oOb/ywEUTJQsXl
         35BGjhvZPXagM761L0u7ymQxROSh1YuEDBQ8K8YnZEUxBFKyAU6usiBV0+jqL9w4upBA
         PcWUAejJW2cDQ7opz62OHULN37HvRC/aPOAiRJSS+ebQNaW9pfscsBtHgL+sGIo6pvNZ
         PujtpI+vFPQ9+V4yz8fwCIvuvLhv07imauOT4PUhe+wA5Uhu6cot5uwm9abnxQIBWtyM
         Pon9J3R7bfF/hCGYTvuV3W11W1n6jwmBXBbi+FA1fotf5byPEhZazjOkUieoHX8xsBUJ
         4UQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792046297; x=1792651097;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1gwU0tcX13myESEjxMHLTQ2r/QSifosTvZ0kTue5VFs=;
        b=mrh+MfrHArUc5DNKhnE2ex5VAoFA4hegiuRt5PZJ3bUQVIZdksy7M12YQ32SvNaNXA
         iGbL7tYTFFQSZzs7UGOHoeS1AEtmiMbHt0WnVDfgevWRZ2nseuqgtDs8KDhuGuShs677
         kOKYYqCiv/J6Sw1kaF+eWp0KoN2mCNenk+67dzBD1q98USvM6fVLg69EQjgBEAnVmC4C
         0RVKZ13RElYEFeD0rYNNRiIfWauZpuiFUhfGQFTHP0yv6A5ncW5HP4LkHuCNW7muLBDr
         mG8/J4pNiri/2SKeUGqVGmf5ZbUrFcbRA+rkbjTPiBPPCPSCbxBBxIvXWiyU0XAHlXmT
         5qIg==
X-Forwarded-Encrypted: i=1; AKwUvBxWk7pqshOzreo/cUKUi1mWKr2k/3646Kzn1XaEfvKlDp2KZDsTiAGNshJPdw4WzbbzfRBE6PZpo6MsWAMEw6c=@vger.kernel.org
X-Gm-Message-State: AFq9FYLd4N+Pv1CWBKk38N4erpuYjo1OTdAkFEq1ozsIV0KdpMQokuXh
	zFgXZd4hMp9T6s22qNQkY5+j1j3H9QCMGrbEfYvD+bEzjGRjgNZPfzc4a9gm+ApF79Zl11tN8nU
	Hl2dVV4e1zMNqp7dYInX52rGjoM5IOoQpFJokNYdTYowiRodsNwZZGgHyvnJGmG6gdjutE57xSB
	mnxwk=
X-Gm-Gg: AYBFou3jogYvZC8degJBJl592sLDvxhRUJoWjt0+ElfvhmVBECa613+RSysln2nrO5l
	fm3s8Y13yd5sqwS8IpBXpSUr45LbuDcBkX2w81dR8uWHefSRXE6XYp1gt9k8wIEq8Qkfp7lbvDm
	MJj1lmF8sVbSWW/Lv0PtU7s7qzp7StPwbfi6cftrcq9ODBxtzgzO12cE8pVDEzhcVcLvPK4LiWk
	MASnvKRDyOfxVGtZ7l+x3Ndwa6zP7+6Pylw1r0W87jMWVzaC1TL1BiswVwJZ9RaG/+q/xlII5z/
	7pkq++uJYalbbouqJ5+HmVGvBYxdUXtMtGk1cLofZl9g4cgjznY4PVUPnmtqxeEwCvzAGPN9pmm
	xbOMCKlRAYU7036g1JzjHS4qZqg5ibAf1
X-Received: by 2002:a17:90a:d44d:b0:3aa:f4af:1e17 with SMTP id 98e67ed59e1d1-3ab3a9d6d17mr13213370a91.39.1792046296604;
        Wed, 14 Oct 2026 23:38:16 -0700 (PDT)
X-Received: by 2002:a17:90a:d44d:b0:3aa:f4af:1e17 with SMTP id 98e67ed59e1d1-3ab3a9d6d17mr13213353a91.39.1792046296059;
        Wed, 14 Oct 2026 23:38:16 -0700 (PDT)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac93ff4474sm2844429a91.0.2026.10.14.23.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 23:38:15 -0700 (PDT)
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Subject: [PATCH v3 0/3] Add TPM support via Qualcomm TEE TPM TA
Date: Thu, 15 Oct 2026 12:07:45 +0530
Message-Id: <20261015-tpm_qcom_driver-v3-0-247c8e50250e@qti.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALt00GoC/3WQwW7DIAyGXyXiPCowBEhOfY9pqkhwWqalSYBEm
 6q++wid1MO2C9Iv7O+zfSMRg8dI2upGAm4++umag3ipSH+x1zNS73ImwEAxIzhN83ha+mk8ueA
 3DNQB7zUw1KIDkrvmgIP/LMTXt0eOa/eOfdoxPxUBlzWr0qPsaWqr4pHM0OJYMytib+f5NPpzs
 AmLOyFSLoxqnKyRcdlucgd3NiLN36NPbeUkb5wyALV2hotB9Z22YFBCJ2rH0A3SOiYM2Ye8+Ji
 m8FWusPEy078Lb5wyqgauBqsakIM9TjEeltV+7OpDfgpygyemYfo3BjJGc6s6rmtw1vyBud/v3
 57Rln+hAQAA
X-Change-ID: 20260831-tpm_qcom_driver-d21c720e73b2
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
X-Mailer: b4 0.15.2
X-Authority-Analysis: v=2.4 cv=BaVNQbt2 c=1 sm=1 tr=0 ts=6ad074d9 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=bC-a23v3AAAA:8 a=9jRdOu3wAAAA:8
 a=b45o4kL6AAAA:8 a=xG2GeFPYwsRGK1jMldgA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=FO4_E8m0qiDe52t0p3_H:22 a=ZE6KLimJVUuLrTuGpvhn:22
 a=dhdsR-PFWuPJUldTnwXm:22
X-Proofpoint-GUID: 16utwRMgadSxTdesNzz9lAj3lQmyFdan
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAyNiBTYWx0ZWRfX1369wzNpUlyw
 ZzN0QyCC0CqB4erPz9zDuOhjAkYfgKJYQY6V5EXm0J6fPCMhcuiPp6mnVWqZkudyuF/8Ve9QVNH
 cmiGl9MshC3h6J0SomYYig71gmS59EvuTFigVC70AFeAgsd0JJkaZgxuDGYFqhnpqJBiVXnfeGZ
 8WdPCkFVo5vMpv+cCGum25rzO2kNa0Rr7e4r1CU9QcJi9+AmgOHk9EFGoIwINplmIAzraZ/jiqd
 DVBqYVEqCHVak/eRFT6LPVvl6jI+RVRKeBHTMOb3mOLVPIbC9WMQiRLThRGUcjUSpFTjNNWTFQq
 gTtTe99QKXQBCm9nDyRxU4VFzmBXEwgSROUyaraZjY0dl3KGkCTnsIEUI6oQ69CO1pNoYTDnNjO
 4fbPoJ7jf8eXKcwdfEWa17F437ABdPYHmObeLvJujK/0QtZTwWkz5w/t+n4G2c/N/tWoKcCUX6/
 55vLlDQQCCLO7WSSjMg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAyNiBTYWx0ZWRfX26x/ae6WuRVJ
 Vp3GecONqDGlakjhM7Leo2hpoHu89df4hjgIvKROyXUlBSmNK3VdY4bMPbOnKIcaPuP0qxnrXMy
 +yylTw6d6XNGQto6R/GaVom9URV6ocU=
X-Proofpoint-ORIG-GUID: 16utwRMgadSxTdesNzz9lAj3lQmyFdan
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150026

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
- https://lore.kernel.org/lkml/20261006-qcom_uefisecapp_migrate_qcomtee-v4-0-bf1c8e2a64ab@oss.qualcomm.com/

Tested on Glymur-crd target with tpm2-tools utility.

Validations:
- Get capabilities
- Random number generator
- RSA key creation, encryption and decryption.

Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
---
Changes in v3:
- Merge tpm_qcom.h into tpm_qcom.c(Amir comments)
- Update return values of functions and drop certain error prints.
- Define locality_arg as default value.
- Add Jarrko's tag on all but drop from 2/3 as significant changes done.
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
 drivers/char/tpm/tpm_qcom.c       | 413 ++++++++++++++++++++++++++++++++++++++
 drivers/tee/qcomtee/call.c        |   4 +-
 drivers/tee/qcomtee/qcomtee_msg.h |   2 +
 6 files changed, 434 insertions(+), 1 deletion(-)
---
base-commit: d419d682257d813f6cb7a28e42b35d0edf4ad038
change-id: 20260831-tpm_qcom_driver-d21c720e73b2
prerequisite-change-id: 20260408-qcom_uefisecapp_migrate_qcomtee-13869d45e014:v4
prerequisite-patch-id: faf4520d818abf0d7533f71d9c8b9a8aade34626
prerequisite-patch-id: b487dfe2fbc076f4815dc6c73b9e68b0b78c961f
prerequisite-patch-id: aef7dba7d7662f87cb06bbf5cabca93304843f02
prerequisite-patch-id: bbdd5327c15aeaa99ce9b74bab324a98f084ed48
prerequisite-patch-id: 6263a8a3b40df5cce7fbe4b119f4b9d67a4c06b4
prerequisite-patch-id: 0c1a650a54014eb20f7ab9ec20038b49e42680e1
prerequisite-patch-id: 7be993abea2ca36057d9352381a5890f50996dda

Best regards,
--  
Kuldeep Singh <kuldsing@qti.qualcomm.com>


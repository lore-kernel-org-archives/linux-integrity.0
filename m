Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795172032;
	b=O1AQI9F43M71HmMofpJM2LH/s/CxTo8qCpbXUQYTmY3i7PyR999o8V7UBUvboQgZRcnL
	 NzSQ6bUs+CxZc7Jyo60RLp2jBlFfd3cEwdYc0KdKIqYWpm5CDZT33FoRKtvJ78qQ4Dsec
	 mouYZHlO6uWqTDB+mQ7wbXG/Lja9uRHNoRS3AJ2UDjLKoxb2fUqfFe3OxU99ERBA1qTk3
	 lqKdo9BXQrHJzi/6ctwCmRbdjdBCFUy27SHxd4u3HmNtGrrVwCvekPGvoMb7paK7H8ita
	 mCZkRU8o0Bd8q5WsydWHyjTZJ8R+chXo6VZPtnz9CtFC5Tsy6e1ejeJ6Dksw6P1OvRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795172032;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=wdWa/4zUENK9UMGMyp2jZmFl6x8KTgGcppwHxjuP6SA=;
	b=k9sEhZzRW7cCCl+Bvz7pv0r1eNPCADfKoObIhqqWpQpDuGnIrsUFlml1/N+9rDOai3Oa
	 3YJ8zkNkC2q2kJgQo7NOfKHb8FBWyYikxSUtfrmEAxMDCDaEpz3Hzf3SgkIRkSFiuopl8
	 qsjaMMJE+Asr3DR/Xt4XZLOv9wcXcNKJ/xQImBgce9VErwAXeB7fy3tIWq+TFJ6WYhSSm
	 +FGyQTxWq3CK29F6Q9Hhp2h/CeJiUmPnabXotyErtxHmZ4stHPYNKlmAWj3NwAknDnzeO
	 PamETv05HCllfceAvqGnJ5/HViGh3tw2MA/ZGfSxu7HJbYTAb6TPKjiasjlkxB+a0+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="LpDcy8/d";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DpypiLqr;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD1D606A330
	for <linux-integrity@vger.kernel.org>; Fri, 20 Nov 2026 10:53:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CD1D606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LpDcy8/d;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DpypiLqr
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKAkEXZ1017083
	for <linux-integrity@vger.kernel.org>; Fri, 20 Nov 2026 10:53:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=wdWa/4zUENK9UMGMyp2jZm
	Fl6x8KTgGcppwHxjuP6SA=; b=LpDcy8/dnZBg4E1IJ3a5ZH8uZRvErhbbJk3frv
	Fz8ZWFphPU1S4lnfl5aQajYf500e6q0HMVFUzDq51JsRTCsOG6Vln4htzzMFPek6
	wTTxZgvRjrWq425ODzcLxliBfeSug0Rj44HvgVPwsx6BqZjBSvCB0d+nVFkzT3pj
	WxeJnQ3AqOb05r238ZSuBunn93RZIAnikL6JqFelqj2oZXgSfTJ0/t+f2Zq/Iwpg
	yjM13LVCAqIPT4ZsOHwLHO9oVUiWlmkUzY1138ekDSNhBY7u/3tMHt72QktRydUL
	/rK2/wJ3fdyUkDZDIjYgcn4DAcD7TSZNqq51N0UfyGCYoqpw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2ggqs5tj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Fri, 20 Nov 2026 10:53:50 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3b41f4ca1bfso708597a91.1
        for <linux-integrity@vger.kernel.org>; Fri, 20 Nov 2026 02:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795172030; x=1795776830; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wdWa/4zUENK9UMGMyp2jZmFl6x8KTgGcppwHxjuP6SA=;
        b=DpypiLqrY80t912oizOn159blD8CYr5PQQEN89Yogc/bgw1sFsffsadBD/TlDLIXur
         X7Dh71Mr2FaEsoOLLz7xGR6lYOwbBdvXhoOVGzkQrOngEcYK4oLclFZmvfUeMQl7RcwT
         Bd56wTXVL16NlaOUrIxH5zE5ZA7Ii3sgQDg1F0k+wQCinuHMhmD+QF+YhXv9RJV9an4m
         cFucRmoFNJaqeeCIYZSicVVgs/aQ59M3Nj5WXkDxp23Knq99J/ivZGCXRMcsUUvG7wT0
         7ifsvS4l4gzHmHG9sAOf9a+fsq66w97AgNqpvNFNyxw64jTwZBpgD8J8hUT3rGhttPmw
         ue+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795172030; x=1795776830;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wdWa/4zUENK9UMGMyp2jZmFl6x8KTgGcppwHxjuP6SA=;
        b=SECrzKG6FStcq/DoFOcUN0C7+DIrtn4JcdY94vlqFMeGCLv/G6IcPfW7oWMpjlUUBX
         SA57gzlBsEp96W2OpzFuYkTr6ZB8x6koTSsZtIbTh3zTgR2HJwFJmKPCGCBFfyU0e8RV
         1IbxGmF1xQQegitbyYfL8UikkQSiipOBopyaxCOQLVTbdg7btGNwyPwBuXdOEMvSWIjD
         BbpkWO3LcDzRLbbHjHgXxZfaFXdlHDPs0dXZTAaXmhuoPhksUJvo8pk4yIUMSAMJo9px
         N9v3+GD2dDK0Ih8oGQBccLNbxXiFF5l58k6E10XWayBM18gK0FsED90cn+9QAbtJAtwK
         gA4w==
X-Forwarded-Encrypted: i=1; AL+hErFI1LhqpzABcuEI603Y94oPpvzesJE7Zks3gqkKvSuaZe5yeynRdyToPcdNEgLjMiVNaFVLzo2ExA+2aiH3nu0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9tuX6PycTdGbhBh7QfzOZ2JbTBm/hTpfqMvogN+OsEq8rOPtjm
	tfwUYJtgkxQ8t++ZHwZIOYf+OjjQlzwjHzPmcGWokBaFgwIb9RNZ7+Yiho00mXP9b/c8pkNZN8q
	vNBn27J9MAPRhFczbSSnSRAaXu9yfyJH97pzQHzHqF1dqRhZahP6tTRWvESklnzCZXgysMZA=
X-Gm-Gg: AZFdTZfSCwoQupcNkVKte9pd2is1z9vSaH56z5wc7cEBn0mPE03DBB9cIKho/sy3btc
	Ov8zBTKaH+8DIrIf81ggpSW6EiA40GXHMrEx43aqQoKpUYMhk7ginxNJAdhL1l+213588M4j8ps
	gVsS/rIuzLSMh4VRZwuGgfxPMtYrwJI30C37b/QG1nA/nFSbUE5bXYBAKsnN1rlsFszeuqYL7xG
	mOnXFROZRmJXfMxrVIRHIbHMOZOn40GGiOJI1rA1E2uoRJ5arx3Z0k2rH5gApBsdMatRab/f1qN
	AsJ6s7QOMZsRss8WTIbuJ8Lk+0jlZa/Z1ojJXFUVp/WcOsOP90ITbA5HRfeIr1QxnrmnK7XPHdy
	T0W+HczsAk8IMFJXrYcG8OsRhOOrw6oqynHavKvPRfIL8fAZ3UtNOHp5uDyH/OF+CGsmkSOZjxl
	C7cU6ffh4=
X-Received: by 2002:a17:90b:4ccb:b0:3b0:9183:23ef with SMTP id 98e67ed59e1d1-3b41c7b67femr2593220a91.3.1795172030048;
        Fri, 20 Nov 2026 02:53:50 -0800 (PST)
X-Received: by 2002:a17:90b:4ccb:b0:3b0:9183:23ef with SMTP id 98e67ed59e1d1-3b41c7b67femr2593193a91.3.1795172029410;
        Fri, 20 Nov 2026 02:53:49 -0800 (PST)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41d22888esm1559604a91.3.2026.11.20.02.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 02:53:48 -0800 (PST)
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Subject: [PATCH v5 0/3] Add TPM support via Qualcomm TEE TPM TA
Date: Fri, 20 Nov 2026 16:23:31 +0530
Message-Id: <20261120-tpm_qcom_driver-v5-0-3d9321ace107@oss.qualcomm.com>
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK0mAGsC/3XQS2rDMBAG4KsYr6ug98Or3KOUIFujVKWObUk2L
 SF3r+yUppBkIxg0+v4ZnesEMUCqm+pcR1hCCsOpFOKlqrt3ezoCCq7UNcVUYs0IymN/mLqhP7g
 YFojIUdIpikGxltbl1RjBh69NfH271mluP6DLK/PbEWGaS1S+tt2SmmrL4VijLWMuVoLOjuOhD
 8doM2zZGQARpqVxXAAmvFnkCrc2ASrXfchNZV1nnfIcJGO085456RSRwnMiNNfGeGG0YLxeh3w
 PKQ/xe/uFhWwzPV14IQgj6Yn0VhrKvd0PKe2m2X6u0btybORCb4zB6p6hhVHEypYoQZ3VTxj2x
 xBMxD3DCkO56jQITAWG/ZTDA4b/Z8w9w9eltDat0Zi3Vj2Y5nK5/ACeshUdLwIAAA==
X-Change-ID: 20260831-tpm_qcom_driver-d21c720e73b2
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA0MyBTYWx0ZWRfX6/ICKeFqLYkj
 fysQKytEUSx4kTy6qI7pzEPaXNgGpZ8fjButKHwJrE8mikDsk+k/nYxojfcEW2EYpY+z2ldb0Jr
 mieYruzlrLys3NboPBK9SpUB8r3k5OSzdjBuhHaSBoFSNwIRVIsShxJHSyjPqaC8CJbJOEzFQmY
 TF3UId7VGc5GVVJgGHv9Lo8xScGZw2Uy3/bINKHF2mRnAocX2jkj0rZG5/wds7HOGQogBP6Zw2N
 KKFkCaejhUoH0qJNEj4gpO2l16b0UtKJ/OIYD1CYQUBio3sm5reTX24C1HEeQu2IUAH5wRYHx3h
 XP2vuq3E8L4i0Mf1qo3EUnEa4hthIelnp6FFQKdTdDOwSezQHs5IUO9a+bZOUq1J2dlLpgpVw4D
 sAk7FgSDlsW9Yd6yPv82fszkW1wKmx0+xJY9DiMXn/2H39UfDG5ItcNp45ySY5wni5d129mTBZS
 M0ijjqRoIUBjWVCO1qA==
X-Proofpoint-GUID: km0_gddQucTNw_kbhy9whQZJzAy3EYv3
X-Proofpoint-ORIG-GUID: km0_gddQucTNw_kbhy9whQZJzAy3EYv3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA0MyBTYWx0ZWRfXyti5CXfn9uvL
 GPF0Q46z5ItZzSMpovo1XdbwX1YSM4f5xbOM7I0/F3RCYSZVHnNAPX3EmR2RabdEvnwj2P8vasF
 dPmw3m3iXRn+GP69jpmI/3uWZnWzc6U=
X-Authority-Analysis: v=2.4 cv=CNy/zhrD c=1 sm=1 tr=0 ts=6b0026be cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=bC-a23v3AAAA:8 a=9jRdOu3wAAAA:8
 a=b45o4kL6AAAA:8 a=xG2GeFPYwsRGK1jMldgA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=FO4_E8m0qiDe52t0p3_H:22 a=ZE6KLimJVUuLrTuGpvhn:22
 a=dhdsR-PFWuPJUldTnwXm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200043

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
- https://lore.kernel.org/lkml/20261105-qcom_uefisecapp_migrate_qcomtee-v6-0-c7d68ce05c51@oss.qualcomm.com/

Tested on Glymur-crd target with tpm2-tools utility.

Validations:
- Get capabilities
- Random number generator
- RSA key creation, encryption and decryption.

Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
---
Changes in v5:
- Rebase on next-20261119.
- Fix qcom_send_command resp_len computation(Amir)
- Use dev_err_probe in _probe and return appropriate failures.
- Propagate dtpm transfer/end error to callers.
- Fix drv_data after tpmm_chip_alloc call.
- Link to v4: https://patch.msgid.link/20261019-tpm_qcom_driver-v4-0-6889b9804ba7@oss.qualcomm.com

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
 drivers/char/tpm/tpm_qcom.c       | 410 ++++++++++++++++++++++++++++++++++++++
 drivers/tee/qcomtee/call.c        |   4 +-
 drivers/tee/qcomtee/qcomtee_msg.h |   2 +
 6 files changed, 431 insertions(+), 1 deletion(-)
---
base-commit: adcad7f4e6332cff3d6d7165f41584899f598534
change-id: 20260831-tpm_qcom_driver-d21c720e73b2
prerequisite-change-id: 20260408-qcom_uefisecapp_migrate_qcomtee-13869d45e014:v6
prerequisite-patch-id: faf4520d818abf0d7533f71d9c8b9a8aade34626
prerequisite-patch-id: b487dfe2fbc076f4815dc6c73b9e68b0b78c961f
prerequisite-patch-id: 9f2c4ee37ba173bdc860f253d44974379f2cf125
prerequisite-patch-id: e86905ac6289821db30fd9a17f73e276e0a88363
prerequisite-patch-id: 09a86ee4de34e0c9cd2e4664c54a6473d7998299
prerequisite-patch-id: a940a0624f1e130d1fe5213952965aa469bf9547
prerequisite-patch-id: 7be993abea2ca36057d9352381a5890f50996dda

Best regards,
--  
Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>


Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207893E7625
	for <linux-integrity@vger.kernel.org>; Thu, 15 Oct 2026 06:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792046304; cv=none; b=U017t63aVXAi7Pdq99W9TfZHgy3/VYxZKC39N0NdPZV2c0vZdNMh07KuOh2VF8oDa2M1JWuzHxO5S/MeX9w7SCDkEJAp7UCo5bXJ3jLFvveGib/utVDWd335jN3ZznvTg42LC8LRGn65umHruRATPKvMa463oXtWGMrurHBoMjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792046304; c=relaxed/simple;
	bh=Gjfl70hTFTGhBH/H4P2RMB0T59SFjyozJ0eYGyE+ryI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ixYI58ehwkhQ06mVWBdd/s6Khl40FAT5tjCKSEm0Sg9j7cneRmamLVe5nTGrnWTEuoAERDlGtjm9O9Xy9DdlZ2Kt89QPhA7D4EL5xYG8Ppp15SJPAhJF8KzFyrHuX+5WRFMGjCMuMExKA5b6suwk7fsNIG1iMyzfWaa9utqhtlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mQU9w7jh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WHRhiKYf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mQU9w7jh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WHRhiKYf"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F0FuKI1672304
	for <linux-integrity@vger.kernel.org>; Thu, 15 Oct 2026 06:38:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Sxi1dDHyen15wUUP13toiSG1kq/ZXdnSJUls7x1z7Xg=; b=mQU9w7jhNCYxUiRa
	Chnig8d2fNEr6JuYe5/wCpaX5gozpghSN3M5FhZgLiqVC3Vz/cvv9ddODfv+MSwJ
	XQDkfK4eISSr5TNN854A0WAIP9pBRcZO3S4Ey2I5of+7CvasYNL7YLclkGLolSFR
	WEOcHCJ0HbKTycbk2wHjSdXvOlv5R+dptw42riOI9ZGTiWOWG30IXXHn1bK/jvoA
	sJUAZca0v8aL4BAOTu2IzK1QjJXkZv8ta8/jAWscdffaTjOugf+23OXMgH2M69gP
	g7/wlqDGTQR7Kfd+XrN9cNxH6p2GET2uaGIgzqKbsn39OmpI5SA/Sqh0Z8OhjNd8
	uYHzMA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hacrhax04-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Thu, 15 Oct 2026 06:38:22 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3ab868fe362so6469654a91.2
        for <linux-integrity@vger.kernel.org>; Wed, 14 Oct 2026 23:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792046302; x=1792651102; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Sxi1dDHyen15wUUP13toiSG1kq/ZXdnSJUls7x1z7Xg=;
        b=WHRhiKYfoJbIKCpfWG8zhDQyGZakqeSUp3Tdq0k9QKQbmcEG3qJd+BcKW7wBS3J8AU
         L1dz8YMadg73suZoffvogT4trjfxVzciu9rwYKXpVMqsDaqmiFj8lH8eCCwX/Am+3ExE
         N2V7lF4CtPKVxz3DSGEHMKHoCIIBVgCF5NqxUV59P7amky/G3mcPOLMVOUWaPIRZ4YJ5
         Nqiwp2LbLIrsvtkE4FD8NQwXuSqp3iE4G+1x495haf676IVmYZ+fZG3kzKwgUJikbp1B
         dtBa3+YkDamv7hrHiag9TPm9AldB0dp3Yi+sHpowzQAaRK2lcWc43G4kJmIol2016yS+
         xe+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792046302; x=1792651102;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Sxi1dDHyen15wUUP13toiSG1kq/ZXdnSJUls7x1z7Xg=;
        b=oFSo2jH8VAMN5f3V/zkjDNY9tB4b72HtBgGPdDya709PcFnJCo/oY9xIXYk7tqCcK3
         mmGCNeRjbDywgJnhWGyYFuHmHrSW4ehGpTyfueiYkcNqe8m01qL9O0/QGHdjZe5nWsoL
         OGIX2aq1OC/LdnXSLwqa3uzv03NSm+a0yfC0qeg51yl+30MPxPY+RJF8CMG64zGl8uvI
         TBSB6YazF657mvclNp+t3p73xlAwZMf68hypJeagxRXwoWrV9e4ykP3AaE2V9ZojqfHY
         CHQYiXJ8J/zM2d37R9UAuoWoJi/AVc1rU/aCm9XuWKwJkBhA6XO8hRzReh/m5I2dnoY6
         Alvg==
X-Forwarded-Encrypted: i=1; AKwUvBy/6qW2wQ7J8CXZtr1prBmNuH+r/8ES3zu6AXPjrYsBl4U+gbobpTe+GWp29MZOI+hERUZA/LOTWi7RcBZvslE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJUOkJijYZyCne4xU26mWBns92RTvAvQkINVhjbepny39xjeNoL
	aMo+Z9OvOJxv3ib4W8kVv4kfMixRTzDNqDgTv3B10aEKX0sTzlSPTDLCQeXM9SUyvNoxlvh72b5
	5Z6FEn3d1ap2LRtEBFiVdanOLVpn98k4OorOlthcOlUT4Znegix+XqIykxJz3xZd/ob5gFT4=
X-Gm-Gg: AYBFou1wjtUgYdVJVn6J2SvzaWiplU2tcJw61Ab4PWszKTsjBR2cUlgqQjg9HFf4FMk
	9AQKiFDQM/52ARncSX498WBI46CVtOteuZNMioxUe11Z/JlTMlVkjFWUZslimH3TSlGz0fVN9Za
	9nl3QdUpRAuGglIcanG8M5AsNbAcK3ouhYyggaEMyJJ7KWe0tGX3llsLB2+4x/MgT9PTkgXMFBi
	orHcVC8YJxesq5kkSisltPI2h1hDXjk7ADv5cDgdf3azTn8Jjb5QjU1UpNQjNMpRqJV3dXvXZei
	i9IQ5OpwNMrGipiguHbWlunmEgANzZ2GM8ySIcEtJUsPykFIoH45I+SoqeczMvyhnshMVbrwFLl
	Gatpdn1IbvaVk1Sx4r8yr9PJX/s3L0he+
X-Received: by 2002:a17:90b:570e:b0:3a8:1a1a:7895 with SMTP id 98e67ed59e1d1-3ab3a90e564mr12340073a91.18.1792046301524;
        Wed, 14 Oct 2026 23:38:21 -0700 (PDT)
X-Received: by 2002:a17:90b:570e:b0:3a8:1a1a:7895 with SMTP id 98e67ed59e1d1-3ab3a90e564mr12340050a91.18.1792046301053;
        Wed, 14 Oct 2026 23:38:21 -0700 (PDT)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac93ff4474sm2844429a91.0.2026.10.14.23.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 23:38:20 -0700 (PDT)
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 12:07:46 +0530
Subject: [PATCH v3 1/3] tee: qcomtee: Register qcom.tz.tpm service for
 discovery
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-tpm_qcom_driver-v3-1-247c8e50250e@qti.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: wPXX5GUhnmFF9JLO53QnXxQLRXbCtOxW
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAyNiBTYWx0ZWRfX/4Db5lCpBCIM
 V0AmKragn2Ffn2eiyNyTpYS1Ae1tntFv7TxN1SPAE1w+aK5TzD5VBygi0ouIUNse54UTBM0yJuW
 e5ikRf78p3XJWZq/zsyxGFBgY7jf2h4=
X-Proofpoint-GUID: wPXX5GUhnmFF9JLO53QnXxQLRXbCtOxW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAyNiBTYWx0ZWRfX259USRAlrHyC
 BTUgRc0WBauUoF9ujnh4UlnzHBPbkL3xKkoro4Nx+CoXAW6iWis2F2baIqbX9VjRcwdy1k4pBS/
 ElGLfHeTZnf6x2r6vNxkpqP9paIW51UYSQ4QyN+unjsKUeq4XN7bnht9zdjYTqZsp6XuctmAFt5
 DBzDlR3uimqOEekooQ5+i282j1bFvAn6BTOexd0wGdkKp75qAnOUVTPBl8MRrm15dEsjW2FDzLi
 QG1CRDZObubo6AbgOQLkq+oxc3qL5IRuT2tKTd9lIKX0+XhZZRXa1/GpQmj5RcDqWFBE1rczjsk
 ff8s2+j2Uj4ljseO/xybJQ9SGminV/c7wK+vHiwgchr50YMLP0LwMVhTLYX16ZQHuSxGTUHc5aw
 xZtjnih7mWegsi2y6Q3OvO4iD/4BeM4sjr4uQZl2V28tjIijXkQW9RORw+q8mlFMtpL3giANJUK
 6us0WY7JnOYTmyQkHIw==
X-Authority-Analysis: v=2.4 cv=SYZi5fRu c=1 sm=1 tr=0 ts=6ad074de cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=cMdrFq0U01fV1n6vpx4A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150026

Add "qcom.tz.tpm" (QCOMTEE_TPM_UID) to qtee_services[] so the TPM TA
is enumerated as a TEE-bus device, allowing a client driver to bind to
it via its generated UUID.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
---
 drivers/tee/qcomtee/call.c        | 4 +++-
 drivers/tee/qcomtee/qcomtee_msg.h | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
index 3061bcbd15ab..d4d6f72eb71b 100644
--- a/drivers/tee/qcomtee/call.c
+++ b/drivers/tee/qcomtee/call.c
@@ -747,7 +747,9 @@ static const uuid_t qtee_service_uuid_ns = UUID_INIT(0xe1b48857, 0x6154, 0x49f9,
 
 static const struct qtee_service qtee_services[] = {
 	{ "qcom.tz.uefisecapp",
-	   QCOMTEE_UEFI_SEC_UID }
+	   QCOMTEE_UEFI_SEC_UID },
+	{ "qcom.tz.tpm",
+	   QCOMTEE_TPM_UID }
 };
 
 static void qtee_release_service(struct device *dev)
diff --git a/drivers/tee/qcomtee/qcomtee_msg.h b/drivers/tee/qcomtee/qcomtee_msg.h
index 9278a361dc70..9fff9dc5fffb 100644
--- a/drivers/tee/qcomtee/qcomtee_msg.h
+++ b/drivers/tee/qcomtee/qcomtee_msg.h
@@ -106,6 +106,8 @@ union qcomtee_msg_arg {
 #define QTEE_VERSION_GET_PATCH(x) ((x) >> 0 & 0xfffU)
 
 #define QCOMTEE_UEFI_SEC_UID            413
+#define QCOMTEE_TPM_UID			81
+
 /* Response types as returned from qcomtee_object_invoke_ctx_invoke(). */
 
 /* The message contains a callback request. */

-- 
2.34.1


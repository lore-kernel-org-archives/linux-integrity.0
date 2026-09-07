Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7201353A87
	for <linux-integrity@vger.kernel.org>; Mon,  7 Sep 2026 09:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788773357; cv=none; b=XEVUx66tPxVGoR58IClZi3ccuDznhGM50WkUH4d/TDN1PRHYEA4sHtkfSBbtg6vuk3ZNhU9mmOATBbg44+0cUCpbfms7QwAtBqmBRvDC2NhNlYgzXqZv55D8hNU9IMvp8tYBj+rfKcJLX+Wwxb9gq3acKtJ2vdkAVgrUQcJ2VSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788773357; c=relaxed/simple;
	bh=cLT0bftYuWxI6XzPRjJvBq69JkHwsp1xKebWTnTY5JE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IiXbJE23NJb+FH8nD1/gn3fvbT2hkcFJebnoxAtzDcutmx1KERznkTlmWsvQwnka7cRgPATxLp1faP+72J09GXy2hCKyUsogMgV+wD0ibyLDF7tHsY9E8zt6SAMtSOOX01fAV7x2BklOv7hQ8tJtVkUEN7IGQZluc9qwySuaLUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=olei01Cz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d4JVNlSV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="olei01Cz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d4JVNlSV"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6877orlR3657407
	for <linux-integrity@vger.kernel.org>; Mon, 7 Sep 2026 09:29:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	l0c4thTN4BGGYhL3ienR3lPOHCXz3GdcGl1jf05y8VU=; b=olei01CzL/AWquQ7
	391AgbwrNfWZWuvLggoUghIC7rGkmGEimLBtmmcmDKpZHdh69UsX+0lI/LZT5llB
	t3F7dRHxiGhoG8FGZWadQ4SBAwGvNh6F9Vb6ul3nm+agaE0zxd/tSxGn5ooVufrv
	2gxzAF1CVNCDL0rf4GGqwjhJrpOElT6nzvyRM0BjJ5frO2hj7rOeU6CV12yr5oRd
	PggkKtT4HHzCfqG6ohq8thatxPLfDrJCqtuM2yS5KQnVRZgsc0fWTPG3iv+d46zO
	ZHTgU/lkIkbIA16aX33fGTLSgUiW2YRKESbUJy+t+qGwrIAd+0DvtjdIFkqWtoyN
	YlHG5w==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghs86rf0g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Mon, 07 Sep 2026 09:29:13 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e54b6556aso4857250a91.2
        for <linux-integrity@vger.kernel.org>; Mon, 07 Sep 2026 02:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788773353; x=1789378153; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l0c4thTN4BGGYhL3ienR3lPOHCXz3GdcGl1jf05y8VU=;
        b=d4JVNlSVuTHjxJ+VwbYJdLpchqdLuVWjFL+BJ8xbMJj4evKZ0um/sp+m563iVho3Qx
         CY3PxWFOUjQhxJq0i127ZAwm8qby8wQ2Ype/kEj2r4A7ofi+I/FpiLnJ0UFRbIobJoAz
         +1pX8AWCOhyBfjl3g+XW6ZgtwhAu1Dl6Uo9tzZXfPVA+noGUVsuwUYD9l9pIViRMdDrE
         tLokNgk4YOHY0NI38OFbz+r8JHh/L9q/baL4UxLNOLTLpESN2fdsveSnzlLvpNZJ+hlE
         SJXJBIvAyS4lgAA8GzlOrhtRWtDfbw5Emh/bgTZ4R0KlDYg862l4aVuJZguArIrf/5lx
         +6Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788773353; x=1789378153;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l0c4thTN4BGGYhL3ienR3lPOHCXz3GdcGl1jf05y8VU=;
        b=Ug/p4u6oqaDKMrv87DpoZwleDlLtnkpDLH91Ug1Aou4b0IVN4I5Bu/9JKy4oHBoaw/
         TdRUQjtR3dg1ZAxVhiys1d73iU0M90jaGhfYecp+8HwcLqMdG3X+iO3rYgxfHqUByACN
         qzZ68F3GYX9oWrFHdgnF6QKAIacOloK9TDMebdkHbqhBXwAyQY1U7BLxj7BVkOvC/SjI
         r2f6m4jJUB0wGXAc9lHNs3S4WiBUNXahJBNaNJhXfwBD8/l6hxGLs6J98FKKI5oCKMte
         9FGAueHXUUDcB9D5Zsk2KN+ccFqaxYyJRyQn2uXd2pz09lwpBqg+2RMRB5Zb6H0SqOBk
         +5RA==
X-Forwarded-Encrypted: i=1; AKwUvBzDuR3PUfRBkr8EyPB7H1UJq7mnK+haL4cOkEM4e5g0hkBdQ8rStLLUOI2gvFA+Xzpf8RJ51IaWQ3ASVHCie1g=@vger.kernel.org
X-Gm-Message-State: AFuF++kr8AuF27CwUr+uEkzpSrbySWxa2kbYk1M/KfaMTva8iNikGO1M
	Xjn543kJHHsEtOrY6MFDxKkXFYmKewoL+in4+Fcs20spmBR35K5Td1xRN8JKq6IUS7KnUFwvLaF
	T5JzTi3IvjdZnBp4oaqRZSrpZMXlreQ8K5JScwuYeumG+B6tGlCDjm4/bhXT6eoCbPmr++lo=
X-Gm-Gg: AYBFou2oosGWdbvTPMQsxA/Ozn3NX32AUn3Q6RQ6Jss3qaDKbr5U2kSzTF1+zC/0xpZ
	I01pW0zD+j1G6hxu+ENVZlq693bedl846nhJwCekShO6qvmSb1InRJ7huoNm3ayEkhFa3isJI/Y
	o8HMck/gRu7LZXYR7ZQ72dlTUn+Vx4tdC0ODMkBbkB1NkQeQ+1DWV7tmUrPb7zzfNwNCs1xdgut
	wtsiT34ZFHmLy+KMcs/8zYNQqoonqrVKnBLe9eFMhL/mNGbIUbERn6GTwe1ah7ic6MXFYLHMpKD
	qrwYmaoPap6kgOnD02KAXxnhW80qkZBnNt+yNguKNuPvZb0g9BnFhPptZVCjTu6VdGaFzAYKzo1
	/WPv8YBE9yIOE6gDi6tMrexpwbRO36bebmg==
X-Received: by 2002:a17:90b:5289:b0:398:e96a:8999 with SMTP id 98e67ed59e1d1-39b261d0d83mr35910559a91.16.1788773352954;
        Mon, 07 Sep 2026 02:29:12 -0700 (PDT)
X-Received: by 2002:a17:90b:5289:b0:398:e96a:8999 with SMTP id 98e67ed59e1d1-39b261d0d83mr35910496a91.16.1788773352487;
        Mon, 07 Sep 2026 02:29:12 -0700 (PDT)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-338778fb926sm1627830eec.31.2026.09.07.02.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 02:29:12 -0700 (PDT)
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Date: Mon, 07 Sep 2026 14:58:41 +0530
Subject: [PATCH v2 1/3] tee: qcomtee: Register qcom.tz.tpm service for
 discovery
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-tpm_qcom_driver-v2-1-71a6b1752da8@oss.qualcomm.com>
References: <20260907-tpm_qcom_driver-v2-0-71a6b1752da8@oss.qualcomm.com>
In-Reply-To: <20260907-tpm_qcom_driver-v2-0-71a6b1752da8@oss.qualcomm.com>
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-GUID: aigQO9FXOyV3Bbj5xO7eQVkh0Klz7qB6
X-Proofpoint-ORIG-GUID: aigQO9FXOyV3Bbj5xO7eQVkh0Klz7qB6
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDEwMyBTYWx0ZWRfX6C+FfX5IAkKc
 zKbzsRGvGKDCu8I6ILyJgJ70dYWTu/rHrCLmqw2mny1IK4reL7h4ymaRcOCiy+uyno2GFK68qlC
 s/bjZUSuk6e6ZmzAd9UHGoY5+VWpq10=
X-Authority-Analysis: v=2.4 cv=LseiDHdc c=1 sm=1 tr=0 ts=6a9e83e9 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=cMdrFq0U01fV1n6vpx4A:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDEwMyBTYWx0ZWRfX8fgLk0gX1078
 vGVmRcSpqGRpS/3b+NWo3vYatXB0UBF5JsIsBn3WEvwIYjwjMTVxFkM0P/gY5wxo/EpAV/zjeEM
 MdrPOD1DMDSdQaQCz8vZZzvNgBV/dnaZ3hSg13gxM8/0HYxdRq3LbzFhj4mH4sp+BeGmlndQCBz
 XyC3nzjA+DeV1qdN7B0dyePy/dM0OPjZg3MX7G38GGL511Ei9ueM9FQZbP7IrrYt9NAB0QDGx9c
 im4ZeAWDUpZ3q20+A0wFcrAUSdTF19PHs83xos14YDONK9hPlSQPM+x3aWQBXPBmithKNEy+fJ5
 P4BiFkmjtpzZxRBJprpnEdOYjNIJ/I35YqiuKBPhDYt6WTSJrSdg2y9/16iDg3C6JQ+8FK3eTY/
 2kFWSiZqjCspvYLnRPQhnR8tVzAqa9hrP2n95vD1k/WUpU1XHh1oL5N8V0CTheWyBfA8nje8qOc
 wn6ih5fiUPkY1dHj0Nw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070103

Add "qcom.tz.tpm" (QCOMTEE_TPM_UID) to qtee_services[] so the TPM TA
is enumerated as a TEE-bus device, allowing a client driver to bind to
it via its generated UUID.

Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
---
 drivers/tee/qcomtee/call.c        | 4 +++-
 drivers/tee/qcomtee/qcomtee_msg.h | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
index 4212572ff54b..aca4e8c6e37b 100644
--- a/drivers/tee/qcomtee/call.c
+++ b/drivers/tee/qcomtee/call.c
@@ -753,7 +753,9 @@ static const uuid_t qtee_service_uuid_ns = UUID_INIT(0xe1b48857, 0x6154, 0x49f9,
 
 static const struct qtee_service qtee_services[] = {
 	{ "qcom.tz.uefisecapp",
-	   QCOMTEE_UEFI_SEC_UID }
+	   QCOMTEE_UEFI_SEC_UID },
+	{ "qcom.tz.tpm",
+	   QCOMTEE_TPM_UID }
 };
 
 static void qtee_release_service(struct device *dev)
diff --git a/drivers/tee/qcomtee/qcomtee_msg.h b/drivers/tee/qcomtee/qcomtee_msg.h
index ecaf8db67d45..87f1c257a877 100644
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


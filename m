Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795172035;
	b=wuNK7enPe8bev+myg2dHQuJ1N9jRvbMLLGKA7+pRRpBAe65uuo8a+Eatm/u4kjO4xCE4
	 Vy+XcuZUEz99lYryNcGFMpOQitCOxPybvc69yRT8rUfVlGAzhcRUajOIAIVKllg7AahO6
	 ydK2YtwbMx/NsZO22ewiubJyJWh62bLgWYikbJt7rZ54tc/lRe/VEhGTjINaMQOB4kPYI
	 E9nKrbw1YlTn3+mYRyLwoSJ18+1GTDsGT/+IvwhzHu9xlofMDGhLZpJEYu6rZ9pcI+7T5
	 J3UEX1LI9cqa6O/f6x14kaeR9J9gCf5x/A74YRcxEkyM6D96oIy9DqK8Dysn/H4O8gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795172035;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=AzCQrlehxDLRvYPoK3LFMcAPEAt34Ay7ZuowUvIExbM=;
	b=3OiyhIV6cOOVvD/+H8njdzsqUkdqRDga7wAPeNxqz1s3WI4mnsMk0WEpprb3fyQMSoRp
	 DhV2XFFmLkq/5bihAp06AbqrtF9z4GdUo7WRX1uA8RWBoF2UsMG1BhFvjwstvGPXsBmsG
	 2xK/VnkoD9ONSd1EkJo4EGZEC/MeF3+f9fZ1PYr8SQ27UVyYS+FTk+7xshuxMuIyQDNwt
	 oNNzBNlk8Xf9jauhUErzRsrmiD0I1sdlKeo1XzDDq4oHiLtw0da1bOBaZpUKtaM7dnj4w
	 sKoxeRGuFx/+oNo7lElHPPtG0jzXiy7bPn89kg/WYQ3VOwCMZmpg58R1Sd83X4FNOhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CDsVIVDc;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DPA61kYa;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1AF60A2609
	for <linux-integrity@vger.kernel.org>; Fri, 20 Nov 2026 10:53:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A1AF60A2609
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CDsVIVDc;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DPA61kYa
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKAjppF1462914
	for <linux-integrity@vger.kernel.org>; Fri, 20 Nov 2026 10:53:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AzCQrlehxDLRvYPoK3LFMcAPEAt34Ay7ZuowUvIExbM=; b=CDsVIVDcGFTjw6lW
	ojABQMtpyTtl++/qTE6KBz11hB1aULRK3VCrkAr54zBTvx7TBcnFsdK6Ev3DBGkf
	14+a+PY+Udz8M3a5gn+CqonKBwI0x8ABhZtzLt/BVxJzcDvblzT8IqCoM0ARCFYC
	zhWMT0lavKGQ9XQOKBnDqWRVO2hJ85KaRvx5xPlziPVSOtGKkn2/76sTJCDtyDtK
	mMzboLFqYupX1VkIQM/py2VOKTBy8a8OjxlK5IH9jQNauItI0uj01jQAwZQB2RKb
	rP8526ejDsb+J/1x904U1ljKsBXAcXUmSz5znBX0k9gRkNuJWcsSaSZ1gFSx/tst
	ObWQTg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2guah46v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Fri, 20 Nov 2026 10:53:54 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3b41e8c1ac0so1103460a91.2
        for <linux-integrity@vger.kernel.org>; Fri, 20 Nov 2026 02:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795172034; x=1795776834; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AzCQrlehxDLRvYPoK3LFMcAPEAt34Ay7ZuowUvIExbM=;
        b=DPA61kYaVfyEoqv1S6dbCkJfBuZC6Es3cZGJF70wdVORN1MrvV0V8uPLQQJUf8cWWg
         1NLU+3auT8YIPHJCXcEyLpo3pZoPifiAJf6My2gyY6FBnOypRuxRwMXyohD5/sjh+tzG
         pbGdhD9fob6bEqxdomSWq+xKwugbeePJS8LeNQpETuX3pDz666gAMnEyXnfZT1qSRNPe
         UC4H+TM/owXTYDbN6axmjpzOW8V1v2bPvZ/cm7JP0+ZrAhLP5Uylic1wRnWTn3HpCZVI
         fX/V1GVAUtzp75WxfWwMGtPM/Hf3UcgfoOLlJ3gBgjEn2HWpQW69fPIRIr3xEeOIvevc
         ie1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795172034; x=1795776834;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AzCQrlehxDLRvYPoK3LFMcAPEAt34Ay7ZuowUvIExbM=;
        b=g6IB0GKUd0yX2v9slS43yFGb36PWcLMWmnJLTE0AgmAo/73YpAjhnePT1b6dvpYKSE
         N2I59KPEdF7zfRVtSB52ivYUlqZxxpApNZl2dQPpXoLM5/H2Wr6vzT+5wSW4uuKY5Avj
         0f2KWFn4tefMBuEM3XWhGRuFpklPYDE44NTkIslu2A+fEGlG4KQn/9E3jFjWZttWywBr
         zwlYem03HUJ2Ro7qJcHhouHhgXjkH9V2QMdad0Jh91rFz4TZUbbwhjqQYwG/9cSOhM0p
         MpIwfnd91ApKzcjhKGilstQUIf+AIfu6CQoSWKVvdrP8o+HnhrilGaCPcPt2fTryvZCW
         EHKQ==
X-Forwarded-Encrypted: i=1; AL+hErE9YLayhw93EABSFZBQh4OGlH/mPlK2IXpsdSVwmaIkbjGyTZWi/9CJeyhK+roh2Z/TtPvhJAQRmoR10b4M7eY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Y3zf1WmkqCsJQ2ySURoBHHKjGmgAf62HS0ynjXz/z3nqQiSwi
	8Pt3johh0cIPEgXshdDRhYef3LSY137VRut6UIzR0PPoD45IDKzV/vo4/cUtKZsvXQpJ3s8hliQ
	rdIkf0/ApmaW4ejFa7rKxxXHG2KwbHsUvtwwt+Izgyr6dkw5LANdD5IiNtaBoYFT/NeJDleM=
X-Gm-Gg: AZFdTZd2Q0tLmRq4rLK088JfoBs6I94rBs9Vcwgie8Kp06rlTd51SKwrBFLhknMJcxN
	Wen8jw3wcHV8T9QPcKagsLLw2jE5p+/Ah4HoZ+XmeaRg3NwmtX3uppQnt6DYhE4Plph1zbeqctY
	EDBgf0B7MQnUDgABRsPIcSwR9UnU2AaFNE+IrhiJ7KjdWi+L526I+Vr6/NXgIeIA6b9Av+WS3Hz
	PYKNVYZr/uIqy88YqcK30bnULWfLdgRKB2Xr094RzWmKECEniPUdxQJIuw+XcUVFs13Ni7FR/F9
	o7cotT9EkmrcgbvsJmAa9H6uED1wDzPTyeD+hXk2I1Z312D+pEV1BZgsljTMhBX0ZvsPzyANsjI
	xrS/CK59g64IcoKBT14ejMe5Lv3buwTL02FmP6IsjMw2RCKeCKtZVc0bmEgFaSA3giRpotSncWu
	DxQtq24cQ=
X-Received: by 2002:a17:90b:5287:b0:3b4:d22:8601 with SMTP id 98e67ed59e1d1-3b41c8fa9c8mr2320781a91.23.1795172033849;
        Fri, 20 Nov 2026 02:53:53 -0800 (PST)
X-Received: by 2002:a17:90b:5287:b0:3b4:d22:8601 with SMTP id 98e67ed59e1d1-3b41c8fa9c8mr2320752a91.23.1795172033343;
        Fri, 20 Nov 2026 02:53:53 -0800 (PST)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41d22888esm1559604a91.3.2026.11.20.02.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 02:53:52 -0800 (PST)
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 16:23:32 +0530
Subject: [PATCH v5 1/3] tee: qcomtee: Register qcom.tz.tpm service for
 discovery
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
Message-Id: <20261120-tpm_qcom_driver-v5-1-3d9321ace107@oss.qualcomm.com>
References: <20261120-tpm_qcom_driver-v5-0-3d9321ace107@oss.qualcomm.com>
In-Reply-To: <20261120-tpm_qcom_driver-v5-0-3d9321ace107@oss.qualcomm.com>
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA0MyBTYWx0ZWRfX05gtj87unNAs
 E/lzpUSSNUzQ4Sv20265Q3G6aGo9X59Aq2pXvnDhQc8jRO9l2qotV8dG1pCGx9UvSxU3k3xCxwM
 LZS5ab26Om7DgPACafINLXhnyNAmlcycAmsrm0stiBMKu9WdfOn8HjnfFIGwgUUsDVEujVR799d
 /m9P2yeKVXHZoRkvdyHLutKeGBE6p7wICcsSvJizn6l6EmWW26Lk84OFnpWW5YXaSdBeGiYDiuz
 ZtM6evfneNoX0EaTOkd0TOW1MSL2bXDKfmyjaviS1CWiZM02pVpM+qKxnOxftwg/6ICrvE41hPH
 kPltTbiCyI2FFed7RBGOVVgYO9Zjvgys2x+KAOi02xN1zrLRdZlslSQlAOEZcfblYaaO4ShXgGA
 xWAsjlDch3GQfRyyV/0zInCqI8XHyhi+SgfXafmPnnWXGTVPiu9sdeTYzW5LP0JVSlIhDU3ivAM
 4PEDzLzbrp5oE3e+w6Q==
X-Proofpoint-ORIG-GUID: LiKzpmLgulm2BNP-b-FAX_5zNNOV3f-r
X-Authority-Analysis: v=2.4 cv=BIYmP1QG c=1 sm=1 tr=0 ts=6b0026c2 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=cMdrFq0U01fV1n6vpx4A:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: LiKzpmLgulm2BNP-b-FAX_5zNNOV3f-r
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA0MyBTYWx0ZWRfX6xdPQJvgXrqV
 05aYUS7J8l/q2pdvXHe08g0k9+o8CH3ATdi6qWYVccrqVkJcXf5AHXre4JQ1wkiPdBV+7JmpR1Y
 Sl4CY+nc0uv+V2K7Il7Son/U6ZSYKwc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 adultscore=0 clxscore=1015
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200043

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
index 96badaf98795..0c9fec95c9aa 100644
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


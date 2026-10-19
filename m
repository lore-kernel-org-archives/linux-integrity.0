Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FB649D595
	for <linux-integrity@vger.kernel.org>; Mon, 19 Oct 2026 09:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792401743; cv=none; b=VTAOuLqjrThMjcGYP7I/t8IW36YOdtLCuhR7d5r9KUX/Uskd7WlzqRRwuT+FsTYu1p8XK+snLrmxOm6Hlwvx1DROMD0x7usTxPhIpfbt/8nW3Evc8GinwGe2k5Yo4tG/jgv56z7I6KQ7W3ctBrUcEQ/oE1W/5KsA1UE98MngfFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792401743; c=relaxed/simple;
	bh=vYqwUH50+liD1PmBF9/X9YCEu7jl4gq4F7J7KhijndQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cLL1tBOk2k5HbpICtDxQNnX/ecVi6yqcyP/rXgqsTSdUgtSmqLWemSvWy98HVaFCOKSnDi8BhDw3efJw7QrpMF8P65K6V3S4GG7S0XM+pZk/rAz4qUrnTecLOyNZCnyCtOb7m5I8MOgiXYCVzs4IpFg1QChv3GZFpo6ucHfSIGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kipViJoV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=i0yY/aVO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kipViJoV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i0yY/aVO"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J8OsL91168031
	for <linux-integrity@vger.kernel.org>; Mon, 19 Oct 2026 09:22:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DA8hRxQNCcV+MK/4Ku6+FpMKSJpiHNgidK9cjVvcI9g=; b=kipViJoVFRHbN7mn
	fpPvCb/q4MdK2JDt1cKrrfh0N4wSagRlRr4E6ZdEqgO6MdKI5Gp7lYtBnC4W2zMc
	axi+k3OOFqvlPg3M27XuBbb3rAkEZpcScxu6FijrQOeQaNOdguYbDDPbnlXDsUMI
	TEiBFOgBNu11/FQSJKRsaZqe1WyQ25jBDtv6fHto85tEom1ZOarSjOqf9DuD6NWy
	c/0V37S20ctBVRjcLDlxddQ2THFxjPp0yvOVbKbfQe69oYZ4INy7yprbrpdo0wy7
	/c8Wa5NG8VceVvSYhJeOObCC1YmL8QL0zaPMcrz1ahpTiu/hmKwnCzhdzAbfLoX8
	8psR1w==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf5c8brp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Mon, 19 Oct 2026 09:22:20 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30bcb065bfdso3844603eec.0
        for <linux-integrity@vger.kernel.org>; Mon, 19 Oct 2026 02:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792401740; x=1793006540; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DA8hRxQNCcV+MK/4Ku6+FpMKSJpiHNgidK9cjVvcI9g=;
        b=i0yY/aVO6h437DpobogQOKgkhV3X1lsAmCDxuCOtOFphJvmoHIOfwLdjnkkwsDE7vc
         Hc0SwN9QO0k8RwE+g+zTccTHYz3doQdO9L6VhDsR9mNqZ4L97eAu3HYc06QAU+Umqm/u
         aIuLW6yMc4xvGF2cvOwjxfk32WKbqpEW3BMedlxPcxqp0xG5ROYHFJQng8XuqwJsBS0j
         kORwPjtCu3y6JVkxC10+bdd7tD03WO01k5F4o3vOCjEGeY8ir1nHonZvcCpdxOWFOnkS
         20nPLJmQELIVzijXopsmhgvV3GqVKYTyG/f/KeQmIE7joV/yYkD5+WFXUCxiNd/EL1La
         ebZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792401740; x=1793006540;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DA8hRxQNCcV+MK/4Ku6+FpMKSJpiHNgidK9cjVvcI9g=;
        b=ESdBRvg4LyoiBwKwTf6hpjQAbL5N2YXzm8qgacjfhs/OYTeAk1Sn5tLS6X8h7F1qwa
         rEyTu0x3wi4WMCImdfPWhJqeVv0b2ytL8QphmsU4Xg28P0HKosP7jWCEt35kK8E1YqXX
         3kt23PCw56tk/pnfULwMpL2L+dLsBAMVNaLHy/S1rhtez5gtv807r7nz0L2IG79Nzo6q
         pv17E+pV6dUfJ5Pzhz5MIFXHXEYsH4hRJZ+qqLEOOSRm0ZRG5bzqnwjB6NXNURCcbbd2
         DD42LO7A2PCTTvBoAT9jirvz8VpFKGq36GGVDkGnYFr/ZePI+QcaVgabFL5nNNL4wKsD
         Jb7Q==
X-Forwarded-Encrypted: i=1; AKwUvByfjCcB/T2yuIe3Zsew/WTwVjPWBIQCuYC5brTbAvlwz4C2aJ0OgQxsTXsdg4bK12glfP7dmcb8lo4Slru1lfs=@vger.kernel.org
X-Gm-Message-State: AFq9FYLO7028lX1t0jvtE3dVrnbABkLic1ld74TwSBwIsJ+MqWXoSr3A
	d9KkUHcIycITUWpUO1LKYFrOqBIKVM08bWerTpSSXt1S9LO1pb1zOLWDf1qDQe1TMVMlTnHsdgO
	VzaQljQgQrkqlQr6XsJK9Shyi5TupF+xuCn30EjhW457ZTxsub4zdKqDp7L9RogFXFSgjTlE=
X-Gm-Gg: AYBFou2jMDgeTvMawi+UTarNKqObgXWk9KlE8wzGN0myRrNC5zkr3RMrMJ5yNAINDgG
	mfYzOrhlTliHW4DCMOxVMq0xb8Xd22Ovv9ghCf0gae1u6YIgDJScOgZWFmDNlz2ZF0NIXg/nter
	qweEyWYkYI1B40iHBXPcQAqMTeCmwpjUtSw0ad6LwVFmA6CFTXsjJJedzV/JvTibAf8JGeX0h75
	ERfQplyasQAyx7phmZojj53+U7JBHpapQ/97s4PwE59/HnbdO6AiH2PvAGCtrVpAsmkwjoORtHw
	ZDpb6LMTLEFivGRFhs5oOI0jedb1ZtqyajyuLgb/eLoanOCS/aCpYNUedSzqoT0OHK/QEk2qaXh
	DV3XjTUd7DXhdpmpaHa2CXTRrFJOXm9LB
X-Received: by 2002:a05:7301:430b:b0:359:2433:2717 with SMTP id 5a478bee46e88-361a136ac68mr10441994eec.20.1792401739715;
        Mon, 19 Oct 2026 02:22:19 -0700 (PDT)
X-Received: by 2002:a05:7301:430b:b0:359:2433:2717 with SMTP id 5a478bee46e88-361a136ac68mr10441965eec.20.1792401739127;
        Mon, 19 Oct 2026 02:22:19 -0700 (PDT)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36082a7b33bsm56225094eec.24.2026.10.19.02.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 02:22:18 -0700 (PDT)
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 14:51:46 +0530
Subject: [PATCH v4 1/3] tee: qcomtee: Register qcom.tz.tpm service for
 discovery
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-tpm_qcom_driver-v4-1-6889b9804ba7@oss.qualcomm.com>
References: <20261019-tpm_qcom_driver-v4-0-6889b9804ba7@oss.qualcomm.com>
In-Reply-To: <20261019-tpm_qcom_driver-v4-0-6889b9804ba7@oss.qualcomm.com>
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAzNyBTYWx0ZWRfX4fOrOBnqU3oH
 JfLnypfqfqbD6bjhtNTzevWpYcBV3hPZ2+covSNg3qt6oOQaCuwi+PU+WIgC9JYk2TJXfhZP4lf
 7KV/af3pVbv02AW8ZikXy6gRLPAPEiI=
X-Proofpoint-ORIG-GUID: cI3kbk9UKzjAOD7hMCj5JvDWc0J-bCsH
X-Proofpoint-GUID: cI3kbk9UKzjAOD7hMCj5JvDWc0J-bCsH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAzNyBTYWx0ZWRfX28dotylPTmwk
 MC4VM7ojHmsyOIjXr/QHMADHujA/tJsl2oagk91iHRX9GCR1vuDs1ZuPxtX5vnDzoMX+WZZZ4Ul
 6z5+DiHJzVcV0FkneQPifN2b6QV07F3/YnzRTXqQeQnQxanDaO3QzI1yfHGYC33AsxvQ3Ghh3h2
 RyYapE3+dov0B9Lu5SWNpDzHecr6cgYHBHJ/wznikw9Noiki4Qd0y5yDDV98BxKIy8du3xk/Alc
 V/0fizaUaqOozvNTD8ZGUvOe0WX6fVcnqB93SSnxe9eh6sZXEpFjT6ilLM3BHie++/DIibWmAXt
 q5odSYJHLTl0XhJqR2VKN3GiICZlWEcDFgMly26cmZ/1HjGOp/86h72/BsDZh57xlF0uFVP8aaH
 ZfbgD4gCu6mgCx87z+y33kynjv3B7COWFT7Bkq+QB40kHhqK32vetwtlkA+kQhWRdil5a9L2uNB
 eAcvOt40/aX22bWkSJw==
X-Authority-Analysis: v=2.4 cv=K6O3jCWI c=1 sm=1 tr=0 ts=6ad5e14c cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=cMdrFq0U01fV1n6vpx4A:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 adultscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190037

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
index 47d8a4f9a159..1b887da83341 100644
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


Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CD33D092E
	for <linux-integrity@vger.kernel.org>; Mon, 31 Aug 2026 09:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788169408; cv=none; b=h9M2U3IlqcsLXnzS82RGzWFXdgX6U4NzxoB7Gtlr2VM63MRlyUcfmGRP5ERT7F+KRWS9aNb6cssFvn+UHdSJD4lBosFbzcrRiKtC82rolDfkGfFbMQLN5k8q/ezi/uxrSEBtRaXguM5iLk9hd0kaXRZ7BXkm0flrNrlhwuI8K3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788169408; c=relaxed/simple;
	bh=ds5EeuA+CTb0BPfIbXKAJvl2PTFGAC/Z73CJ6Krns8A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T2ySN/K7KKAYkh1h6SLME4X7asbZcj88/kjvl9rmdZA399gglh3rO3KhYVpLVofBLKEjNVv1lQDENdq2w2GKyx+yicxajZtHhQsRmKsDXPf9zABo5eeBdEtC65R0p4NyjWbWT3lf5/EGl8afn9yJt6h972zIeU0Uy+kt9PnZ7ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UoGZKsyS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FAxCXhcg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UoGZKsyS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FAxCXhcg"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V7xJMs2460293
	for <linux-integrity@vger.kernel.org>; Mon, 31 Aug 2026 09:43:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/yFEAg71NUKByt/pUVT5zmDN6HUPvw1ZY6tWiIuwibA=; b=UoGZKsySMbVNLdum
	V6PYvVRh13yxz5Wly+/Fw7rvsESURf0ZjbA02xJFVC3zvmJpHMzNPAF3NHP/fdb3
	PdI7sP9/aIv8eEifvrG0oQthe6I3yeCWPQSa4INnG/ZkML1xIVPBLWcrApJKKMyN
	ffrJ+g9+g0W9uTJ4j3XhfTwk3VZF09Ydlwaq98tMypVh47svmgg/9gOtcMWl4CwK
	rzqjRdOBvD8R8abmp3aMyauA9bbVUl/yPqzPYPVkMxI9TpEJEgjXT2z7iw3dgXq4
	zZaByDVpPusLrQpI4p9T9e6ZIFTpNLcWee40dT+bxVFNEiYXlrzSKeKIgdQ7fhkU
	o+AQ/A==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd556rkbx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Mon, 31 Aug 2026 09:43:26 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38ec0f510a9so1979538a91.2
        for <linux-integrity@vger.kernel.org>; Mon, 31 Aug 2026 02:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788169406; x=1788774206; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/yFEAg71NUKByt/pUVT5zmDN6HUPvw1ZY6tWiIuwibA=;
        b=FAxCXhcgD8USX+7u3V46VPp+PgJ9FdxHBTRR79nswCIq9Cwm6oIgPp2Fd9qhCp1fV5
         Y79UCHYbYb3o0nE7lnGo8v3+uKY4TwdiuI6GS5VTFlfUBP3f0UfL1kT/BZmpbU94NnMk
         3KguAImrU7n6pMahmbwkIDgxB6pNwbV15DoHz6v5dA0qsqaf2p+nBTiSIdn6fV9BjmTQ
         1/H0h9YU6GHYF4b9OyrqkM8QKMa7nFm2f+3oByYN8b+htr2oGWbyorV/ZpAxcEca8x35
         EJ2W2dyHN6zXWqZh3acr9wRu06jQyCYm2JlH7sx0gIgrpKSnU4XdaHYiuN+4j417TErf
         5POA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788169406; x=1788774206;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/yFEAg71NUKByt/pUVT5zmDN6HUPvw1ZY6tWiIuwibA=;
        b=PPeRCdBOjqplPKpy9MAH2aL56LOIPnZU4EPkQecnx9x5Qf83pLlNYIUJTcLm78h253
         AQ8giIMkmE4rrCOmiRvab2FGJ08ERUdAHr7CMx8WesXhdf4uYqb4uC+4GzN0PjhpK1Lt
         WQ1DHiTKh2D7SgasUP7XwCmXS/mQsij1IKDoq0Fq+cB+QEmU+GSnJyG/xb4iCIBuB/Wf
         NNWTANvaHDN9ATIHPusMXaydZSoJO2ayNckM0H6UQkLADTmGPkW6TtngGYY/MAEMNeDv
         RQntjbS/YTF34C2DGywa+WzGG7HijM8z8pM+ubwZtBQVKmiWROrzsNG467PEng99x7oP
         BPBw==
X-Forwarded-Encrypted: i=1; AKwUvBzXPQfGbGazgA0dhWT5BT16nx2bvwTH3KPv/BUliSnhjTX5Y9SSa/syGxDZFa+aRGAi+e7cm1VDIpuJ1+w/9Tk=@vger.kernel.org
X-Gm-Message-State: AFuF++ndLFwa1uiiwxLHiQ2wXWUP+/PlcAw56y+oERwOVonVb/DkC5F8
	wAzbftmYiVsaIN+qVMpQGucjfx4w39EIC3AHa2oQpE0n9L2LcBy+4MNgtusekFmpfuONygNbjMO
	ov9KnCSNhnnh262CqkebE8zopGnODQj1ey824GFNs7WYDlklVdzlQv4Z2/Xv2vPQBeWNiti8=
X-Gm-Gg: AYBFou3zjVzDB37rrq2jv/BSqBSvjFERzrV7MYrisA6zQyXXKSZTLuznx7s4wPsDzBt
	/A48Ltyf7nl3k+AeY0Cty/OTZHYYuyU5E6zdN3HgE1Uu7abTt6EXTd84zJQB8gGlVJVfdbVdJUO
	S1V7kE41HJGuXN3Il2LoMjrHF3Y1Tx7rSMqMg5kzJ+CM6LaSuhy48mg1/2PSKM3NGWfv9Fu7tFn
	aNlmBThN3RcNbZWa6CGcVNG1CvW6qgYfaEJU2qWOyH8n2+eCVDdG7vzGtIsvxd798Ibn7nkmJNV
	TtDuCA/HPqFTjzH2Hu+t1L/Ehvw+THLXVsOOG4NTNlO35ixWVvldJzM0Pdt/jsUdTbnEYDrqLnR
	kikRNmbrvRFtAD3AmWURclgq0tnYnKy+5Yw==
X-Received: by 2002:a17:90b:1f86:b0:396:4cbf:45a2 with SMTP id 98e67ed59e1d1-396d0ff5bb9mr42028748a91.14.1788169406082;
        Mon, 31 Aug 2026 02:43:26 -0700 (PDT)
X-Received: by 2002:a17:90b:1f86:b0:396:4cbf:45a2 with SMTP id 98e67ed59e1d1-396d0ff5bb9mr42028688a91.14.1788169405737;
        Mon, 31 Aug 2026 02:43:25 -0700 (PDT)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0bf8a13sm40782983c88.0.2026.08.31.02.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 02:43:25 -0700 (PDT)
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 15:13:00 +0530
Subject: [PATCH 1/2] tee: qcomtee: Register qcom.tz.tpm service for
 discovery
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-tpm_qcom_driver-v1-1-6f16fa6924fa@oss.qualcomm.com>
References: <20260831-tpm_qcom_driver-v1-0-6f16fa6924fa@oss.qualcomm.com>
In-Reply-To: <20260831-tpm_qcom_driver-v1-0-6f16fa6924fa@oss.qualcomm.com>
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA4MyBTYWx0ZWRfX9Uvb6Jhbss07
 hJHb3KnHq2gTvF6r6Ali2/8BGgH79oGtHgjOql73sYZSGYrCvSWFk04ru42CdYi/Q0zFtwuz2nt
 VIDIpa7bh1YVTvvonYK+HGxrI4KNuNw=
X-Authority-Analysis: v=2.4 cv=O7sJeh9W c=1 sm=1 tr=0 ts=6a954cbe cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=cMdrFq0U01fV1n6vpx4A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: MFrssrIcc6u0LgBe6z8uNb30SQsoblj5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA4MyBTYWx0ZWRfXxUPqNLX8Ndji
 XOIknLovjUIO0PPu8fOYd3wrqr+uKUiTcHMbH1kdLVxv5MyGGvW/hm5MOZnJjfVHMIZXQjgW5KY
 RJaPfThIOA+a+dyePSJH5EQnnzETo62BvpftmbbfI1ZbV3k3o18XNXviDq+j2zBfY5NG4NTtAEq
 s9dkjxF49BuLZkrGl9yJswZkaLu5pf8+TeXiirG0gF2H+19P5YiBc0FAYzej5sKm1aX5+HHRtwA
 Ed6RIps+BkoN7d2imPq5hAK5bL3Uphc1vChTyuUGpO14EVpFhpugR7hv2cs45LTUHZuPikDdKia
 2Uei+BCeO2ETIg5bpZdVKd2CRjhAc2DSr8Wp94d8djOFZTWnSpdePjjCmwiIemhItdDeMN5Wp5t
 QM37VutOddrgigQ+l8kDfkSFhBeQ82dtysQQzw00t9iO27TkUFCeJhXCQkxuLyIQxZhwPuvfzuf
 1PK93tS73we0wuGhr0A==
X-Proofpoint-GUID: MFrssrIcc6u0LgBe6z8uNb30SQsoblj5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310083

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
index ecaf8db67d45..888611b801c8 100644
--- a/drivers/tee/qcomtee/qcomtee_msg.h
+++ b/drivers/tee/qcomtee/qcomtee_msg.h
@@ -106,6 +106,8 @@ union qcomtee_msg_arg {
 #define QTEE_VERSION_GET_PATCH(x) ((x) >> 0 & 0xfffU)
 
 #define QCOMTEE_UEFI_SEC_UID            413
+#define QCOMTEE_TPM_UID			489
+
 /* Response types as returned from qcomtee_object_invoke_ctx_invoke(). */
 
 /* The message contains a callback request. */

-- 
2.34.1


Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84F64848B4
	for <linux-integrity@vger.kernel.org>; Mon, 19 Oct 2026 09:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792401753; cv=none; b=bWe7df70Xtb5bNJuFkBGRHr7XTwvVG2jKEF154MRCvUu4SzGGUVTwaKhQadl8oxldmFnCUlmUGfTAhsGWPF2Xs9wrOxMwJOV2ghwYReDsRp9rqIviGnUkgphyJV0ppu5FzEd85Wbbz70vThBSBiN0ka0w/9QdcRLocBRRirZNAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792401753; c=relaxed/simple;
	bh=YSCzLQSB16uKcbe3+cGF2KdfW35CZ03t502Q8V6q/LI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rgXgIV47ZlRknK/VKoFg3dbnA9YMy+xHDRUsXTFC948nO44vLfEBo0jJp1DnJeF+9SSpdPmsz5HRq1n06Fx62wFhHX6muAudUgxCxmZ7YfrxuOfGrRvH1VE/cpKy85NVsf3UsHqrkF/E/PiS5ht0152swVMS+2er232SYFL/8cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D8KQYvfU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZhrvBbMZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D8KQYvfU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZhrvBbMZ"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J8P5PA1896537
	for <linux-integrity@vger.kernel.org>; Mon, 19 Oct 2026 09:22:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JPhY8yd7nilzGQLPZJehSpMwbHwaeWfXH6IGdZHCFa0=; b=D8KQYvfUiGomP2vh
	1E77fvOYjhjovo6v7Bq98ClXgB4uOqnjTsPDOdrHftph6UYBzuPUPD6cker2nYcH
	sZK1qQMPRxWJ8xLeCHgs2qZ/YYCReKRggLsnwxL8QJ/L4NsgBBGDtvYa0REueiEY
	M4tp6vNPPrASIuFcvB08XU1frJyDqYdqOjBQivvdDpTIVCc8LyZMdz51LLdF9RaT
	570etR8Ruyq8diobA+wKbzaXeu6/Xx3DVhcT6rek/nM5C5qiZ83MyyXVCYaELnIF
	ZN8l/qkKU8Wv26frf1wboAcmCupB98O1HA4Fp8YqGZ5Rb6Eygy0NkT54KWYyRY4B
	ZXpV1Q==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdbvr95pn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Mon, 19 Oct 2026 09:22:29 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-357e2bc3b1bso3319478eec.0
        for <linux-integrity@vger.kernel.org>; Mon, 19 Oct 2026 02:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792401749; x=1793006549; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JPhY8yd7nilzGQLPZJehSpMwbHwaeWfXH6IGdZHCFa0=;
        b=ZhrvBbMZs9Ohv/ZhZRqyMGSK2y6DvHZ3gSB77Z/CR0L4Ua/Dj58vP9mES9UK6TM1/f
         WwyKzUPZyqnQ8PfNRLFhpHp5nMnOeJTWSmUGf4S9kIMylx5BxA+h4/kvapeZt+ccg8d6
         iY/mqzkCihPxlJnUPcEsglbxnqqusfDTlwXM8sfc6wvsVbBqTyjSyUMqk4T/fbDD4Yv+
         gbuJ6IPlKQlLmJWTQlnAvTOeSiu0VFJ8TLODk4iWLLwwkUwZwscIToelKb3SnggJdl7O
         atXiIrTqKOM88tSkCYww4pOXq7QEHh1/5wZwrlZaRV07txci5m2RC1Y8eHZEtr3PuTby
         VgSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792401749; x=1793006549;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JPhY8yd7nilzGQLPZJehSpMwbHwaeWfXH6IGdZHCFa0=;
        b=t5i0BGuTIkBemhqAd71d3vMNhwFnKK6ORXuNpige2yoeJqKgZmcGw7KsDOoy3dvQzz
         Px30nmlZpdcDB6nFpVzHVoO7suNA+Xs0GcWene1a/nGf618uBgNSwrQtIvOXe8MbBXmJ
         oRA5ngWMo+AYdyfYu84kScz9rWIddV7FUX18fsPYrDqgJ+5tlrnk3oIZbH4ntSnDW5kV
         yuaGbnIgRhR1NrfqlZDwBQrMldTdVpO0evDmVSGwixahXiRSRqEcPdL70JgOiLsDY9ur
         zc3gyGxEAEm3j1NWtVPoOPoodLKAgvhE5bkPfNPRX0Dy31uaNH9MKeov1RMomEkgIt3q
         BODw==
X-Forwarded-Encrypted: i=1; AKwUvByNRfdPrIBR75K9RPA5zf9ceKEaF5nSRZbvBfSqd8UKlKbpEXGSN7IvKKH6NXukxmm2Itwot41tMVu0IG5LIzI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKJckG0F7lrhDSeSUsBiqNqaX2+dAIsjrfypjl0K95/U/CfH1zr
	1GhK7dqyNNANminDCfEZCBW4k0OKccFz56ZRSRcSAu/mj3tjjPqvwP9H8jBiVA3ZKE9KeO6EKu1
	6bLm5C7exwv+zKr2E1Couoe+2QXwBgbsAKlOrJH6fjVzLINidU6p6gmMLFaXKACLkMTo4/qg=
X-Gm-Gg: AYBFou2zJ4CcuuBXbvZL6ZiihsSjXJ3reCr2+GKcQODADopGIUhcZKw6QuyjfRwpNyr
	4uHN2kxIrOZSxYrJC5i1zgZCLrgH9ymCRHrIp90f5w+xBLTSGSKoZur92przteOq9US+iuM/XA0
	tphNF9jz6rkU/vFv1YLGeDeH7s8eAH0VFrwku51a3+riNh9mha+Z3jKLQGia2tlJEs2Ht90luMM
	xxmt6QKUZ6fjsm6yY7QqXIEF9DejwmYd2GDSwnWHhgVm/6EDEbTFlKAk2EbYrBEPWZw9q26kOXC
	E33D5Wg3g99FCQgQc77Z8qRd0TlBbKk+x/miwKLufdwsPtSuiVs311OiCQ/ybfC9Iftxelzkqyc
	zdZnt2hlK0vhA5YpW2tgzxvbu6Og0D9ef
X-Received: by 2002:a05:693c:6395:10b0:35d:b44:a52 with SMTP id 5a478bee46e88-361a23528d5mr10797490eec.24.1792401748794;
        Mon, 19 Oct 2026 02:22:28 -0700 (PDT)
X-Received: by 2002:a05:693c:6395:10b0:35d:b44:a52 with SMTP id 5a478bee46e88-361a23528d5mr10797467eec.24.1792401748285;
        Mon, 19 Oct 2026 02:22:28 -0700 (PDT)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36082a7b33bsm56225094eec.24.2026.10.19.02.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 02:22:27 -0700 (PDT)
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 14:51:48 +0530
Subject: [PATCH v4 3/3] MAINTAINERS: Add Qualcomm TPM driver entry
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-tpm_qcom_driver-v4-3-6889b9804ba7@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAzNyBTYWx0ZWRfX3CUW5UQqRBTf
 RHosPQumrw2lAPHHhqSMek8VNSq7SZJ5ASwLVwqaC8HXk+fF2pgmryCDBXmtx6MdG4MGttBsovV
 LZ0keEuvDwCaZlylkP26DQi7x3shosYwqezkC1ruODMWwN/O0EEaPuAci2Fsl83hotMasSFkipI
 5iyFpMpVk6IC9WCbdXpu5EzIGhWcS2ISndN+//Oe+RPpXIbSGEXUBJqzhZgilQMPR61h2nfAkKQ
 T23LeTrfacXTFEJgXG6rDFuKOu/p0d/rwjIhCow/LmXu4JYS01SpohCHxB5kbIBmvc+weQ4HLxv
 wmPffHICe2ZJKxYpRo7NLb4Qm1NGcJPIsRuLqecwcY125Rjoy8ORSW0Qa5XrI5rk35sg/ML7Ery
 u9c6kLo8rW8EGPqTRMPzsi3yXRTgKTUi8PB/3poWYX00RHqk4ph5D0xxbgGmSIgWKUFQ5PPIPeT
 JLLT5e69j+chqi6tqZg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAzNyBTYWx0ZWRfXzCBVHrOGK0IK
 so/sYtc2MUqb863RLsA+T4O0oy3QkeBtOo2JNbfdc8Dmw7xXKM7Q4ii9bjo/eUTyEmWhHhK1K1A
 emQq16U3RjCO5sTuf+YZVFhL+X7QKTE=
X-Proofpoint-GUID: FbBiXQWBmAQ8ATuDFj5miewbaRUZkBQU
X-Authority-Analysis: v=2.4 cv=K/+3jCWI c=1 sm=1 tr=0 ts=6ad5e155 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=tHMf5gnvwFDjO4kcr9MA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: FbBiXQWBmAQ8ATuDFj5miewbaRUZkBQU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190037

Add a dedicated MAINTAINERS entry for the Qualcomm TPM driver, which
uses the Qualcomm TEE interface (qcomtee) to communicate with a TPM
Trusted Application running in TrustZone.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fb43b8e46158..bb86a7c024e4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23160,6 +23160,12 @@ S:	Maintained
 F:	Documentation/tee/qtee.rst
 F:	drivers/tee/qcomtee/
 
+QUALCOMM TPM DRIVER
+M:	Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
+L:	linux-arm-msm@vger.kernel.org
+S:	Maintained
+F:	drivers/char/tpm/tpm_qcom.c
+
 QUALCOMM TRUST ZONE MEMORY ALLOCATOR
 M:	Bartosz Golaszewski <brgl@kernel.org>
 L:	linux-arm-msm@vger.kernel.org

-- 
2.34.1


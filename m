Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19EB48165B
	for <linux-integrity@vger.kernel.org>; Thu, 15 Oct 2026 06:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792046317; cv=none; b=Th/CcPPVC+I4apvIS/CM+Boc89FJplkY0xysdlzt6nhhRvBR6dc0tCFVBMm0QttcgzFC1wefWHwCb86vwmlpUgPCMkmu507AhoZ3oSlkHjxVrsU18AGpwKyAZRJz3rRmH3MimRrmiUMyDpFn79frehsgCX3a2AkOsaOO3wVDd0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792046317; c=relaxed/simple;
	bh=JYTMtNgj/5fZcL3ftFEkoott1ir+FEvQxYenqM4wIjE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VepT1Mrtn+HzIXd++S/Wr319lo1S36TnsOvB0ECKRMBxX77lbpBfZjsq1XLb8dsY/j6jG+etTPgOoQWIAqeJ9oFygQA2mEECyegkEl7BN3EGc20hUdIkl+7YMz2FaumuMtZUtqbM0FeR4Mv0LOnJfy4H40ALNJXKNj8xV8iCr4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TvXu1D1e; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=B3N5nEYx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TvXu1D1e";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="B3N5nEYx"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F1ObGx1707234
	for <linux-integrity@vger.kernel.org>; Thu, 15 Oct 2026 06:38:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Vn+PAPU2yd7dK7uPhM98pxh8Uq/TtLrKIIgwoWoqb3U=; b=TvXu1D1ezG/STOX9
	8R0AFj1gTvm2/nHC15+MuZiqzspRvk1HLnKXf4UGL7aK6ufIT3D82+PG4lYDENed
	2FEX1L/DHyCgsk0SpV+bJMV7i5db5Wksppsd6LrHXuWR954+54infdTFRWAfc6YW
	bZv8xx7yq1k2Hzz3L6Y8Qyh6XKQCljvo+zVecVDMW3aeMfXRxmXaQI9qxU0dW7fV
	MUSBOlwWv8HVFwqdnE+r32Jx/13swZ3AyVazVPPCzxCQFFJzb6KbqAZEKPMKH2xn
	PwSz4sp8WioAma1ICiJPmSgPV9rCceidSbBNB0Y7TIy9Q5o2t0f5IYzAsGWxt8kt
	aSeeKA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4han54s1vn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Thu, 15 Oct 2026 06:38:30 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3ac575a9198so1769129a91.3
        for <linux-integrity@vger.kernel.org>; Wed, 14 Oct 2026 23:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792046309; x=1792651109; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vn+PAPU2yd7dK7uPhM98pxh8Uq/TtLrKIIgwoWoqb3U=;
        b=B3N5nEYxZ9ZHvBQkwV6Lr1UQD+n8zjUI8xSG5EE4LrzfycdOhNqYPWGzBCA0BqtaNy
         CeMLdFXiZ/3/cePmRPMS2yLbtdNxGJS2jpT6QCZVvrvxZzoyfADq1ZpoyXBqdoi6k1Tw
         +LM7jBF+9fwRVDTy9hS+TU1nHeiUIadaU++m3rt+XVW1OG7R+cc7vW6GdGiy0ciGNaMe
         SCW0yUcfWV4UD5TRpwlUOuyi1G6cglHmvZMSyGjj5skix3TxLp/gF9EITY9BiozNFjew
         A4TqioqTii3RNWogwu2DJXUTKKths8yQN3Fyg67P0YMyBaLNcEMQWr0uiD4iSZCXWMvD
         ZiAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792046309; x=1792651109;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vn+PAPU2yd7dK7uPhM98pxh8Uq/TtLrKIIgwoWoqb3U=;
        b=QFhh7SgFzCwlAzHv/9VVUwZvZlp8mplpE+H6uOmolfa1HEWY4jxp1AJu0HRZAgbiWg
         x2wIFsVem5AtH+v2YsPqtlNnebrXr+fmqAgrNuO7aOiektglYoVr4d6Chn+b33z3UAmx
         MSSSwbW9YejruBPUfEQn2UMKrC1hx7J5XbGnGkEHA3egp2lhA+PxXi8piGloNa0YxObR
         BYI8gWmvpwYvAzIdmad/gd1DUCJAmymm2ZxQbkve1k/tr9lnpnzfXxq6JYzhFBHz4B99
         GmhR1OmXWnrPItkT6/vdUkEngp5KIyu0xVZepNRtuJMuHYSkPKqevFwVBM8wI/f3LJq9
         Rkfw==
X-Forwarded-Encrypted: i=1; AKwUvBx67orhNYjEBWnrsHIsLxBlaDpRsvHLpnMJ/Mh/RsxYxzpD8GxqP1oaD8RacRrbUUd0GNsmHSKxGIL4/qDFDwA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJHuUIAwMPCNf6gV79hqqxlh/CDJrauVpuaFqb9COjVD9SSTqsg
	qcTumj+n7UeWk4iFNGhP3Tz5PWa6SSpq0ir9yoZteFNt4hC6sgn2GKA857up0X/L3csBDdJCMsJ
	+ewRv675BgF6Rv67/NQt2qdlX4rGqNMKC/KhejFtNexuF10G5KmfcCmPNXah13Rkqw7D9Tuo=
X-Gm-Gg: AYBFou1MN0zFgyTyjItyWBiTGfqw9ZImctecRD5cIQX4sAImGgOZVfkHIXQSleYl1Mj
	Ag8vP+JZTIZy9DtWd18+cp8TTwXVZ0AjJ4hzDqVPJ9WYzsnDw7nNEtB9zcy5X7ulsE8AaYKxTkp
	az8t2IU/gbq0u3/m6X/cXwhRkQgu8Kxu/3VyOIvL/jNMMhuhL3yOX9VyXuPYD3gj5+rBktbu8yU
	fw/UgNN9qPDNZGfkdZ4QUM9nJ+0MMEdxq2AzfCOltF7wxSZtBLmr2BQW6Ia/sBbTETwitIzc6+U
	FrV3vYoAsOZLKOXUOVfpwKBEWqFaZynAU21jOFTEa98WzvEgtmAhHBZwcE3BBnxVLSJ0LAqhAVO
	DofDWSKIYOQB6LDcd7UHUWmhBG1ZyGk3+
X-Received: by 2002:a17:90b:4f4c:b0:3ac:7377:fd48 with SMTP id 98e67ed59e1d1-3ac73780712mr3644505a91.56.1792046309425;
        Wed, 14 Oct 2026 23:38:29 -0700 (PDT)
X-Received: by 2002:a17:90b:4f4c:b0:3ac:7377:fd48 with SMTP id 98e67ed59e1d1-3ac73780712mr3644492a91.56.1792046308950;
        Wed, 14 Oct 2026 23:38:28 -0700 (PDT)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac93ff4474sm2844429a91.0.2026.10.14.23.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 23:38:28 -0700 (PDT)
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 12:07:48 +0530
Subject: [PATCH v3 3/3] MAINTAINERS: Add Qualcomm TPM driver entry
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-tpm_qcom_driver-v3-3-247c8e50250e@qti.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=RYQFmFtv c=1 sm=1 tr=0 ts=6ad074e6 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=tHMf5gnvwFDjO4kcr9MA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAyNiBTYWx0ZWRfX1ddx/LSD9YQh
 FqMnBVbmXzo5w14C3Cg4w8fHmGhgvEwp9XuV/EQ+QdtUQ5irB0vRC5zDHE0naDH6g+eSNiNJ+iq
 PZB+dir4dr0g9wMbbMH1QJecJXidMTXhfDChemP1rkSS4DMlzVRtPUfC/7KLFlWn1V9syHtJT57
 dm0CvjwRKp0yfENQUnfzTsmBoCrQZlm6E1i6SiI8hFSqM7Pkho/7VUSI3DHN0YAQtSJ0jFQxljI
 6zPaDCBurLDDzJqRu/ZBoWjCXQJTuUl6xeLaY1C7SwpgU9yCsQsa7OGl1kL+MmeVunFBDvaaXS7
 X5aptjUKWzLeGyx56WfqMaFm/9t8GwzV3cpU9lQ2GG2zJ6PSyJuTdT9pEUeFvuDqe1BTyDabyw5
 Sm6DsgU0dE6kvsVNkDa+8Z6H9Oc+qIMilNWLDy8DnvjRIEhDHuf4PHti/lQj9c/YOaHkbQYWj5V
 e1HTtfx0HK1IZzKSQOg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAyNiBTYWx0ZWRfX4copZvDuuzzY
 YiSrgvHAqbR8RsxcXNssRMs8gVXUOKwUwjb7LhFpNqOLhB9BcwSKIGIMq4LKt0FIbuLoVgHzg+g
 yFpgdSD+qD6kz6MqecQfx1/gLVYOO5M=
X-Proofpoint-GUID: d1InNYpI5Ocr4dHAtEJHddsizx7PGGB2
X-Proofpoint-ORIG-GUID: d1InNYpI5Ocr4dHAtEJHddsizx7PGGB2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150026

Add a dedicated MAINTAINERS entry for the Qualcomm TPM driver, which
uses the Qualcomm TEE interface (qcomtee) to communicate with a TPM
Trusted Application running in TrustZone.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0426fc05a66d..618ebcf39ca4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23124,6 +23124,12 @@ S:	Maintained
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


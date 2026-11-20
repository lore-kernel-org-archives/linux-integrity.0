Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795172043;
	b=ATrfHIIPkEnyURTY8awhqw2xO5sPCO7gm23lLM1YgcdLQB1MhbKPFpfOeGR32+oFCpuw
	 PUzbv/wMsMirnj9Uik5Ad2qya5jLlRvRI6lFnYKs6aLJBEMnky6E5vPpEeJjEhD6WrjQd
	 Pv0Sjsly5noavSt+Y/NGYITwzPVX5xa8OlqbsqM/PMOlr5iZVLID4NMI27FtOW3xAF9tj
	 ruSsoEQxSK7bTBMNNB477fm8xptGt3MrjjeeqdoM7NmNlbxuxUvEbM1wuWgH4O9q7OCOV
	 JpNdLqoNzoCn7FEpsrFoDVPSp5qDgkeF78kSudx/gsWwPfCUnUASCMPS1hfrQORxW8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795172043;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Uj/gif/EMkxaB651vPrPhFUEprfbTV3srXkqqMvLfTg=;
	b=Vp6EtkinCTJ4vKKEKjEsoVelRWUdUX/LjSrYDbDaGgj9d6LOAq3wwy2h+TnYL9hG9+jn
	 UYC9644TkYrnsa7OPhBAoc8X2OmCuLVaXcE6ibtk/ELQUtS+rcVpDg2qPyxgJsVCo9S48
	 O/oai6tOarqHnHqF3p7lmA9DwmTWqVPr2bxbRl8uL0e5WVQuFHw6eZjiGnrpZKUtSHmPx
	 yYMAApXApJYMgjFYe4nBIOvoRr7DQ65QL8cX9nRwOvUh8Lt3UUIvqyv36jKzDXGao/1s4
	 pbkLdoGXtlFZ7uyDYmKZdSWgNljpYAMq/1UpKYakXRBSdCU2wCIkWrdAs9wbMxn3ylg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Cen6HUbP;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hNugXNor;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD72760A260B
	for <linux-integrity@vger.kernel.org>; Fri, 20 Nov 2026 10:54:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD72760A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Cen6HUbP;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hNugXNor
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKAjrek1681908
	for <linux-integrity@vger.kernel.org>; Fri, 20 Nov 2026 10:54:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Uj/gif/EMkxaB651vPrPhFUEprfbTV3srXkqqMvLfTg=; b=Cen6HUbPI02arLjb
	pxF8ifzkAJZ+mH5QwSnReeuz1PFDh7Pi2WJZKu14LG/Y7PQxapT//KpZAAH8qOcC
	JVAZ2Od7N879dZDBaLK3EEkrza6jVjIFq1AFeLOHNW2/RObqNi2zOirxvPCv5MKZ
	fisSgG32nyhGSteM7zUCzKUD+zBLFBgQNUfoB8FwU825XylQidGyithQxbR+hug9
	HaiqaVGTW9jdycB//UD094P6TpkWwVOuxM1PoV6/k4tcut7quInMURNpU12ArA86
	2pebd22Ijvk8ZFOrw6kQvD5dD9AqEtIV3D0FLjmo3c5Sm126agQ+66wZy0LetMo5
	bYITgA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2cd1t2dh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Fri, 20 Nov 2026 10:54:02 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3b191f8a9b3so1238578a91.1
        for <linux-integrity@vger.kernel.org>; Fri, 20 Nov 2026 02:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795172041; x=1795776841; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Uj/gif/EMkxaB651vPrPhFUEprfbTV3srXkqqMvLfTg=;
        b=hNugXNorJmt6F+SEiinSTWkAzywc0ACXmsrtvVsMeDEssWEa35nzaGP7KfiaCVCQFv
         KytgTwVhI3cagvosQmeSC+snKOim9wjL19+ARWfq1Wo2NrF3UgLHtwtvUM580buJh9Xa
         iHwydpzbByR2RVq24/J4pB+QovyyW094mQfcdMtczVB9TSau6f1vhfteQjZ1RIYU5gWY
         5oQvcZK6h2mTTFJ6nRBcD94Mr87Fyf4tY0cBNTyaC70dg6+ny0vEUSaEMYlG2w7wnB+F
         3Wa3wmshPifoCV9mOa1cr/U4rJ7bAcMm5PsOZ+ZAgZL1gLGOzq301Xj3ACnkC01uFkoZ
         FR7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795172041; x=1795776841;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Uj/gif/EMkxaB651vPrPhFUEprfbTV3srXkqqMvLfTg=;
        b=p5bcYl6E3gUOMt1s1agfnwpb6RsZx+Sej8g2PBJXSOiFNPCbhBQU7x98oavAwcyjUB
         BWSJrC3q8p2ZhYZ1umqk0R/5E8Fgoq0m5JL5jW9QAOL/A8q4PDKMNXlbhwKctGIk1DNa
         voaJqIchnBxeAZDxqyN+6h9AE4eo3w5bx/W2Tt4aRHYNi+q4ysoMBE4X7XpUwi0OO/nW
         82WetaFr1+VFE++jtnG3xcEOQWlVNj+LkwezLC9s9zYLWj32pbrlkI68P5ohleAVeXOE
         gl7GRZ+PE75iGDK9Vrlt/QwWrTAddB4gWvg35vJz3lPZJ7Ma4uLU+/twz5p21IRGLWIU
         Hjxg==
X-Forwarded-Encrypted: i=1; AL+hErEMol0OLJ6rSsE05Wpez9n42ZHHdBwgZlP3OL3RZxmRaTE7566AVn4ptq15vQaVz4krY9Vl9xMnd/3z2JnraXI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+YxFlDawYjjcdI/GogO7a3T5sL8UtUZNK+2Pfi56FM73gwNkQB
	KfVppqM1FVKwZFhqkIvfvd9Cvg2OKCyH0xXSp7PbUBt56LfID/rO6m0rbneLry1IYgMrTP94Ykc
	c8j8W0ldebpt4w28mVwgF1eoJLxN1mK6fSOUdGJ2WhIStUhp7ORRYfR12EBM0D2wtDeoeFz8=
X-Gm-Gg: AZFdTZce8hQWEUHD+MulmAiVNJiy6sMDhtUK2BT8PpdNsQTepCeGnDionVPtHBo3q+V
	R2KlkLqhRTIf4Wz/KQrhQZLnaU7DqRNYv45Pf6ADA+soOFouxzS0xA/udrzt1de0V9QV6pY9/PW
	nYoe/ZdLBw3OyhiWMXXtzJWQAwebR5PrSXE3SUn10y1k168Y/FXkIJeDl4LxEfu0JtqSMZrwqNb
	dkaNJzEGd4VPEOh+WL/NmmPJx1TejBpGr2BIXsaES6OkIYTpJSSSz1V69KzDMlqwvYTyaqRVTt0
	SupmChyQanG/PrCVtToAvb0AcgnXXEd9NHfw32/1kvNM0OGG6zlXm83qd2bPaqohDCQFY2GB6Vz
	yIHWlvQDKHaCgsXUkVuBcsq1fC/UgKvJ3Ac8wVL219QTHm0H24ByMINRKriR+Haavqg+ioPPB21
	tqw3hWo/U=
X-Received: by 2002:a17:90b:3d8d:b0:3b3:b704:118c with SMTP id 98e67ed59e1d1-3b41cb4f321mr2403016a91.65.1795172041440;
        Fri, 20 Nov 2026 02:54:01 -0800 (PST)
X-Received: by 2002:a17:90b:3d8d:b0:3b3:b704:118c with SMTP id 98e67ed59e1d1-3b41cb4f321mr2402997a91.65.1795172040980;
        Fri, 20 Nov 2026 02:54:00 -0800 (PST)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41d22888esm1559604a91.3.2026.11.20.02.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 02:54:00 -0800 (PST)
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 16:23:34 +0530
Subject: [PATCH v5 3/3] MAINTAINERS: Add Qualcomm TPM driver entry
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
Message-Id: <20261120-tpm_qcom_driver-v5-3-3d9321ace107@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=Dt/Da2/+ c=1 sm=1 tr=0 ts=6b0026ca cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=tHMf5gnvwFDjO4kcr9MA:9
 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: 9h5HGUPXXu7rXDDDenshJoh4BetmoJaq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA0MyBTYWx0ZWRfX0uKK/cGf2nwZ
 MZx4xoLOg4eVQwgaIWdnXYnXEVmZ0bLME+4dOBZpLr8187OztykK+KNgq1cmaR5BOGztrbdWIGS
 stie+9GFAxZDLsYxt2b9Zev7BSF+LDHS4J06Dt+PM+fdbuT8BD1BcAN7VUeQzcVkjDcqx/y7faW
 7zgDV4OzbezVrCX0mbggQ6m/437YyrujTAW9pikCuqYiewxcWqZ/KKeJ1dlOWZhZ9MUPX+6dH01
 TL1Cpg8DEs2N3MXwm2JynzbFInfqeDM3LQrhKknAVKGq46Uh3mHFqtNjepPPIgX7DkyaFpM/dMi
 yt2cTzzCS6yEJaxDHfEcvAY2nBeJrC7dSSYmJZldEhGvL8zieoctlq2FJovYZ4uV99w1CBRp8Pm
 VCu0aLUgvC/Z/8Q7HUx9u0pevlMBsAAtZVwacVCSM124g+A19JF9HOREwtCD3R97pDnNp6R0n0Y
 cVBRjg/rH8rX+3Qk/tQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA0MyBTYWx0ZWRfX+LgsqRTUeJWs
 jFOvI4NSGEaE5VJtDZOUmnFPJZnPwLQuPR+E+Ifq8WRrIZ9UoNjxhDB9Qg0yXOo3w8PaehPC2X5
 CizUKN+aG5hrWK6wYRN3j/aEn7k47Ao=
X-Proofpoint-ORIG-GUID: 9h5HGUPXXu7rXDDDenshJoh4BetmoJaq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200043

Add a dedicated MAINTAINERS entry for the Qualcomm TPM driver, which
uses the Qualcomm TEE interface (qcomtee) to communicate with a TPM
Trusted Application running in TrustZone.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 733719f400b3..bb80ced07840 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23435,6 +23435,12 @@ S:	Maintained
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


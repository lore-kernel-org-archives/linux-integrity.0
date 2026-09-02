Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2D241A51B
	for <linux-integrity@vger.kernel.org>; Wed,  2 Sep 2026 09:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788341245; cv=none; b=qLKPNEi8wlL2+OxPk/KjUMrDAKG4w9o0k0ZryOo+zedVqJginEIAbqAcUP3CZdzAxkgrw5FCNCEkpPFMoAUCFbbqTJdXFEmq5IK3omuYnbgzKdgDUZ4zFiUIAfZG5NX6Yp9CGfROBOQVqNycFwQixMvsJo8/99NgSP+AAPRJxeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788341245; c=relaxed/simple;
	bh=4RrWg3YRAeHPQUzHKjgVo28GNnYT956K15imGLTP8yk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gh2SD0lpWdWAZvcQByNjD5oaNG6hTazObbUJE87dk4ceHgXr8r+BX3ABrI31weYlwSwK3p+MgDwiHcuyVRbvn0Hyp4uWz1TLYUniaHL0Z0emj5Lm5PLwj9bpEWHHQiSxnw6Z46roE5ROfEoPIEyvYA0bdq1WZ7XKlDvbjEASinU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CVF1nDol; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=c0lSWEnC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CVF1nDol";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c0lSWEnC"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6829N1FT590064
	for <linux-integrity@vger.kernel.org>; Wed, 2 Sep 2026 09:27:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gNLzMLJZKI7OImu+XuzOnLBC17S6dnkYMkkwnpIHzgw=; b=CVF1nDol+hpZwsFS
	MOgvCBfb1EwOK0kpu/Z3JNm/mxhLAgh54XhaeCGkXwlxAj2rRKgmNudMadzRAUB6
	6VIahtjrGJKoReOrZVYXLEGFRr340+g4JsWIFwWZl2yCIersIw0MU7Bnw//mavuL
	OoTVWoM5YAztEdwdxd0tLDEnFQIeZ/iIuIuyGb3gMKKvSXd43IpYyfj5PZ2a24Vt
	PyLbKWBXkxzhRWd6YLdV0QtDLb/OhlYfmF0+BJplbFO+QH6WDUNfJ51h3pEwYY5U
	UyToNEgTyeLhWpkb0DJIjqLj5adDzsiqMKWdNWSDFmnc9pGRy0KLjsp4mSavnPiK
	41ffjQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ge1wpbpfg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Wed, 02 Sep 2026 09:27:20 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-396b9ef3070so1563053a91.3
        for <linux-integrity@vger.kernel.org>; Wed, 02 Sep 2026 02:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788341239; x=1788946039; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gNLzMLJZKI7OImu+XuzOnLBC17S6dnkYMkkwnpIHzgw=;
        b=c0lSWEnClzg2XppVrp/7RBMKxPMYeYw6ZdOIWskOhVe8iyw9qJ2WjXstbDBXgARjrQ
         g54y8QP2fp10TXB459oa9w3EKlqSTVqoIT+qIWhUEEXpdmLkttSExe3p3XhzrGRcjb4n
         Ig4gEIZPtGvXKbcjjhM9IHYwmJnJpgl4CxyxylJwGlhKJYEtzVX1ktXu8SWOWqKHwWyD
         rJyoTiyYaJ2cW+QMWyAfgkkqwrgxpOCfDfrajV4AXg2TLL9rFmXl3VgSYCEQpWwZVE3w
         /cMbS50srO2deGojeHs9igKmKqi4lUMhJ1LupwkM0atSwwWT/EeH9Pbawoje/4onPKKt
         0dpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788341239; x=1788946039;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gNLzMLJZKI7OImu+XuzOnLBC17S6dnkYMkkwnpIHzgw=;
        b=ogNBXsP601b37EcjC44XpIOLce8gxzypOW3JvH1JIQjqScOWj+pFX1I4pGWkJLzhNx
         DZMjZNyqJ8n2ckzAakkK42RszGleUdNI3MYxhTW1MEoKA4Vum2Eb3VzAIb3Gg7yGZGnN
         wvuuTaFbJ3moCYsuI4fj2FCtnt1+gCRq8URhxqH1U+khKBLYrvZJv0C9HhcRDpumNH5+
         ZxCz4fklt3AXw6HheBGMx6gXzR8xOnm6aE9BR0qwVB9j5GSfssNYBN/Ecjsnb9px63SR
         +l39DjhJ/3b68tNi55z+MIB/L8TNguNSohLZLFS91wWuWjI73DI21wQ+i2k2ZqbpE/Hz
         gong==
X-Forwarded-Encrypted: i=1; AKwUvBxRxLYnUl6GHVKMSqDkaAdGsp0ee3kO9pEmz0eJ/fDYf3bub+CUL+rWEOTn8fC0bVklfei1aBlH1gRei+DvAUw=@vger.kernel.org
X-Gm-Message-State: AFuF++lynIJHxlnjK/CN9DB7hAbVbtwn+XV5fhVzsvAtvx343KI3x4+G
	YxCkGG9eXPIC7sQQyMV8odxCcKuxVnQh0ovq3TrTEQQ1G5glc0gk7ys1eIfArd2K1yX7G3htgZ2
	t5MjNyo/4aEoiDa/f8TJbOXgSrNN7ZxKIUvyX0DdG+FrU+HtIoUr2gX1UZYyH8yqebZx6W9s=
X-Gm-Gg: AYBFou3UrTFT61WeKNV119B0nlWcRdtMDXcq+DNHonpTeURs2OudJewYrNUwPQS4Y74
	pC5WajQx/KmIePe+B4blfaACJC2/jI3gWtjlmftzTIUxHxAtAUIcPhY1hldDwKbV0ZAOaP3H78K
	NXXtLYftmyOfhyv5bBIfI5TgHZmETz/RFHB50KbaN3fzQvOJKmE8HpZ9q9wdcQbslXs44GSYSZG
	gHDQUQEqEgamKx/rXrs5d8i4HdzT3YHYPJ2Y5/AR67LugjTdQuDrK+p6MSH0CdqEzEKZe039G0p
	R1wbRmtpyDJn0KV0PLamrmCj5cQHVrP2/rfSs36FLNUXSK0gX8e/6sSS1AaquttwMSTij8SLSZ3
	czAidDyn1SyeOqH/MYow2A6BGFpFm0TE=
X-Received: by 2002:a17:90a:f94f:b0:398:bacb:1137 with SMTP id 98e67ed59e1d1-39aee21a4demr5659444a91.19.1788341239437;
        Wed, 02 Sep 2026 02:27:19 -0700 (PDT)
X-Received: by 2002:a17:90a:f94f:b0:398:bacb:1137 with SMTP id 98e67ed59e1d1-39aee21a4demr5659371a91.19.1788341239018;
        Wed, 02 Sep 2026 02:27:19 -0700 (PDT)
Received: from [10.218.31.125] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1430e9eb4dasm8445304c88.2.2026.09.02.02.27.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 02:27:18 -0700 (PDT)
Message-ID: <54de34e2-cbe1-4464-b186-3ba242ffe3fd@oss.qualcomm.com>
Date: Wed, 2 Sep 2026 14:57:13 +0530
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] tee: qcomtee: Register qcom.tz.tpm service for
 discovery
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
References: <20260831-tpm_qcom_driver-v1-0-6f16fa6924fa@oss.qualcomm.com>
 <20260831-tpm_qcom_driver-v1-1-6f16fa6924fa@oss.qualcomm.com>
Content-Language: en-US
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
In-Reply-To: <20260831-tpm_qcom_driver-v1-1-6f16fa6924fa@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=F8JnsKhN c=1 sm=1 tr=0 ts=6a97ebf8 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=3Mugy72lF2TQ84n-Z4MA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: 81Xh8Zj2aseo7fe1b9yraFQUvgkimyVn
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA4MiBTYWx0ZWRfX1BG6zIi6muE8
 qWu3gabKKiUA2j30OLpvQDno87uSXwZBGJ8VEFZIzFcDI/CtszXlNANDydxRN9Qh39/sKMu5CTY
 7erdQZeNrR/o0k6OguvQRUbSk4fGa6I=
X-Proofpoint-ORIG-GUID: 81Xh8Zj2aseo7fe1b9yraFQUvgkimyVn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA4MiBTYWx0ZWRfX+WugvDWxzl1T
 dh+kkzRq5aBmcSs4oEwm4GvWSAq3QpumHGdDh3/0InLF9ys9eKGkTr54H4ojpxahrRDewDRMlkn
 TiIBVudQE1n7iHFJ3EszsmdOtzOALfsG1gxbu+aBjtlZOhiJ/evTtmTknHKIcT41p5MTFmqGXpf
 2LoOCUUtQEehWy8NBIYygul4blEBFvQatcy+y83ebeJn/Jt2sA9vMxVdBa4f/97E1+FplsEswbI
 6TH8tH4G/7qF1ZJLPNpWoojmOaYLdTGtrJrTpVNVJ77OYHRSHXfvxzehWtcHZuVksxrHFefgvzY
 2R5iAQt0C4y1+WwSD3QLgADiQKZMm9khJGoTawe1d1U/ZEX3JkmWS/b+euHW8dL46Ge79YEi2vz
 o/Neg4sj1wkZ6cM7xuuf1pyzz63fGSBIeSXAcKq+UKRxLHh1f4VxgusH3ZW8OeHgy5HWkccNPON
 4h8U7t7M6yOvhFrFG5w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_02,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 malwarescore=0 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020082

> diff --git a/drivers/tee/qcomtee/qcomtee_msg.h b/drivers/tee/qcomtee/qcomtee_msg.h
> index ecaf8db67d45..888611b801c8 100644
> --- a/drivers/tee/qcomtee/qcomtee_msg.h
> +++ b/drivers/tee/qcomtee/qcomtee_msg.h
> @@ -106,6 +106,8 @@ union qcomtee_msg_arg {
>  #define QTEE_VERSION_GET_PATCH(x) ((x) >> 0 & 0xfffU)
>  
>  #define QCOMTEE_UEFI_SEC_UID            413
> +#define QCOMTEE_TPM_UID			489
There's discussion ongoing in QTEE side on keeping idl with uid 81 and
not a new idl(uid 489).

I'll update if needed in my next patch.

-- 
Regards
Kuldeep


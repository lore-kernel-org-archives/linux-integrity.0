Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C9349DB89
	for <linux-integrity@vger.kernel.org>; Wed, 16 Sep 2026 09:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789549387; cv=none; b=Odclh82/5YZaemc2K77A6Ze8iPA11AbpumMCt6usqkso5myDVi7vLihJODDzng983b6uS4haMkdvdWznTkCd3OymSm2xGXHC4Uyao5e46giRc2Nu9MAnq7J2xapZcawefvzu3mZ30310Jj9Iy1OTFpUIDqAs7IjtooxMWP1+odQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789549387; c=relaxed/simple;
	bh=8UFeeybC4bmuxiusNOrf9sVTHbKx9+PFb0qkWwY8hmM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BBURix7p8m0+STsyZ7O1KYWWvqwntfZkmS7byelxH31dUTvfOVsDwWdm6MVjsg0uEglmlODawt9pztx1coNJ1j0sN2OQdhLClyeBGg2Uu4MEbZyEYCb1v/RvOckV63hqf1X5oBQ7AeQYQrD/t2LD6bJhMbTWxcKxiUWLE68otD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jkbt/Ib3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VL5M4AC7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jkbt/Ib3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VL5M4AC7"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68G92uPb1721215
	for <linux-integrity@vger.kernel.org>; Wed, 16 Sep 2026 09:02:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	r3NqAKzdAq254vliErom2NOcRQ+52lRi7cu+PTb9OTg=; b=jkbt/Ib3oZlFP/qY
	vx+fBsJvf/urm6HHBVNHJEfqN+K+1JycMarvEp7bms6ylGjyamQbsxxNuq8dEjQW
	8aCJo6pmz0ThQb0ww59Iu+Mt++3LWirm27pFMU4c/9zi/Stlz+FHxXw/qLaw5TZS
	YMulhlCOH6ZKCujjdwzPW+YdWgFwMjyYTi+MQGYguwylPkYQ+G1X6bFPtG0+wBCd
	/aPh7oS5HERU2ICluTxLftnoFtiaD1YCL1oRzVyKAsV6SryFHcOYkBEZ7ngnstpY
	g3VVCmBTxjoPKuVci6udACnFTxZsq/Ieupa3DZEmwSnYSnpruBwOSruUfiWYQnBq
	EVp1aw==
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqbmnk007-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Wed, 16 Sep 2026 09:02:57 +0000 (GMT)
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-6c2549d0cbaso7548892eaf.0
        for <linux-integrity@vger.kernel.org>; Wed, 16 Sep 2026 02:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789549376; x=1790154176; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r3NqAKzdAq254vliErom2NOcRQ+52lRi7cu+PTb9OTg=;
        b=VL5M4AC7hsBJ7HHuPMEpnYzQNhi8mJUQ4J+fRx3RX04ddN8/AOI6FBJN5gSyPeWVlG
         oe5LX7EypUpYOr6E3l4/IEnJc403o4aZvq709+h6wJibJrNJeevyjvBc0aTI5MODV7lL
         mcPTX3t+m3Ql+ofLocewEceupxEnu+WolM6iFyaGBMMZpvF4mvfRE3kOlS4j592A+kKh
         B6WChEL6Jn6BySBnbEEjX/rw2/yKINJYFk3NhXZMAbl0rVKzCTWmv7WxBkNxzN+VM2ft
         /uwCtBBSkZVRzyrP7NZ/Rc7c7yaVrPdYUu6vgwT93YwYHP2lmR1fmxrF5WYrbHt1J/Zc
         Kxcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789549376; x=1790154176;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r3NqAKzdAq254vliErom2NOcRQ+52lRi7cu+PTb9OTg=;
        b=r0UaKxC907DTC4i7W4UdYNNa6nfYd4QfX8UYdcMnI5I9EUYqVtaFNBwdGZ7tAFo9yR
         RyiueplLlb38lxkyv7TCWJ1MBQQ/BslIEbnUJEg7YNpOH+jAEmlj6CLh1jsZrAzy8PEK
         eL+uysDBZzjs82QYAlCZYmVzq8F/C7Icf5mZUqcftOFi6jCf0EWQ3QSnvaFEbNnIW/lp
         RZ1bWFF/un111Onns9Hy5a/yxhrWcaEeUcgfOOnoO9+nT4zODiZfv4KRkvGZXvkCQF6Q
         iCFKYkjMgqpQYQFbP+/r9C4Ni8BFTKSS97YFcoU0kPa5/VNkYFF13/L9HkGtyjhZJu78
         Xw8w==
X-Forwarded-Encrypted: i=1; AKwUvBxSMu4byVF2wkD8D25BQAYQ5SsGK62JqDIdDzLQ4BmuNjQj+VWGfwnZndROtJygZWsqNHASyO/L1W3WRXGOD8I=@vger.kernel.org
X-Gm-Message-State: AFuF++lTv7IQHIwGuMM0rmqcI5ay4nFmCDQbh4CA4PfCwhszSdP6Yig3
	gntQ+9I6WYJJSrbFJwrFSML3Y0wWbYq4V7nO7GPtk/fOQQy/A2DC4C3Et3xyyDBRti/aJnlJgUy
	SSNAmZQXP5LDId1JJMWY2YyErq1YgsEkA8g+YqIWq8gnrcDMESDiXgycGUFebTygHH7qj7i51VD
	xWFIY=
X-Gm-Gg: AYBFou21LfOSZ2a1qSGERDsJOisfHERVWUeuJpFtJpp4EV4fP8iYxBfNCz5H8fZS9E4
	6PZmzViSBLiSxDe6+vnl9R6vdVbiXQGV77jSaDHa9JbGfqgOuNpk4+MAHz3HRrbOCUeSKPqYvou
	uYE/LfjesMwlMKWCiCn+3QyWX5Lt4jqsiZyVOPxXDAD5jqxbaWxuugIbmV9SNB/wXWC9+IrP7Lw
	+bqBrHoPzF6zhVxWSw5sOpDx1CETl2LXOuxSwFVDiIsynAtB/tIWCeWn+Old9MaqFkv7x8Vr7Vp
	kvryTWRVfN5ghjMAi1UpwxAY8eKgC5+KJGF0oqiF+AZvQSFp8jm5r/4QnsuVKZgFsylOWhELNlD
	aV/auJD31UhKVklE2PWWLuHkkKCMzB9Y=
X-Received: by 2002:a05:6820:81d7:b0:6c0:e39e:c22d with SMTP id 006d021491bc7-6c7d48ef8ffmr1847057eaf.53.1789549376032;
        Wed, 16 Sep 2026 02:02:56 -0700 (PDT)
X-Received: by 2002:a05:6820:81d7:b0:6c0:e39e:c22d with SMTP id 006d021491bc7-6c7d48ef8ffmr1847014eaf.53.1789549375491;
        Wed, 16 Sep 2026 02:02:55 -0700 (PDT)
Received: from [10.218.31.125] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5aa1e38sm6413732eec.16.2026.09.16.02.02.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2026 02:02:54 -0700 (PDT)
Message-ID: <2e5278bc-5f11-43f3-8e9e-b70786a697b0@oss.qualcomm.com>
Date: Wed, 16 Sep 2026 14:32:49 +0530
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Add TPM support via Qualcomm TEE TPM TA
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
References: <20260907-tpm_qcom_driver-v2-0-71a6b1752da8@oss.qualcomm.com>
Content-Language: en-US
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
In-Reply-To: <20260907-tpm_qcom_driver-v2-0-71a6b1752da8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=POyaavqC c=1 sm=1 tr=0 ts=6aaa5b41 cx=c_pps
 a=lVi5GcDxkcJcfCmEjVJoaw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=QTb_0JKWY7oM6lVZCfEA:9 a=QEXdDO2ut3YA:10
 a=rBiNkAWo9uy_4UTK5NWh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDExNiBTYWx0ZWRfX6RvuDSz0YXrt
 SKk7JBWrJF0ja0hc8AEb+5jbw5RVAK1HonWrg+xwaEGNkgmAW7obc76+i1pFnjp0EdcK84gMa9y
 DNosSJia/vdip93082Q3Br+eEXUWKiv8Wbg45CJMxg2MhCj1HayNOydRUJooIa5G2zreJVyWuuS
 rFrw3b4uC4uqq0CFdYPagpxRlLHVi8T9Ia/lGO+zjUiPasIKsMPDul5EG0j+hVPvSrkz2xQUa5/
 NyaUr/s8W2h/X+CWjooweDXW6RJrgPLVZfIfwbzjQd1jAfjpz935KL/7aR2QaUFkn0v5vOABXti
 sg4pgU4/lGrCjAUcP9uup8JO0GV5G1SoHeGtr0a3PzpiKjoNBldzI8KjDWx0DtFLYDJZ72xLFBg
 NquA0L3HEQfX1u3jDsV+UQgb0KLBr46avVP/abLGNvpUkkDz7NZE8EoijR1Laze3j9aScO5rQ4Y
 f4mFGZLl4bVe8R5ZXag==
X-Proofpoint-GUID: WIlbhyrrq_kRX6QopAqUnw8c_gn4Yty9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDExNiBTYWx0ZWRfX3N/OvF+/4/BQ
 qCzqohukrbPXbhIAU4vWzYEtYRyesOms77SOCNytc2jS9O19BDK11k9ynslkSAPXkErM2NpI00F
 t8QovbAUl38HuRquHBCV3LyWIhYSdLw=
X-Proofpoint-ORIG-GUID: WIlbhyrrq_kRX6QopAqUnw8c_gn4Yty9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015 phishscore=0
 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160116

On 07-09-2026 14:58, Kuldeep Singh wrote:
> Qualcomm platforms with a discrete TPM (dTPM) talked to it directly over
> a non-secure SPI channel from the kernel. Arm's Base Boot Security
> Requirements (BBSR) v1.4 require that access to go through TrustZone
> instead, so on affected Qualcomm platforms the TPM 2.0 instance is now
> fronted by a Trusted Application (TA) running inside Qualcomm's Trusted
> Execution Environment (QTEE), which talks to the dTPM (or implements an
> fTPM) on the kernel's behalf.
> 
> This series adds a kernel driver for that TA, built on the QCOMTEE
> object-IPC transport (drivers/tee/qcomtee/) already used to reach other
> QTEE services.
> 
> This patch series functionally depends on below(patch 5/6 specifically)
> for qtee service discovery.
> - https://lore.kernel.org/lkml/20260722-qcom_uefisecapp_migrate_qcomtee-v2-0-b8a8fcbe4211@oss.qualcomm.com/
> 
> Tested on Glymur-crd target with tpm2-tools utility.
> 
> Validations:
> - Get capabilities
> - Random number generator
> - RSA key creation, encryption and decryption.
> 
> Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>

Hi Jarkko,
Kindly let me know for any review comments/feedback so that we can align
and shape next revision if needed.

Many thanks!

-- 
Regards
Kuldeep


Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0A9403B13
	for <linux-integrity@vger.kernel.org>; Mon,  7 Sep 2026 09:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788774461; cv=none; b=d2ICurDbef7nk0mCUMQY/qslwM+/9loMmJdgPNIvzOaSLyD49qqf+z6XRMTjUNoYRSCg+RUdyLUfmBsCFn6BvGe5iPh2uvqpEm7FGPQqQ2PIdDoxZH0nm5foIQiX6aPRBlcn6me1sVpFSJojdrGd5PPQtEZBmrSeCbKQ0TkMY/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788774461; c=relaxed/simple;
	bh=6SspYc/M1jCPep/6JTqdwpr6N1VKzLwAITB+4WnMG5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qsktLk/Ilz87tvsheYHYC4VBBAjAK6Rwl6R5fRYGCQpD03o6li6r/ORIHCit1+pMv4Q2EETw67ufh/wF9evfhaqC0OS8H+dQCZ3ymttIRZtfE8atVeM/uixsAL06ZMAvOISRvQtDfdN5+V9cAe0+liQuVKg1xO92JxnPBOyv5w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Gj+S71mA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YoIwpdEx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Gj+S71mA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YoIwpdEx"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6879bT4M648880
	for <linux-integrity@vger.kernel.org>; Mon, 7 Sep 2026 09:47:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NSadxso+8kCU0Paycvkt2KDREp12le3ozz3U7BFkz2U=; b=Gj+S71mAQ69L2o/N
	ZE/ViHnpWzSoj5C+vJFAzglZBg6pRF23n1mPCVVbvTVfPazGvza413Irt38EUZg2
	5SF4plzNgNmKK44eE2SA+zQ0T498d90bHtNQUtpPcZmi52TzQJdLMGE5SSKowxTC
	6EK7VKPDFK96WDcgU8WwqfJ1NHBU+pK1gc6g+OR1RTr+PiI36tUac25r6jyumV/B
	FhVhz+n0vC/gHIfjh7rb098MB73VTjeY3Wj5dc2/OuxRzvK5opyTqXmRZwJffiFN
	oQyH4VdQDkdp5PFSmP63BMTwwrOyznMaPIuqgqTrjt2p2X2EPtfxuufuoE0wbwX2
	OLR6Lw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghrua8rpx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Mon, 07 Sep 2026 09:47:38 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ce7dfd33ffso44335915ad.0
        for <linux-integrity@vger.kernel.org>; Mon, 07 Sep 2026 02:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788774457; x=1789379257; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NSadxso+8kCU0Paycvkt2KDREp12le3ozz3U7BFkz2U=;
        b=YoIwpdEx3ixU7EswbYFJUc1efZ05dcoRqLJ584WFfybAmHflJAc2G1UeQLbJ4GUGyd
         1LkfIGsphPFfqWygqQy/z8p5FPOTunCCCIaBnyAdXXRthVZ1QYBTKZW6YELTJ7Jm+4vD
         wASEu4zIantNDV/m/Upty54MT9R/wllod3VunkUq+ucD+lsX6Yg3bFfJlsRWkWBpOlox
         vf8o6B38C78gIyCdD6TZGa/OjTpiMKhECTu8W081anZetYGKAw1QlUjLE+ypmSTQAnwS
         sE6B0uXhR7bX68aKXb3tZLcedrXTmB7rb3iAGai0auhn+zyy8vFLOgqMBhhfXS5yy+mQ
         Zewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788774457; x=1789379257;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NSadxso+8kCU0Paycvkt2KDREp12le3ozz3U7BFkz2U=;
        b=N+sfiTbJnBzeARAYSuGbuvUYOt+S4jVPqSxDWg6BwOLmEQWE6nsBAdsxTAZtR+EXwR
         tSlhFOz5FmXC+8y1mfFxSd74HKoMukG7thQSNBTp0Dsqp1JNRwFufFeqRbgYX5QRt0t6
         EjbMeinbbcZf+Kux4pq/yUkIBcCvWFcQWakDpw5g482wajgWdNZC//YOAkGkeVkHZQID
         OvRcJHnTr1dHyw+R7tk9F/INEV6h7m/oExjCpPGcNNY8ncqYtPYUpgIfXFOfogSHwsbW
         2ViP31t2GwvUKAIc5IXdUKWbJnXH1Nsh1JGiA38jRTEG0yV8z6LOsWvKyfJpJzAoimQf
         UWIQ==
X-Forwarded-Encrypted: i=1; AKwUvBxbcIO4ZZUesCdc8Fm1TrX7A1C/onduodrQ+zRnpb4Ngj0QGoy9izNLB7zD/tQJKfpuqnyMPK72nfcEicCK/bg=@vger.kernel.org
X-Gm-Message-State: AFuF++lWu8QIybLP01VH7OwtJqGPwZ0QkziK49pHRZqMpSW5oa2PXeJ/
	2u/0HE6PJJ9Exhyh8SBx5QN4cjWslBcmxgiygkJojWZP9rkcCZ+DFHEL7WW0UcQH+6dNehsz1Y+
	XZWHr/YBcj4r5PuOsJYpNyCcPijqlXMMbbBTqBd5LU5QjqdujNUhO37AdfhuOmHG34EZjs7U=
X-Gm-Gg: AYBFou1PXwnzX+rrreQjChXldMjycivFH/P98LThX02dMsJG8MDrf7n3qmcVbYVG5MV
	Jx9bbkO6CTklIVdMF3U39NZzq95G35XjHxUTWHBEYDDIE6fBwk/6vB0nk3MR1ATSiWIKSfTGw1U
	+tURL9n8kUKn5vY4NLcPOXJmshe6XnfnBgQvbTGFHBaRF3MSQwT6bZIKspBOYwkoeCylrw1bBTH
	HTFSiZWOyBYK2FUPR7YmqXUrgz9et0s5UX03NEj/5NN9Z2Xyqvt2/wdmPzcUPVnZrjc9cRv6wDr
	YBVVRbAX2y6eD7EbHnrk/L04YG6MPGXEG0LSydXnc4WkmUUfTN0/ryA4m0Psb+tzPgMrRVVNA+S
	BiP+ARio8jUYdMHOPrGHvTYnjW5Iya1U=
X-Received: by 2002:a17:90b:3a50:b0:38e:4cb:51f with SMTP id 98e67ed59e1d1-39b26101576mr37063432a91.11.1788774457566;
        Mon, 07 Sep 2026 02:47:37 -0700 (PDT)
X-Received: by 2002:a17:90b:3a50:b0:38e:4cb:51f with SMTP id 98e67ed59e1d1-39b26101576mr37063367a91.11.1788774457148;
        Mon, 07 Sep 2026 02:47:37 -0700 (PDT)
Received: from [10.218.31.125] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1432435ec2bsm23169442c88.3.2026.09.07.02.47.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 02:47:36 -0700 (PDT)
Message-ID: <591315ce-37d0-40e4-8bfb-55206578f0f4@oss.qualcomm.com>
Date: Mon, 7 Sep 2026 15:17:31 +0530
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Add TPM support via Qualcomm TEE TPM TA
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
References: <20260831-tpm_qcom_driver-v1-0-6f16fa6924fa@oss.qualcomm.com>
Content-Language: en-US
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
In-Reply-To: <20260831-tpm_qcom_driver-v1-0-6f16fa6924fa@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: hi8wbl9UucLXQ46a3yMO8ICt8AtKkZ0n
X-Authority-Analysis: v=2.4 cv=U+aiy+ru c=1 sm=1 tr=0 ts=6a9e883a cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=QTb_0JKWY7oM6lVZCfEA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: hi8wbl9UucLXQ46a3yMO8ICt8AtKkZ0n
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDEwNyBTYWx0ZWRfXxUyNv2nOgAou
 ydqME13hSB8ypkL52w2bWKPAp3ZO98YnbpCGf6VRCuhpzbh1uW17YqZhI0rtXbzdLWC5p+ORYuq
 KS3tQepfxMmxw6sIVeWCYZdfFG/4fWM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDEwNyBTYWx0ZWRfX20rSHCKCjJWs
 1MZw2/RlKSE/wcDHJiQAtWNBTSP+1lF7Aee9M+I+HIcQtWnzDDrUmAvUeQBjlm4FgcrvandyMUv
 4kP4blaOhKNWLpGN7qlPHEtebYPYS+TMW2axiovZqK5EZhUpfYUjwcA+sqDH820F7SvrAwU8W0K
 cfzjRueOcxrrFSYVaAXkUxflMkhEfhwfB3ghXkeVQlGWKPcU/DId39hltBsqmQvKzuP30Uej/ze
 H7gSK2+Dnoiz+z2eQE4eKUmzB77XrBmu1VAD1jCQlodYJW55ksxxxD3YglMnINSXviSLR4MII1l
 1lHiEYm+jhPf3adH6+FG/i+BnnmD1pgVRQN+LxGoO8JpJY5ugMDdwEggAs3Got3lgUV6gclPEFa
 dlQIZyt9fW6vPUH0FF2R3qwy6NozSjO2qHoPep6TXXNmfCXyU1fgOeMh29d57Vjo1zhQszFh5Hk
 kEMjCbUpS9JaaZPKBLg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_02,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 impostorscore=0 adultscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609070107

On 31-08-2026 15:12, Kuldeep Singh wrote:
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

Sent v2 for this series.
https://lore.kernel.org/linux-arm-msm/20260907-tpm_qcom_driver-v2-0-71a6b1752da8@oss.qualcomm.com/
Regards
Kuldeep


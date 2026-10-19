Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C523E63B2
	for <linux-integrity@vger.kernel.org>; Mon, 19 Oct 2026 06:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792390556; cv=none; b=MhfvX8FZs6XeJMBQetB576P+z6pEm6Esv0j4u32xSzNUFb+1hi7zaERCYLoCPGOVsuNT+ZwvZSp1Gw01b7bUMInrxTzIZ5y2qFMy9oNZLHGucKMdU6R1bYIfIOoHY7q/rhOH0+1ZhFCzO2DAK1NTIkTRdVY2FZyvPlXRkVP7nr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792390556; c=relaxed/simple;
	bh=xhmXf1PR+SPWbydXKdG1JG0Ihlu3vWgnp2oEIJ3YqRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TVTvahBG0f66onhvbM5+S1dTa1sDnwLqaDzDjabzdO6Q9ZRPRJEx9SAOSVFygox+oHOZNlijirSI0eiIUOsi2LOeEYFg0E0aXHFLdg8Wuv9D1TIxb/Q43GiJ5/+IuDvL9MqH96VxFgkQmBc0gCbKJxcoSM8jYUbovNtv2zqw6M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hBafz8Cp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Bwn0lHiW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hBafz8Cp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Bwn0lHiW"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J4itXE862065
	for <linux-integrity@vger.kernel.org>; Mon, 19 Oct 2026 06:15:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xnXlvura6HqbRVAHGsr8qtM9oPK7l8m6EFNCUTUAuOc=; b=hBafz8Cpu55qf6Qy
	RRsAnylBWsXPrZOVUSIJGFPsjdbUIODgR31N/lSucVSeGpCO+D3Ad8TH3E/Xlw6S
	t1qEAw32fZ3lQh7UciwTaClUF1A0L/Y5bhSKS6YK68SLOEkF2M+f/euccjDt5m8Q
	cyoEcmzjzGex1A2Hyv9zY4gaI7Vpky5pixtbbJzj0yQmXM0niutqhf181rDp3KAT
	IthhK6CMaJdiznoPfJ4ZF7okP+COcOeZr0iZu9tCEDzHIqggJDLw4nZGPeZe/F83
	ZGL7K45cBwg3tAfvoIszodOVhzMdMfH0INn6IpAAofwmd+BwQZk7W1WE1T69boUd
	tEo9VQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hc2a9myr8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Mon, 19 Oct 2026 06:15:54 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso3915592eec.1
        for <linux-integrity@vger.kernel.org>; Sun, 18 Oct 2026 23:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792390554; x=1792995354; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xnXlvura6HqbRVAHGsr8qtM9oPK7l8m6EFNCUTUAuOc=;
        b=Bwn0lHiWiWjWhpcMrudF3xEmzBaMcfDINhXWtqWFrjsFM0IPul8CAnTfngGTprDMZr
         ehfSUh3gptDTGuHt8m8A2FvJ77XJjP5C4se0waBhahOzru0dbo64+PQgTGXFgzpKahWf
         J31YCXFA3ATn/9yXROYfWoKfiIbcQYrR9UGXsSMa7Lll4P/UC0ZWg6SIhP4V6onWoVWK
         +YlPDN8aB12FoaMdrzNeq/XInDzkCb6VPJnHjmZhrfPcpvQsO6MFieM3fmDwT3H8OZCD
         Zr1FaVRUdClIS7tkObKiyW3dAeqDiyI9bH4VnFgwMBfaIfa0RatNX33Y2U1Gu0NTA8sx
         eUXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792390554; x=1792995354;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xnXlvura6HqbRVAHGsr8qtM9oPK7l8m6EFNCUTUAuOc=;
        b=H9Yn2j0ljRQOi5WJVbO4v6hKRmRL8+jWGWZtW5f6y7ogUI2ZCVArvOnI1vxj3jmTDg
         OZZk6YxXmi5Lhc3xgQzvHClLNNAfqqnmTzSRUjJms1dcS+6nPoupjGQgWrSI+Ty7y3bI
         /TinlV7EEvjmaUQ68hqhN7PKm+3JCgLHd4Je1GPtHFuqlRAbreckvPLyPQhwSIqgR+R6
         M19RM53TP3SaQNQ/j1jbtAss165hUtZgba/P8/QA8Mh0zmUg8X8PZ6lKU757gg0R9LTE
         kRSm0pq5s5rMQ3+CGdTZFMNFAaSL10V/5IKrY+kk5/YNoe7s4vniC56vA34+5x57t7k0
         wYxw==
X-Forwarded-Encrypted: i=1; AKwUvBzGmiCKl0/svWFN6Iw3YWHnkjOAMKwz/yFIQL9V9RMn2EK2lfweFWsZbbWo2ufpFM97fS68LFaFH72A2JqxFso=@vger.kernel.org
X-Gm-Message-State: AFq9FYLNg/xmrA8zJShYG03IAu+iqBRgUIr5OzlJa2pxULN23q9jcaLV
	dtnv1UedCzAvM14TFoPS+JVIGXDTfyFbwqkZWQL10CHubLpwoOsY2Ry3bHHz7Xye5qbA4u90O2W
	mTkU7NKDNq6mAv8JD2BTErzSVt1pSCM3DhQLPMhyerahRwOz7ksYdPNWxIzWl0vO9hSjV1h4OYn
	+77Ts=
X-Gm-Gg: AYBFou28yoToEGsZG+RU/5APNEiABSMbhkaF/iJb9roaboRNfqhwGXVnl05QmiMzTFh
	5qcXomJ44DRkMIzMdIeDwHsG3RHLzlJtXN9BJqo9ibnZPzQm4GM4DxJCV1p2zIl1Jz9MAEke+uE
	KnTuEtW0YjxK85z14IwIMofPjPms25BnODQPKcheWVF2rijpW6Jg8VcO7ThiJfBr+7/u1lui43k
	KST54m2brXdNAfJTTfP9FKCOxDSDU4ni+VQy5WD2mIBEIoQHeqZIZIN8fQHTr+4jC086bGVo73V
	WLl/I8f9cQ7r7woj7O0XOtnW5XXzpziTt4yDEMi9mlU9oeAJ/glcPEWWg5sMcX5VsVoz++ShB8R
	GfLvPAr7Tv8X0G4GahqZJIbWOKva/Tg==
X-Received: by 2002:a05:7301:4b0e:b0:360:ca2f:ce6f with SMTP id 5a478bee46e88-3619ea236b5mr9259809eec.1.1792390553824;
        Sun, 18 Oct 2026 23:15:53 -0700 (PDT)
X-Received: by 2002:a05:7301:4b0e:b0:360:ca2f:ce6f with SMTP id 5a478bee46e88-3619ea236b5mr9259784eec.1.1792390553247;
        Sun, 18 Oct 2026 23:15:53 -0700 (PDT)
Received: from [10.218.31.125] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3607bc950f9sm32590185eec.0.2026.10.18.23.15.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Oct 2026 23:15:52 -0700 (PDT)
Message-ID: <f14e7eb7-89af-4228-82d2-e0dc6b67a0b1@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 11:45:47 +0530
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] Add TPM support via Qualcomm TEE TPM TA
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
References: <20261015-tpm_qcom_driver-v3-0-247c8e50250e@qti.qualcomm.com>
 <atKRjiZEMIx3hhxI@kernel.org>
Content-Language: en-US
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
In-Reply-To: <atKRjiZEMIx3hhxI@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAyNCBTYWx0ZWRfX64Aca3Mqv10m
 XQNhJNyFTVS7UFCaQRTumTKXMz6001ZylBrRk+5dCoXy+rYt4FfNrSN0Pee8/1+045nEv7ARFoz
 CUs2Ig31zIT432dQWpV1rw4FlpE5Zr0=
X-Proofpoint-GUID: FF8tQLd4qvOq_TqHr0yNTSiI-qXbiSGs
X-Proofpoint-ORIG-GUID: FF8tQLd4qvOq_TqHr0yNTSiI-qXbiSGs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAyNCBTYWx0ZWRfX/MYGgij6oOEa
 /bR0yEbnzMdPMFHWzxny+EjfZgjn6EkWfoQO8dyNP2eDqeh9gNyJbjyByX4tB7mTEe7ABypvjHM
 e5siuaqh6tRb6uMG97+4sOrr3MHo8IU7qoEirDuKfSeqXmYMx7fsaFSHU1dc4MNBq5wNXEdMvLe
 YSaklc2gz+GsgH/476TfOXBOn4HolE09EQ/BIc6vkbs9PqbjNxrtanUyT6vD7JRdE3lyt91wE0Y
 wtOQQXuszdYsfYi1cX292S+Kl2o+zg2RTH11fniHEm4x3vwW2Zee+6czirA9i9T1Xo8XhBIvPnF
 I9RsI0tnmKTxrGmDXVk5wBmcumZd8Bh6nBtr6PSmYRpIBD5z5oXgfEfZ76ZEZWUBb2b7FA09CMP
 c8MkY+4qNubH6J+6gYyyd/PrCi2K7I+Hhne8bd7DK22r2b9TDJE97FpQ5+++fZ28YQiGKWL6BS5
 hNVC1Jn0OGgbkrZSgzA==
X-Authority-Analysis: v=2.4 cv=PMeaavqC c=1 sm=1 tr=0 ts=6ad5b59a cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=VeEq6VHES1BVyvH2O-YA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190024

On 17-10-2026 02:35, Jarkko Sakkinen wrote:
> On Thu, Oct 15, 2026 at 12:07:45PM +0530, Kuldeep Singh wrote:
>> Qualcomm platforms with a discrete TPM (dTPM) talked to it directly over
>> a non-secure SPI channel from the kernel. Arm's Base Boot Security
>> Requirements (BBSR) v1.4 require that access to go through TrustZone
>> instead, so on affected Qualcomm platforms the TPM 2.0 instance is now
>> fronted by a Trusted Application (TA) running inside Qualcomm's Trusted
>> Execution Environment (QTEE), which talks to the dTPM (or implements an
>> fTPM) on the kernel's behalf.
>>
>> This series adds a kernel driver for that TA, built on the QCOMTEE
>> object-IPC transport (drivers/tee/qcomtee/) already used to reach other
>> QTEE services.
>>
>> This patch series functionally depends on below(first 5 changes specially)
>> for qtee service discovery.
>> - https://lore.kernel.org/lkml/20261006-qcom_uefisecapp_migrate_qcomtee-v4-0-bf1c8e2a64ab@oss.qualcomm.com/
>>
>> Tested on Glymur-crd target with tpm2-tools utility.
>>
>> Validations:
>> - Get capabilities
>> - Random number generator
>> - RSA key creation, encryption and decryption.
>>
>> Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
>> ---
>> Changes in v3:
>> - Merge tpm_qcom.h into tpm_qcom.c(Amir comments)
>> - Update return values of functions and drop certain error prints.
>> - Define locality_arg as default value.
>> - Add Jarrko's tag on all but drop from 2/3 as significant changes done.
> 
> I get this because I have hard time to write "catppuccin" correctly ;-)

Lol, so sorry for typo!
It took me sometime still to figure out where i caused the typo! :(

-- 
Regards
Kuldeep


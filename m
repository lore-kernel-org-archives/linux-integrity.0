Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792561900;
	b=NEk/s4auN4G9/QnsVCjRoDtCptakv0XHBRiWWa2UXWJh+Luo/0vWw27UCO9T/FQTcNxb
	 8WSe10f/g+yQCnFE4xIyz1jNhAmCtCf77Lkx2AFEJyzGRvYXEwtuqcYs/DxYGnKlLQSJ2
	 alVgddONk3OY5JcOVsVKU9666j/H1F1mGpfwNZ26HDysV4/URXy7X9H+ownycaatlgU+z
	 nlIL1MGhRMZDng216u1+35GDE/tNBgaGs9tDhKM9lWfQO7Hf0vTP0R33cYGGHhUvXy5UZ
	 Vqud6dSfXBsEXkd6DCNt1Gf66UD9q4xNHPoVPMEdJi5zYJDdNoIQBRbC65AhsFJfUPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792561900;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=P86U4g4HatT60Cwqp5YLLNb1rgi90YTXNNoTgRjZESQ=;
	b=kuRZ3UcMhzTbobfzVWhs9l86R94waV6EZAubV6+yDkBiR791d6laIcgv3nlhH0V9KvAE
	 8F3T7gZ1cOt+1Idhd6dEWYBTunRjBdfBj/bxh4qxPAUarWh04WEVwurhtOZJ/PD4yUe8m
	 EZp2pSeEdLROeqZ4x+38eVxebYk9FOAk7C+515cRKh5NOKm0J7sn+hVlCir865WnI2lyZ
	 exH14pq1xbQ0GX9T/UX5NuxkSSyVPZ7dIH0L+/lF0btJD91bG41ZNXpfso8RgFG8JMLLD
	 tRSEBfXLAMy9Kb0gj9Vzh/Cy/OX6sWu58y+BQQB87jsuQo7CxkFLJRAMwI1A6RXDeAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AYwbCZUx;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XhkjBCvy;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73742606A31B
	for <linux-integrity@vger.kernel.org>; Wed, 21 Oct 2026 05:51:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73742606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AYwbCZUx;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XhkjBCvy
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69L5j6LU793374
	for <linux-integrity@vger.kernel.org>; Wed, 21 Oct 2026 05:51:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	P86U4g4HatT60Cwqp5YLLNb1rgi90YTXNNoTgRjZESQ=; b=AYwbCZUx5ANMu15a
	n5Va1u/CwFM7vsswae82r7jxn5B+VXbvm8EHB9CcpU63AGNu5rCFyXHBDHkC67HE
	JbJN/YORUCvxlGnLTHIUA5GO8wMIHfh5dw9ZMh7iBHiQwuHSf7GGa1FzP0k893/F
	rl/jjGT8a96Dovyx72/nJzKg/JHZesB9zNccEjbOoMFP8rpYgwhmFSkJna0RUAxm
	JvkSZ1I7Qipimj1p/ePYzofvvkvptJFrGdjyDdm4X376tF6KVKDtGvAe0gv+RcsL
	WT8sgad1vvwRILmIRTthsVPqhRQ1rKZF7a53Z4Y8NNbsA8oFaTqS2tmiQws+jpym
	csXxYA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hedabj7t5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Wed, 21 Oct 2026 05:51:39 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2e9995cea88so4165095ad.0
        for <linux-integrity@vger.kernel.org>; Tue, 20 Oct 2026 22:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792561899; x=1793166699; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P86U4g4HatT60Cwqp5YLLNb1rgi90YTXNNoTgRjZESQ=;
        b=XhkjBCvyrxwBGAz5xP26xeFUIo2gc4mqrxsbi6hT9zWVvIfGIDf5NEXR/SpFbaFvtu
         NuKkDTC6Mo8UCq8oqq0MNggsp1fGN5IoJArrWCLQOzGanAXUdEunkGekp6hB7iJVrT6Q
         FW+qu15m+vYRp4OPvVJUshoagtaSMlXOLQuY4deip30YRVvLWqQf+2pWzUcGgmij9tZ5
         phXReThPW5jHkhILsMSX2ZQQ9z7Kak3c4Zg+eBgCCqoGyawc83Ej85d8n3ac7E4hFNdl
         y3hXoDSRrQZovmSGypdliBlfQYjhwyzWQTeZObvGXkYdB9rH4lGbVuo+8P38wmCZGmE7
         L3sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792561899; x=1793166699;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P86U4g4HatT60Cwqp5YLLNb1rgi90YTXNNoTgRjZESQ=;
        b=H/vPogaVE6WVorQCEh2rCwLRbgyjpFQ6EwFuiIlIT7HXI1t9xAj+rT440knzts0MTP
         nKkjerDCTDx8PKy9B45ZiKgPSQXt8XNbAf4RMN1N2UI5OYdG0xmzo2RlvxRLqD6Z6hDq
         wSeEigpTkboW6plLtSLKdKiMgnxs0q5iSCdxHdWtqApsDmuBRJ/clR4821bwHkZv6dSG
         nAoIKBmYMAESsEkMZsxApw2nu+795KF5eBYdtjDCM1eg0rUnhknQON3mcRWRtpgazNos
         SjhosogPWbta9fybIz1Z5gV8TamWauz9M3P07Z9ngoSgoZrYQUkWXv2BDV+FGt+6fMws
         WYvA==
X-Forwarded-Encrypted: i=1; AKwUvBwnl/VN9BBD6zSoKUxsJ4V5oTREY+0PKacb0K6GI0a1GU71mlRvmwWhKF+Oi9EhGiDvX2NWEy1dO8vAtsbVH9E=@vger.kernel.org
X-Gm-Message-State: AFq9FYKNWk0hYf+lJ7yUoFwo/7eShqPFyful/9puRLpKwK2kyFIHFAAB
	oDZ7+qMtYGAvq7WwsCTF/PXxW5m/j4EM2OFiusnf5WB67XyWIUWzQ8I9/ydpuLkfmiCuHeLrLXr
	mZM/IRAEpAnwVpomOYbCItX6dWclw180tKAYGE6hPDddx3wAk+ArQ7wwHC+ZfBe8QV5uocz8=
X-Gm-Gg: AYBFou2IJ8TCGLX035CA1qNyfqU5ztqR6hU4Csj/aYO4DZYV9HT0qWD3VY158MC7XaZ
	qTOB/iYYxvFy2FdvBb/E44Af844iaLAs8sPiSQe9jlVklXjHPau2Gq0KaJn2R9iyZltUpUtQwYH
	hnaLSVf6GbnKFQIJALVTme2IZymzxMQqWhWSqRqzBCzn8wgiYmvwhOuQKOlwjQ0HAvFZgNIosef
	OEOdMyK/YiQf1ZiT4UUNqUhLY8lCRWtXM7MH8t+z1sNfXWKmpTJP5zoPmE0pM+xPsXIoOv9EK+K
	aJenrodCycZFtoY4LK5KjQLBVG/UJZ5BWWIAh8h7CKIXudmnlVDCGxbBgvq1gRIEF8UO4uxIvGG
	GNBfyG7aq+ZU5Z7hVz6AxAz4WMDbVTw==
X-Received: by 2002:a17:902:da83:b0:2e9:734c:5027 with SMTP id d9443c01a7336-2ea43d3a1abmr8645345ad.15.1792561898975;
        Tue, 20 Oct 2026 22:51:38 -0700 (PDT)
X-Received: by 2002:a17:902:da83:b0:2e9:734c:5027 with SMTP id d9443c01a7336-2ea43d3a1abmr8645205ad.15.1792561898506;
        Tue, 20 Oct 2026 22:51:38 -0700 (PDT)
Received: from [10.218.31.125] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea3b49caa7sm6217035ad.69.2026.10.20.22.51.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 22:51:38 -0700 (PDT)
Message-ID: <8896d867-dfba-4d63-a0f0-5686c572b262@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 11:21:33 +0530
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] Add TPM support via Qualcomm TEE TPM TA
To: Jarkko Sakkinen <jarkko@kernel.org>, Jens Wiklander <jenswi@kernel.org>,
        Jens Wiklander <jens.wiklander@oss.qualcomm.com>
Cc: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@kernel.org>, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-arm-msm@vger.kernel.org,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org
References: <20261019-tpm_qcom_driver-v4-0-6889b9804ba7@oss.qualcomm.com>
 <atYZXRLf3YPZhiNB@kernel.org>
Content-Language: en-US
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
In-Reply-To: <atYZXRLf3YPZhiNB@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAyMiBTYWx0ZWRfX0buDcAzITXvU
 CgxIorHJB0uY5eUT4oaHKAAp/YpF8xoB11tteIWhi1/FWLbX5GtDXbIMacfPwRinxsMn38v3+KE
 6Oj0azvZ9Y2Of/RNHKDsyivk98jM4gI=
X-Proofpoint-ORIG-GUID: wsffql0aFRhCqZo7oYNNHGs29u3seitl
X-Proofpoint-GUID: wsffql0aFRhCqZo7oYNNHGs29u3seitl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAyMiBTYWx0ZWRfXxrOyaEhgo0+I
 xWAAQ2dt8kSCNjVhlOgArgngoP/O0Y5WIQY4O9jU9CXYJdk+WwTsiOpbL9/4byrmF4Xu1LSB+Gf
 CS/NqpxJQ/ZPKtkyDxJIDL9Jo+muNY3AaUvvqXC6/TB4LHjgQV9os4CsCMhasLuYDe1bvffUCbL
 HNmRjr0IqGC4GregTueWeH7gn4l9vmsCWzK8tJG6xx8sdnFSBgtjdSZ3tSA0o/lzukWTcdvPHGI
 N99JANVUHKRPtU7xOXqSI+iiri5XHlXfUfCixwf9qIJFl0A0/FYSRQE0UBzA5HUQT+G3OSp/Jji
 4JJ8M79lZfk/WJqFZi0e8QVHG+EBTHtxvM5DGUEDfWIhPOiMkPTgKSxnjfakNywTty0a2vNOqqL
 Gf17+SplA2S0BNaWl2qGo+33U1aqPRihM2Nc1u9dneCvoDqvXEQ/dpvMacp5NhcL3QfQQH67Rre
 hQB8Qw3Wg9Gt4T13gPg==
X-Authority-Analysis: v=2.4 cv=NLpAaE6g c=1 sm=1 tr=0 ts=6ad852eb cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=JNtoCX4LS8KcKRon3YoA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 impostorscore=0 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210022

> Applying this pulls tons of TEE patches:
> 
> Applying: tee: qcomtee: Track the object invocation context
> Applying: tee: Add kernel client object invoke helper
> Applying: tee: qcomtee: Allow object invokes from kernel clients
> Applying: tee: Export uuidv5 generation for TEE backends
> Applying: tee: qcomtee: Add support for registering QTEE services on TEE bus
> Applying: firmware: qcom: Add support for TEE based EFI-var client driver
> Applying: arm64: defconfig: Enable UefiSecApp TEE client driver for Qualcomm SoCs
> Applying: tee: qcomtee: Register qcom.tz.tpm service for discovery
> Applying: tpm: Introduce Qualcomm TPM driver
> Applying: MAINTAINERS: Add Qualcomm TPM driver entry

Yes, first 5 are tee patches prerequisite for tpm series as mentioned in
cover letter too and this series can only be merged once Jens can pick
dependent series[1] in linux-next.

Since, v7.4 merge window going to start soon so i doubt Jens can pick
for v7.4.

Jens, Any plan/timeline you are aiming to pick series[1]?
I see it's mostly reviewed with no other relevant feedback to be addressed.

[1]
https://lore.kernel.org/lkml/20261015-qcom_uefisecapp_migrate_qcomtee-v5-0-1460691b35d3@oss.qualcomm.com/

-- 
Regards
Kuldeep

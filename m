Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793723603;
	b=PbnNzKm2LulK/mKnLXkd5h01VKslmHZ2dmXEmiAzkgX2xx4b0ZsSJjxdfZEVq/gqJ9nw
	 45T8Q0WLdVDC4TZ2t2Xa0OM0xdqqQ/pCudRBvI4QMj/rofP3GQMI2hh45i2NK2uSgpo4A
	 ++0QLdEP6wHPs0HdTLd5XZAXMmhBkvAAH/0zIbrYKUoLB0FtnlBhvRotvKOXtH5Dpi2ba
	 xDZE5/qQrkWKtSwX4ooSaRcB7ZxrfFOjAwhtMpY8B/wUajQxg7nWQIgJ35P8hmGLUdqka
	 FKZ8cxokyjb1OK1YK2mqHCs5pZLwZkMzTVVvfzTnIDCB2tepTCc0cZwawkJkUonhp6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793723603;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=KNX4j1BmI6v/586ULUJdkOuJ92tPPScGDdWzbmLn3Po=;
	b=yZk6drcKl8K73IRqGEgTy2JGNOXccQ2Rvdr1jMrMJTcILQQlPQfeNIX7YBy/FuANm+L9
	 Vo0doTgvod/edGMxdUYVeBm8dP9aJfcKei6oe25v7JMe0FqXgUCHFEUEt2AumefRioTye
	 z16jwYyyrxfPSsMA9FVX2LO1ModJRLsoJNMigMc0Vary++WD345yVIAjrRbwXAnTQvt1T
	 8EDCajjbdEsTT3k+OsYxzUwojN2j+604iu84ANbVE9nblPezRT98WZji7uNjngyvejyqw
	 JiIRchJSrYA+CtrsyhlpYsHWUCSR82UxZEFTza+5HcMHDqxUz+rIA7FrCOfWZZcLuuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mjwuQ6tS;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gcZJ30C0;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD62606A32C
	for <linux-integrity@vger.kernel.org>; Tue,  3 Nov 2026 16:33:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2AD62606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mjwuQ6tS;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gcZJ30C0
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3E9tfV4049725
	for <linux-integrity@vger.kernel.org>; Tue, 3 Nov 2026 16:33:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KNX4j1BmI6v/586ULUJdkOuJ92tPPScGDdWzbmLn3Po=; b=mjwuQ6tS/VigZEq3
	ogxeCgwHxzhqzyfJV4CTYOXLH8FY8s1MqudfValPEMNThuzrnds/+rtXHbSiYJ3x
	Y1uIfLy+4LM7PhoodDOI3wPU8NgBQEenCPvUZWTazR9+FBt9xyZPLedZ+XQ5+fLW
	CTY9qaiJu9SvfXB+MmHKMj9JHj2fBmPKE38GdLGIjZd0z0LbX/5bnNzYGRRN79H0
	wRQj1c+gRehu5a2RnjhzjX2XEDiqelUyaH6tH+B6YgGvTSQBiZOC/697CGzjPJWO
	5QGvoF8uEyNSjvha2TLgLPjUOBhC161Ti7dv6aTXwu1tY91TUyQyIX07qVEGo04A
	ntxq4A==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq3uy3uaw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Tue, 03 Nov 2026 16:33:22 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f20addba1so790226185a.1
        for <linux-integrity@vger.kernel.org>; Tue, 03 Nov 2026 08:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793723601; x=1794328401; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KNX4j1BmI6v/586ULUJdkOuJ92tPPScGDdWzbmLn3Po=;
        b=gcZJ30C0/lvQ0so9zvM0d+CAht9HORPywW0r1gbKKqn7iYPJmoCAp6O61Tudf+fh5G
         eln9rl4F36s8Nr4B3dX3k6TWrOSvtMnTrCq5jA8E8uPpHJ9ic62g7ORLcEgHhOgCJ/fF
         XmruU8JXWeMnJYn6zHAz9qCGDuY63EFQafwTRfItWiXuqri1WHDOQy4B4XUwuDJFP6zJ
         QHY5irie1ANacniLm0FgMGbYHho90KXfBG0wXNKvW856i8DkpKVywTQB+PP2QpjY5wwu
         JSm9fke3AvZdcWNyBj6wsdv9GNoPMnJGWT2yKFenpiTc4BBhibnP7Jkf659hpVYDKWVi
         ZMmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793723601; x=1794328401;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KNX4j1BmI6v/586ULUJdkOuJ92tPPScGDdWzbmLn3Po=;
        b=TqTHbXB+a46ScoIz/i1o+hzsVyD753l6mdi0Jxwz1LKcg6f8UXuMsEIqwUcaf2HsoZ
         RtsLTVz6/ON0BUQW2j+nTfXePZHNIjkTrDulusG/GuEkvOP9erVnbMwWuoiSEwLcB4cc
         zaDX3gv9cneUIfQVzOiCosJZ1RAEl9P3EM6JNlCqo5UUZwbgqA557GLWoT8rcN/hss/w
         e8MBv05iazSutlr8zkR4Z2Pv/YECw3UL0u2EDl/9sAapClvrA0QAUNIynzRbwYGCngPC
         5wr3ygZoeAJzVwUYhEiewxnVRR1hyWPr6EVIkOlCUPe/UlMC4VfC5aue7JtEb0lJBPrR
         zLNA==
X-Forwarded-Encrypted: i=1; AKwUvByREDTcOJ6of9paSvyF7xkL2qnmouFGer3SrP1dDq3Inddrqtei01lr36Sn63p9P+ZQQsmLT7lAuZljox7GNsg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9/nBIVtAQ2z2hKMxc0xd900OHTFR+h52fwQpIGR6Ru/VzwL/bZ
	I3K2wEBScgfOdREjdKXyVzLLJE5qkhAjkExe7hqKyqpVMGy1DWnWx1e9+lhXK9KVShH2Sjes9eQ
	IIdcfAXkgwgFeNfbFO3bGPxPYmH/RXxHPcTaqiuDp5b5izaIu2UkkSXWHjFtPeoPPy2E6EFk=
X-Gm-Gg: AYBFou3694BHkGC74tpTilSO5PeIWCmCH75jgNAZ2oual9Soflk5Uasgr641zPaie56
	4M1TTk1cws8kAiOIGaPvYe7P/Iks5ZvdL8vZ0u5QSntx//cFmSfQBf6G/TkhhqUaN50O9Q4YE/Q
	MezVMjsTss/nl6bBve64rCIVVx5tQQMIdel0QuLeZ+OxnX/CtzFaspW3acXjyCDN8QPoPAJ5Vsc
	8x4mCC6lU9W+T11rStHuUXLKsYZIpAQUzYkbIhF2xPQatZx74uP+ro5Jjueq0v2lovlQ4PJCYmW
	G6Gv45/K9hywDqzibHnwST3oIEoBk+kdkydd8PrhTA2PNm5I03EMnNsKGR3BiFapOof4kZ0wVD5
	u+3WSg1mKS+hSAktziHbZwZrCbuoci/rgikRGvY8o7jKziCmVsLN0xtSSN+lYzaNrLvUIGy9xnR
	14YcJ0yY4TnoLdyUBtU9FqUjr/lC4U531Cr1VKqd3s51OHbpBeI4tcvgk5FVvwEwwG/+8d5Z2jl
	oJ3Des7Qx5s/gU=
X-Received: by 2002:a05:620a:a502:b0:945:ad43:1d59 with SMTP id af79cd13be357-945ad431d8dmr1008660885a.75.1793723601190;
        Tue, 03 Nov 2026 08:33:21 -0800 (PST)
X-Received: by 2002:a05:620a:a502:b0:945:ad43:1d59 with SMTP id af79cd13be357-945ad431d8dmr1008657185a.75.1793723600734;
        Tue, 03 Nov 2026 08:33:20 -0800 (PST)
Received: from [172.16.20.169] (h-79-136-84-34.A175.priv.bahnhof.se. [79.136.84.34])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cebf3dcc9sm101883766b.53.2026.11.03.08.33.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 08:33:19 -0800 (PST)
Message-ID: <2f6f80eb-57a4-406d-a041-8602805c7647@oss.qualcomm.com>
Date: Tue, 3 Nov 2026 17:33:18 +0100
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
To: Jarkko Sakkinen <jarkko@kernel.org>,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Cc: Jens Wiklander <jenswi@kernel.org>,
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@kernel.org>, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-arm-msm@vger.kernel.org,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org
References: <20261019-tpm_qcom_driver-v4-0-6889b9804ba7@oss.qualcomm.com>
 <atYZXRLf3YPZhiNB@kernel.org>
 <8896d867-dfba-4d63-a0f0-5686c572b262@oss.qualcomm.com>
 <athuhfkfGPZp_YXT@kernel.org>
Content-Language: en-US
From: Jens Wiklander <jens.wiklander@oss.qualcomm.com>
In-Reply-To: <athuhfkfGPZp_YXT@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 80F27mIs99x7LvlwTAgnbms62_Q8W66g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA2NSBTYWx0ZWRfX0oyXQfzsge4d
 HguWaXbuHzHFwXrf9cSHnbJc0lq38EMYdCeOhXniHPo4ItROxvEQRgwY9WNP9Hkk3RgeKSzCaEK
 Qkg+cwDWFaDuZpk7Ky9rHKeyPYZrAhwMElOqRb+AXcckaMrmiFd9UoFz8X0KK5BjyQqNMx5uNCo
 4E8s7b1LjdofelfrUm3Z9tPSZagOaLMDrQhDL6/H7MnKY4a1aad5WX3t5RPbMB879nqg1mElKu0
 VOAheBxquiMvGvdyOZde8KEo6Ov43IzPRy3FX5JDz2LOO+hcwxFdKwGPIj3JyC/hAFZjsYNnRou
 vCB5exhmnkrMz4hNQNUo6TH8kQpdtFqLQJss6/06wVDxR9QR+ERQX7MWyercvBA5COLqe7iJXJa
 riR0ljUdUJEy8FYy45eu6U+Br6ApJP3IMlO4b/Rz3hgdP05Scw/+ZIHxvPtqG4xwt4xYF29+KP8
 TZ99rarxezxi+2Lwk9w==
X-Authority-Analysis: v=2.4 cv=VoG2kO2n c=1 sm=1 tr=0 ts=6aea0cd2 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=dMv3lA6PLLkT9/uWe4YCGw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ma1MJH4ChwW9rezZrwsA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: 80F27mIs99x7LvlwTAgnbms62_Q8W66g
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA2NSBTYWx0ZWRfXzUMVGzcmLkF5
 1CGeQyyEuDMklF/DJHGZGGTz7us7fYSoK1OOsj11ZzEbK10YbNzl0I5ZWA8p3BXI6Gu234tbs/v
 xiFRSGfQAdmYTmgNgNZu7FupoBGF4O8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_03,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 impostorscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611030065

Hi,

On 21/10/2026 09.49, Jarkko Sakkinen wrote:
> On Wed, Oct 21, 2026 at 11:21:33AM +0530, Kuldeep Singh wrote:
>>> Applying this pulls tons of TEE patches:
>>>
>>> Applying: tee: qcomtee: Track the object invocation context
>>> Applying: tee: Add kernel client object invoke helper
>>> Applying: tee: qcomtee: Allow object invokes from kernel clients
>>> Applying: tee: Export uuidv5 generation for TEE backends
>>> Applying: tee: qcomtee: Add support for registering QTEE services on TEE bus
>>> Applying: firmware: qcom: Add support for TEE based EFI-var client driver
>>> Applying: arm64: defconfig: Enable UefiSecApp TEE client driver for Qualcomm SoCs
>>> Applying: tee: qcomtee: Register qcom.tz.tpm service for discovery
>>> Applying: tpm: Introduce Qualcomm TPM driver
>>> Applying: MAINTAINERS: Add Qualcomm TPM driver entry
>>
>> Yes, first 5 are tee patches prerequisite for tpm series as mentioned in
>> cover letter too and this series can only be merged once Jens can pick
>> dependent series[1] in linux-next.
>>
>> Since, v7.4 merge window going to start soon so i doubt Jens can pick
>> for v7.4.
>>
>> Jens, Any plan/timeline you are aiming to pick series[1]?
>> I see it's mostly reviewed with no other relevant feedback to be addressed.

I'm sorry for the delay, I lost control over my inbox for a while. 
Looking at [1] it appears some more is needed before it's ready.

> 
> Maybe it is better to pick also TPM patches through your tree when
> you choose to so that this will go in-sync.

Yes, that makes sense.

> 
>>
>> [1]
>> https://lore.kernel.org/lkml/20261015-qcom_uefisecapp_migrate_qcomtee-v5-0-1460691b35d3@oss.qualcomm.com/
>>
>> -- 
>> Regards
>> Kuldeep
> 
> Br, Jarkko


Cheers,
Jens


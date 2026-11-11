Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434601;
	b=2bB3bZ5Pvcj/q0+DpQb6ZqWHdMU4udrMNSBgO4UlawZ0posaHAPfn3Y3M6kYoXPnS0I2
	 TQCHqjAPhZbz6uAfCEAdX5juNyaxX7DE1zm5zGKp3V6epTjGhZTqTrUPcYdV1Sn6NlJ+V
	 fYlb74mMQdPQNjrxzIcVrHh0686eqguyTCCRzH9VQ6bSu0JAiC2GqkEkXybcK76iXdOjc
	 vb3SEtrlLDuwWHdeUyZwSUNMElnhzpf3oiksl207n/5mO6hiMHmqJ1StSnxVMplgJpd59
	 jfZvgU1F9xVcN/81AT8WEz+mOsmmwvIWSndg5TShgkrdth0RF8p0ep7urbdLrvoIrUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434601;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=L3r2W9ol8URSEQDtiQtI0G55c0BKwpTOQuX97PiChOI=;
	b=zp+WTool+FX7HvYkWXcikIfwj4y31LlCKbnLqI9zzsbhWiEowyv3oFwAO2xmOg387xrA
	 2wa8kYwzV80MjbWY/CPlWlKFVPxxfoGmLTGUZyCWrZu370HnMiDaOt+xurWq6e28DRCSb
	 lLvkZQS36gIsvtSqHRgdTXSE6IqawjiburKYEMTT8x3BlVdLQszA0ebgLhjV0GFTqLjz2
	 beTMkOmpGJwza7oAu0Rr5o4C3Y55h8ltMvOsdMgtHs6BajATKHaCKcIKxEe9mKsCSMh1/
	 8LT5CVadWKoiqco+iKKJ/38fI15A5l6Mz4iIcKB2kJce3Sxk7pk9rmA9IARbRomjc/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JZHSRO8l;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XaMYRKLb;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A54606A8B2
	for <linux-integrity@vger.kernel.org>; Wed, 11 Nov 2026 22:03:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8A54606A8B2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JZHSRO8l;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XaMYRKLb
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABIp5LY481058
	for <linux-integrity@vger.kernel.org>; Wed, 11 Nov 2026 22:03:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=L3r2W9ol8URSEQDtiQtI0G55
	c0BKwpTOQuX97PiChOI=; b=JZHSRO8lood3/frxYRFv+2ipixVEHfYXHDZlqN77
	SftBHMMbnD+kBRA0b0FI4gz6ehiEGeW4fVhyU9AEYL9HTSXcIGcRPUBoNUftikDk
	zPUFV/72xgACcCstgDkhYV86qWJy9I6Xszi/Huw1UB/gzIimXvcbYPTYdDZu4E9M
	7ckPgBFQjQbApmzCQWKkngEMn7Qso/yJV4yX3w1WqaA5lRSNjtMHxEn0VjMYXtCc
	I2BVe5B40wumO4KEQ67OwXBxVwy1EBsyLTwhUlR7U55aijctin69wQa7voRhDtj0
	a4zjahDGTgx7j/YLODyXJQjG/xa8QEz8OmJQki4U3z10/w==
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvtymsfcx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Wed, 11 Nov 2026 22:03:19 +0000 (GMT)
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-716f23c53d6so3849797eaf.1
        for <linux-integrity@vger.kernel.org>; Wed, 11 Nov 2026 14:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794434599; x=1795039399; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L3r2W9ol8URSEQDtiQtI0G55c0BKwpTOQuX97PiChOI=;
        b=XaMYRKLbB6qeHc9QWJGaCfl+R96uQqv78+fDXBjl1F98jBa5xLxloiz5dMZFEo5mvl
         9JTcm37ySZr6PnR9MvqCwcJIdJfrWrjPA6lH4mRoFbLo+bvwb7i4vAwFOdQsTkAI2kyq
         ALUDTV0FfZBfA+ScF0iVD+vtgLuYLSG4WCVeKf8JvJOSGZNgXrvmrvFwFrdyRU8iZtC2
         qnF0vsWZeZ65GqY9h3sKQAEseAWNhya4xA0YV8v+flwzGlyoIbloZzoOzjVHp6XNej45
         8LhLwgpgXH/ILkBwly9Ng4wxZngtuc63qyYtgnL+dKku7Jtf3wLij8b7crPY30zDSNCw
         tldQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794434599; x=1795039399;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L3r2W9ol8URSEQDtiQtI0G55c0BKwpTOQuX97PiChOI=;
        b=dC9gSDx8yIAgK8HBEWdDKX0NHTxnrz+tX7+uy0g3dt7q6nIvL2e3D/h46Tc+HlB3SC
         4Ns8JAPeJIKYhsRmzPZ9CqQbYDKMSPBvBkbUifi7HXiVGuEPBNWwU9/uMRZlJny0MnyP
         Uj7pkFxUCeWajHaIr6v5mhhIcW3O/DoofqFjPPwLVISzdkXwq3nJt458wM5rFjsXxf9T
         KQPSRH93vPVMvS89nUXBRkyS6OVywmAY3YQ+qdgivSwCGZoT8jcjwNNJi+yUynPakyIB
         AAG0uS+gmKVzZwovFCsixTgeeLcOnjJBrWiIXcXR3qhTfFXH2U0FOS0hXxS6C4WtqS5G
         Ia1Q==
X-Forwarded-Encrypted: i=1; AL+hErGuC10BogwnxYmO9n67xFBViRSkj19fjxUwTefwwL+7Aj5W9RnCp5UcDA6pokAcOXGlMDM4g7Kruo2dBLPjOLw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8gtjkG8a7o1R9fELi4P7C5ga955XZKlgBkzYApE1GY9WJBfqT7
	MBj2Nyp0ZOqM6DUOTV+BCj3TJeCSPezUVAN5QWDl2M6F84PA+Sueqd6HUIwkjezvumx3C93QvuE
	xlR4xkoArquSiIVkKFx0exS7r4anJE8Y0s0LsgNdpd91HBw/S2iWuWvgPSfWsTRkC/RbPYr9MSa
	B2hW4=
X-Gm-Gg: AYBFou1QjuF94VrraFC/SWY1xP0HRFnkHIyfdpr/jSC4axHUBiL6eMhxcdbqBlWDiz9
	P2XVr1m4PSRKa7niMpxGxJ0wMGh2fdOcK5WB3klAo9qRx5Szt0/EIbflCeybympTpHWlXa2S4M1
	GbOA7HawcWQEfCMf7LVzMMgY9Ikbb70WaYmeL3jhAVOA6fHjkQ77WL56OegnFloFu9kutNwKKxj
	em5nhE1zHfC+ZjUSY7IbLE70MubCGBo1eEuM6n/O7LBNfM385xbjcyVa03rCv7yI3vC6yyrkIaF
	TKrVegLbLrSKj5cm1WfZQ9RnkCJ4689vXmRV5Ggz/o6nDuw/6qQnVhW6uiBR7Xmv/hQ/m6mRPEi
	3XSLjX1vfS+zbD+fRGRptMgWJmg3E/DfUaLzBf1ZkmKVZvcF66m0BcQYtso6oCuexQcsp6vEbXs
	GMZA==
X-Received: by 2002:a05:6820:16ac:b0:6e0:fb60:d5c8 with SMTP id 006d021491bc7-719175f9f32mr2440465eaf.1.1794434598530;
        Wed, 11 Nov 2026 14:03:18 -0800 (PST)
X-Received: by 2002:a05:6122:1b09:b0:5ea:94cd:c5d7 with SMTP id 71dfb90a1353d-5ee1c462ffdmr1573952e0c.16.1794434579670;
        Wed, 11 Nov 2026 14:02:59 -0800 (PST)
Received: from trex (50.red-81-37-172.dynamicip.rima-tde.net. [81.37.172.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49836b8eb11sm14103545f8f.57.2026.11.11.14.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 14:02:58 -0800 (PST)
From: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
X-Google-Original-From: Jorge Ramirez <JorgeRamirez-Ortiz>
Date: Wed, 11 Nov 2026 23:02:57 +0100
To: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
Cc: peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        sumit.garg@oss.qualcomm.com, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v3 0/2] tpm: OP-TEE transport core for discrete and
 firmware TPMs
Message-ID: <avTmEXZzyyjxA2dy@trex>
References: <20261111215940.3503287-1-jorge.ramirez@oss.qualcomm.com>
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111215940.3503287-1-jorge.ramirez@oss.qualcomm.com>
X-Proofpoint-GUID: sDfM-JHZN6YXpiNI58L2E3tTbJEvWEI1
X-Proofpoint-ORIG-GUID: sDfM-JHZN6YXpiNI58L2E3tTbJEvWEI1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA4NyBTYWx0ZWRfX1THEn/rN3ppX
 2/R58GKRnKMLaqgn/qIoNc3HLHhKDTtsjPIMSdJWlP8sikK8+/7JH10cS6M7FJdioG2ZDpzVVc2
 ZtsWB7bdyi3qayuM5/dAvkH+Q6wbYg9SF3v6bYC/5eMqRqP9ASyUeUPfQIyCNlXj0oxczviTwBX
 TUnedtVOM+XSe1EMIR8bHGw5f2JH9IcbfWk8fUVhZZ+uMF45YTc6RfBI+X56L9UqvJZYV3dt+1M
 XUtzN+0VrRleJgxzlW/5G9PTSl+RooiX5v7XvXqsk0u3CQnot4Bjq1WFjZaNqxQZd2y7h3WAx4L
 A5jX0Duc3XP3o3bIpgJoj0hqfb2znbL5dg25wnNdOibJPjI40Klpn7+9eRYchvr8oJ8lHpx/Yhp
 Mi8ph8VrdjSGiU8tJQ+W+HeGXyruVXSF3B7jPyk5VRjr4a5E2QO+RR/MmDSyB6S07hFxhd8XG/1
 kifKJ2pHWxkdwPNN2GQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA4NyBTYWx0ZWRfXxpkAvVQKxY+d
 uLy64Z8k6shiqUovNJ5BkGirsdmyTZw9zOqQjtf3y8ksE2TUltXYA2fnMoK6MS31mfWgYcGY7aY
 xa66oTcsE/opuip5RQqHysNb0+MYHtE=
X-Authority-Analysis: v=2.4 cv=Q4BHcI2a c=1 sm=1 tr=0 ts=6af4e627 cx=c_pps
 a=V4L7fE8DliODT/OoDI2WOg==:117 a=VbO86HPdXvN82gCvB8O6pw==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=NEAV23lmAAAA:8 a=McN5tr3TAAAA:8 a=3qyK1sCLMOwx5v9cIf4A:9
 a=qcg49hLlgF0N60+LroqrWnV/Vu4=:19 a=CjuIK1q_8ugA:10 a=WZGXeFmKUf7gPmL3hEjn:22
 a=OiMWn5MEmObRqTLTTlUg:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 adultscore=0 suspectscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611110087

On 11/11/26 22:59:33, Jorge Ramirez-Ortiz wrote:
> This adds a driver for a discrete TPM that OP-TEE owns and the normal
> world cannot reach directly, and factors the shared OP-TEE TEE transport
> into a small core so the existing fTPM driver uses it too:
> 
>   - a transport core shared by the OP-TEE TPM front-ends;
>   - a new discrete TPM front-end;
>   - the fTPM driver converted onto the core, keeping its name, its
>     platform/OF binding and its shutdown path.
> 
> Patch 1 is the feature; patch 2 is the fTPM conversion that justifies the
> core. Both front-ends were exercised on the Qualcomm Lemans EVK over the
> shared core: the discrete ST33 TPM (patch 1) and the MS-TPM-20 firmware
> TPM TA (patch 2), each presenting a working /dev/tpm0 (tpm2_getrandom,
> PCR read). The fTPM TA is the same MS-TPM-20 reference the existing
> tpm_ftpm_tee platforms use.
> 
> This is the normal-world half. The secure-world OP-TEE support it binds
> to -- the in-core TPM2 SPI (TIS) driver and the mediator pseudo TA that
> relays commands to it -- is under review separately:
> 
>   OP-TEE support: https://github.com/OP-TEE/optee_os/pull/8155
>   locality 4:     https://github.com/OP-TEE/optee_os/issues/8160
>                   (design follow-up: the secure world policing
>                   normal-world locality access to the shared chip)
> 
> Build and test it on the Qualcomm Lemans EVK (a discrete ST33 TPM on
> SPI, owned by OP-TEE):
> 
>   https://qualcomm-linux.github.io/qcom-buildroot/lemans/quick-start.html

The above was the wrong link, please use this one:

https://qualcomm-linux.github.io/qcom-buildroot/lemans/devel_lemans_security_dtpm.html

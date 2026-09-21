Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8267399357
	for <linux-integrity@vger.kernel.org>; Mon, 21 Sep 2026 08:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789979812; cv=none; b=Hsa05YqygkNeiEe/5f8goPWUSJ6oDZNjUoRfuG//3tYmaTz6fvKbXQcAtWWXPuSflSpkwQDrKTnyFx1w8J38Xr5ADee8xZn7mkOShThEhZ2ORgk2bj2Eb0ale4ryycNQYgjraTu29ZssDm1PxRojXvKCh4LkSu+Tnb94TvcsZS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789979812; c=relaxed/simple;
	bh=ZCwmZO84Gw6iM0nAODwcNKlVIlSJtLdUDQfhkkemjho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xn0lofk7VPN4o8a2esMBkdEPglK9hFqbp5rjqguQFeh4J2ZQGK4hD3eXjqDpqA01TEqe+q4PVYuM93zNk2pMz/eDF0BCvgIrptYNUXH3IciDKiqFlKFPT8Hmw2Ijh3DgM38BYSIgMgGU7cmHuZxt9tkjkeNvY1STAFlMyX8tV60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D3SlBmMU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BeCv6j8Q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D3SlBmMU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BeCv6j8Q"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L84SeE4135073
	for <linux-integrity@vger.kernel.org>; Mon, 21 Sep 2026 08:36:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kPtxmrYU8ZrfXfOjYF4vl1wiQZgzuzOfDh5H7b3Y+5s=; b=D3SlBmMUdBjMKj91
	YpyGZ9eAsB9w24gK8bmeYcytRs4qvBuRHT/NJk+RqIa4tng0epLHf8B3zUKe5Rp3
	zP92/H2hfYMQpD38qKx9ztIzgXW4sbUMsSAEYqGJFq8DcPCl6RlFy0i0BTXgrJ4C
	zKnMXhxoJqbmUpwFlYlt1ko6cyxji/h7xca2OeNhe3/REHptY5XkQtLRrrx7Mvdk
	ScW8Namr9rsqVFYw2SFHSR5OVKA9r3xu83aZVW7ThCp3WxxZBZrNR44u1Eb60F0i
	Y4J0pGCUzM236lTVO/XsK9k35pJq1i+pD+NiJUF6Fe3cr1K36uP1hK9gD0KC+075
	WhSndg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu0rj04ag-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Mon, 21 Sep 2026 08:36:49 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ccb687f82eso39702975ad.3
        for <linux-integrity@vger.kernel.org>; Mon, 21 Sep 2026 01:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789979809; x=1790584609; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kPtxmrYU8ZrfXfOjYF4vl1wiQZgzuzOfDh5H7b3Y+5s=;
        b=BeCv6j8QZCNJ1YYmNoDTRNEAPElE9f9PXGrsHzfrdlNOgcCHCB6ZboF27a5Pb1LQOM
         arZWF0crabLmFYmSu8JfvXezPDzaz/DYyepUwkRpnW89wQPGEH0LCAuP1l+A2NdoSrGj
         wJjpMWpn7+zBU/ZxRWF559fOwmA5Jg8u3iaNgx1HcQfuwrGnOVFswk5eEjgPT+QLfkDE
         9i7IhwfR4D4xyAy7Om/z6BGK0l3MUEhWG6DaTV/wUx1jtz3AMMp7Sc1SnIOYh2e8oKng
         Iq81nG+uTHBuI3UmHVu4eQPnv8EO6tQauEhtabjfuBWzD4LUbaD2aQwJOPhirL9CC4Bg
         Z1fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789979809; x=1790584609;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kPtxmrYU8ZrfXfOjYF4vl1wiQZgzuzOfDh5H7b3Y+5s=;
        b=LXAeVzdvXcLsEj1Q9RBdU8StV+j2dcqh9e6qFqTzbEDI7zatIAwRm3jvzd4SPppExi
         8rgf8YwXrHr1acCTGsFvyjZ6BxKS0HvaPG0On/PqKAvKLTGcGGNjRJ0xdctjq+MoUM+W
         FGHQb5dwjFlMoltr+rtJKqFCNHlrXXhmdUHRDH0LDxVoR8SR1PqGTY6cDohsPV8ENpKF
         fhOGkvm7BGQUWBQ11UkXf+Y2J1mu3g6eheJygQ7BQxS4OzqdH6d936ApEg1Zkn5kHKsG
         jhRidMbyLmCV16/udgqGIlQKvmz/J/4YRJemldLZxaCHR4Orx1eo21k6+85FVrOp8obI
         dJcw==
X-Forwarded-Encrypted: i=1; AKwUvBxGgNSUj870DAcw0qHM7jje50MxsGcQnat5ncm0ln3K6DhWn1cMgWFREg5gT7WlTydRV8e2EjDh6aQFuG+Kz5w=@vger.kernel.org
X-Gm-Message-State: AFuF++kPTKCJV8arsCxhLELG+oqLnCGMOdWDBPf6iZscYDWq9kYdUrYn
	y21DAD08jJZ0r0PN22uKFVZOfJaBg52NhZGMeMuk8vLF9Wl/5gQlf5CkAiGLaH+HNQ5Ttpseihi
	cVNGqA8sU9hEtnD8KorXORQLKsKScNxSrM184d2cNXyXsf8Qukcsk/yqqRN9YM59YiNmAiYg=
X-Gm-Gg: AYBFou1S088lMBX34X8qkp8UZwMyjt07a2FaYaWMWpdlH9xI9NoakEvlewkANWvxTeh
	fr/zQjzd9FsO5L/vRpWmY0rdy5WOxuflyGlSU65zmuVepewSzR5ynEpB0oFQX28cxQlkEGap9nT
	AEI9rWg6sF570zLQnXJaD8arMZLX/9gizkH6q3DHyrHuouWJMX5I3G5gM5t8nDNPGLNqsRheqgX
	lTWruAs2uVMwwK8L7T9i1IehLF0ewQVNJ2lwltlrwV4cKui5X4Ooa2cYbSoMA2h4Jfr/QuZQ8hZ
	Z4ftWbk8IY0zhsAYPfz8crRiXt8zvqTw4S2vk+S72ieyuIDxdnkCsdAzODqbtd5OJKUoTemM4YM
	Ffd+vHEBg5eGzDy9XeUOpbBApR37KrA==
X-Received: by 2002:a17:903:9ce:b0:2db:20fa:9443 with SMTP id d9443c01a7336-2ddb1b1133cmr154922805ad.13.1789979808853;
        Mon, 21 Sep 2026 01:36:48 -0700 (PDT)
X-Received: by 2002:a17:903:9ce:b0:2db:20fa:9443 with SMTP id d9443c01a7336-2ddb1b1133cmr154922645ad.13.1789979808455;
        Mon, 21 Sep 2026 01:36:48 -0700 (PDT)
Received: from [10.218.31.125] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c331d55cfsm22056781eec.30.2026.09.21.01.36.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 01:36:48 -0700 (PDT)
Message-ID: <d555ee76-3999-4ed0-be6a-ca07354af6d4@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 14:06:43 +0530
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Add TPM support via Qualcomm TEE TPM TA
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
References: <20260907-tpm_qcom_driver-v2-0-71a6b1752da8@oss.qualcomm.com>
 <aqyZtHynb2nuQT-P@kernel.org>
Content-Language: en-US
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
In-Reply-To: <aqyZtHynb2nuQT-P@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDEyMiBTYWx0ZWRfX08lWUBw+E3za
 thk9qqRjwSwQwgnsXmcE11m5xsrgFhU7G9+3C0neBUbaUPcaY77WerSJpIz/cCKtFlTLGCjjEcX
 Rf/eVr6vVX+dq36aLgm8zFtUb0VyCVU=
X-Authority-Analysis: v=2.4 cv=AsR7T+9P c=1 sm=1 tr=0 ts=6ab0eca1 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ltvzBnS6LVNGfPjtTy4A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: UpB1USBuVTwGtE1YopuVBpQwkiWZTBKz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDEyMiBTYWx0ZWRfXx8dM9ycBeLK7
 Fq36ilvAjCFrplbqtAjGez/SbsUA+DRmIk6Q81JQpVYEWWVA0E88p14YUYafL18pJFT/v3jgvKp
 Fa+QEcbNgH+IizXXAIcPsczDMjhzVhImjmPPljQ+/MduWnKU03tFuixIxBH8qvliDRwdQ3CbBua
 KFOMRPBtMCYINugswUpRiAZK9zRqhM2zWxwQ8H21pkOM8DR10IGajEUUmLN/YRkSxhiZGKrjUi8
 uR1SqevcuHNEXS8I0H9ORCMhYOZrLwNNyGFNHWCYzuSvDxonuDgi4+w36Ybrp/aN5WJWnEX/yyD
 ko7YR0uy2svgjmdPtGPwGWLzWw9vWVqwPPZ9rHrY51awxIYz94JwYwkHmxs12LNrQir3PEvehVt
 MpMBhu8FEDgO88eQL7yPoGoIkr8CAvmhN8uWf/EsuLvGHXm/gJ82xX8To6HSUKyA4HlfVmvvJJA
 fsi8hAt7oYcB977ZryA==
X-Proofpoint-ORIG-GUID: UpB1USBuVTwGtE1YopuVBpQwkiWZTBKz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 impostorscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210122

> Causes merge conflicts with my tree when applied with git am (actually
> b4 shazam).

Jarkko, this series was sent based on tag next-20260828 after applying
prerequisite series[1]. Some minor Makefile/MAINTAINERS conflict was
observed IIRC.

Kindly note for merge strategy, prerequisite series[1] will be merged
via TEE tree and current series need patch 1-5(not patch6) only as
prerequisite.

To merge TPM series, it's better to pick from your tree and TEE
maintainer can ACK patch 1/2 for seamless integration?

[1]
https://lore.kernel.org/lkml/20260722-qcom_uefisecapp_migrate_qcomtee-v2-0-b8a8fcbe4211@oss.qualcomm.com/

-- 
Regards
Kuldeep


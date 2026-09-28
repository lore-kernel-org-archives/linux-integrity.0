Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E6B364E89
	for <linux-integrity@vger.kernel.org>; Mon, 28 Sep 2026 08:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790585899; cv=none; b=i1kNPMY4fS0ntrlE6QbLRLz7Ws+fAxaHNbZN7DZx+TVRiolGw1PItx2YN0sXrqqrUHv4tmZPoKsRHwvQvjcXktbdA52RKpazv2tGBej6AHgmqtJ32546HyNbBzcLOGXEkzQwGDIxQZxDyyYFLHhPTGgkMGKxK8c21QhVXGVvpU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790585899; c=relaxed/simple;
	bh=QnGVPdRF5BQ4R3RWf2F3HmnJIaAinMYoLk7wpgpUFrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KbrgAUK3BI8k+8Teaz4SOLY/WThyPs8j43Zwwlf0305V2NM5WnFs6BvwaHfNhvIaC0ByCbYTxoifYUGyP1eCu93G0RmDLsWbEQlsHuL9Ur+hhLVnj3wSRc+9zt9qBMoF9AkZ9C8rLfXkUanRv0dr+hl+jOn+cmmsEkMtBe5Iacw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZdZsHRNw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GdbYh/WI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZdZsHRNw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GdbYh/WI"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68S80l4Q1422216
	for <linux-integrity@vger.kernel.org>; Mon, 28 Sep 2026 08:58:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xaXj4PjqLEDQu2RCV2Zkjhys5ijdfJNEie7gMliYE+Q=; b=ZdZsHRNw9uXfAL5w
	BozeSD6/zbQlWxZsLW0vku1sEm9hDelF0RNCJyN3KJ6ONYtgvwOOvfzl9wSplsZ8
	veLGugP65+M6rfmhti6yLfDuNItWwE/TQ/X3v8QL1wtt0J7JNTryAtK4CCJFngrJ
	8jEg1LRNAdwgPlJ2vREghhmhsZPvMcmbxdTnujMwp8E87R975UiUbGvUgjOvb/IX
	ah3zo1TqXcPwBgDCtZQ+Tfgz92+OLISWqLMifNby/LN70b2x31p1n2p4zuPhGSjI
	92jUKi+GZK3xxINo8FXsUU2gmSF0WmL/ODDb+7iUqd2yxsOkdhCu6gER8q7ihen+
	SuBw/Q==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx5mwdcpy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Mon, 28 Sep 2026 08:58:16 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc489e7a701so3488454a12.2
        for <linux-integrity@vger.kernel.org>; Mon, 28 Sep 2026 01:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790585895; x=1791190695; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xaXj4PjqLEDQu2RCV2Zkjhys5ijdfJNEie7gMliYE+Q=;
        b=GdbYh/WIRUgEhB3/R/RdfutMklB9Ao/tTyoXHp+ZO6PD88NJHkFGP+an3vyq/6lCr/
         DCnIJKDiGXbwESf7HvXfdujYVfK37IZC4Xwl9orS2/7ndccO7ODycfH4R6Q8Ct7uhjO+
         rQsdncehxZxV5l6z5QZwpC982x5BNSGpVd14oPU2O48cv16GA8tRWDsFc9Eu+wfHahR0
         ctRQXeWyHt0TALS+tkHMTRDA8LCJSrkotDtTwI9z0rziX1KrLy5xdKglB6BNCnujR/hp
         TyGpwVM8U88RbbRdyQY/OILI1OF+Mj94zIHgsHslQqLZiIsyv7yrAfD5KV8ojw1Y6juw
         QLGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790585895; x=1791190695;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xaXj4PjqLEDQu2RCV2Zkjhys5ijdfJNEie7gMliYE+Q=;
        b=TSk82IeJE2emkE/LzoAb7r7eqXGLrzb1aw7vMsaAIhbx5TVwaohu0uX17AirVnOJxK
         sS5AmvR1G/yVeatw1dFhORlJ1lFCgw4UD6PDXA0de0NyixaA+UcPFjqtEj9CnCelYtH5
         7aHNVQnlbyscxA1RU9Gn1+rgGbBrQYPrfLVpRw0e4CCwndmEdpNzlh/+ClEl5ehl5w8+
         1hoNagftgbTtgnTjT+ArAVCGP8EVKmCzMOf1pPmTzQd9o8wPZcLoBJa7wuWQK/Fp6+fL
         Qq/mmXslwNOEXPytJU+b4E2EIyAZc/Ha29Rkb9DUST4TLAgwaJU2pG4RvlxmntuICPR4
         kIIQ==
X-Forwarded-Encrypted: i=1; AKwUvBySfmPYupU+cxGLKLhkWXZ7LXQBJrAIQHRHR/7UsZE2447Hal8L4io5tbBDM2QlHzRscoLqTpxjFEkFvkg1MTw=@vger.kernel.org
X-Gm-Message-State: AFq9FYI/FSzS+JFxKP4pH4lIWkwCIrOsZGichzwdSVISCQRINDOr04In
	gWLaWDjUkM+PbZ1uo2+lgrE5uFWnc7LYssxB2zDtojzfyVYrfOdlr4nDhxJGQ2r/hwNfg6t49S0
	/IKhm0cwk8qq9ga3M1OjEI3OwiSizYuRDtPLt/3v6BIrZUywaaTlw1kXNkyvDRbQFHimnjA==
X-Gm-Gg: AYBFou24tLlj+/5vnl0wdfzE3d2Dd9Qgv3Xq8jwIfm9x0NXvJZN7H62hp54VcYyEH5t
	hiJrAwQF6GPpZ1PYf56eP5sUfgDG631ziR76720sJLgzzq0ADG1qrqy0H7EEQQ57vzO3lEZ8Wot
	Q0FQ8M8a6OXF1GAexi1AZe0ny5Jn/aglqgNly1xacqc0kNODgq6MCIzAOUFfC80mAHzaVMzOJTR
	zva/V+PfBKrRVcZB8U5ejv7FZ8EHOsKm2Ex3UF8BrQGulyctTYa9yFtK78A6P3SgjY6ullzVQ9h
	RiS1wJE9JtpW9KK1s/qlUt5QJwK1qe22iVbcJDdpXODUgyG1zjsCPBUjGVHShxCc26d43Tha/8V
	oWuy5izn7GiCpNkw2MfN6JNrFqua9OWIw
X-Received: by 2002:a17:90b:2250:b0:39d:f247:bb3 with SMTP id 98e67ed59e1d1-3a098b4b334mr10136991a91.21.1790585895467;
        Mon, 28 Sep 2026 01:58:15 -0700 (PDT)
X-Received: by 2002:a17:90b:2250:b0:39d:f247:bb3 with SMTP id 98e67ed59e1d1-3a098b4b334mr10136980a91.21.1790585894976;
        Mon, 28 Sep 2026 01:58:14 -0700 (PDT)
Received: from [192.168.1.86] ([65.181.14.184])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0cd1c4ec9sm15313374a91.16.2026.09.28.01.58.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 01:58:14 -0700 (PDT)
Message-ID: <c0e3afc3-899f-44fe-b865-a32892e00cc1@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 18:58:09 +1000
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] tee: qcomtee: Register qcom.tz.tpm service for
 discovery
To: Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, Jens Wiklander <jenswi@kernel.org>,
        Sumit Garg <sumit.garg@kernel.org>, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-arm-msm@vger.kernel.org,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org
References: <20260907-tpm_qcom_driver-v2-0-71a6b1752da8@oss.qualcomm.com>
 <20260907-tpm_qcom_driver-v2-1-71a6b1752da8@oss.qualcomm.com>
 <aqyX3lJ1eNBmzbSP@kernel.org>
 <a8047ec0-742f-47f8-b5bf-cb1b32f06bd9@oss.qualcomm.com>
 <CAGgiveUA665UFwoojYBOB_rvCh=3NBug-B8xEBBVNPC=0jTCQg@mail.gmail.com>
Content-Language: en-US
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
In-Reply-To: <CAGgiveUA665UFwoojYBOB_rvCh=3NBug-B8xEBBVNPC=0jTCQg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: XAhLVXgIjRCXybJlda_qM6Z_qgidIfVf
X-Authority-Analysis: v=2.4 cv=QvPLTlyd c=1 sm=1 tr=0 ts=6aba2c28 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Pslwi5Fl4CR3OXkguhnOPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=aXdvgW5Kdip_ic-aS84A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: XAhLVXgIjRCXybJlda_qM6Z_qgidIfVf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAzNSBTYWx0ZWRfX9NaQy7G0Bbu6
 hizxt6zrrGAojJmkXowpml1YHhBrb34fN/Kn76n6h+5m6IZpVXPELkKXjCeoyyRXt4KWfQLzTaL
 Jm8C0Q9Uu/LGizpQURJbZNHRsybSi4Byku0XnkO3+4MDLNmJSzWYqnosCqc3ggFFO1PfSDI18Cd
 ngMaK6eFkS8Nxzj7Jv4mK2M8Kakc/RT+utxsgSbptgvEwAaqC7tb8gmbww2bQIRbO2OzDGIkspU
 AhBkA1P5KQA7UbIGm+FUNicJvGaFZgGeGC9cckC7yMIMRx+i9H4OfIkT+cLLOuRKCoFRphwB1di
 gjmPshqAHHx+gZ/goatEiYcYY08DHiXFDBfOCI18VsdBP/eC98xRUf/BqbX9qTRVyqcDirGiNk0
 ukNvNGC8LS9XnSFgekGzZHjI2BS6APtAxR385tBgXA37bUTDx4P6OqjkpjtCk1hqQw7M8szjbWp
 6vvpkiQpQtUG/5Izfiw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAzNSBTYWx0ZWRfX/e6jTloAk2Zd
 efukzWjqV6M8joX2eesJanPDTO6TAAdppaUz27Av+GyKPLe0+8JYVZ67IfA48fU2eP0sOKPcFV6
 a9+NTEaYMIi8P3u80YHEfH10ZNxU4/4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 priorityscore=1501 clxscore=1011
 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280035

Hi Jens,

On 9/25/2026 6:51 PM, Jens Wiklander wrote:
> Hi,
> 
> On Mon, Sep 21, 2026 at 10:10 AM Kuldeep Singh
> <kuldeep.singh@oss.qualcomm.com> wrote:
>>
>> On 18-09-2026 07:16, Jarkko Sakkinen wrote:
>>> On Mon, Sep 07, 2026 at 02:58:41PM +0530, Kuldeep Singh wrote:
>>>> Add "qcom.tz.tpm" (QCOMTEE_TPM_UID) to qtee_services[] so the TPM TA
>>>> is enumerated as a TEE-bus device, allowing a client driver to bind to
>>>> it via its generated UUID.
>>>>
>>>> Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
>> [...]
>>
>>>
>>> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
>> Thanks Jarkko for the review.
>> Can TEE maintainers(Amirreza/Jens?) also review this change?
> 
> Amir, please review.
> 

Sorry for the delay. I'll do.

Regards,
Amir

> Cheers,
> Jens
> 
>>
>> --
>> Regards
>> Kuldeep
>>


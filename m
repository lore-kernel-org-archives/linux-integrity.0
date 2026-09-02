Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FA74137A1
	for <linux-integrity@vger.kernel.org>; Wed,  2 Sep 2026 09:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788340947; cv=none; b=O6CVqR7zDeNYA4XZWrg0lgzU7kt+8P2JlUADH2aiMTejlY04jQ1vah+CyoK40NC0Yk97nlYEw2CQWv0lkDOnejo68yQNiaLTk2sIy2xn4z1cq6j2446wRw0TnCbzpDW+vGCeOTAHMPwww11JiKI49NUn1+LH2qwQ0U5fZGAKhso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788340947; c=relaxed/simple;
	bh=Ix9gy4iNaJC6TKz8JfDA7ApKhF58oPVDVuveegmoPss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NgKFRc2nw0vubmA+oYk/JOvtAZZ7hU7cirTaq58ZPn+ARAcyx3BlTmAQyRa3Toc1KPJKRR6+tNCC6s9+eFDLTjCCfQhtQkOdoZIe0BcLOyjTdafrXLAIcKqPSkAUlJKr8bMTdAgeaS6lTO7kCPa6PDe8wIh7pbjNyN4hY0K7y44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hz8QZcL1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=T8Hx+JGg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hz8QZcL1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T8Hx+JGg"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6826VTYH1859138
	for <linux-integrity@vger.kernel.org>; Wed, 2 Sep 2026 09:22:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2B9311cIh3QhjI7jQVcMJXJqQDtRI7MudWJkahg+Q9M=; b=hz8QZcL1gUEAjyF4
	ifjO6XomZtCApAIVtzyZN5VGc/KBHr0C4BFQZGNxDWd/gjAePmX/FvTl1ac4XmCv
	JPaYtInDdPtRyXuAJ908ypIDApb9Dhhm40y80KMJiN5oSF8+YhwUkpHxp2UkbdPp
	IsuH1N6XJBOZCN4RnWMIyUqbFGwQfoEeOQkjqBNSbd6V2mabEUI++EJT6pE6EI/V
	fVmAC5tf5XmdF0ZH4fwMOzbjcCHiTKR3tq3ALApU5yHiQfsGTQ1ooRZMHo8wkO+c
	MdictcwhoVU42e5IceF9an6Vsq+1yehbhZmIfn1A5XwhMUk11r7Byr9bBoD6VgEB
	rKA67w==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ge8whht2s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Wed, 02 Sep 2026 09:22:24 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-398dcfabbf8so2129671a91.0
        for <linux-integrity@vger.kernel.org>; Wed, 02 Sep 2026 02:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788340944; x=1788945744; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2B9311cIh3QhjI7jQVcMJXJqQDtRI7MudWJkahg+Q9M=;
        b=T8Hx+JGg7PkM1pJa9AaKbi4+FsM7X4kXfWKv3EDXlkKMLW2duuiE8MFpmSIve3e9sb
         5yo3B7GsaA0ryVrqtKyaQnaW0WMIgbHSboq8Pz/9RzCPV/jtIQ5Ww1ZRmzDQSbCBPuDv
         7KHvpbJeOPeOUgWZwvFMaRrRKcPEglJpZ5wmTKmYclFdI8Pg/QIPUKZWaE+YfgeKocpC
         OlCsmH/3Fk9cNkKAU2cWWIWuX6p8rVuxLu2HqpMJJO4L7M1X8IihAStFS1J4fRTPWUbv
         vkvyS98dHCP7I9zU87KvsMnoM+Elc6KijyINEZsFJPIyY+hoHloffl4m7ZW+7zKkXN7J
         PRsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788340944; x=1788945744;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2B9311cIh3QhjI7jQVcMJXJqQDtRI7MudWJkahg+Q9M=;
        b=ipMoo+/BiU1qddcuOeS3VFmcI0tddlJ6M58htYFlfE4PmADht1LQjP2cFlgfe+FCWn
         hM935jEUEII0uShMbbw+zYjBEgEY3ZhU+CzckEZah7y241+vI4lRKmpyslEcmY4TNunU
         qepKkVSUrb5i+BGGV9n3ArByY6zlCeNC9YcNGgWDVITI37i601dnzUPdRmO1YucK54Ua
         u04j11CvLC+nVzStoBIJVrVRQuKDsWcb46U37123MJid2lqfHiDdOKayjrgAffKFDbd2
         vlWa67iWyJK+jz7k6OPMl0bEExXK0dN3Lf4hNza/tuz/3v7YwhwrfFgV/UTnNGvyqEia
         gTMA==
X-Forwarded-Encrypted: i=1; AKwUvBwMOjgf5jyDEqmn+0fO6vvcmaij2S0EODf+I3XzGqUSL3fbSTkFsne06xhXRus5MGlwfO0pbi6hxVstPDXVY3Y=@vger.kernel.org
X-Gm-Message-State: AFuF++nihaQZ7NBrPxoZ+e5e7GJXbtG6Aihly3jyOVB1taZRoFKJTR+9
	KQYd0UXJ9eSAHUwzFs/4dDTX2Axpb1VuVOvp/MF0pvXK5L4YWKg4IlA1kG81D1l4yAMuC3ZA0Nx
	EkRCNDHlmYN77ZX0/i3nxbpfLb7fztkHBtIPBIFbTlsgDu1SpzboMQIZ2d5SYHyuqMqzNasI=
X-Gm-Gg: AYBFou06GwRz9DYy5CKVPtVGF1u3CIgkW0Lvr2C7e2Q+grOSjalyHr6BRLknhLHghYm
	peqmElk7HnO4zcexQ+ohtpVkgk+rOWBfonjuxvDMUGNALztI1cJOK2fFi94n9j4hmjABG24CWmT
	91EkIx4vFPKkyg+pIxjdgm4cQU67GAKhGRT1PYbXqP2reeizUAAjtW+6ezaBfUJjgILO0G31MyT
	9TbGU7cUJlMxriYCxFWeBzSeGCq3pjm3Gsz25Vmvmhjuv/9uvCNsMtfyMNt/2RTwNkroJQYO+0m
	jFbye2EM7JmAciek/73dE6xAKk3nNSMIPArmmz6XTeqDnKhebL/hkSYcJJqmzIaPs8bT0FRKLxp
	L1SUkhjJaeHkbFyy4nOUYRLU3rErpxqQ=
X-Received: by 2002:a17:90b:54c3:b0:399:ecd:d68d with SMTP id 98e67ed59e1d1-39aee26286emr5767763a91.22.1788340943832;
        Wed, 02 Sep 2026 02:22:23 -0700 (PDT)
X-Received: by 2002:a17:90b:54c3:b0:399:ecd:d68d with SMTP id 98e67ed59e1d1-39aee26286emr5767708a91.22.1788340943425;
        Wed, 02 Sep 2026 02:22:23 -0700 (PDT)
Received: from [10.218.31.125] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32f079f7d77sm4998797eec.12.2026.09.02.02.22.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 02:22:23 -0700 (PDT)
Message-ID: <38984608-4b5c-4355-ad85-8c5a1fb78cb2@oss.qualcomm.com>
Date: Wed, 2 Sep 2026 14:52:17 +0530
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] firmware: tpm: Introduce tpm-qcom driver
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
References: <20260831-tpm_qcom_driver-v1-0-6f16fa6924fa@oss.qualcomm.com>
 <20260831-tpm_qcom_driver-v1-2-6f16fa6924fa@oss.qualcomm.com>
 <apbXKZrjFdK1vrny@kernel.org>
Content-Language: en-US
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
In-Reply-To: <apbXKZrjFdK1vrny@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=fLkJG5ae c=1 sm=1 tr=0 ts=6a97ead0 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=OCHYf-eeibxfj-F0XOcA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: AB85C7FkJsaBMAqE0z_qkMvpatEK2ulU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA4MSBTYWx0ZWRfX6A2Lws7MfYrS
 8vFMA++QchpMcHxc67OLjHInsCXRyWgIy0nilwdI4AK2XMUfRnUAEpw0DsWIoeypGXT7u21A+Am
 LylJEGls6BUqS9f0a2bYxWJSJWSQOScyWBfajS/zB1lrKqmIHu6HJnBwcW/RlJURdDc+ES/RMlW
 m2lzvl8HTeIg+cADFcLlch0lDUF4kuuNPEBtNaAjdDYUtIRKCNSR5yzhN/8fseOdqi3a3uTHLCb
 /GGisv6VNDl5GFsp6n6OQXjv7ou8sxoYJ1aIOQ50nxk8g4V+48qoDqYlKvl22nAuU7JcOrxGS9s
 0KdPiLb1eGzOaPM2k864LOAgQ2m3r03V5bveI8DUwVBlbZGZptXKhLVPHZcgEAvfNYQOV+J1TDY
 5aD3qPM8T0bNKe9D0B4w2QMW9UOg5sCUgq2v3M47rcWkpq1HSYb94xtFmL6jAzfBpnCVWaJxKSC
 IgvYt19mNVDtFFHKWfQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA4MSBTYWx0ZWRfX/Zn5GC2ecQdZ
 U+teW0xuC0yW0pXHSUNDax4dK5wxCYbHViAye/tZWepqu0bGeu0wxA2Sr9H8Ztt1wZMSVpJ/KAf
 Cu5WrVDKe5z0f1ys6+btHfhlpL685/s=
X-Proofpoint-GUID: AB85C7FkJsaBMAqE0z_qkMvpatEK2ulU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_01,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020081

On 01-09-2026 19:16, Jarkko Sakkinen wrote:
> Short summary has a different driver name that is implemented i.e.,
> it should has "tpm_qcom", not "tpm-qcom".

True, let me make more generic like "Introduce Qualcomm TPM driver"
instead of having driver filename in commit title for any confusion.

>>  MAINTAINERS                 |   7 +
>>  drivers/char/tpm/Kconfig    |   9 ++
>>  drivers/char/tpm/Makefile   |   1 +
>>  drivers/char/tpm/tpm_qcom.c | 371 ++++++++++++++++++++++++++++++++++++++++++++
>>  drivers/char/tpm/tpm_qcom.h |  82 ++++++++++
> 
> Rename it as tpm_qcom_tee just to be aligned on how Microsoft's fTPM
> driver is named.

I'd say firstly microsoft ftpm driver should be renamed.
For example, MS ftpm is based on optee(session based context) whereas
Qcom tpm driver is based on qcomtee(part of same TEE subsystem but uses
completely different mink-ipc based sharing mechanism).
So, it's completely different driver compared to MS.

My suggestions:
 - Rename MS driver i.e tpm_ftpm_tee.c -> tpm_microsoft.c
 - Rename Qcom driver i.e tpm_qcom.c -> tpm_qcom.c

I see pattern like tpm_{loongson/atmel/ibm} etc. so better to follow
this convention?

If ever need optee/qtee to specify, more namings can be tpm_ftpm_optee.c
and tpm_qcom_qtee.c?
Personally, I don't prefer tpm_ftpm_tee.c as it's all generic name with
no optee specification.
 >
>>  5 files changed, 470 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 47b04968e79a..cfa5b66823c7 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -22636,6 +22636,13 @@ S:	Maintained
>>  F:	Documentation/tee/qtee.rst
>>  F:	drivers/tee/qcomtee/
>>  
>> +QUALCOMM TPM DRIVER
>> +M:	Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
>> +L:	linux-arm-msm@vger.kernel.org
>> +S:	Maintained
>> +F:	drivers/char/tpm/tpm_qcom.c
>> +F:	drivers/char/tpm/tpm_qcom.h
>> +
>>  QUALCOMM TRUST ZONE MEMORY ALLOCATOR
>>  M:	Bartosz Golaszewski <brgl@kernel.org>
>>  L:	linux-arm-msm@vger.kernel.org
> 
> this change should be a separate patch.

Ok, let me make MAINTAINERS entry as separate patch.
Also, i noticed none of other driver are being even compiled as 'M' like
atmel, ibm etc.
Any obvious reason behind this?
Should i enable tpm_qcom as Module in this patch only.

>> +	print_hex_dump_debug("tpm_qcom req: ", DUMP_PREFIX_OFFSET,
>> +			     16, 1, req, req_len, true);
> 
> Please don't do this. It can put production systems at risk.

Ok. I want to dump some contents on failures which makes debug easier.
Instead of dumping entire req/rsp buffer, dump tag, reqlen, rsplen etc?
>> +static struct tee_client_driver tpm_qcom_driver = {
>> +	.id_table	= tpm_qcom_id_table,
>> +	.probe		= tpm_qcom_probe,
>> +	.remove		= tpm_qcom_remove,
>> +	.driver		= {
>> +		.name	= "tpm-qcom",

Whatever naming we'll decide, I'll update same here too.

>> +
>> +/* dTPM SPI transfer optimization:
> 
> Block comments AFAIK should be
> 
> /*
>  * <TEXT>
> 

Let me fix it.

-- 
Regards
Kuldeep


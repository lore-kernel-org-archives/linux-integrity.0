Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1843DAAB9
	for <linux-integrity@vger.kernel.org>; Mon,  5 Oct 2026 12:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791201633; cv=none; b=e41uIwcaYcLESpX3MS9aW1FxD+H9BgUUn6qPvl9YB9Wqrp8O+Tlm0u9gzUGlVdMvAINqBCvMkxx3hW2UsHFSupf/ZVzkI7wppGaJwNTb6sHb6OuiTPfSqADgefGLLjuMtyG39DBDB8x4MVPzer7UB57uK/R9QrAIdibpmYY8Bls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791201633; c=relaxed/simple;
	bh=J4f3p9npyqHrcIAJJeagZsStVI/MJ0U6TEfe6bpSb0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gn0RVkgxEC3REumDz4rmm0+/jtaGkSPSq5A4VjMoYwVwmpznQioVrNLLit69cYyTXNUoU1gYtuBZYRbOl8iwYPJPfR9AzeNIx+mmk8XxziUM323vdfo3IO9CibOJykQbRG0xeTTqVvfcbzqMWpDcy/ZGWLTT5jJFa3tSWtXJtIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=atC8/+GU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=j/MVrc+0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="atC8/+GU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j/MVrc+0"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695BTvTC1830141
	for <linux-integrity@vger.kernel.org>; Mon, 5 Oct 2026 12:00:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NjqrkeGFYtSDE4uh57Qyu5uwPPi7oB0ETinHFeakgL8=; b=atC8/+GUTPUwWVMT
	STecLuCaR8X/jeIAcvaelX0sxrJ2tEHRqQEXCaPKa8TyDKd0/V+vFJ8hLSNWBsP+
	LB1DqGTiYtnXMRMcGJ149UE6O8iQC/RsNxWuczKl8RUz8crNsbJgUun+XbXCTeJv
	hXnFNMW9YJizYijb6FCVtjjZUPLT35iJeBGe5jXL5U46IOywT7MngsgrqWeJp5lf
	B9STWTf/Q8NyXDTnju9F6sSRRarstjaLJ2gjGKZuz58BCH1OsXoFJ5XitnYIKbj1
	ZMJLiPlDAd+LeCRWOvSpmMmfAdQC0QzYqJNToF3aQy1k7Tq+pFnY64l1h8HbiOWf
	GV98xw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h3xgysygk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Mon, 05 Oct 2026 12:00:30 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-395543dc382so1556494a91.0
        for <linux-integrity@vger.kernel.org>; Mon, 05 Oct 2026 05:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791201627; x=1791806427; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NjqrkeGFYtSDE4uh57Qyu5uwPPi7oB0ETinHFeakgL8=;
        b=j/MVrc+04j/nmdYVlTJ8snrVX6jWyo7IX/8hxE001EHnq2pPQW4HdCghGS2Lm4VqmO
         Myds1bEyfQGt4jyEHKf2NtY8IFwg1ZNb6BaLwnyc+9qkMnEzpGZkt1UHzPXH5zUFrL7L
         gRikHVVmCLCMIHjY/c0dFFvykFUu/qzIrmGUEC9FCGmP+ThhEmXcnze+P0MEiwXemWEM
         ppqiL9rlRqLPCrs4lmctxs/r9nWk35BG2/BxFlr1pWehSh1XqEfiW+svVkqUl6Ctikhk
         e9KM/8sK+Z+jwjQ01jJ7lik41qhooTuPA6Zzq2ed9QEeURExBTvgE3g/Gd0F/xIp4qVm
         j3RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791201627; x=1791806427;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NjqrkeGFYtSDE4uh57Qyu5uwPPi7oB0ETinHFeakgL8=;
        b=gpQstGgtzWSAaINQU1Ij5RY7w47AlOEuZRjRwfSvKWFPwZsVqqXVwFuvq/MRmYInyJ
         e0JxiBFk5DFgLfU6JtqKAPxoY9qqhH6Pp3rOPi59u7fsxicjR4zDWjNJwTmQIm6GpZRd
         f9fZ+adVyNjgewuVDLPqHKfijZa3r85MtQ7D7AygKjlwgoDEDm3mCMWDWoLK1ux8B79j
         cj0/Gg97NSB05n6Kmio231BtYP1swMErDK5SXwkn5PYxQEEusZOqIeZoHrBEk26bbQ4W
         OfS9lIHpHQNk8WoX2IVsS4IcenMcrdexFQVWgErkQ8tMB32vYf6fFQ5oorXcUClNGS6W
         pyDw==
X-Forwarded-Encrypted: i=1; AKwUvBxqB8kJ/mqq3jwU995a41gon32xvAXDZpo1iQc9lE14tifZwQtfsHpwQF6ceqIW3dVRRIpf4rJ7NSfbxuIwNZQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKUoSR4ya/FVHuhpQ0MGnDQ2cl9PHwnE7i5XBjgGxnYypwbMol/
	mlf5y2r6S6HVVeNp+XmM3+CDdZ/s9McYvQSt6fCbfgrEhdZyHwSNqjSwxUsJO1QAhVldHocStC1
	Y6PqxJqddPkxbw1QJ+meiS9LiPr315rmL2vf/bR2xry49ddF8uLBZCds5R+Iy2+q7WrMAJC0=
X-Gm-Gg: AYBFou12IxfACBYRF3EBBDRUeUV9xXClgr49rrT0JJ257RgKXq2lgJqxWmGneVQGftu
	j7A1sK0fQee3RGH6x1Aq4jtaCaULPQ5ewWLomsLDvxwqysnV+/TLhA/fS9eUBEOXzcwxJhQuQGr
	q2vhM03SvqhsegNwGfY9j8gfeCfDEBvY2h4cAQ4M57mQyP5QAXDZr9RTiIuipa0/hsngcEE7/bn
	ELfmOIQmGbw5lRr/o2SnIN7tsAsoQRk1UCr1EpwxYrhIoq7rtiSN4J6fWWRnWXgr9Oi9USQ9EIG
	vkyumlKvmxyKi2J12xA4veayyxICBW/zECJtHRmav4D21T/5T3bZAP2cGSsQ5WsfrpnynWs=
X-Received: by 2002:a17:90b:4c05:b0:3a4:ba6e:65c9 with SMTP id 98e67ed59e1d1-3a6ce963ad0mr4301072a91.59.1791201627253;
        Mon, 05 Oct 2026 05:00:27 -0700 (PDT)
X-Received: by 2002:a17:90b:4c05:b0:3a4:ba6e:65c9 with SMTP id 98e67ed59e1d1-3a6ce963ad0mr4301044a91.59.1791201626566;
        Mon, 05 Oct 2026 05:00:26 -0700 (PDT)
Received: from [10.218.31.125] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a78d6b3ceasm11047079a91.10.2026.10.05.05.00.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2026 05:00:26 -0700 (PDT)
Message-ID: <e1ae7f91-0787-434d-9553-3ced487fac6f@oss.qualcomm.com>
Date: Mon, 5 Oct 2026 17:30:20 +0530
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Add TPM support via Qualcomm TEE TPM TA
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Xilin Wu <sophon@radxa.com>
Cc: zeroknots <zeroknots@protonmail.com>, amirreza.zarrabi@oss.qualcomm.com,
        jarkko@kernel.org, jenswi@kernel.org, jgg@ziepe.ca,
        linux-arm-msm@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        peterhuewe@gmx.de, sumit.garg@kernel.org
References: <20261001055029.1960743-1-zeroknots@protonmail.com>
 <0c6d29ce-920a-4566-9a4f-a0687b0e5ddc@oss.qualcomm.com>
 <b2xdth3hkuypnvxlrgssnj4toffbceohhnh7w2ju46fzinflfd@qaq6ai5plolq>
Content-Language: en-US
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
In-Reply-To: <b2xdth3hkuypnvxlrgssnj4toffbceohhnh7w2ju46fzinflfd@qaq6ai5plolq>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 1TCQVxtIDFf90rt_tFt7-93zWIWFNAGZ
X-Proofpoint-ORIG-GUID: 1TCQVxtIDFf90rt_tFt7-93zWIWFNAGZ
X-Authority-Analysis: v=2.4 cv=A6b5rKWG c=1 sm=1 tr=0 ts=6ac3915e cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=WzojQP8EweJUJc-V32sA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA0NiBTYWx0ZWRfXw+XIt+tynB+c
 eW6YDfwnbT2TaTiZqoaiqNOu9oTWJWdyeVGScUiYraTOxm9rS7/i+waGqrSdEX2VQa8b6dWWdrX
 tm6qsELlBEflLeXDjrnUmauaYKf8m3zUI0cBbtMYL4vgDvoio3wM1QfJMPrprDHuPUSkr8rcE5X
 OSasi2XlHwyPzNWHDUoSPJSAidOr6qc8TuJaN8U5dzS+AtG8MmrFdJPzf+S52In2b+ekW9knd0e
 zpsZ3OkXr0u+DiMfe4owEFR8hN00KSNrgRauQkvcg6Pshz26S0bbr3s1llF+6YG9CO9S9RHWwp7
 xdf/cqk6Hl+HFoVh2cixXtsbAfMc9dpzm5peGtU2fir8objSUfT40VQoJDauxnw1qBG6FEFGmiB
 yUqs+5iHzwMQGXAZW0B74/uBphce/QzPLRb1w4eLnYUg2wnmVEN6A+tEylcEM1ZAV+pOQ73viwl
 3ytjwWYTUTDnQJ9SrPA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA0NiBTYWx0ZWRfX8RqcXrMvv5uS
 ZfV56c5w6+9vnGHuvofOEZYPZEMC2bWmk9+2GKzIntd7vIwwLdJy0y4u+btUEEk699ZDKF6lQMx
 EZF9sJDstXkB5r9bQEoV2bjY6vFOX5g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_03,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050046

>>> Two questions:
>>>
>>>  - Is service 81 expected to appear on retail firmware through an
>>>    update, or is it specific to the CRD firmware?
>>
>> Yes, there's spinor update(bootfw2.mbn) needed which is in progress to
>> publish as QTEE side changes were already merged long back.
>> Roughly it takes ~1month(ideal scenario) to get firmware changes
>> available but somehow it's taking more this time.
>>
>> I think i should have captured this dependency info in my series cover
>> letter to avoid any confusion.
>>
>> With the changes, service uid 81 will be available and won't see qcomtee
>> driver issue log there.
> 
> You are responding to the user who uses a COTS commercial device. Are
> you suggesting that the user can somehow update the firmware on that
> device?

Ahh, for COTS devices as one cannot replace firmware so it's better to
use qseecom path in that case.
For latest ones, one can switch to qcomtee based approach.

If Xilin already has qseecom interface written then it's best to have it
for the COTS devices.

-- 
Regards
Kuldeep


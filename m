Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3613D7D8D
	for <linux-integrity@vger.kernel.org>; Mon, 19 Oct 2026 06:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792390680; cv=none; b=IlfKAHLamUgTO+MANF7QR+xRfnhVaYZpAkwhYnSt92LoONq1PE4Y87KsgZRLMqJxFrPmJqBreqOQiolT3QW9KLb/20+tQkVVi7nsk9VF580LEH4IxPHMQuHJT37RifDsgv7sYSzpRZeiVbYlJljT/SVas+B8pjtdc/pbkReUYFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792390680; c=relaxed/simple;
	bh=hT3kconPAO71ZAgCnNBq9KkOENtVYYhR4KqdJA6cfk0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e9bgP73yXfAVsC4PuavDeE7J/vTssVbJIvAM+DzqxOTKhEFn3e2Dpp5MC2/6f/OKKaL06EjKMU5lgVGaMG/Zt90BW5g5vcpWDm5Pni5f7pFcKxIm5P/DY9NpKCBn+rRFAlBUAcjnfCpmIYnDbx9blokivaU6qs/tppwCWDS1rfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CiLn2vQu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CbmbzSQ1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CiLn2vQu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CbmbzSQ1"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J4iuI71405350
	for <linux-integrity@vger.kernel.org>; Mon, 19 Oct 2026 06:17:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	06159emas6EFWdKcDMqYp+aj70RJ3dHGp+7F881lMJ0=; b=CiLn2vQuMcLzGow0
	xpNe9dDGBIItBH+h7uzFCA1iQKtfahmc3/In2zjq7GhKXTRfzEGSauz/Z78BPQVk
	xskwMPfTcmOIblFHnjMnvWyIXs4fVo1tGPrHgQy6mX1fkZO38GJS5qVfMlbYMn/U
	p9I9sajflr3RWPxJfCsDcHfaQyog/f6a0lDFe3Gd95fs187trY/sT9dcnBCr5+lk
	5ln43iHtYpBeeFK6MZN3Yjfcb/ScRur4d+wLpbYnUbkuy8WP7JQnevsLtwy/TQJx
	CoHe2N3MnrV+dD+NmWmuyefVEjlHo96h5KqzW5n3Bx4FUJb9sETFXdFJidjRY6Ws
	rgzYJg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdbvr8dqn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Mon, 19 Oct 2026 06:17:57 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-35d4538fd74so6548794eec.1
        for <linux-integrity@vger.kernel.org>; Sun, 18 Oct 2026 23:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792390677; x=1792995477; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=06159emas6EFWdKcDMqYp+aj70RJ3dHGp+7F881lMJ0=;
        b=CbmbzSQ14QCNnbHIMjAS9r5MOOzVobnMeRFeAmLiuGKxHFuI7giPYKEeGX9IND8ptV
         NM0htSAdV6tKXumrdqOfQBJuRq+7FGMC6L0513w9Srl8nXAplROLOvzPNNK3gmlJU8Su
         XjIwAPU0I0S4ZvJ0pakxW9jgYZUEVGhDc/YWKwg3JpgeEgOOg1LCRJFk5uJc7VC6Dcmh
         i42oaqjwDjcNU5Yg8N5cviqT9dDS4eQWY0r4E2/ZIgs4pSyIjfypSivbj9VECq0XL1UZ
         7N/NL6HMl4ZJIYBRfUzCdQLO9NC+5MixYm/Sx1dgqeB/9if2GDD8TQFcsB95T/vt9CU1
         k7jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792390677; x=1792995477;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=06159emas6EFWdKcDMqYp+aj70RJ3dHGp+7F881lMJ0=;
        b=b/Co8b6aKAHsB3mH7bVLlf9ZCg712A659KHJtBJ/OqjIHuMQDDT2zF0lif3xshhrHk
         LxRh4GkXNHAICUpvyjAn3OdUh8hIa7JWJ50dsLLBrouT5QPJxV6uX1tEQ+Gus9RPkZg8
         doEEuspBp1AKcbuUvHNzbJgev6dprePyv6VzdZRaoUcp2oQAsh56+HVD59hiidklyJx8
         5dz2j391/8IlF0ELEEB6XnP9sVsRWukIuvRT0JixPvANJ058IEt6gC/sY2lWZNHkQKon
         BTuDUuErI6V+vZFgCPOpUqgQssf85W2uaKp8gc9WbJy5+JzcLRo0ljpkNkej6WNFYkyC
         5GwQ==
X-Forwarded-Encrypted: i=1; AKwUvBz0VSNBMbDtdR/ASOtBZyxexUksVZLFr85GJsT7NoPeRbutYRzZJQ/nFnhs9ZaqMjYX8/X9v/rSIm2Eg9CDHak=@vger.kernel.org
X-Gm-Message-State: AFq9FYKPOi075Y19tKF18rz5oCyz/jqvTVbqSh6+npuDaSrz9UhxssMb
	4w8UnSuYDlgvBiZsksMIxzYuTx/vQBkrYmvFDFAfRCWBZb8D/PBHWsU0QASBB30IwvZRB4iezlo
	pBy1YV0KF7xzL+KfIp6oQ39O/N0nPosf3SW2pOr9uXVYuPXSr/fyfhzrDDeFvqgj4oLCvKcs=
X-Gm-Gg: AYBFou0dnaTbCuCASlzFSy6bK7De2dfc4BqAuiVnxhVMfUxigFdv85we96ufuvMYITv
	GpAxPcHo1o0rPmcMk9ftEUa+W1iGzTSO6hc4LGSfS+upglX+JJgeWRiXT+5yhciAiqO5JUIKp5t
	RSdI885TdWp+gW7fX4vEIcyEYgaEj4p6jcow+2myLX3fRF6A179LsYFfd3L0leLQ2LlSWYRXuNe
	b+W/+kNWCpkG2xUKDIeSgD9HsqjKB5U3VZeXEh+GifOAA0khLy9m50MtRtQK0hy8163jl9fSQYB
	bDDFQZ0ZzHRgq10T/qpqH4dBcNB3exuvN1CPRLHw7S3afpO3+WHsZxlX9o+T9gf5FxSwEqeK45S
	JIwBSfYRWoPSirc8rokkmEaNdbL3WnA==
X-Received: by 2002:a05:7300:ea8e:b0:35c:8abb:b4ae with SMTP id 5a478bee46e88-361a1f505eamr9695499eec.25.1792390676714;
        Sun, 18 Oct 2026 23:17:56 -0700 (PDT)
X-Received: by 2002:a05:7300:ea8e:b0:35c:8abb:b4ae with SMTP id 5a478bee46e88-361a1f505eamr9695458eec.25.1792390676169;
        Sun, 18 Oct 2026 23:17:56 -0700 (PDT)
Received: from [10.218.31.125] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3607ee0cc23sm34095658eec.2.2026.10.18.23.17.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Oct 2026 23:17:55 -0700 (PDT)
Message-ID: <fca1f5e8-2b11-4912-98b0-42ea2e9a3d1b@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 11:47:50 +0530
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] tpm: Introduce Qualcomm TPM driver
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
References: <20261015-tpm_qcom_driver-v3-0-247c8e50250e@qti.qualcomm.com>
 <20261015-tpm_qcom_driver-v3-2-247c8e50250e@qti.qualcomm.com>
 <atKpjLYdUuugwAUQ@kernel.org>
Content-Language: en-US
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
In-Reply-To: <atKpjLYdUuugwAUQ@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAyNCBTYWx0ZWRfX8u1KiyB0LkF9
 m6MFBlNZ0Xq6hBkFoHOxb6Hvfr+y84ajr/uPn+ctmOf9BBhSRjjlLNVhmzWzhIz9cKIUPHY8+t1
 DDv5PaRFviQ0Cc48iGma/596LSAjpFiOGIodHctAdMAa74uGJTqhk3mUjsnMKUdsd0ZuG2C3Bmt
 sk8sUNXsARHr2l0hqLxZgbN4T5lZgLzT9RH6PwMvgX6Us5b5re3TD5rfNCCGWbXdQ3Kft9o0IRm
 axZBzggGfH3n0pmWVC5si2R7bxPpGERvgX83TiM1GQ93S1d95adOzaJoWN1q5N4rRUqAVDTNRry
 tbDAjH9d/bD31L14oGwRZEwYAQcKlXUjqJZa6uaErB2gWYaqJ14SsiBIorvdBynAZeTv5TqWRBj
 90yIv+iuAZG78rOHsud78nOHWEVMJ56ZK2Edjw2BFyrYoYKsLFjHtgpXefbPdaHe3GhF19FHiqH
 3eGK6e7sVfFxad+dADA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAyNCBTYWx0ZWRfX2q2t/U21Xs1Z
 me671/0yBqFktYjNB3OzlT0EviPFLiKcr8eoIfu1HdVfv4yzD5v/7HHgwnLaLq1ZWIH4AfCgYOB
 LyDDrT846BsW5twmOb8bpkkERCMTN14=
X-Proofpoint-GUID: jvzGY1CoihqFaO5VWVEvj--7Wu0nN8yc
X-Authority-Analysis: v=2.4 cv=K/+3jCWI c=1 sm=1 tr=0 ts=6ad5b615 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=Ebq4Ce3iuLL-fAZv0N0A:9 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: jvzGY1CoihqFaO5VWVEvj--7Wu0nN8yc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190024

>> +	err = tpm_chip_register(pvt_data->chip);
>> +	if (err) {
>> +		dev_err(dev, "tpm_chip_register failed with rc=%d\n", err);
>> +		goto out_svc_obj;
>> +	}
>> +
>> +	return 0;
>> +
>> +out_svc_obj:
>> +	tpm_qcom_release_object(pvt_data->ctx, tpm_svc_obj);
> 
> This is very cleanly laid out driver. This goes perhaps unhealthy
> levels of nitpicking but we usually tend to have newline before
> the next label.

No worries!!
I'll add new line before out_ctx and post next version.
Let me check any other goto usage and update that one too.

-- 
Regards
Kuldeep


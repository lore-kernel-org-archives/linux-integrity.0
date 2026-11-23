Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795425505;
	b=M5OQKUm7JpBVijCAp1uiLh1JTzyMhj3pnpzcS18Sg6k04zI/YkHvRloAthZCCZ6aIP72
	 Mkjp4K5W5dDG25jS7NhiJaItvNATgP4UWLBzWX1sB036rNjOEZY2c4mzcFHYrCQ1uTkW3
	 B7jruIdC6yPojQIlhTkkfthHmgkoEOp9JJW5UfGcrL4RA/IxoOUM9P6v3hiyXpT1exDYC
	 VvFalwjHGF1DpcIdxCtHJ3w3T06OBM+D/TpMgUADMSPuby3FU277VFaOPXpnCydpLLTeR
	 rro/vDGWScD3UNEFqhMPGev4svv3AZPHprSnO3juiTG5mbBsv22MtQ/34v0wGEQE5cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795425505;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=mSzMQRsg+yqrEBzUwipXKM/+0J/rVsVGfEXY3Vx7ICc=;
	b=yAChDKmbB8thbD9WAJ9TkC1egmlmhcbXPzd/G/JUeqNV0fYACuxjbf0hdfg+h2/zzdMr
	 MpYNndm5IBa9J4ysI6KxWJpfy4yhxOl3K2gvfdrIhawQfu0RZXTYe91Cqfls2IvQr913u
	 5fZUXns0nD6wEn1QrNQiHWws9KOjEvQ2XqeS6EFxMoPOqhrsHk4k5za+twQR3n7pvv7b0
	 2DoAH6Te0CQwsdUadrgbm5AycbuEC3/UG5c6jbZu4Bt7pYUGc8SHAExr7YDaoLhUQNFjf
	 PCHT4OZDluVCZGE62iW6PF/pbGQfKy7IswnfN1yviuVlh4bjWUTLDlXKA8hdwRtGFjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Xg1unES9;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SXSmv38J;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E10606A31E
	for <linux-integrity@vger.kernel.org>; Mon, 23 Nov 2026 09:18:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55E10606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Xg1unES9;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SXSmv38J
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN9G9lT1397077
	for <linux-integrity@vger.kernel.org>; Mon, 23 Nov 2026 09:18:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mSzMQRsg+yqrEBzUwipXKM/+0J/rVsVGfEXY3Vx7ICc=; b=Xg1unES9jsmRSZyK
	HTGRTKLWVi8KzqJYZAb0udLqpQqOHo101z4Zb/hMrylrs4gj1UJyLPqVKcJZW2L5
	VHmFZvw0g9iEJRrddx4zxpqE0xU0BFzwHj5ic48N09PqyT9UNfGFJy4lkA8ni9DR
	mTLW9qgjJr7YoolBgiNEziKbgmS1Nt+5GVHxyxZiiHmBKCmrIIPZWrCn3WFNwSI6
	c3Flfq3SgAaGlMNyXZaCb24wZ69W7Qw1pOEMLRtxLXaZqB6fE1KWciK77m5kcvKX
	KT8KoeYt3QtTGPeykiAMNcoibkzoHlVLFcFWXom+FDmk0BSjfOPnPkTlFjsZWCKr
	9lHkHQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4exx0vgm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Mon, 23 Nov 2026 09:18:23 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3b4b76a2b95so72965a91.1
        for <linux-integrity@vger.kernel.org>; Mon, 23 Nov 2026 01:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795425503; x=1796030303; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mSzMQRsg+yqrEBzUwipXKM/+0J/rVsVGfEXY3Vx7ICc=;
        b=SXSmv38JqmEdnmaKjPzoHspZ4j1KgXye2tSGNsa58Eu03qy09fIlbqg925bJ1QOXfj
         X/WR7dOykR41g8MU3jLgLYVohDzxQOlGXlxiMr0rAGYS2ipKTCUSn8ukd/SrFjjPTF6J
         FZRaxxfTgWNBNFybRCm6Fi3UQ26Py9YK9sbwo82Acmxza5frbjNX47E1U/G6S6HHmWqD
         gJJj87dONd3Y5tdG1UI2jVaFGMj4vrBc0zkotCCgMPUnoT91+moKeH5KXzeuZoRBm53s
         TGMpS/g1/vqlgpkVT83VGG+bakmolZ1gwVhDzhdIAqxZ5Qzojkmmmt770q1dX0xZgRjM
         fFig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795425503; x=1796030303;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mSzMQRsg+yqrEBzUwipXKM/+0J/rVsVGfEXY3Vx7ICc=;
        b=IvVrRIUv7uyZCT3aCXnU49EBxgiysETFWuqonNZSWZXBDFhX+njcEZNrk/GLd3kxQj
         2JZpojqPMpXZ6fo/9nH9rYIy3ny86UOSowAJkTdpaO0ikfEsp3+2Oga53dtN8ZRILRiH
         2Ln9ktp3vb/KPIT1eK7pYwT1v2yu1pJSlk2GNtS9yKyN3wOFmnbuaPds/V0RHnVcKjpw
         mfwREZiImmPz8uFteRQNtbxmgyRVjQ+lxRcuO/YXXJS7dLpfrxllEEPLBwkZaTaYPM00
         mm1QjDJ+4++gMLgQ/o1dLLjELD3Js24/jSq/loDrJ2ONg1smwE9KJwuRe64pMUv/drfI
         13Vg==
X-Forwarded-Encrypted: i=1; AL+hErHMs9n3Vb7sL76ERvcOBem5nZU8ekXWj7n4EdBWfE+h95u5+aHhSh7y2b/UHC13ScYO5nz+8v9zO1NYrYQzQCg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9tL0Ck3Wt4KzbEJohUh1LpONJ2IbNWE55FQKXdZkJCBgDTtNTy
	/edalLK1Fu8hGD/QoJY/OMXcNBEfX6hx93Ft56SQhKafS509QsjIP8Xrxfv6cyXASLHnSpNa8gN
	TMr9PbGNUD7dWEfDAjUwd4pfNs33JK74XN7ziR2w7ir+273jGAaEap1RP2Dw9kKM6ps7PauE=
X-Gm-Gg: AZFdTZdWwU42pDyGlBepPSX36qjY/lBAvMAwAz25nt/hP5soZWVGYo9xEjy4bDQ84ux
	Owg/uFeYdB0W87aBoL4Ag6YeLAGmUo+G5x/S1qlqsOn2xbwOdX9LQAe+LiLtCPDRym0EVyJVJV5
	DzTmPpEV9sddca+FcORRz04PO4VqTa6DxdhOxJRbQWBN+RXufHKzOPVCRLD/mscAqF/zUyxkfye
	5jLFaZ02KuzwWe4e8sCN1UhpsSvD5yqfTAEMsv5FTbGC7WgWRLHYBGX2UHb8CthT1nWOudFGUef
	ba6y94FgD8qJFi+QfDwjkG53dCBy0t/t6WW28qTtFdV2Dalux8h/XKVpvIxPpiSEg8uqDh1EosA
	Jl7DrFyYcI7sjrtpzbEA3uGKpAfiWfRlPEyCqxr1haF6dOODHLnT7uStivKzhNcfEH2+GciRVmA
	qSw7Cf
X-Received: by 2002:a17:90b:2648:b0:3ac:da41:ef7e with SMTP id 98e67ed59e1d1-3b41c95b67fmr9470992a91.52.1795425502993;
        Mon, 23 Nov 2026 01:18:22 -0800 (PST)
X-Received: by 2002:a17:90b:2648:b0:3ac:da41:ef7e with SMTP id 98e67ed59e1d1-3b41c95b67fmr9470981a91.52.1795425502450;
        Mon, 23 Nov 2026 01:18:22 -0800 (PST)
Received: from [10.218.31.125] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad0b2c4sm16839831a91.4.2026.11.23.01.18.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 01:18:22 -0800 (PST)
Message-ID: <8aed0815-685d-41b3-af2e-0055bc6ad920@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 14:48:17 +0530
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
Subject: Re: [PATCH v5 2/3] tpm: Introduce Qualcomm TPM driver
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
References: <20261120-tpm_qcom_driver-v5-0-3d9321ace107@oss.qualcomm.com>
 <20261120-tpm_qcom_driver-v5-2-3d9321ace107@oss.qualcomm.com>
 <awGtGoxtker8a9kG@kernel.org>
Content-Language: en-US
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
In-Reply-To: <awGtGoxtker8a9kG@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=FKKOVOos c=1 sm=1 tr=0 ts=6b0404df cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=V7dZqg2nRoFFyRf2opcA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: yZp6ACT1nk3rgPb8PO5AjrntvM70e9ge
X-Proofpoint-GUID: yZp6ACT1nk3rgPb8PO5AjrntvM70e9ge
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDAzNiBTYWx0ZWRfX0i4D3l8dvKLw
 xFVrTIXZvYuzj6jbgi0Kake4AJWLcqzVAgtJ33MQKiI7R8kvh090CTdlY38ZSXnRuizpJSOt2lJ
 HpcLHxbThSw9YhSik2rSQBl75gWdeoM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDAzNiBTYWx0ZWRfX/rVCBilZInU1
 5JV7GBHBX9dhcPgqP6D+WJhyhQ7RA2Z829Ou/N0R17Jrw80jAwH42Ay3DcXJCJnoiKNVY2/DbK+
 R/McItFfpAoSjvFTiOcpvZljv8o+uqmTJDcMU26L+2WHceAEoWUSjNIG5G6JWy3fAlmVreRX16w
 VMEjg7NsxFv/aEMWSOLabMmLZ+hiv3rSAJD7IGu1NTN8yoRgT3ObXIHd6LWzSONXkQnnQATKMe/
 H4lxduKbUE/9TXScc+DIrjTSmbJ1jBOL8bI450C5R/i/rTCi3dDyaEdr7ZCMSjNAN8ksWU+Xji8
 rrBo2tk+yRFy4mSl18Sodm/sX/BmDSLmUiouIMHL/N0BUXadWcXj33nrGIr385owXWGSk1zUxua
 zDh+G/XMZdbuLwUQjFdRAH3cbRbNOe+LznSLdL2hPuIy2Pv4VTKQLbYgp2vIRosCdNGACNeEwRG
 F2i2lCwT6+fxXG6u++Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_02,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230036

>> +module_tee_client_driver(tpm_qcom_driver);
>> +
>> +MODULE_DESCRIPTION("TPM driver for Qualcomm TPM TA");
>> +MODULE_AUTHOR("Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>");
> 
> MODULE_AUTHOR() field is not that useful and nobody keeps it up to
> date, so you never can rely on it. Not NAK, but just underlining
> how litte it is worth :-)
> 
> Copyright and authorship is anyhow recorded by Git and
> MAINTAINERS document.

Ahh, I noticed couple of other drivers doing it so took it as reference
and adapted here. Seems MAINTAINERS is updated correctly so folks can
rightly reach out to me for any dsicussion/issues later on.

Btw thanks for mentioning. Will keep a note for the next time!!

> 
>> +MODULE_LICENSE("GPL");
>>
>> -- 
>> 2.34.1
> 
> 
>>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Thanks!!

-- 
Regards
Kuldeep


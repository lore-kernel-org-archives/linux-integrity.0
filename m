Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D0D42882B
	for <linux-integrity@vger.kernel.org>; Mon, 21 Sep 2026 08:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789978212; cv=none; b=ZL7jThH6Ps3ucMYQ/hY5HnfWxI1Rfm2m2CbO4i+8/CzXrcQY0Oc1EkCpNIysCmkAr2uLbebjc+46S+mA7/kP8e2HiHCj4we5N5eLfr/WjH/ud86E+B+1aaZb5oAitqKFior7LMDW7R6v+CvO9nNU4/KPKlLnoIUktTOJHEUt8qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789978212; c=relaxed/simple;
	bh=rKlnqLXl8V6UXo3u9TSsBqyAGh4ks3QBlOSYRYGHoJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oa6KdQ0jfF+CPQn7Yqreg6E4IpFJk8h7L9GuOh6h8WHyQ/w4o/sB/rY59s9gWVuaUN1xd8hugtAKG/lWwIwK6vlDiDwmxNLrZwKNcp9+j6mFPkvxiUOJR1w6HjbaUD0zRDiXWwjSK1sSPvLXj5nVhUHW5L/GPeyIdhp96O/vbzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lMrqFDRe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Bg2pKIH4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lMrqFDRe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Bg2pKIH4"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L79p8G3952937
	for <linux-integrity@vger.kernel.org>; Mon, 21 Sep 2026 08:10:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FQXQavybAGc4BtAZ7JoSR+X9Eu5eNUZkOTjr9bp+nWU=; b=lMrqFDReR8779C9D
	AQKv4bvaeZ4mPeMg8aKkm5C31aRWydJhwn8j4C+3oGdFGiLhxEoLIZ+tXqmRPO9e
	eDfIx6jaEt+7vj0fGCamyd2qfTLX8v1XOYDvpomzp5LLpJEdxw/DKi4a70Pn4laI
	dZu/JgalzJ1NqzVnYnImlIaOWX69bt2p/vJbDCZePk7VHgUakFUcNNyWJbMMUhpa
	IngfVMM807+LT1t7mHntTR105mkzcP7ae+uGQEhX8ZiuXKF5OCGB/gWr+Lqo+fcV
	f18dcMTN8K1Kk90U5qaOePRpQS+7hLwh4uZ2t6d9fou1WAUZpGpwDANOGI7ZUtO2
	B+l/FQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gskp9wade-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Mon, 21 Sep 2026 08:10:10 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cec4226c70so34419425ad.1
        for <linux-integrity@vger.kernel.org>; Mon, 21 Sep 2026 01:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789978210; x=1790583010; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FQXQavybAGc4BtAZ7JoSR+X9Eu5eNUZkOTjr9bp+nWU=;
        b=Bg2pKIH4ESzHLS6pu+2BSZo0Cn8Jo4U04kduSPtjrlcvaXWHALehVRgcF1tvifptAp
         WMYSxg+J9Ticy9vzzxumz9/K/bIeQHcntW5PStBcMP/TWrUmQEZs9UKZQWn2IFvH59VZ
         /lR62LvrkQIyTXXyab+6UlC5m2b321Usg28Q3S7/kAZA3cRTYIzzb9zYppMkyPhcG5/3
         TG0h28fMTMUh93KjbnXLEwmOgd+5rF9G57onLS0MA12UIbC3BF5j9t5Wi3Yjbeytovrf
         Z2aEF1wcLfm+W2i0rP3d1VpF6pM1OOqqyWjkU2kd0jukGvPIiwDSO28JhMhCDNzrou9G
         V/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789978210; x=1790583010;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FQXQavybAGc4BtAZ7JoSR+X9Eu5eNUZkOTjr9bp+nWU=;
        b=pX9RFLp10d/3syCDQEcLh/jvPSqv3LuIkd2Ft7n6e2KaqVCbI4K3ixkZoHtM3T9zB5
         4xufUp1gHsf1ttYGdiOI8L3xYFLZ7VbDKH/1inumujgRmhqgLCWJK8KVo17b7YkRIc4U
         tMws7QBvATiEHXkoPJ04vi3Lao+Vs56AGYgNDYounPCDow0TDnunBl8PXtcY0siIK5wu
         q9UEw1+PQTbyap3gFfHspAwfigwdRMz6IAXscy5pkhfdzZcmsRdCcllOJW81qSuP06UX
         HvJa14DBSmz9yLrvL50C2lMiA+viKzG8wWpdzOPGcAO9oEWCj/phzG/Biur7eOnRvI8w
         FHgg==
X-Forwarded-Encrypted: i=1; AKwUvByzKFBFnQvEvSCmQFEgrAInDQzcsNcVJwMwDOwGPIr5FlK0TJszVX4TTLBhx+fGeZts1K/+PhMcb5ku0qqVCYg=@vger.kernel.org
X-Gm-Message-State: AFuF++lD40f/5cQCIHnS/OepHnI6buD6rK2Kd+4kDBfxHytVeUIR5a2y
	ungPOThObWZOCW9nR1hd8kGygUZMsWpQliM8B4Gx3Ggikq7gUlQrgg+sz+ILCJ03jInQ46RlfGg
	1kJUMVBfJ0lYz5UJWAPLUl8SyPeg1oGI5cdGaetzqz6zS1NYf3gn0NvlDR4F3+5ygKja5tuI=
X-Gm-Gg: AYBFou0uJfL51OgMgM7IEzTVCrrRuU5GMZHZ/V9qQJvKhSLeyfGN6v5bAj6eu6ZLyB5
	rtRqjvgk56MLgZeYwcYKceDgQc+/6SzuG3+uEfNXDTPlfl7PBblYHpunQMlPkqIqghhcuoxhCqT
	1vEtwp4xGd23d9bBP7KzVjX+7EAzFAYLgKPZjejOVVAygt/1VTBfm9GG5vLEkQuKGWoe2TALfmI
	7jE9d+TW6nTXooXo6xSX8TXsXOyZuZ2zQ5MHpI+a+IdSQ6166YzUO1I0hjiUXWiVUJi48tBszhA
	eVJ5FXTYwYutnjff6bpMqiRsdl3M4WR3GIujLM6RIwiUxFpVvZTSzTmqqzJmo0SjysppjzzdaWd
	JcyLoYLFCLKR79SiGB92OTeylkGve1w==
X-Received: by 2002:a17:903:26c8:b0:2dd:c0ff:e72e with SMTP id d9443c01a7336-2ddc0ffe9ffmr83871345ad.64.1789978210204;
        Mon, 21 Sep 2026 01:10:10 -0700 (PDT)
X-Received: by 2002:a17:903:26c8:b0:2dd:c0ff:e72e with SMTP id d9443c01a7336-2ddc0ffe9ffmr83871165ad.64.1789978209832;
        Mon, 21 Sep 2026 01:10:09 -0700 (PDT)
Received: from [10.218.31.125] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c3313d96esm17124286eec.12.2026.09.21.01.10.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 01:10:09 -0700 (PDT)
Message-ID: <a8047ec0-742f-47f8-b5bf-cb1b32f06bd9@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 13:40:04 +0530
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] tee: qcomtee: Register qcom.tz.tpm service for
 discovery
To: Jarkko Sakkinen <jarkko@kernel.org>, Jens Wiklander <jenswi@kernel.org>,
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-arm-msm@vger.kernel.org,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org
References: <20260907-tpm_qcom_driver-v2-0-71a6b1752da8@oss.qualcomm.com>
 <20260907-tpm_qcom_driver-v2-1-71a6b1752da8@oss.qualcomm.com>
 <aqyX3lJ1eNBmzbSP@kernel.org>
Content-Language: en-US
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
In-Reply-To: <aqyX3lJ1eNBmzbSP@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: kuZBclh8Sq_x9RTKDNJtJ5721z3qT-HH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDExNiBTYWx0ZWRfX/2CMHoJYKbT/
 YokSJsCiwmTAWN4Y+ZmrhuImfl9xCAjoWlehkAYwJEK1wQj3WWswPAOFVczxOoYyS4SJ5XJCSqY
 mQW7sM7Zs+4McXeQC/4qmCXyPvJ3rA/myYnjXsOR67RoDyPXO2tRDMjcogPfSuOXHnISvwIALvs
 MYHZ6b/Hm1+trznpgjF1ABQ47WnZ1cD0iS4Xava7pxfmI/QBn29Nf004ZqibJCP/ohWaBt93w3z
 H4m9U6QHfgtlkgncJLRifJA/TuvTMtnqtQxh9BdBVq9j/WY6orFNo9qcGvqZT0EvKy/HrH2N5NY
 eO8mAZTxqsIhWj1+YVlijBDyPgWgZA8A1tGCJiVNOh8N3Fb7Dd2z1UBlmcABEwA7xFS1KUCs+xy
 8AglGYHgPNG4SjzWbhPw43HIYJL+9UqdN8URZl3eihf/aO/CV9+MXmYB0KToJ0LsNB0oNC4Zytt
 D0QA7RzYu156FLynFqw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDExNiBTYWx0ZWRfX0/XPSP80JWCX
 fsuafuHrtqx3LWo7YlNbdaCxTvYyk6fKjpHup2HdJ4KImBNpsEAxoUiwVEW8SpLHO1GKq7ANpmp
 Dt1rE/OnhtNzoWAKJ5k+6blZTuU9rvo=
X-Authority-Analysis: v=2.4 cv=BKAmP1QG c=1 sm=1 tr=0 ts=6ab0e662 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=kq3ZzjkpYTjXZhaqunoA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: kuZBclh8Sq_x9RTKDNJtJ5721z3qT-HH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 impostorscore=0 spamscore=0
 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210116

On 18-09-2026 07:16, Jarkko Sakkinen wrote:
> On Mon, Sep 07, 2026 at 02:58:41PM +0530, Kuldeep Singh wrote:
>> Add "qcom.tz.tpm" (QCOMTEE_TPM_UID) to qtee_services[] so the TPM TA
>> is enumerated as a TEE-bus device, allowing a client driver to bind to
>> it via its generated UUID.
>>
>> Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
[...]

> 
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Thanks Jarkko for the review.
Can TEE maintainers(Amirreza/Jens?) also review this change?

-- 
Regards
Kuldeep


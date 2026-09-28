Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD55492E23
	for <linux-integrity@vger.kernel.org>; Mon, 28 Sep 2026 09:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790588091; cv=none; b=A1V+iPkD/ZtHEeemuvh9BjtP1qQPUoyFtFOx0fQbEownu5LrHZUqyZCwtW0gUIEUjWICOemkS/R5ICeSCLSCuEss9MEoPjnyvvNbZ42HCtYrejO8FAoaQ3+jiyR79LQvWl9jRSSISD9Q+UQgV2hdBhuRlI2INqA+/5HC1dP60lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790588091; c=relaxed/simple;
	bh=aut5EtV7EHnIQnhVgpWGAgLGS+IWWJeo0UTmCPk4f+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PZ54MZ1p3Dtc/9mA0BDVNShGzHoroFWOEzBDEXl7jYu3VWSxClE1SCTJ9RpVfRXSBZYMi9Zi3HH8FxYWWTIqGvXdJBkUjtlGR5g8+Tx1T8KXvyzzq7IxvCySIDaHg1d0UmKgcRseImVKdwin/nq5S8+D6/3wbDijeYcV09VZH1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aLkXJMxX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jsE2lCzi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aLkXJMxX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jsE2lCzi"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68S9MJ9U2168269
	for <linux-integrity@vger.kernel.org>; Mon, 28 Sep 2026 09:34:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cslUYpSyi91GFkeEotZ13vFtrVwZDY/B9c/HltZgtHA=; b=aLkXJMxXbzCJ6p6Z
	R1DN0vMl5w3AtEV36Um+luOaXUFYzgfWR2zIKCa3WBtp/4Y/sUhP276G4AgiWvys
	3oJs/O/B/KifdYqa4l/M9QEYeYXCkIQaCBsb1f9xv+0qypcfzGc19gHVjZPGahbN
	4fDfnc6Tt8wFluYbpc488aKZpPtjvajURfCEg+wU0zkkOsVJZuhs+Zq8Hu8HqyXz
	M5wCl15K+5XlP6Zkv0rwloBDRvaP+B/N2lm09lneoGQPx5IeXfi3be6ARv9FLCvo
	etyxotJivn6ZbarEhG4T38eXD/9665rybEHWBs3+qBtVtnHp3n+SFv3C8zfOpPpA
	1BGorQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyj6t0vct-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Mon, 28 Sep 2026 09:34:49 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e8fee6af3so2792937a91.1
        for <linux-integrity@vger.kernel.org>; Mon, 28 Sep 2026 02:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790588088; x=1791192888; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cslUYpSyi91GFkeEotZ13vFtrVwZDY/B9c/HltZgtHA=;
        b=jsE2lCzijKPzwdzujjkkma5+C5GBZ99Jn4g09o62nw9OCLT3pXoe9PmjQbHq81+s0g
         5o1o8XYAp08Pz0rE3NLhFB9m8OReN6GzETizYjWC+Q2JSFXyWDotf1hQtXDIqmjx45No
         eDE1s9Cp3go85RLfaPqED/rAbbokchq5Kzi9zltfwriGzPRazlYAjRAQlPl+KtIXcfuB
         67R8KXvqGipoP72TcbY/TsFLsY1nIan/NGL7W65qqab9+i5U3no87aaWKKBjXhfVDiI6
         /bOa6ku/0i7zVbKR9ZAxkoUqtPX1/PLzFjLLhFc+qpQeLWrsQk5i5cD9I6xTUOx1c08Q
         cR9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790588088; x=1791192888;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cslUYpSyi91GFkeEotZ13vFtrVwZDY/B9c/HltZgtHA=;
        b=yQ5Jr6fJ84HeBY7+1W4zMhc8d2InMOeAo+NSTPv/3II5jzcJiiYlmaZPpH3yDAnkUX
         1IuqFDxzCmf0P0LdINg4Ngbhnn25d3jpJjK75h0XZUXvJqqHvkGruiSQCXsXiueILWE/
         0vjkmbAf8oN29cq0PJsaNm9XCRx+R2XGxpa/ZAJPhSyjUW7Wxjt3zcPXcgcl05Zmbg5M
         EmAiIP8eBrjSPbJDyKhOMavyA6e+r/Vz03amMcn41QdLzS1HVBHUykFRe+Gy6h7JBb8z
         Bivl8Xp38JFQMWrlzemQURk55LxtcB5b3X7BMUiHYWRta3bq3TPrTv4Q5iAg3raDimzJ
         tOQg==
X-Forwarded-Encrypted: i=1; AKwUvBzg0fgi7SwcbBiRzpJfUJi9rO0UvemYMybw4YJdLe/UDusWm2wxb0QJzEEqYHspztNPKV2DFHVJZyaNQaXkCO8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJaADpfLyFfx+o4sXjHAg8yL5+y3/2BCAVmvSFzqgELFuqBYZv7
	1PNdalvj7CY9nXb0rNKH/PNAIZ4f+jvPenSSt5VfE2ZkZtDtABJYJxsYLpHA8DmfTuP71t0NZWo
	H9GreHqKd6OAnuNbgD0HPa7/aslbjTR6UWtEGDsw+Iv3rykz5nhB9VaYw1lEp/+WUytfJdFI=
X-Gm-Gg: AYBFou236PBQ7j5dn2CpG8h71ePBxN2VwUaoXeF31Q7uHrEAG6BVfYsneYR9o2bPWre
	ZiTgvu/5ZHjvwIZ6wbTM8Kj7MeBhhSd8VXYH8C6HNu8p7IOVDxN1420IVjRLW/gSMHeqgCkWW3m
	XbcAyusfGg7xVBSCjbHnmW3Q7tprzfp2B7oxtQnnz3EJGOVDDER7Yn9idYoH9Ga9GEbkRS3XJ4G
	Zmn3OB4m/xECRMJxZfY6nlJ9xOSyFD1E+CrJbCwvwbH/5bBAnRGSx5qzLYLJ5yuUZ9tmV1NNJ5x
	8V8jTc6Rrn8kO/4l5eQmYmWvgHArYnC1N1J4VMrhq4AZfDDDZfSVLUWhzZsBM0tPV14vWD/sAq8
	apOgkjtp7LmQI7/PT3Ekkz328a3ZacQ==
X-Received: by 2002:a17:90b:2649:b0:3a0:b223:683e with SMTP id 98e67ed59e1d1-3a0b2236bfbmr8129130a91.48.1790588088379;
        Mon, 28 Sep 2026 02:34:48 -0700 (PDT)
X-Received: by 2002:a17:90b:2649:b0:3a0:b223:683e with SMTP id 98e67ed59e1d1-3a0b2236bfbmr8129114a91.48.1790588087871;
        Mon, 28 Sep 2026 02:34:47 -0700 (PDT)
Received: from [10.218.31.125] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b9356f48sm19867799a91.6.2026.09.28.02.34.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 02:34:47 -0700 (PDT)
Message-ID: <bb9b3980-141e-4ad7-ac18-6ea7b9002dfa@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 15:04:42 +0530
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
 <d555ee76-3999-4ed0-be6a-ca07354af6d4@oss.qualcomm.com>
 <araJKqHdeXstD7nR@kernel.org>
Content-Language: en-US
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
In-Reply-To: <araJKqHdeXstD7nR@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAzOCBTYWx0ZWRfX/8cOA7ohKlt6
 dbSr0kCfhuYe5Z/RHmR2DD/ayNXZ8UNWCGWXLTEf7QWB+8YFPC18KmYBHvfW8YSk95wvnCZ7feV
 HC5rIX46qAYUbNMHhuBzLIx9e7E2oIcLeWMC9JdXk1ZcZVO/8pejTm6lABhxDQlVtkdmy62xNS3
 AN79KklY6iCaFcoTixSUbbuZC5mPCIJYGux0lguUj6gqZEJ5dEzwWzW01XL4mCRYUwU/wU3xZQE
 W1CUor0gkWlvZxaVZ77+5D98mdUCx7M2g0YznNnd8zDTafxLV68NcUIylyTBFJrEHAOVvMOPyvf
 V9z795T9lwStr4pXgGCiFyF4oARi3JmZtflopWsV5T4HwQNC240KCLDtKoFOloN0Euo2EHQICAo
 udsHftB68Cj8a84wLunJxUKcJWQIWuQiTeFKXVNcWtAeP1BOeJTi5z6Py5awFxlkCeNnZ2h6C1Q
 ttGlYIMHn/YZVyufNeA==
X-Proofpoint-ORIG-GUID: PImYKpf1u07yqEynN-j9oL5w7tHjhw8z
X-Authority-Analysis: v=2.4 cv=dZkVTnXe c=1 sm=1 tr=0 ts=6aba34b9 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=bi0NzNZZtduFk6DORyMA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: PImYKpf1u07yqEynN-j9oL5w7tHjhw8z
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAzOCBTYWx0ZWRfX3wTghIhqQl6Q
 NqiZOC8ansHjmNP5289uUt1uvzwlkzvXGLA5S5jP9AwLXQxG9avcP1on1ihDheDQc8Ld0kogiKC
 SteZJ+mCThrup68PH7BlGfTAq1agouQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280038

On 25-09-2026 20:16, Jarkko Sakkinen wrote:
> On Mon, Sep 21, 2026 at 02:06:43PM +0530, Kuldeep Singh wrote:
>>> Causes merge conflicts with my tree when applied with git am (actually
>>> b4 shazam).
>>
>> Jarkko, this series was sent based on tag next-20260828 after applying
>> prerequisite series[1]. Some minor Makefile/MAINTAINERS conflict was
>> observed IIRC.
>>
>> Kindly note for merge strategy, prerequisite series[1] will be merged
>> via TEE tree and current series need patch 1-5(not patch6) only as
>> prerequisite.
>>
>> To merge TPM series, it's better to pick from your tree and TEE
>> maintainer can ACK patch 1/2 for seamless integration?
> 
> So I'm just having trouble following so: what is the best option
> for you? What do you want me to do? Which route you prefer?
I took latest linux-next (based on tag next-20260925) and tried b4
shazam and observed minor merge conflict in patch 6/6 of dependent
series[1] in drivers/firmware/qcom/Makefile.
Makefile conflict was easy to do as seems recently qcom-pas framework[2]
merged which updated the Makefile.

Also, I don't think we can merge tpm series once dependent series[1]
patch 1-5 merges. I initiated thread to atleast conclude 1-5 so that tpm
series can be picked completely from your tree.

[1]
https://lore.kernel.org/lkml/20260722-qcom_uefisecapp_migrate_qcomtee-v2-0-b8a8fcbe4211@oss.qualcomm.com/
[2]
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/firmware/qcom/Makefile#n12

-- 
Regards
Kuldeep


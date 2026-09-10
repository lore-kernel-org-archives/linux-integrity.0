Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD523BBFB6
	for <linux-integrity@vger.kernel.org>; Thu, 10 Sep 2026 08:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789029298; cv=none; b=Q8iZa9/rQr2okqdAfkBCK+7pTHx9F0a8Bh3jSnN7scLRlsdy1Br7uKGxFyhgcSmnLCBwYsYHGJbHB7CIvhuL3Exv1POPZOgw95gUGBuu7P6HOuhU7x70rdv9GEtb3rGcpLT/MlzrMNm+S4kobekIHDo2+SXVtKEar1Lx9MgNpVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789029298; c=relaxed/simple;
	bh=1VG49kK4fNZl7JgRGZ2R0lXCv5A3AAINFdkFYWuVzrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GLnjdEX+xFEv27ZrUV9BdWg+B6K80pqy/v/lhCxGzdxlXl8pJ6PHYv7veQepZL+xbdI+JRrz231p7391jXXz4QuPl08LNHjvThCyvJ7HKs5/JiB5E8epW+iOxUsFiQJqJ87tvSTBXzzDg4EJAFScQa0UuN/KpScnf2aCoF6y8qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j+EgQV9N; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OGrvcbFb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j+EgQV9N";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OGrvcbFb"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68A5GXiD4187798
	for <linux-integrity@vger.kernel.org>; Thu, 10 Sep 2026 08:34:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZDtD7s+88cPFkDJa10PZ92cfoS/KlLMFXDnVCuSEkiw=; b=j+EgQV9Nr/E6JoKp
	V7juIRxiQ/FGbc4XOkpjrhmPem8YQAfkfFj5y08XCxsW82OGEdjLTycIKS59/oL3
	JaYlvBYdgO+IofwTSv8lul5Ii/GkQ2hXP4jYu9le79S5kU8BOE1NZt0p7OgFpPDA
	SxI4bs9F8LrVkAk2Y/t4nOyt3gD5fiLgNohIiiyRRhpD3YD433UURPftyhwcyb30
	EATMWh08rciW8CXfQK5z/9nbltTZMIhVzHX0uO99L2k9Q/AikSJ6D26klrliopXE
	5R9mof55HSj4hXGokrYpPICw8N4g6PkJNIn9fUV/2uM8Fh7XZrKN66N4FEqYoEah
	eZvbhQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkcygtw33-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Thu, 10 Sep 2026 08:34:55 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8663802b58fso3909834b3a.2
        for <linux-integrity@vger.kernel.org>; Thu, 10 Sep 2026 01:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789029295; x=1789634095; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZDtD7s+88cPFkDJa10PZ92cfoS/KlLMFXDnVCuSEkiw=;
        b=OGrvcbFbnYdVdOx82uWgj5DcTcLuONp58GHgIzDuWYAiVUu8pTYWq4LNbWNkgK83OK
         Qd7814deOKVRZfW87nKOfLS6b2pPd0+GzXm31GLW9lZYArW+vGTEbu4M6Bioj5F1zSJL
         dnLS761ACK2QWVGhWbfl31oBoBCB48LRP54IGpqc0JaZdjZpf7ckFAwgb2F0aslBJLk/
         x4wRpMJuQd+KczT0CHPMLVSLeQMe//jsVsjVcSeDMBmKwtTJm2kyRp5wvIpWwvCRE9Yf
         i31ABl7p/iQCQPupM6TSlPw+iGXRwmS8TM602Hdh90ZHCv0cHkbrEZwB3d/gwexJTOJq
         vHHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789029295; x=1789634095;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZDtD7s+88cPFkDJa10PZ92cfoS/KlLMFXDnVCuSEkiw=;
        b=L32g0WhMlb9euc8F6eUnntUZGMPJ8KEjUVoNwF8c2JR8mQcHwxEWbicqECjLHvI6yL
         b76oEPsinn9wKFXCMKPbp7bqK/7TUlIwgBkeQyS2fMn12XxHajASYPfClpcSIsdQFCKg
         XqSfXlyweLqD2MKOm2mPjHCdQZ+RVanOkHUrtKRx2xZWDf6+UO8IwtYApz8kBsL6Jw84
         x4HN0vwS7/VT4zJECo6pyG3sGmhs6WPo/EhXuRhnS/VRxjoeOz61934XzBSlMvV79Z7d
         iXwga5+EbiTv7RAYZmHPfK2WSZ2SptHGkuxHrehQ3+q9G45wNgznAF4lb3D0gOAbEEYR
         kd+g==
X-Forwarded-Encrypted: i=1; AKwUvBwIy7ZlQTaJeI2JJyYvmLBLvASZj9hx7y/B+khi1IwK6ah64w6pDsonkjobVVWz76JsDGsNk6ENNfLng6wBCmg=@vger.kernel.org
X-Gm-Message-State: AFuF++kc/BVO+aaZDpRmPnkiRSGFB+/PxCPcLU1cgy66YuOC+pyrLgs5
	BhKCTj9G8lApi9Z2Kxef60+ofI1qScNp4upIp0wBLw9AW8zzoeo+RClbyw+IG8jt2o0XfLpETeS
	GLfqIJM4/AtxQW+WN9Mmpwb/ws40JEbIuTZ5J70KNQf7XGRkbWAMAz0nJQ6gzjll+TQy+lsY=
X-Gm-Gg: AYBFou0vwtRtscVJ9uI7teWPN0/rVM5WkgaEMBKbQV1FeJFi8aS3TilDnTTKcOxou3/
	j+XenQrUiZmo6i3US/dCCYocp6dfzbKh1l1FmYKeqiDgdVKVx0veFfbdSQ/qx7XP25ddPMZL4zM
	ryRvy4udtPYIkw/ho1xawNOHnasq7XyuZaLz3raH9A8ww5bWgoGkjAJa3Z8uQsSjr/9aAAf9rmd
	U+qREaoK1ysZzRxCZd1V89Yv9+1xrU2kT+p80MBovovKjOrNyCjJbu4XlrXx6uJON8mtyerDj51
	mNl+V+Q0HqD3KC98bBugGyT6baSaf04LkpKs1ErX7oxfhVE5xdz75/AOh+Nnx2oYZqCdUuv2O3s
	gyxMPLK7Z4QaDuROVJpC7dJFNVR/FMmI=
X-Received: by 2002:a05:6a21:6e8d:b0:3d3:af44:ee12 with SMTP id adf61e73a8af0-3dacbf4c52bmr12033304637.27.1789029294865;
        Thu, 10 Sep 2026 01:34:54 -0700 (PDT)
X-Received: by 2002:a05:6a21:6e8d:b0:3d3:af44:ee12 with SMTP id adf61e73a8af0-3dacbf4c52bmr12033198637.27.1789029294111;
        Thu, 10 Sep 2026 01:34:54 -0700 (PDT)
Received: from [10.218.31.125] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-339770f0489sm20481499eec.8.2026.09.10.01.34.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2026 01:34:53 -0700 (PDT)
Message-ID: <f39b118b-b100-4063-bc4c-ded1f9ce0233@oss.qualcomm.com>
Date: Thu, 10 Sep 2026 14:04:48 +0530
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
 <38984608-4b5c-4355-ad85-8c5a1fb78cb2@oss.qualcomm.com>
 <aqGDL2qZ0sZNMG0f@kernel.org>
Content-Language: en-US
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
In-Reply-To: <aqGDL2qZ0sZNMG0f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDA5NSBTYWx0ZWRfX+n8xuIPlxySU
 kwJYziMxvg5GemjxZtv18+TRJ7CbDiHgsv76JEMoFMPv3ulomCHrhYY2mOqZd3IH5C8zg0eK6Fz
 qimt5P7Hmv3SttFTfj9PQLTUUjuNBMTcebO974UL/G3D5W1+zHO1oj+chJSDkPA3gLMyy3DALvl
 w90Ox5uoGxlHRkOeJTTnkQ7J82kFMZNR5Gh6irsd/NajCDQ0SDgoHSiM28mZWR6UcdocbTTML/l
 tqBzoMpAATZww2EAUgAtzXC6JqTDdFs1rprV3b3OVsi9JnpO3iqWCeQWgW4xDEMvzrpmhk13l0R
 E3xhE7jvTohUBn74twXXLk5XKrkv0fNiF33tqiZu4iSDVePDWxBUrUzYaqu/AYuHh9dx0kQSPUg
 JpnYKknOD9GAypT1ZCDkRMLCRjZqDLd/QkNCKRq4i0K3tOE+zdlSRj+X7kIcBVHhY5hP3ssxD60
 TVHyZ31VItE/FZk3uaA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDA5NSBTYWx0ZWRfXzXSFvYSZFC1M
 UObvupMRGl01kA4P+6h5k2kBc5z03PbJXAgaDCRUSp7YKSiVBlwYmtVArYV+NbTVUnz4WsNw+up
 SJnJorzur/LLfbUMAKWvNDXT2q2peWI=
X-Proofpoint-ORIG-GUID: kYOeQIK0MhDDX2jPD-Wy2yE6zyR6RKo6
X-Authority-Analysis: v=2.4 cv=VONIDNPX c=1 sm=1 tr=0 ts=6aa26baf cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pUs6DziAekBCN6WXSR0A:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: kYOeQIK0MhDDX2jPD-Wy2yE6zyR6RKo6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_02,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100095

On 09-09-2026 21:32, Jarkko Sakkinen wrote:
> On Wed, Sep 02, 2026 at 02:52:17PM +0530, Kuldeep Singh wrote:
>> On 01-09-2026 19:16, Jarkko Sakkinen wrote:
>>> Short summary has a different driver name that is implemented i.e.,
>>> it should has "tpm_qcom", not "tpm-qcom".
>>
>> True, let me make more generic like "Introduce Qualcomm TPM driver"
>> instead of having driver filename in commit title for any confusion.
>>
>>>>  MAINTAINERS                 |   7 +
>>>>  drivers/char/tpm/Kconfig    |   9 ++
>>>>  drivers/char/tpm/Makefile   |   1 +
>>>>  drivers/char/tpm/tpm_qcom.c | 371 ++++++++++++++++++++++++++++++++++++++++++++
>>>>  drivers/char/tpm/tpm_qcom.h |  82 ++++++++++
>>>
>>> Rename it as tpm_qcom_tee just to be aligned on how Microsoft's fTPM
>>> driver is named.
>>
>> I'd say firstly microsoft ftpm driver should be renamed.
>> For example, MS ftpm is based on optee(session based context) whereas
>> Qcom tpm driver is based on qcomtee(part of same TEE subsystem but uses
>> completely different mink-ipc based sharing mechanism).
>> So, it's completely different driver compared to MS.
>>
>> My suggestions:
>>  - Rename MS driver i.e tpm_ftpm_tee.c -> tpm_microsoft.c
>>  - Rename Qcom driver i.e tpm_qcom.c -> tpm_qcom.c
> 
> This goes for argument using tpm_qcom.c but we don't rename ko's in
> normal circumstances (unfortunately so).

Sure, we can keep tpm_qcom.c then and don't update tpm_ftpm_tee.c
I hope I understand you correctly.

Kindly check v2 posted after addressing comments for latest.
https://lore.kernel.org/lkml/20260907-tpm_qcom_driver-v2-0-71a6b1752da8@oss.qualcomm.com/

-- 
Regards
Kuldeep


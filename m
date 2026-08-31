Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05B33C1F57
	for <linux-integrity@vger.kernel.org>; Mon, 31 Aug 2026 11:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788175595; cv=none; b=ke7aACmTKeX+JDIRAZdP+bEq7ND+omYpuJlWkJu5NizFYCAWmVi+MX7tql0swHzCaMwgzFCxVr93uc7FJZ9hxJT1jroio7aGjtepQaXQgCGGb6lgg3b11EB3EG4GUMt3rQkqlQnLiBumY4GfomjiA3kvtgU4E50D6J0014awUTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788175595; c=relaxed/simple;
	bh=SZXxCQIYWsUg4ahPxedyt07MQGWzfBccOL+3jDOGBDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZNXLejlJQp1hZtVXyHLMpL0ZNJgZUp/bbSj767WPz4r75DP4bSjzUVdUpL9GSqegQ4Mr4bNf7GABx2qBh3NRDiVzIEEZwu+Vtv0yamLWoGNxL3VJQdcnj4d4dbO1UrbYl8kcgEonOclKfMKAlIbhkVattxLJWRZmnVXeSh4o/nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Bc03u2+N; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SX4tlpZY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Bc03u2+N";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SX4tlpZY"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VBADh34099253
	for <linux-integrity@vger.kernel.org>; Mon, 31 Aug 2026 11:26:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UWuFeN+BQaevlcj0WqFSPunVnUDxXUWFNKXnkxSodb4=; b=Bc03u2+NH7c4uu+s
	J1dZYgqF4br/6toJy6mLik8ITJ4t7A+mRmTgLL0X8kqvehy8o7bkag09Y4R2S9gd
	D3ycLojvfpHaJL6/VEb13SUY1HfG8unNch4qSA5qtfpTR3bGaHA13Im/4zAu6RlL
	Pcp+1AZqm7JebwGGcQmzLoDtcgDhzzrJ8kRDmHKyO5oLdN6TUDWoD1V3yFrmG8iC
	rpc8GdOAzV/2K+S7qUS8WIi6hczqPOuSbzA15q4178q+vcK6IFC/qmXtD0GoYPN1
	Vx+P71Mx2jDUWbx2Kld/LSiL0eRb7jKKepI3wQAXp1YJM6MyxIip5Rlw+LL35BqL
	u4EWhA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd4x091dv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Mon, 31 Aug 2026 11:26:32 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-ca8aee88725so5840767a12.3
        for <linux-integrity@vger.kernel.org>; Mon, 31 Aug 2026 04:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788175592; x=1788780392; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UWuFeN+BQaevlcj0WqFSPunVnUDxXUWFNKXnkxSodb4=;
        b=SX4tlpZYF84vLcnb4D0Su7l3YpvT+L9jDXoPPqAihqGrw1NcAYhlE+ScYpjLBaajbv
         8xUg5uMNDYF/2WeedIHSPnGrGVE8F9875+Pi7QeUsZbuHp6AH4CvNbbf8jfOBLcsxvhh
         7sqIPXg+O0ESt9EapVAirD5Oi2inXH+8Ub/rNDSV0GfHJ4gUA1q4wSIUf5q9pcOKHTBG
         4RUjanjzgZwfPX30F37NmsDTTWVk5jJ8C5iyeUiHgPOkcn0naV90qB3WtNNYp/gIVGVb
         M+N0iHuHtruIGSrG1sQ4MyqI9rAeDDREtQgDAcO1tDDh0kiPEIZ2G+yOqXUpjzcX5uTq
         ja1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788175592; x=1788780392;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UWuFeN+BQaevlcj0WqFSPunVnUDxXUWFNKXnkxSodb4=;
        b=YBgGVSSKFa4ACP7LSpRPYSqXpdfGyWkwqfA8M7qlirqGbV7zLxcmNGYantB35JNWeP
         OFj9AOFoserp7UjSCaj/Pvdl7yvYUpgawul29EQ5IUh7iAJESro3f6P/+i7IaUbtC13p
         ygkjX9cXt9dKs3WWAxX5xwb2bH13AImN5S2Odavb9pcyMpV9Rs+hMbhx5SPH4jzOHpXL
         XgRf9WTxg1HONgclOGovtXwDn5KLdZhnR/99MXel+x5XnAyqJYN22ZNmLT2tUycsUrtf
         TTqyd8NGeTryWne45u4H/+uUk9I0bHYPzwmDv2VZ/3PfMmVqSgs3ftda8deIdZBjTBIS
         3h2w==
X-Forwarded-Encrypted: i=1; AHgh+RpgTmJAK+YFGzmi0ruIlyC9Jt2RJBhbLe4PGrmM+l/PocEB1VzBsx17cDS6vwG3KNv9t7fLagKiiEGPS5QaHaM=@vger.kernel.org
X-Gm-Message-State: AFuF++lD6Kihn1Z+Md+rVuKfI+iiZzS6Szw81LteECtM1Fosw7hC/54d
	bouFuDJkU+8E9XcU7WN8U+OfQZxrBx+CWeu57dlulx2anadoxy6Yr4c691PCadE+jEHW7SfmKfG
	rpMRTJR4qa3Tbvy4byXWttJpZVJD4/5QOrO+Pfr6jPoeU3c3pq/to6XxDhtGwOfHQDr5GIec=
X-Gm-Gg: AR+sD10/e0UCE1J6mZ0uixbq6jiN/HiaNgBEe7UxmR4m7H0vTJ0EN/bpTHkRMF+prBv
	1fwDOqKDn9+IMwxvxm9x0bgjROTJnp68Pr4qEKy5Dn2Cf1VkA7qKa0IFDB3NyRWQaKoWZtOXmCD
	EkeWKxPXPbaY0JQ8z8es0/A5e/yfyb2xWEBYCT/R5IqK3Cfv/1Sc2BM5q9vsaebWJkWfvRGyB+r
	pdJH2qnd2RbPOVYidawjOz0u9q6e3BdoFBaNTv33evJJWb0TUprzQSzDStpuSumEuflVv8nKEfM
	VoD7TBGDzonI4ZW/8PD9MNznzryAxpZSRbCfnMqJDafyu031fDOyHs57AuZGoXxEmRWDcgO6F3R
	CXzE+C1WBBDT2XOO+PGoWLf+JdJ3R6+M=
X-Received: by 2002:a05:6a21:a0a:b0:3d0:abdb:de03 with SMTP id adf61e73a8af0-3d7ad788edbmr439187637.2.1788175592303;
        Mon, 31 Aug 2026 04:26:32 -0700 (PDT)
X-Received: by 2002:a05:6a21:a0a:b0:3d0:abdb:de03 with SMTP id adf61e73a8af0-3d7ad788edbmr439110637.2.1788175591875;
        Mon, 31 Aug 2026 04:26:31 -0700 (PDT)
Received: from [10.92.160.219] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f99585csm28349834eec.21.2026.08.31.04.26.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 04:26:31 -0700 (PDT)
Message-ID: <8a61f8b5-bead-4114-8363-42b469738599@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 16:56:25 +0530
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] firmware: tpm: Introduce tpm-qcom driver
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
References: <20260831-tpm_qcom_driver-v1-0-6f16fa6924fa@oss.qualcomm.com>
 <20260831-tpm_qcom_driver-v1-2-6f16fa6924fa@oss.qualcomm.com>
 <e7f7f0ea-cb63-41f2-93c6-5d47fe4cca3b@oss.qualcomm.com>
Content-Language: en-US
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
In-Reply-To: <e7f7f0ea-cb63-41f2-93c6-5d47fe4cca3b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA5OCBTYWx0ZWRfX7BsmBmlh6YI4
 KudspWYRkT9MEZvxctZslVKqIWwLA0+7hUuur8l4BuNQswZ+IYoI+E4asfecHe6DEZl+kUZD6h5
 HEGusVAOYh4WNEUWIol7sqmnKCytDB0=
X-Proofpoint-ORIG-GUID: W7RMsgjGWHRNKyc0HNBjhL6jcY7Lh15Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA5OCBTYWx0ZWRfX59wvMe3AbQ5e
 UrjMWbUN5ILRqortO00srx5COGNx4FZUsPc8UtXdu62248u5hZHltCTZBjKARJZOjOl5fQbT+r4
 W21Cb3gu4sUX19C+9UwZOLcaoX/Dgj2QH/MeSWfSyAAnTFFmRpLJS3+dU351AZT7tkWpfYdQ+9C
 YofPaSfgYcsz+GI68YZESffmAfVLu8J1iVjqKhIhuQgmsKL9pOKkv2eaYvMUxg6UKF4CIOpCZ+D
 0DuMWeiZwoIxffqMVbCmw49HcwMQhpOFY6FXfcA47n5w/rMBAz8EyZC2/TbLaR6a8prxSzN3jHn
 //qs72Cqmpol7pquYc2MuLa5VGL09w8WCM7HdQCyQ9f+E1CNx56aZBk4GR9uGZl6yKtXULtVKAC
 KaUWh+5u4H35kf9LFJp3WGb+BRXadjKTDxFrNqj8h7be0f0AICgCXFLZqIBUQIK5OEWEiI94hOy
 P3qit7bvYB9n0HWcEmQ==
X-Authority-Analysis: v=2.4 cv=Iqsutr/g c=1 sm=1 tr=0 ts=6a9564e9 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=I8atxffxcjRlebx0Ix8A:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: W7RMsgjGWHRNKyc0HNBjhL6jcY7Lh15Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310098

On 31-08-2026 16:45, Konrad Dybcio wrote:
> On 8/31/26 11:43 AM, Kuldeep Singh wrote:
>> Add a TPM chip driver for platforms where a TPM 2.0 instance is
>> implemented by a Trusted Application (TA) running in Qualcomm's Trusted
>> Execution Environment (QTEE), reachable over the QCOMTEE object-IPC
>> transport.
> 
> [...]
> 
>> +static int tpm_qcom_get_client_env_obj(struct tee_context *ctx,
>> +				       struct tee_param_objref *client_env_obj)
>> +{
>> +	int ret;
>> +	struct tee_ioctl_object_invoke_arg inv_arg;
>> +	struct tee_param param[2];
> 
> nit: Reverse-Christmas-tree would be preferred

Ok.

> 
>> +
>> +	memset(&inv_arg, 0, sizeof(inv_arg));
>> +	memset(&param, 0, sizeof(param));
> 
> You can zero-initialize local struct variables like this:
> 
> struct foo bar = { };
> 
> [...]
> 
>> +static int tpm_qcom_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
>> +			 size_t cmd_len)
>> +{
>> +	struct tpm_qcom_private *pvt_data = dev_get_drvdata(chip->dev.parent);
>> +	size_t rsp_len = PAGE_ALIGN(MAX_RESPONSE_SIZE);
>> +	size_t copy_len;
>> +	int ret;
>> +
>> +	if (cmd_len > MAX_COMMAND_SIZE) {
>> +		dev_err(&chip->dev,
>> +			"%s: len=%zd exceeds MAX_COMMAND_SIZE\n",
>> +			__func__, cmd_len);
> 
> The name of the function isn't helpful here, this is the only time this
> message appears, so it's easy to grep

Sure.

> 
> [...]
> 
> 
>> +	err = tpm_chip_register(pvt_data->chip);
>> +	if (err) {
>> +		dev_err(dev, "%s: tpm_chip_register failed with rc=%d\n",
>> +			__func__, err);
> 
> Likewise

Since it's dev_err so dev name should be sufficient i think.
Let me drop function naming from log.

> 
> [...]
> 
>> +#define QCOMTEE_TPM_GET_TA_VERSION_ID		0x0001000
>> +#define QCOMTEE_TPM_TA_VERSION_GET_MAJOR(ver)	((u32)(ver) >> 16)
>> +#define QCOMTEE_TPM_TA_VERSION_GET_MINOR(ver)	((u32)(ver) & 0x0000ffffU)
> 
> That's FIELD_GET(mask, x)

Sounds good, Let me use FIELD_GET.

-- 
Regards
Kuldeep


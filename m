Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158BA34CFA7
	for <linux-integrity@vger.kernel.org>; Mon, 31 Aug 2026 11:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788174923; cv=none; b=hjWyYktrWQo0ZPMFRZ/h6CXYB6pwbLuz+Us8Dh6HZr4CMyu0rNSbQFhNmNeJftzXpnauZRq10SZRwRLCE6z8bzJ3UAXqZIp5dRI/jn+a1MvkaZ8ev/T2inXnvJtwRgGzoMLpDaJxFdT7kkGj4C05sKr2IUcYzEXt6rTfBqi72uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788174923; c=relaxed/simple;
	bh=8ULGEUNNJjvyNdM22e7Tq+wJQwAaiE78urMxW652MuQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yb5yPgAAHS07NY2G04mNI4fjY+lsNF+QWo6tvXB/3T4ZGeQSwo6lBhT+x54mYu17yJRsprTr5MfDIy9jfiNVGPgRLhGC04fWIhez3LiemH8Pc9aTKNNFJ4s4b/iTS2jwj8pYXFTbw9wsPyW/1BzHS8USGOYXSz9hwVYcIF4OGuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i/ixE2zj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QKfTz2aa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i/ixE2zj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QKfTz2aa"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VBA05m320544
	for <linux-integrity@vger.kernel.org>; Mon, 31 Aug 2026 11:15:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YunmAvG2pE66QhekMLMzUPWMf7nH38ggy6Vr0EmXp94=; b=i/ixE2zjgLMAs+zL
	bcCx3btOx/4Ux2/TNwtwOUaRperJRA9AxSnZPvAg0e1ds4JtnacejfPRsY1lCtW7
	R7xYUn+vxZZq2b4iYWTTO2DiNkCeKFcv0dQR75texHXYCRWilBbZmbBlfYWJEckX
	Q9qM95p10/VnqFlw11AsZeTLExTapTqNriqqJu+bmwOxZ0FEULlOIHRSHMq1JLKb
	7k6qiB4ylYmtzpj5/hNOTj4LxEk6r7bVksPrwg7qHlXruSDoJ9zwH3s/vUEzw6NE
	SZwb8dsQDo83WU/olEoagz8EUeafeYTK3tBj7dX3yBWRNFdj4WvOqniFs75AsmHC
	TBCcOw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd8cvr1fb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Mon, 31 Aug 2026 11:15:21 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-52fa40fed05so6711481cf.2
        for <linux-integrity@vger.kernel.org>; Mon, 31 Aug 2026 04:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788174920; x=1788779720; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YunmAvG2pE66QhekMLMzUPWMf7nH38ggy6Vr0EmXp94=;
        b=QKfTz2aajZXA5SGsVNUxa4XbqgBoOhXLms2XU40ZMIr3Jf4xhQ8DsHGaDYmsAZAPkn
         GtZrIHBIMSlTt5/mXCwsWprVijeruRv35jVxYJ+3GurLGv/nmF5XG7R1KYCszdarXUoO
         QwUVoJmLvn1lno53mq71f3n0hhY8P058UJXaoDGIqDqpLXuwHSFLaaYYCc3YXDyhcDyF
         9dsX8I6VEJuLzrnSRrAoqgjelrivvszebYqxxEzbuqRUz32w0b8YWPvG5EFFrNIQkH29
         ngR260eMwMs47h8X0JpXGE3toCSUa+UppWzZqzLmfKMqQDdaMG8+azeIV1aSZ/VoTPdD
         QCiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788174920; x=1788779720;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YunmAvG2pE66QhekMLMzUPWMf7nH38ggy6Vr0EmXp94=;
        b=syrbuAcbDlqI2IrzQrrgverrVO782Rl9nzDXSnnsrzdm9lIlKwTMw1GUrk7U0wGZx1
         KCUhxudSm+qDhOqgLXs5PpuEJlFomzfbGq45rFPdsbsJljRww1sXwGjG2DS9lrj02D+j
         bQwavs+7DIWsvNBOR0T32LvIDIEOJx6Q6Ch4fj8Q04kbjzCyvNzPUbP7rs0o/ACUCdYs
         ZyyKvrgOwMhcpuxtYUW03LhhkZxdF3YB44uN+oIPJXL8Rux20kQf7P46PjEKiSS86ZYi
         2wuCMHbxXWzX5ZdxbFabwjaP+W+yKSV6pClRK1InRqCJLpTP46GlUVIvRh7agN9fc74A
         ZMaQ==
X-Forwarded-Encrypted: i=1; AHgh+RoBfG2u36uMrC5R/dVmtf43amUnjiWjBD3VyfOKG/3C8/VRK0pzVTFGEaZq9dH/v0yGDZG3BCnCsOiyjgcNSn4=@vger.kernel.org
X-Gm-Message-State: AFuF++mdDEzOutsevTlO+BAg1ilNLZSp34H0dz74CVC76O0kLXtIb0cK
	7wMm1AwmmQyE7mudAZcY7f1kNiscdMfT3u09iLlWXHJcfSEd+O3V7ycHv+hl/e/ABYY9yuKyvAr
	pZuImu0btPXt7kiKGVetjyBXkfqyrCuTQrp1BAQvqn4UJp+xoFxIZwCoIFxQ+QvVlR88pUFQ=
X-Gm-Gg: AR+sD13CPoOTJ0Yk6VXgv1gdJAMSz771cZ0MlpQ+FuIt9HkAdWzurBFFAhS+bcWF+Tt
	1BiqymFpSLP510Xitb7o/e4vMq/Cf9gKZWbKZMeVxf5ugEBWN9HYP0OyxWOsC2ATzNcPtsy4NJp
	o0Qmvx4hk7+Ey7W7nn/4HIrr7hFf8UjbRvCFAybZSJsyqzESHg5HQi3FHdGaPpTxyHG0EDlLmsH
	HBMGeEeuHFSNpbiYfxqIjPGAm/xog573WJPyW41wt9lxeMK6WUTR5te0AVHEt/gNDwGbgpCjUm1
	1uALe7uxBRSMgoSzLcCb06KAfXIoLSugJmNqPKg9XWoQlexjr5F8Jcq7nmiG/6DMzyYnyBAK4I2
	Vvc+NEyrbBN8bJwc9k19z5w==
X-Received: by 2002:a05:620a:45ab:b0:939:74c:f122 with SMTP id af79cd13be357-939286884f8mr854290785a.1.1788174919572;
        Mon, 31 Aug 2026 04:15:19 -0700 (PDT)
X-Received: by 2002:a05:620a:45ab:b0:939:74c:f122 with SMTP id af79cd13be357-939286884f8mr854275885a.1.1788174918130;
        Mon, 31 Aug 2026 04:15:18 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25895beeb8sm212026866b.31.2026.08.31.04.15.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 04:15:17 -0700 (PDT)
Message-ID: <e7f7f0ea-cb63-41f2-93c6-5d47fe4cca3b@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 13:15:14 +0200
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] firmware: tpm: Introduce tpm-qcom driver
To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
References: <20260831-tpm_qcom_driver-v1-0-6f16fa6924fa@oss.qualcomm.com>
 <20260831-tpm_qcom_driver-v1-2-6f16fa6924fa@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260831-tpm_qcom_driver-v1-2-6f16fa6924fa@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA5NiBTYWx0ZWRfX6q2lIVG0CxZG
 Yk+5Gcy0Rma7eSDO2wuWsakbGIySuHO4642ZSO4tVJwOmJ6mQSLk4xiQmceaHpAsmvvSn+uq3gl
 IcByqoSNDINYoMS4yfkXssPYkZGWBCc=
X-Authority-Analysis: v=2.4 cv=JtnBas4C c=1 sm=1 tr=0 ts=6a956249 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=1TzI99NNmMpykW__4ucA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA5NiBTYWx0ZWRfX7bZP/aMsCoKR
 QAyCQ2+aLir8gQ45I6lEjA9GkEXbIIbiD+CL3MjS2lsEkNu0IjUIbU9pSUQIFiiXCdIzfSnV0G5
 He7vK0w0BrP1xyZrP/mi1j+vETFldBo5qyvPt5G8nEeNd2//o8OTrgpAR31a7V1ZgPNy0uFM9Ca
 T+2VUu6XwczI1/a3VmpCu3TXNWU8+RWI7ArIl7BISCkHBTp6NASVN/B98HP4hPyVEWHuYoCQGxK
 tyI6I6ukpgBkjtW+xe+T7dS+gChjqxsSPaezin1DSaERlcN9O9eTVSCBN7n5uXAfPZj4QmolLQh
 a7XImcqNVHqPKXCZgh6ydbiVeEUFe2uYl4NFYeNl+NDqz4KrV6RO4MQ60f3b9OCMFiIc7MnlvBR
 7U161HMTP+0w6DAvDmtKT3vxqel/M5pomSMz+QcpcScCku6NAIEde8gGIDCDYtskqgu3ZxoxyLU
 HDiNsCm1QAGi/xysFJw==
X-Proofpoint-GUID: z7AgXEYvT0aVIPtvkz0fJEBfmiwkW-rw
X-Proofpoint-ORIG-GUID: z7AgXEYvT0aVIPtvkz0fJEBfmiwkW-rw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 bulkscore=0 phishscore=0 priorityscore=1501
 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310096

On 8/31/26 11:43 AM, Kuldeep Singh wrote:
> Add a TPM chip driver for platforms where a TPM 2.0 instance is
> implemented by a Trusted Application (TA) running in Qualcomm's Trusted
> Execution Environment (QTEE), reachable over the QCOMTEE object-IPC
> transport.

[...]

> +static int tpm_qcom_get_client_env_obj(struct tee_context *ctx,
> +				       struct tee_param_objref *client_env_obj)
> +{
> +	int ret;
> +	struct tee_ioctl_object_invoke_arg inv_arg;
> +	struct tee_param param[2];

nit: Reverse-Christmas-tree would be preferred

> +
> +	memset(&inv_arg, 0, sizeof(inv_arg));
> +	memset(&param, 0, sizeof(param));

You can zero-initialize local struct variables like this:

struct foo bar = { };

[...]

> +static int tpm_qcom_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
> +			 size_t cmd_len)
> +{
> +	struct tpm_qcom_private *pvt_data = dev_get_drvdata(chip->dev.parent);
> +	size_t rsp_len = PAGE_ALIGN(MAX_RESPONSE_SIZE);
> +	size_t copy_len;
> +	int ret;
> +
> +	if (cmd_len > MAX_COMMAND_SIZE) {
> +		dev_err(&chip->dev,
> +			"%s: len=%zd exceeds MAX_COMMAND_SIZE\n",
> +			__func__, cmd_len);

The name of the function isn't helpful here, this is the only time this
message appears, so it's easy to grep

[...]


> +	err = tpm_chip_register(pvt_data->chip);
> +	if (err) {
> +		dev_err(dev, "%s: tpm_chip_register failed with rc=%d\n",
> +			__func__, err);

Likewise

[...]

> +#define QCOMTEE_TPM_GET_TA_VERSION_ID		0x0001000
> +#define QCOMTEE_TPM_TA_VERSION_GET_MAJOR(ver)	((u32)(ver) >> 16)
> +#define QCOMTEE_TPM_TA_VERSION_GET_MINOR(ver)	((u32)(ver) & 0x0000ffffU)

That's FIELD_GET(mask, x)

Konrad

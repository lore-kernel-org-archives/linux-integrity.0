Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792617375;
	b=y5Q1MgF5ck2+aH/B8cM1312IhFq9PtrqtYTpq4DVxhJG6jgltfUII+W3I8a7P7RaeHSn
	 v0XnshBmmBJntyKu2WB4WkmmJy0tMO/120nUnyVtyJju7U3zjOO7RYmMFMEYhN+WF/J28
	 9u39vi69jzr6UOYXuTvHkJGL8ZC8uyER55tamSprt7e6ytST938KET5H6zZaTWq5KGLjN
	 IvYq4vQ/QFyE+xW+ZNyMj57b+tcvQ3JohSmz0TtJAfG7G2CHjl5j1/tTZixSNbhLPMJcd
	 Oj9DFE24jzJ8g5DH4ZCZ/H2PcMKNMTamiSODe2Rvs2mdQClA5bxicuZuOgSq5uzoMtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792617375;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=In7UWKZFYC3zSnJsQr1KWQoGjjGRCbWkVCXiuO48ynQ=;
	b=P9AEE0zFSp/BReWwJPnI06yKmfWNEOi9NA/SyyidqIUjPTzR9ibaHcIGLM2bVIRht75B
	 Oajf90+EaBTikXKLqdyLUCWjKfunGPRbjZnMGcz/zvZluO4hd39KpUdmtt9Inbb6XssS9
	 BD/imIDk4j1Xx0Ix3oPOJpxSFHmQhc9IwULh/pBkx5AWkhcpxcM/yfZ86sHTWHujTWi1D
	 GilD+tzS1+D+Edp8yYVxF72X6Qu6yKXw9gu/f371X7ZQ7Cn+Fi3920rryzaKaECj0DcXr
	 wHVe1mCU+Iya8dFHuKnCqkZsJATqps7/DULIioLRhGqej2d0BqVIQJm4CDjEiRkrfnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=e8p3urDB;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ii5dHDNF;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16CA606A31B
	for <linux-integrity@vger.kernel.org>; Wed, 21 Oct 2026 21:16:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B16CA606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=e8p3urDB;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ii5dHDNF
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69LL3g3v2288308
	for <linux-integrity@vger.kernel.org>; Wed, 21 Oct 2026 21:16:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	In7UWKZFYC3zSnJsQr1KWQoGjjGRCbWkVCXiuO48ynQ=; b=e8p3urDBkNn0Qwxu
	QgKsj7vg5qiGp0woOOXU26cWe3QNGql/aNqfrqHIOYv4AoFUS2cFMeU6a6PxqbsU
	eEfhqd47h2mv+C+1zrsxOhkeL+FpAfEJBJPTPoq3XAuIul13mp2JlR2EkrAZvxyq
	jsz2l4Cxav82YO1G3bRILzFlGijsWe66daleEr3yPviFTOGTGkOrmXao03HfbwAD
	pmS3YQeGcytTBSAWfO1PIT1w6PQadUVV71mmZT9yel9zEqNgTxU1z0UHnrS1TnHB
	Z1/1Or3rwbCKS/dyP2ljOhY1i+FBPnaazXxlGkGubngc8LKr0QKtBYZYSjDAeDqs
	QvJdRg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf0v892ht-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Wed, 21 Oct 2026 21:16:13 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-341eff9e381so2937799eec.1
        for <linux-integrity@vger.kernel.org>; Wed, 21 Oct 2026 14:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792617373; x=1793222173; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=In7UWKZFYC3zSnJsQr1KWQoGjjGRCbWkVCXiuO48ynQ=;
        b=ii5dHDNFCcx6wDZI3O8lD0I3rJEIBZ7bjDN9BhEAzRYmfBesqxGzObeBeEIMCiAD4J
         HC7aE9fgtIvDs8RahcHAnFg4Z4/XylMYbTa91Lz3PsyJXBshxARKQeQMQLsed0lg29Hy
         tTc3AJghQDk9yLWqE3lcRdRau3x8LlqgxdgKAW1jiEzvEcDxOh2tswDX6mBuU2wAIgze
         5YFnQCKnWhxqfJpQg2B29YKEPAGE08Bxb1CXzouFlRZgNsomzSXrNjc+o4a2+AxrbKiw
         Y335+I1d6PGfKyQfNvyhqB+sTdtiRtA2Z/WoArqjZrxMlTy/KxoIdh2YvY27CvDwiqcU
         Cc0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792617373; x=1793222173;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=In7UWKZFYC3zSnJsQr1KWQoGjjGRCbWkVCXiuO48ynQ=;
        b=LN3SKvx6fmn0nvDrr+yR23g1OqJ/VJ8vflsRZL8k+YCzi/vhsI86wwEyO0obXZmisG
         pJsjnlDSdH2QktfSWx1k/Vlng3Rz7a5+nxyoB24NzYlbMfO0/qLSbKeQuBWdkbz4H6CP
         +osNWPHTVtVckfq6sFWLDXy6hY+AyL3tIhBbepzA3Xddss7r6Z2F+g55aTpMRRW2rZuR
         8968dHuIik2PCKOepUMP+5LKaDPptE15n1N7S+joBKiZRzddD7Uf/OuwZaqr80RtSk06
         cMSwQOoTAiMB8rp7K4IEIXX7hPGo+cB/A4Q7fzJ4SsEirQbHknXDb66QUVCoDAkhdH7j
         YZEw==
X-Forwarded-Encrypted: i=1; AKwUvBxEs6lBPbAB+bIjti87VLcBHipuziMy0/48xCNno+AMH0545gRTw9R9wCSUILYIm48j2jH8GXBZX4j54aXk6Ec=@vger.kernel.org
X-Gm-Message-State: AFq9FYIxvSt8RAKH6qh51qnRObGr5m7tYMNEjNI9Oktqq/p2uERDhqtl
	mnbbA9saFpmjOdCa+Q4N26lzoYY+/AeDyfQ4FaFmUCyeRMrD90XWLRo35ca4u6v4abS7PLtgOzZ
	Na/KoCZM+Bb4Oh0SeMBziEoxqtwqnRVWjYfrXMhmqxXUmNsJEPMwEyrZNxlpHp0CJ8z3ZQg==
X-Gm-Gg: AYBFou1p4CNCCCFuy71QDPg/ldfnMbMJeywzhM5zG8ZC/PK4ftiEz6ulxTDegzePB9X
	yS+jHydfCw6hrSnh+vGJUaBZby7CAPBSePkaXYwJtAPwpSDJ+ASWa8wTE6LyF0+M4NPt9/TQfy5
	dQk4iJhwld0RHB/6yy7q4hyb7ELEjZNcIo95YhaWjuKCO4g664YyUNTyEYezVw9X0hQtLbwu0YG
	CpNGSc1jUrLpv4Wl4aPboWwj58zaN0Khnh0OniBLxA5d2BA2+vb/ZiOl5kVBOujnBKqJwpJJIGc
	aGol/nJqyaEryUCl+s+S++mQ2Vwy/XPZF2hTkhAdbOOCIx5zIibR6Cf+korGJJbc5SRtrxVyHDW
	F4NmEx5Ps+gnqV0TbKDoUqKPAhoVQ5jM=
X-Received: by 2002:a05:7300:828a:b0:367:185e:867a with SMTP id 5a478bee46e88-3674f21c1f2mr4409487eec.38.1792617372504;
        Wed, 21 Oct 2026 14:16:12 -0700 (PDT)
X-Received: by 2002:a05:7300:828a:b0:367:185e:867a with SMTP id 5a478bee46e88-3674f21c1f2mr4409446eec.38.1792617371755;
        Wed, 21 Oct 2026 14:16:11 -0700 (PDT)
Received: from [192.168.1.86] ([65.181.13.88])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36741f753f7sm9947297eec.27.2026.10.21.14.16.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 14:16:11 -0700 (PDT)
Message-ID: <ef93b833-68d0-46e1-a777-d7451e50da4c@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 08:16:05 +1100
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
Subject: Re: [PATCH v4 1/3] tee: qcomtee: Register qcom.tz.tpm service for
 discovery
To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
References: <20261019-tpm_qcom_driver-v4-0-6889b9804ba7@oss.qualcomm.com>
 <20261019-tpm_qcom_driver-v4-1-6889b9804ba7@oss.qualcomm.com>
Content-Language: en-US
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
In-Reply-To: <20261019-tpm_qcom_driver-v4-1-6889b9804ba7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=C9Z8WgP+ c=1 sm=1 tr=0 ts=6ad92b9d cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=DFNpOA17G2bluAzxCnbuxw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=TZTEVhZfE5fPnIgvEYgA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA4NCBTYWx0ZWRfX+TyGnxDidxnh
 ojAe8TUgt+b1U0icq2VJH7Ykc8CHkGBnVnJbom3EkzORqEjxh4P42VJWjrsAmEvOeol9cKJOrOm
 ji8gYKtQ4BZ3KQLYIxxHJubHqD3YXAM=
X-Proofpoint-GUID: 8AkwGNKKqmMDvuZp-t4xUs-FQ9JrcwON
X-Proofpoint-ORIG-GUID: 8AkwGNKKqmMDvuZp-t4xUs-FQ9JrcwON
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA4NCBTYWx0ZWRfX6F1iS7jjd2gh
 yWx84mRYEQOD0j7Pqbty3qwd2EslHtLFB+akZQKZncWRUBazWUn9JSJ66f5jOrhnbS9KCfsGC25
 h1TXKBCKwt5s6hf6F9aGT99XaxOFvFji3usK651VBWMEnbGsTLRWZuHzWLO9Gp/dxmkU4kBdEqX
 DQCfrHVCbyYsdwDYL8NI1yyblZJNfATt9EZzkBhYY9fp6MmfVb+vFykK1crUA5xTc65lQEcJfbD
 XurvHZeWzkMs94xt5WNulozuqxBdq4jts7LlbZTHbFlLVUgq9IT7a2msXnrVsW4cENcJJMv0zde
 S+0AiJjc15lxymqjKBEbtJ8cykz2vG/9t4Y31fnQchLTGMVG5zME9z7aJtkknUW6JyEjGNib1ua
 YzjBE5nTDVRM9u3H5LTlFBE3hN56UDwX3X8k8wWehLVG3cbgVd0B9KY+gM6KFTlhu00CcIo8Kqi
 QGEXpHzX2TAW81qK2Yw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 suspectscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210084



On 10/19/2026 8:21 PM, Kuldeep Singh wrote:
> Add "qcom.tz.tpm" (QCOMTEE_TPM_UID) to qtee_services[] so the TPM TA
> is enumerated as a TEE-bus device, allowing a client driver to bind to
> it via its generated UUID.
> 
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
> ---

Looks fine to me.

Reviewed-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

- Amir

>  drivers/tee/qcomtee/call.c        | 4 +++-
>  drivers/tee/qcomtee/qcomtee_msg.h | 2 ++
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
> index 47d8a4f9a159..1b887da83341 100644
> --- a/drivers/tee/qcomtee/call.c
> +++ b/drivers/tee/qcomtee/call.c
> @@ -747,7 +747,9 @@ static const uuid_t qtee_service_uuid_ns = UUID_INIT(0xe1b48857, 0x6154, 0x49f9,
>  
>  static const struct qtee_service qtee_services[] = {
>  	{ "qcom.tz.uefisecapp",
> -	   QCOMTEE_UEFI_SEC_UID }
> +	   QCOMTEE_UEFI_SEC_UID },
> +	{ "qcom.tz.tpm",
> +	   QCOMTEE_TPM_UID }
>  };
>  
>  static void qtee_release_service(struct device *dev)
> diff --git a/drivers/tee/qcomtee/qcomtee_msg.h b/drivers/tee/qcomtee/qcomtee_msg.h
> index 9278a361dc70..9fff9dc5fffb 100644
> --- a/drivers/tee/qcomtee/qcomtee_msg.h
> +++ b/drivers/tee/qcomtee/qcomtee_msg.h
> @@ -106,6 +106,8 @@ union qcomtee_msg_arg {
>  #define QTEE_VERSION_GET_PATCH(x) ((x) >> 0 & 0xfffU)
>  
>  #define QCOMTEE_UEFI_SEC_UID            413
> +#define QCOMTEE_TPM_UID			81
> +
>  /* Response types as returned from qcomtee_object_invoke_ctx_invoke(). */
>  
>  /* The message contains a callback request. */
> 


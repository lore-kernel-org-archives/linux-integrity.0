Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792604624;
	b=bh8MyuH8P5rC/FWI4QqJzlfoYtnHRkphMRbFARIxaAHsvDFVYloofVXVCynfpTvSRTL9
	 VxVCAjPjEkOrEtPaEmAo82deiucU7RCZbLM2+DC6OVjbvGNr/v6j2bcBvsf6Dp3D/QgIn
	 3nnYhPbbAHfZs4N9KQvegiBPhkQ1h00JQJaYLGaWoDjnjib+fQLCHhjekj7mgbuCyu7nl
	 NActkQxSh1bdifBPkKSKe3ay/DadDDZ1c7ATFfgrOeIdPBso4lDdv8GGMNE0mr+Hgvwbs
	 9PBX0TIaLSpM/EmIKtxpr8qJjggfxnfs9O8ciMotxzybe5AJm9VFLj2nnVSnMpHMu+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792604624;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=vilmZRHHMNfnexi+YGDujqWXf83C8yeE3BqzopJL6bY=;
	b=z/deG37hUWRnmT9bvfNhdsPMNCuFje4SpFlhFMnPqMqncfM3OE5luUeFsHMvU4mtIFhl
	 e+mxPC1e1hbirksTVpWaxYG+iuwliuFASh4KLNVR91MX5zPDXlqhTxPYohQE85ze0gUpm
	 x5jFscrVJ/0sdhWnd4nuL+3Mqh6KkujfNPdMU3jVEQPsOAFmziKxztHDaucEULfAD3xlL
	 elyyKhOU9byvrDMN+pr5IHuFyNA0WCFl8SAQtULMqRx7MMjLVptDjzXgLYvEsT726QZMT
	 YsRS/wzGZCMKr+5H48w//v7gm3MNTZY3NhnAY44q/zEFqaDTZ3sXKr1lO+UyG8d0KEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eoyi9og8;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VPBJ2VMc;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DFC606A320
	for <linux-integrity@vger.kernel.org>; Wed, 21 Oct 2026 17:43:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3DFC606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eoyi9og8;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VPBJ2VMc
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69LFTo58141139
	for <linux-integrity@vger.kernel.org>; Wed, 21 Oct 2026 17:43:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vilmZRHHMNfnexi+YGDujqWXf83C8yeE3BqzopJL6bY=; b=eoyi9og8lE7X7gFs
	6zN8p4jNwkyfCNTayV/KpLYTog8YiPf09MNrJZcVJnd8ebBGnM3y90AF6J6wPsgu
	KIHm6p3JiNc6RZfwNDa4t1fGBEFrTEmAppjPtFmqqXsDcs6gCeSuRZZlb5bNDOS9
	ImS1uhcDnN727Uzxw2NojUhBmpaItcPZUTIJpC/20W36NsqozA/ILY/A7RqOC8Fa
	fp6nVz6bC6n4qpaiLw/MFEox+9rhuaWmCR3mtKA8Cekf76hFS10V2nlLwjUarK9d
	b3wbMfLBTWZOussj3TRqDPdEihPsXKcxNsCG7ejdilg63VQy4NSwejKyn6ahUKZG
	iSFgwA==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hex58986q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Wed, 21 Oct 2026 17:43:43 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-139b62317d0so3204281c88.0
        for <linux-integrity@vger.kernel.org>; Wed, 21 Oct 2026 10:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792604622; x=1793209422; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=vilmZRHHMNfnexi+YGDujqWXf83C8yeE3BqzopJL6bY=;
        b=VPBJ2VMcXcNaHj4LvsAXnFhW1FlDSGpaj2nJ67NIv90rlCtfQrlm3xO2OP8/6q3U3v
         m/GywmheMx/wIgDsfVLHSLgY8RkZnG8Q4BjhxWHOhLRuYL+ZwHntk2e+DA2w8++IrGkr
         7taUWS2dgOWrmoN+0sCwZUd9bWehyi0IcJXVqUby/F+KkeuwMKzDA+2/A/QYRhi6dN8T
         TgkoO+f1LeOWlAfFzrzlPWw6NvnyBvLkPrbTgCqMCHglJfTtBKjYW9wITBbwCKrvukU9
         mWriQnI4utRmRal8KvRNBjJxkrWcOFT9PhHcVop3Pl2aAniGBamO/Gn2qlaJ4T3qeaQY
         ZWXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792604622; x=1793209422;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vilmZRHHMNfnexi+YGDujqWXf83C8yeE3BqzopJL6bY=;
        b=nOb4IQJc58mCj1iwOC1AEzZU9uOY0ILVwzxE3TM2mGP+V5Yj/DKondNGrowjQGufg3
         2lEiQfUtjX6cvItBL4lz4kpdPKwzqs2ZnaV3SOZDhVQjIuzXNw3LWGAZpF9PvVQmzmox
         5k4C37eiPTGe+7pjJ3SutTspd2pHexBliAgrOMBtOr17c1qDszFyJCZcAORGc2omf2yk
         kcZN0Cz+BnGgfP2/sqVXK7CAr07hSwFHhgsLGAaxHIwHXnvxPLxbI/aL+aI8emz6M/V5
         hlTqOEBn4S5nM4MX14A0Gkihgvv8p419jmVeCUtt48vvuS8yNsp64KcJ5l2e7GGBgGzW
         eeRQ==
X-Forwarded-Encrypted: i=1; AKwUvBxChnQ2+ZilHM/zWCVeRMlCGbQDsp1rIy6DMMrShmiZg5rJgNK9RDthEqpzFDmZ06vNf7zd+rTp08vcPfdggOw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLIsL0dMTr9IxmNixrcrUEAaX8p2MWRrJd3+ZZ0Ah6oWArqmd2Z
	4knCOgh6f0wOigqUsfONnD+I2z+JIs9awTv0yKu7qdr8ahT57k6YKUXhw18+/3zZZ1A0F6z9IoS
	33Cu9i2kffjJM47eIeJLeijXmkbXMvzwH8uBCmZ/8KiY8GM5XyBpO/VZet+qUp3/ie2L96E8=
X-Gm-Gg: AYBFou0yH9CKH2ush44MhtmeuY8S0XtNzJCdL04P6vax9jyrjjV1KtI3HSJbIuA8NIk
	2eMOudzmGCOnqd8KeVUqgMHFhWOlSDfU6dOnl80Z1XV4myNSDO0ehBaA8lrutJ5w6sJL98lot7N
	kQlYllHPBNlo2lVKnEHMorQaL/I2MOO6lRWuqW146Ot1Qw/Efv6YuWkooT77x4A1efYWpqbUaXK
	f0GFTouU0fbqJECzewp0fQL9N0T0mMcIt90IAzwWEQCnsffgERHxCvkH4AKfMo33ph3gq6zw2v4
	VPSnrh+47FFiVgvEodfDiMwnHG8ZHAvXyoYR/B+0XKG4FDVuMuffvbraJwF/xhZC0mPeTf1E/5V
	59hbByCyLJ/7RgM2oHYfer2y+eHf/ciLqVAxRW/0Wvg==
X-Received: by 2002:a05:693c:65db:b0:366:8efb:bab9 with SMTP id 5a478bee46e88-3674e450f24mr4349160eec.11.1792604622268;
        Wed, 21 Oct 2026 10:43:42 -0700 (PDT)
X-Received: by 2002:a05:693c:65db:b0:366:8efb:bab9 with SMTP id 5a478bee46e88-3674e450f24mr4349127eec.11.1792604621677;
        Wed, 21 Oct 2026 10:43:41 -0700 (PDT)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36741f753f7sm8840346eec.27.2026.10.21.10.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 10:43:41 -0700 (PDT)
Date: Wed, 21 Oct 2026 10:43:36 -0700
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Albert Ou <aou@eecs.berkeley.edu>,
        Ard
 Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Catalin
 Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>, David
 Sterba <dsterba@suse.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-riscv@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
        Randy
 Dunlap <rdunlap@infradead.org>, Simon Glass <sjg@chromium.org>,
        Shuah Khan
 <skhan@linuxfoundation.org>,
        Nick Terrell <terrelln@fb.com>, Will Deacon
 <will@kernel.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Conor Dooley
 <conor.dooley@microchip.com>,
        linux-integrity@vger.kernel.org, Palmer
 Dabbelt <palmer@rivosinc.com>,
        patches@lists.linux.dev,
        Piotr
 =?ISO-8859-1?Q?Kr=F3l?= <piotr.krol@3mdeb.com>,
        Ross Philipson
 <ross.philipson@gmail.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Song
 Shuai <songshuaishuai@tinylab.org>
Subject: Re: [PATCH v2 11/15] arm64: drtm: Add macro definitions for DEN0113
Message-ID: <20261021104336.00000437@oss.qualcomm.com>
In-Reply-To: <11-v2-989a18390eb1+486-arm64_drtm_jgg@nvidia.com>
References: <0-v2-989a18390eb1+486-arm64_drtm_jgg@nvidia.com>
	<11-v2-989a18390eb1+486-arm64_drtm_jgg@nvidia.com>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA3MCBTYWx0ZWRfX3+QdBxkOPNiD
 zygY84pIrv8wE2rUzaeCgLb9RZOq4rWPEge6i8L6xekP/Be8ntLauoQId+1OYP9NjePHhMfji+M
 kUXHim6FofUwIiqkNvBg08pz5C30z1Q=
X-Proofpoint-GUID: -KjjxI6fbgGcWuRMKZIeH8HBP8atsh3C
X-Proofpoint-ORIG-GUID: -KjjxI6fbgGcWuRMKZIeH8HBP8atsh3C
X-Authority-Analysis: v=2.4 cv=Ku7YSmWN c=1 sm=1 tr=0 ts=6ad8f9cf cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=Ikd4Dj_1AAAA:8 a=EUspDBNiAAAA:8 a=cBdanpMcOxUnX1AP4g8A:9 a=CjuIK1q_8ugA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA3MCBTYWx0ZWRfX5W8Bvw/h3kuW
 pCBpTSK8QPWp/D+5eCQIdrwtPKJ9Bm0ffTlu7Otqr6pCEN3WIxk869C1V1uCZpaQYf2ZCX7+Nb4
 jSfFu2YU/I5Iw53OsK7GQNuQMkoc3qFkJ6Cm54SsV+JQXT+KxtLX1dZhq5ZRiLMba7bZNaK9r8p
 GFt0vBqGw58XWP9OpDT24mEB4VJUGSAA2NkzjlOjPnuvT6ZaJnhD0l8cgukKPTJ4/WGn1QBmBKD
 E8/FIRl7hz7MGSKDehsFouB9RR5/xsDzc7JcI3Vmu18W2/Mr9dKhtJBykhiFAmmDFCLWh7ZyZoW
 mGHAyfVfex8erMOmoI/f42uNuqxbEcbRJq2ILDXoEkDZZiNXxsHjLe5aaV9ShxRKtDnhI+uYJyd
 aP/2ekgHTpVoHH7CJLlPZ7aewBZUqnWgvn6aT/stcCOH+NIl3kMux/YL40bEy/E9ZpgIgLqUsuR
 JDmKqkB+zaFzzUShcoQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210070

On Fri,  2 Oct 2026 20:31:48 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> Taken from rev 1.4b of the spec, following the SMCC register layout and
> constant names.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Nice - appreciated the spec references as saved a bunch of searching.
A few really small comments inline. Either way 

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

> ---
>  arch/arm64/include/asm/drtm.h | 304 ++++++++++++++++++++++++++++++++++
>  1 file changed, 304 insertions(+)
>  create mode 100644 arch/arm64/include/asm/drtm.h
> 
> diff --git a/arch/arm64/include/asm/drtm.h b/arch/arm64/include/asm/drtm.h
> new file mode 100644
> index 00000000000000..8188af1b582bb3
> --- /dev/null
> +++ b/arch/arm64/include/asm/drtm.h

> +/*
> + * The spec uses 4KB pages for sizes and alignment throughout, see v1.4B
> + * sections 3.3, 3.13, 3.14 and 3.15.
> + */
> +#define ARM_DRTM_PAGE_SIZE			4096

Maybe use SZ_4K from linux/sizes.h



> +/* v1.4B section 3.3 "DRTM_FEATURES" */
> +#define ARM_DRTM_SMC_FEATURES			(ARM_DRTM_SMC_FN_BASE + 0x01)
> +/* X1 input parameter */
> +#define ARM_DRTM_FEATURE_SELECTOR		BIT_U64(63)

Maybe define the alternate masking for function ID - for completeness if nothing else.

> +#define ARM_DRTM_FEATURE_ID_MASK		GENMASK_U64(7, 0)

> +/*
> + * PCR schema numbers. ARM_DRTM_PCR_SCHEMA_MASK is a bitmap indexed by these,
> + * and the Launch Features ARM_DRTM_LAUNCH_PCR_SCHEMA_MASK field holds one.
> + */

Similar to below. Maybe this dual use is a bit fragile.

> +#define ARM_DRTM_PCR_SCHEMA_DEFAULT		0
> +#define ARM_DRTM_PCR_SCHEMA_AUTHORITIES		1

> +/* v1.4B Table 6 "DMA protection features" */
> +#define ARM_DRTM_FEATURE_DMA_PROTECTION		0x03
> +#define ARM_DRTM_DMA_PROTECTION_MASK		GENMASK_U64(7, 0)
> +/* Only valid if ARM_DRTM_DMA_PROTECTION_REGION is supported */
> +#define ARM_DRTM_MAX_REGIONS_MASK		GENMASK_U64(23, 8)
> +
> +/*
> + * DMA protection types. ARM_DRTM_DMA_PROTECTION_MASK is a bitmap indexed by
> + * these, and the Launch Features ARM_DRTM_LAUNCH_DMA_PROTECTION_MASK field
> + * holds one.
> + */
> +#define ARM_DRTM_DMA_PROTECTION_COMPLETE	0
> +#define ARM_DRTM_DMA_PROTECTION_REGION		1

The dual use of these for bitmap indexes in one place and
values in another seems fragile.  Maybe it is better to have
different naming for the two even though the values match?


> +/* v1.4B section 3.4 "DRTM_DYNAMIC_LAUNCH" */
> +#define ARM_DRTM_SMC_DYNAMIC_LAUNCH		(ARM_DRTM_SMC_FN_BASE + 0x04)
> +
> +/* v1.4B section 3.5 "DRTM_UNPROTECT_MEMORY" */
> +#define ARM_DRTM_SMC_UNPROTECT_MEMORY		(ARM_DRTM_SMC_FN_BASE + 0x03)
> +
> +/* v1.4B section 3.6 "DRTM_CLOSE_LOCALITY" */
> +#define ARM_DRTM_SMC_CLOSE_LOCALITY		(ARM_DRTM_SMC_FN_BASE + 0x05)
> +
> +/* v1.4B section 3.7 "DRTM_GET_ERROR" */
> +#define ARM_DRTM_SMC_GET_ERROR			(ARM_DRTM_SMC_FN_BASE + 0x06)
> +
> +/* v1.4B section 3.8 "DRTM_SET_ERROR" */

I know I'm the one who asks for references, but maybe the SMC numbers are obvious
enough without given the name matches the spec section?  The table references
etc below are excellent!  The do no harm beyond a bit of bloat though so I don't
mind if you want to keep them.

> +#define ARM_DRTM_SMC_SET_ERROR			(ARM_DRTM_SMC_FN_BASE + 0x07)

> +
> +/* v1.4B Table 8 "Definition for error IDs (Bits[10:3])" */
> +#define ARM_DRTM_ERROR_ID_NONE			0x0
> +#define ARM_DRTM_ERROR_ID_PARAMETERS		0x2
> +#define ARM_DRTM_ERROR_ID_SECURE_EXCEPTION	0x3
> +#define ARM_DRTM_ERROR_ID_TCB_HASH_UNLOCKED	0x4

I'd use NOT_LOCKED to align with spec.  Maybe it makes a subtle
difference somewhere? UNLOCKED might imply a transition to that
state, where as NOT_LOCKED doesn't.  Meh, doesn't really matter
as I'm probably over thinking this.

> +#define ARM_DRTM_ERROR_ID_TPM			0x5
> +#define ARM_DRTM_ERROR_ID_SIGNATURE		0x6
> +#define ARM_DRTM_ERROR_ID_IMAGE_FORMAT		0x7
> +#define ARM_DRTM_ERROR_ID_VENDOR		0xFF

> +/*
> + * v1.4b Section 3.3.1 says:
> + *   A return value of greater than 0 means the feature ID is
> + *   implemented, and there are other feature-specific
> + *   feature or capability bits available in other return value
> + *   registers.

I'd wrap to 80 chars.

> + * And for FEATURE_SELECTOR all defined features return data in other
> + * registers, so 0 is not an allowed return.
> + */
> +static inline s64 arm_drtm_query_feature(u64 feature, u64 *value)
> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_1_1_smc(ARM_DRTM_SMC_FEATURES,
> +			  ARM_DRTM_FEATURE_SELECTOR |
> +				  FIELD_PREP(ARM_DRTM_FEATURE_ID_MASK, feature),

> +			  0, 0, 0, 0, 0, 0, &res);
> +	*value = res.a1;
> +	return res.a0;
> +}


> +
> +#endif /* !__ASSEMBLY__ */
> +#endif /* __ASM_DRTM_H */


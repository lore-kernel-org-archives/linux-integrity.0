Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8566A202C29
	for <linux-integrity@vger.kernel.org>; Fri, 25 Sep 2026 00:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790296203; cv=none; b=PzURyI5n6lPRf3VcZkkU/oYUkUxVzAPMEfziIgmCuO3cvpyCMOlukHCbaXOTLVtWhQm1SlozI9DwgZ1hJyLeeNeKNtTlyF9XbyHVFkvv4UIXZ7MBspNnePx+JFNbwMMcG8nDZ5MAu1Lems2lyI+xSH3OX4b5B1qUjZv6OwOaHn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790296203; c=relaxed/simple;
	bh=9Q2K6mbtjsAzLVeuxK9KBYZdqtzrNEWwtOzv3XSpeh0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sRAXHSF/CM+5irC9L/aBkxMZVkpPrcKQFKV8Rg8XLA2ghoP7Rb83We7ClNEUWN+BjpgoB6o6SIDCQv2WHO7PJvdMzsb/hN/jmOcxEvx+dZ6HXzXEZREdmB7t7nI6U8kCcAYt//xgA3ii53fgP5RtLO66oq/Kd8DNt1sDpMDdQVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P76wGl9I; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Tu16rjmg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P76wGl9I";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Tu16rjmg"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68OMPg0G3935177
	for <linux-integrity@vger.kernel.org>; Fri, 25 Sep 2026 00:29:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Oxf/bzY2P61BCqevg2wInSVfof+9uK9KzXUbb4iYa7E=; b=P76wGl9IagAiq66z
	2eVWkt5gKScEyoH6IEc5LKDqXNs71bWKfmNptmv38ekmGmu7RmwpyI5NtrieqwQS
	cqaqS8tJ096rBMDXM622NM358/UcNvcfGs4uZCG9YHP+3Ap0plsm232eBGFhqhkX
	IXSzJCFIpCpBejv+M+BTi42oPh7SdVS7ox23EZQX+Wxgjp/KN3NZe1D9Ppp9IQcP
	srKp6ngYvY2dbl5kHBU5ShT3bqa8Tnn4XoCaMNINkdLrIPP6WEQQWh+mDbYjzSLJ
	UBL8Dbnh9uDBCmUIKZ/ji0gn+uoMLIMG3zEq9UsSQTf5HMI286EScBcjOzAqDpSy
	BpcC+g==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw1tjk6vh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Fri, 25 Sep 2026 00:29:59 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-333543ac378so368810eec.1
        for <linux-integrity@vger.kernel.org>; Thu, 24 Sep 2026 17:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790296198; x=1790900998; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Oxf/bzY2P61BCqevg2wInSVfof+9uK9KzXUbb4iYa7E=;
        b=Tu16rjmgJZmnIgdF6sl8ikP0SYTf32K03hrfrINCtgTOi9FyKAHcTq6eLFd0beh3F3
         5bw/aO2PEeGnH631jRnbvXGeGQzcDl48I83rbzJ9yrlcOfJN/wh6ZlVa/5eCaUGW/Ldt
         xsMh+XKgCy46PXeca8vTggH+DLW7vi+OV+yqstmpaPtrcF3yNyxtQMgRDd1niUQvFVBz
         utkeIl2TAGV05LtOTv4URJerCGqzlWnobyyBqUQUWxiWIEM/Tz5FtuLonMgKun9vQS6l
         9v3//oGqmAbfZTNhNgpzmeDJu01fYSyTLqYsLVWiL4eDA5k/qxZWf5vC7ehSg9qK3UHv
         L40g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790296198; x=1790900998;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Oxf/bzY2P61BCqevg2wInSVfof+9uK9KzXUbb4iYa7E=;
        b=J3TbDfFlCiffMNk4vRFXe/W/VuitW2zlv9Neosc0lmH0pSmXklLJe9oFb7/sUwJC+l
         buUJsXIfQgsq6Cmsw3vmUQwfOWdizRK9ZKNrjfWfh++nLiY2p91/JZXlT0yqjlmsS8SP
         1bpuGpibVOifHIdYYu0p2/VQQIrPKjCgJG/gMsFFKQQtF6ILnPILePkApRra+i97UwcM
         pyVxBotjOIdM/YPNZ/MxaeXVhWeXLDIKqksw+jn2/1VtwKzMYu5HFcUGFg+jamjTK3yd
         XddiZgWumKK4Ew1H1SzhgmyKj9AD6QHJHCkvouDWTG4jR+LbM99WI4PED36P2FQGypRq
         zh2g==
X-Forwarded-Encrypted: i=1; AKwUvBzosF5uj95UIpXmeEIKMpq9EknGc1bt0J90qwRIiHeA+7OqEOURo/2NaqzEMednksnaXwqTWZ6kbb/MlTrwhN8=@vger.kernel.org
X-Gm-Message-State: AFuF++kZQbrHH4cZS8vj9U5BPG5LmzqKVkCHTfWr57h9enGLIfOS5W0m
	t7dH59cwIVWduy80Rmi91u2qHaSY7Fm0JtZI+OLwXRIHAJY2CxkxMu91LLrMUZOFuubBhKM3p/R
	VDGwdn5VH9pXJU7upommKPjekgJjbxVO7TDEoNE0WIqPCvHrK38pZmypVJQstVY7gH6aEOrY=
X-Gm-Gg: AYBFou3n5lWzn5Fnj+MclMrTJNkGG67gc4tzgPgsE0hFDY0wk7EMVvcvN3Gb/KcJFsf
	sjO5D/Tp41hR52Hf81RCj4pePRBt8zDIioUa3eqWazsb/Te4QA5St6GPfwRTJh+K936bnzaUMcm
	VM+rwiTaNfhHytW/c4FRn/Ztln3r+81ZcRGK+8vM7QLQaVyorMrCGwXIaY4KNkASvjPLQ0Rv2tX
	YGT8VYpzBIcQJor1NKZW0i8Lc5NjPtfIHci3kRJLd/A8E3zjYuS4b46PQ9p6jAjjN/27VSsYGLX
	eq18sZNbLBS+Q/ZBA90NKl/Y1ks7xvswdMXbocnZ1nH7d52j7vhTNvCw+6QPO6h2IiUoIX3dZc8
	TiGHIqK0oSvejUBJkxLKhf0mD8CYRXaB0ovfo9jl4yIVJHruRZED99lQ=
X-Received: by 2002:a05:7300:c019:10b0:33b:c24c:47cd with SMTP id 5a478bee46e88-340035bf9d9mr3661160eec.16.1790296198012;
        Thu, 24 Sep 2026 17:29:58 -0700 (PDT)
X-Received: by 2002:a05:7300:c019:10b0:33b:c24c:47cd with SMTP id 5a478bee46e88-340035bf9d9mr3661145eec.16.1790296197403;
        Thu, 24 Sep 2026 17:29:57 -0700 (PDT)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34141a4a5ecsm1889901eec.3.2026.09.24.17.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 17:29:57 -0700 (PDT)
Date: Thu, 24 Sep 2026 17:29:52 -0700
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
        patches@lists.linux.dev, Ross Philipson
 <ross.philipson@gmail.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Song
 Shuai <songshuaishuai@tinylab.org>,
        Suzuki K Poulose
 <suzuki.poulose@arm.com>
Subject: Re: [PATCH 12/16] arm64: drtm: Add macro definitions for DEN0113
Message-ID: <20260924172952.0000527e@oss.qualcomm.com>
In-Reply-To: <12-v1-27d06b313981+8b-arm64_drtm_jgg@nvidia.com>
References: <0-v1-27d06b313981+8b-arm64_drtm_jgg@nvidia.com>
	<12-v1-27d06b313981+8b-arm64_drtm_jgg@nvidia.com>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 06an7liqxAxPp26IYBEtnk3TkNm0HBHl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAwMSBTYWx0ZWRfX1C9oo24tZk7r
 +HCC/5rJqTxye59YFGC3O8sVpsjVupkrvrCX7Jv38PIrJOywW2pBnbCNjoa43L8QW+ZLZW/CrRQ
 oupgcENsSAzMY0RN+xyjMzT+ITnTYAxmHUYzsedwua0jQE/soiM2AiTAf5MWPwE8VgLYllbapn/
 X6rgf8M/5jT2fMwIkXQMMYG831lbPdD2yxZp8+T1kyvjcveRcDY7rfQr1z8Gfu9lx2OSSe+Bc8V
 VDrDp4iAn2r9XHzNAKevb+hUggMypEHhhVfcAUYwmGJu234cVQl1aJpYic06INR1tj+0AsRngcX
 U83MruHOHFx8YVrLPBZR/BGHUwh+zpy4lsVfYAcnr8EEElfI9l3b/B5SNJ4cskOB3EElzbqpJSL
 6oq4XiGeGnM3K3ckTvTA1HM1baYbIonGZK/5oJPy7LJ384SzzTKuHebGh+sIY6dPm8/Xd7lO6p+
 MljAqWfwX9cAw8xtQIg==
X-Authority-Analysis: v=2.4 cv=cK11IVeN c=1 sm=1 tr=0 ts=6ab5c087 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=Ikd4Dj_1AAAA:8 a=QhzypnB_sqCglQZzAf8A:9
 a=CjuIK1q_8ugA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: 06an7liqxAxPp26IYBEtnk3TkNm0HBHl
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAwMSBTYWx0ZWRfX3ioNBNtBavTN
 k2bJBmiPkwOaZYjEVpmT+scNOQqFQ5G/tsHW4/bi0YXx38ZAG1eTZNPobT/4SV2pmp6RvjQbYnK
 ZSVf4rcVklPi53ulM+JyHQP2otGd4XE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250001

On Thu, 24 Sep 2026 10:53:15 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> Taken from rev 1.4b of the spec, following the SMCC register layout and
> constant names.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  arch/arm64/include/asm/drtm.h | 196 ++++++++++++++++++++++++++++++++++
>  1 file changed, 196 insertions(+)
>  create mode 100644 arch/arm64/include/asm/drtm.h
> 
> diff --git a/arch/arm64/include/asm/drtm.h b/arch/arm64/include/asm/drtm.h
> new file mode 100644
> index 00000000000000..d6dd04a4ebcea5
> --- /dev/null
> +++ b/arch/arm64/include/asm/drtm.h
> @@ -0,0 +1,196 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES
> + *
> + * Definitions from ARM DEN 0113 "DRTM Architecture for Arm"
> + */
> +#ifndef __ASM_DRTM_H
> +#define __ASM_DRTM_H
> +
> +#include <linux/arm-smccc.h>
> +#include <linux/bits.h>
> +
> +/* Offset 0x02 is reserved by DEN0113. */
> +#define ARM_DRTM_SMC_FN_BASE                                      \
> +	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, ARM_SMCCC_SMC_64, \
> +			   ARM_SMCCC_OWNER_STANDARD, 0x110)

Another wrapper for the same thing. Now which patch set did I last
moan about this in...  RMM 2.0 firmware series.
https://lore.kernel.org/all/d7ccaf22-5bde-4344-8bf0-a5a17dcac0f3@arm.com/

This one at least does it via base and sum.  But that then separates it from
the spec?   That is sort of the case anyway because the spec has the full
number.  0xC400_0110 so I guess not too bad.

> +#define ARM_DRTM_SMC_VERSION			(ARM_DRTM_SMC_FN_BASE + 0x00)



> +#define ARM_DRTM_FEATURE_SELECTOR	BIT_U64(63)
> +#define ARM_DRTM_FEATURE_TPM		0x01
> +#define ARM_DRTM_FEATURE_MIN_MEMORY	0x02
> +#define ARM_DRTM_FEATURE_DMA_PROTECTION	0x03
> +#define ARM_DRTM_FEATURE_BOOT_PE	0x04
> +#define ARM_DRTM_FEATURE_TCB_HASH	0x05
> +#define ARM_DRTM_FEATURE_IMAGE_AUTH	0x06

Nice to have a mask for the 8 bits of the feature field.
Also nice to keep order the same as the SMC defines which would put this after
version.  That also puts it next to the values returned for each feature.



> +
> +#define ARM_DRTM_TPM_ALG_MASK		GENMASK_U64(15, 0)
> +#define ARM_DRTM_TPM_HASHING		BIT_U64(32)
> +#define ARM_DRTM_PCR_SCHEMA_MASK	GENMASK_U64(36, 33)
> +#define ARM_DRTM_PCR_SCHEMA_DEFAULT	BIT_U64(33)
> +#define ARM_DRTM_PCR_SCHEMA_AUTHORITIES	BIT_U64(34)

Ah.  Always love a field made up of a bunch of bits. Hard to define
cleanly.   Do you actually need the PCR_SCHEMA_MASK?  Might be easier
to just not have it?  I think you only use it for a print. Maybe
build the bits we understand from the two specific bits?

Alternatively you could use the spec style definition and have 
#define ARM_DRTM_PCR_SCHEMA_DEFAULT BIT(0)
#define ARM_DRTM_PCR_SCHEMA_AUTHORITIES BIT(1)
or similar and have to check them via a FIELD_GET(FIELD_GET())



> +
> +#define ARM_DRTM_DLME_DATA_PAGES_MASK	GENMASK_U64(31, 0)
> +#define ARM_DRTM_NW_DCE_PAGES_MASK	GENMASK_U64(63, 32)
> +#define ARM_DRTM_PAGE_SIZE		4096
> +
> +#define ARM_DRTM_DMA_PROTECTION_MASK	GENMASK_U64(7, 0)
> +#define ARM_DRTM_DMA_PROTECTION_COMPLETE BIT_U64(0)
> +#define ARM_DRTM_DMA_PROTECTION_REGION	BIT_U64(1)

Ah. They are at it again. Fields within fields.
Maybe could use some white space to make it somewhat obvious
that is going on?  Indent the subfield a bit more?


> +#define ARM_DRTM_MAX_REGIONS_MASK	GENMASK_U64(23, 8)

blank line here probably just to make it obvious going to a
different u64.

> +#define ARM_DRTM_TCB_HASH_COUNT_MASK	GENMASK_U64(7, 0)

Same here.  I vaguely wonder if it is worth adding something
reflecting the relevant feature ID to each of these defines
so we know what the are referring to?

> +#define ARM_DRTM_IMAGE_AUTH_SUPPORTED	BIT_U64(0)
> +

Maybe a comment for next lot to where to find them in the spec
- took me a while.  Table 9 DTRM_Parameters, line for
LAUNCH_FEATURES if anyone is following along.

> +#define ARM_DRTM_LAUNCH_HASH_FIRMWARE	0
> +#define ARM_DRTM_LAUNCH_HASH_TPM	BIT_U32(0)

I'd rather see them as fields and field value pairs but
can see that is going to get a bit verbose.

> +#define ARM_DRTM_LAUNCH_PCR_DEFAULT	0
> +#define ARM_DRTM_LAUNCH_PCR_AUTHORITIES	BIT_U32(1)
> +#define ARM_DRTM_LAUNCH_DMA_COMPLETE	0
> +#define ARM_DRTM_LAUNCH_DMA_REGION	BIT_U32(3)
> +#define ARM_DRTM_LAUNCH_NO_AUTH		0
> +#define ARM_DRTM_LAUNCH_AUTH		BIT_U32(6)
> +#define ARM_DRTM_LAUNCH_KEEP_SECURE_IRQS 0
> +#define ARM_DRTM_LAUNCH_DISABLE_SECURE_IRQS BIT_U32(7)
> +
> +#define ARM_DRTM_SUCCESS		0
> +#define ARM_DRTM_NOT_SUPPORTED		-1
> +#define ARM_DRTM_INVALID_PARAMETERS	-2
> +#define ARM_DRTM_DENIED			-3
> +#define ARM_DRTM_NOT_FOUND		-4
> +#define ARM_DRTM_INTERNAL_ERROR		-5
> +#define ARM_DRTM_MEM_PROTECT_INVALID	-6

Hmm. the spec I pulled from arm.com has COPROCESSOR_ERROR for -7. Maybe
include it?

> +#define ARM_DRTM_OUT_OF_RESOURCES	-8
> +#define ARM_DRTM_INVALID_DATA		-9
> +#define ARM_DRTM_SECONDARY_PE_NOT_OFF	-10
> +#define ARM_DRTM_ALREADY_CLOSED		-11
> +#define ARM_DRTM_TPM_ERROR		-12
> +
> +/* Algorthim IDs are defined by TCG, in the kernel they are TPM_ALG_* */
> +
> +#define ARM_DRTM_PARAMETERS_REVISION	2
> +
> +#ifndef __ASSEMBLY__
> +
> +#include <linux/bitfield.h>
> +#include <linux/build_bug.h>
> +#include <linux/stddef.h>
> +#include <linux/types.h>

> +
> +static inline s64 arm_drtm_features(u64 function_or_feature, u64 *value)
> +{
> +	struct arm_smccc_res res;
> +	s64 status;
> +
> +	arm_smccc_1_1_smc(ARM_DRTM_SMC_FEATURES, function_or_feature,
> +			  0, 0, 0, 0, 0, 0, &res);
> +	status = res.a0;
> +	if (status >= 0 && value)
> +		*value = res.a1;
If status == 0, is res.a1 useful?
You have a helpful comment at the call site in the final patch but none
the less I have read the spec section a couple of times and have no idea.

> +	return status;
> +}

Thanks,

Jonathan



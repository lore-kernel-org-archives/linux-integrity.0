Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AD936F434
	for <linux-integrity@vger.kernel.org>; Thu, 24 Sep 2026 22:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790289762; cv=none; b=sgoQ4XzJm7wrYoRZE2C3A6vzwCkCLva3uyGaEVm8Y/MxQZnrjVkDEHzEh85u0VWnB2EmMm5ZJ7xRQUbxQb1XIbWux+VEEy4JV8wna0WJXmhc5Y3YQfGrdVrub2NY7oqXcovP897allj3HkpR/nss41oWr9v8Nho48rfmElGUGls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790289762; c=relaxed/simple;
	bh=2G1FOvOSJrV6/l8sO+qjbSBFUO9X0CWF5KTVr1JnZkM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AkcwuFuG/8Nni37GH0ov6DZSW2KarIqTA2rrWHdyjLZPBYuNygLNXiT+pmfDlKV05kDSt0r/e2vlusjbHnZjgJhxmDH7cxz2iTElgQ0fwnlWiUZpCYQl4O48OzvwzbRK8MN8PkFADcQ1xpncoOQzTyDZN/Nv6SQcsNTKIt0mxC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eaJiYBco; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gG3maEZM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eaJiYBco";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gG3maEZM"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68OMP2HY429311
	for <linux-integrity@vger.kernel.org>; Thu, 24 Sep 2026 22:42:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	81QaywXThCj9GvWcrqbFC8hrrggxf6pFQEEvB0A8Stc=; b=eaJiYBcoVJ7qevSl
	dhfq+tXf9Yrht/mLq/jwiRTObIgOPPAp4gq7bt1mDqjTW0V6kXIW+8178jTvvqEY
	/g72Tu5uLFr9TmxDOZ/WTOw4Db3jptMoLUpu03x0RYDq28zhhqtQH8+V6kNLVLAO
	1Ua+MyDrNoK2wgREaJE/EZogzihYwOq1s6HaLVkWSmzeuJh3HKsCfCtwvHP6+Jd8
	ENol9vchyHUhmq3K8SCqt3P2t3zGBv8XLggSyAt3yjEQk8zBoVPz6YK9sKvOoTjx
	qeijDJMaDaBEWWHG3mt12b/Lo717uv1T508Ea2fRW/yjOhQsk+HBOm2Y6914Juvl
	Prcy/g==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw874h4as-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Thu, 24 Sep 2026 22:42:37 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-33310847fcaso426103eec.1
        for <linux-integrity@vger.kernel.org>; Thu, 24 Sep 2026 15:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790289756; x=1790894556; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=81QaywXThCj9GvWcrqbFC8hrrggxf6pFQEEvB0A8Stc=;
        b=gG3maEZMC0pbufO8LL5QOq0FfxjoTxszo+qJRi0KYCzyZCnePkWLIQGKfUtcl/KTdQ
         XjIIP4d1fDStjCZtJK9dsFhzYqlQfBj62tM06gZ9fuECG7YBftIZ78IOog6jWcOcuiSo
         /5mMrN9O7ofxmffmpI05i4EMNqB9IWBf1KgF6KIBYQro5JMrRozz7UdnFaUUr3VsbfBW
         kCvnHHspLUSOy0tdNscpUYBF3SKsf958SmJCMRsUDNlDI/GD92uWfL4eXPW4W3XFOfpy
         82xm6J1T77jrZruDN8xxqCS6SIJD47hkJXLXaWxDaaBoyb9FmZtoNxk4esbVzM6dqf3l
         1mQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790289756; x=1790894556;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=81QaywXThCj9GvWcrqbFC8hrrggxf6pFQEEvB0A8Stc=;
        b=pOV0xKSOyshbu0AuJ8++Px/EhyzvoQIo2ts+yKGSfRaXiMZSusjyaoB5iY55trYeX2
         VFJNxUjih++uX12l9pgq0NlzFjZg/OTf4J/zsM0pEZMGPB10vdodySu8+Mc1niNTqvc6
         rzASh75eYkAejZuKZL+XBkJ1NjCpfQ43QqpeQ0EPxYwN2iUQotjSETRfnsBNOCBMM6+m
         Su3I4SUsu1GE3z6Ol7DQU+/mURU+iiMcY+Iscf/6odCyNa+2GkLTtuPWFg0TP5LGhEbL
         jFf4A1ceZMrjNCXkPCzdbTuyir3Rqe5miNqZbBUm3Yge7ZMHuSu1zKgV9TlMM1Bjywrl
         Og+Q==
X-Forwarded-Encrypted: i=1; AKwUvBxOQofS2T1bhBtnbN+1beNiXGs23DkIrZi4tH/QGGl7UaAQjUuouOVmL7d8+jy9YOTi+y1cZj1OKMg0jt7AGCo=@vger.kernel.org
X-Gm-Message-State: AFuF++mQ+DfEplMsodylYK9tE9jMWCxlB4gGMdUP1ONXwdkDKcXg2dM7
	AgSjIiKJHPtFmIkAiAF8zf1yeFzZJkWrtIKhd7Js/egltGwxh24Pf+LLsZR8C6GO9VkpehHL2nW
	G4g5XbIBpiGQDLEyb3a8PJYyjmLU4k0tcQLsbLjRE2RNWdjY0QQxURNgjS/Rd0QoamplmXh8=
X-Gm-Gg: AYBFou0heWJfMFSEXt2JWrECTcPkjAbufQBtkICLcWooUpXg5+kF6bIj8ciUvZgxbJh
	zox9MlDxDtLsC0rKJEVJfPnyEgwHArOLqDVEhzqmby3GRBdlapOLz5EtCznVI2L33oA7/S+YgtC
	bYf52QxKd79/ggV1gRfENI9+zBAGQ8pVKjyolPVXYSjpmIq9oTdoGzkzorVJSBLNqiq3LccaVAn
	jk+w7cq+xS6BoSkjvkRM0U6Aj/21jO8mO3XWo3lXJW/dlMO2jISgXgpUcdpf52glaAWetSsDCt1
	DTPhenFyNR1BqylP/TQeiIq4rQmdS/njcKMkvKo74OR6Cc2ue/jP+TujzNlRphdh/qnfDMC2fvu
	GpfEaxoOJnkSposPgImx+7MZ4fjOJC0zJSvu/ZyDO3sHniDymq0jkow==
X-Received: by 2002:a05:693c:601c:b0:341:4f3:8f84 with SMTP id 5a478bee46e88-341973cf3cfmr121006eec.13.1790289756381;
        Thu, 24 Sep 2026 15:42:36 -0700 (PDT)
X-Received: by 2002:a05:693c:601c:b0:341:4f3:8f84 with SMTP id 5a478bee46e88-341973cf3cfmr120917eec.13.1790289752160;
        Thu, 24 Sep 2026 15:42:32 -0700 (PDT)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34145d0fc9fsm1538764eec.25.2026.09.24.15.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 15:42:31 -0700 (PDT)
Date: Thu, 24 Sep 2026 15:42:27 -0700
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
 Shuai <songshuaishuai@tinylab.org>
Subject: Re: [PATCH 01/16] efi/libstub: Fix error unwind freeing fdt in
 allocate_new_fdt_and_exit_boot()
Message-ID: <20260924154227.00001cbe@oss.qualcomm.com>
In-Reply-To: <1-v1-27d06b313981+8b-arm64_drtm_jgg@nvidia.com>
References: <0-v1-27d06b313981+8b-arm64_drtm_jgg@nvidia.com>
	<1-v1-27d06b313981+8b-arm64_drtm_jgg@nvidia.com>
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
X-Proofpoint-ORIG-GUID: J_mrzFGONCbMvwpfVAlq--OGtA6U9fpn
X-Authority-Analysis: v=2.4 cv=MI71C8Zl c=1 sm=1 tr=0 ts=6ab5a75d cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=Ikd4Dj_1AAAA:8 a=EUspDBNiAAAA:8 a=7U2iMG9xLqzP7ZOKqLsA:9
 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19 a=CjuIK1q_8ugA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA5MiBTYWx0ZWRfX632tAaJXwj0d
 N65z65wPEWiQqP7iQeBRImxUL+r5HamNp6Bh5egXShIoYEQ/pM4eqq2v0iGRXiHcQZWPYvSgFcJ
 4DwmCogLfQZDEo8aqSVdQq+y08lyS6oRJzVSApXYnIOvNCerIpIlcZavIEiuIjhfGdGSTJbBJvn
 B7Eam/Ihzi77CIJ78QMtVQB/1XcvezBnxf9FGEGeqzlpytQzGxJLTzONm7rpVxOHv9c8A0ktRtM
 ITpbYoLbOUN8GTfDsisMIlTKXxiODXWN3Bz5e8busDjz0HBP6E17UvuDK75VZZLDk/Tq3X3G7vN
 DKDChlEQ/5vu84Tf/KAs3bu+nY/IGTZrMr2RhRCUGrkkB3simoOCIMhXWRWoBp94xZ4oGCvMWHU
 0eAassNZcdK31JeVidD0OArcT0WGBXggoEFnDvsmmAaV/P8mJJ/Tg8ULS1sL7939/gbVMY/lbrQ
 7OydDlS/VtafzG+fjMA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA5MiBTYWx0ZWRfXxlBYk3w+G/zb
 q7zVihxCqXlnqtJVcjvEfU+SLyK7lX4xJI++b/9TBuGFn1iE2e0lMSAG8Drai0M3Nqh80p3Q+FZ
 sMex4O0wI91KK59pn2AHPgXv+XcNisk=
X-Proofpoint-GUID: J_mrzFGONCbMvwpfVAlq--OGtA6U9fpn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 clxscore=1011 spamscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240092

On Thu, 24 Sep 2026 10:53:04 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> Sashiko says fdt_addr can point to either an allocated fdt or the fdt from
> get_fdt() which is memory owned by FW.
> 
> Only the allocated fdt should be freed on the error unwind path. Use a
> dedicated variable for the allocation's size so that the free does not get
> confused.
> 
> Fixes: 4fc8e738ff3e ("efi: libstub: remove DT dependency from generic stub")
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/firmware/efi/libstub/fdt.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/efi/libstub/fdt.c b/drivers/firmware/efi/libstub/fdt.c
> index 23b3543d3041b0..5b2dd709d7b151 100644
> --- a/drivers/firmware/efi/libstub/fdt.c
> +++ b/drivers/firmware/efi/libstub/fdt.c
> @@ -229,6 +229,7 @@ efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
>  	u32 desc_ver;
>  	efi_status_t status;
>  	struct exit_boot_struct priv;
> +	unsigned long fdt_size_allocated = 0;
>  	unsigned long fdt_addr = 0;
>  	unsigned long fdt_size = 0;
>  
> @@ -257,6 +258,7 @@ efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
>  			efi_err("Failed to load device tree!\n");
>  			goto fail;
>  		}
> +		fdt_size_allocated = fdt_size;
Hmm. I argued with myself for a while on this.  Which one of fdt_size and fdt_size_allocate
is the appropriate one to pass to the call?  In the end I didn't get a good answer so
oh I guess this is as good as the other way around.

Bug looks real to me and this fixes it I think. Give I know this code very little
take this tag with a pinch of salt.

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

>  	}
>  
>  	if (fdt_addr) {
> @@ -334,7 +336,7 @@ efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
>  	efi_free(MAX_FDT_SIZE, *new_fdt_addr);
>  
>  fail:
> -	efi_free(fdt_size, fdt_addr);
> +	efi_free(fdt_size_allocated, fdt_addr);
>  	if (!efi_novamap)
>  		efi_bs_call(free_pool, priv.runtime_map);
>  


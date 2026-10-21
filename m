Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792600405;
	b=P6q2iOgwmRzlELQ7Z9E+w0uDN4UGQQrtVbnmVLYYgzmDE2JF6U8DPDN+6b3UUMC/7+IN
	 MeKtdOMHo4bfiQcCqxW+Um46PQB88Y722VahcMzQfP5eS1hnWc4YM6ISoN9ntVYanJPoa
	 ajutyQ78GkFVU0LWhryz7xsXZpJhNSaKaZi5QnOUdjpI5fNkrrBVa59ZkTsW/U6wv7u4C
	 cxIv+qUF0T8LVqEWg0OarE2Al58ItQ0IGh2hHEZlo8v08HZSHPn3uNKRmk1RQDJnTNMFI
	 /1k+T09cNwmapltai1LPqyM4IYRZT9D6ZyCyoYzKOHfvr1XC0t816sAYcCFAjpCDHIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792600405;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=5S0gFGL7jUhkinHTL4yVeHOzYpusQ3d8V09xofjMzsw=;
	b=JcJuXycR8EETTwxOLM4IswQJStBcVoE9opw/EIjCLiztQTWxa3SNv/cW9J5b1iKi5Re6
	 gxaXjjcMVOEBlZgA7L0GXUCYQCRONstxNlnn7p/CDItcZGlrOe47qui4h554lIGBkltKM
	 J8VJteSEuxmORrgrAaMI9kEnQ3QD6jQPIe2GCXodnVdHFe8qLwqqio7w+TS9dxhR1yZAy
	 umgv0Qz9qmWUh8kKwY7flqV0dzcZyt78d80cuuQLaFRZddySOtlS/+Mcb+x00KPxuNTUx
	 woPK4DzPClUOsOvfCvq65wzqMx+npzUyc4WUn0b5o3Qhw5wMZlCIRldvnYL2fhXUPTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GUi+svDU;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NUmJEvst;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CDA606A323
	for <linux-integrity@vger.kernel.org>; Wed, 21 Oct 2026 16:33:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33CDA606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GUi+svDU;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NUmJEvst
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69LG4BWf2149265
	for <linux-integrity@vger.kernel.org>; Wed, 21 Oct 2026 16:33:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5S0gFGL7jUhkinHTL4yVeHOzYpusQ3d8V09xofjMzsw=; b=GUi+svDU/yyymhsl
	VrHOtB1d73sBGwG7COM52idcWEEDctYMa+eF6Pt4VtlzcUUOeQtAh2n1Vsh/2WQu
	0u2tDuR/jArqfSZjo5WeZDkmKKnq5Cyx8LpPJLaBgJ14HSsFT34pk/oMJnE/QjZP
	wyw5Luv8WVqQT2T3xAGbmx03QPVfE3A+2OotuyjaMF4DqeoByKTYNGCQZF08de+c
	iWVSRHM+0Mr8/oSDoL8AAiVZP7kj7Tx91KaLcsM4HRQSlR0x5UCwgmmD9m+hLCQj
	/j5oJYm/JjLQzfXhoQU6IC244z8l/Pqlkc+kupWm84Z9ZYCfxIBs8ju/HIUwivyK
	DroMWg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf0ke059r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Wed, 21 Oct 2026 16:33:24 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3ac6795617aso798200a91.1
        for <linux-integrity@vger.kernel.org>; Wed, 21 Oct 2026 09:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792600404; x=1793205204; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=5S0gFGL7jUhkinHTL4yVeHOzYpusQ3d8V09xofjMzsw=;
        b=NUmJEvstuVXE/tFZM2esXmuv3658YshInDdySPbrRF3yWviKEdk0fOMWFJAkCexFb1
         /zokv5p0CPry3SeWu3Prxvcmv2qZgDT4IK3A2By04GvL6SdhHDW2H2UBzMWbUMVVF9z0
         k53jxv6Qwt/j+0PrPmrxMtlEmqNG9UCMJBM8X9+esboLh6Xs8PRYprzgsS2w67CGcGjS
         oX+f13kUk+taAl/Klgo+b5SDplOcLjj5kOEK6tONmQ+oLIcUrikm30dMmA+Wt1xcPw8I
         AG6LILRXd4RgRW4JLbJN0sddoSipHTJ/bfNJubKWZfcfcfnyUxQCWLuCLb6wYoCJi8R+
         9rqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792600404; x=1793205204;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5S0gFGL7jUhkinHTL4yVeHOzYpusQ3d8V09xofjMzsw=;
        b=twOZWvewxdMX2Uu1uvdxgJbLuee2D55el7ol6YbdPTLRv4fVHfl/4nQZhNDtF/CiN9
         +8ZCOCfQvr6DAa0hw3GNmQqoeIbY+kQWcm2CdJld8MOFwq7EW7XlwPq6ZvNrVbAOA73/
         SIr646rCAwv3B9Z+K37xuhTHgG6DzT4YsW0sV14u2FyldTpkBzqkLot+vlSx4N2obU/w
         baXBSmzyj9NreYhoUGr/8jDXF0eC4tuR9TC0I6ZUAjhOpA1oOZJNZoFjD3mZZCqugauN
         J7+YZSgEygb04XCmtodMpSysxSQTwmFmR2GmDf8urI/laPPqZqJOEXmRVrHSOG2ol79o
         MiuQ==
X-Forwarded-Encrypted: i=1; AKwUvByR63Nto3UKJWl0JGI7nKZfvd+b8H/Ntj+8z4NdjirkbEanrHrL3YPl6iToGDsk7EiT5q8pPpeG01R+zzko4z0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLsPEu6slE94QLdYIzRWM2n0d6UbWBaZykWmVZW27lLDIoKXPh4
	KLbH3yBJm3qcuLKgKe9yreso56Bo8CcMqjVXbWmFBKw+K8EXR7v/0GQihTNNI9AL9yAkZptWJFt
	AN+NATjT3Fd68QbWhlkCrEFDL13uwFLCTztmPrHCPHL1neybxsR95D4TzjBT5y1KmQWl94ok=
X-Gm-Gg: AYBFou1ZN/GlwiX3ZG1KMkdnfgnHG1kTQaMFcPNKZ/5pFbFIjiwEcFDeD2s8hJWHz3J
	flutcS8J3Bbf79cS7SJEjXE5thaUsb+DJ+/YQ0Xke/Vk4iUohZEguAozO9Rz1ZANEl9UfR83eF/
	la9Xe2+g6VwzCgAr5PcE55m+Wt5eik1XGykM+jz0G0a0hzYb8Bo8l+VUFRbpi7ohZSggof/oD7U
	nX3bxir3boE7VOvhCRmil6acQjoCLCGhTvM5or/cawK7Xt1pxN8r0OvP86VIszpWELVDdR/PqXk
	ZvZ8T88ALA3eoZgta3Kc83gejO+KCvWA3Npc5Q1Stj/sTd916L/lH5Auhuw+Jv7KGi9pDDFch1m
	6i5tsLt3vsvqBW/ldA9EOQjTxmxKodGAJAPqvhNQQzg==
X-Received: by 2002:a17:90b:5688:b0:3ac:b185:fa16 with SMTP id 98e67ed59e1d1-3ad86ef57d3mr2257186a91.43.1792600403629;
        Wed, 21 Oct 2026 09:33:23 -0700 (PDT)
X-Received: by 2002:a17:90b:5688:b0:3ac:b185:fa16 with SMTP id 98e67ed59e1d1-3ad86ef57d3mr2257139a91.43.1792600403107;
        Wed, 21 Oct 2026 09:33:23 -0700 (PDT)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea4005a7c1sm11891595ad.71.2026.10.21.09.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 09:33:22 -0700 (PDT)
Date: Wed, 21 Oct 2026 09:33:16 -0700
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
Subject: Re: [PATCH v2 06/15] efi/zboot: Lift efi_cache_sync_image() from
 efi_zboot_decompress()
Message-ID: <20261021093316.0000594b@oss.qualcomm.com>
In-Reply-To: <6-v2-989a18390eb1+486-arm64_drtm_jgg@nvidia.com>
References: <0-v2-989a18390eb1+486-arm64_drtm_jgg@nvidia.com>
	<6-v2-989a18390eb1+486-arm64_drtm_jgg@nvidia.com>
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
X-Proofpoint-GUID: RxFa1LMVt2dOpCYuk3GeCEngh3rhSN0A
X-Proofpoint-ORIG-GUID: RxFa1LMVt2dOpCYuk3GeCEngh3rhSN0A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA2NSBTYWx0ZWRfXynp+xeG72Mqn
 p3Ndn+667NL7GpAPLHAmfXVXRMSrynRCePrK+FcrML1zK/55vglEJfpqe8pAfTdVvVKLEXqB5OH
 vGWndX6IJXHPMWD86YZtcGYYFtjUQY4=
X-Authority-Analysis: v=2.4 cv=KOzPn1Fo c=1 sm=1 tr=0 ts=6ad8e954 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=Ikd4Dj_1AAAA:8 a=EUspDBNiAAAA:8 a=w7afb6Jpyl5axNu8_tQA:9 a=CjuIK1q_8ugA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA2NSBTYWx0ZWRfX+aQ8n2M1g8Kv
 94vpz0D6WmOcstrGqEZFyMvpscSK76vFbqKMklmM3lrAdrnd3tyNp0efe9gMTPx3xO8xviOVIxM
 pe+cyAA61bsGD9b94CdCXEhr1msrYTPYtf75wisoMO0jpKYc2PZ4mNgzm5Qy/XdkxifclQHWhsO
 gnLIjsFhBQsOa0r1QKibBTtZkSPmZBRrX1eXD1yUcyKzfY07WfpbDFgFny99hOQvNaARiM1it0X
 rp3jXmhcGHtsyipa5NUgf2rtGHagg65cZB0GO8Pl8MRmblr/CidPnzMqxrNxP90MRhaYDWL7ip6
 DvakU82Fpzea8hvjCnG+Fou3R1zCsj41StiqbTzQikDKcW+OcCQG9+f3UvpUbweocH2mK7BF/Ae
 oA42SFy07XByCB7D+ZAu8T/XX7xqgx6OaV7LI+3ZbNSctQn5a30TCDTFBnIqfM3blEngrxcIdeE
 +vGjcCejIM7QjSon87w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210065

On Fri,  2 Oct 2026 20:31:43 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> The two decompressors duplicate this call and the next patch needs to
> change the argument. Hoist it up to remove the duplication.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Some mutterings below, but I couldn't come up with a better code
style, so

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

> diff --git a/drivers/firmware/efi/libstub/zboot.c b/drivers/firmware/efi/libstub/zboot.c
> index 4b76f74c56dae0..e3abaa05fc4183 100644
> --- a/drivers/firmware/efi/libstub/zboot.c
> +++ b/drivers/firmware/efi/libstub/zboot.c
> @@ -92,9 +92,11 @@ efi_zboot_entry(efi_handle_t handle, efi_system_table_t *systab)
>  	}
>  
>  	// Decompress the payload into the newly allocated buffer
> -	status = efi_zboot_decompress((void *)image_base, alloc_size) ?:
> -	         efi_stub_common(handle, image, image_base, cmdline_ptr);
> -
> +	status = efi_zboot_decompress((void *)image_base, alloc_size);
> +	if (status == EFI_SUCCESS) {
> +		efi_cache_sync_image(image_base, alloc_size);
> +		status = efi_stub_common(handle, image, image_base, cmdline_ptr);

A little ugly though less so than original code with that implicit assumption
of EFI_SUCCCESS == 0 that is avoided in most the rest of this code.
__free magic would be complex given the need to provide the size and hence
we are down to a helper.  Ok. Maybe just not worth the effort given how small
the code is.

> +	}
>  	efi_free(alloc_size, image_base);
>  	return status;
>  }


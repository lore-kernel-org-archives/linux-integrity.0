Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792598917;
	b=fiw1rjaQ2/fxAr/SN5jIk/oPHbcq0T1QedPnZB4TRPZk3mPs2mN18Ub3M+0ljmRAbKxa
	 VnBn7ONjvp9IcNdhkt0uCTOxaxSdC/yMR31gGKP1byR/I7HgazVxMMeiKLkpMRA/IUk6+
	 z7jcRLR7CusWKBDNSi47Dl6fytc7FOnNfR4g5nRY25gd9retn1/U+1ohw5xtPwUojxbo/
	 XJUuPcyoVjQAVUlnLWM9/rKDx/Y1FD0jTvwDLGl1gmO1wxNbQpsk/oQr/cFmNljKy9lHv
	 YUp2/x7CWneKmh4sqbfHYoZAU6r0WG/X95wiTWnYM67c4ZMaMZz3zGUsCpc4WdzH5RQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792598917;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=xpcFx5Tgg5MtNBAEwITPf99dESr1dNj5mhlvVGEZ9HE=;
	b=ZQ5ONNFf05iN8ow+JeqMCPuEcLxTts2rnbFrZMp4bx1G7Zor9OykCheDMNMPrRc/Oqtq
	 0LtAI6yWpMr+AjkU9SBUde9F+TM5+IldDO7JmFOTl0CAeFMJEq0QGL0JVj+lnV165pU0n
	 0AVeM8dyJzNd8B0eNaB2sHYk1f0qb6skTCaq+yTXzyY2Ddm9lABBStHTcEe4s6juULXPt
	 fTWW0f8njLoqYHZduJeqLOuhzpqiEfzcGCQ/yEhv0w9+wS3f294+S1Zm5RmVWj+FKanje
	 t71OG6SqGjkGsDkEZpGTVW+27cAEeQDHqS5SgkMMW9XfAC8/1sEb7o+kbQGrmAdxbyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ppsqazaf;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AlgG2yKd;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F20E606A31A
	for <linux-integrity@vger.kernel.org>; Wed, 21 Oct 2026 16:08:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F20E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ppsqazaf;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AlgG2yKd
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69LFU4gh3727088
	for <linux-integrity@vger.kernel.org>; Wed, 21 Oct 2026 16:08:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xpcFx5Tgg5MtNBAEwITPf99dESr1dNj5mhlvVGEZ9HE=; b=ppsqazaf3z/Ovnn1
	SzWOwFC6FBH4fWPIj1FFpw1+MfbxoKTpq3L+dL3Z+e3w7356YZ6RysSOxUSlT+jE
	QJ63VeLe4fC9YoZU8/wWjZGfXODKSBwllcZGiYbUnENdNs5V4JoZtOO0xT0uHd/I
	xWphiIy5SHHmhNox7zwzrK2Vqs+UWLy3gU0nXuyduCWSyhwAtJrrWHEuN+VRgTMm
	hlzoca2KU2LPeFWWVXhGFOSPOe97rBtnG8yGmM71Gq6BNVbN2C1Iwmwrje5lGBva
	VCVasiUkD3EzsCgdmldMxwRAjdIFHG23zVG5vKxeMRaRrlso7XF2npL2q3GBF2Sc
	GdYlJQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hesy79yfc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Wed, 21 Oct 2026 16:08:35 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8a01e2962a1so1139185b3a.2
        for <linux-integrity@vger.kernel.org>; Wed, 21 Oct 2026 09:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792598915; x=1793203715; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=xpcFx5Tgg5MtNBAEwITPf99dESr1dNj5mhlvVGEZ9HE=;
        b=AlgG2yKd9rezGDoVAK8tHC1EbYhTk2vdFncR/cM32rw1R4Kg3pGEJ0vzzMUUx7am2N
         86uFG8yz6c1dkLP+e0mlLOW74Aii11LwnHh6fizV8MJzmvSB9foYSYt7B6+SfKXOmlOU
         Y6Cd4lU5EU+M/yf9x4qe2bkTw4WDOkMAUJHSr6XLAbH8+Y8BH17FStqqZhf/2q8FscJw
         cB+wBWGPasCxLlurN9xiTMFpKGvWaFBONYji6K3D+LV/lFZp1gWdKI7v38J83C01YMr0
         gyz0RChxfsYPVwnpEgXAWOU5LDy9m3J/wYoFEU1tDek9N9ZCBN27nPim2GM+ANVs7qIi
         W2Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792598915; x=1793203715;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xpcFx5Tgg5MtNBAEwITPf99dESr1dNj5mhlvVGEZ9HE=;
        b=X6WcdTZODtnWXK5F93XemRQ+XgEabMaShyO6fWzw/alMDtZkpHDgdYISu/2MaRyd3E
         COi2upYmXt9eZjKwaJfcSinW9TPpD0sW3BRDrCo6kYRkak6IKyG83I9butxAJxM+5f3L
         U/XO1/xov2sIqfj9rIXBt0K5EJCKe29J8E96t9ACwognLj1DjGgrLthtejElJfTsEYfE
         FJR2lNOWBVInRS+ABO2rfuDv0ZmJyxO2Ud50LAvKwXvoUtRvFIXc47hxFTCiJUV9isTO
         SCJJoZnup7q1V6ncb91pLIlqG/2jl0ZE4QUeny4J2bgzvLdrfnCmzvgPfFFBjJhZqzm7
         jFKw==
X-Forwarded-Encrypted: i=1; AKwUvBwnrVnKUAYDxNf9W7TBlBUHLFUwEIVn+/mmfSTUESGFwnfyjA/yNIgkUuyLrqS8zTDVclE3btDcQmZ2hiU2pfg=@vger.kernel.org
X-Gm-Message-State: AFq9FYIboghZtr4pIS7D3XjVzQkmG4CYWZjw/WvX8x6Zaer4sYl3t7MR
	aAnKfqn9eKSlQy/t8R7y/h3ARPgNBfVLXsI5sgIDkONVNNcOJrABSdNxFs3J/z/uxwAIDxg9Ddf
	hBkxZpMLfVSIlP7T2nhxk1wNjlp+2PrpZkp4DOya565NQ/pY76n9Z0dZi2WJymh/Hdvwr+Rk=
X-Gm-Gg: AYBFou3j05stEisCBR3mZnKFhLPueRVzszbBLxgxK+9IxEmI4U7JKfUdA8B5I5htppa
	2fr9TdWBmpIq3Bqji51Ji9hG5Fb5OS8CRZn1Yo1c1L4Mv16MBz/yxeMsqMNxzLvA+aBQDuF3SJ9
	z+/webDXXFYtu5NbcJCUjDDVKIRu4qktz88y9cjCIb2njQtwo9f3Ha++g7Zr5YxkWXiYCGZCXT4
	++KtNZh3j55KsyXQ4CAV0bXcYMJL7CfEEaRwgBM4t0VrSE0KPi7aTdYBvIX4lmc2E39ZPfeHR4t
	+fh1sZiwAUSxYvvFuZYPWkHKADVr9MWD2UOutigR/wBmXJqeMSPEynlKcUdNzvOboZuulS9Tx9T
	bGKd8bLMTx9eS7gw5Gl0c23G37H6dzpamcKwTEXQVOw==
X-Received: by 2002:a05:6a21:3288:b0:3e2:2b76:bf23 with SMTP id adf61e73a8af0-3e287eda189mr2084261637.68.1792598914766;
        Wed, 21 Oct 2026 09:08:34 -0700 (PDT)
X-Received: by 2002:a05:6a21:3288:b0:3e2:2b76:bf23 with SMTP id adf61e73a8af0-3e287eda189mr2084221637.68.1792598914240;
        Wed, 21 Oct 2026 09:08:34 -0700 (PDT)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd6b861c7dfsm188964a12.25.2026.10.21.09.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 09:08:33 -0700 (PDT)
Date: Wed, 21 Oct 2026 09:08:27 -0700
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
Subject: Re: [PATCH v2 03/15] efi/libstub: Free cmdline_ptr in efi_pe_entry
Message-ID: <20261021090827.000078b8@oss.qualcomm.com>
In-Reply-To: <3-v2-989a18390eb1+486-arm64_drtm_jgg@nvidia.com>
References: <0-v2-989a18390eb1+486-arm64_drtm_jgg@nvidia.com>
	<3-v2-989a18390eb1+486-arm64_drtm_jgg@nvidia.com>
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
X-Proofpoint-GUID: bgmccoF8TMAot6HM5m982rasslZjFhOA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA2NCBTYWx0ZWRfX3VRwkFi9EbLH
 zEaAaZjOa0AvqAdcMLKC5Tzz2hHxeiu46/QSK9jQ844tKPF2QvV44u/9cQRxMEfxzaFghQvXpen
 ZaDln8Itf5fOhp5+qJH0x8Ss83U+QrvFIngfs4svwsJAfp8ACojKZ50ELRWgUxDAyzD680O60hj
 n8PonZw2BU8YFRkQsHAeL7+k+dH7DwWOudbizoxle13zi/vSmQFXK7e0TuFOf5lDATnjcggaL7X
 RI3/kfki1WplY4vq486FfZDSp7+J94TNWir6SntTI6WlE5Gtd8dDv18IcWv/iM2yzWPbcnJfYrJ
 ftYzevSOkF+D+1NqOf5wWMuWiEFzCm4M+v+T6np1wjFoiuiUC+w59UfyksmuJsWwz3HdZ+9S72x
 PCih0CSsPAQChKyescOzR6eezCkUBWD7yEsr2x+NFf/SMDS4xMrc873hchikxA0HxsOGORu+EYU
 od+sCs5p0HlL6rA+hcg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA2NCBTYWx0ZWRfX2jBNngbG50Z/
 nt2QcSv6loeGVGqcH9+vwlRlL7UZsCfqXNhYdgO9GUzFt3P3PSV/n7Gw87i322DaTeNvSQDkfeV
 oJ0Uaj3z83SmP/D8RfRc0CzkYNPLQtE=
X-Proofpoint-ORIG-GUID: bgmccoF8TMAot6HM5m982rasslZjFhOA
X-Authority-Analysis: v=2.4 cv=IPaXmQvG c=1 sm=1 tr=0 ts=6ad8e383 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=Ikd4Dj_1AAAA:8 a=EUspDBNiAAAA:8 a=gCM90IwNaqpJe8xd-nwA:9 a=CjuIK1q_8ugA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210064

On Fri,  2 Oct 2026 20:31:40 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> Sashiko points out that efi_handle_cmdline() allocates this memory and
> hands it over to the caller. If efi_pe_entry() ever returns it should be
> freed. Add a __free annotation.
> 
> Fixes: 42c8ea3dca09 ("efi: libstub: Factor out EFI stub entrypoint into separate file")
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Seems sensible. 

If anyone has more time than either of us, I note the efi_handle_cmdline()
use of __free() should move down to the point of allocation.
It's only a couple of lines, but none the less...

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

> ---
>  drivers/firmware/efi/libstub/efi-stub-entry.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/efi/libstub/efi-stub-entry.c b/drivers/firmware/efi/libstub/efi-stub-entry.c
> index aa85e910fe595e..fc1282fb442e71 100644
> --- a/drivers/firmware/efi/libstub/efi-stub-entry.c
> +++ b/drivers/firmware/efi/libstub/efi-stub-entry.c
> @@ -40,7 +40,6 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
>  	unsigned long image_addr;
>  	unsigned long image_size = 0;
>  	/* addr/point and size pairs for memory management*/
> -	char *cmdline_ptr = NULL;
>  	efi_guid_t loaded_image_proto = LOADED_IMAGE_PROTOCOL_GUID;
>  	unsigned long reserve_addr = 0;
>  	unsigned long reserve_size = 0;
> @@ -63,6 +62,7 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
>  		return status;
>  	}
>  
> +	char *cmdline_ptr __free(efi_pool) = NULL;
>  	status = efi_handle_cmdline(image, &cmdline_ptr);
>  	if (status != EFI_SUCCESS)
>  		return status;


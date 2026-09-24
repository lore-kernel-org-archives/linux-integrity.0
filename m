Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F43F41D641
	for <linux-integrity@vger.kernel.org>; Thu, 24 Sep 2026 22:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790290149; cv=none; b=pe5j7ZdF9runWWa5q1Ayq9x6ALPgUl0/FFup4cAb2agcrBjhIKjPuJdyYLKmPpvjEIn6dVHYk+/cPeHx3gUNJ9GqQzVicISInqLwiXB9NpOpxbqoqkAf/2KME7AH3wjuuF2R9qoPOdOlIUQA27FQGkXRSIU4xHLfXqwQizOtCeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790290149; c=relaxed/simple;
	bh=EsE+bP4ImbF198tRF/p/BEO5nlCx3+LrGeUaFu0gIWU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m6M73dLVNpAcZs1Fa+CrPRKhS6f/wjom3rXt21+YXf0LUmF5egU4Ui9OfdUtFB1OEhMLEume7vZagxJc/MjEYe5eWg3695Rdzz3tGTyT3U7EilG85UrYTwJaFwhxewzLbh8Zy1yTDJlpjjOOQsWITUOcqbO2zXIATCk2cXsuCQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UnwyqbzY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TE/W4E2Y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UnwyqbzY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TE/W4E2Y"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68OMPjNj2971167
	for <linux-integrity@vger.kernel.org>; Thu, 24 Sep 2026 22:49:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oo8YGRfyp+kAVxf53tgrQWeKF/gkFQ1vpq3RnEKr7OY=; b=UnwyqbzYYs+KvHQI
	pdaCx1jtw5ZY0g35b3TDHY1cZfUiyOOybRzb2dGrJpMmxlONRNVSQrHCIK6+AoC7
	QnvuyVkfsbutTtg/yDMfBQUkcTg+g9F3yaain8P0Plp1XMrZxMEFtivmZwU0CQSe
	ofHBo1aKp2Fj7gieTJXChc0guhXjz78g5/YQm8yV6jdF4DVlAjn/ZKGezuK1U1zf
	EgGFGjtO6diq8oxU1+jfEQZtkOeEUAA1QQjM+IUboDFRrPF9yqUpJATk3M3VjNOY
	A8FRKURil3a5aaVAiLtj8asDhAlxSaEDtDqf0iqQI5xndVjM8Dveu39DfcoA+QTX
	4xyL3w==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw68e1srt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Thu, 24 Sep 2026 22:49:07 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-33713e5e6daso410321eec.0
        for <linux-integrity@vger.kernel.org>; Thu, 24 Sep 2026 15:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790290147; x=1790894947; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=oo8YGRfyp+kAVxf53tgrQWeKF/gkFQ1vpq3RnEKr7OY=;
        b=TE/W4E2YA7DdQDjtoKa9Ohy5kUi+xAKvSnseMcMtfdSdbuoPntoIv73orzyxWN4IuC
         2oePRdpPasRiq6vVsCfUbvmsX2alW+qlKKX0UKAX89xkaWkb0KhGwesg2bQuV15mUiZV
         U2KpG4683JUoUkaXslkWhxiLu2r2Lh1CUKo+LPzK756B6CRK28mQsWOX4r5+PV3v73zw
         sI25zXrD+7mkZw05ruaX+DWfies/8zF5Pgr72KoohmGqNLICIVEvNz0tLj85efg6EmvC
         CiYpSFon1t0TmqgQxUDzlKxZ/q/X30MN8Zgc5bl05DNJYB2dvA8lm0jlnRGzcFXobNGl
         XvaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790290147; x=1790894947;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oo8YGRfyp+kAVxf53tgrQWeKF/gkFQ1vpq3RnEKr7OY=;
        b=VNnAvE+lM7HeOQdPcVV2wn+Hq4aH/YOa8OXoWS1kj3sC8F1QuE4ajiOtR3dJTz4gOy
         UeBeRBRvTztZqB57gUsPfiGtO8biGmjNaEy6KgsQLDQbBn7uVxGMvwxuMR/1YoJkQAzM
         z8luQNZpGvV2rtZvskZ9c0YEJotPYrNfPrZ+5FguPlizPUsmsO2uXfRne3BIq3xj1DDI
         V+ztYAk6eQa24ZlBOOOhPgdGwpghty+BAoeUYW0NtoMQk/zyIGa00U7WJEgaDuYOH+8e
         k+MfaIf1UOvinrHWUaQPLdq4QCZjMuCB1ep4W3dn5hKWpfePrB87HQ5ffD6Vx4gMLLl+
         mFqQ==
X-Forwarded-Encrypted: i=1; AKwUvByVydpC2OzZE91T5czA00scw1c84g8NHm6e3n0wGLwgoaFLB1yiVBKDIS/0Isb983dbMUwWhyEN6OP8cFxKDr0=@vger.kernel.org
X-Gm-Message-State: AFuF++kX9F4ggwjm+92Jn4J6RFmJlPRQjYG+brDPxDHINrDrKHSB5zzl
	W1mX4Nex6xop+lCwt5JGG6X8ltEHhSMX3gt7i29zrGCp0HkNmaVwwMi4smQ6waZ8tq15u9CiOT0
	OCJ1W8pQYkCGWkVivqXKN0lGPHDf8CQMTKrE9rLktMSjq1ZHEoFLpv4J59a6oocacRM1jwf0=
X-Gm-Gg: AYBFou0BnLZTe+HcNbabibmJ2QIxYeUpgNX5lHaEB0561ukT73ekdtGG/VlXmaV+Tko
	kpmEA8dWHwx2mCnvUffhpHUvNzLXEE4bVQKuyb8H5yTcY+SKlYcSnv+LKnFRw+O8t1aIyCjQSPc
	V6MUEn4/m63tQ7QcCMV9JzSi71Y8O8hCYdsMpk5kaoZmFSTxTdfaQxRhPeAkPYbeliE+IoHePOQ
	LLEz9OTJLRXfy4OY9G7KXxwGDvMaZqcIZOl4WPpdWhttpMyTxBhKoeIbwHlfvHujDBWMaXIv8pQ
	10jyFUCESGjSBRSVSgJlaHynQFLlK9hzFj7ECkacSUkkn8tr2DQBfxGO7AjkX/Er376D9dcGmmr
	6IdI9zqUAI8fAxkNsX3P5IU2msjAPyQ8lAJ+M7ykNjCTXgOQvam6kCg==
X-Received: by 2002:a05:7301:8614:b0:33b:dcbc:6046 with SMTP id 5a478bee46e88-33ffe341a5fmr3054528eec.7.1790290146760;
        Thu, 24 Sep 2026 15:49:06 -0700 (PDT)
X-Received: by 2002:a05:7301:8614:b0:33b:dcbc:6046 with SMTP id 5a478bee46e88-33ffe341a5fmr3054509eec.7.1790290146115;
        Thu, 24 Sep 2026 15:49:06 -0700 (PDT)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3414407d18fsm1417100eec.10.2026.09.24.15.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 15:49:05 -0700 (PDT)
Date: Thu, 24 Sep 2026 15:49:02 -0700
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
Subject: Re: [PATCH 03/16] efi/libstub: Free cmdline_ptr in efi_pe_entry
Message-ID: <20260924154902.0000528b@oss.qualcomm.com>
In-Reply-To: <3-v1-27d06b313981+8b-arm64_drtm_jgg@nvidia.com>
References: <0-v1-27d06b313981+8b-arm64_drtm_jgg@nvidia.com>
	<3-v1-27d06b313981+8b-arm64_drtm_jgg@nvidia.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA5MyBTYWx0ZWRfX2tSd1DTB4Sj3
 IsIQNKijTFHzpNiyLrsly0hrov2tNdE+V2WRFoyTEltwUeJR7DWlMqaVre/F10/GwcpGV/nm8B1
 2QpiePQfPq89PXLRBCLKwceqp5gAjhyHdIHn5M8EETji+d68RDZEiaje2x4FeYV//UoCGRALc4V
 qANuQcT94pIrmY9ZfSBZJppO4LGqIcefRsDo415v0srsd2Hip42zp1cbBn1HNYsegKd/2j+nMTE
 wcu06ay0H/ywEwLMh5kdyseD1ovChFuTPuyf48HW5n4jhIxxYJjQLeHkVhqSov8vNT2A6/h99So
 s/cKkCw4gu4X9wlCdGGZs0L+2HBZ4JSPWnbNEkLu3YoEyUrW8bP8VFu7WxKt/6Uik//B6NeGtmC
 mh2qYzMzeUtDivXvp5YEy/T4smYepLYn+34Mo5lC0lWCxWnL9rqyq2dtJiLWtQBIMZhatKFTOe6
 RUBQnUO6o3bEB/kkoUg==
X-Proofpoint-GUID: ZC-FbyWIajZINBNliumSAVWoholI0xm-
X-Proofpoint-ORIG-GUID: ZC-FbyWIajZINBNliumSAVWoholI0xm-
X-Authority-Analysis: v=2.4 cv=XawcX455 c=1 sm=1 tr=0 ts=6ab5a8e3 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=Ikd4Dj_1AAAA:8 a=xhtQj0KKqAk-GveBB2QA:9 a=CjuIK1q_8ugA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA5MyBTYWx0ZWRfXwj87KSRWI5bt
 vTYrhWbmvD6iVZAHeJ5WWbrLAAyLOhvYrWsVZbTthM/oMYUoR9XJ91Ki/hbivLlfMy0kw+fQi/R
 ZIMonpAxgK0lATYn2iP3EkLeyoG1eHI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 impostorscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609240093

On Thu, 24 Sep 2026 10:53:06 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> Sashiko points out that efi_handle_cmdline() allocates this memory and
> hands it over to the caller. If efi_pe_entry() ever returns it should be
> freed. Add a __free annotation.
> 
> Fixes: 42c8ea3dca09 ("efi: libstub: Factor out EFI stub entrypoint into separate file")
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/firmware/efi/libstub/efi-stub-entry.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/efi/libstub/efi-stub-entry.c b/drivers/firmware/efi/libstub/efi-stub-entry.c
> index aa85e910fe595e..83fade2b0d3b84 100644
> --- a/drivers/firmware/efi/libstub/efi-stub-entry.c
> +++ b/drivers/firmware/efi/libstub/efi-stub-entry.c
> @@ -40,7 +40,7 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
>  	unsigned long image_addr;
>  	unsigned long image_size = 0;
>  	/* addr/point and size pairs for memory management*/
> -	char *cmdline_ptr = NULL;
> +	char *cmdline_ptr __free(efi_pool) = NULL;

Can we move this down to just above the call to efi_handle_cmdline that
does the constructor side of this?

I see none of the efi stuff follow those guidance note that went in cleanup.h.

Ah well, not my problem :)

J

>  	efi_guid_t loaded_image_proto = LOADED_IMAGE_PROTOCOL_GUID;
>  	unsigned long reserve_addr = 0;
>  	unsigned long reserve_size = 0;


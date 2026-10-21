Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792599395;
	b=Mbg4Cl8ZeAtgLzlTyBwAjocbd3gqdHJnqbXPuZWK0/v77zGXatjER4W227IQHlt/KSF1
	 SYXv35m4XyUJNPmtk56Um9JUE4L4LiJlRV53MJKJO/eTiYlqcF8QTKuZUn6/8GtOAHCua
	 FfsUajEHR5e/tgMqm3OE7xHK6XGDVhbRWqFLmSx8ZzbrQtjwdJkpD6CcnCxOBYoMlJBem
	 /UbKblTLg/ccrd6uFBlbQqYbPLHo0GuwQfRsmANmp4xvC9frLbvKObKkP76b31etw0SNt
	 LrjoYMBy7JAw5oEuiUcIYneC6DK5wLtgS0K669tRRqp3S9ADz0+HIbwaev6WVNzK58Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792599395;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=9hWqXEuq9iUvICKJmtCYJXRTGUsjg4czRSsoSn+YADM=;
	b=1lst/GD7PT+EfQwqeVhT7FoVRVnNSu82e3tnQ1J6kvhztJm2M+548+9EG8j8TETJNYjM
	 i2bkJSNNtZZHGzjBTng6PP9gDQEmhrgBEVIoMJElSPha0PbWxtbyGzA9+K2HhRlAd7kc/
	 p1xHDPjiqcvjJJplq7jke78JOt42eT/d8xbF7LmE46FEqARFFKn7vzulilPM7Ml0vdTjP
	 LWpiu+yA6OB50qpS7jAuh+C/bdDPE3EiCHBgho0aYjYytOkclZ4QYtN8VfusFk2kVFBvi
	 FWDjSSgyI4qzN8IcMuZFy95VygQPpj42EErnrWFXS2slpe3Tp1HQaDeTSOJ9d8+K3Vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=i9+3PrHW;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HnlJbmWx;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF75606A578
	for <linux-integrity@vger.kernel.org>; Wed, 21 Oct 2026 16:16:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BF75606A578
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=i9+3PrHW;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HnlJbmWx
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69LFoBID524209
	for <linux-integrity@vger.kernel.org>; Wed, 21 Oct 2026 16:16:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9hWqXEuq9iUvICKJmtCYJXRTGUsjg4czRSsoSn+YADM=; b=i9+3PrHWHdY9KcEx
	Rkizp5TA6LO3x6JHCBfisbZ0xVIII/InNbBxuEouoj5Gl5TOhuvbQWrw8eL06u4X
	qiHRcvAhNmVYdbjfFVOwPWC3tQY0bR5kWrXLzQ6N++TpSf/0W4Z9TASh0cWZS0a4
	Xr9AZ/sJJsXeg1+6ffdBlzPEUJbhqfq/9wHvJh7xsRqxJSeMNgDYFH12igwOZIPc
	9Ae4kXTrb8SAFEmNoQRNByJbkPWjKBdcjRrRz6EVRgeBw92KcZMZBQC+kZVat+X1
	ZWlx2gub9lucHtn0mdnHsO852q/e0aPYuMDdx068yiGnUphUu4BvJDEy1BXUn9xg
	8ukbIQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf0cv03w5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Wed, 21 Oct 2026 16:16:33 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cd0e92d64a1so3251a12.1
        for <linux-integrity@vger.kernel.org>; Wed, 21 Oct 2026 09:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792599393; x=1793204193; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=9hWqXEuq9iUvICKJmtCYJXRTGUsjg4czRSsoSn+YADM=;
        b=HnlJbmWxheT2gXIIjcxthAC/H1+57UtsxmUxyx+vccU9Ep3I9hxpJXeWGHordJbqWu
         mxrJNr1Qjrz+GPYJhwC543D/FR/xWwBeMhtMNPU2oYRyGY65Ves5ed1yTzwT58zruClh
         e1biPaX9kRMaKlncicouX1Q3sUh1I8ETUPNMehINjSDX2ofI8gI7Ytc4R0PGEv/DhgxM
         WDjyeDA6Ox5vIp4TKjrb6Fam6OaEAfF9uPr2wumCyuHYre0Wl1XGa1Y/chTGb1kExVZI
         yDk664y1iTShBv59Jaz4slCuc/SnbLQDoqcqN9cdsXscy4GHBydOwxDDZTqqQYUu62GO
         eHJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792599393; x=1793204193;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9hWqXEuq9iUvICKJmtCYJXRTGUsjg4czRSsoSn+YADM=;
        b=e8yeoX0gCMxnGYkfmEjCdgPp3b1xAVp4Kkby7J7CicmBq9ogZiMz19VorsPPpTwnog
         256qUm3hhv6THJ1zZ/RSFhCtsbcVnZ/TQAbETc1NxzPuuCxm7z2AUr36Rjbo3TlZ/RJi
         PL7ePQlpxkxL9CIpNHLRIY7e9iFt2MJDuNh+0C04wuROiciVFNeUe3rEqRUefe+YYdAK
         uG6jNpuzUWUbX8oQK1kWHs90zuEedPMm09U1Ujfen59/AdGcZYxBc/AOc5Hksg/9fpfQ
         Q8sx1IweaGAxst05+/ybg3EBIa9FK9yM/g0pTkW9q6X72/AIB5uRX7JTv0zQHrdydtiR
         ydPw==
X-Forwarded-Encrypted: i=1; AKwUvBzt7iEx7biu34b16FgxU2ClcMynpLNjEBQvUXC3EwtQNCggnfgUQjMDzuCko53hMijF3jN3zJMNiZyPLU1mW84=@vger.kernel.org
X-Gm-Message-State: AFq9FYLI5nnJg9qYJJgbxsJx8a/NtX+AXbGLP27CIcImoyCjd30T2n3o
	7n57qtjpw00ymTHv4qPl1fkBWq0gC8ZrwmOTc/UCjB30C3GTE6sTgfYXWmeM/X9B+LMOtrmYdVy
	lEq39MwWR6eWOPkI13AGftozT5DoTGMLi6A/qAtHmKR+eYWnEWv4Zbuj/04vnGPvL3IENWAU=
X-Gm-Gg: AYBFou3RZfyhV7Gqaz0/4rkLFiHgEVkiAlwdrYJ5bv65tEhF9MP0GC5roscKkHQ0Bzd
	NpHrCXsdVEHqe/q7FQyu4JB6NJVPJwLyeHBaEw8e8O61vCDgPAijfepFnBGLq51/57dRZBbwSLt
	0JfTsajQMUGbUZ6r/4cYGWsLvhd7AhTWEFf8cGGYtHdei6tI8hWgp2nR0/auLGV8+Zu3zhscRKE
	CUS74V7VxFD71fHPpcLZj04FEcCHp5e8V82Ocl5G1pnqud1JEaqANiUJz2ILcwYrkprik+H8UB6
	O6oq8/AjAIim99Fi3JU0bxBUeR1L/8+PJ93+xtR43QEZ2V2+j2lSU9+EdHFWWZLep8NUbN3ecK4
	75dxHoGZ0bBVYWnpJKj2we4CkfRnjkojnwr2+LPQqXg==
X-Received: by 2002:a05:6a20:2f98:b0:3e2:6653:149c with SMTP id adf61e73a8af0-3e26fc04d39mr3512958637.10.1792599392905;
        Wed, 21 Oct 2026 09:16:32 -0700 (PDT)
X-Received: by 2002:a05:6a20:2f98:b0:3e2:6653:149c with SMTP id adf61e73a8af0-3e26fc04d39mr3512915637.10.1792599392315;
        Wed, 21 Oct 2026 09:16:32 -0700 (PDT)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd6b84b6b17sm205866a12.13.2026.10.21.09.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 09:16:31 -0700 (PDT)
Date: Wed, 21 Oct 2026 09:16:25 -0700
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
Subject: Re: [PATCH v2 04/15] efi/libstub: Add a general way to get symbols
 from the vmlinux into zboot
Message-ID: <20261021091625.0000515e@oss.qualcomm.com>
In-Reply-To: <4-v2-989a18390eb1+486-arm64_drtm_jgg@nvidia.com>
References: <0-v2-989a18390eb1+486-arm64_drtm_jgg@nvidia.com>
	<4-v2-989a18390eb1+486-arm64_drtm_jgg@nvidia.com>
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
X-Authority-Analysis: v=2.4 cv=NrRE4MdJ c=1 sm=1 tr=0 ts=6ad8e561 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=ah4THgOBrJhmsRMU:21 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=Ikd4Dj_1AAAA:8 a=_GvItbcUg7J-DuPKX2oA:9 a=CjuIK1q_8ugA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: u19kHNzQMsg4-h_BysmvQFuMgYChC6AF
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA2NCBTYWx0ZWRfX0fWFoj6nf71F
 qHjNUyX7toJpV2tMbp7DkpMTkWgAepzXnq45nbI3Gq0JMohoOJt3w8+gT9d/xwlzbYWF/pQFRwN
 F77Zgmle4k33JbQFdYlGfL30cA16mf4=
X-Proofpoint-GUID: u19kHNzQMsg4-h_BysmvQFuMgYChC6AF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA2NCBTYWx0ZWRfX0f4KBHF0ZrYw
 BYuAQrxUPLUpH43Ta5sZSLFWwixl8RME5Ay10LPLS2OP/5Q9HP5b0zIQPVM6aLQoj5FkzPbH/+M
 alwn+cMW8uZ1fm+G6dxLwCLex1Ho7IzjdM2oCUzQlmk2UXFg2sA5V7N8TZxwvs0yTT/tuVcM0B5
 ze6fERzPgZxpV+uzubsWf0vYTFvPWYXuetLFeyNG27wrTKmeXkS169G+exSuHnltGGeokJ5y7o8
 I0Q9AKfxaNYmJr0fLpGLquEkwAqgvzsjqc/Vf4Ua+Rf0OrOvQMyuLcykMgmTXvAAjyQXmU37wxo
 PE/6vnngETs2x1O2fRJXn5f+GHT5xW08mgFDVyNDwYQFMty6aPe0CZePLeT1Kmvs+WCHXK9aPeb
 IIl8bA59T5CCidnh6b9MvReSXBEuoHxPlMfvaUPmBrquFsjH54H48aUN9Yi5i3e5rAENNqJ3nkj
 jUxa7F3kW/g+uiMEewQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210064

On Fri,  2 Oct 2026 20:31:41 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> Currently the zboot stub has no access to symbols in the vmlinux. In
> contrast x86 has a voffsets.h header that allows the stub to know whatever
> symbols it wants for the decompressed image. ARM DRTM needs another 4
> symbol locations to work, and it also wants to compile the DRTM libstub
> code once and have it work in both zboot and embedded.
> 
> The current solution in arm is "code_size" from commit 45dd403da851
> ("efi/zboot: arm64: Inject kernel code size symbol into the zboot
> payload"). This is neat, but it makes the zboot and embedded cases
> work differently.

Not a real review as linker fun is not my forte.  So just some
trivial formatting comments.


> 
> The x86 voffsets.h approach is also nice, but it can only work in zboot
> since it relies on 'nm vmlinux' to extract the locations. That's a
> circular dependency for the embedded stub.
> 
> One idea that meets the requirements is to embed a struct of offsets
> inside the vmlinux and then have both stubs know its offset from the start
> of the image.
> 
> First, each arch defines what information it wants the stub to have in a
> struct:
> 
>        struct efi_image_info {
> 	       __le64 code_size;
>        };
> 
> Second, it populates the struct with the linker:
> 
>        EFI_IMAGE_INFO(
> 	       /* code_size */
> 	       EFI_IMAGE_INFO_OFFSET(__inittext_end)
>        )
> 
> This approach with the linker is guaranteed to emit a value and not a
> relocation. I looked at writing the struct initializer in C, but that can
> result in relocations inside the struct. That seemed sketchy so I stuck
> with a linker script approach.
> 
> Finally, any stub code, either in zboot or embedded can access the struct
> through:
> 
>   const struct efi_image_info *efi_get_image_info(unsigned long image_base);
> 
> The makefiles arrange that both links have a "u64 __efi_image_info_offset"
> symbol that contains the value. For vmlinux this links to a symbol created
> by the EFI_IMAGE_INFO() macro, for zboot it uses the same technique as
> code_size through the zboot.lds.
> 
> Since this needs arch changes, protect it under
> CONFIG_EFI_STUB_IMAGE_INFO. The arch should define the struct and use the

Odd line wrap as moving the CONFIG up a line is still shorter than some of
the lines above.

> linker macro before enabling that config.
> 
> Since everything is linked together, and the actual location of the struct
> is not fixed, this is all private within the kernel build and can't become
> ABI to any bootloader.
> 
> As some follow-up work, it seems interesting to standardize on this
> mechanism and remove the PROVIDE() and voffset.h alternatives. This would
> also avoid needing to pass sysfb_primary_display through EFI from zboot,
> for example.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>


> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index b2988aa12f6645..4dd52ddb148401 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -83,6 +83,44 @@
>  #define RO_EXCEPTION_TABLE
>  #endif
>  
> +/*
> + * Architecture specific information made available to the EFI stub, see
> + * CONFIG_EFI_STUB_IMAGE_INFO. The architecture describes the data with a
> + * struct efi_image_info in its asm/image.h and emits the matching bytes here
> + * through contents, using linker expressions the compiler cannot compute.
> + *
> + * Place in the same section as INIT_DATA.
> + *
> + * The architecture must also define EFI_IMAGE_INFO_SIZE to sizeof(struct
> + * efi_image_info), and that definition has to be visible to the linker script

I'd wrap this to have the whole sizeof() on one line line.

> + * before this macro is used. Keeping the two in sync is checked by a
> + * static_assert() next to the struct and by the ASSERT() below.
> + *
> + * The struct's offset from _text is emitted as a u64 at
> + * __efi_image_info_offset. The architecture aliases this location to
> + * __efistub_efi_image_info_offset for the embedded stub. The absolute
> + * _efi_image_info_offset_value contains the offset itself; Makefile.zboot
> + * extracts it with nm and zboot.lds emits it for the compressed image.
> + */

>  


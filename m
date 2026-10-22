Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792629106;
	b=ssUGswhuXyfQoDGHBS4dFpdpCwlhl3cQcwcn/q5pXx2AyznogriHTWbrQ70dVpXeXiCC
	 G7QpQJ3agd6Jd7r34yGkD0RDaBaXMWqjVfcKctE9Ptxkb6r+mlvtkG0kB5XYAIEama8iS
	 EToPlvGP2c+47/FYSapS4dM2Z7tPE9RgIxkAuBt/BVXM2ceCo/qC3KgTxJCkGGf8pUuxs
	 f0HGDPWRElACFn1XhXPOsK4P7XTxKASYXrrVmEaKUg8SyzU+Qcv9r91dQDv0khJVdFo5u
	 IrWpxK2qK9wha6dpatJ4twRVlpZf2lmIzx0bonZhUB9VyppJSunkQ0gcssRYQ8aL7dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792629106;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=H/opNow+kHytu3G/NcD0sUoEO+o11bnVvWNwj42+U14=;
	b=PdetSo49d5hqaHLYQK3R71VAE3Foa166d2LfgescK9pjEVlzTNwhnNLUHVy2mJ2+8CN9
	 2RXRr/Z8NjWnOT5YxH/xC5UYM9Eq20ucdEfPX7/oxMnpQxfkCpdIgpK+8p+gBozCW7+CX
	 3KWU5xa0ZNG/sT2Clf7RK4HunKwWy/MBfn5UdpqT+yXP/y+JxwXFbc4m7SoZD0LmO0H9R
	 hlAn1N5glhleHQTmYRNOvf3jBNdJK4A493DBxxSahbbQPpo/o2jteJzyUtpFo9jNGuYaZ
	 NZxiw/7eO8csVS8io5t/yniIGEkJQcLzs5qjRFhJyrJNJYrHmYjlt4gAReeXGeGB+qQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CKTmObd9;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BJLbtas3;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D52606A31B
	for <linux-integrity@vger.kernel.org>; Thu, 22 Oct 2026 00:31:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33D52606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CKTmObd9;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BJLbtas3
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69LKe9lY1722471
	for <linux-integrity@vger.kernel.org>; Thu, 22 Oct 2026 00:31:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	H/opNow+kHytu3G/NcD0sUoEO+o11bnVvWNwj42+U14=; b=CKTmObd9EYBRD8Es
	JW8RP6hHE2nV/jriTWLFK4Tj07MD2YQ/d+k3krx0ltsunPU1Cqkd265kNM9yKAU3
	GEnCNnmIZVqdzmOaFvqwUFGMkR3jhOrDwVbvYrdhKxx40y/3PqS6OEdz4Y1mzA5r
	nc8kaRtBDStzSfIldolLvF/dk667tyPSl7AI/LeWGSrXbgSZl2mpo3K30Ew21v2d
	6hYLTLvPXuNcUx8Ous6bX1zJ4wVog4riLz0NNXpV98/XnWjGQDy4Iramm7tFASVm
	hQQeeHZq2uT1zz50gd3ihZtkQZ1hZa24QON53S/ZDK8f4lAV6Lzg3Nt099ldullS
	qho3Mw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hetj4berf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Thu, 22 Oct 2026 00:31:45 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-35c902e0da2so491704eec.1
        for <linux-integrity@vger.kernel.org>; Wed, 21 Oct 2026 17:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792629105; x=1793233905; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=H/opNow+kHytu3G/NcD0sUoEO+o11bnVvWNwj42+U14=;
        b=BJLbtas3WiTC6waWhgjBmGpy+nI14/5zPCjcXpDPSk7e+jtXoCiTpt03tXxIfPsW4s
         9oy/phuFShedWgE7isVYgCJaBy9Rm9rBruByH5kbnwELxECLPupNNKoxrZEdWdsxyWT/
         v4ZflTF4oXu6ehCAfpt1KYoEV5NacAPlt8hK/AJgHVtZYUTvL/92bHz5b8mODLOffSw+
         86+vi9goRPV6iFCIHEUJRCI+cK0YVbzfqunLmJfryEu9PKq/4ww+REWFd56EqPXhWMJt
         /w47lkYTbaVnxoWCzycvWcDQXridcvswPmbdO7VEB9HI+uEhxjHEE7hC2gBHXrBM6jtP
         dYrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792629105; x=1793233905;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H/opNow+kHytu3G/NcD0sUoEO+o11bnVvWNwj42+U14=;
        b=odQH5hLn5S/fRjHgBfv+MMOI/cphnF9UlX4faZarTQa9o8jjflzERLf4PMU/+vwk1z
         a56Fz/3mao03ecJ9kePJyCkSUhGpS9eG+MtmTtE+7aZe+8+D27JoU3j24f071WXq9Ydj
         0XQWUMdD3QsCofxLVJMj7WuVFZJ8MwFwTwEKNlouAXYEHOSDCzOLke8maL0oO11mQizu
         /sm63Mg6BBFEy7SVeTnn+na94hJwMU6+My5raPw/UlWEU/Fhd1FL8vG6l3fNG631SvJV
         SBj0IwKUyF0QeEHKIjMwWjPyD1KnOcJ5mGMyDmqUi62pY50IL06v0pKa3YA/VHR0IHEU
         d/AQ==
X-Forwarded-Encrypted: i=1; AKwUvBy3MubBK1nlFnwBz/VqDtKuHRS5LswsfhVx4hzV8aIXXt5UUNE2t/4J4rPgTtx1sjfEn3MDeOTvOlwvse+/mac=@vger.kernel.org
X-Gm-Message-State: AFq9FYJenokRfljgElzdrQbpnvmkRKtgXg7aciF45QTndN5FXpLj6H7X
	xGU7eOGLndoe3ZE18iEsnHZvdo6cD7WUm+nSc4gDoUYkb0bbRXehCi3mF3QKAcUUxwo9E/wB+Na
	xq/mVe/fS5uZDbvlHhd43LyM+GNz9yNl6xrONm8Zz11gxepnw0tQYotzj856t8khx5gIaUrs=
X-Gm-Gg: AYBFou3GLhzU5FQVstJxIHGjL7ndD2MtNGqDpG1bPvsQgMk4m/M+Z2MA88I+yH3/h7p
	HQ0BUj5QP08+tCKmyMsZiRXhFivfSgRFfuXen1HjhVjywpQGss/bfqwycpXDRDN3/cQZ2ylAkhV
	MDYyb9mDX8RIe7tIm7rS5peuCsoZZcYrpeYSq9UdIWGJgiXQ0Z/NyBI4rss/JY+QYYgKnsBYkEf
	p44wgfnFvDqJRzoSvB0nepF1DUb2qrC3zsGcSOeD9qEmP9/nj9i9MMM+4arLed1u30x3cFVJA/m
	KIZlIYi7K0mTvlO7LodhXbGEUoPN843CJvFZ2i/2DPVMth8ErmUhWhYjv/mluFR2GIJQ4mkhIb1
	twVCp+VrTu/fBX0ZWWprdhe76lq0lPkv0uiOFbl5nPR2K/7bWdRJplQ==
X-Received: by 2002:a05:701b:4192:10b0:143:808b:b178 with SMTP id a92af1059eb24-192f5c29bf4mr1174142c88.26.1792629104438;
        Wed, 21 Oct 2026 17:31:44 -0700 (PDT)
X-Received: by 2002:a05:701b:4192:10b0:143:808b:b178 with SMTP id a92af1059eb24-192f5c29bf4mr1174090c88.26.1792629103886;
        Wed, 21 Oct 2026 17:31:43 -0700 (PDT)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903a180ca2sm8819002c88.6.2026.10.21.17.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 17:31:43 -0700 (PDT)
Date: Wed, 21 Oct 2026 17:31:16 -0700
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
Subject: Re: [PATCH v2 15/15] efi/arm64: Implement ARM64 DRTM in the stub
Message-ID: <20261021173116.00000df9@oss.qualcomm.com>
In-Reply-To: <20261021233909.GX3008132@nvidia.com>
References: <0-v2-989a18390eb1+486-arm64_drtm_jgg@nvidia.com>
	<15-v2-989a18390eb1+486-arm64_drtm_jgg@nvidia.com>
	<20261021111115.00004c5c@oss.qualcomm.com>
	<20261021233909.GX3008132@nvidia.com>
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
X-Proofpoint-ORIG-GUID: XCXhYLbTMX3LyYqqvVATFtawbHP2c3HJ
X-Proofpoint-GUID: XCXhYLbTMX3LyYqqvVATFtawbHP2c3HJ
X-Authority-Analysis: v=2.4 cv=N768hG9B c=1 sm=1 tr=0 ts=6ad95971 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=Ikd4Dj_1AAAA:8 a=j7B8HJC98GV4A_3RkYkA:9 a=CjuIK1q_8ugA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDAwMSBTYWx0ZWRfX5D2DmT3pdjlx
 YnW42yVhEdq9sg677YeeU3szLcJZGzZRsV9BkZksv5DD2TmTxqhuyLQgUbBubjfJiyBbq9qRp62
 95pjpY+nQHn0y730qWBmQIyqFOHIeqvlPamWZQRg5qB34XqdePJcJNzvLcjQ65QNv01AMkowRR9
 qqK2B6cD/WWdIHIQ2xahNZzIsHNQtxR3TDU4HKd4bcV1/sZstF7bSbEkswlLqBafzQg8wgigz/7
 TgEXplQRV7W5FGLwt2Kl3SeRohskPGpiSm2kV6nORZKfRpQ63ipY8kAVXfNBUUQjSovLPyL4PR7
 CNKgfEyHMNmYjpc79iJOky+1XwVFGGS6Q8HecsT54kIWlLduApfh43MuCqggywzEfS7dRetSKaM
 xF8eC0tzT8bmEejmRuBRxBgSTPS0FJSpuADFUnn8Q499juOulH9F7mHWmtXIljrxBaGeAo0MqNV
 gHg+AiXuDs+RXdp8Hmw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDAwMSBTYWx0ZWRfX6vfDgmag7/fi
 sAdH56HeVy7uNqlY/D8T4S4Qn6YpIqOgHqDKgwfr3xVXV29u1xiVI+fCi6DEIhdCM3vzebM2UjJ
 LSLKJJF9t6oZSU+RoW0tdPcRXNbJUyM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 malwarescore=0 suspectscore=0 phishscore=0
 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220001

On Wed, 21 Oct 2026 20:39:09 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, Oct 21, 2026 at 11:11:15AM -0700, Jonathan Cameron wrote:
> > On Fri,  2 Oct 2026 20:31:52 -0300
> > Jason Gunthorpe <jgg@nvidia.com> wrote:
> >   
> > > Provide an implementation of the CONFIG_EFI_STUB_DRTM protocol for ARM64
> > > DEN0113 >= v1.1.
> > > 
> > > First, it queries the FW for support and collects all the
> > > information. This is needed to compute the extra_size, which comes
> > > from FW reporting how much memory it needs during the launch for the
> > > DLME Data and DCE-owned data. The generic stub ensures there is
> > > trailing memory after Image for this.
> > > 
> > > Then the DRTM_PARAMETERS launch structure is computed using the
> > > offsets in the efi_info.
> > > 
> > > Finally, the stub does ExitBootServices and calls the actual launch.
> > > 
> > > The feature discovery process is deliberately fairly verbose to help
> > > debug any FW weirdness in the field. Enable it with efi=debug
> > > 
> > > It looks something like:
> > > 
> > >  EFI stub: DRTM: interface version 1.4
> > >  EFI stub: DEBUG: DRTM: TPM algorithm 0xc, TPM hashing unavailable, PCR schemas 0x1
> > >  EFI stub: DEBUG: DRTM: minimum DLME data 73728 bytes, Normal-world DCE 0 bytes
> > >  EFI stub: Decompressing Linux Kernel...
> > >  EFI stub: Generating empty DTB
> > >  EFI stub: Exiting boot services...
> > >  EFI stub: DEBUG: DRTM: will launch, selected launch features 0x0
> > >  [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x000f0510]
> > > 
> > > Eventually the launch'd kernel is going to require built in crypto
> > > libraries that match what the FW is using so it can validate some of the
> > > information left behind during early boot. Refuse to launch if these are
> > > not built in and build in the most common ones from the ARM64_DRTM
> > > kconfig.
> > > 
> > > One nit, if the platform does not support SMC then using drtm=auto may
> > > crash on the SMC op. As far as I can tell there is no way to discover SMC
> > > support through EFI. Learning it from the ACPI FADT is doable and costs
> > > about 250 lines of code.  
> > 
> > Ouch. Sounds like a must have if there is no easier way.  
> 
> Yeah, maybe so. I will include the patch in the next version. Though
> I'm not keen on it and I don't know very much about ACPI.
> 
> > > +/* True if SMCCC 1.0 or later is available. */
> > > +static bool efi_arm64_psci_smccc_compatible(void)
> > > +{
> > > +	struct arm_smccc_res res;
> > > +	s32 status;
> > > +
> > > +	arm_smccc_1_1_smc(PSCI_0_2_FN_PSCI_VERSION, &res);  
> > 
> > A function that is meant to check for smccc 1.0 is using the
> > smccc_1_1 namespaced calls?  Maybe add a comment on why that
> > is ok to do.  Is anyone actually using SMCCC 1.0 on systems like this?  
> 
> This is a good point, I didn't quite get all these details at the
> time, but yeah, technically we have to use the 1.0 calling convention
> due the register clobber differnces. The other reason is we can't use
> the kernels 1.0 helper since it is an asm function not an assembly..
> 
> Fixing everything I came with this:
> 
> /*
>  * Discovery must tolerate SMCCC 1.0 clobbering x0-x17. The EFI stub cannot
>  * call the kernel's out-of-line SMCCC helper, so issue these calls inline.
>  */
> static u32 efi_arm64_smc_1_0(u32 function, u32 arg)
> {
> 	register unsigned long x0 asm("x0") = function;
> 	register unsigned long x1 asm("x1") = arg;
> 
> 	asm volatile("smc #0"
> 		     : "+r" (x0), "+r" (x1)
> 		     :
> 		     : "x2", "x3", "x4", "x5", "x6", "x7", "x8", "x9",
> 		       "x10", "x11", "x12", "x13", "x14", "x15", "x16",
> 		       "x17", "cc", "memory");
> 
> 	return x0;
> }
> 
> /* True if SMCCC 1.1 or later in the 1.x series is available. */
> static bool efi_arm64_psci_smccc_compatible(void)
> {
> 	u32 version;
> 	s32 status;
> 
> 	version = efi_arm64_smc_1_0(PSCI_0_2_FN_PSCI_VERSION, 0);
> 	if ((s32)version < 0)
> 		return false;
> 
> 	if (PSCI_VERSION_MAJOR(version) < 1)
> 		return false;
> 
> 	status = efi_arm64_smc_1_0(PSCI_1_0_FN_PSCI_FEATURES,
> 				   ARM_SMCCC_VERSION_FUNC_ID);
> 	if (status < 0)
> 		return false;
> 
> 	version = efi_arm64_smc_1_0(ARM_SMCCC_VERSION_FUNC_ID, 0);
> 	return (version >> 16) == 1 && version >= ARM_SMCCC_VERSION_1_1;
> }
> 
> efistub can get away with this inline asm since it isn't 32 bit and it
> doesn't deal with quirks.

Smells plausible to me.

> 
> > I a bit surprised we don't have a common helper for this -
> > I guess the version checks are often explicit in a particular
> > driver being bound.  
> 
> The PSCI stuff in the kernel is all very early when establishing what
> the channel is and is done only once. Here is a bit different
> since we only accept the smc instruction used by drtm..
> 
> And even if there was a helper we can't really call it from zboot..

True enough. I was just hoping there was code to compare this with :)

> 
> Thanks,
> Jason


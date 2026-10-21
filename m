Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792601530;
	b=lcVWSPwUX8HGE7bSMPXP9fCFSJNw2wft0Lg0iHyHmNVhbvMljgbOkZEbApl2Wg0OEpbH
	 b07xAZ1njrV0jphF8Jt0Inv//IB/S0LuivyZcVva4XGlkJaljemSoFY+FsrT2jRJTpFIo
	 oaD37jrYBa3V89YyppMZR0IrGS1cClMc7kOucLbIv9CiIHNzp3dIxbQtLJ3peXHYV0xTp
	 TRtfLjyFO0AnZ/LFIAHQiiNYTC2jekM88wrX2nXQ6mx3NnCtPpe0Kp8qvesHo8T9BvYD+
	 MrDpMdtIs4btQW2RNPWvXhrObwh3f5kEanJlrWNhBFo1R01XWU6eIl/q0vQPBR6YJCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792601530;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=3Qwd5IeDpUYoKVbi14CXRmp0vCTcpiIpKFvrCb+PUaQ=;
	b=3eyGpdifc+/QZ46fn2f8GtRA4pjOMu8V1k8VZimDYCCW8mVo9p29ANf/120LGHd1o7Bj
	 ZIStoXDiOh95P1q2Pr6hAAF9mbbwGe4nS5hc633clFfINgMTgCdU+v/2e3zctSJ1L+Ccl
	 kdcm29TA6DxiD0cDHDGvtm7ZEGQpZxq+PyOBtg0Id1pJ7KpUyOj1w7f/g6NaSttehEpiH
	 WKceA8S4KspdnL6JYZHGWd2KQpgWc2prjZEx+eOBG1GGytJw+uiY6EZJyml+cU1ZBaQ+Z
	 xIlmO1y7CzLc+YnejoJeR3vleGyB3eE8XzI568PIzONsJECpLZbiNK5uL2MdCfaC9hQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fGBW0L6P;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QQjpQpmx;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7585606A321
	for <linux-integrity@vger.kernel.org>; Wed, 21 Oct 2026 16:52:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7585606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fGBW0L6P;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QQjpQpmx
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69LFTw1J1481033
	for <linux-integrity@vger.kernel.org>; Wed, 21 Oct 2026 16:52:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3Qwd5IeDpUYoKVbi14CXRmp0vCTcpiIpKFvrCb+PUaQ=; b=fGBW0L6PCB1n3raX
	d/aUhPmemf5kyrJMb2V994vfSQxb8ZW1AUflWoJbMqxkNdQMkyX60NaRpWzwG2ZR
	dyDNPyramva9fABPmwqppOy5x+y3G2Xjpzu+HJAQ8qTdGMQEDtxA5BLJJps0Gfbc
	0RS6PuOx2PIHdwu3bJdDo33JYwkVD1p+N8Eahl+8OsJIsrCWmXNci7Ks5pmN/stb
	gumg0KOS4MOx3tLDNhDJjMnuFbAjLxfI2H6AicbgZ1SvXdgPAikr3eeNDm/5NzI1
	ReUtxdLTy3hBPhb9/wjImsppuSRvPHiJNWyrz7U7vS8e4LyChMQCIA5S5oPDbcDF
	hGURjw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hegs04a4v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Wed, 21 Oct 2026 16:52:08 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-366c279b454so1836046eec.0
        for <linux-integrity@vger.kernel.org>; Wed, 21 Oct 2026 09:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792601527; x=1793206327; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=3Qwd5IeDpUYoKVbi14CXRmp0vCTcpiIpKFvrCb+PUaQ=;
        b=QQjpQpmxczgrpr2meAC6qTgPsJ4ZmJ91pnxGxL09Sesa1rfJJ+QmYIiqzX/3ZN2Whc
         PGHUczg9OAvRA0sX9sIDqu77sBzAiBbu7jGYKhjLqjsw2zunSyFSZrk/9dIw43rWgx87
         IVATm2JqsZfxBJA4hz7gvE+ZQkKi5tu3ZcAv3WPj72XLC61Kfbn/vxwFtyI0+LKC4Fg9
         N7c6i0MEQt4EgFAEAjH6SeD6iQGD2AApA1yq+2zxXGXf/7tUfU8F3yLM6Mcr02afFF0F
         fC6EP1lR68xmmprG7i052+aNcNNEAIDBPU11lgff4/LOklidQA8lbZ0lsxRZbkFmV+xj
         424g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792601527; x=1793206327;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3Qwd5IeDpUYoKVbi14CXRmp0vCTcpiIpKFvrCb+PUaQ=;
        b=AD2KHGbKZn4x7txk3AhWDWZTv3RZSY+Njja1XoLt/lplVbvfsS3BkBTM+KAjB9h5UZ
         tgPEtRNtRy88XgrIUfSTL6uyx+w0mmDdX4R7q49deXLaBRCSL3QAn/3cSaWgE+83hvYP
         F6hD8jyY9UENP936wFk+ibynqRBedEzB/gv2qXMe9ahccUocwfuJGRIJG14dlrF47EdB
         yjxamihzelWN8N2nNir1k3YLVQOjKhhf/eFxTSTte6Ucx3JZ0eaKkGKLaHvCsngpw89F
         qTl7PTBrg5MIFTI/8dN7cZ2t/OefQTVSu+cAzaorzFEU6CAPmuAu21cgyMs4BnRXFAsQ
         +0Gg==
X-Forwarded-Encrypted: i=1; AKwUvBykHqJ1WZv/+ozhO75nviZR1F4P7UA1jEKhSU+/aaokqOilhs49hgA6wv6zoaUH5yQKhWjXUDqvzjeaGQYj8Kk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKqDEQEIQAqinIJ0b2A0zHQ6czMsXj5d4Gdlndz8E1gl5pdEiel
	clXbS649xMJSl2mO9MIlmbWGvtwLXGMWxHkyjEPbJnhb6d2BgIMLK6pM5cG7Qs4fzIFj2IGIBKj
	xpw/zKtj96h9WwCUBlq5RwYx/z1dItClHRIXkw5a1On63O4RDNqpBCcMqUTnBOFWaP1xpOTA=
X-Gm-Gg: AYBFou3jiZgk8xQF0xxDcokm0yonVclmT2YljBhCeqRvKysjOVIZ7gmZGdvw1s0QlO8
	uZhHqLlOpvefPPmb8+ehWpscoMAXX9YE82v1LYomerOFu2zNTPNV6qw8DzLspfkPameCobIlUHQ
	L6ukxK/235uvZx+NoOT0NndtWFjE37sjVIjslE6nn2Ko50aInQIEgY3xbQ23UzMP3zSLxUPICZE
	ebi74xVDwRRMucWnHWHHF0dVfKlNG7r019dH1lQUC/C/KUzw41aDnmDC6BbRJQHvt6vgUkf5Rv1
	LUzjb6QXDN5WUoHby56jiClAml+T7un2ppE8VqP9EFzOuEHYitvadNb7BuW1L5/qoRq7FCgcbgF
	rbaUg91qX2y8p4eKYlDBQJMP60/5wWB+330+fWCl0ow==
X-Received: by 2002:a05:7300:fb83:b0:359:8492:2107 with SMTP id 5a478bee46e88-3674c43c286mr5506653eec.10.1792601526898;
        Wed, 21 Oct 2026 09:52:06 -0700 (PDT)
X-Received: by 2002:a05:7300:fb83:b0:359:8492:2107 with SMTP id 5a478bee46e88-3674c43c286mr5506599eec.10.1792601526326;
        Wed, 21 Oct 2026 09:52:06 -0700 (PDT)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3674206d1f1sm8700283eec.28.2026.10.21.09.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 09:52:06 -0700 (PDT)
Date: Wed, 21 Oct 2026 09:51:55 -0700
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
Subject: Re: [PATCH v2 07/15] efi/libstub: Add generic arch callbacks for
 DRTM
Message-ID: <20261021095155.00003fc2@oss.qualcomm.com>
In-Reply-To: <7-v2-989a18390eb1+486-arm64_drtm_jgg@nvidia.com>
References: <0-v2-989a18390eb1+486-arm64_drtm_jgg@nvidia.com>
	<7-v2-989a18390eb1+486-arm64_drtm_jgg@nvidia.com>
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
X-Authority-Analysis: v=2.4 cv=S/NMU4sP c=1 sm=1 tr=0 ts=6ad8edb8 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=Ikd4Dj_1AAAA:8 a=EUspDBNiAAAA:8 a=PZHjKiIRVRR-A8qzlogA:9 a=CjuIK1q_8ugA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA2NyBTYWx0ZWRfXxvi4B2nwoR3p
 /PXUt7kfin/1r4RJmFXQYsR7pEBV9a2QF1hAr7910/r8DzDz9XMgDwEn838NbUwWR6UOPvLLZKo
 UCENYtZHrO8qTLGsCOUg65Ptb9kGsQWBCDETR7I3omsGn24np/gpFOjv+fGDZ0SAGPDUoeixCMH
 3sByMOAFBXNgtCdB49noH2oEh2W89H/LtAjkPijciA5FGquOvUDiV3SyMvp8GjMEpEfouL8rX/B
 i1bAFXnzo7k43a177IeYjYQkfbamsPsROqsdjAL2WHisKYBYQZeMCDJjoOTZYvokmOhcUwIE+3b
 ailbaiQ0LF7FKh1ufy9Q/4Jku+cvawoaGOUWVoEXZWUUfwTeL+haXmBjDzaFLvOONsxCrkcuEgC
 Tc55TTEspOPkzRGkaw5UD7AMrOxGsT2p5/BO/14vF9ZnpMZfbEPX1EncxSW4jwh+aOp7cSDYynn
 rgiANxQiFY+jlm8sU/Q==
X-Proofpoint-ORIG-GUID: hLZiYDBSUj0yJnRcPoPB1PFdCZklMxbj
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA2NyBTYWx0ZWRfX3wuSN4EQ4J2P
 be42ZjJBgKlHTyb8ak5pbszzbOAqMAhxOT1kaUJJ4NYAGW42Q7zZ6ESalGJOnXVshaBYsBjnU2Q
 44Q4qwosHEzb5YwsC3Bmqqaw9sFq9F0=
X-Proofpoint-GUID: hLZiYDBSUj0yJnRcPoPB1PFdCZklMxbj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210067

On Fri,  2 Oct 2026 20:31:44 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> If the architecture supports an EFI stub launched version of DRTM, it
> can select the kconfig and provide the hooks under its architecture
> build.
> 
> Have the common code parse a drtm=enforce|auto|off kernel command line
> parameter to set the boot behavior. Support commas in the args list since
> there will be more options here down the road.
> 
> efi_drtm_prepare() is called before doing any decompression or image
> relocation. It should figure out if DRTM is supported, policy-permitted,
> and how much memory efi_drtm_get_extra_size() should return.
> 
> The image handling is revised to allocate extra_size at the end of
> the normal image. The architecture can use this to store any
> information needed for the DRTM flow. It is always contiguous with
> Image, which is a requirement of ARM's specification.
> 
> efi_drtm_prepare_launch() is called while still in EFI boot services after
> Image is fully prepared in its final location.
> 
> efi_drtm_launch() is called after exiting boot services and must
> jump into the kernel through the DRTM flow. If it returns, then the
> normal launch is tried (auto mode).
> 
> The extra_size is allocated directly after the Image. Handle the
> trivial zboot flow now, and vmlinux in the following patch.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Seems fine to me.  Some of the functions affected have annoyingly
complex flows already but this isn't obviously making things worse!

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

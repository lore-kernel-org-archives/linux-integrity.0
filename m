Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792604855;
	b=43zcoAmAKiEsX3GxvhdyF7HSjR3hjc/klD9v+EdC5YXZzkDFSSnh9f8iMg/9LregyTnR
	 9wNiP83hqE5FgbHxHokOcuRy/NXDCAnaM5WMWkqNKKPxEHUa4SLuUEpv1fEEg2ihE2ytT
	 RuCnTRxJiJiyFidZVYR/McJ7iug7tiVoFKiOc8SGH0FHa6iKaVOQrQqukNCy8TpXH4kSG
	 OFYbmrTm8NLuZHjWCpdBs+DeN4nWvjc/zV0YO903LBoI96ph8OqNiJLAmjRI7tsimSl5q
	 JN5dGZNCV8GyB0cJ1BHYtp1N7MlnEfQ4DzmzH8D+KS9fOgxEtmKc7gYkUsr2F1Wed7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792604855;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=kD15e1tCEFZb0oDM+2xTBELmNwYQTz7QW2OQ3oM2K7k=;
	b=ZCobrkZuDw6AVapI6t0qh6MfypfDsRHm9cZaieVEZNL2WhSXLMpiaZ/fVLEkHjFKNtVG
	 d3iwivB95jiztUpmcYVA4M11laPPG9QtlnRX0z4pkqxhG3kDw1McEQ+8RU874qvrzho1r
	 zUV58ZvBtWsKVmPDsbgTH8DSmNrNpwMnHml+2Uwepco4SMZDlzWd7OhgAuyO1sGHXAQEB
	 oKJ88AqwRRZ8weH9WJhsY8APaxECGVWjHla5FSlRKnrxfDH3Yv4KYv9r5O+BKANZwaMfP
	 jS4HFI9xULjrGl6ecFUtdqN9vZEUTbJ8yXAU3kx2Gt0X9M2Zmqguz3pXjUUAMJHwPcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hfpCRj+j;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LxyvmbLd;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA55606A31F
	for <linux-integrity@vger.kernel.org>; Wed, 21 Oct 2026 17:47:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CA55606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hfpCRj+j;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LxyvmbLd
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69LFTupE1045400
	for <linux-integrity@vger.kernel.org>; Wed, 21 Oct 2026 17:47:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kD15e1tCEFZb0oDM+2xTBELmNwYQTz7QW2OQ3oM2K7k=; b=hfpCRj+j2KxWdKAB
	AHRIXbKs8512TkOfMBg7uAuf4pQwBrgHnCXqjXGBqRwBoq/H7P7OrFgZF0Zfi+tR
	vu+VfuJDugBApslvid6veWNBEZZcyRXJAke9i6292jK0t0YZGi9NrNaWSpT8tY+V
	s0gVcVKmPr81HHIdp7X7HflfO6HpD/K1SRGxm3CFbfoBQBPSdCsoYQ7ODmPPoU7T
	R3UtMzJ9hljMDpG1WZQeQQuRgdzWHC+h+yxC/BvbZHBOb3CssvTUbrb7Z5UqBp16
	83IkxTQ0zg67ak7mU7qRBBySHW1fHCbjzIGN0Kp3HDrdNz9pEeOQETK0hUBs98qx
	h9bHVQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hetj4a419-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Wed, 21 Oct 2026 17:47:33 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-359b81ad4e8so1677375eec.0
        for <linux-integrity@vger.kernel.org>; Wed, 21 Oct 2026 10:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792604853; x=1793209653; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=kD15e1tCEFZb0oDM+2xTBELmNwYQTz7QW2OQ3oM2K7k=;
        b=LxyvmbLdOsZxUwrTx1onxCooip8x4q/sb4QyCokMkc2qtq/N9VNCawNfuzRzDY3WnN
         5VH0FCiN5eAUTOseG5A5LiFEcHt7L1nKqsnbyN/oZBUMidpiJLhBXxTIBIqbzwNzbfje
         8waG3/t7QFmpiDSsk9gNWJvToE2lvN+2WXT0MmTYCpMScTs5bTRLTQCM/09zx4wUj3xN
         35hYYe5lOoPNAyk2buaHqcY9GgRrktpCpggEtZcemKKfFaKr87K60I9rQba3EB59we7m
         ZNv3Kb2PQIaAIR035ItnPyK7XduTXioO2l0Gv/RpFaBL9ghrY5ST3Wrbudn4WtW4g6u5
         NUTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792604853; x=1793209653;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kD15e1tCEFZb0oDM+2xTBELmNwYQTz7QW2OQ3oM2K7k=;
        b=N/lg8cCqvXZiz59b8SB9Wt80JfuLOEtV05PYuXrruhUTb1zB2Qe9h7sFgMtw78rbiz
         obz1XmoU9A0fI7C1RACFqskfmH1a1T3eVfTrGLKuehjmqQGlobaMFxgclnb99Kl/VZAl
         PKNgYaXZGtfBvHEgv9ztiuluI+8jGcGuS/S8HfF2f0n49GTvwzNVfExYPdi1f7mryGyc
         p1c+CazyMWIYGNgpJeC0SdItX0PFoS9dBDIvZzZa8ImoU0dIXKeKeEzVdV773jKWWjEB
         uG5H9Y8lMY2A9qPat9o1t+Cafz32nWBoLqz+ZUL2iB1SAu2UeBBPnJbt8Jaz9kON+/zl
         SvCQ==
X-Forwarded-Encrypted: i=1; AKwUvBxMAMxUEHIBYOmmvOt2HHquoNH3Ak/5nOg37dSkYgqULp90dsuTxyzRKF7Gq+H4F+C7+zEaUPHhh7fbVYFpSyM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJemyJClILfzA/7P5PnBUBbz69BHhR54ikwsxYZMvo8LZHHj07d
	grYbROINheIYBmPcEVkdkA2ivD5rYI0k8fooWUON8qlH6L7VeSphsA6Q7BLnZYMWXPd8+FTOaC2
	r0rRAKC0NaU97Oi7DKV+HrxTJs5fI0CZ6/7tlG6O9V6E0tDw1D6jr/OojgP4lgT+uDQsYGts=
X-Gm-Gg: AYBFou2WvoHJAEMwt8oPbPzqXM9BT5FytGOIgbtYALqzoLf1eh9cRLtzGibbgDvl9Dj
	pP+SxJ+xLqdNtqcDedHiBKMCpBlQyMj+o1O3CBET41wkcss+ooBDz04+LmU4iI7UDoYmYlWRlcQ
	mG3ayhrJqBQIIVKnG4OdrGCDAmsyiyROIKZ9X14ZxVAfYcnflRTSr0rgemYDxbLp6eZ9IkqLwKY
	6s909QVTN8TabfXIcGhxXlS+wPKIg7nfx8iOgra/+Af/zrNzJeecoNCAqrXk73z/GEmETgHfL4b
	i+Kq1qvrhuJpNl+1OEYj6KM27Zph5OW8J2sDHXR+92ZYBbmJl8kUYrhv1jnlNyGmPIsfp5q0sZU
	OJwn1m4EzX8jvWm9JYQItz693iVeoue8dvyamVYKvMg==
X-Received: by 2002:a05:701b:4214:20b0:143:297c:276c with SMTP id a92af1059eb24-190a5d6f349mr3478009c88.33.1792604852518;
        Wed, 21 Oct 2026 10:47:32 -0700 (PDT)
X-Received: by 2002:a05:701b:4214:20b0:143:297c:276c with SMTP id a92af1059eb24-190a5d6f349mr3477983c88.33.1792604851896;
        Wed, 21 Oct 2026 10:47:31 -0700 (PDT)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36740cc848fsm8915123eec.13.2026.10.21.10.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 10:47:31 -0700 (PDT)
Date: Wed, 21 Oct 2026 10:47:26 -0700
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
Subject: Re: [PATCH v2 14/15] arm64: drtm: Call UNPROTECT_MEMORY
Message-ID: <20261021104726.00002640@oss.qualcomm.com>
In-Reply-To: <14-v2-989a18390eb1+486-arm64_drtm_jgg@nvidia.com>
References: <0-v2-989a18390eb1+486-arm64_drtm_jgg@nvidia.com>
	<14-v2-989a18390eb1+486-arm64_drtm_jgg@nvidia.com>
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
X-Proofpoint-ORIG-GUID: Di5_r_xBIs5N0a_2pj7WCDMto7y3Ex8K
X-Proofpoint-GUID: Di5_r_xBIs5N0a_2pj7WCDMto7y3Ex8K
X-Authority-Analysis: v=2.4 cv=N768hG9B c=1 sm=1 tr=0 ts=6ad8fab5 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=Ikd4Dj_1AAAA:8 a=4lc54p1sSd76nvOad-kA:9 a=CjuIK1q_8ugA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA3MCBTYWx0ZWRfX69Al9ZRFLAsr
 36VHTU36cwe+VGEHRGdSdP+1KOj5jf04MofoKNv5ML7zX4rGWfI3urgLCSWAF1r1Br0fK3Rmd3j
 zlrwdbInpIVEz5S9KhkEHaugmehUOsL7w7+uDhUVCGLjek0d+5a2TiovqBwDF76KAljJ+ggAXOQ
 OSRh7+XxCSMUEXRRKGH6y5zXsuCVesQBj5uD12b6d9YBzmc9PW2N1kAVW//pmNf/rBweGWV+Pkl
 cagfYcz+XdYGn1DzsRHDfmlf+bAFKuRnS4w05BxuPXu4jG/cCwRLBqCWNf0Kt+DV68ijpaGqYAf
 XLJzHVVqIi0RL7Pqs3cuzAisHLSjPmgCk4Yp3xrhPZ8LgHZxH7/9HS46/U/wJC5y757QcORae+F
 7PpWxHVtgdJMfkWuxik+3I42ZWECCuqadm95iX/6QR7vTrwJcgg2bgYvff/buQnkW5Q4nEG7p9C
 TqI2F0K/q3LAhnJOWfw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA3MCBTYWx0ZWRfX4FMTEPI5l6u6
 tl2wAq+dyRX9Xa8OERqMa62rJ30UANRligV42hY95EHywLDa4HS05dnSvNJ/q0LhB0R61KJEKXY
 d/th8OjSY+meFKfEdUc3gCg6mE0rN9w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 malwarescore=0 suspectscore=0 phishscore=0
 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210070

On Fri,  2 Oct 2026 20:31:51 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> The stub always requests ARM_DRTM_LAUNCH_DMA_COMPLETE. On a system
> with an SMMU the COMPLETE option is sanely implemented using the SMMU
> global abort register. DMA_COMPLETE should be mostly a no-op. It
> seems to be designed for the region protection mode that Linux does
> not use.
> 
> However, the FW can still do something interesting under it and we
> should call it. Choose late_initcall as we know the SMMU drivers are
> loaded by then. If some platform does actually block DMA beyond the
> SMMU, then this would result in a noisy failure of built-in driver
> DMA, not a silent security gap.
> 
> The platforms I'm aware of are OK with this placement, and it is a
> reasonable place to start.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  arch/arm64/kernel/drtm.c | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/arch/arm64/kernel/drtm.c b/arch/arm64/kernel/drtm.c
> index 14493948a27f0d..6062980a5d9e53 100644
> --- a/arch/arm64/kernel/drtm.c
> +++ b/arch/arm64/kernel/drtm.c
> @@ -3,8 +3,47 @@
>   *
>   * Support functions for ARM DEN 0113 "DRTM Architecture for Arm"
>   */
> +#include <linux/bug.h>
>  #include <linux/efi.h>
> +#include <linux/init.h>
> +#include <linux/printk.h>
>  
>  #include <asm/drtm.h>
>  
>  struct arm64_drtm_handoff arm64_drtm_handoff __efi_data_handoff;
> +
> +static int __init arm64_drtm_unprotect_memory(void)
> +{
> +	s64 status;
> +
> +	if (!arm64_drtm_handoff.drtm_enabled)
> +		return 0;
> +
> +	/*
> +	 * Currently Linux can only fully support a DRTM implementation that
> +	 * relies only the SMMU.

That sentence doesn't parse.  relies on maybe?

> This should be called directly after attaching
> +	 * a driver to every SMMU but before binding any drivers that want to
> +	 * use devices attached to the SMMU. Our boot flow does not have a way
> +	 * to do that, so for now call it here.
> +	 *
> +	 * For SMMU based implementations their UNPROTECT_MEMORY is probably a
> +	 * NOP since touching the SMMU here is forbidden, but they may still do
> +	 * something interesting so be sure to call it at least.
> +	 *
> +	 * The stub excludes the most likely case of non-SMMU by only using
> +	 * ARM_DRTM_DMA_PROTECTION_COMPLETE, which is defined as:
> +	 *    Complete DMA protection is hardware-based enforcement at the SMMU
> +	 *    that blocks all DMA from Non- secure devices."
> +	 *
> +	 * For now if people have such systems they cannot include built-in
> +	 * drivers for any DMA devices, those have to be modules to be ordered
> +	 * after this.
> +	 */
> +	status = arm_drtm_unprotect_memory();
> +	WARN(status != ARM_DRTM_SUCCESS,
> +	     "DRTM: failed to unprotect memory (x0=%lld)", status);
> +	if (status == ARM_DRTM_SUCCESS)
> +		pr_info("DRTM: launch completed\n");
> +	return 0;
> +}
> +late_initcall_sync(arm64_drtm_unprotect_memory);


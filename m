Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794453753;
	b=0nRb++DmzQwNsj510xipXranp/XxDJjUNtiADMXWUKkwS0yBIj3mD3X+dhLkswTP4bVV
	 bTvr/XAv3HAg3Fm55PvRhExOL1Vs/lYV/c4sViyzu37SENFdGx+PqhkF/xpskhTs+4wyE
	 WB2PKK1BrS1hp4Swq4z6gvVmdPBu7cGz1PDuPLbHZTYaZw+JfuOTeMtfEmjN4yMSFSJ5j
	 eQj+KqMQKmuzxw0P8kM7V4rzbA0Pomx99DcANGJIKZ2XOqZXd1RjBTKsrbeJ2IssGa/9h
	 k/2fRXVF/CwxHOLjRwv8HwXgT+jG0DSiCGAyMnJwkBua+WGlbldEwfWAkBqzFj4nR7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794453753;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Nia/3Fejzq/8pwGFpOYXDtAfbAIiNtIbDIVtuujz/Q0=;
	b=1WQo2en2pSkCxeASBRoMnvO0drYcD0m++toCprqsv1Miv7bW74E0pUHvh5WXdtR7YUQP
	 DP0dO9T00EubsNJ/iRCiuhjkN1XFIqwlbo3Lk584Ce2Y4hPfnzbsjNrXcecO0a6fqd1tL
	 nH7LgRuFmhxkhMfPOmyCqhWkJPx+tL3FoAFgSrsryWsJItRnZXNbCkuoTdRu2D4F5pXGa
	 VcrzaqyfErXgX3uFDy8ii8YZpv2OJ/f8WelBsTjUfAXxHw6OfGbT9JsP7y2Yoz4x2JTTF
	 oykzxHZ2TDUUJugyS3H2wFlzcHaGuPqee+t4cpM5oivkUHJLojb6WqkWOT1KMMWAA+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LOpIkJFk;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YfcOO+8b;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20953606A327
	for <linux-integrity@vger.kernel.org>; Thu, 12 Nov 2026 03:22:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20953606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LOpIkJFk;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YfcOO+8b
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC2ZbaC022570
	for <linux-integrity@vger.kernel.org>; Thu, 12 Nov 2026 03:22:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Nia/3Fejzq/8pwGFpOYXDtAfbAIiNtIbDIVtuujz/Q0=; b=LOpIkJFk1qcw9dNR
	IGn4sA5UCOtmAyOLiqsLJomBSihf4tRG/wVsCktehqAKlkuNZgtYphQhJjW6Y110
	kTG5YWTTru2Y4kr1/8Qaz2fJNsQUA5m5Ka/oMwTdFZcaTTHwgtDbyWShJX3YM2kD
	EmjFp/er0dKt0SxCLGtWua47LlVvaLI2blykILXXkO3UwS+VXzUWZRxAMyr0kUAL
	D2ZraxIHHVBA5T54djHiEvNFaJ4a29MejhkgHnvgHbDKd2hHf1ktkpCFc9c1JW8w
	HlSYTbk1ggYxW2ytlV2rCexQSaEEvjbUKJ7IAbCnqhsZMIW4j1I8fuadDWk7094Z
	MUoEtQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvgjdn36w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Thu, 12 Nov 2026 03:22:31 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2eaae8d29e0so49239945ad.2
        for <linux-integrity@vger.kernel.org>; Wed, 11 Nov 2026 19:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794453750; x=1795058550; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Nia/3Fejzq/8pwGFpOYXDtAfbAIiNtIbDIVtuujz/Q0=;
        b=YfcOO+8b58GCURpz5PXBLv24Uv1uH24sUAtfEyQOlUc9OwlPaHxRxUSu2Wb/xdKsDw
         9nNqgW7xq0qxgqaMr2Wbnrv2lxWwKO4qCJVKmNAeaWhLXOGKsyLr2FO3tqwiyEMcAKtF
         eopnhJ2XDhlR/ff9EIlREaT/fP6MarfDEOyZpQsDkJyCbP5b5QTm1G2QanAcyDn6yL7u
         0qFRl5AhkJ0RAI9Wh563lPvd12X53SiZRpjEphQr471LwLTDeEKjlyJMstJfqPSTjrJF
         KTU8mWBvJpuhlrCtzB3cY0UePYFekSC+EjfzsbCf/ghfk3y3qXlpZsicnvGR3fXBghZJ
         RL0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794453750; x=1795058550;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nia/3Fejzq/8pwGFpOYXDtAfbAIiNtIbDIVtuujz/Q0=;
        b=N9yto6sjyxxtOfWZHORIZsK6Vu8NjYpf2tkJjPKqgi132gGBr+3sM2jfj9C8oEfe89
         eLLkBDZGkt+vlz4DYDyVJ7ULkoekgGP+crBeGcxCKytwNrMuGH2uAxoXem2Jls2A5/Vb
         zecZam2HJXUSoFXqmJGuwhNmHalsIwEWw+b+qcBAoC1/3D0igEc2rl+uTCwbRQoAlhHf
         JjkzV3sgCJ6IQ84t1chok6AtILVwrjx0EASrkpMWC6SOAPydgvMOF5OlZ1Sun0F72tSd
         mrHzcAVy8+DO1EHOd2CF2gQsKoy1rFCU91keojbLHTatZ4mbL+gU0X7e5kxYASEE/cHI
         NLGg==
X-Forwarded-Encrypted: i=1; AL+hErG4P3HdXgOoIpS7AAIBUP3S2qbZdU8k1apwRpgZhikSivnq9lIoiS/Bddp9dXKl0J5qd9OBA5s5TkdpilR+Q9w=@vger.kernel.org
X-Gm-Message-State: APuU4Z/UdcV7Dl41EGbH4wslgrCx7JOST5mh6kQcmMkSdLwgZCx05hb4
	EuNUs4SLqKQvc4AOkB8WwbKGYO8OGurOBVbF/0g7iJLdSITxYjJZlW7HW6tDDBWJ/R9BcVXGOZH
	2VoK98KdBifUpDw/Pzqyd04E4E8tIcrLwpqKz9H7odDmYz2XuKd1A9zqh7kQYtUfJPNFoCa4=
X-Gm-Gg: AYBFou2R2nFMLyc8qlPPnOopZygJsRISsNhFpu1quYL0xa5VZzkmfjOYWkE7gFamWku
	37gMc3p2rnuSRrz2vYSgaV5VmTgts90cUn/xqHLyXFq6Bkog/SIRpOUdNRi7cuG7DMrj6p8qHYk
	Iv40EmpJhdBWfx055XMUnKv2v+lGjm7JUgjJurOAoOiYclZDhKHVToPZTheAaOSR+pyTWuyPxkU
	qHW+yTfYUHG06wYA65xdKzqIouD2j+twZlFmDcxaJtlp095vaElbEl0IxtoEcqZqzwKobAUFGcB
	mNcteKUv7fpF4SENoyuN2Gk7OX75975//g2BXpRBmW73DNnXG3loXOj+py+qP/xzprqsy3NDOyt
	CFSq7E6xyuXF+FfN6luxNSRUFCfLJfXg4wNRrvnogJfQbEIybhKkth6qoec09SkIjK3cYKsAY++
	gPlNtUUszjs5f0DgOJQahjwkMz8EyeB5LgTn4xuQGc+s2sgw==
X-Received: by 2002:a17:903:2ad0:b0:2e9:58c5:8c68 with SMTP id d9443c01a7336-2edd7acfcd0mr38209175ad.54.1794453750559;
        Wed, 11 Nov 2026 19:22:30 -0800 (PST)
X-Received: by 2002:a17:903:2ad0:b0:2e9:58c5:8c68 with SMTP id d9443c01a7336-2edd7acfcd0mr38208695ad.54.1794453750048;
        Wed, 11 Nov 2026 19:22:30 -0800 (PST)
Received: from [10.133.33.220] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6dfb58dsm26134275ad.66.2026.11.11.19.22.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 19:22:29 -0800 (PST)
Message-ID: <acd476e0-fb24-4f11-b917-c4e86f86171a@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 11:22:16 +0800
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] cpufreq: ondemand: Include <asm/cpu_device_id.h>
 unconditionally
To: Pavel Popov <pavel.e.popov@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin
 <tursulin@ursulin.net>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Hans de Goede <hansg@kernel.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Logan Gunthorpe <logang@deltatee.com>, Arnd Bergmann <arnd@arndb.de>,
        Len Brown <lenb@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, David Airlie <airlied@gmail.com>,
        Simona Vetter <simona@ffwll.ch>,
        "David S . Miller" <davem@davemloft.net>, x86@kernel.org,
        linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, platform-driver-x86@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
References: <20261111234821.4814-1-pavel.e.popov@intel.com>
 <20261111234821.4814-5-pavel.e.popov@intel.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20261111234821.4814-5-pavel.e.popov@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=E7tYNqdl c=1 sm=1 tr=0 ts=6af530f7 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=L27Nr_72VT4YvYD4_PkA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: 9_X2pVp07nU2mhcjP-W-yHqy71UMeqEA
X-Proofpoint-GUID: 9_X2pVp07nU2mhcjP-W-yHqy71UMeqEA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAxMyBTYWx0ZWRfX3fMp2CyQEoCe
 l9YzKhPTuuZyqy+q9sSsLOkuybyKWP9bPi9LjSDMSyW+6xp/ncsijsaa68vZspnkJ08HBvnhvN+
 5kItN+EJe9RE6gzo7kUgfjKMx16by6W+1WQU1cv5EkbqLl/5jNhc4JShxjjTAG9LN/L0ndmcoxi
 UwYANTqaIDWeR1CM3oBqIUmiATb+apMMP+4JS7D6YnsWzjhri4fWYbFt3PExOIvLqVJrUgRvmvW
 /MC1kgpZ0TW8hV4Qg05XwkuZMyRBqG+p2GO10ESZqytxYNKbLfR/I4TmIW2Sdhn/6WBqC5IfsnZ
 MjVM1Xm8HX7HiGw0xJ2KfhGKoytJe2CUm9BzJvV2V7QltzHIUhe/O5bQCZAjuW3/PSggT+A6DRb
 hI0QvcYc+9PPQ7acGfvjjqpFECB1ns559065+sXuGA0GG1/BjlK/gzFJgGFNgPGceKao0ZZla4+
 uvUigk/iax7fAL9OukA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAxMyBTYWx0ZWRfX1pZNgCzRa652
 n9oj/OmyM/hBlVyNTsIgMXcHH8cbErxxqP5J1KjHQjgN8cKhaEqaefa1VTD1Gh0Mhy/AcgFUwDK
 AkXhGBwEkbct3wl/+FjH6CwAKVQmUjI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 malwarescore=0 clxscore=1011 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120013

On 11/12/2026 7:48 AM, Pavel Popov wrote:
> <asm/cpu_device_id.h> now has a generic version, so the #ifdef
> CONFIG_X86 around the include is no longer needed.
> 
> od_should_io_be_busy() still needs CONFIG_X86 for boot_cpu_data.
> 
> Signed-off-by: Pavel Popov <pavel.e.popov@intel.com>
> ---
> Depends on <asm-generic/cpu_device_id.h> from [1]; please apply after
> it is in mainline.


Yeah, this patch strictly depends on [1] (series patch 1/3) being in
mainline first; otherwise non-x86 builds break.

Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>

> 
> [1] https://lore.kernel.org/r/20261111234439.4098-1-pavel.e.popov@intel.com
> 
>   drivers/cpufreq/cpufreq_ondemand.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_ondemand.h b/drivers/cpufreq/cpufreq_ondemand.h
> index 2ca8f1aaf2e..0e33865f9d3 100644
> --- a/drivers/cpufreq/cpufreq_ondemand.h
> +++ b/drivers/cpufreq/cpufreq_ondemand.h
> @@ -6,6 +6,8 @@
>    * Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>    */
>   
> +#include <asm/cpu_device_id.h>
> +
>   #include "cpufreq_governor.h"
>   
>   struct od_policy_dbs_info {
> @@ -26,8 +28,6 @@ struct od_dbs_tuners {
>   };
>   
>   #ifdef CONFIG_X86
> -#include <asm/cpu_device_id.h>
> -
>   /*
>    * Not all CPUs want IO time to be accounted as busy; this depends on
>    * how efficient idling at a higher frequency/voltage is.


-- 
Thx and BRs,
Zhongqiu Han

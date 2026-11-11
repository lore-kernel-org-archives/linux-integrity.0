Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794404965;
	b=HyXwVbgYvi1coXopnkDoaxSR16bnAbYlXEGOxeyuNsiZgpGq98o93PPU2gk0jHvhXcdd
	 a6xkbRF2tpx62/0miXnrgN9zsPBzWLPYDnmAuDiWP/w7jdPLMA4mtRwCri6rv75un4wCk
	 LzSdRJzxejGbvB1+kU6ZemIOCnqDXcXN/sIBCd3iqzGT6VXBUBTEm6tTyT3gTJFu8GOmt
	 xHdHqY+PulXmMxdFPmMl7eRMPAb1nC4Tw13qQDeDxc1wI70JaN37VPHCgtvabN3AUdaVy
	 dlpEKGngHbd4GH6svMNDWivohRVpyS5fjmfr4GPvDN6mx0znC2Stv9qCuU5lvKaAcjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794404965;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=lSwWMcsTLqANVOz4thWu0HIN2eRkabNLMzH9iPg6N8k=;
	b=1lC3DlhD6kDHnxJxphGu5CmUV5srBXVM55JVJyooJjv3QcFJjtR0xqh3f8TxXYwnkIXq
	 bK0jvzefLQz8dCIF0ceSEQP0lj0/115e1HBbJ966Zsg0wAL4ao9iBTDxflu+yKuqsd9I0
	 fv3hBdxJmC3GCO07M8AyO7IGu3thknv07uCatGvgXWus4mGZayvFoUyMCToxyH6Qfx7eE
	 BQxRZRNseaIXt0ic9iYG13qeD+aujXz5aPIH0FaTp2ugIFczWhqIi2tY1svWPm38o0mPa
	 wJGTbTewFBOEpeUPsm+GoduSgmX+Rmg3RO0HmvXdzmc0HHC7/TKIyk45SpJAdghZw/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="lB7/Hzob";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="R/3aetT1";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F062B606A31C
	for <linux-integrity@vger.kernel.org>; Wed, 11 Nov 2026 13:49:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F062B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lB7/Hzob;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=R/3aetT1
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABCZKIL708109
	for <linux-integrity@vger.kernel.org>; Wed, 11 Nov 2026 13:49:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=lSwWMcsTLqANVOz4thWu0HIN
	2eRkabNLMzH9iPg6N8k=; b=lB7/Hzob4wLxXBROFUWrgxOKFTaWUHM4A11zqpLA
	1/h6bh6ahoqD44zc15wX/MkMcrR0pudtST8tGqcgjdjDcrEokAACwTX3GHBIhKsn
	jnD5v0lTh0d72AgLahC35H30jQDEFhXYlrGUXfhdx34Uxv01SebyBkEk1XVkx3pH
	XUHH+B8ubL6ZcXnf61rK1knn6EHmHaavScy95AvIppr8GnnHBMj32yPbVTB+heKh
	UZdE+QPsYiqw+8RVeHv1jtTLU+1ET/FpTX6uNvxJLNXpD7+w/4TkTzHUsg1kCgCX
	DD2OVYIfRuSGkMROECj0DPfCt982JiEWdhnbYjzzoXmksQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hv9b33rfx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Wed, 11 Nov 2026 13:49:24 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-91ea5866643so61059586d6.1
        for <linux-integrity@vger.kernel.org>; Wed, 11 Nov 2026 05:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794404963; x=1795009763; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lSwWMcsTLqANVOz4thWu0HIN2eRkabNLMzH9iPg6N8k=;
        b=R/3aetT1YIa+rNP5YYo8s8q2ij+cylbptPJZRokzd4MWOr0Vfv4SA5X+LTvLOI8kI7
         zjYIcae3O0yLpbL1yMJGoV4AUP7sPlzJaVo8Qj9Su3KiQI+V3dTz6/WsRDzBN2DOywiN
         RJDxgcKz/e6PajGPDY8+FEbnys2KqEBkkdYEGA0JdhCMJ569Ud5eN34lz2LEUCBTkHvv
         uRnJhAOcp0qnO/BxYpIIVjQLHYoHR3HcnlUpm5has7xGz9CKv3+qcJp3i70BSYU3DHvB
         smUDo5OfyGNt1u2sfaM72SFe1rj8G1rH76Qf/B18gm50qtELhqUE4xZraeHvDHUAP9lD
         tLUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794404963; x=1795009763;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lSwWMcsTLqANVOz4thWu0HIN2eRkabNLMzH9iPg6N8k=;
        b=pQJ5I4zFvxq5FwkRz9r2jSnnfHawCUj2dDVrGqItaJ/KK6mfh8Vr/5eCH3utRjtDoU
         wQe+d7WEHzgwLxJYkm1uDdXrHqkr5S6R9Hdbu9nFmDIcQR14zii1CIxopXnzf1HoJb5p
         XalMQJmgMUKlEeRNK0FHCx/ZKZSvX05H8OO+ec7wDbWWCr9DD1cWW8WLmjGc0y7uXGLM
         yXxgNhF7QfPRmfYf7/ps8En8kX9ZPV+qqk0IwTOl2/V5XpcevVi8KQtUQaDjM6ifJUbu
         FnAHrigelpJou0EOZNlQHwLpBiswgXyhyj5aqk+E7KfMQYfOnVSAvylcahYlzv/iTHUH
         cjSQ==
X-Forwarded-Encrypted: i=1; AL+hErHMbala5wGA4h6sO8n4CAPm4j3C89pOG1KZ6j8X6gfgaQRKh385johtLrUs841ijDsBJHoHWtv+dVGCweA+/3U=@vger.kernel.org
X-Gm-Message-State: APuU4Z8pIHXyt9fYrLReJZCwniX/GIMz/oJDNVikflZjotPWwM50dFlm
	f66UTbAiv8t1Kckk2bXeoHz0FACHLnGaWVGccadSeHsC5fTLrs8go7FJMrfwr1nJfC/I+NWsU6e
	yE60zNKleCG0GszWuLJGt+oYjM2UAjKyCRuX9JpReRN7jV0o240ecdy8xR1Iql6ar4O5gyBE=
X-Gm-Gg: AYBFou0nsByXPclHUPtjIdHuyl4Z+hBdBIgmvWTB03rP5iJJcTQpLF3Mr4YaAk9w62V
	HH6ac/3PoJDGUDpr8FdZxQ2pewIMxY17qgeC5Dz+aQOnqsmAq+xyhD+VRw6asEjdJIHcC7YLblF
	0t+sTQlOXyKeTcbVbGEZvQDZr+qpgXp0tBk4UJOeJ8eR1QLrIeswF52TlECYd4sREYsXADk59oW
	tqckzsg6cmXKUH3ZJG/1hsRRDH5ZU9XmVkbO/xZc476JhXh55gLlId+3OuYfl5Sd3bX1ZQ5ls1F
	BIEKn0uLPRXTAyJrH5JNk+qsjlJtmAaZRu4MYG8TpuhGkNaK2m9lw53NPcM7PDC5+KBvnamSxYI
	d2Q54jCaPdwReDJh92sIBTyoVXb6Trsze/RWi1/wbBPe0o/23QLj3n5OAJcwfPZwm90pAEeh6KJ
	w1Sw==
X-Received: by 2002:a05:620a:1a03:b0:93e:c12c:f127 with SMTP id af79cd13be357-947b00d6dd4mr341948585a.83.1794404963114;
        Wed, 11 Nov 2026 05:49:23 -0800 (PST)
X-Received: by 2002:a05:620a:1a03:b0:93e:c12c:f127 with SMTP id af79cd13be357-947b00d6dd4mr341943885a.83.1794404962512;
        Wed, 11 Nov 2026 05:49:22 -0800 (PST)
Received: from trex (50.red-81-37-172.dynamicip.rima-tde.net. [81.37.172.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498362eb14asm10330443f8f.34.2026.11.11.05.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 05:49:21 -0800 (PST)
From: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
X-Google-Original-From: Jorge Ramirez <JorgeRamirez-Ortiz>
Date: Wed, 11 Nov 2026 14:49:20 +0100
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>, peterhuewe@gmx.de,
        jgg@ziepe.ca, sumit.garg@oss.qualcomm.com,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2 1/2] tpm: add OP-TEE transport core and a discrete TPM
 driver
Message-ID: <avRyYBpQcYx-xo9o@trex>
References: <20261110141923.3100770-1-jorge.ramirez@oss.qualcomm.com>
 <20261110141923.3100770-2-jorge.ramirez@oss.qualcomm.com>
 <avM0uIlZxZIga4dY@kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avM0uIlZxZIga4dY@kernel.org>
X-Authority-Analysis: v=2.4 cv=GKGdgeNK c=1 sm=1 tr=0 ts=6af47264 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=VbO86HPdXvN82gCvB8O6pw==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=c92rfblmAAAA:8 a=EUspDBNiAAAA:8 a=kVfuh0FxlVcxPe7lGXYA:9 a=CjuIK1q_8ugA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA1NCBTYWx0ZWRfX6SYxarAiTzvp
 xETx/KNDm5NxphwldlwhY9HJHIERJV4jyes/iBJJpgzKSwrvr/1y+syE3gv7hiOstc5LHS4NOng
 z8jf1aDnmciOHFA+5Y/9FNJ+tXobhEuG5FaMSfwouyThj2NktF6GSStYd32aVPbMXtLZWW7GobE
 bObX/UIZ1u28RZbd9P3IcK8snyCgRBVNtW4gWcQaMzM43ZoszDGAjLMNWckgfxXXh5KFDYWJDEf
 xJ5txBZDQ69fvDI895810l7vZ3uZOTjzGZeqzU+7F0maG8nR9tTZUu63r7ybetSAS7COZYq6et7
 jJROcPbMEycVAPppiQk+DWEW630qyW187m0p7IOPpyY9gE1VWYQQH5J4KMmNT1NqE6xA/pLy1GB
 6lYOqTO1j85qCYZKdlgzRcZmyS26CDSlNARdrbt+1GfZCLvzojXWKpfcIwIGQWGRQEAil8GhHoZ
 0DVvSFTz9FuPDKcGGjw==
X-Proofpoint-GUID: DxMe2a7MZa0KFeoFR6GnE__O7pJTLdAC
X-Proofpoint-ORIG-GUID: DxMe2a7MZa0KFeoFR6GnE__O7pJTLdAC
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA1NCBTYWx0ZWRfX6Eld5qNeblu5
 3koXPUMOpTjGYZT6TY7kJ91eJ35iupx0fxAZlxWmTNj6Rrm7jjEtPvmptcCqHUu8bnVy4Due3ev
 jNruStgBZ1H83Zfm99EBBfizeUqgECo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501 phishscore=0
 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110054

On 10/11/26 17:14:00, Jarkko Sakkinen wrote:
> On Tue, Nov 10, 2026 at 03:19:08PM +0100, Jorge Ramirez-Ortiz wrote:
> > Some platforms place a real (discrete) TPM on a bus that only the secure
> > world can drive. OP-TEE owns that bus, so the normal world cannot reach
> > the chip directly; it instead exposes a mediator trusted application
> > that relays TPM2 commands. Add a driver that talks to that application
> > and presents the chip as a standard TPM2 character device, so the
> > normal-world TPM stack works unchanged.
> > 
> > This is a separate driver from the firmware-TPM one rather than a reuse
> > of it. The TEE transport is the same and is shared through a common
> > core, but the device identity differs: the firmware TPM uses its own
> > application and a public-login session, whereas a discrete chip needs
> > its own application and is restricted to kernel access so that user
> > space and other applications cannot submit raw commands to it. Folding
> > both into one driver would also break on a platform that has both.
> > 
> > Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
> 
> Looks pretty good. Did you check the Sashiko remark?
> 
> https://sashiko.dev/#/patchset/20261110141923.3100770-1-jorge.ramirez%40oss.qualcomm.com
> 
> Br, Jarkko

um, right, that is a bug correctly addressed by the ftpm implementation
(the shutdown callback needs to go in the core as well)

will post a v3. thanks!

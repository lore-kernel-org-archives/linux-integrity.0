Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793089487;
	b=E5dmucyRZ3WZpZcGYNhpThRA6RX3d+0YfYabVRI/ClFPmpsJWBjkYdIvB3vRaBqYmreu
	 GPyHC+pNiLK/7GrabYAcuLJbuABLV5wzG+s56mnEUjcCsD8FeyAeURTRgy/OvbvZFUAWM
	 r6Z30Wscj3GWNCHQgClab93v6rmTr0h0z2uYSpJHqDTQMwyF3oIn8PG09wxAz9qYqejx4
	 2MY+xdVIG0Ged6g5So+v+PkYPP78R0AHxUhCDsNVutuBvBjJURI5uvjGj12nZ4Bh5wxN7
	 JlrIDaYYb4eWpqeFRtuV2GwZ6YA9pdPIYbmBgxGTzhydB2XkfGeIoVayrVexaehsDAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793089487;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=CvepuuK0gAaEvpLBJ4Cf86p7o1uPMZuJuRF3Ujh14sI=;
	b=dukn+wT0eKG0X2F+OQ3ggbhmLW+H0phXiTU95Qj/1TcfM7sRIO9KrprxX5yWk1VcQ7b3
	 08yXoZfwAUYLLK3a3sisU0AajMzsCyQ81zjLQFM8Ipge71ijB1ulso3Hk8j/0KCB8g1O4
	 eYZaBHIw0ar1SjAY6xc+zawmFUkfK1+lDayUcitUD0zwFdtigRpewQT0eEhef6lAW1xJo
	 z4DfJgceZgnXAsomAQUo5JvJJA8O7bjyBggJ+C2uLnrYs68bhxCchypSg5QeWI2ylg8Pj
	 OXKHuzCIRavicbFj/UmsrDoE4xLFmeL9gMyESZ1Pxw4W1kAzQE1Hu6pE9BrcmtNk7Ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ACuDC3vq;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LTk2fYbI;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B439606A31A
	for <linux-integrity@vger.kernel.org>; Tue, 27 Oct 2026 08:24:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B439606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ACuDC3vq;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LTk2fYbI
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69R5Z2NK1297020
	for <linux-integrity@vger.kernel.org>; Tue, 27 Oct 2026 08:24:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=CvepuuK0gAaEvpLBJ4Cf86p7
	o1uPMZuJuRF3Ujh14sI=; b=ACuDC3vqat8VvwXekIFu45xF+7k4NpDy1rtAc3YU
	niAvcU7IDpDWj/tyjh/55PfzavZgy/cxZ5duJBGCFQcEysiSBZPfL4hLWvkmiGKl
	2pIFBbC4G06TAbJ8Kz2XJP/5pwCZaSe6wywfQPlnbcPs/In38nsuoNGDm0nSUpgj
	2RbE9Zl8CwYet4ut0GkL6O1V/v16VN7ChZXt8Gy4k2UUpiK9o61NX0t3sWl2JTJU
	ujcs+on3QxYGhsEMkdZNe/auE+OeJzNybq01RT0/hAF/ze3U/xhKag+bp45M32hb
	yUpc2BCbDSqcoKmLiBI2Yhi9QaCPba9tolg/9XQudDR+Jw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj79xuvgc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Tue, 27 Oct 2026 08:24:46 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93ce7a85f04so807731585a.0
        for <linux-integrity@vger.kernel.org>; Tue, 27 Oct 2026 01:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793089486; x=1793694286; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CvepuuK0gAaEvpLBJ4Cf86p7o1uPMZuJuRF3Ujh14sI=;
        b=LTk2fYbINZ7WDpcyoBTvZqU/Bw+IhCgzQ07fq5H3P8sQLnV8YM1LUSmrBP9Rkqyjzw
         YtmLg7IEXJ8VWF4gyo5RsxxhV9DpIjP6fUC1DglxLLh3JKI58aXl2p6iUyOss6BWF5NN
         6Ihc+zlOm6YclZPeA2coRYT+mRbXY/QYW5nqUDNO6Lz4DULIBX5aUGz76SW8rRad19NN
         eIikVfCOQUyoZZ2yKEh58SZzRR1DrNQn/jj1FbM6ogCAV+oeYdi575l1F/i8z1p0rAwn
         Ky/KPtut+mRvHzqhhb+yZ36W8YKGNyq9EdEJaY+ruersaJg608SWa8IgyRwsCi1E9sEU
         MstA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793089486; x=1793694286;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CvepuuK0gAaEvpLBJ4Cf86p7o1uPMZuJuRF3Ujh14sI=;
        b=A90x1G/eQHhV2i9a12HBu0GVcjyLIImeQa0q6QnpAmnaevc0mGWIjO1TsfBOV4P9h2
         Oez6LDBUTB2jm71BzKKt4ewKV7wvXANI61sfbix+cDvxBxGedF96Rv8s57Hsu8jbkgKd
         bYu7h0+lqRMOh7tx132ui6cPH9Cs5J98eAV/BLaOwtIUeTv9CQUn1GAXaPmvrWMlbdjV
         +CIE7dsAp32NphY2phJK9e/UjL/UHm/MGiQaaozazDRsSGWFpK55LeilU7rNG1zyXXB2
         lH/fs73ABEMvabMJfnS4f2tDAu2/ERsngbRqa8W4mmr4pQ6yMWNUtwyEMKFQOu4z09Bs
         TRtQ==
X-Forwarded-Encrypted: i=1; AKwUvBw2DfW7cvAuoaFoOcqtfPIDX8+SrNqo1BEkjeJ5o4cMjgb/O/ktipARoAedTf+Jv9U1Vo4oA/11aUDic7YlraE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKa4vG8m8LGAFiCXVY1trKEAMf6v5CrSg2pbkrM1prQV9hnSuhH
	9pgDewnBLuBq5EjYGD8nzAW+s5awYNq0+6Q14X9MfoAh9qNR1ffCTPPWxY6id1eMzTl4NPbbg0X
	HtB5uzt8NyadwdymUQZa2FfckzUZebsSmhs2ts3/ola+f2ojplhF3aPvttNE97PtZfUJU2VQ=
X-Gm-Gg: AYBFou3WQ2JBcY5SjvTz6MSrPBm4GDdHNZckyVhXtzmfeTwHhuJ3qr4XUGgSJqHilXR
	b/szwVtfYz9u8ShF64TZDNzhrRQOqnIocRCgOfGAnE3oTT60V8PK3RsxsP3abqmhhKy0Hb5P38e
	U2B7qWAVa55XzXRT8h9N31JRdOmAxWaaCVG8qfKLw81IZKeOsdmtVOzSqwMdS6OrBImDTUMZ83d
	d3PaGR/0YREtgylbdLBCHt/qtrlmnB/6yjgvsu2+AgJOPSHHRVWWoJRhBWPXoQLkMiXITnKj+qb
	jPiTSBJVBeuK1mx88/Y9tDUlKyiBMXNTLAwu2QE8YAwwuId5SpsraU8d6NnfS9YVSbGJbKjPXYd
	+XulpO5zZvoSUh7U4ahMndwPr/C1UxU6IxezvNBc6n2YxqzaWzCDFp4+jIpVCBaItltcJHvcCc0
	ZkHQ==
X-Received: by 2002:a05:620a:838e:b0:93f:1dbf:6cfc with SMTP id af79cd13be357-940ef93997bmr1516405385a.36.1793089485581;
        Tue, 27 Oct 2026 01:24:45 -0700 (PDT)
X-Received: by 2002:a05:620a:838e:b0:93f:1dbf:6cfc with SMTP id af79cd13be357-940ef93997bmr1516402885a.36.1793089484989;
        Tue, 27 Oct 2026 01:24:44 -0700 (PDT)
Received: from trex (50.red-81-37-172.dynamicip.rima-tde.net. [81.37.172.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecde7c3sm22476897f8f.51.2026.10.27.01.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 01:24:44 -0700 (PDT)
From: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
X-Google-Original-From: Jorge Ramirez <JorgeRamirez-Ortiz>
Date: Tue, 27 Oct 2026 09:24:42 +0100
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>, peterhuewe@gmx.de,
        jgg@ziepe.ca, sumit.garg@oss.qualcomm.com,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH 1/1] tpm: add TEE driver for a discrete TPM behind OP-TEE
Message-ID: <auBfyueV3s_XUS97@trex>
References: <20261026163259.1900439-1-jorge.ramirez@oss.qualcomm.com>
 <20261026163259.1900439-2-jorge.ramirez@oss.qualcomm.com>
 <at-y-BtnXX-u67hv@kernel.org>
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
In-Reply-To: <at-y-BtnXX-u67hv@kernel.org>
X-Proofpoint-ORIG-GUID: vbUiEYP32FpHXAPpL1rOaMd8hguPzd4X
X-Proofpoint-GUID: vbUiEYP32FpHXAPpL1rOaMd8hguPzd4X
X-Authority-Analysis: v=2.4 cv=FPyOVOos c=1 sm=1 tr=0 ts=6ae05fce cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=VbO86HPdXvN82gCvB8O6pw==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=DybJpyO7BEJrc7p_h3oA:9 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDAzMyBTYWx0ZWRfXwIHZd1adWOAy
 AtwOhM490d5DxUzNFlOhaq97nCn6g3GH45NMqxXlAo+mhSAqOWExlrMoRXMFcsA9UutdiO0d1sZ
 lOsQywYxaulWyHM2lO8F0LIpMstSXKOV3ImCEW/EQRVhkE2uFJbQ2ouKF7L3pvToYHbLttz7tkU
 useMWLJxuFFE6KyO4ylpeZd7Mkjj346HLBJ+4ZNx+vrGpmrtWTEPS9ZvujMH7mmB4sQtG27/gLV
 f9h9cogRKAxni+OuEziyC2xDlVc4IUJ2mVdzmv7Tkr7hPFU5b3yY+3NhQOzIH3U6KdHVcUy/vwZ
 VAsdENYn3mPiqo8s8ggumDSKhLB3zX8CpcQDpr6LI2CXcc5P106crL8sCtFNUMv357lOcudPKYN
 fKWqTS5T1dK7PweViKel1SufEH/q5ub4aUJxQwShZEM6yRbw3LWxQIY8JkTmKYKCwt3F4XOkfu2
 w2xG2p+GrvcjyEO8vkw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDAzMyBTYWx0ZWRfX5vwYSgkA/lFg
 ZDJx/7ZmmpNm8/BPZLnjVf1kj7FhdVQeUjBeXoPdWkbggg/MRuxT0TJ0AuNAzwWCTsAcrG+U8tb
 EVtvAvWYZhXJgtcyx14AUfpzJfbzml8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270033

On 26/10/26 22:07:20, Jarkko Sakkinen wrote:
> On Mon, Oct 26, 2026 at 05:32:48PM +0100, Jorge Ramirez-Ortiz wrote:
> > Add tpm_dtpm_tee for a discrete TPM that OP-TEE owns and the normal world
> > cannot reach directly (e.g. an SPI TPM on a bus driven by OP-TEE). The
> > driver binds to OP-TEE's passthrough pseudo TA by UUID and forwards TPM2
> > commands through it, presenting a standard TPM2 character device.
> 
> "OP-TEE hosts" would be more understandable.
> 
> I have trouble following the hops you are doing by speaking about normal
> world and then jumping into SPI bus. Please try to somehow make this
> more rigid and less terminology decorated.

I'd rather keep "owns", not "hosts": OP-TEE does not host this TPM (that
is the fTPM case, where the TPM runs inside the TEE). Here OP-TEE owns
the bus controller the chip is wired to, so Linux cannot drive the
chip.

That distinction is the reason this is not an fTPM.

> 
> > 
> > It is a separate driver rather than a reuse of tpm_ftpm_tee: the TEE
> > transport is the same, but that driver is tied to the Microsoft fTPM TA
> > and opens a public-login session, whereas this is a distinct TA for a real
> > chip, gated to REE-kernel access so that user space and other TAs cannot
> > reach the TPM. Sharing the fTPM identity would conflate two different
> > devices and collide on a platform that has both.
> 
> And they don't share any of the same DNA?

Sure, they do. The TEE transport is effectively identical: the
shared-memory, the invoke and the response validation, plus the
probe/teardown sequence.

What differs is the device identity: TA UUID, login (REE-kernel vs
public), and bind method (ftpm also binds via platform/OF and has a
shutdown path).

> 
> Two other options:
> 
> 1. tpm_tis_core type of solution.
> 2. Implement the feature as part of tpm_ftpm_tee.c.

I'd rather do (1). The shared transport goes into a small core; the
per-device identity stays in thin front-ends.

Something along these lines:

  /* tpm_tee.h */
  struct tpm_tee_config {
          uuid_t  ta_uuid;
          u32     login;          /* TEE_IOCTL_LOGIN_* */
          u32     cmd_id;         /* SUBMIT_COMMAND function ID */
  };

  int  tpm_tee_core_probe(struct device *dev,
                          const struct tpm_tee_config *cfg);
  void tpm_tee_core_remove(struct device *dev);


tpm_tee_core.c would own everything that is common today:
 - open context
 - open session
 - shm allocation,
 - chip alloc/register
 - teardown and so forth

The front-ends collapse to config plus their own bus binding, e.g.:

  /* tpm_dtpm_tee.c */
  static const struct tpm_tee_config dtpm_cfg = {
          .ta_uuid = UUID_INIT(0x50568cd9, 0x370a, 0x46b8,
                               0x9f, 0x2c, 0x6f, 0xd9,
                               0x06, 0x64, 0xd2, 0xee),
          .login   = TEE_IOCTL_LOGIN_REE_KERNEL,
          .cmd_id  = 0,
  };

  static int dtpm_tee_probe(struct tee_client_device *tcdev)
  {
          return tpm_tee_core_probe(&tcdev->dev, &dtpm_cfg);
  }

  static void dtpm_tee_remove(struct tee_client_device *tcdev)
  {
          tpm_tee_core_remove(&tcdev->dev);
  }
  /* id_table + tee_client_driver unchanged */


I'd push back on (2): one file would carry a public-login firmware TPM
and a REE-kernel discrete chip, plus it breaks on a platform with both.

The core split removes the duplication and avoids that coupling.

Questions:
- Is the core in tpm_tee.c / tpm_tee.h acceptable, or do you want a
  different split.

> 
> I don't think tpm_ftpm_tee was that great name choice [1] but we have
> to live with it. 
> 
> So more logical name as per taxonomy would be probably
> tpm_ftpm_tee_dtpm.

tpm_ftpm_tee_dtpm reads as "firmware TPM ... discrete TPM", which is a
contradiction (this device is _not_ a firmware TPM)

Per your own note in [1], the ftpm prefix was a mistake, so extending it
seems worse than leaving it.

With the core split this seems clean to me:

  tpm_tee.c         transport core
  tpm_ftpm_tee.c    firmware TPM front-end
  tpm_dtpm_tee.c    discrete TPM front-end

Does that work? I'm open to another name, as long as firmware vs
discrete stays visible.

The rest I'll take: = {} initalizers (drop the memsets), module name as
the function prefix, and the MODULE_DESCRIPTION reworded once the layout
is settled.

TIA
jorge


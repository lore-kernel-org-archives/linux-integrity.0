Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793032395;
	b=q7RCP0J7AEucsZPThTjDpB2/z2X3L93aISi5RY20Y5Dei2HWpLuyJTNkIOl5NQ597ew2
	 oSullbqT6lRwNvAeyWi8L1+oXVXk4tb55/zPXrpWJuoQzE1cuy18VgEFn4ZyqDdenbbgX
	 qefR42VKHrtybzWRICuD6m+78qrMZCyJHYL145LXZDsd+QUE4iJblWk/R0DVrMR4XQ3nE
	 F8SIiSCGVVALRGd7d17GDHr9yGCzzuePOxP/STp8sZOgeNSLFo0PAqvEO0BuQQIHhAdQq
	 Q2y0JgHFEfyyH/5kln0bb0f8x4FTlhQlimpdHKVUjKDAx3cRgN2w2gA1+CmVzfzgniw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793032395;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=GaIPkzk+pG3/QsmiSTZYcHrcSj1XsXpOWVinLGBuws0=;
	b=w/JSRODPVWh2Cr3Gt/vfIGwEWgELnxXba6zel/e6JxgLn72HOrdSoD/h/Dkr6ZbiIxRZ
	 3TENjZFTqysk/wpStmHFvytxCpEm0jZrep86y4IXis6PCRfScXF9iybZipINUeKvLyBGc
	 dHA84C32/tlZzQcFkpAao+1/lJA/waf2HRwuXFcxHL+UNJErDkaMQvjXam5DL42C2cGm9
	 eW0+pOtO7mRuyMhs0qjA+bzogqlksmjm9Z+FRRFBGDUYY1rtgp9RmPiNVXcc6TkLIBtJz
	 ErqeTXLT6ZPoPUO+12a9YrOHSlH8TKtfAB8IfjVfWE6DMCSY2dBvz6SA9A0AApBFehg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="UFF/m42T";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZTQcrEsg;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D2A606A31A
	for <linux-integrity@vger.kernel.org>; Mon, 26 Oct 2026 16:33:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68D2A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UFF/m42T;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZTQcrEsg
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QEvrPm3268491
	for <linux-integrity@vger.kernel.org>; Mon, 26 Oct 2026 16:33:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=GaIPkzk+pG3/QsmiSTZYcHrcSj1XsXpOWVi
	nLGBuws0=; b=UFF/m42Td1b4Ae5WWpmiXCgVE6qbgoZ5HTYEd5c1Rf3slkVrv7j
	sNif4o+bKe94pri6JMem/4HQiiFkSxdd9+EBhsy+mGrjBaA4DtT04w/ISqEoBZEn
	AKiNaZYaOQcTwSXIPZmYOwVjX0VlCnALZl0hWnFaKbCSLm6N1klFGSj+dd4EGc/B
	T0V+0FxC4t5pFbUQoHSI7SqHj6g1ajei7OSQiUYmPwwSV1+5ud12WahhlmlSd+S6
	90vsZXGaOrHHaT0c4RDEODsFDtW4qRzt9I4qhxU/Q9s4epTq9jyXDSBRYll554xy
	ke6jJjMEQwUuplQSW3YASnVF6juk35D5DmQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj4cp9kv9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Mon, 26 Oct 2026 16:33:14 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93cb6391e89so671247985a.1
        for <linux-integrity@vger.kernel.org>; Mon, 26 Oct 2026 09:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793032393; x=1793637193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GaIPkzk+pG3/QsmiSTZYcHrcSj1XsXpOWVinLGBuws0=;
        b=ZTQcrEsg6xWPLUtTjG7QzzEgPCSeX6CKqSZPIzm//WYsPILGYneznYVcO0xpDLtLCl
         nJ8AhcdkwNvIPX+by+7UnrHTFWfdx9ifNzBtRQjnYLAusADinMEFumQGrh/PXxZQr5ke
         /We5CCJ+oCnTDKEz1xJUZYJ1M93+1gOZiwZTleDwBkmrUGP2wT5MexkNsuoFmcQAWRtO
         UmThUhQToeBhicHhdTlR3UP7bEErrHB9HEaRbO5sd8sHs49KNdO3+FVDsReOy7L/5Zg8
         7CadgBZDCK7hGZfB4skA1+PMU6mFQE3e3TrFovAXJ4vpMYD75YukGlZFXDOFp5hm5i8l
         1FhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793032393; x=1793637193;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GaIPkzk+pG3/QsmiSTZYcHrcSj1XsXpOWVinLGBuws0=;
        b=GONtSBrCbxoM8c/KKOfSiOoL2SJTjQnyeAB0aI5Kj9y725+W3QiiUW1+F9ydZEfl9E
         6H7c/tjneJwu37UH2dlHlx8k9Nle2DdQquQfTCPnGp5bRUfPnXZMGQy4Ep+8TebMkcci
         QQNoe2m0lYWFLNJjYiUC1naMwC/rXfb8t7w7VDnGrPTwQ85d5b0g7fKCPgKESyd6fMSq
         TLafP1mImHgnNan5qltFYBCxyLU6AyF2xlsadgxidWQfOWUqjOVW9p+jAjeCgmIQMlrY
         cV/S4p2IrKUF/KRkyT9JB/yw579566p3UJYb5Fn/mJL1wGLACGfoKO1OnOfQJRM3vGHb
         U6BA==
X-Forwarded-Encrypted: i=1; AKwUvBwDFTWyir3xXEO0oLQeoAzZM1LadwfJkheXR1PMiH/W2foEmcTNXIuMRNdLkdB7IZuPlvJhgldJk2SsRokeALo=@vger.kernel.org
X-Gm-Message-State: AFq9FYIT58b0trVKTVA393EmcBzJWs/S09loIwvPQDBNHQUeXLPs2gal
	5t+pN9j8O1DyddSUhmP4SBKjRNZcW1KhUfCslJiqeJGsiN0vo6OosTT8XNHFFw5Pd6S4ofljNoz
	bREOwoBe3L94hF6coSvT7w5xobyvl4Ta5Dry/lTXFxtscu1tcnwN5+DIpgb4Hu9z/Jv176zxgiH
	JPlN+OxQ==
X-Gm-Gg: AYBFou1lt45jvoaqbpo/et7SsCsy1MYwX9r/hNHJvqEDRYG35n4X9VBbHyl0CaTZ2F/
	RpQzHcfFrUqI0wGKAkpbG1xa3urkEMWm8zVaMjk9VHiWz1+mKYVe3bvVGxSDG4WGR258fCK0Ref
	T/lCrtwGNBcO5o/9+CZhhQ0usPnJrH9tnPSfMH5CR7pyxsNaTGrAbh4vERDAeUlb4HNCbfZxwQl
	8FK/8WXWHq+xNZJ31594C4KGGmhAh5n4O39Jdqysfq8uB3/nZGf3/Du98ns7ub+AcinJFxkLTH2
	rmPGF+mYaEYMnSip0bm7i9Wec815BVLF8eAimjQJeFHMt8xIMFxnyBe7ocuuFBQ6R7JE40BCisu
	+1F+7cAUNrSD7xbMxO5gffRJnYXnB7VPZCwc4wsc7Yn9YnEVv6oYgtyG2Ivr25L4CvLHtbyVB/g
	TDnxc9PYSRABWaGSFpWA==
X-Received: by 2002:a05:620a:2a03:b0:93e:c12c:43ff with SMTP id af79cd13be357-940ef9c49femr1068564985a.76.1793032393392;
        Mon, 26 Oct 2026 09:33:13 -0700 (PDT)
X-Received: by 2002:a05:620a:2a03:b0:93e:c12c:43ff with SMTP id af79cd13be357-940ef9c49femr1068454185a.76.1793032384035;
        Mon, 26 Oct 2026 09:33:04 -0700 (PDT)
Received: from trex (50.red-81-37-172.dynamicip.rima-tde.net. [81.37.172.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc3932sm18589629f8f.18.2026.10.26.09.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 09:33:03 -0700 (PDT)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, peterhuewe@gmx.de, jarkko@kernel.org,
        jgg@ziepe.ca, sumit.garg@oss.qualcomm.com
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: [PATCH 0/1] tpm: TEE driver for a discrete TPM owned by OP-TEE
Date: Mon, 26 Oct 2026 17:32:47 +0100
Message-ID: <20261026163259.1900439-1-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA2NSBTYWx0ZWRfX0QQ7N7lqgaxh
 3ucg+wNOQkBFMAnH0vkj6CNQpQXatXZ0kyOfAhWXucw259ZrtFh+v4YVlPfFecBPYSezPJEgSXC
 gTbIjYjwrgAOjg3rYYtcQq1+pVQqJzIfHNxVx2tzipp82ckclntnYLR8xhIsLnN0y0vziQCFx6H
 4TOHSMlgYgk7y2TjyzdaCmpJ/1GX1RGwwUJlGYZvYd8++97BGMz4f3HAXU9ILYY5fL+KhQ1P3wH
 Q8TE8zEUHxlhEx4jRi5nChoiWCGDPw6Q/YZK2phB3/pN6Tme9ftlQFuZaEL3J09O4TrOprLyVSe
 noeNk7pd5x65eNjcRd8SGIeJFkPLxupX3VZovxuCiuVkOVtndfLYciqwHRUqCljuv/YKOGZg9Ve
 kM6CcBKaPWlMuRsG05Ln8/SnQz8rqpn8S9QP3gaBR+jVltgR5IkiNP/mtDmp0mJdDO54FnjYkVh
 CnnYiRezQ2cQ0fGjDVw==
X-Proofpoint-GUID: NUfr1TmirxCrffWRlO91M_2YujzVqake
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA2NSBTYWx0ZWRfX9a4i5jf36VE3
 8CvVj66FiiL/Ni6Iq9Z8ZcOklBHBalqgt+DsnSVCQ/vfXfNLuZF1w1/Pr/DJB2STYpuvYr9fWB1
 F+qgBqGu7zH/I0gM7wAdFMxIDaajBTM=
X-Proofpoint-ORIG-GUID: NUfr1TmirxCrffWRlO91M_2YujzVqake
X-Authority-Analysis: v=2.4 cv=TboDJhQh c=1 sm=1 tr=0 ts=6adf80ca cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=VbO86HPdXvN82gCvB8O6pw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=NEAV23lmAAAA:8
 a=1sRuEKMv-XdyHin6HR8A:9 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 clxscore=1011 adultscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260065

This adds a TEE-bus driver for a *discrete* TPM2 that is owned by OP-TEE and
exposed to the normal world through a passthrough pseudo TA. It binds the TA
by UUID and relays raw TPM2 commands, presenting a standard tpm_chip, so the
usual Linux TPM stack (IMA, trusted keys, tpm2-tools, the TSS) works through
/dev/tpm0 unchanged.

== Why this is needed ==
The chip sits on a bus that only the secure world can reach -- e.g. a SPI SE
whose controller is assigned to OP-TEE -- a deliberate hardening choice so the
normal world cannot observe or interpose on TPM traffic, and the engine cannot
be re-muxed to attack the chip. The normal world therefore has no path to the
controller at all: there is no tpm_tis_spi for Linux to bind. OP-TEE drives
the chip and this driver is the REE end of that channel.

== Relationship to tpm_ftpm_tee ==
The TEE transport shape mirrors the Microsoft fTPM driver's SUBMIT_COMMAND
(memref[0] = command in, memref[1] = response in/out), but this is a distinct
TA for a *real* chip, bound by its own UUID and opened with a REE-kernel login
(TEE_IOCTL_LOGIN_REE_KERNEL) so user space and other TAs cannot submit raw TPM
commands. Reusing the fTPM identity would conflate two different devices and
collide on a platform that has both. The common transport could later be
factored into a shared helper; that is left as a follow-up so it can be
reviewed with the fTPM maintainer rather than in this bring-up.

== Device-tree coexistence (important) ==
On a platform where OP-TEE owns the SPI SE, the *entire* non-secure SPI
controller node must be disabled in the kernel DT -- not just the tpm_tis_spi
child. If the normal-world controller stays enabled it drives the same engine
and corrupts OP-TEE's transfers. The Kconfig help spells this out.

== OP-TEE counterpart ==
The secure-world side (revert of the in-core TPM2 driver removal, a generic
TCG PTP SPI (TIS) transport backend, and the passthrough PTA this driver talks
to) is under review here:

  https://github.com/OP-TEE/optee_os/pull/8155

== Testing ==
Exercised on a Qualcomm Lemans EVK with an ST discrete TPM on a QUP SPI SE
owned by OP-TEE: the chip is detected and registered, and Linux drives it end
to end -- TPM2 identity and PCR reads over /dev/tpm0 round-trip correctly.
checkpatch --strict is clean and the module builds for arm64.

Jorge Ramirez-Ortiz (1):
  tpm: add TEE driver for a discrete TPM behind OP-TEE

 MAINTAINERS                     |   6 +
 drivers/char/tpm/Kconfig        |  18 ++
 drivers/char/tpm/Makefile       |   1 +
 drivers/char/tpm/tpm_dtpm_tee.c | 282 ++++++++++++++++++++++++++++++++
 4 files changed, 307 insertions(+)
 create mode 100644 drivers/char/tpm/tpm_dtpm_tee.c


base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
-- 
2.55.0


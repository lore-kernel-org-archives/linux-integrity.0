Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF7B4A4401
	for <linux-integrity@vger.kernel.org>; Tue,  6 Oct 2026 19:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791313274; cv=none; b=NaSjeRvl2FrhLgMBOdKqbsk0P1MTGmnSZV1JhwoXwHxQ/TKcb6u0OPqB2kN82d86upzV+M7fUojNI6g0JYn5vT50vMkbeaXAZqT84LT2ChAaf+2ly6iWptkiFssGhtJcoU9zwLxEqywnZXOphKAf+LCsJV5mdwbhF9lN2PUHR0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791313274; c=relaxed/simple;
	bh=2RW6IPDLAolYy3+iGgEQpAzkNDBRbDglAQ1q4BAExJQ=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=jALvuSKn+uG/kxAlVqwwrX13/+twM1i1e8XhHrZo1jdcC97ysBqtU0MnmfC8rxt9rotcNzDahw357hl2jv0l9Ms62XD0+o/rtIaEiUodyRiP/GO5xNNLE5MQYSk3LcIQd4pJBO0iCFZWIF4Yq0Zxcm5Xu2ZqeYqZPp4POKNbOi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GU5t5yzy; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GU5t5yzy"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696I5iw1097348;
	Tue, 6 Oct 2026 19:01:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=d2jrY0
	gwjkqS9EfNsjck0QlgOQnhcqFn7I+T5Z6+0kE=; b=GU5t5yzym2ct9PvkencjQP
	y8ce1ofj/pNw4mrH3n+1roFeoz6wacAa9QW4xCQWZdRD7Bs8JpGy/1yO/nyaDG2n
	two+0vuR0GPk9ajyR+XIkbdFMSMq2Ux+XkS1697TpiOKjcZNpzbO2F/ECm9xANa+
	U4sTUzbmNSxnNnL3qwpr/0IQCfiXgQrtMzUCBvuWk4retbJhmOhk8Tn2F0sGowTG
	EkiNMFqwf2N+6EfpRipy7hWniq4RnW/WwsvB5z3xt9bnbQUfuuegNd9FZOM6VSgh
	dXvroIQA4z9PCpzwoBh8w5wuOAQgmMnSHOJ7Yh4FzjC6qa0y/6ML6ywBQlkXzN8Q
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2q4js9xw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 19:01:01 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 696HlZLH662563;
	Tue, 6 Oct 2026 19:01:00 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h3eqyb5s6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 19:01:00 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 696J0xi631130274
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Oct 2026 19:00:59 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C120E5804B;
	Tue,  6 Oct 2026 19:00:59 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E522D5806B;
	Tue,  6 Oct 2026 19:00:57 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.35.151])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  6 Oct 2026 19:00:57 +0000 (GMT)
Message-ID: <130bb656d4bdb8bab4d044780343b1132f4c417c.camel@linux.ibm.com>
Subject: Re: [QUESTION] IMA: kexec appraisal and the unauthenticated target
 command line
From: Mimi Zohar <zohar@linux.ibm.com>
To: Danny Hu <dannyhu@arista.com>
Cc: linux-integrity@vger.kernel.org, roberto.sassu@huawei.com,
        dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
        Pierre De Abreu
	 <pierre@arista.com>,
        Julien Gomes <julien@arista.com>,
        Kunal Bharathi
	 <kbharathi@arista.com>
In-Reply-To: <CAFn2k5Cj1wTZQsPm4HoSRWZx7gJ4tYoQYhmSPBZc_0qkY5HK4Q@mail.gmail.com>
References: 
	<CAFn2k5AwOoHesnqB42kpfAGx0Wf-CtQbpU3px7LMj8PeiACvZg@mail.gmail.com>
	 <55d240d39dfbdac4d034380dd02f78838d09f061.camel@linux.ibm.com>
	 <CAFn2k5Cj1wTZQsPm4HoSRWZx7gJ4tYoQYhmSPBZc_0qkY5HK4Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 15:00:56 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-2.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 1Evp4ganmGeAwyrUNMF2MJA12BWm_LjY
X-Proofpoint-GUID: 2wD1l6utu5LDT2sMUf5KxeFU_jt7ItW9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA3NCBTYWx0ZWRfX4oAnGx116F5w
 78kp4SP1F+FY6HZrsT+OoAh7aIMc3nh0aHamSCxD9e3qXwjv6Rf2nG76WsXr59eKeTClFbzxSyH
 Mo1qCDTYN8jGoZY0+ZZUYvawQ6qH4FI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA3NCBTYWx0ZWRfX3+xWIgIPGlGP
 FpCMEzSIe4A4CUBGF2t8QwWVKfdJTJRD80RLF2Jb7of4LVDEx9yeVRywGE7+FIIGgbEGPLFRYvC
 0e//rH8eQ5RD5/px+tCnWq7iHs9yczpJ5nrAqg/8BL7vmctHIhB+6bu9c1WVRNU23OUtIPFEu5x
 scOa/qqQcKh+EkK42r4levFeInh4ZkGoq8QUZhIKCZoQ4YqF8ev7RpPP8igEsggtfCSk1fwfB1i
 73hUSQCx0YgT/Q9veR3tEml9ea5IG1WWYFrim1CxNlUbKHPjy9R5SBdE8lp69Nr9CU8wo9A3EtL
 mC2TgNHDa0yG/IJa8+U27CM45ePgEAfPgmUjFXOEsAnknhwpELa/BSkhJPzKAmisB2nPUQF72l7
 8N1b/6niNNGjUHkoJcaRNSijC1nAt8GkhNZezHwMKytLsEcWrN/+g1e+Eg5SmXEXztDeLl0k7Tp
 5gjFnQkDvRFzXtYfoWA==
X-Authority-Analysis: v=2.4 cv=eYeo7LEH c=1 sm=1 tr=0 ts=6ac5456d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=07d9gI8wAAAA:8
 a=NEAV23lmAAAA:8 a=VnNF1IyMAAAA:8 a=zWGv387p14Tq1d7Pc1sA:9 a=QEXdDO2ut3YA:10
 a=e2CUPOnPG4QKp8I52DXD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_05,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060074

Hi Danny,

On Fri, 2026-10-02 at 11:18 -0700, Danny Hu wrote:
> On Thu, Sep 24, 2026 at 7:27=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> =
wrote:
> >=20
> > The lack of KEXEC_CMDLINE appraisal is an architectural constraint of I=
MA's
> > inode-based appraisal model. The kexec command line is a plain buffer p=
assed
> > directly to kexec_file_load() via syscall. Unlike the kernel image or i=
nitramfs,
> > it is not a file. There is no natural way to associate a signature with=
 it,
> > whether via xattr or as an appended signature. This is not an intention=
al
> > security decision but a consequence of how IMA appraisal works.
>=20
> Would appended-signature appraisal for KEXEC_CMDLINE be a reasonable
> extension, or is it deemed out of scope for IMA? I see code comments
> stating that buffers can only be measured and not appraised and
> recognize that IMA was architectured to appraise file backed objects,
> however, it appears technically feasible to use ima_read_modsig() to
> parse an appended signature from the cmdline buffer. The signature can
> then be verified by existing modsig verification helpers, and excluded
> before validating the terminating NUL and loading the cmdline.

The original IMA buffer was limited to measuring the buffer, but that chang=
ed
with appended signature support for the kexec kernel image.  So signing the=
 boot
command line with an appended signature should be possible.

>=20
> I understand this would require extending the current appraisal path,
> policy support, and error handling. Are there additional architectural
> reasons that would make this approach unsuitable?

AI mentioned a couple of issues, but none necessarily blockers:
- Size: boot command line size limitation (defined on per arch basis), migh=
t not
be large enough for the appended signature.

- Ordering: the NUL-termination check and length handling are in generic ke=
xec
code, so the signature would have to be stripped before that check, which m=
eans
changes outside IMA.

- Final cmdline: several arch loaders append to the buffer after it is pass=
ed
in, so the signature would cover the user-supplied portion, not necessarily=
 what
the new kernel finally sees.

- Binding: the signed cmdline should be bound to a specific kernel; otherwi=
se a
validly signed cmdline could be used with any kernel.

In lieu of generic cmdline signature support, a forced built-in cmdline (e.=
g.
CONFIG_CMDLINE_OVERRIDE on x86) lets the kernel signature cover the string,=
 if
that fits your use case. The tradeoff is that any change to the cmdline req=
uires
rebuilding and re-signing the kernel.
=20
>=20
> >=20
> > The threat model concern you raise is valid =E2=80=94 a caller with acc=
ess to
> > kexec_file_load() can supply an unauthenticated command line that weake=
ns the
> > target kernel's enforcement state, even when the kernel and initramfs a=
re
> > appraised. This gap is real and currently unaddressed.
> >=20
> > IMA continuity across kexec has not been discussed. Appraising the kern=
el image
> > and initramfs does not guarantee the target kernel will enforce an equi=
valent
> > IMA policy after boot.
>=20
> I agree that appraising a kernel image alone does not guarantee
> equivalent IMA enforcement after boot. However, the deployment would
> be responsible for signing and trusting only kernels that implement
> and require IMA continuity. It would also need to exclude older
> trusted images that lack this support.
>=20
> >=20
> > We would welcome proposals for addressing these gaps.
>=20
> An idea that does not involve signing the cmdline is to preserve IMA
> enforcement across kexec. The source kernel could hand over its active
> policy, which the target would restore during IMA initialization. To
> ensure the IMA subsystem has initialized in the target kernel, we
> could imagine a CONFIG_IMA_REQUIRE_ENABLED that ntroduces a readiness
> flag that init_ima() would set only after initialization and policy
> restoration. An unconditional check in kernel_init_freeable() would
> panic if the flag remained false, indicating that IMA has been
> tampered with.
>=20
> If the inherited policy appraises /init, initramfs signatures and
> xattrs would also need to be available before execution. I saw the
> earlier initramfs xattr proposal (https://lwn.net/Articles/788922/)
> but it seemed never to have merged, so it will likely need revisiting.

Refer to https://github.com/linux-integrity/linux/issues/11 for a more rece=
nt
version.

> This idea would prevent weakening IMA enforcement across the
> transition, although the problem of broader cmdline authentication
> still remains open. Would this be a reasonable direction to
> investigate?

Any help in reviewing and testing Roberto's patch set would be appreciated.

thanks,

Mimi

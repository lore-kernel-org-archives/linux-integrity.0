Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A86A32ED3A
	for <linux-integrity@vger.kernel.org>; Fri, 25 Sep 2026 02:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790303255; cv=none; b=HqNCL1p7sqyFlKP+89IKuSVyKmEVb/omPvYD8LlZ71r2W02UcPxzi9JROBD33v1rruhFGFXwP7cfv3hKZLz2SsFQJCYYsOGGUvVXfCZlVFcc50yEoIXEPtNmzVdhKCABz+eqQor2I+mrEHRT0YUKVSvpmPtkh1jzPmxea39mw14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790303255; c=relaxed/simple;
	bh=znqg67V5TjvnSD6E9JVZjAv37U4X5x4wMbyq/htgOIk=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=AFvWPBqqglOwoDVs17/UtccWlErRH5yu691bywfaH+TvIhnGHv3+KDH0HmHztRDSKDveE5ASq1Ol4h/wUniQB8+vMih61ZSYTdlxoRl3ziuyXMsriO+1spvVDCe3j6gWqYYhL6gQdBQGuVd1onITkuSnySA+lIyE6PXK104H6yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qJ47HuXr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qJ47HuXr"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P25qmT2741242;
	Fri, 25 Sep 2026 02:27:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=znqg67
	V5TjvnSD6E9JVZjAv37U4X5x4wMbyq/htgOIk=; b=qJ47HuXrDohAOfqW/w5Gia
	UEGUue10Y1s/EcPhCvpbRzffLvxgh7Fq4sVCqzJvXv9HRhSySV+DPA6VM18EaC+P
	3FcJP1q+BLX7icrDluzHhhcU4JaASLMXfx8j8Appz/UyfjsjPUcLK8G3MXwk2ToR
	kqOxudQRuDtCKYslo0/a2SLlPmUHCLeVPiXLEY8aFnGtqHetd1qjtRt/RK4ZePav
	E6FY7oM0dzhTKIPpTiKzROyuKTIk60g2Ow1tAhK/dLSrGVzEYDdzYf2klRzsG1Ck
	w5jXpOUIXg3fioRvEaCHJnE4VooeGjZRMhIb1PNhgNMTA5HzW9xWQdmwUJTbx1Ww
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgqutey-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 02:27:22 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68P1lgab2994293;
	Fri, 25 Sep 2026 02:27:21 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbt30krv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 02:27:21 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68P2RLcU20513496
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 02:27:21 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3CE605805C;
	Fri, 25 Sep 2026 02:27:21 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9061458051;
	Fri, 25 Sep 2026 02:27:20 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.81.48])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Sep 2026 02:27:20 +0000 (GMT)
Message-ID: <55d240d39dfbdac4d034380dd02f78838d09f061.camel@linux.ibm.com>
Subject: Re: [QUESTION] IMA: kexec appraisal and the unauthenticated target
 command line
From: Mimi Zohar <zohar@linux.ibm.com>
To: Danny Hu <dannyhu@arista.com>, linux-integrity@vger.kernel.org
Cc: roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com,
        eric.snowberg@oracle.com, Pierre De Abreu <pierre@arista.com>,
        Julien Gomes
	 <julien@arista.com>,
        Kunal Bharathi <kbharathi@arista.com>
In-Reply-To: <CAFn2k5AwOoHesnqB42kpfAGx0Wf-CtQbpU3px7LMj8PeiACvZg@mail.gmail.com>
References: 
	<CAFn2k5AwOoHesnqB42kpfAGx0Wf-CtQbpU3px7LMj8PeiACvZg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 22:27:20 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-2.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab5dc0a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=IwKq-39_mviHmJYBMSMA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAwOCBTYWx0ZWRfX6HlpyuyLRK1y
 l9zy3M1SF5iou1OihNueJHVdw+VOzHk2b/FeQIu9GBjh6LAv9/RMOxINmXKZ2MZlgUpORPzG0WK
 CV/FT3H5ByoXZfVdQ3Vuw/Qye2vN9uFOPF20u4ImGZXzVGGdPTt83mUHV+JdtERDpGejc7LJQYQ
 YeXg98zcgOYCG95zqPFR+vp2Qn73RFmEGKU/g7fbSu0iu1NYnAxaJtLkFT+mlbV3AZesK7QHPRR
 WeacCwsalrKhZ53KOgOqZMCjsyAV28ynpwYOLM4RZSOpzFp8tcDWs4AmvajSk1AghRG53YJZDko
 QLL+GYlOm9OuojN04TqD7uNvkZV3p/0umlUgDhEevDiLuHST/6JgC+O4+6Es5Rz8HN3CmVl9doc
 WTz2jF75NYDwz0sZVuI3uNjYDuzc8RAwdxBy83HWZsuqr3pqwKtxeTKETnP/+b3J7def+4lQrHw
 89VjYCeqEaUifa9z9UA==
X-Proofpoint-ORIG-GUID: kpztPbIPpVwskPoJcG1UiFlL8YK0UQMs
X-Proofpoint-GUID: NDJH-AaTGrlDh7dF3q0p_ZMVyaX-XW0p
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAwOCBTYWx0ZWRfX7f3pU10MP5Ko
 i4KhYHN7L6g38kzGBfOwpGHgOJ7zcfUxu0eOO89NxxabW0tndDX/8oZOKOF3+EBPb47CvVrC+Ri
 5WPZsifT+PDn9Zaipr8/W3E85sC8Hbc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1011 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250008

On Thu, 2026-09-24 at 16:34 -0700, Danny Hu wrote:
> Hello,
>=20
> I have a question about the intended security properties of IMA
> appraisal across kexec_file_load(). I am trying to understand why IMA
> supports appraisal of the kexec kernel and initramfs through
> KEXEC_KERNEL_CHECK and KEXEC_INITRAMFS_CHECK, while KEXEC_CMDLINE is
> measurement-only and cannot reject an unauthorized target command
> line. Requiring a signer-approved kernel implies that CAP_SYS_BOOT
> alone is not sufficient authority to boot a target kernel. Then why
> are command-line parameters capable of weakening the target kernel=E2=80=
=99s
> enforcement state not similarly bound to the signer=E2=80=99s approval?
>=20
> This appears to leave a gap when IMA is the mechanism enforcing kexec
> integrity. A caller permitted to perform kexec could use the signed
> kernel as a downgrade trampoline:
>=20
> 1. Supply an approved, signed kernel and initramfs.
> 2. Supply an unauthenticated command line that prevents IMA
> enforcement in the target kernel. An example of such is through
> =E2=80=9Cinitcall_blacklist=3Dinit_ima=E2=80=9D.
> 3. Boot into the approved kernel without effective IMA enforcement.
> 4. An attacker is then free to execute unsigned code or kexec into any
> other unsigned kernel.
>=20
> A few questions for the IMA maintainers:
>=20
> - Is the lack of KEXEC_CMDLINE appraisal simply an architectural
> constraint of IMA=E2=80=99s inode-based appraisal model, or an intentiona=
l
> part of the security model?
> - Is command-line integrity expected to be provided by another subsystem?
> - Have there been any discussions around a concept of =E2=80=9CIMA contin=
uity=E2=80=9D
> across kexec? By continuity, I mean preserving the appraisal invariant
> across the transition so that every accepted target kernel
> re-establishes equivalent enforcement.
> - If policy continuity was not intended, what threat model gives
> appraisal of the kernel and initramfs its intended security value when
> their execution environment can be weakened through an unauthenticated
> command line?
>=20
> Thank you for any historical context or guidance on the intended design!

The lack of KEXEC_CMDLINE appraisal is an architectural constraint of IMA's
inode-based appraisal model. The kexec command line is a plain buffer passe=
d
directly to kexec_file_load() via syscall. Unlike the kernel image or initr=
amfs,
it is not a file. There is no natural way to associate a signature with it,
whether via xattr or as an appended signature. This is not an intentional
security decision but a consequence of how IMA appraisal works.

The threat model concern you raise is valid =E2=80=94 a caller with access =
to
kexec_file_load() can supply an unauthenticated command line that weakens t=
he
target kernel's enforcement state, even when the kernel and initramfs are
appraised. This gap is real and currently unaddressed.

IMA continuity across kexec has not been discussed. Appraising the kernel i=
mage
and initramfs does not guarantee the target kernel will enforce an equivale=
nt
IMA policy after boot.

We would welcome proposals for addressing these gaps.

Mimi

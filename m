Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B521397923
	for <linux-integrity@vger.kernel.org>; Wed, 29 Jul 2026 17:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785347760; cv=none; b=ByUf/QpZxa0Pb48oEksR6sHq6Tc6SZiiJVUiF+zyowCAbgtVtQeAIf+sJ2FsRD+Rj0+DiwMTeGAH3BwCX7C13Opq8l3UyahBIRSIPigTSoM+fK2oyGESX3HJE0ifodKdgzaP7dXKW6spuNIZ1chKbijKmXRjiRCMTOwEIfTM/hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785347760; c=relaxed/simple;
	bh=3u0iXIOpRuro/S6ivbIogWND2AXNvpVGKGDKGirxDBk=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=lL01xkhVO8l/HmxxcLSni9m8bsQgCsxg5oqHQKRkDKvKgWPM9pSEvE2jPIQ4JVGHswGRcT15DLo+P0AAe4nOPd2meZAAGrYX+o+6iCFp6HGWUPETd0E5545/ehov8t1aGsXjvn4ufYrVIoBbAPIhNNfLZ96TphqcdMXyB8pPpVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Idaann5r; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Idaann5r"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TFIBav284430;
	Wed, 29 Jul 2026 17:55:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=kIgaKQ
	XWcfZ1D1aZocHiBrx509/dikRRbzOYAOfrhbE=; b=Idaann5ri4NaO6/wNv0QcE
	osJtrSz0lNcItot81oQs0RWyA1dY2zFv4tM+wnOrwUnvzE8LDHGIN+5Kw3JOmrWo
	CW6iZOj5BdNeSkvEdzo5yKunSgQY+1OOvjes7D1gjX+KlRipCPjUrTpsO8aYV+js
	KpfjIQee44CWftE0zBQpSZvNMdBHvIfprxrkHp4FU4cjhcVsCC3fUF8fFjAaGwsd
	zXqy3dVLCPmJLELiOlgwNxzO+RV+BJHB/mMxuAJD40+wqZJXXGLXz8pSqAOLEXGC
	b4aymbVVChjUqgmf7nrL/HBOqhEPvo8S8WsEGrgcG/icsViFeqPJtfHT2N9jD9Hg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0nu5yu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 17:55:42 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66THfGIL018395;
	Wed, 29 Jul 2026 17:55:42 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fk7thw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 17:55:42 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66THtfxK28181246
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 17:55:41 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB9955805C;
	Wed, 29 Jul 2026 17:55:41 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 41E765805A;
	Wed, 29 Jul 2026 17:55:41 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.31.108.66])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 17:55:41 +0000 (GMT)
Message-ID: <7279643f66b2ea6d6888716f7923363c2f59b6eb.camel@linux.ibm.com>
Subject: Re: ima_setup.sh: Fix check_policy_writable() for kernel < 4.5
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, linuxtestproject.agent@gmail.com
Cc: ltp@lists.linux.it, linux-integrity@vger.kernel.org
In-Reply-To: <20260728133556.GA1128467@pevik>
References: <20260728114224.1055009-1-pvorel@suse.cz>
	 <20260728125815.4069-1-linuxtestproject.agent@gmail.com>
	 <20260728133556.GA1128467@pevik>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 13:55:40 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEzNyBTYWx0ZWRfX1JWC+f1yRS/K
 e/RraXScbo/8eqY3cHd/+9LPk6NYGNVC6dvcT7D/6i9XvCn0nqyYWKa4lE8PEK/JqqNN7BFgm4Z
 nGHSurv4nQa2D59z5Nw0XihoQgtDj6w=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEzNyBTYWx0ZWRfXwnYpvRmynRFo
 VMvpazXguNLpRkU1Zur+17Rifg71xHDowK2c+smDvj1UeayNL+xuZnZSDrU00R1tVBoI7KzcMgk
 w56ZqkxKUyUGto3VXik6wLrnbIJx39IJmu1uUq7AolyTpvW4RXmM5xEZTFdsYbMVUzn596Zy+J9
 KkUzaEmyjDNvUqfjDMosFo6MKCB33tL7yJ7GQyRZSA0Frv8ZlaIlWQ3WfStbSVwPMsDdHEn09wh
 U+UFvsDof3lBundbsbltaBTTNzRq1vQdr5e8tKi9q7i4GkRnSoPtoC0fLaC6vboPY9wL4HwSHOE
 jhXqcV8h57q4c9jqOCrkIPbQwAnMhmRGg8lBF/t4KsgCKos519ezjBkXvZeYseaszBlRGUxNRoa
 JLE898CeTXf9y3zBpImWbgK4pbdQFMV3enKNiKfmgD41Q2oR2UZ504ImfiQWUXBBzt8+MWHcX9W
 jtKQ+U5QKAxWWHBjhJg==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a6a3e9e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=kLBT1emeShgpeJOJY6cA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ZdORQgrXuODFcVdXcn7RObsXSYd0nsIL
X-Proofpoint-ORIG-GUID: hnKvgR72_XESAT5vhuFJavPE0cXgvmfF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290137

On Tue, 2026-07-28 at 15:35 +0200, Petr Vorel wrote:
> Hi Mimi,
>=20
> once you have time, I'd appreciate your comments. Thanks!
>=20
> > Hi Petr,
>=20
> > On Tue, Jul 28, 2026 at 01:42:24PM +0200, Petr Vorel wrote:
> > > ima_setup.sh: Fix check_policy_writable() for kernel < 4.5
>=20
> > > -	# workaround for kernels < v4.18 without fix
> > > +
> > > +	# Workaround for kernels < v4.18 without fix
> > >  	# ffb122de9a60b ("ima: Reflect correct permissions for policy")
> > > -	echo "" 2> log > $IMA_POLICY
> > > -	grep -q "Device or resource busy" log && return 1
> > > +	# Require >=3D 4.5 to write multiple times via CONFIG_IMA_WRITE_POL=
ICY
> > > +	# 38d859f991f3 ("IMA: policy can now be updated multiple times")
>=20
> > Is CONFIG_IMA_WRITE_POLICY really the reason for the 4.5 boundary here?

Yes

>=20
> > On >=3D 4.5 ima_release_policy() runs ima_check_policy(), which returns
> > -EINVAL when ima_temp_rules is empty. The empty write therefore sets
> > valid_policy =3D 0, ima_delete_rules() is called and IMA_FS_BUSY is
> > cleared, so the probe stays non-destructive even when
> > CONFIG_IMA_WRITE_POLICY=3Dn.
>=20
> Well, CONFIG_IMA_WRITE_POLICY did not exist in kernel < 4.5 (not sure if =
that's
> obvious from the comment I added).

Perhaps prefix the commit message with something like:

IMA allows the builtin policy to be replaced with a custom policy just once=
.=20
Support for appending additional policy rules to the custom policy
(CONFIG_IMA_WRITE_POLICY) was subsequently added in linux 4.5. Refer to com=
mit=20
38d859f991f3 ("IMA: policy can now be updated multiple times").

>=20
> > What makes < 4.5 different is the absence of ima_check_policy(): there
> Yes, that's true that ima_check_policy() was added in v4.5.

Agreed.

> > the empty write is committed and securityfs_remove() drops the policy
> > file. Would it be clearer to state that, and to keep the v4.18
> > permission workaround in a separate paragraph, since the two comments
> > describe unrelated things?
>=20
> > > +	if tst_kvcmp -ge 4.5; then
> > > +		echo "" 2> log > $IMA_POLICY
> > > +		grep -q "Device or resource busy" log && return 1
> > > +	fi
> > >  	return 0
>=20
> > With this, require_policy_writable() no longer TCONFs on < 4.5, so
> > ima_policy.sh test2 ("verify that policy file is not opened concurrentl=
y
> > and able to loaded multiple times") now runs there.
>=20
> Hm, maybe test2() does not really makes sense to run on < v4.5. But test1=
()
> certainly does. And echo "" > $IMA_POLICY really disables policy in v4.4,
> likely due one of these from v4.5-rc1:
> * 38d859f991f3 ("IMA: policy can now be updated multiple times")
> * 0112721df4ed ("IMA: policy can be updated zero times")
> @Mimi WDYT?

Writing an invalid policy resulted in never being able to transition from a
builtin policy to a custom policy, similar to writing an empty policy. Comm=
it
0112721df4ed ("IMA: policy can be updated zero times") addressed the invali=
d
policy case.

>=20
> > On those kernels one loader gets -EBUSY at open, the other succeeds and
> > the policy file is then removed on release. That hits
>=20
> > 	elif [ $rc1 -eq 0 ] || [ $rc2 -eq 0 ]; then
> > 		tst_res TPASS "policy was loaded just by one process and able to load=
ed multiple times"
>=20
> > so the test reports that the policy can be loaded multiple times while
> > only the concurrency half of the assertion was exercised, and loading
> > twice is not possible before 4.5.
> That sounds correct and should be fixed.

Correct, IMA originally permitted transitioning from a builtin policy to a
custom policy.  Support for extending the custom IMA policy was added in 4.=
5.

Mimi

>=20
> > Should test2 report TCONF (or split the two assertions) when
> > CONFIG_IMA_WRITE_POLICY is not available?
> With requiring test2 to be run on kernel >=3D v4.5 (I'll add it to v2) ev=
erything
> should work even with this patch (unmodified behavior on >=3D v4.5, avoid=
 write
> policy on < 4.5 when doing the check for ima_policy.sh test1 and for othe=
r IMA
> tests).
>=20
> > Verdict - Needs revision
>=20
>=20

Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7974026ED4F
	for <linux-integrity@vger.kernel.org>; Mon, 17 Aug 2026 22:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787004821; cv=none; b=dBmOzc2Ty7z3XNFIIJHBfNIYQPbc5rbMgX4OsFu8OiPT0Yah3ThOXXsT6DF09QFOV+pJLYhQt+XkrdwEkhur8/fQYmn+IRqzGU5klO9gQ67fbO/f+RM7cjpB6AxUeRyKJj6Hwn6XxAxxZj0qv1+49g5geOcedt4s+/kQg6PSQ+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787004821; c=relaxed/simple;
	bh=Tqfl9Sj7ON8bYdhXkeDs5yDZ3txyiPJnY5B3fRgmgpc=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=OoAX/ooAOf35owWGZB2gpJXf1Gsc9Hjtf6nzSh8aBFb3cgIKOethS+LY1g5TWdavSfYMI1RAQEpEnvjlBziUVNR4gY3h7IVmpq7CzoaSJRZYjHtclxdI8fDJnVGWHkV3cAIqFs+CQAgPCMaa6oBs+f6dBbgur4INcpm/ozDzoCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YLtO7B2L; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YLtO7B2L"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HM1c68758949;
	Mon, 17 Aug 2026 22:13:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=q16JZO
	9J4xeP9WkDPSNFS4FchR2vA+laWBYbrrIjXSQ=; b=YLtO7B2LYBnD10MS+Shl2f
	KJSvUyjZOIYamXTrVS03KxJQ2eM2FTKWcPnCCZpAvBco8C6I9GDPgDPHPsBa8iML
	3X1EPzKMkKfiN/6EjxoH5UThrbGw29UaMztj6UJal7AD9QqLPWSkhDukd6ro+1A3
	uOpYZtXQ5eyEgjhmvbshEMfNZ/KOi4tvRri4fYD9GTwfQrs5K/1brDmelzRjHBTh
	2Melc+LaXLWYG0pPBvn8liPzmVnVgkaN6fHwT0g3rTlLb8JbS2aztFCwAdiPsbLg
	7xkwScpT7Se+XF64XvUw/qcCR7K3rfepKKFraE94WYFP4noIdl7Af/4B8Du9uONg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fsqmp3j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 22:13:35 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67HMBi6V031377;
	Mon, 17 Aug 2026 22:13:34 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354y7t43-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 22:13:34 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67HMDXKZ22414006
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Aug 2026 22:13:33 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4489B58059;
	Mon, 17 Aug 2026 22:13:33 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BCE6458058;
	Mon, 17 Aug 2026 22:13:32 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.11.167])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 17 Aug 2026 22:13:32 +0000 (GMT)
Message-ID: <2fb152d374a14a0e30b20de73d74a90b195e0793.camel@linux.ibm.com>
Subject: Re: [PATCH] ima_tpm.sh: update test2 to detect integrity violations
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it, linux-integrity@vger.kernel.org
In-Reply-To: <20260817105556.GA1951950@pevik>
References: <20260814135704.1247403-1-zohar@linux.ibm.com>
	 <20260817105556.GA1951950@pevik>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 18:13:32 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDE2OCBTYWx0ZWRfX2/Hx/HJW546D
 repS9XPAS4Em/y1KiMgNzYP6p2I1dtJwiydxir34GrmfabZt9t4q6+aY9yi64fPP/2RaCnfILsD
 ijtRrdKVbd/5QOuBUgmDN5mHJVC33uYaPFdFqpNVg3AkhSvitOnKqrUjGd5HPq6hmGY1sPNsiUG
 eMxUeB8xqDCA1XF15KrY5R1fOL0bCtBeYpy5K26B/GSBy2xY64PO6v+AUkFsNSlBesmh9WJPwli
 KpZpiICtYqQ9LyFsm1IOD+ehYXlAFFJQ6N8Blm12G05Pq9tX5CJuehGrRvKzj4fg1cFnPlzDEDF
 OSmA6vKOyc/OHR0x4fXYdEwxgQ4Xm++inzjSIVvJjwOjMge7EFuwMthQaN7d5UdtQ8EMGgSlZsX
 EDsTqm1umlMvvhD2sRZygzVSWbjN45O7Q0h4sWSg32ROWE3p4sWIeUbJljwd49wJBmggCGk4iWA
 B0r5ELBV9A5JloMNVHg==
X-Proofpoint-ORIG-GUID: 36ss2kx5yaistmmORZ_JKd3aPs80BoSB
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDE2OCBTYWx0ZWRfX37J93XU2wCmF
 KiX12EwvUl7fyCs0wgISbmZ5RUJdRKqXXN3Q50ag6eHpCYBbRQ6GFMMfrA6/Mua5vg+4vHWYuuK
 ylmtLPi2w8TQg5nrNgGFcn856N44fgk=
X-Authority-Analysis: v=2.4 cv=DJe/JSNb c=1 sm=1 tr=0 ts=6a83878f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=NaXFS9rsp0321YIt4qoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 36ss2kx5yaistmmORZ_JKd3aPs80BoSB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170168

Hi Petr,

On Mon, 2026-08-17 at 12:55 +0200, Petr Vorel wrote:
> Hi Mimi,
>=20
> > <securityfs>/integrity/ima/violations reflects the number of
> > integrity violations.  Include the "--ignore-violations" option,
> > if there are any violations, on the initial IMA measurement list
> > verification.
>=20
> Thanks for your patch!
>=20
> LGTM and it should be fixed. But there are some potential problems
> (see bellow).

And here I thought this was a simple performance improvement to execute evm=
ctl
with/without the --ignore-violations option once.

>=20
> > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> > ---
> >  .../security/integrity/ima/tests/ima_tpm.sh   | 20 ++++++++++++-------
> >  1 file changed, 13 insertions(+), 7 deletions(-)
>=20
> > diff --git a/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh b=
/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
> > index 5d34d8679..acd8b6d30 100755
> > --- a/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
> > +++ b/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
> > @@ -142,6 +142,8 @@ read_pcr_tpm2()
> >  get_pcr10_aggregate()
> >  {
> >  	local cmd=3D"evmctl -vv ima_measurement $BINARY_MEASUREMENTS"
> > +	local violations=3D"$IMA_DIR/violations"
> > +	local num_violations=3D0
> >  	local msg=3D"$ERRMSG_EVMCTL"
> >  	local res=3DTCONF
> >  	local pcr ret
> > @@ -151,16 +153,20 @@ get_pcr10_aggregate()
> >  		res=3DTFAIL
> >  	fi
>=20
> > -	$cmd > hash.txt 2>&1
> > -	ret=3D$?
> > -	if [ $ret -ne 0 -a -z "$MISSING_EVMCTL" ]; then
> > -		tst_res TFAIL "evmctl failed, trying with --ignore-violations"
> You removed TFAIL (potential problem, see later).
>=20
> > +	if [ ! -f "$violations" ]; then
> > +		tst_res TINFO "missing $violations"
> > +	else
> > +		num_violations=3D$(cat "$violations")
> > +	fi
> > +
> > +	if [ "$num_violations" -eq 0 ]; then
> > +		$cmd > hash.txt 2>&1
> > +		ret=3D$?
> > +	else
> > +		tst_res TINFO "ignoring $num_violations violations"
> >  		cmd=3D"$cmd --ignore-violations"
> >  		$cmd > hash.txt 2>&1
> >  		ret=3D$?
> > -	elif [ $ret -ne 0 -a "$MISSING_EVMCTL" =3D 1 ]; then
> > -		tst_res TFAIL "evmctl failed $msg"
> And here again removed TFAIL (see later).
>=20
> The main problem is that you removed the code when evmctl is not installe=
d.

If I'm understanding the code correctly, the original code executed evmctl
whether it existed or not.  Let's fix that first.  My question is whether t=
he
test should fail or be skipped?

>=20
> Therefore trying to rerun evmctl on failure on older release (e.g. 1.3) i=
t will
> fail due option have different name or not exist at all in evmctl < 1.2).
> -a "$MISSING_EVMCTL" =3D 1 check had meaning "don't rerun with --ignore-v=
iolations
> on old evmctl which does not have the option.

Thank you for the explanation.

Before appending the "--ignore-violations" we should make sure it is suppor=
ted.
I guess for backwards compatibility we still want to verify the measurement
list, knowing it will fail.

Hopefully with these two changes this patch will work properly.

Mimi

>=20
> FYI the code is a bit complicated, because here on TPM2 we require evmctl=
 1.3.1
> to have --ignore-violations (renamed from --validate), which was released=
 in
> 2020 - too new for old enterprise distros to ignore; also TPM1 we require=
 only
> 1.1 from 2018, probably still too new. Once SLE12-SP3 EOL (in 1 year we m=
ay just
> expect 1.3.1 to simplify).
>=20
> > -		return
> >  	fi
>=20
> >  	[ $ret -ne 0 ] && tst_res TWARN "evmctl failed, trying to continue $m=
sg"
> Back to removed TFAIL. While this is OK as TWARN (some problem, but not r=
elated
> to testing) we might end up to TBROK "Test didn't report any results" err=
or in
> tst_test.sh which quits test with TBROK "Test didn't report any results" =
if
> there is no TPASS/TFAIL/TCONF message.
>=20
> _tst_resstr()
> {
> 	echo "$TST_PASS$TST_FAIL$TST_CONF"
> }
>=20
> _tst_rescmp()
> {
> 	local res=3D$(_tst_resstr)
>=20
> 	if [ "$1" =3D "$res" ]; then
> 		tst_brk TBROK "Test didn't report any results"
> 	fi
> }
>=20
> And this happen later in test2():
> 	get_pcr10_aggregate > tmp.txt
> 	pcr_aggregate=3D"$(cat tmp.txt)"
> 	if [ -z "$pcr_aggregate" ]; then
> 		return
> 	fi
>=20
> Other option would be to print TFAIL message in test2():
>=20
> 	get_pcr10_aggregate > tmp.txt
> 	pcr_aggregate=3D"$(cat tmp.txt)"
> 	if [ -z "$pcr_aggregate" ]; then
> 		tst_res TBROK "failed to get aggregate PCR-10"
> 		return
> 	fi
>=20
> Lol, I'm disappointed how complicated and error prone I wrote back then.
> Part of the problem is that quit with tst_brk does not work, when code wh=
ich
> does it is run in a subshell (via $(...) or `...) ), which quits subshell=
 but
> not the parent shell.

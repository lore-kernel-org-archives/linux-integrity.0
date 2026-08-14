Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834101F3B8A
	for <linux-integrity@vger.kernel.org>; Fri, 14 Aug 2026 03:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786677143; cv=none; b=Noa8qPc24vsWPRBxyB/Y+P8s2Skw/uBsX7PMYnOv0uW3te6wV+VUgw/Pt1KzcL+b3D7L0ETLeGhP+92y/I0/Svc4bQNpv3+8a1fKPGuQaCMC6Ir6KmjwsAiW+CW6U4bsYMiKtbrK0OHAqyyyBU9HIA+E37izQUL59klPFSrNv8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786677143; c=relaxed/simple;
	bh=5/VU6EZfKDu5QzMq1KjwO0m0ECTgazNkN2mHN8C+IEE=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=nENh7wlsh+FYWAsJJul25/TgS6t09slEBGeSalUjwOuUJEJzX/CYehCWYEP9yqiB4+zGoVOrY/c9b/2ubS/0ez4xO6wdh6o2VUmMo8YH8cnW09KCCeCUJZNtNrE7VGqbbIQXayl6UREPgAfrJcXfuJepXTwjqktSVsf6IGDmls8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WoALDk5G; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WoALDk5G"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67E1Vrlm2877545;
	Fri, 14 Aug 2026 03:12:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qOE5FT
	wGT6aZ/hLAQO3rKQCEmKJxSmnc9DpClpC0fh0=; b=WoALDk5GeXcwk6pnwFtWsr
	72BXVSBFcY8AxIQDOymXnB9RNxuq+yA+dKC1JQ61J7hAjWOipuRvQjeu2dWucbOY
	e8EDr0bNH7t8D+5z4b9HzU/GwRvYEYgohAH4t4mlY45x1Ho7WpA5a9NGcbIXt3vh
	jyQnQjsRZ8QyKNvZSSBeDcESgUH/1AIrvyw8EISuBcASNf8xuMtEs3E8ag6vUvTN
	SlKdvkdg4YmwDig+eFKKTXMyH7VUwCFs68Nk8dAYk0si2WRchsERySP2luRs3N9O
	IJucUHaz+KBI5daDK0rWbxk8BCQyG57uQV1dTO/c7xLce1mFExp4AobpyPU3Hmfw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fyb243680-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 03:12:09 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67E3BLqM013070;
	Fri, 14 Aug 2026 03:12:08 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0gnghu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 03:12:08 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67E3C7Ub29033204
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Aug 2026 03:12:07 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B53935804E;
	Fri, 14 Aug 2026 03:12:07 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B9295803F;
	Fri, 14 Aug 2026 03:12:07 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.7.32])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Aug 2026 03:12:07 +0000 (GMT)
Message-ID: <2651c2c94ced4a363a5206a983cf7fd86c46def7.camel@linux.ibm.com>
Subject: Re: [PATCH v2 2/2] ima_policy.sh: Require kernel 4.5+ for test02
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Cc: linux-integrity@vger.kernel.org
In-Reply-To: <20260810143344.1029588-2-pvorel@suse.cz>
References: <20260810143344.1029588-1-pvorel@suse.cz>
	 <20260810143344.1029588-2-pvorel@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 23:12:06 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a7e8789 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=4LehP-HEuwBpZdEOSaMA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDAyNCBTYWx0ZWRfX8Uksyf3Dfeyp
 AutHIKcgss14QwjmgyiAD6ksyr5gFZtADGzjmQ9kzIwyuSJ3awB9LedQPgxnO0OeszmXB1ZgOHR
 RSN6xL3o0tE2cRlf6SEZSEOCH74p+FooZIDrEFwHW11KPDDO9zdfiVLEzPULjOTc5rlWNCZtX6c
 /Tz3+7NRv80l7gPN8vT6oPApqhXp/wGHlvsalzoevAey0k20PuwSjhfX1uTannwGrQ2mdeqTtUP
 CiRKki2u5vVlLcbQdhLiOdpKuiL+v6bf3zkxb5PAIVcDm0n0DexJBXPqGNhIP3keW8dmZDJ8xvi
 85/URJ5GscLVSHFDswCPKrhJut2mfSQWRwV+QDhe56QfScFIkzpyMyD/2gi7Be0r0pjly98X8xp
 XDElGMAyq9tSeG14ai8JKVLrde2UaETEro49KRGtakr93vPwWPaImxiZJd64oXikzeDUpdaFedg
 eMVvYR85ifxX/SIW4/g==
X-Proofpoint-ORIG-GUID: Qw3qe00huqYWj9fi1N5yOe20x1eJIbGQ
X-Proofpoint-GUID: Qw3qe00huqYWj9fi1N5yOe20x1eJIbGQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDAyNCBTYWx0ZWRfX68IcaxDTmzBE
 bslnPs7Qe87bzvxwBFHZMDAxu8xG+OMxV5Vb/UvDbh42uT3n9Ej3BczDjizXnzkclINzvu0SNqY
 riOfco7SXrYLsYQhCPfw+1PGsP8iD1Y=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140024

On Mon, 2026-08-10 at 16:33 +0200, Petr Vorel wrote:
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> New in v2.
>=20
> @Mimi I appreciate your RBT or ABT.

Thanks, Petr.

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

>=20
>  testcases/kernel/security/integrity/ima/tests/ima_policy.sh | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_policy.sh =
b/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
> index d66f261a81..e6f4ff133a 100755
> --- a/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
> @@ -60,6 +60,11 @@ test2()
>  {
>  	tst_res TINFO "verify that policy file is not opened concurrently and a=
ble to loaded multiple times"
> =20
> +	if tst_kvcmp -lt 4.5; then
> +		tst_res TCONF "test requires kernel 4.5+"
> +		return
> +	fi
> +
>  	local p1 p2 rc1 rc2
> =20
>  	require_policy_writable

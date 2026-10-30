Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793370949;
	b=EtW1OGKRgrqPpq5dtxmeRlekpT66WNCWDV1+5895PS/Ql9oPP5bo4waZCDTa8tP+NrIt
	 UxmN0qFgnXhNh8r+TNKDMqdj8ZI+m5nmM2bfykz1SfjSv2eBkzr83ugOvH9WrgoE2KOM+
	 fuT4EfF2ehB3+XnBKD9unYNR+a3BZtKPaAdqs0H7tzfDCYQcuDH5xuqeJxpYxqVpdMV2X
	 uHxeJBBe/YwdwJrSt+1sZ12yBwIEhIX/2nSHx/9sWfzqG17hmVH8uzPhoWU7f9jrlDwRo
	 T4EhgCmw/gsfoZ2Nbf/tKFoBFIJG3RgOGaUcbYXZt6teVttY59hBnQQzCcwD028PIOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793370949;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Subject:From:To:Cc:
	 Content-Type:Content-Transfer-Encoding:Date:MIME-Version:User-Agent:
	 X-TM-AS-GCONF:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=7XaX5yU1MuZsYfPEiCc0AYOOMAtv5l7Gnvv6ve5depg=;
	b=lNQBp7XoAICRGRZMSf4mX2ka8QbfJNIsgY0rvLPTMYccbogFKF2U8Qa5HLAlU8/iUA8u
	 FlvqjNn/qz5j7CBZ/nr66gIi96xpY5uDx7W39BYU9dJdH8k4ZMTaWGr6V1j1sjPfZwVmx
	 QFXcaxp25TAQgg+TIxQG78jTo3hLuVQUGiVqlWK30E3qnLAuA4j3e58ABIWPqvnrsRPKH
	 j/9UNIXaziVeF6iZQtiVTNoTjwBSLixBo4+zh7Px5Hp7krpWMMI7mCAl5sEQzic2msMdV
	 TGC0KijfBQp158CgaKHHSllhjMPpCEzd34UyFIpEVX3DfEEd7FAc41q2lBZzxaUGoSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=oZmfKqzz;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF33606A31A
	for <linux-integrity@vger.kernel.org>; Fri, 30 Oct 2026 14:35:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACF33606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=oZmfKqzz
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69UBIQav1600267;
	Fri, 30 Oct 2026 14:35:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=7XaX5yU1MuZsYfPEiCc0AYOOMAtv
	5l7Gnvv6ve5depg=; b=oZmfKqzzUCjMqsSYfyM9Rm1c+tv1N5r/2AOHZfDhvgdQ
	yXk0kpmv/bToSoX3GxhPlwyJfcwF7t2jmn4V+okbJBN5oAfoh1v9n0jlqTu4YSH/
	geAZblMDBP1JokfYlfTsIZIJB1rJSMFXWVu2sK9Zh4HJsMLExvHV37LaNcy0M8Ak
	FMiGaxiegy/JCmBZTq5g5g62JbZX+rY0O/nYUlWQXroEmU0pum9AGwqwAZSge+qY
	zVN71EReKNrgoZ1U7vuu37+Xgap+pFcF5hGmTvNcaI80GVxcZ5hSJo/MPJ4MhDBX
	fY8Nzb8ujX0WW12EdjkB6oVUUtgfM7ySbfAooCga6g==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hmeayu5xt-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 30 Oct 2026 14:35:21 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69UEZ1I0691333;
	Fri, 30 Oct 2026 14:35:21 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hma543tmw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Oct 2026 14:35:21 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69UEZKYW33358584
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Oct 2026 14:35:20 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4EFF35805B;
	Fri, 30 Oct 2026 14:35:20 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A2C6058058;
	Fri, 30 Oct 2026 14:35:19 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.90.173])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 30 Oct 2026 14:35:19 +0000 (GMT)
Message-ID: <cde3798ee896e1538b38fc400cb02119ce54dc3e.camel@linux.ibm.com>
Subject: [ANNOUNCE] ima-evm-utils v1.7 released
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity <linux-integrity@vger.kernel.org>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Bruno Meneguele
	 <bmeneg@redhat.com>, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov
	 <vt@altlinux.org>,
        Stefan Berger <stefanb@us.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 10:35:19 -0400
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-2.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bzzXekdvdwrPBsTbA_qVIPcPTtM2q2qo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1NiBTYWx0ZWRfX2D5H1k51aR5L
 QdqHpfrKYzpdr30R0ldSxsWdM2eeNiIQ2wxlRtyQH/Vxz09BXj3ky4uYjx0xMyMA1n0FdYRknBl
 U8g/gW3r3A6gKD1p3S7OdWG8qGRc1bJ25I2oNv29VJJ2Gevc7db8WC39iFWbj21HW/w4yytdfth
 Rm3b4/xEXeCqGRwibvUMq6zDwqCOsZT0oPRRPv/dJv+Gl7C9n87HNw89cZba+1B27WHHG9dqWtO
 aVBHi6paFJJ3Kc+AY9lXHv71mMCemzsnGlvRl7Fv/9gJhQX2PiLU13egqXoJLZlc6yQB6i7iT9y
 xj3pn2qGrPdZF1SNWocS2TRu6tV5HZxm2lqYz2O16dgev6vqwpepWQbbKtvWTaOSlYShv8hhCqJ
 uWyf67Mu+ZPHf8zGXLfF7JaAUFiqsf+Waga4NiA6zWMMFPSxE3kaewgXAvaLENYBwp5kwwY025H
 iO35nmAZisbN+HcU5ug==
X-Authority-Analysis: v=2.4 cv=Ms3HeGae c=1 sm=1 tr=0 ts=6ae4ab29 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=NEAV23lmAAAA:8
 a=HWrzk5iPIFjweBkEaMYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1NiBTYWx0ZWRfX1H3xCaUKDROm
 /ge0EtGmJD7wUr8D/jHsTNoWeAzWcDmwbQ5/jl10aFZOvb9xArd4JAN8N/8PfCk3isV0j3vm+lA
 1WuT3XRb11xzg+KnCQhgIKonAKnqU88=
X-Proofpoint-ORIG-GUID: bzzXekdvdwrPBsTbA_qVIPcPTtM2q2qo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 spamscore=0 adultscore=0 clxscore=1011 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300056

ima-evm-utils v1.7 was released on October 26 (commit 08723a20e00c, "Releas=
e
version 1.7"):

https://github.com/linux-integrity/ima-evm-utils

The main changes in this release are:

- IMA and EVM signature v3 support (--v3).
- ML-DSA post-quantum signing support. ML-DSA requires OpenSSL >=3D 3.5 and=
 Linux
7.2, and is limited to sigv3.
- A significant reorganization of the tests: the tests requiring an IMA cod=
e
signing key were moved to a new tests/kernel subdirectory.

I'd like to thank Stefan Berger for the signature v3 and ML-DSA support, Ro=
berto
Sassu for the new tests and testing changes, and the community in general f=
or
their help.

Please refer to the NEWS file for the short summary and the git history for
details of the ima-evm-utils v1.7 release.

Mimi

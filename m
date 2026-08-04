Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD3547FAED;
	Tue,  4 Aug 2026 16:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785862422; cv=none; b=QndCOukHcVbf5Ijm53WCpQnx/WIiwh8Sd+9wYDX6QM3o2Tfym4Dk3XOP4NL8+KOCacbS2sWuRo/9V0ujGLZn25D3/lDKV5FLW0udggruzMnS33gkwz6isIQFcGzKiGutWS5C1QlaXqn3w2epI8FQ0x5LExFFvtHOj1Mnsf7FzS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785862422; c=relaxed/simple;
	bh=+yhBzeGXF4P3sNmF3SjWv0eWrEx9tlAKZAadKPFtVw4=;
	h=Message-ID:Subject:From:To:Cc:Content-Type:Date:MIME-Version; b=uUPqWbFbmktzqemc0YQ5semRalh0kczDQ1BoUnGxVu3Xljx+n5HcDg2YzsEHbUdCsUy867dMSZjcWroZGTdMiT48MqYp2yxAcaQjsoMFLqJBZ5GheTpseh+ZO+uLdQ1wTxvXRWjRifhOL889BeeES3qUdo3W5BLr8Lb9UZAeKlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EyojGZtZ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EyojGZtZ"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674Flkdr1192233;
	Tue, 4 Aug 2026 16:53:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=pQjReup/4WmAj+57BEdhDFalN/NU
	Z4fROiXhg2orbdY=; b=EyojGZtZNLfg8l/fP4JC1l0dQQRmHQ+bbbW+1IPx34jY
	YX1s45a2sDPqqfzR8kx+zzmU1h9fswL+1i6FKfiiFL8L4Z3Qg/sxP/PJLKdQh93N
	EAOvjHM230D/noY/W+vCDoo0m/spnKh71TSzAdgBUw8uq+CtsXXWaHVcNt2p64eK
	CqDP8SwqEU4ilXWt3t7OaIwkDYkfTvZWkgE4tP3Tl7qUPTHxr9vsd/dwKUZb4voV
	GXVgES+HcRfrBWODMKXdyULr1rBJHNKir48f8VaxmNP814ttKS5LKzAkl5B6I5sH
	KE9ArbMROl8ZjRoGivmkb2LyHmj8goKWofzyaPtPug==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67hpsh5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 16:53:10 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 674GfJf3014330;
	Tue, 4 Aug 2026 16:53:09 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4k2u7t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 16:53:09 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 674Gr80931588874
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 16:53:09 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CFD7558059;
	Tue,  4 Aug 2026 16:53:08 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7D54758057;
	Tue,  4 Aug 2026 16:53:08 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.135.125])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 16:53:08 +0000 (GMT)
Message-ID: <1ace49db9726d140de8e4cc4c91ae53b0a060bea.camel@linux.ibm.com>
Subject: [GIT PULL] integrity: subsystem fixes for v7.2-rc7
From: Mimi Zohar <zohar@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel	
 <linux-kernel@vger.kernel.org>,
        Roberto Sassu
 <roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 12:53:08 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDEzNSBTYWx0ZWRfX/z1acS/apJAN
 RNM/KI1hLPn9psnrVs9jxM5D6IflCkJ2MpnWA6Y+WpJ9Sb/9yhwZOY3YfB27mDBuq2DAWd/Jo9C
 IcNCerafWeyO+zdgFkJVKIjYF5+hmJ4=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a7218f6 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=FWwAVGKfw4JQas9rDcYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDEzNSBTYWx0ZWRfX9mtvoEQoGWUE
 pZeM/0WEFmSP5FVjsOJiTiZuIIYRXx/jFsCHJ+89LtSmliWsstpd8B4NTRfgBU7G0P7UeL2QKV7
 flYqKTuM7kQyfMvgOrCiahwCFmHWOxNYyw0dtzCK117hTzSBKTHo5oe4tkdhnNCR1558GgGBPhi
 W4YMAbHepu1L7Lv6W25HE8Kx7CA/5Uln/XQ3cx3eqQK5mc4TlekxgKIQ+q24DES0Q9lScIkRNEf
 GSyh3DU04qFw12D8YkPoLlgSU+M2eBFDlcIM/Jw57vTuFq4QkdGIpDaCHiJTtdedbzML0o3O27y
 upoJlokFkY5er2Sp10AZJjV38olTn7j6fpqh1fdwTEs1n32sggE1d8jntNjr86Ryw72gB3FNe7X
 ywAeXH+HzP8jX9h890/0eWvePqO9fqzcw3kacOVvjHvVrTMzZP4whqRlD5M8BoaSdi8xjGGvAkm
 TBWUn93vaKCkmcuCvpA==
X-Proofpoint-ORIG-GUID: kqCKNeiassEEXLCMfx2dJA04nTxcLCFd
X-Proofpoint-GUID: kqCKNeiassEEXLCMfx2dJA04nTxcLCFd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040135

Hi Linus,

There are two IMA bug fixes: one addresses a potential integer underflow, t=
he
other instantiates 2 LSM hooks.

thanks,

Mimi

The following changes since commit 075b74841bd0065a3bda3440873c747938e69b68=
:

  Linux 7.2-rc6 (2026-08-02 16:24:24 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git=
/ tags/integrity-v7.2-rc7

for you to fetch changes up to b80bed5c871a80151351342c065579405ce77145:

  ima: Instantiate file_truncate and path_truncate hooks (2026-08-04 12:35:=
02 -0400)

----------------------------------------------------------------
integrity-v7.2-rc7

----------------------------------------------------------------
Lincoln Wallace (1):
      ima: fix out-of-bounds read in xattr_verify()

Mimi Zohar (1):
      ima: Instantiate file_truncate and path_truncate hooks

 security/integrity/ima/ima_appraise.c |  9 ++++++--
 security/integrity/ima/ima_main.c     | 39 +++++++++++++++++++++++++++++++=
++++
 2 files changed, 46 insertions(+), 2 deletions(-)

Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC394502F;
	Thu, 20 Aug 2026 00:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787184648; cv=none; b=P17WTmLotkAtsI61RWxfccW5sRvQrTp8UwXAFJ/LjhLfuTMwjwE2QoaT5+EcynCxI+kCpFm5OajyTcpfzrn6ftJIxJhSzkJXVy3fNjFiqVpzeukfpM4H4MTfb2IKD19PyBH3tp8ET/hbdIoY02K1NGLCjirM9caaw7g7RbiTymI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787184648; c=relaxed/simple;
	bh=rHg+HJ0PnKLAvlmQUVhhMUtJiNJcZgRm/7GSxGvJssI=;
	h=Message-ID:Subject:From:To:Cc:Content-Type:Date:MIME-Version; b=hkZ+sPO7kHW5rPYQt0D2t30yRdL4qojuKg7M/OpeswFZawE8i5qVpYtrPru2Fe6LE8Kzr8XXqaY+uDoH6XcLbE1SjEbqyvuj3ILW96USHEVgcU++3/WniBNZwAwCG3Ju/3ROxAbTN/z9NjIMcE0ACRTBV3tzwS8eQOt1qGmendg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=S3Ear7Me; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="S3Ear7Me"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JLVx4j3544030;
	Thu, 20 Aug 2026 00:10:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=ds1YuBYaGoYYTKoA49Gp2LjFwVhj
	mlEJkESIqYklsEM=; b=S3Ear7Meux3fUkBigSKvEh2xeHVvKsIDX8YvFifxkRr3
	oPLvaYq4ufR0HMOTg+8eMa0+T7J2Yn7MksCOoE2ShDt2qHtj5F97sZ0KYZ8Xl98Q
	cHdc1mDauwXE+Xb6epO0pIXmwnr6zvnD8be4nUaERg9rSZvvEBpChfdnJfGOJAMs
	xBDQ7oYdksSXcehXQnKcRcp+ZZW2FThCVTfzlNme0zRhq2x9/DsPsQNBl+0+xW+F
	vL9SkZ1RlcOUdGdmXEMXAKNtr/Hs9wTm7h3wVa7z5S3EEo3fH7iWRMKsGnexAFgS
	o67CRytqyFP8MhoYjBrwLPPL99cAL+yioKVQD48tnQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu26ss7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Aug 2026 00:10:40 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67JNuVje003619;
	Thu, 20 Aug 2026 00:10:40 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33xhbhs4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Aug 2026 00:10:40 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67K0AdNb13238808
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Aug 2026 00:10:39 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D531C58045;
	Thu, 20 Aug 2026 00:10:39 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5846A58052;
	Thu, 20 Aug 2026 00:10:39 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.90.157])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Aug 2026 00:10:39 +0000 (GMT)
Message-ID: <6246d8de26d1cce22b4c2e5f53891fff44af02ca.camel@linux.ibm.com>
Subject: [GIT PULL] integrity: subsystem fixes for v7.3
From: Mimi Zohar <zohar@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel	
 <linux-kernel@vger.kernel.org>,
        Roberto Sassu
 <roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 20:10:38 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AdqB2XXG c=1 sm=1 tr=0 ts=6a864600 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=Ol3P_JN7KJFd9DtwO2UA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: W6dTi73dFDrPetv4WNbwnv_ZQXATh9mY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDE4NCBTYWx0ZWRfX8wKiAbtUNqul
 7sdL9JluV48EAriXVletRg0264M3g0uQvrLzAEDA8MKl/4vbPd9rEaYIucPVq2e7vHhT09pwZ9b
 pg5/kq0T0Qz4GAuCi21d99UNQ77fRZnv6ALiiYM9tt65XCiVALJMxP1uhygHWiuOtm66oYkr8SG
 hnCZka0fmwjjVfj6jgjaONsfsIhf3OqLkR/JvfKBJ2xUC2vb0vBPlOxVOCEWfNR/D+AoGfv5mjL
 OITD7Igpp/Mf2XazEdCitefa379MvMFpWNA0z9P7iez9C11LvcBnYsUGvFeoexYw4JoR5uAWeo/
 re0T6cSxSFQFJK6pJhzlZqPy47lpOhqnsUATZ/zRXLxQI+cOkvtVJr9FShUOlFSbNzGTXKY2C5/
 PUdx0fjcM72bDkEeJsUHdEdGUcnPwYV5NzIzZdiaNvolWxWxB2Fu/If0/uLO2XPfyEXQRtfcJ1N
 gk0JjfKQyGpPRa9bLYw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDE4NCBTYWx0ZWRfXwYIFLl62DgEC
 wwv4WWn4BJqnTKhG1NNRVyrGpXkP1N81HLVHTIV32FdKfhjUAdFlT/T+aAAKz4Vte7kpKk0tB3v
 4MmVS8brP0IAMyF7wzwcefoH2Z87/rs=
X-Proofpoint-ORIG-GUID: W6dTi73dFDrPetv4WNbwnv_ZQXATh9mY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608190184

Hi Linus,

There are two main changes:                                                =
    =20
                                                                           =
    =20
- TPM initialization is sometimes delayed until deferred_probe_initcall. Si=
nce
ordering is not guaranteed within the same initcall level, IMA may initiali=
ze
before the TPM and fall back to TPM-bypass mode.  A new config option,
CONFIG_IMA_INIT_LATE_SYNC, allows those building the kernel to defer IMA
initialization to late_initcall_sync, accepting the integrity risk of missi=
ng
early measurements in exchange for avoiding TPM-bypass mode.
                                                                           =
    =20
- The raw policy rules are now measured, as well as the complete policy, cl=
osing
a gap in integrity measurement coverage.

thanks,

Mimi

The following changes since commit b80bed5c871a80151351342c065579405ce77145=
:

  ima: Instantiate file_truncate and path_truncate hooks (2026-08-04 12:35:=
02 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git=
/ tags/integrity-v7.3

for you to fetch changes up to f1e10b10874051e4d99911dae0dd7b75a9f8ae66:

  ima: measure userspace policy writes before parsing (2026-08-04 12:35:03 =
-0400)

----------------------------------------------------------------
integrity-v7.3

----------------------------------------------------------------
Enrico Bravi (2):
      ima: add critical data measurement for loaded policy
      ima: measure userspace policy writes before parsing

Jonathan McDowell (1):
      security: ima: rename boot_aggregate when ima is initialised at late_=
sync

Yeoreum Yun (2):
      security: lsm: allow LSMs to register for late_initcall_sync init
      security: ima: introduce IMA_INIT_LATE_SYNC option

 include/linux/lsm_hooks.h                 |  2 +
 security/integrity/ima/Kconfig            | 10 ++++
 security/integrity/ima/ima.h              |  5 ++
 security/integrity/ima/ima_efi.c          |  2 +
 security/integrity/ima/ima_fs.c           |  9 ++-
 security/integrity/ima/ima_init.c         | 15 +++--
 security/integrity/ima/ima_main.c         | 26 +++++++++
 security/integrity/ima/ima_policy.c       | 95 +++++++++++++++++++++++++++=
+++-
 security/integrity/ima/ima_template_lib.c |  3 +-
 security/lsm_init.c                       | 13 ++++-
 10 files changed, 170 insertions(+), 10 deletions(-)

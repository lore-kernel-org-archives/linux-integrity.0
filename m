Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68587499F1E;
	Fri,  4 Sep 2026 20:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788554878; cv=none; b=gZVdgLNvfxbEpwj+59jP7BZ+44T2luNcFmahb604wykJAzI3EMGRlUai2CpdbY637Xd3VD1byjMQWSeGqkhIHewBhMLM3kLQBkLF/QqKqZxEbHbnkWOYmsbPrSkhp8p5iYy9uz8a/0c24YCTQjjkQwWQDi0DTKgGhIMSu4EpT0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788554878; c=relaxed/simple;
	bh=njinWSXiz/zqfi4X9wy+FqKfdlus891NdF8nLMmad/U=;
	h=Message-ID:Subject:From:To:Cc:Content-Type:Date:MIME-Version; b=e7NNcnpYof5r86n7E5YoYVvupDDkxkX7yri3Yc6Ecf4iasQk8BCw8CeuSRiEV55hd5YECIghEyXE8/MKKmGIw6Ebmgj9G0jGRwtgUYgJjjAw/6DoYKge5LFP4zQPLtRFopU22/F33QWJwigV3ekeot80658wMXk1fkojyKOXxyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oX2vjdLX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oX2vjdLX"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684HW3F9501955;
	Fri, 4 Sep 2026 20:47:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=y1/65ohXpEJP6iQhC/OqMrbBR3SQ
	LZMUb7y17iw8rw4=; b=oX2vjdLXHP43WN1mzYsnXOPT1qWzX6W7M+vv1nL0sDl1
	p7p4LoJeuIIdMgXLv7apnxshIBLyqY6g4m1KeMrDocD6R1/TlPw6v0CICGQzt1e2
	Fg6yj1uhsRGPhd90NRFTHGPUxGL/jPNs0AeptdUXA6JBYTHWX0ptTy0z0Pz9IHDh
	RZiNLerUxmWjo8aBhfWYQ45Qw1J+IkhZZGM4P8jvY3P1GSAPTxa3edqwmwogfuRw
	tSMplhSBKjogjMR7S9yuzDcECZqT5rDcIlaNDeQKMmEUANsHnYzqFqfKFVg5qjzq
	ibfV3Upwh4yH1i4jUvH6hPK4PZ0Oyev5gJL7jRLfZw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq3rw6w7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 20:47:50 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 684KfgLT030692;
	Fri, 4 Sep 2026 20:47:49 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gc9rqycvf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 20:47:49 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 684KlmfT64094556
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Sep 2026 20:47:49 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E235958058;
	Fri,  4 Sep 2026 20:47:48 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 542885805C;
	Fri,  4 Sep 2026 20:47:48 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.85.196])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  4 Sep 2026 20:47:48 +0000 (GMT)
Message-ID: <0e98c262ca18fb67d9a9a4556010378b332882e7.camel@linux.ibm.com>
Subject: [GIT PULL] integrity: subsystem fixes for v7.3-rc2
From: Mimi Zohar <zohar@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel	
 <linux-kernel@vger.kernel.org>,
        Roberto Sassu
 <roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 16:47:47 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EIc2FVZC c=1 sm=1 tr=0 ts=6a9b2e76 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=40eiCIM62yLBkaOSkhwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDE4OSBTYWx0ZWRfX1GmVmSMF2KK3
 JtRJBdcSMFiG4jKQ6HZp92aahnweeabNXKcK6WjMmoUBc4QWe3dF5A3pXU78bKBJIoT+yow1Veq
 b2Vwlv315wOjVpJ3fsDqUZiNbZhAW6LNertTbW7xv36I+BPR7Fa2SxpjpBsUYMkxxMOrMStUXEy
 Hx9wlPgP7UV3RIhnDEnkDYnkZ7xxw1izLmN+wuNXt1oZ9v9zsb7GmghvjgykgXo4U6D50UcyMH+
 L3iXz+NdlXtn5131olLWIECSIbyChR09n24Yo5gvqs0DDY3OqN5FqcAK3o32N0Dyc915A4Uy3ET
 eTnIN6Gye7yvPyhF+3w3pRgrFrIcUKS9VMHUOn8XL4Z4dDaA5mJ9GhYwNEyLK+nqK3h8BBtWu+D
 UF0wlODf37oDTG09zAzfCLRmolvnMIw/WKYW5AHW9IPZ1xuQHvW0nxWwqarZXFohEFgVDr30qlO
 9GytFAEeKWmmwnkXnMg==
X-Proofpoint-GUID: uF0FM-6ZjujJ8QBcrchbbuOdlEoD5hLY
X-Proofpoint-ORIG-GUID: uF0FM-6ZjujJ8QBcrchbbuOdlEoD5hLY
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDE4OSBTYWx0ZWRfX+kPeCRgKPGKE
 bV7J1IVJLH1CPnesnEDCdJRE8KNqjvhm2lrQ2UbNdNIj/LmVLJ/auAcT4v+i4AxUSoMHY0jvtNK
 Uny46JDaOAnnSrwCCwJ4PygfwFcXnU4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040189

Hi Linus,

This contains three small IMA bug fixes:

- Instantiating the ima_file_truncate and ima_path_truncate LSM
hooks resulted in configfs locking issues. configfs files should
not be measured, appraised, or audited in the first place, so the
builtin policies are updated to exclude them.

- IMA audit messages include the filename, which could result in a
page fault when the filename doesn't exist.

- Un-hide the IMA_MEASURE_PCR_IDX Kconfig prompt.

thanks,

Mimi

The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935=
:

  Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git=
/
tags/integrity-v7.3-rc2

for you to fetch changes up to 6903878d4654bdef4e08e38cdf1ae306ce7de5f9:

  ima: allow users to specify the pcr index with IMA_MEASURE_PCR_IDX (2026-=
09-04
14:01:00 -0400)

----------------------------------------------------------------
integrity-v7.3-rc2

----------------------------------------------------------------
Bradley Morgan (1):
      ima: Check for ERR_PTR from dentry_path() in validate_hash_algo()

Frederick Lawler (2):
      configfs: move CONFIGFS_MAGIC definition to magic.h
      ima: don't measure/appraise files on configfs

Julian Braha (1):
      ima: allow users to specify the pcr index with IMA_MEASURE_PCR_IDX

 Documentation/ABI/testing/ima_policy  | 3 +++
 fs/configfs/mount.c                   | 4 +---
 include/uapi/linux/magic.h            | 1 +
 security/integrity/ima/Kconfig        | 6 +++++-
 security/integrity/ima/ima_appraise.c | 2 ++
 security/integrity/ima/ima_policy.c   | 7 ++++++-
 6 files changed, 18 insertions(+), 5 deletions(-)

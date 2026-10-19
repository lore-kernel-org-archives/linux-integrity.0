Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792439711;
	b=zgWdYk2kcxw9P8smkaunZ3UNzDV93LQxj4qUuAgbrdtHaF+E8ls+ik55tXX3FEIEQUeJ
	 oM/+3nuM3jjI/PqGbhLoUsgxlaxciOXUnpe5N8ESgwwJTpXkcphDmT01sU00qKbb2N/bU
	 NAujPA9qg4a291TYfKEp8YDtLRNc4ZNYrOdZXrW4BMuYPMmP125+0WaFynoO30gHh46uL
	 ys2ihuLucVZccC241Z6EkNG4IFEhHuFuVvMryysamoAJpS31gZDwFQBzY6jEePvHkwoTk
	 EDFfQErOXzXlpbq2mBy0aj5RFUkfzQy7/KselADva1uVUEuloFssAx5aGIANtFziA9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792439711;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Subject:From:To:Cc:
	 Content-Type:Content-Transfer-Encoding:Date:MIME-Version:User-Agent:
	 X-TM-AS-GCONF:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=/6iEsuM/zvmEANlDM/5YpOxO2KfQ+VwCOp9kum7Fe8s=;
	b=C6BMuFNol7RGhTmpDI8AoqYOg8EAObesslFaxS9I+KK5Mss1S63m2vX7KHvffj2T3aUX
	 LZXcZ9NVKHmWNp3epSNY6ZU6T8KKET7AWB9fla7cOrF8WbYF5nRQOTl9BT/Vnr70NCmKX
	 re7/16AP37aQGkaJ+0HAEbl+ge1oyl3gO6AlRrilG0lZN5fZ3+xleIFHJA7Ir4BT8/aDJ
	 Tx6ZKMr0LYOAsX8Up9oQUiufUo3wOuS/bOQacwcKMJPk4HKttKJYOH5R+pxYDudxaQ4Tu
	 uPxlU2RxJcuFuyCe/iL7GNdHdAdVHj/47h+AXJEN0sJbAnDE+bkxjsmHOb09RffuNxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b="iWD9e/Wy";
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4493F606A31A;
	Mon, 19 Oct 2026 19:55:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4493F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=iWD9e/Wy
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69JJiLiw508686;
	Mon, 19 Oct 2026 19:55:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=/6iEsuM/zvmEANlDM/5YpOxO2KfQ
	+VwCOp9kum7Fe8s=; b=iWD9e/WyEnoDTqfNYlWO08x0l+dxjKUYwXcr0yCRtsJv
	yBmMOFAhoaCWWlwioeCBPU6qdAjN27RQA/kgxoibWg+DKvOePPGMfpBsxSYYclWa
	EbR9BmDSttQJfVO4SRXzkM3eNSDljR0eel96lXcEYs7bJeQgV8X+QJNM05Xv75N4
	3z6gL/XZOVv2YBmm2aA7/B/gHX/mXUxTnduCDn0gTXLkB9hYstZz9xHvnp1aEmnI
	tPp3I0omdWlGnBt2PdvoXlJmJGkdEoUMD2PDnMchx8OeYCpnkYBX6WadGeaaQ1Hf
	gV89HvLNuRuxlqbIIi5c/3ggotlZ2iCGikktmnc7TQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hc0nvvdb7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 19 Oct 2026 19:55:02 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69JJKFNB422111;
	Mon, 19 Oct 2026 19:55:01 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hcmugy5rm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Oct 2026 19:55:01 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69JJt14W12124676
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Oct 2026 19:55:01 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B04B58067;
	Mon, 19 Oct 2026 19:55:01 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BDA4458056;
	Mon, 19 Oct 2026 19:55:00 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.34.225])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 19 Oct 2026 19:55:00 +0000 (GMT)
Message-ID: <c891877eb88c102a1f65acef5e99595963c12f53.camel@linux.ibm.com>
Subject: GIT PULL] integrity: subsystem fixes for v7.4
From: Mimi Zohar <zohar@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel	
 <linux-kernel@vger.kernel.org>,
        Roberto Sassu
 <roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 15:55:00 -0400
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA3OCBTYWx0ZWRfXyaeT34RvzTPL
 y4/8luO5N62MZVttP+as9THtY5H+//vU8zGJ/W038Kr778XLEsnyyS+Aq23CZchE+nLIY6Fu2E2
 gVTDkgUClnSdqdDmN5BqzCN8An9qVyM=
X-Proofpoint-ORIG-GUID: UTxtiIvZAOCEmb2b-Cgy9S2uuErYvVZ5
X-Proofpoint-GUID: UTxtiIvZAOCEmb2b-Cgy9S2uuErYvVZ5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA3OCBTYWx0ZWRfX6yZqkpR2Y8O4
 DEO3THNLlx4sn40Xn9apxBu0EB0kcFjGkl8CSH5FXGvwXQ+0yF4nE0ApwWUPlk77Hz/bWTgBO0g
 k8Lms0uieJGpNBzoDuN5BWAHG7PFNKYjQM5T3Nd68p75yDEOlDXJQYi3oVIsWF5LWBj/h4R8/p5
 /cEoh8uBQ2JlbpujtYVEt4FI4pzLE1ZD1Ar5aoxnOZi3hKxJ2wdl+AcqQnF70htXFUbdvtnzApm
 67vIlHlvpGk6ldtNuhE3efilAPoAjDL0t4/zqWYt3LDHLKSR1gLu7ZN/9oguZjCu+OkW88TXxZT
 ahSgNG9ekufo5LxpBuo1beO+a4xqSWczRxL1T9OVk2jv1GD7j9XtPaEKyeaoSdWyAfI70dS4nwq
 fvapAv6Ibi2IBCok3gwKd2YzPdiEHxVZ1H5vk49pdL6dzabarn1LrvO1DoYYuniMOFG9DJzOCW0
 E8uLLAVcMEDwVQD0nmg==
X-Authority-Analysis: v=2.4 cv=MY35KJ/f c=1 sm=1 tr=0 ts=6ad67596 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=4HTYTHHu4CgHxqjbLl0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190078

Hi Linus,

A cleanup and two bug fixes:

- Update ima_audit_msg() to report errno directly, revert making it a wrapp=
er
for ima_audit_message(), and remove ima_audit_message().

Two bug fixes when carrying the IMA measurement list across kexec:
- Restore the number of violations in the IMA measurement list.
- Reject restoring IMA measurement list record(s) beyond the expected buffe=
r
size (out-of-bounds).

thanks,

Mimi

The following changes since commit df2908090cda368b01ff43709f51890076c56157=
:

  Linux 7.3-rc2 (2026-09-06 15:07:20 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git=
/ tags/integrity-v7.4

for you to fetch changes up to ceb24c7052cc4649e3b52a51a7cca7dfe4896cec:

  ima: reject a kexec buffer whose declared size exceeds the buffer (2026-1=
0-16 10:54:53 -0400)

----------------------------------------------------------------
integrity-v7.4

----------------------------------------------------------------
Enrico Bravi (1):
      ima: recover number of violations after kexec

Fabrice Derepas (1):
      ima: reject a kexec buffer whose declared size exceeds the buffer

Frederick Lawler (2):
      integrity: Report error code in integrity_audit_msg() call sites
      integrity: Replace integrity_audit_message() with integrity_audit_msg=
()

 security/integrity/evm/evm_main.c         |  9 +++++----
 security/integrity/ima/ima_api.c          |  8 ++++----
 security/integrity/ima/ima_appraise.c     |  6 +++---
 security/integrity/ima/ima_fs.c           |  7 ++++---
 security/integrity/ima/ima_init.c         |  2 +-
 security/integrity/ima/ima_main.c         | 13 +++++++------
 security/integrity/ima/ima_policy.c       | 11 ++++++-----
 security/integrity/ima/ima_queue.c        |  2 +-
 security/integrity/ima/ima_queue_keys.c   |  8 ++++----
 security/integrity/ima/ima_template.c     | 12 ++++++++++++
 security/integrity/ima/ima_template_lib.c |  2 +-
 security/integrity/integrity.h            | 18 +++---------------
 security/integrity/integrity_audit.c      | 12 ++----------
 13 files changed, 53 insertions(+), 57 deletions(-)

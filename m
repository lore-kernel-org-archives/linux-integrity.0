Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3313340DB0
	for <linux-integrity@vger.kernel.org>; Fri, 21 Aug 2026 20:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787342811; cv=none; b=gTqUMYQ2SzLyYpjaY487LxeNTMZOdkqaEMc/XaXFWK9Js/SX+GuGtgjC9ckXetRQRhacIVsOGQ+pPn7UPEGtTfTs2X8yi8OLvQuaFvIaE/UtL+IwYeMZbMpP6lAdurMhKWsano3ssibj5ovovLArzbbPbBbMak5T4gIKnODEqaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787342811; c=relaxed/simple;
	bh=4dovncOIiZqhQpdxww6Qrgp7ZmH/53E/I+iCs3WHzUA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MLGnwC3K8wgQuYktmYcSbMILoPfqtjDmHP+U8doBBViljmIWBU7S0HD2qR+Nm8n2YtBzDOWotxP+EZacN4eOPvMFkSI5/46hT6xL1KjF0rhF9tJJ9cHWavpf9OP1pgm3W/4oxLIud3MCLSn/H3XqA50FlQR4TEvOTJYxJmY7QXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=O++JfINy; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="O++JfINy"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LIVexq1237239;
	Fri, 21 Aug 2026 20:06:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Ud0M7LVjTPzoYvjbtwz3P0o6sVL8jTDAPuquyjVBf
	0o=; b=O++JfINyJ4tkJv2gUNsaQVZv7bQNcIuZPsPfA87yXoFcoIOS/C/rjj2ag
	PxyVieOwwX1BDP3HbzhWtItNRMeqWYvkLw7qIzercxkupq7Ig+PWVNBxMotbYJ0l
	/jHzBBLh6OOHMbxxxQmpPMZ3Y4lsSMiaNEtl+MMfCQDw1XzHu69DUxCcNdj3mDTv
	4pTPA2hwZL14HsFHfSpPViCDWalDtLC6XPVOYnYg8V0u99C5It0uZUFXjYlKLcce
	cQyXS+bBSee2w48ztl80FrOPLSCBOyCTrgZxSiDZKShg9odW+pLjyLBALmxcM8Ui
	EyEjZ5l8GbdSp9Qb8uc/5vs9eW+Pg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu2ktt5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 20:06:33 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67LJuKT7009952;
	Fri, 21 Aug 2026 20:06:32 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32eqpxs3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 20:06:32 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67LK6Vks35717456
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 20:06:31 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EEA882004B;
	Fri, 21 Aug 2026 20:06:30 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 78D6120049;
	Fri, 21 Aug 2026 20:06:29 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.mynetworksettings.com (unknown [9.61.97.171])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Aug 2026 20:06:29 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH] ima_selinux.sh: test2 assumes CONFIG_IMA_DISABLE_HTABLE is configured
Date: Fri, 21 Aug 2026 16:06:20 -0400
Message-ID: <20260821200620.902699-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AdqB2XXG c=1 sm=1 tr=0 ts=6a88afc9 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=okxfWEJuFnmLN7zTFJYA:9
X-Proofpoint-GUID: MHFFpccppfVI3AWxF8yk-E7GU9rPhWMC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDE2MCBTYWx0ZWRfXxJZp0ael4b5k
 abH10qCCeppxvQUSmBy6/WSdfwsDmcxM2JgnqvycjyeIa27Jf0PKPFpk6vgE4Sdy0xBsFcNgWvL
 S7kOBFhXWFt7hiTmB2vA01A7S00MtP/97FFVnkOSVNAzfrIwy00zNXicY51HuZoWLECucsd0DTi
 RepTbPvGt9fAlYMAIwM5LdFGVgNcX21Ts/jZdu5uEt5UYpCgc9QBpU8UnFuEcmFMlJddRpmxIiz
 uzzH/DbBStXlBcTjGf0JTU4tAVcA2SYNOvUHXaQhpSWw9e+pjyy71/tlzVAr1+jYx8kwMHq43zL
 Qv1ZoavmweSVpIg90gpa6udhz7k+JB4hG3uFMMbK+rd/rGedlnbW2YtVgPsR4SqiW5mNCp0oClQ
 AboAdExeD+s+JTYAL10G0mmNgNHSueZ+m7r6kJbry/DwtCmFncepK0EqEHb0N1IF6ZZQ+ocm0cM
 fxKS08ts0BUdSpzCg5Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDE2MCBTYWx0ZWRfX0DzdBsjlSvKy
 oraAVkWn9lfosUcodhpAx9LcngrwOjIkgrnoo9nIVFfq5YRpIbNfH58sGzrUvYJmNFCm6+58D4b
 r8tvBf4Cptxn6ARCNHdIreH6UYcH/yM=
X-Proofpoint-ORIG-GUID: MHFFpccppfVI3AWxF8yk-E7GU9rPhWMC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_06,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608210160

test2 uses the last "selinux-state" record stored in the IMA measurement
list to determine whether SELinux is in enforcing mode and then compares
it to the selinux enforce file status.

The tst_update_selinux_state flips the SELinux enforce status
(/sys/fs/selinux/enforce) to force a new "selinux-state" record to be
appended to the IMA measurement list.  However, this only happens when
CONFIG_IMA_DISABLE_HTABLE is configured.

Don't fail the test when CONFIG_IMA_DISABLE_HTABLE is not configured.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 .../kernel/security/integrity/ima/tests/ima_selinux.sh      | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh b/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh
index e64a7739f..9b312f8b7 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh
@@ -147,7 +147,11 @@ test2()
 	enforced_value=$(echo $measured_data | awk -F'[=;]' '{print $4}')
 	expected_enforced_value=$(cat $SELINUX_DIR/enforce)
 	if [ "$expected_enforced_value" != "$enforced_value" ]; then
-		tst_res $IMA_FAIL "enforce: expected: $expected_enforced_value, got: $enforced_value"
+		if ! tst_check_kconfigs "CONFIG_IMA_DISABLE_HTABLE=y"; then
+			tst_res TPASS "Duplicate \"selinux-state\" record missing (CONFIG_IMA_DISABLE_HTABLE not set)"
+		else
+			tst_res $IMA_FAIL "enforce: expected: $expected_enforced_value, got: $enforced_value"
+		fi
 		return
 	fi
 
-- 
2.55.0


Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BBD1BD9D0
	for <linux-integrity@vger.kernel.org>; Wed, 26 Aug 2026 00:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787704509; cv=none; b=iu7Yc6uhcrlCX0Sp0ARty2+ppMU8JyPzOJsdO7UTPFtqn+ft3hGqwdgdHkQ2E0iKT9Auf0JlN3GgYjcJdXo82h+AmoFsfTltTQuq4UHjLn6ZnAP24XFd7dZCILWEJFTjj8DeF/ShQ5r1U7Ee5tuoCB0lYX0MIzSm24aKz0yl0Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787704509; c=relaxed/simple;
	bh=gL3hLqfnlatKGFMiynWhR6BbReWBdMlJ6BwqoLEBlVk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eHw6TBUBD9z8Xs/epXwmbUixdAegbOuenqqtTQ4R3ViPtaCIumk4Ioy+FTWMP5sRsIIr3kEYZSMDhtxVKZ3wazqkIgZ6od30IMvOoJwR3RnIK2p3d7nKZD5PIF/33CO1I8NZvqJjJICyrQibjKwIHRDKwf0zXa39qE3McN9qHQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Q1UCA2Vt; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Q1UCA2Vt"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67Q0VXo92458019;
	Wed, 26 Aug 2026 00:34:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=4wFA3SYsMF8qzznrAP91sb5p35mXskhnffM5ho5oL
	5E=; b=Q1UCA2VtPdVikKHxO9AobzXLQ/oPA7NcwcjZ8qFaoOedKnDUjHJ3HHDR3
	7XnfkZlBbUXE7Xqy/AjsMBHLvT0LRLVVoq9Fnj/HXpAgG/cCsTCecWyaEz3lNkpW
	THaRAj62QgA7rhSfIEBg/8sYFxsghSvTQZPp0t+xuzRSVRmHnu6Kvlc+xT2jKg3r
	5SDBZItieizftMKYLxU9gsNiwHXPyxqBOqpvdVKLtvbvQbslmR/Xi6so1D8G0lmp
	EjmIoamiiO4y1aG455rnIQaHoIRS+YkU7TW07saJGYka/NRaJVYUJm4Yo56k0VS+
	ecvOMB+UlYYAjy2w0bTf8C30G1s+Q==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g4umkn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 00:34:51 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67Q0QSOo017865;
	Wed, 26 Aug 2026 00:34:51 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsy70h0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 00:34:50 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67Q0YnZZ48628190
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Aug 2026 00:34:49 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D7482004B;
	Wed, 26 Aug 2026 00:34:49 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D0CA420040;
	Wed, 26 Aug 2026 00:34:47 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.fios-router.home (unknown [9.61.20.77])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Aug 2026 00:34:47 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>, linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH] ima_tpm.sh: properly detect failure to verify the IMA measurement list
Date: Tue, 25 Aug 2026 20:34:44 -0400
Message-ID: <20260826003444.424097-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kv3XaVqllBMohAAtYBciMSbGWB7UEKgd
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDAwMyBTYWx0ZWRfX0tCkzR0mNa3f
 +AYeWodgZbM2cboguBV+m4rhtlPCKALIREvCHTxjM2HAfTWAZdnRvgM0uiLCu7aujDJkhdniWGP
 fO7eGGmKkzoGkfEJdxfLsiwBpBUVwz4=
X-Proofpoint-GUID: kv3XaVqllBMohAAtYBciMSbGWB7UEKgd
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a8e34ac cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=tqA8ivxAeGEm9z13NQ8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDAwMyBTYWx0ZWRfX7voLwNN4DpUS
 Fmp6JkcPHgfAZJeXsZqBLw0pHDRm9svwkv4Tsyf2M0kymIBifiUhpgQh4laf9dcHshrAJU9S/iE
 elI5uOmFKUDz/y4wLjNItxY5wJBS5xv//vkLpy8qbhWZXYZaUQJWuTib+xZmhFVPbAc7b1SadDY
 nfszLaiIP14voRFrttJVlqhPgiOrWfZsPAkI2RmnPGmratn16W6yJKPbQs5jPRgQP7nwNyaUFgG
 PUL3WlDnUQRO2CILxomqdBYHFjIC7CWc6zjLLKhp3evAm8SYaE32ZTYu8x+cplFLUi11PBGPQIL
 cNgh8nbblTrecdufPYJJ8UQPQyQ4AQ0m8MgNcc2AN1KNDpPsH7s2fnWDvzdrTr9xznW74HlydG+
 6YRUulIdCMvaKpuYrhBkz4oZy8PPMzA1BT6Wq2SNyPK/HWnnIBuNGudz7zG30Dp2tJbSdwdOSNM
 rPty4vLxQz+x5SjhE/Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_07,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260003

test2 attempts to compare the aggregate PCR-10 value with the current
TPM PCR value based on the current measurement list, but does not take
into account that the measurement list might have been extended.

evmctl returns success/failure when verifying the IMA measurement list
and displays the measurement list line number that matched. Update
test2.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 .../security/integrity/ima/tests/ima_tpm.sh   | 34 +++++++++++++------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh b/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
index acd8b6d30..5f7a5e983 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
@@ -146,7 +146,7 @@ get_pcr10_aggregate()
 	local num_violations=0
 	local msg="$ERRMSG_EVMCTL"
 	local res=TCONF
-	local pcr ret
+	local lineno pcr ret
 
 	if [ -z "$MISSING_EVMCTL" ]; then
 		msg=
@@ -178,10 +178,13 @@ get_pcr10_aggregate()
 		tst_res $res "failed to find aggregate PCR-10 $msg"
 		tst_res TINFO "hash file:"
 		cat hash.txt >&2
-		return
+		return 1
 	fi
 
-	echo "$pcr"
+	lineno=$(grep -E "^($ALGORITHM )*PCR(.*10)*: succeed at entry" hash.txt | tail -1 \
+		| awk '{print $NF}')
+	echo "$pcr $lineno"
+	return $ret
 }
 
 test1_tpm_bypass_mode()
@@ -249,7 +252,9 @@ test1()
 
 test2()
 {
-	local hash pcr_aggregate out ret
+	local hash pcr_aggregate lineno out ret
+	local measurement_count="$IMA_DIR/runtime_measurements_count"
+	local total_measurements
 
 	tst_res TINFO "verify PCR values"
 
@@ -288,14 +293,21 @@ test2()
 	tst_res TINFO "real PCR-10: '$hash'"
 
 	get_pcr10_aggregate > tmp.txt
-	pcr_aggregate="$(cat tmp.txt)"
-	if [ -z "$pcr_aggregate" ]; then
-		return
-	fi
-	tst_res TINFO "aggregate PCR-10: '$pcr_aggregate'"
+	if [ $? -eq 0 ]; then
+		pcr_aggregate="$(cat tmp.txt | cut -d " " -f1)"
+		if [ -z "$pcr_aggregate" ]; then
+			return
+		fi
+		tst_res TINFO "aggregate PCR-10: '$pcr_aggregate'"
 
-	if [ "$hash" = "$pcr_aggregate" ]; then
-		tst_res TPASS "aggregate PCR value matches real PCR value"
+		lineno="$(cat tmp.txt | cut -d " " -f2)"
+
+		if [ "$hash" = "$pcr_aggregate" ]; then
+			tst_res TPASS "aggregate PCR value matches real PCR value (line: $lineno)"
+		else
+			total_measurements=$(cat "$measurement_count")
+			tst_res TPASS "aggregate PCR value matched real PCR value (line: $lineno/$total_measurements)"
+		fi
 	else
 		tst_res TFAIL "aggregate PCR value does not match real PCR value"
 	fi
-- 
2.55.0


Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B60430146C
	for <linux-integrity@vger.kernel.org>; Fri, 14 Aug 2026 13:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786715851; cv=none; b=iBOcsfnF72SXWxGqYujxhomqjhbQiLnlONsU2Q2r9GW7bf+hC1mkMgRN8GCLfs3px2IHILcc9Ddtlwu69Dkn79T7VCjPcINHX4DLpPRQxnX0H8qA2+eaeBHVm288krHxk/rrQfjiY06UofK4NloalcNO6Adr4LlBEz99MNVl2bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786715851; c=relaxed/simple;
	bh=BgVR7gH0SIa941zdLcNENtU00NrOWm+yNvsU2K6UK2o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Am3Mc3Z72dY/cI0LoZLhtVC0cMWpS6YVfSRToF9eL03Yu7NBGE7JpSlCa7BXglwRAn8IdHO2RUzHrlUkeKPezQL9esogRvDBjv4ekDctc89DJVAYx0yMHI9J+qCY1W2RHwDRwhjTz8zCsWT9JlNknP7VA8AhhzJas+H0g/RmvaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IxncnYAk; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IxncnYAk"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67EB1wEL860834;
	Fri, 14 Aug 2026 13:57:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=qV/jWDV1K4qF1oLyvUZGFNv1Ke/03IOVTmd2oz5xb
	1A=; b=IxncnYAkytuEzUYQGvBjL+0/uuW4OuLN9PmOP0j+8lyEpfJu6ZhR+jQNS
	CZlrIQa7A0F/XFpmWjc7LKiRSRc/OBgmgMiKQsTiX02+2fVhJtxXnWapmxx/wAIu
	IzszEfOYpc63JirA5sT5Ay0hO+5oDcLLDXXLVD866695IZygvODMS5v2XI09tkBB
	3hXHT+HRahsQCW+dnOuMCWlw4gro7Mpu5YameftHTAuoFWLoCf6iWjAMosW8zEEw
	/yBNM4661HIBnDZhQuhIMA0oeIELMSDTnQkAcAEPVDf7CeyW/u6/bbMeWn8gkXdU
	cWpA5cfkrqo+0m+R4ac/OC89tdHEQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp3bweg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 13:57:15 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67EDuHC0000555;
	Fri, 14 Aug 2026 13:57:14 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxesqfp4f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 13:57:14 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67EDvCXf28705322
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Aug 2026 13:57:12 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B96DE2004B;
	Fri, 14 Aug 2026 13:57:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 75BBC20043;
	Fri, 14 Aug 2026 13:57:11 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com.com (unknown [9.61.142.234])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Aug 2026 13:57:11 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>, linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH] ima_tpm.sh: update test2 to detect integrity violations
Date: Fri, 14 Aug 2026 09:57:04 -0400
Message-ID: <20260814135704.1247403-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7f1ebb cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=Bis4OGlwcyryPO7ueoMA:9
X-Proofpoint-GUID: 7SbbiyhUPeJWObx330Og6fe1Owzw0YUz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDEwMyBTYWx0ZWRfX6sMc+/XDBJTq
 TAF6NPVPIy9bwa7m70Q2dmKM9iEutlSi9fuBDBXUsH1wRgtjjS/huemy0FZFiwUnK0mUI4RXIVF
 4jdMB4faT4rZNBF6/R6+Em9HgomdTZSavz6Dvh/j1luVTOBeml/3plESPfh+yP6vOe7Mb8eUUab
 zH5wyra37gtDoBzoRfsjCVUdFhSW8oi80gTsrFu62B5WAwJTC7FsrXbwibQRQNwdvmUPtvelCxi
 4xUmfligMZ1OCjfKemyEvyRrDQ0/WNxr7kGmjdn/i7b7hRp/cF36Fn9Tb/04kobYYYDMwQNqjum
 pGkhLSQQ41NX6pyW9yEgve1ggT29szGb0Q7YTdcyWw3pu2GiWRtC1hMXunYw9cjUI/IvNdwenB6
 c3u/0tKdD+0+BgLdIIOpzX4n7fKLD4L7AzE/otD5wkTu2BlPuLz8jyz8/IzWMKdJk+hlQ/HH8Ex
 7VjvQ5WJpMpAaNM4FEg==
X-Proofpoint-ORIG-GUID: 7SbbiyhUPeJWObx330Og6fe1Owzw0YUz
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDEwMyBTYWx0ZWRfXynz+pJipddJm
 HTWYUlYzliXXtwoUittuJLKX6JSb3aGfMoNNHwM0X/E64rhgXsWGa8DMv04veCvKKDxnO83zL2Y
 5BHxLDI/DsT/goNdF5aexhBtvtRLsYw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608140103

<securityfs>/integrity/ima/violations reflects the number of
integrity violations.  Include the "--ignore-violations" option,
if there are any violations, on the initial IMA measurement list
verification.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 .../security/integrity/ima/tests/ima_tpm.sh   | 20 ++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh b/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
index 5d34d8679..acd8b6d30 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
@@ -142,6 +142,8 @@ read_pcr_tpm2()
 get_pcr10_aggregate()
 {
 	local cmd="evmctl -vv ima_measurement $BINARY_MEASUREMENTS"
+	local violations="$IMA_DIR/violations"
+	local num_violations=0
 	local msg="$ERRMSG_EVMCTL"
 	local res=TCONF
 	local pcr ret
@@ -151,16 +153,20 @@ get_pcr10_aggregate()
 		res=TFAIL
 	fi
 
-	$cmd > hash.txt 2>&1
-	ret=$?
-	if [ $ret -ne 0 -a -z "$MISSING_EVMCTL" ]; then
-		tst_res TFAIL "evmctl failed, trying with --ignore-violations"
+	if [ ! -f "$violations" ]; then
+		tst_res TINFO "missing $violations"
+	else
+		num_violations=$(cat "$violations")
+	fi
+
+	if [ "$num_violations" -eq 0 ]; then
+		$cmd > hash.txt 2>&1
+		ret=$?
+	else
+		tst_res TINFO "ignoring $num_violations violations"
 		cmd="$cmd --ignore-violations"
 		$cmd > hash.txt 2>&1
 		ret=$?
-	elif [ $ret -ne 0 -a "$MISSING_EVMCTL" = 1 ]; then
-		tst_res TFAIL "evmctl failed $msg"
-		return
 	fi
 
 	[ $ret -ne 0 ] && tst_res TWARN "evmctl failed, trying to continue $msg"
-- 
2.55.0


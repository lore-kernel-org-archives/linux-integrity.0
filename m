Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54FA17D6
	for <linux-integrity@vger.kernel.org>; Mon,  6 Apr 2026 00:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775434110; cv=none; b=Hq73geutVgz9H7c6LcenzO6TwGhkFd8gohsDiSE+xl23pGbjjLuz9RgF8Fr7I76XpcwZmbwUeNCDgy0Cvov7ssHCyBwQ87a1EhQAPs/40HHIN4AjMkFKhb8s6OSLPtzGach85PzImr01KdZWWI2XdkL+LuR0seRBIvhmZOyouwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775434110; c=relaxed/simple;
	bh=Ni6IDew4pZt7Miq3JB05x2b14dOw6tR5ziC+sIu9suo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aqZ3dLt/MuPv3VCzpwrQCzbVmRDNVdHOE1/f8WlPt6wu4EIdyJpalNLn1JKTNlhyvgyQGQwuMJEqK+p+CqnpoJT3T/BY0S8GQckfpy/RCzXTcxEJSGax2a5y5geV4znCAiZfHP+bcVpKih1xTNdZHHhhsyfmC7g92TIHWDQKRjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ScEyY/Om; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ScEyY/Om"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 635DCab02694011;
	Mon, 6 Apr 2026 00:08:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=00y3LH3GE6xMyCGUF
	f8zdpOKtGo5VxkfDbCZdzipRJA=; b=ScEyY/OmOYL4CB+Dpnn1D0L7g6mX3tS4N
	/AuL6Id6DhBF8kxgFiqQYqpSnyxix8AFg4HAxAXO3yXDPL+7due4u0V2c1mxAMDh
	KgtGP6QvjJ8lb530KRf8LCqeOOT/rcYTWA71JjGKNRX2nzv3JDpvt/NMg9zkO5Yo
	5NnwNfZw3m1AU441Pxa3AOaYxQBOlS36awqUeeV9ITP7Jl8gYYLByIiElfdxlgjD
	OnukzMZ0pBOFw7GHKsB90IIA85ZvFV4qn8bAJ4eah2fAonlRO4N1D9sddbZ8QXuu
	nmAXPSIoKK0vDy2xJawYPtIB3L7omWn1a07xV66GawopjK3JHBnNw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4datc2mmth-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Apr 2026 00:08:20 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 635HR34i014731;
	Mon, 6 Apr 2026 00:08:19 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dbf6jtmua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Apr 2026 00:08:19 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63608IdK24904268
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Apr 2026 00:08:18 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3BC2658059;
	Mon,  6 Apr 2026 00:08:18 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C886F58057;
	Mon,  6 Apr 2026 00:08:17 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Apr 2026 00:08:17 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, roberto.sassu@huawei.com, ebiggers@kernel.org,
        coxu@redhat.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [ima-evm-utils PATCH 2/5] Set size of xattr_value to MAX_SIGNATURE_SIZE
Date: Sun,  5 Apr 2026 20:08:07 -0400
Message-ID: <20260406000810.4013201-3-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260406000810.4013201-1-stefanb@linux.ibm.com>
References: <20260406000810.4013201-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA1MDI0NyBTYWx0ZWRfXweu8LpQD37S1
 Si1srwzapicPQcZmYjOniGjwvhubt3Ul+IuUNGozGyl7Tm9iB/HyWlu2hUNfWmHKI02HEtguVMO
 bs73FCNbC7BSeTVc0tiisE0c3T/9ifyf87RvHnv6tYUmJbb8MQPXt/N3TIsmsoW9r5HykixR1y/
 mcXGlLVpUef8RZ+1UzcCLxMpaAMBcgU2CcXeTI3onExyJyI5mpd+Xp7ZTRWCFZ2+IU5R+BTgO5v
 YZX6k/h3rKKP0gD6KV+dqoJRQ6fdv0a7GpFn0QqCWM1hBG6Si1f1sUX843/EshCC14cNxdF4NH6
 LR9j4SEhIlM0Bu2KWwdM/35SGDfe9kzzmzv33s9zYA2CA10TfeqVOPVvQgetxxwJ6RQiO09p/RZ
 skglXzRpV1rjGQo0JPZipOUg5U1lrjTJP9h5yi2Vw6ES3qbelevZNFmvLjXA1+543d4mxmkxBT1
 uRXVVX2j4HA2oLNgkLw==
X-Proofpoint-GUID: Mok3l34NnCq2fyeJKAPbIiR744J1lQI9
X-Proofpoint-ORIG-GUID: Mok3l34NnCq2fyeJKAPbIiR744J1lQI9
X-Authority-Analysis: v=2.4 cv=HJvO14tv c=1 sm=1 tr=0 ts=69d2f974 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=mA4aZrZgGGEE23H5QREA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-05_08,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604050247

Set the size of an xattr_value that can be read to MAX_SIGNATURE_SIZE
so that ML-DSA keys can also be read once enabled (and MAX_SIGNATURE_SIZE
gets a larger value).

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 src/evmctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index de67178..c8da495 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -347,7 +347,7 @@ static int calc_evm_hash(const char *file, const char *hash_algo,
 	EVP_MD_CTX *pctx;
 	unsigned int mdlen;
 	char **xattrname;
-	char xattr_value[1024];
+	char xattr_value[MAX_SIGNATURE_SIZE];
 	char list[1024];
 	ssize_t list_size;
 	char uuid[16];
-- 
2.53.0


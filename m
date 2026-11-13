Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794528717;
	b=DmV6HNg7UOyoh51cHwz529W4zRrGwlIWwfZP6SX1fwIx4Rh3Ozc6iho6kVfh5/V7mNuo
	 v3ddNZmfrZDu0339v8vDPn+F1h7kX7fASS+z/eRxQUhAK32mCNFXFrA5aYDCvcCbpYAoi
	 aaT0/FOI41njK9LT/ImlR5jBq8Miu67P+BDHW/wOF9L3l2erQwRQd/ICezgV12iKhENGa
	 P8pgK58pjeYpDDVxUJX8pL2ngynVh/MV3y+p0kR6G6AMgBlNhU2vY3SvvMIm8OVDxR1lW
	 PfdCehkBoLMBN6JL5wRlzf2DjOzQmbwLnx7+I0SJ9Ny2JtqurwNp7fAWG+8MePY4U1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794528717;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-TM-AS-GCONF:X-Proofpoint-Reinject:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=uTUew+nSASwIzfu5dLG5VTz88GYc2y3CBFNoJJiYSS0=;
	b=eEmwiCFeJcYnGfYr+p4pz7RxAQCkPDaRIsTn3NY3M/n2DEzkhSoBbRA7QdDfhuIXUuod
	 /2kq8hXybL7kx6+4UQ/3arpKNCha2TRVHUVxkVRxaPO4A0g5uwpSm/Ug6ulegwv1Vkc+f
	 GhrSjdFxXWx2PG7pIsDd0y3PSCslof1JBF72mRCeH9Q5H7tusg/vqJB8ov9i/EyBknDRr
	 evrasT93m0xb4fkXDXld3WO+6ZKxL2HAhtXiUAaxLLzX+QI2+lW2l4q6EDXc2CDDdWwfh
	 Jg8hcN0IQl5tMN9n9jBelV/Mun+5d1I50iRLMz3Wc+c9KW034iWFGcGEgg7gJH4gUqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=arcSgdFI;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A03606A321;
	Fri, 13 Nov 2026 00:11:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57A03606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=arcSgdFI
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ACNEnE14094594;
	Fri, 13 Nov 2026 00:11:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=uTUew+nSASwIzfu5dLG5VTz88GYc2y3CBFNoJJiYS
	S0=; b=arcSgdFIRTybFrLrwA/6nH2wxUHqeAeYqu5N4lweqArIPaEpHmXpeXIkc
	yPMxB1MtAv80LG+cuDjxsVfMy+XQpX9gNED3jczGccDjAV4mBJ+VAGetTwShpm5s
	bnJiv4gmZQutOLX+R7yyFd40xATE/rehCk1Mb5U2klI05IVzs5rtz8QDRmy+EA6e
	vg0Wm8QBkd4d0ZsJiGBdF4I58A4CJmUU62qV3XbE+x/QJpdvPOLz0hVrHSFMuvw7
	VaExk+DmwT9NV5k1urz0/166B12zjj5ByJNK3oGLzX+AxzZc1yVUpcLWNP/l+d/H
	w9ZnilIhUlK0I7BDICPS5zRbGKEkA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hstdggguq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 13 Nov 2026 00:11:52 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ACN4uc21380869;
	Fri, 13 Nov 2026 00:11:52 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hwd85a4a6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Nov 2026 00:11:52 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AD0Bp3R48038344
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Nov 2026 00:11:51 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BEED558070;
	Fri, 13 Nov 2026 00:11:51 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5536D58064;
	Fri, 13 Nov 2026 00:11:51 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Nov 2026 00:11:51 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org, jarkko@kernel.org
Cc: linux-kernel@vger.kernel.org, syzkaller@googlegroups.com, jgg@ziepe.ca,
        Stefan Berger <stefanb@linux.ibm.com>, fengaojigui88@gmail.com
Subject: [PATCH] tpm: tpm_vtpm_proxy: Try to disable queued work before flushing it
Date: Thu, 12 Nov 2026 19:11:35 -0500
Message-ID: <20261113001135.1355215-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=J+M/fwnS c=1 sm=1 tr=0 ts=6af655c9 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=ryBr6C_TQsVeIpDuTNIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA5NCBTYWx0ZWRfX5oVrRyxCW0Om
 oHtGfEHO3iu94Q1ixfngZ9kltdktrZ1wCkICtnEW5IcXbWCOoGD1imtdShBxFWLGcKGV4gJJJlg
 +NQsZpr7aUm8oRfQejqSTnQ4EQj4HE/8Y+UI63bg6hwzOwRCtF3LQwiF5p51PpIxQSIvv/ASmmi
 zXuZf0aX9SiGHmTc4iw/tYoXpynFcRO1Z/YEDi3JcZ3K0Qvkt4nOxcdtYBN/pL0zoQxdtlvAqnU
 KsM/IGtzWSohJ5sl7mg9WinBLhuShUOmQvShm8IvljH+xuc1xG7y2l/Cxnog4+1Goc8JSvO7HKI
 IuHzSM06Kt6s7t04g++rKtEoUEup0PNv/6Kt9nr98vETVGwzuvREBol2ik6O3f+KM6hYthuMRxI
 nxWk68Fy0N4anrbqfKTDuy/CYc09ApbfGXTY9R48yaA7ttym/oQ8Q9N2s3BT3l6RQEpIsg7Ar3k
 QKehsRcAYUGYHs76B3Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA5NCBTYWx0ZWRfX4noAXZSoWaTW
 s9CC2vK/7Y3MXa3P35cnLu5MYs/qnYxmWS+rmKSvBnmHCTWaarNxVeQaZ7AdTvi1kb3R0m9Pabu
 wqsY3c+mDJNfBUsAVB76Lcx5gQuJEsc=
X-Proofpoint-GUID: MikZLykDcleZQXdMb_5ke0f4FI9mCqxq
X-Proofpoint-ORIG-GUID: 32GTfYXpxhjK6mPxyJIKAVVFgAL8cCjv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120094

If an application opens multiple server-side TPM file descriptors using the
ioctl() on /dev/vtpmx and does not close them in the order they were
opened, then the closing of a file descriptor will run into flush_work()
and be blocked there behind other pending and active work. As a
consequence, the currently active work, that is waiting for a response to
its TPM request, will have to wait for the command to time out since its
STATE_OPENED_FLAG will not be reset. To resolve this issue, try to disable
pending work first before flushing it. The disable_work() returns quickly
and unqueues work for most of the closing file descriptors. If it returns
false, then run flush_work(), which makes sure that ongoing work ends,
which also happens quickly since its STATE_OPENED_FLAG was cleared.

Fixes: 6f99612e2500 ("tpm: Proxy driver for supporting multiple emulated TPMs")
Reported-by: fengaojigui88@gmail.com
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 drivers/char/tpm/tpm_vtpm_proxy.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_vtpm_proxy.c b/drivers/char/tpm/tpm_vtpm_proxy.c
index b81fd2a537df..7ca5ddb0d135 100644
--- a/drivers/char/tpm/tpm_vtpm_proxy.c
+++ b/drivers/char/tpm/tpm_vtpm_proxy.c
@@ -467,7 +467,8 @@ static void vtpm_proxy_work(struct work_struct *work)
 static void vtpm_proxy_work_stop(struct proxy_dev *proxy_dev)
 {
 	vtpm_proxy_fops_undo_open(proxy_dev);
-	flush_work(&proxy_dev->work);
+	if (!disable_work(&proxy_dev->work))
+		flush_work(&proxy_dev->work);
 }
 
 /*
-- 
2.56.0


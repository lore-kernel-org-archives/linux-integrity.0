Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67807395D99;
	Sat,  3 Oct 2026 08:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791016091; cv=none; b=BmqvVD5s2QfkeMXjZJ/q/scHtF8Nqif+0QkIy492lXprvUw/4Wx3/mBvcgyvQYPq6bS1wGS9KWJRexezuABRTKQ0p0BOCxyeWhJ0dbKJYpvsjaxCg1VTdfZeJQQnZlLqz7AV1avIOHn2oGy7KEFw2zZA3mCKHugzYhd1n7wLKIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791016091; c=relaxed/simple;
	bh=ITGDmkS1LPLwF2/5tqsW5ek2LRnUfIbeqidAy0rlEN4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YaOjAq3CE3jYMBX2+TT9++/Qdg0GpyGYdM7mXB6P/T6nehr1ugemWbbABCBiJOopXF6nh9tj/0jpKObT0i6eafQWBHy/FPS1MKVuS1FesLJXo/Jk2Td3ckMBxb1dDP/3elbtT5xZSwiau+r2O0e1+kIGIqdKjsLlrhCINh1VuPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 58131122bf0411f19a56ed5b684f684d-20261003
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:a7b6948e-9667-4938-98b5-208e55757d48,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:8588205fd2caf676db6ced337bc95263,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|850|865|898,TC:nil,Content:0|15|50|99,ED
	M:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:
	0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 58131122bf0411f19a56ed5b684f684d-20261003
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2021119684; Sat, 03 Oct 2026 16:28:00 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: jarkko@kernel.org,
	peterhuewe@gmx.de,
	jgg@ziepe.ca,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH 5/5] tpm: fix log messages in tpm_init()
Date: Sat,  3 Oct 2026 16:27:55 +0800
Message-Id: <de8bafc78e84dc6abc6f11e8eaa1b91c17e0c368.1791015549.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1791015549.git.xiaopei01@kylinos.cn>
References: <cover.1791015549.git.xiaopei01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make the error messages consistently prefixed with "tpm: ", and fix
the tpm_dev_common_init() failure message which was wrongly copied
from the previous step.

Assisted-by: GLM-5.3
Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
 drivers/char/tpm/tpm-interface.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 1ccdbde98b69..666a1c654c02 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -524,13 +524,13 @@ static int __init tpm_init(void)
 
 	rc = class_register(&tpm_class);
 	if (rc) {
-		pr_err("couldn't create tpm class\n");
+		pr_err("tpm: couldn't create tpm class\n");
 		return rc;
 	}
 
 	rc = class_register(&tpmrm_class);
 	if (rc) {
-		pr_err("couldn't create tpmrm class\n");
+		pr_err("tpm: couldn't create tpmrm class\n");
 		goto out_destroy_tpm_class;
 	}
 
@@ -542,7 +542,7 @@ static int __init tpm_init(void)
 
 	rc = tpm_dev_common_init();
 	if (rc) {
-		pr_err("tpm: failed to allocate char dev region\n");
+		pr_err("tpm: failed to allocate TPM workqueue\n");
 		goto out_unreg_chrdev;
 	}
 
-- 
2.25.1


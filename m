Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE143D75A0
	for <linux-integrity@vger.kernel.org>; Wed, 19 Aug 2026 08:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787128572; cv=none; b=jxEfW0qWOhp/2AT9PW/mRF74K+YT4v+hHyHUlVcpfUSYzqA8Vpp8NYeW+zkTdLha50Fy1yz6mVbyoy/lzYu9wOEE0fgRM3AF+BHtLksL1bfRcALX2cdskZOpJC6BlGtb6lR+/g7L9ubWCH+VTOA31Bg/hSuVEP3DzRWWIMw9Y6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787128572; c=relaxed/simple;
	bh=jzjCuYXv85KIu/n38tcG7eLaWt+HP+fZLN0hWltS1Ao=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=kNR6UK2duDBooQZLmA1f/eHIU5LAdE1YfBjS0ssz9qQqtWEjthjizqC+61hdsITyWCTbwdi3gNoTnAd4z7ZVeZUE1aT0dvKtdJSPZRtp5osQHJBwe4/c+XuG4Vgamzl0H22SYhpMyoh54+ybxYzzqJKpKlkvPq6P1vQTq3fyQTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 02abab5a9ba911f19a56ed5b684f684d-20260819
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:2b310b67-4c1c-4390-8191-3526b9ddf691,IP:0,U
	RL:0,TC:0,Content:-5,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-30
X-CID-META: VersionHash:7db8b62,CLOUDID:391a9c45edd4eb7726063089e654d37a,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50,EDM:2,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 02abab5a9ba911f19a56ed5b684f684d-20260819
X-User: lijun01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lijun01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 885736861; Wed, 19 Aug 2026 16:36:02 +0800
From: Li Jun <lijun01@kylinos.cn>
To: lijun01@kylinos.cn,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	peterhuewe@gmx.de,
	jarkko@kernel.org,
	jgg@ziepe.ca,
	linuxppc-dev@lists.ozlabs.org,
	linux-integrity@vger.kernel.org
Subject: [PATCH] char: tpm: Use SIMPLE_DEV_PM_OPS for ibmvtpm power management
Date: Wed, 19 Aug 2026 16:35:47 +0800
Message-Id: <20260819083547.2703228-1-lijun01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the manually defined dev_pm_ops structure with the
SIMPLE_DEV_PM_OPS macro to simplify the power management code.
This macro automatically handles CONFIG_PM_SLEEP configuration,
generating the same suspend/resume callbacks while reducing
boilerplate code.Add the value of 'thaw,freeze,poweroff,restore'.

Signed-off-by: Li Jun <lijun01@kylinos.cn>
---
 drivers/char/tpm/tpm_ibmvtpm.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
index 6fb4d30eb6f6..51c7e2add3d2 100644
--- a/drivers/char/tpm/tpm_ibmvtpm.c
+++ b/drivers/char/tpm/tpm_ibmvtpm.c
@@ -462,10 +462,7 @@ static const struct tpm_class_ops tpm_ibmvtpm = {
 	.req_canceled = tpm_ibmvtpm_req_canceled,
 };
 
-static const struct dev_pm_ops tpm_ibmvtpm_pm_ops = {
-	.suspend = tpm_ibmvtpm_suspend,
-	.resume = tpm_ibmvtpm_resume,
-};
+static SIMPLE_DEV_PM_OPS(tpm_ibmvtpm_pm_ops, tpm_ibmvtpm_suspend, tpm_ibmvtpm_resume);
 
 /**
  * ibmvtpm_crq_get_next - Get next responded crq
-- 
2.25.1


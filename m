Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3921DF748;
	Thu,  8 Oct 2026 01:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791422205; cv=none; b=RyoGg0F7laQ6IYV3sAVxstruKl8gpDXza5yZ1HjvHqOf7jjTlQo5IOMetyuQSuW//p2ZaI2uY4Cwl7MNKSHKpMh77FP/cHceXEEQSpGab9tnKMdPl+aEnXwv3F3V+OxGqhqw7NFStTEm2F5s+hcLgSRWyUxqlsD7bU+WhwK1PhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791422205; c=relaxed/simple;
	bh=2PRjY6Pm1LJ1GPAyjNYSbkt8TnUu5iQ+tAZZ36dZFAU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nUmx2sQgc74F0UdqacjRiJgYLomeEMvgGTCd8hEubLsc9DsD/G/oVmUq6Fs2o/4ChrX7lrOIHgO1aK+WFs8vCwVMcgBqIjIg0pZnV4PG6RJf50FfrYVHQ73Cn51bY5MqBuiNyCcLrgSF2XeRVbg7j8MEH0k8d0Qq/S+PQOm8JAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e2d67524c2b511f19a56ed5b684f684d-20261008
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:a1a1db5c-aee2-4b0a-b397-a9b3060be7df,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:7db8b62,CLOUDID:1a96ac9eb88a34fae2cf279a60d32ce2,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|136|850|865|898,TC:nil,Content:0|15|50|9
	9,EDM:5|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e2d67524c2b511f19a56ed5b684f684d-20261008
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1670350895; Thu, 08 Oct 2026 09:16:27 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: jarkko@kernel.org,
	peterhuewe@gmx.de,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH v2 2/4] tpm: tpm_nsc: fix NULL pointer dereference on init failure
Date: Thu,  8 Oct 2026 09:16:21 +0800
Message-Id: <f2eec6c86c5a5f738af43f4d950cb4f2be905ed4.1791421672.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1791421672.git.xiaopei01@kylinos.cn>
References: <cover.1791421672.git.xiaopei01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tpm_nsc_remove() is used as the release callback of the hand-created
platform device and dereferences the chip drvdata unconditionally.
If init fails before tpmm_chip_alloc() (e.g. request_region() cannot
claim the ports), the error path drops the last device reference and
the release callback runs with chip == NULL, crashing module init.

Return early when the chip has not been created yet.

Fixes: afb5abc262e9 ("tpm: two-phase chip management functions")
Assisted-by: GLM-5.3
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
 drivers/char/tpm/tpm_nsc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_nsc.c b/drivers/char/tpm/tpm_nsc.c
index 879ac88f5783..46a52dc99b14 100644
--- a/drivers/char/tpm/tpm_nsc.c
+++ b/drivers/char/tpm/tpm_nsc.c
@@ -259,7 +259,12 @@ static struct platform_device *pdev = NULL;
 static void tpm_nsc_remove(struct device *dev)
 {
 	struct tpm_chip *chip = dev_get_drvdata(dev);
-	struct tpm_nsc_priv *priv = dev_get_drvdata(&chip->dev);
+	struct tpm_nsc_priv *priv;
+
+	if (!chip)
+		return;
+
+	priv = dev_get_drvdata(&chip->dev);
 
 	tpm_chip_unregister(chip);
 	release_region(priv->base, 2);
-- 
2.25.1


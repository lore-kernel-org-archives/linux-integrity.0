Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470B340F74A
	for <linux-integrity@vger.kernel.org>; Wed, 12 Aug 2026 10:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786529399; cv=none; b=k/t2GV7/NjkKuP4Va8Ihdz4BKCdCb7NYyEoa/rVpaT2jA+VOsbPvzEuJRen2lCtl4Z+ahS33KlP41SYUcloQwO+7QYlAYHbTwsqfOoEiIByVM9kwyvBlryEPrsqG4I+IAf2c59fx1/kj7sCCiUtEp4PcmQYJqyu4SfCqTJctSBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786529399; c=relaxed/simple;
	bh=yMqDjJFzSn7vEszxYcVvFCskegkhEmWphKNzhYCPkiI=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=fU6/M4FN8yMIJ3A6vVuCADFhN7GJeOdHXqBAoeZBXQTawCVJTwTaFY+5o7s0WnkpoV48iEWKQSTnKTYSavsASi3Us5SJ2kieTs4iattNdJIXClDvoqC/HKoxVU7OY3CqluyR6r9PQtJ/qtG8aeJ71wvC4LsrCBR/BnE8STWut5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f26f17a4963511f1aa26b74ffac11d73-20260812
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:9130979f-d792-4bb4-a03d-d406a8c21fa2,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:e7bac3a,CLOUDID:efbb4e038608dacd7321de23bc56bacf,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:
	0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f26f17a4963511f1aa26b74ffac11d73-20260812
X-User: lijun01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lijun01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 665049812; Wed, 12 Aug 2026 18:09:46 +0800
From: Li Jun <lijun01@kylinos.cn>
To: lijun01@kylinos.cn,
	peterhuewe@gmx.de,
	jarkko@kernel.org,
	jgg@ziepe.ca,
	linux-integrity@vger.kernel.org
Subject: [PATCH] tpm: tpm_tis_spi: fix nodef CR50 tpm_tis_spi_resume is null
Date: Wed, 12 Aug 2026 18:09:14 +0800
Message-Id: <20260812100914.3540149-1-lijun01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

if no define CONFIG_TCG_TIS_SPI_CR50 in config,
the add of tpm_tis_spi_resume is null, this cause the tpm chip to
fail to resume.

Signed-off-by: Li Jun <lijun01@kylinos.cn>
---
 drivers/char/tpm/tpm_tis_spi.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_spi.h b/drivers/char/tpm/tpm_tis_spi.h
index d0f66f6f1931..ced416ecd92c 100644
--- a/drivers/char/tpm/tpm_tis_spi.h
+++ b/drivers/char/tpm/tpm_tis_spi.h
@@ -40,8 +40,12 @@ static inline int cr50_spi_probe(struct spi_device *spi)
 }
 #endif
 
-#if defined(CONFIG_PM_SLEEP) && defined(CONFIG_TCG_TIS_SPI_CR50)
-extern int tpm_tis_spi_resume(struct device *dev);
+#if defined(CONFIG_PM_SLEEP)
+	#if defined(CONFIG_TCG_TIS_SPI_CR50)
+		extern int tpm_tis_spi_resume(struct device *dev);
+	#else
+		#define  tpm_tis_spi_resume tpm_tis_resume
+	#endif
 #else
 #define tpm_tis_spi_resume	NULL
 #endif
-- 
2.25.1


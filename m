Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748881DA62E
	for <linux-integrity@vger.kernel.org>; Wed,  9 Sep 2026 02:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788922757; cv=none; b=Jr6dMI2UTsEecyIrhw520CPAWRbuqX1+TIZUjt36RJ28YnttXeX1wgBSZPINlGq0SAm+RGOHsg5AVYBMS2LgJCKGaNKpVgj0Hy0yZX2ujLgkSuYjdTmjcv4mnTsDEzog09Qma5y8xG3dWZ/sEWJiduSKGAJXDevYYsRyVfwFzbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788922757; c=relaxed/simple;
	bh=dWcHn7qrrgKghLYqq5lgwJVe9PlFwDpPtuECnxVTWVg=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=BMM/J3Qwb+u6RJfBJQl8wH6Nurst24bWuDMzEGtXnhAnvi9pucqczKiz5hbgvDT3Yy9Dq8Qm78fhEQxiCV679jpC/+INcQ+gYVogGpjB3/4hOX6lRQX0MJKaP+sFt0Le55gbur7vgCZTJQiduhu727V1nAvJasBxdRuTluBDQwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6ee75d8aabfa11f19a56ed5b684f684d-20260909
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:dffbbf96-84c3-4ffe-a8d1-d973c27dbe30,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:7db8b62,CLOUDID:9293b4d5238814c0955b982405dbadfb,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50|99,EDM:-3,I
	P:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
	,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6ee75d8aabfa11f19a56ed5b684f684d-20260909
X-User: lijun01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lijun01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 667099908; Wed, 09 Sep 2026 10:59:11 +0800
From: Li Jun <lijun01@kylinos.cn>
To: lijun01@kylinos.cn,
	peterhuewe@gmx.de,
	jarkko@kernel.org,
	jgg@ziepe.ca,
	linux-integrity@vger.kernel.org
Subject: [PATCH] tpm: cr50: use DEFINE_SIMPLE_DEV_PM_OPS and pm_sleep_ptr()
Date: Wed,  9 Sep 2026 10:58:57 +0800
Message-Id: <20260909025857.206617-1-lijun01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the deprecated SIMPLE_DEV_PM_OPS with DEFINE_SIMPLE_DEV_PM_OPS
and wrap the struct assignment with pm_sleep_ptr(). The old code keeps
a completely empty dev_pm_ops structure -- all callbacks are NULL --
as dead code in the object file when CONFIG_PM_SLEEP=n, because
SET_SYSTEM_SLEEP_PM_OPS() expands to nothing while __maybe_unused on
the struct only silences the warning without removing the struct.
Switching to DEFINE_SIMPLE_DEV_PM_OPS() lets pm_sleep_ptr() eliminate
the callback references at compile time, and wrapping the struct
assignment with pm_sleep_ptr() drops the entire structure when
CONFIG_PM_SLEEP is disabled, instead of retaining an empty one.

Signed-off-by: Li Jun <lijun01@kylinos.cn>
---
 drivers/char/tpm/tpm_tis_i2c_cr50.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm_tis_i2c_cr50.c
index 7f828fae70d3..6c0ea5ca2b92 100644
--- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
+++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
@@ -816,14 +816,14 @@ static void tpm_cr50_i2c_remove(struct i2c_client *client)
 	tpm_chip_unregister(chip);
 }
 
-static SIMPLE_DEV_PM_OPS(cr50_i2c_pm, tpm_pm_suspend, tpm_pm_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(cr50_i2c_pm, tpm_pm_suspend, tpm_pm_resume);
 
 static struct i2c_driver cr50_i2c_driver = {
 	.probe = tpm_cr50_i2c_probe,
 	.remove = tpm_cr50_i2c_remove,
 	.driver = {
 		.name = "cr50_i2c",
-		.pm = &cr50_i2c_pm,
+		.pm = pm_sleep_ptr(&cr50_i2c_pm),
 		.acpi_match_table = ACPI_PTR(cr50_i2c_acpi_id),
 		.of_match_table = of_match_ptr(of_cr50_i2c_match),
 	},
-- 
2.25.1


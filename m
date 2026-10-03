Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1430B399356;
	Sat,  3 Oct 2026 08:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791016102; cv=none; b=K3iRVSXiZT3F/lE/m8qlUS7FGiIGMry+/xgX7lfzOSUD6O2+r/7x/XFXJTaVwpHuS2tVsM+YZJchWlnHYerMUI2A0Id7FQO1p8v0U20A7kIQC1eLyid51ob86t4JvAb2P3aYoKVVRJfwLLbTWogYGkgIBbVs5lC3sLDg/vEnido=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791016102; c=relaxed/simple;
	bh=UsZynSl01Pdh+6VtbZlOZ7nvRsrVNR0uP5Dvge7Fqp4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R/rxlG1bvBMUZZqBaDITsus6FhRamYKwHbF0HRSx9Oh0yUTE9yMA5I70Vdz0shn/K95qxtPfMdTJm3PwfV34pnKNDn+RhCUX7dLpCYBqWzj1yBTafQgsU7fZxtL59XZTwJ6PiC8S46/AxNGHg8YgFnE4RC3oNT+OKhdRbhbU4Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 57709dd4bf0411f19a56ed5b684f684d-20261003
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:7a2a5323-55ff-48cf-95d3-3ae0c935c996,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:7db8b62,CLOUDID:1c11c83c06909e4bfda4cec3a386f4ce,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|136|850|865|898,TC:nil,Content:0|15|50|9
	9,EDM:5|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 57709dd4bf0411f19a56ed5b684f684d-20261003
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1946296680; Sat, 03 Oct 2026 16:27:59 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: jarkko@kernel.org,
	peterhuewe@gmx.de,
	jgg@ziepe.ca,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH 1/5] tpm: tpm_ppi: fix wrong error code returned to user space
Date: Sat,  3 Oct 2026 16:27:51 +0800
Message-Id: <16ff8f5a35246d5932068ce1b01438bc2895a46a.1791015549.git.xiaopei01@kylinos.cn>
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

tpm_show_ppi_response() stores its return value in an acpi_status,
a typedef of u32.  Both error paths of the function (-EINVAL on a
malformed _DSM package, -EFAULT on a non-zero operation return
code) end up as huge positive values when returned as ssize_t, so
user space cannot detect the failure with the usual "ret < 0"
check.

Declare the variable as ssize_t to match the show callback's
return type.

Fixes: 84b1667dea23 ("ACPI / TPM: replace open-coded _DSM code with helper functions")
Assisted-by: GLM-5.3
Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
 drivers/char/tpm/tpm_ppi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_ppi.c b/drivers/char/tpm/tpm_ppi.c
index c9793a3d986d..949fb7055bea 100644
--- a/drivers/char/tpm/tpm_ppi.c
+++ b/drivers/char/tpm/tpm_ppi.c
@@ -234,7 +234,7 @@ static ssize_t tpm_show_ppi_response(struct device *dev,
 				     struct device_attribute *attr,
 				     char *buf)
 {
-	acpi_status status = -EINVAL;
+	ssize_t status = -EINVAL;
 	union acpi_object *obj, *ret_obj;
 	u64 req, res;
 	struct tpm_chip *chip = to_tpm_chip(dev);
-- 
2.25.1


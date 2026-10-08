Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF0A2E64D;
	Thu,  8 Oct 2026 01:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791422203; cv=none; b=UNoxj8Ecdg4+d1Gh6sfdCx6orsYlL5jGEd1ZBskliW+JTKeYOLMuNsNNORqZctnv15O6iriG0wauhXYfcEpM44E3MYb20O8ddpkn+z/qhP0a3NybYatBIjQrVg1Kf9lSNY2mG32DlHfNVLxsDonJ5sgd6Jbc9Dj5uwyFIUXv4uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791422203; c=relaxed/simple;
	bh=p16Pez1yoys5FVE9c0g1mlPkjmaw0gaCK+97rtivypg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IJlhLjeYh/ebLDV2GnaQskzwxpVbOqg7YFoi2Ea2HdY3Aa0FlOrdWkblk1olhk7B60qOLag+Qi/YEmv9yrWxa3wbKVdPxbs+K8VX8nwOInWkEtivnNjuTdBD1xY9sOOTgctHvUKYWt9VMBIwpqUcq+RPmS+zZFCu/kAgG1iTWEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e2b19b78c2b511f19a56ed5b684f684d-20261008
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:099ed28c-41c6-4314-bcdf-e6fec626908b,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:dd0d820fd9d2807c11c8df7d87404954,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|136|850|865|898,TC:nil,Content:0|15|50|9
	9,EDM:5|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e2b19b78c2b511f19a56ed5b684f684d-20261008
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 421328061; Thu, 08 Oct 2026 09:16:27 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: jarkko@kernel.org,
	peterhuewe@gmx.de,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH v2 1/4] tpm: tpm_ppi: fix zero-extension of negative error codes
Date: Thu,  8 Oct 2026 09:16:20 +0800
Message-Id: <654d1a02c0720a37ae38382a71f0b8c0f5f9b6a0.1791421672.git.xiaopei01@kylinos.cn>
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

tpm_show_ppi_response() keeps its return value in an acpi_status,
a typedef of u32.  The two's complement of the error code is stored
correctly there, but on return the value is converted to ssize_t and
zero-extended, so the sign is lost: user space receives 0xFFFFFFEA
(4294967274) instead of -EINVAL, which breaks the usual "ret < 0" error
check.
Declare the variable as ssize_t so that negative values survive the
conversion.

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


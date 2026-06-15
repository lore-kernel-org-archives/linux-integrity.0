Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E31285CBC;
	Mon, 15 Jun 2026 04:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781498953; cv=none; b=vB9QxjsERCiJuOCkR9zWfVNj6VJNdI39gQ9NgBkFy4R3CnCJ5aYZTCx5wwWtazQro5wo+zN7ZKXVpvhWT70balABgRwZSyLgyT10J9Q/V2j8t9d0YceqY1RG8lengbkAtQv6Y77mRD343plVyRsGXsFS9kUzDnKqiqfnS0IICmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781498953; c=relaxed/simple;
	bh=J/L5xT5aQww8vWb1GaDhaND6bJ8nV45qb/jqb4nzyUs=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dEmvagiKDIfJelwL7nmjlWqi0nXUBHoAZEuujuRF/7bw+Pe0RQ6/VxMPvk/WKGJnrHjxXCHJPHVLJl0iWylgj8WL8wMVkPF5n0oExaqn92FDQBEli38Zc4QrGYgQDlx7lWd+32Vgps/Bb5XWhKvLPLQoggKRx1dWSmt1wLrliEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wYzFp-000000000p9-3vZz;
	Mon, 15 Jun 2026 04:48:58 +0000
Date: Mon, 15 Jun 2026 05:48:43 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Chen Jun <chenjun102@huawei.com>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tpm: tpm_tis: add settle delay after releasing locality
Message-ID: <086949bcf2c10bead892b0b4befd98da370cd3ee.1781498837.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tpm_tis_core_init() releases locality 0 then immediately reclaims it via
tpm_chip_start(); some TPMs (e.g. Nuvoton NPCT, TPM 2.0) need a few ms
before granting it again, so probe fails with -1. This back-to-back
release/request was added with the locality claim around TPM_INT_ENABLE.

Wait for the chip to settle after releasing the locality. A delay of
TPM_TIMEOUT (5 ms) in __tpm_tis_relinquish_locality() is reliable; values
below 3 ms are not.

Fixes: 0ef333f5ba7f ("tpm: add request_locality before write TPM_INT_ENABLE")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/char/tpm/tpm_tis_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 21d79ad3b164..6b90ff50c78d 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -171,6 +171,8 @@ static int __tpm_tis_relinquish_locality(struct tpm_tis_data *priv, int l)
 {
 	tpm_tis_write8(priv, TPM_ACCESS(l), TPM_ACCESS_ACTIVE_LOCALITY);
 
+	tpm_msleep(TPM_TIMEOUT);
+
 	return 0;
 }
 
-- 
2.54.0


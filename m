Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:60379 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728334AbeIDAFo (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 Sep 2018 20:05:44 -0400
From: Peter Huewe <peterhuewe@gmx.de>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>
Subject: [PATCH] tpm: Make SECURITYFS a weak dependency
Date: Mon,  3 Sep 2018 21:51:51 +0200
Message-Id: <20180903195151.7576-1-peterhuewe@gmx.de>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

While having SECURITYFS enabled for the tpm subsystem is beneficial in
most cases, it is not strictly necessary to have it enabled at all.
Especially on platforms without any boot firmware integration of the TPM
(e.g. raspberry pi) it does not add any value for the tpm subsystem,
as there is no eventlog present.

By turning it from 'select' to 'imply' it still gets selected per
default, but enables users who want to save some kb of ram by turning
SECURITYFS off.

Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
---
 drivers/char/tpm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
index 18c81cbe4704..536e55d3919f 100644
--- a/drivers/char/tpm/Kconfig
+++ b/drivers/char/tpm/Kconfig
@@ -5,7 +5,7 @@
 menuconfig TCG_TPM
 	tristate "TPM Hardware Support"
 	depends on HAS_IOMEM
-	select SECURITYFS
+	imply SECURITYFS
 	select CRYPTO
 	select CRYPTO_HASH_INFO
 	---help---
-- 
2.16.4

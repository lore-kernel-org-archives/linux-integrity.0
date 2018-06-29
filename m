Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:50596 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935602AbeF2PKX (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 29 Jun 2018 11:10:23 -0400
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Winkler, Tomas" <tomas.winkler@intel.com>,
        Azhar Shaikh <azhar.shaikh@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] tpm: require to compile as part of the kernel
Date: Fri, 29 Jun 2018 18:10:02 +0300
Message-Id: <20180629151005.10899-1-jarkko.sakkinen@linux.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Do not allow to compile TPM core as a module. TPM defines a root of
trust for integrity and keyring subsystems and should be always
available and not be loaded from the user space. There is no a
reasonable use case for a loadable module existing.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 drivers/char/tpm/Kconfig | 2 +-
 include/linux/tpm.h      | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
index 18c81cbe4704..9728771aecbd 100644
--- a/drivers/char/tpm/Kconfig
+++ b/drivers/char/tpm/Kconfig
@@ -3,7 +3,7 @@
 #
 
 menuconfig TCG_TPM
-	tristate "TPM Hardware Support"
+	bool "TPM Hardware Support"
 	depends on HAS_IOMEM
 	select SECURITYFS
 	select CRYPTO
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 4609b94142d4..cefa61b12891 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -50,8 +50,7 @@ struct tpm_class_ops {
 	void (*clk_enable)(struct tpm_chip *chip, bool value);
 };
 
-#if defined(CONFIG_TCG_TPM) || defined(CONFIG_TCG_TPM_MODULE)
-
+#if defined(CONFIG_TCG_TPM)
 extern int tpm_is_tpm2(struct tpm_chip *chip);
 extern int tpm_pcr_read(struct tpm_chip *chip, int pcr_idx, u8 *res_buf);
 extern int tpm_pcr_extend(struct tpm_chip *chip, int pcr_idx, const u8 *hash);
-- 
2.17.1

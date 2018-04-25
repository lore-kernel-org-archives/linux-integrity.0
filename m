Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:7853 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754452AbeDYKov (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 Apr 2018 06:44:51 -0400
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: stable@vger.kernel.org
Cc: "Winkler, Tomas" <tomas.winkler@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org (open list:TPM DEVICE DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/3] tpm: tpm-interface: fix tpm_transmit/_cmd kdoc
Date: Wed, 25 Apr 2018 13:44:22 +0300
Message-Id: <20180425104425.5803-3-jarkko.sakkinen@linux.intel.com>
In-Reply-To: <20180425104425.5803-1-jarkko.sakkinen@linux.intel.com>
References: <20180425104425.5803-1-jarkko.sakkinen@linux.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

From: "Winkler, Tomas" <tomas.winkler@intel.com>

commit 65520d46a4adbf7f23bbb6d9b1773513f7bc7821 upstream

Fix tmp_ -> tpm_ typo and add reference to 'space' parameter
in kdoc for tpm_transmit and tpm_transmit_cmd functions.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 drivers/char/tpm/tpm-interface.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 0091eccdaf8d..f71352cf7552 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -400,9 +400,10 @@ static void tpm_relinquish_locality(struct tpm_chip *chip)
 }
 
 /**
- * tmp_transmit - Internal kernel interface to transmit TPM commands.
+ * tpm_transmit - Internal kernel interface to transmit TPM commands.
  *
  * @chip: TPM chip to use
+ * @space: tpm space
  * @buf: TPM command buffer
  * @bufsiz: length of the TPM command buffer
  * @flags: tpm transmit flags - bitmap
@@ -544,10 +545,11 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
 }
 
 /**
- * tmp_transmit_cmd - send a tpm command to the device
+ * tpm_transmit_cmd - send a tpm command to the device
  *    The function extracts tpm out header return code
  *
  * @chip: TPM chip to use
+ * @space: tpm space
  * @buf: TPM command buffer
  * @bufsiz: length of the buffer
  * @min_rsp_body_length: minimum expected length of response body
-- 
2.17.0

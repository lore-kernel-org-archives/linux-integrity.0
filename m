Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from smtp11.infineon.com ([217.10.52.105]:5127 "EHLO
        smtp11.infineon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751166AbeFTJzx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Jun 2018 05:55:53 -0400
From: Ricardo Schwarzmeier <Ricardo.Schwarzmeier@infineon.com>
To: <linux-integrity@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <peterhuewe@gmx.de>,
        <jarkko.sakkinen@linux.intel.com>, <jgg@ziepe.ca>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>,
        Ricardo Schwarzmeier <Ricardo.Schwarzmeier@infineon.com>
Subject: [PATCH v2] tpm: Return the actual size when receiving an unsupported command
Date: Wed, 20 Jun 2018 11:55:07 +0200
Message-ID: <20180620095507.682-1-Ricardo.Schwarzmeier@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

The command size is computed for the header anyway.
It can as well indicate the correct number of bytes to read from the driver.
Fixes: 095531f891e6 ("tpm: return a TPM_RC_COMMAND_CODE response if command is not implemented")

Signed-off-by: Ricardo Schwarzmeier <Ricardo.Schwarzmeier@infineon.com>
---
 drivers/char/tpm/tpm-interface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index e32f6e85dc6d..0923e81505a5 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -423,7 +423,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
 		header->tag = cpu_to_be16(TPM2_ST_NO_SESSIONS);
 		header->return_code = cpu_to_be32(TPM2_RC_COMMAND_CODE |
 						  TSS2_RESMGR_TPM_RC_LAYER);
-		return bufsiz;
+		return header->length;
 	}
 
 	if (bufsiz > TPM_BUFSIZE)
-- 
2.17.1

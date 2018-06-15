Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from smtp2.infineon.com ([217.10.52.18]:54660 "EHLO
        smtp2.infineon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754760AbeFOMoA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 15 Jun 2018 08:44:00 -0400
From: Ricardo Schwarzmeier <Ricardo.Schwarzmeier@infineon.com>
To: <linux-integrity@vger.kernel.org>
CC: <peterhuewe@gmx.de>, <jarkko.sakkinen@linux.intel.com>,
        <jgg@ziepe.ca>, <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        Ricardo Schwarzmeier <Ricardo.Schwarzmeier@infineon.com>
Subject: [PATCH] tpm: Return the actual size when receiving an unsupported command
Date: Fri, 15 Jun 2018 14:18:21 +0200
Message-ID: <20180615121821.23376-1-Ricardo.Schwarzmeier@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

The command size is computed for the header anyway.
It can as well indicate the correct number of bytes to read from the driver.

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

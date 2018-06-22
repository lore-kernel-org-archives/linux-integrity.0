Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from smtp2.infineon.com ([217.10.52.18]:7649 "EHLO
        smtp2.infineon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751213AbeFVG4l (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 Jun 2018 02:56:41 -0400
From: Ricardo Schwarzmeier <Ricardo.Schwarzmeier@infineon.com>
To: <linux-integrity@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <peterhuewe@gmx.de>,
        <jarkko.sakkinen@linux.intel.com>, <jgg@ziepe.ca>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>,
        Ricardo Schwarzmeier <Ricardo.Schwarzmeier@infineon.com>
Subject: [PATCH v4] tpm: Return the actual size when receiving an unsupported command
Date: Fri, 22 Jun 2018 08:50:00 +0200
Message-ID: <20180622065000.31139-1-Ricardo.Schwarzmeier@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

The userpace expects to read the number of bytes stated in the header.
Returning the size of the buffer instead would be unexpected.
Fixes: 095531f891e6 ("tpm: return a TPM_RC_COMMAND_CODE response if command is not implemented")

Signed-off-by: Ricardo Schwarzmeier <Ricardo.Schwarzmeier@infineon.com>
---
 drivers/char/tpm/tpm-interface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index e32f6e85dc6d..7f2e2d54894d 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -423,7 +423,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
 		header->tag = cpu_to_be16(TPM2_ST_NO_SESSIONS);
 		header->return_code = cpu_to_be32(TPM2_RC_COMMAND_CODE |
 						  TSS2_RESMGR_TPM_RC_LAYER);
-		return bufsiz;
+		return sizeof(*header);
 	}
 
 	if (bufsiz > TPM_BUFSIZE)
-- 
2.17.1

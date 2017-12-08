Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from smtp2.infineon.com ([217.10.52.18]:26579 "EHLO
        smtp2.infineon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752338AbdLHSvX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 8 Dec 2017 13:51:23 -0500
From: Alexander Steffen <Alexander.Steffen@infineon.com>
To: <jarkko.sakkinen@linux.intel.com>, <nayna@linux.vnet.ibm.com>,
        <kgold@linux.vnet.ibm.com>, <linux-integrity@vger.kernel.org>
CC: Alexander Steffen <Alexander.Steffen@infineon.com>
Subject: [RFC][PATCH 6/9] tpm_tis_spi: fix sending wrong data during wait state handling
Date: Fri, 8 Dec 2017 19:46:55 +0100
Message-ID: <20171208184658.9588-7-Alexander.Steffen@infineon.com>
In-Reply-To: <20171208184658.9588-1-Alexander.Steffen@infineon.com>
References: <20171208184658.9588-1-Alexander.Steffen@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

When the TPM signals wait states, the driver has to repeat the last byte
until the TPM stops signaling wait states and accepts that byte. It should
not send a dummy byte, even though that might work with some TPM
implementations.

Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
---
 drivers/char/tpm/tpm_tis_spi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_spi.c b/drivers/char/tpm/tpm_tis_spi.c
index c4f511b..2758b41 100644
--- a/drivers/char/tpm/tpm_tis_spi.c
+++ b/drivers/char/tpm/tpm_tis_spi.c
@@ -88,9 +88,8 @@ static int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
 
 		if ((phy->iobuf[3] & 0x01) == 0) {
 			// handle SPI wait states
-			phy->iobuf[0] = 0;
-
 			for (i = 0; i < TPM_RETRY; i++) {
+				phy->iobuf[0] = addr;
 				spi_xfer.len = 1;
 				spi_message_init(&m);
 				spi_message_add_tail(&spi_xfer, &m);
-- 
2.7.4

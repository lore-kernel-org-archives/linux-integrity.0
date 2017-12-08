Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from smtp2.infineon.com ([217.10.52.18]:58397 "EHLO
        smtp2.infineon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752003AbdLHSxp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 8 Dec 2017 13:53:45 -0500
From: Alexander Steffen <Alexander.Steffen@infineon.com>
To: <jarkko.sakkinen@linux.intel.com>, <nayna@linux.vnet.ibm.com>,
        <kgold@linux.vnet.ibm.com>, <linux-integrity@vger.kernel.org>
CC: Alexander Steffen <Alexander.Steffen@infineon.com>
Subject: [RFC][PATCH 8/9] tpm_tis_spi: add delay between wait state retries
Date: Fri, 8 Dec 2017 19:46:57 +0100
Message-ID: <20171208184658.9588-9-Alexander.Steffen@infineon.com>
In-Reply-To: <20171208184658.9588-1-Alexander.Steffen@infineon.com>
References: <20171208184658.9588-1-Alexander.Steffen@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

There do not seem to be any real limits one the amount/duration of wait
states that the TPM is allowed to generate. So at least give the TPM some
time to clean up the situation that caused the wait states instead of
retrying the transfers as fast as possible.

Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
---
 drivers/char/tpm/tpm_tis_spi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_spi.c b/drivers/char/tpm/tpm_tis_spi.c
index 2cc6aa9..e53c9c3 100644
--- a/drivers/char/tpm/tpm_tis_spi.c
+++ b/drivers/char/tpm/tpm_tis_spi.c
@@ -88,7 +88,7 @@ static int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
 
 		if ((phy->iobuf[3] & 0x01) == 0) {
 			// handle SPI wait states
-			for (i = 0; i < TPM_RETRY; i++) {
+			for (i = 1; i <= TPM_RETRY; i++) {
 				phy->iobuf[0] = addr;
 				spi_xfer.len = 1;
 				spi_message_init(&m);
@@ -98,9 +98,10 @@ static int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
 					goto exit;
 				if (phy->iobuf[0] & 0x01)
 					break;
+				tpm_msleep(i * TPM_TIMEOUT);
 			}
 
-			if (i == TPM_RETRY) {
+			if (i > TPM_RETRY) {
 				spi_xfer.tx_buf = NULL;
 				spi_xfer.rx_buf = NULL;
 				spi_xfer.len = 0;
-- 
2.7.4

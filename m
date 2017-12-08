Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from smtp2.infineon.com ([217.10.52.18]:63432 "EHLO
        smtp2.infineon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752003AbdLHSxQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 8 Dec 2017 13:53:16 -0500
From: Alexander Steffen <Alexander.Steffen@infineon.com>
To: <jarkko.sakkinen@linux.intel.com>, <nayna@linux.vnet.ibm.com>,
        <kgold@linux.vnet.ibm.com>, <linux-integrity@vger.kernel.org>
CC: Alexander Steffen <Alexander.Steffen@infineon.com>
Subject: [RFC][PATCH 7/9] tpm_tis_spi: release CS line when wait state handling fails
Date: Fri, 8 Dec 2017 19:46:56 +0100
Message-ID: <20171208184658.9588-8-Alexander.Steffen@infineon.com>
In-Reply-To: <20171208184658.9588-1-Alexander.Steffen@infineon.com>
References: <20171208184658.9588-1-Alexander.Steffen@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

By setting cs_change=1 multiple messages are kept within the same
transaction, i.e. the CS line is not released after the first message. This
is fine during normal transactions, when the last message sets cs_change=0,
so that the CS line is released at the end.

But when transactions cannot be completed, e.g. when the wait state
handling times out, the CS line is not released before leaving the
function, because no message is sent with cs_change=0. This breaks future
SPI transactions, so ensure that the CS line is correcly released in this
error case by sending an empty message.

Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
---
Note: I expect it to work that way, but have not tested it yet.

 drivers/char/tpm/tpm_tis_spi.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/char/tpm/tpm_tis_spi.c b/drivers/char/tpm/tpm_tis_spi.c
index 2758b41..2cc6aa9 100644
--- a/drivers/char/tpm/tpm_tis_spi.c
+++ b/drivers/char/tpm/tpm_tis_spi.c
@@ -101,6 +101,17 @@ static int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
 			}
 
 			if (i == TPM_RETRY) {
+				spi_xfer.tx_buf = NULL;
+				spi_xfer.rx_buf = NULL;
+				spi_xfer.len = 0;
+				spi_xfer.cs_change = 0;
+
+				spi_message_init(&m);
+				spi_message_add_tail(&spi_xfer, &m);
+				ret = spi_sync_locked(phy->spi_device, &m);
+				if (ret < 0)
+					goto exit;
+
 				ret = -ETIMEDOUT;
 				goto exit;
 			}
-- 
2.7.4

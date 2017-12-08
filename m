Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from smtp2.infineon.com ([217.10.52.18]:50613 "EHLO
        smtp2.infineon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752003AbdLHSy2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 8 Dec 2017 13:54:28 -0500
From: Alexander Steffen <Alexander.Steffen@infineon.com>
To: <jarkko.sakkinen@linux.intel.com>, <nayna@linux.vnet.ibm.com>,
        <kgold@linux.vnet.ibm.com>, <linux-integrity@vger.kernel.org>
Subject: [RFC][PATCH 9/9] tpm: ignore burstcount to improve tpm_tis send() performance
Date: Fri, 8 Dec 2017 19:46:58 +0100
Message-ID: <20171208184658.9588-10-Alexander.Steffen@infineon.com>
In-Reply-To: <20171208184658.9588-1-Alexander.Steffen@infineon.com>
References: <20171208184658.9588-1-Alexander.Steffen@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

From: Nayna Jain <nayna@linux.vnet.ibm.com>

The TPM burstcount status indicates the number of bytes that can
be sent to the TPM without causing bus wait states.  Effectively,
it is the number of empty bytes in the command FIFO.

This patch optimizes the tpm_tis_send_data() function by checking
the burstcount only once. And if the burstcount is valid, it writes
all the bytes at once, permitting wait state.

After this change, performance on a TPM 1.2 with an 8 byte
burstcount for 1000 extends improved from ~41sec to ~14sec.

Suggested-by: Ken Goldman <kgold@linux.vnet.ibm.com> in
conjunction with the TPM Device Driver work group.
Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>
Acked-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 drivers/char/tpm/tpm_tis_core.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 7240ee4..7979b06 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -320,7 +320,6 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
 {
 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
 	int rc, status, burstcnt;
-	size_t count = 0;
 
 	status = tpm_tis_status(chip);
 	if ((status & TPM_STS_COMMAND_READY) == 0) {
@@ -333,23 +332,23 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
 		}
 	}
 
-	while (count < len) {
-		burstcnt = get_burstcount(chip);
-		if (burstcnt < 0) {
-			dev_err(&chip->dev, "Unable to read burstcount\n");
-			rc = burstcnt;
-			goto out_err;
-		}
-		burstcnt = min_t(int, burstcnt, len - count);
-		rc = tpm_tis_write_bytes(priv, ADD_LOCALITY(priv->fifo_address,
-							    priv->locality),
-					 burstcnt, buf + count);
-		if (rc < 0)
-			goto out_err;
-
-		count += burstcnt;
+	/*
+	 * Get the initial burstcount to ensure TPM is ready to
+	 * accept data.
+	 */
+	burstcnt = get_burstcount(chip);
+	if (burstcnt < 0) {
+		dev_err(&chip->dev, "Unable to read burstcount\n");
+		rc = burstcnt;
+		goto out_err;
 	}
 
+	rc = tpm_tis_write_bytes(priv, ADD_LOCALITY(priv->fifo_address,
+						    priv->locality),
+				 len, buf);
+	if (rc < 0)
+		goto out_err;
+
 	if (!(priv->flags & TPM_TIS_ITPM_WORKAROUND) &&
 	    wait_for_tpm_stat(chip, TPM_STS_DATA_EXPECT | TPM_STS_VALID,
 			      TPM_STS_VALID, chip->timeout_c, &priv->int_queue,
-- 
2.7.4

Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from smtp11.infineon.com ([217.10.52.105]:27459 "EHLO
        smtp11.infineon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751275AbdLHSsP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 8 Dec 2017 13:48:15 -0500
From: Alexander Steffen <Alexander.Steffen@infineon.com>
To: <jarkko.sakkinen@linux.intel.com>, <nayna@linux.vnet.ibm.com>,
        <kgold@linux.vnet.ibm.com>, <linux-integrity@vger.kernel.org>
CC: Alexander Steffen <Alexander.Steffen@infineon.com>
Subject: [RFC][PATCH 3/9] tpm_tis_core: correctly wait for flags to become zero
Date: Fri, 8 Dec 2017 19:46:52 +0100
Message-ID: <20171208184658.9588-4-Alexander.Steffen@infineon.com>
In-Reply-To: <20171208184658.9588-1-Alexander.Steffen@infineon.com>
References: <20171208184658.9588-1-Alexander.Steffen@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

According to TIS/PTP the dataAvail flag and the Expect flag in the STS
register contain valid values if and only if the stsValid flag in the same
register is set. Currently, the code first waits for the stsValid flag to
be set and then looks at the other flags. This causes the STS register to
be read twice, so that the stsValid flag might not be set anymore when the
other flags are evaluated.

Other parts of the code already check both flags in a single operation
within wait_for_tpm_stat. But the current implementation can only check for
flags being set to 1, not 0. Therefore, add a parameter to
wait_for_tpm_stat that allows to specify the expected value in addition to
the selected flags and adapt all callers accordingly.

In addition, this now checks the dataAvail and Expect flags multiple times
within the specified timeout, so those flags no longer need to have the
expected value right away. This is important for example when sending large
amounts of data to the TPM, when the TPM might not process its I/O buffer
fast enough for the flags to be set correctly when they are checked for the
first time.

Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
---
 drivers/char/tpm/tpm_tis_core.c | 51 +++++++++++++++++------------------------
 1 file changed, 21 insertions(+), 30 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index d367016..0df05b4 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -37,13 +37,13 @@
  */
 #define TPM_POLL_SLEEP	1  /* msec */
 
-static bool wait_for_tpm_stat_cond(struct tpm_chip *chip, u8 mask,
+static bool wait_for_tpm_stat_cond(struct tpm_chip *chip, u8 mask, u8 value,
 					bool check_cancel, bool *canceled)
 {
 	u8 status = chip->ops->status(chip);
 
 	*canceled = false;
-	if ((status & mask) == mask)
+	if ((status & mask) == value)
 		return true;
 	if (check_cancel && chip->ops->req_canceled(chip, status)) {
 		*canceled = true;
@@ -52,7 +52,7 @@ static bool wait_for_tpm_stat_cond(struct tpm_chip *chip, u8 mask,
 	return false;
 }
 
-static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
+static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask, u8 value,
 		unsigned long timeout, wait_queue_head_t *queue,
 		bool check_cancel)
 {
@@ -63,7 +63,7 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
 
 	/* check current status */
 	status = chip->ops->status(chip);
-	if ((status & mask) == mask)
+	if ((status & mask) == value)
 		return 0;
 
 	stop = jiffies + timeout;
@@ -74,7 +74,7 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
 		if ((long)timeout <= 0)
 			return -ETIME;
 		rc = wait_event_interruptible_timeout(*queue,
-			wait_for_tpm_stat_cond(chip, mask, check_cancel,
+			wait_for_tpm_stat_cond(chip, mask, value, check_cancel,
 					       &canceled),
 			timeout);
 		if (rc > 0) {
@@ -90,7 +90,7 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
 		do {
 			tpm_msleep(TPM_POLL_SLEEP);
 			status = chip->ops->status(chip);
-			if ((status & mask) == mask)
+			if ((status & mask) == value)
 				return 0;
 		} while (time_before(jiffies, stop));
 	}
@@ -243,6 +243,7 @@ static int recv_data(struct tpm_chip *chip, u8 *buf, size_t count)
 	while (size < count) {
 		rc = wait_for_tpm_stat(chip,
 				 TPM_STS_DATA_AVAIL | TPM_STS_VALID,
+				 TPM_STS_DATA_AVAIL | TPM_STS_VALID,
 				 chip->timeout_c,
 				 &priv->read_queue, true);
 		if (rc < 0)
@@ -268,7 +269,7 @@ static int tpm_tis_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 {
 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
 	int size = 0;
-	int expected, status;
+	int expected;
 
 	if (count < TPM_HEADER_SIZE) {
 		size = -EIO;
@@ -296,13 +297,9 @@ static int tpm_tis_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 		goto out;
 	}
 
-	if (wait_for_tpm_stat(chip, TPM_STS_VALID, chip->timeout_c,
+	if (wait_for_tpm_stat(chip, TPM_STS_DATA_AVAIL | TPM_STS_VALID,
+			      TPM_STS_VALID, chip->timeout_c,
 				&priv->int_queue, false) < 0) {
-		size = -ETIME;
-		goto out;
-	}
-	status = tpm_tis_status(chip);
-	if (status & TPM_STS_DATA_AVAIL) {	/* retry? */
 		dev_err(&chip->dev, "Error left over data\n");
 		size = -EIO;
 		goto out;
@@ -329,8 +326,8 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
 	if ((status & TPM_STS_COMMAND_READY) == 0) {
 		tpm_tis_ready(chip);
 		if (wait_for_tpm_stat
-		    (chip, TPM_STS_COMMAND_READY, chip->timeout_b,
-		     &priv->int_queue, false) < 0) {
+		    (chip, TPM_STS_COMMAND_READY, TPM_STS_COMMAND_READY,
+		     chip->timeout_b, &priv->int_queue, false) < 0) {
 			rc = -ETIME;
 			goto out_err;
 		}
@@ -351,13 +348,10 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
 
 		count += burstcnt;
 
-		if (wait_for_tpm_stat(chip, TPM_STS_VALID, chip->timeout_c,
-					&priv->int_queue, false) < 0) {
-			rc = -ETIME;
-			goto out_err;
-		}
-		status = tpm_tis_status(chip);
-		if (!itpm && (status & TPM_STS_DATA_EXPECT) == 0) {
+		if (!itpm && wait_for_tpm_stat
+			     (chip, TPM_STS_DATA_EXPECT | TPM_STS_VALID,
+			      TPM_STS_DATA_EXPECT | TPM_STS_VALID,
+			      chip->timeout_c, &priv->int_queue, false) < 0) {
 			rc = -EIO;
 			goto out_err;
 		}
@@ -368,13 +362,9 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
 	if (rc < 0)
 		goto out_err;
 
-	if (wait_for_tpm_stat(chip, TPM_STS_VALID, chip->timeout_c,
-				&priv->int_queue, false) < 0) {
-		rc = -ETIME;
-		goto out_err;
-	}
-	status = tpm_tis_status(chip);
-	if (!itpm && (status & TPM_STS_DATA_EXPECT) != 0) {
+	if (!itpm && wait_for_tpm_stat
+		     (chip, TPM_STS_DATA_EXPECT | TPM_STS_VALID, TPM_STS_VALID,
+		      chip->timeout_c, &priv->int_queue, false) < 0) {
 		rc = -EIO;
 		goto out_err;
 	}
@@ -434,7 +424,8 @@ static int tpm_tis_send_main(struct tpm_chip *chip, const u8 *buf, size_t len)
 			dur = tpm_calc_ordinal_duration(chip, ordinal);
 
 		if (wait_for_tpm_stat
-		    (chip, TPM_STS_DATA_AVAIL | TPM_STS_VALID, dur,
+		    (chip, TPM_STS_DATA_AVAIL | TPM_STS_VALID,
+		     TPM_STS_DATA_AVAIL | TPM_STS_VALID, dur,
 		     &priv->read_queue, false) < 0) {
 			rc = -ETIME;
 			goto out_err;
-- 
2.7.4

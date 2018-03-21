Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:41732 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752556AbeCUSpv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 21 Mar 2018 14:45:51 -0400
Message-ID: <1521657949.6397.22.camel@HansenPartnership.com>
Subject: [PATCH v2 2/2] tpm: fix intermittent failure with self tests
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Date: Wed, 21 Mar 2018 11:45:49 -0700
In-Reply-To: <1521657747.6397.18.camel@HansenPartnership.com>
References: <1521657747.6397.18.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

My Nuvoton 6xx in a Dell XPS-13 has been intermittently failing to work
(necessitating a reboot). The problem seems to be that the TPM gets into a
state where the partial self-test doesn't return TPM_RC_SUCCESS (meaning
all tests have run to completion), but instead returns TPM_RC_TESTING
(meaning some tests are still running in the background).  There are
various theories that resending the self-test command actually causes the
tests to restart and thus triggers more TPM_RC_TESTING returns until the
timeout is exceeded.

There are several issues here: firstly being we shouldn't slow down the
boot sequence waiting for the self test to complete once the TPM
backgrounds them.  It will actually make available all functions that have
passed and if it gets a failure return TPM_RC_FAILURE to every subsequent
command.  So the fix is to kick off self tests once and if they return
TPM_RC_TESTING log that as a backgrounded self test and continue on.  In
order to prevent other tpm users from seeing any TPM_RC_TESTING returns
(which it might if they send a command that needs a TPM subsystem which is
still under test), we loop in tpm_transmit_cmd until either a timeout or we
don't get a TPM_RC_TESTING return.

Finally, there have been observations of strange returns from a partial
test. One Nuvoton is occasionally returning TPM_RC_COMMAND_CODE, so treat
any unexpected return from a partial self test as an indication we need to
run a full self test.

[jarkko.sakkinen@linux.intel.com: cleaned up some klog messages and
 dropped tpm_transmit_check() helper function from James' original
 commit.]

Fixes: 2482b1bba5122 ("tpm: Trigger only missing TPM 2.0 self tests")
Cc: stable@vger.kernel.org
Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Tested-by: Jarkko Sakkinen <jarkko.sakkine@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkine@linux.intel.com>

---

v2:

Take the original commit from the tpmdd tree (which didn't work
because of a failure to restore the header and handles) and integrate
the TPM2_RC_TESTING retry logic with TPM2_RC_RETRY handling.  Have
tested this version in the face of TPM2_RC_TESTING returns using an
emulator
---
 drivers/char/tpm/tpm-interface.c | 16 ++++++++++--
 drivers/char/tpm/tpm.h           |  1 +
 drivers/char/tpm/tpm2-cmd.c      | 54 ++++++++++++----------------------------
 3 files changed, 31 insertions(+), 40 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 9e9bb62ae6b8..62fee2c10013 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -569,6 +569,8 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
 	ssize_t ret;
 	const size_t save_size = min(space ? sizeof(save) : TPM_HEADER_SIZE,
 				     bufsiz);
+	/* the command code is where the return code will be */
+	u32 cc = be32_to_cpu(header->return_code);
 
 	/*
 	 * Subtlety here: if we have a space, the handles will be
@@ -582,11 +584,21 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
 		if (ret < 0)
 			break;
 		rc = be32_to_cpu(header->return_code);
-		if (rc != TPM2_RC_RETRY)
+		if (rc != TPM2_RC_RETRY && rc != TPM2_RC_TESTING)
+			break;
+		/*
+		 * return immediately if self test returns test
+		 * still running to shorten boot time.
+		 */
+		if (rc == TPM2_RC_TESTING && cc == TPM2_CC_SELF_TEST)
 			break;
 		delay_msec *= 2;
 		if (delay_msec > TPM2_DURATION_LONG) {
-			dev_err(&chip->dev, "TPM is in retry loop\n");
+			if (rc == TPM2_RC_RETRY)
+				dev_err(&chip->dev, "in retry loop\n");
+			else
+				dev_err(&chip->dev,
+					"self test is still running\n");
 			break;
 		}
 		tpm_msleep(delay_msec);
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 05967c1a1f32..c542f877cea7 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -108,6 +108,7 @@ enum tpm2_return_codes {
 	TPM2_RC_HASH		= 0x0083, /* RC_FMT1 */
 	TPM2_RC_HANDLE		= 0x008B,
 	TPM2_RC_INITIALIZE	= 0x0100, /* RC_VER1 */
+	TPM2_RC_FAILURE		= 0x0101,
 	TPM2_RC_DISABLED	= 0x0120,
 	TPM2_RC_COMMAND_CODE    = 0x0143,
 	TPM2_RC_TESTING		= 0x090A, /* RC_WARN */
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 47f612ded599..909150f6db7f 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -24,10 +24,6 @@ struct tpm2_startup_in {
 	__be16	startup_type;
 } __packed;
 
-struct tpm2_self_test_in {
-	u8	full_test;
-} __packed;
-
 struct tpm2_get_tpm_pt_in {
 	__be32	cap_id;
 	__be32	property_id;
@@ -49,7 +45,6 @@ struct tpm2_get_random_out {
 
 union tpm2_cmd_params {
 	struct	tpm2_startup_in		startup_in;
-	struct	tpm2_self_test_in	selftest_in;
 	struct	tpm2_get_tpm_pt_in	get_tpm_pt_in;
 	struct	tpm2_get_tpm_pt_out	get_tpm_pt_out;
 };
@@ -864,16 +859,6 @@ unsigned long tpm2_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal)
 }
 EXPORT_SYMBOL_GPL(tpm2_calc_ordinal_duration);
 
-#define TPM2_SELF_TEST_IN_SIZE \
-	(sizeof(struct tpm_input_header) + \
-	 sizeof(struct tpm2_self_test_in))
-
-static const struct tpm_input_header tpm2_selftest_header = {
-	.tag = cpu_to_be16(TPM2_ST_NO_SESSIONS),
-	.length = cpu_to_be32(TPM2_SELF_TEST_IN_SIZE),
-	.ordinal = cpu_to_be32(TPM2_CC_SELF_TEST)
-};
-
 /**
  * tpm2_do_selftest() - ensure that all self tests have passed
  *
@@ -889,27 +874,24 @@ static const struct tpm_input_header tpm2_selftest_header = {
  */
 static int tpm2_do_selftest(struct tpm_chip *chip)
 {
+	struct tpm_buf buf;
+	int full;
 	int rc;
-	unsigned int delay_msec = 10;
-	long duration;
-	struct tpm2_cmd cmd;
 
-	duration = jiffies_to_msecs(
-		tpm2_calc_ordinal_duration(chip, TPM2_CC_SELF_TEST));
-
-	while (1) {
-		cmd.header.in = tpm2_selftest_header;
-		cmd.params.selftest_in.full_test = 0;
-
-		rc = tpm_transmit_cmd(chip, NULL, &cmd, TPM2_SELF_TEST_IN_SIZE,
-				      0, 0, "continue selftest");
+	for (full = 0; full < 2; full++) {
+		rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_SELF_TEST);
+		if (rc)
+			return rc;
 
-		if (rc != TPM2_RC_TESTING || delay_msec >= duration)
-			break;
+		tpm_buf_append_u8(&buf, full);
+		rc = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE, 0, 0,
+				      "attempting the self test");
+		tpm_buf_destroy(&buf);
 
-		/* wait longer than before */
-		delay_msec *= 2;
-		tpm_msleep(delay_msec);
+		if (rc == TPM2_RC_TESTING)
+			rc = TPM2_RC_SUCCESS;
+		if (rc == TPM2_RC_INITIALIZE || rc == TPM2_RC_SUCCESS)
+			return rc;
 	}
 
 	return rc;
@@ -1095,10 +1077,8 @@ int tpm2_auto_startup(struct tpm_chip *chip)
 		goto out;
 
 	rc = tpm2_do_selftest(chip);
-	if (rc != 0 && rc != TPM2_RC_INITIALIZE) {
-		dev_err(&chip->dev, "TPM self test failed\n");
+	if (rc && rc != TPM2_RC_INITIALIZE)
 		goto out;
-	}
 
 	if (rc == TPM2_RC_INITIALIZE) {
 		rc = tpm_startup(chip);
@@ -1106,10 +1086,8 @@ int tpm2_auto_startup(struct tpm_chip *chip)
 			goto out;
 
 		rc = tpm2_do_selftest(chip);
-		if (rc) {
-			dev_err(&chip->dev, "TPM self test failed\n");
+		if (rc)
 			goto out;
-		}
 	}
 
 	rc = tpm2_get_pcr_allocation(chip);
-- 
2.12.3

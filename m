Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:50504 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752655AbeBSMYD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Feb 2018 07:24:03 -0500
Message-ID: <1519043040.4721.5.camel@HansenPartnership.com>
Subject: [PATCH v3] tpm: fix intermittent failure with self tests
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Mon, 19 Feb 2018 07:24:00 -0500
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Ever since

commit 2482b1bba5122b1d5516c909832bdd282015b8e9
Author: Alexander Steffen <Alexander.Steffen@infineon.com>
Date:   Thu Aug 31 19:18:56 2017 +0200

    tpm: Trigger only missing TPM 2.0 self tests

My Nuvoton 6xx in a Dell XPS-13 has been intermittently failing to
work (necessitating a reboot). The problem seems to be that the TPM
gets into a state where the partial self-test doesn't return
TPM_RC_SUCCESS (meaning all tests have run to completion), but instead
returns TPM_RC_TESTING (meaning some tests are still running in the
background).  There are various theories that resending the self-test
command actually causes the tests to restart and thus triggers more
TPM_RC_TESTING returns until the timeout is exceeded.

There are several issues here: firstly being we shouldn't slow down
the boot sequence waiting for the self test to complete once the TPM
backgrounds them.  It will actually make available all functions that
have passed and if it gets a failure return TPM_RC_FAILURE to every
subsequent command.  So the fix is to kick off self tests once and if
they return TPM_RC_TESTING log that as a backgrounded self test and
continue on.  In order to prevent other tpm users from seeing any
TPM_RC_TESTING returns (which it might if they send a command that
needs a TPM subsystem which is still under test), we loop in
tpm_transmit_cmd until either a timeout or we don't get a
TPM_RC_TESTING return.

Finally, there have been observations of strange returns from a
partial test. One Nuvoton is occasionally returning
TPM_RC_COMMAND_CODE, so treat any unexpected return from a partial
self test as an indication we need to run a full self test.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Fixes: 2482b1bba5122b1d5516c909832bdd282015b8e9

---
v3: - must pass through TPM2_RC_INTIALIZE
v2: - review feedback: encapsulate transmission and rename NOWAIT constant
    - Rewrite selftest routine to run full test on any unexpected
      (meaning not TPM2_RC_TESTING, TPM2_RC_SUCCESS or
      TPM2_RC_FAILURE) from the partial selftest.
---
 drivers/char/tpm/tpm-interface.c | 37 ++++++++++++++++++++++++++++-
 drivers/char/tpm/tpm.h           |  6 +++--
 drivers/char/tpm/tpm2-cmd.c      | 50 ++++++++++++++++++++++++++++++----------
 3 files changed, 78 insertions(+), 15 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 9e80a953d693..b9a8914b05d9 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -515,6 +515,41 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
 	return rc ? rc : len;
 }
 
+static ssize_t tpm_transmit_check(struct tpm_chip *chip,
+				  struct tpm_space *space, const void *buf,
+				  size_t bufsiz, unsigned int flags)
+{
+	const struct tpm_output_header *header = buf;
+	unsigned int delay_msec = 20;
+	ssize_t len;
+	u32 err;
+
+	/*
+	 * on first probe we kick off a TPM self test in the
+	 * background This means the TPM may return RC_TESTING to any
+	 * command that tries to use a subsystem under test, so do an
+	 * exponential backoff wait if that happens
+	 */
+	for (;;) {
+		len = tpm_transmit(chip, space, (u8 *)buf, bufsiz, flags);
+		if (len <  0)
+			return len;
+
+		err = be32_to_cpu(header->return_code);
+		if (err != TPM2_RC_TESTING ||
+		    (flags & TPM_TRANSMIT_NO_WAIT_TESTING))
+			break;
+
+		delay_msec *= 2;
+		if (delay_msec > TPM2_DURATION_LONG) {
+			dev_err(&chip->dev,"TPM: still running self tests, giving up waiting\n");
+			break;
+		}
+		tpm_msleep(delay_msec);
+	}
+	return len;
+}
+
 /**
  * tmp_transmit_cmd - send a tpm command to the device
  *    The function extracts tpm out header return code
@@ -540,7 +575,7 @@ ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_space *space,
 	int err;
 	ssize_t len;
 
-	len = tpm_transmit(chip, space, (u8 *)buf, bufsiz, flags);
+	len = tpm_transmit_check(chip, space, buf, bufsiz, flags);
 	if (len <  0)
 		return len;
 
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index f895fba4e20d..3e083a30a108 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -104,6 +104,7 @@ enum tpm2_return_codes {
 	TPM2_RC_HASH		= 0x0083, /* RC_FMT1 */
 	TPM2_RC_HANDLE		= 0x008B,
 	TPM2_RC_INITIALIZE	= 0x0100, /* RC_VER1 */
+	TPM2_RC_FAILURE		= 0x0101,
 	TPM2_RC_DISABLED	= 0x0120,
 	TPM2_RC_COMMAND_CODE    = 0x0143,
 	TPM2_RC_TESTING		= 0x090A, /* RC_WARN */
@@ -499,8 +500,9 @@ extern const struct file_operations tpmrm_fops;
 extern struct idr dev_nums_idr;
 
 enum tpm_transmit_flags {
-	TPM_TRANSMIT_UNLOCKED	= BIT(0),
-	TPM_TRANSMIT_RAW	= BIT(1),
+	TPM_TRANSMIT_UNLOCKED		= BIT(0),
+	TPM_TRANSMIT_RAW		= BIT(1),
+	TPM_TRANSMIT_NO_WAIT_TESTING	= BIT(2),
 };
 
 ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index e5052e2f1924..13d9e74084aa 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -838,29 +838,55 @@ EXPORT_SYMBOL_GPL(tpm2_calc_ordinal_duration);
 static int tpm2_do_selftest(struct tpm_chip *chip)
 {
 	int rc;
-	unsigned int delay_msec = 10;
-	long duration;
 	struct tpm_buf buf;
+	int full_test;
 
-	duration = jiffies_to_msecs(
-		tpm2_calc_ordinal_duration(chip, TPM2_CC_SELF_TEST));
+	for (full_test = 0; full_test < 2; full_test++) {
+		const char *test_str = full_test ?
+			"full selftest" : "incremental selftest";
 
-	for (;;) {
 		rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_SELF_TEST);
 		if (rc)
 			return rc;
 
-		/* Perform tests in the background. */
-		tpm_buf_append_u8(&buf, 0);
+		tpm_buf_append_u8(&buf, full_test);
+		dev_info(&chip->dev, "TPM: running %s\n", test_str);
 		rc = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE, 0, 0,
-				      "continue selftest");
+				      test_str);
 		tpm_buf_destroy(&buf);
-		if (rc != TPM2_RC_TESTING || delay_msec >= duration)
+
+		if (rc == TPM2_RC_INITIALIZE)
+			/* TPM needs startup command */
+			return rc;
+
+		if (rc == TPM2_RC_TESTING) {
+			/*
+			 * A return of RC_TESTING means the TPM is still
+			 * running self tests.  If one fails it will go into
+			 * failure mode and return RC_FAILED to every command,
+			 * so treat a still in testing return as a success
+			 * rather than causing a driver detach.
+			 */
+			dev_info(&chip->dev, "TPM: Running self test in background\n");
+			rc = TPM2_RC_SUCCESS;
+		}
+		if (rc == TPM2_RC_SUCCESS)
 			break;
 
-		/* wait longer than before */
-		delay_msec *= 2;
-		tpm_msleep(delay_msec);
+		dev_info(&chip->dev, "TPM: %s failed\n", test_str);
+	}
+
+	if (rc == TPM2_RC_SUCCESS) {
+		dev_info(&chip->dev, "TPM: selftest succeeded\n");
+	} else if (rc == TPM2_RC_FAILURE) {
+		dev_err(&chip->dev, "TPM: selftest failed\n");
+	} else {
+		/*
+		 * Any other error code is unexpected but should not
+		 * prevent the driver from attaching
+		 */
+		dev_err(&chip->dev, "TPM: selftest returns 0x%x, continuing anyway\n", rc);
+		rc = TPM2_RC_SUCCESS;
 	}
 
 	return rc;
-- 
2.12.3

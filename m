Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:54294 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753020AbeCQBWg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Mar 2018 21:22:36 -0400
Message-ID: <1521249754.12827.7.camel@HansenPartnership.com>
Subject: [PATCH] tpm: add retry logic
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Fri, 16 Mar 2018 18:22:34 -0700
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

TPM2 can return TPM2_RC_RETRY to any command and when it does we get
unexpected failures inside the kernel that surprise users (this is
mostly observed in the trusted key handling code).  The UEFI 2.6 spec
has advice on how to handle this:

    The firmware SHALL not return TPM2_RC_RETRY prior to the completion
    of the call to ExitBootServices().

    Implementer's Note: the implementation of this function should check
    the return value in the TPM response and, if it is TPM2_RC_RETRY,
    resend the command. The implementation may abort if a sufficient
    number of retries has been done.

So we follow that advice in our tpm_transmit() code using
TPM2_DURATION_SHORT as the initial wait duration and
TPM2_DURATION_LONG as the maximum wait time.  This should fix all the
in-kernel use cases and also means that user space TSS implementations
don't have to have their own retry handling.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: stable@vger.kernel.org
---
 drivers/char/tpm/tpm-interface.c | 75 ++++++++++++++++++++++++++++++++--------
 drivers/char/tpm/tpm.h           |  1 +
 2 files changed, 61 insertions(+), 15 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 7c3380201960..1d25d1dca2f0 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -398,21 +398,10 @@ static void tpm_relinquish_locality(struct tpm_chip *chip)
 	chip->locality = -1;
 }
 
-/**
- * tpm_transmit - Internal kernel interface to transmit TPM commands.
- *
- * @chip: TPM chip to use
- * @space: tpm space
- * @buf: TPM command buffer
- * @bufsiz: length of the TPM command buffer
- * @flags: tpm transmit flags - bitmap
- *
- * Return:
- *     0 when the operation is successful.
- *     A negative number for system errors (errno).
- */
-ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
-		     u8 *buf, size_t bufsiz, unsigned int flags)
+static ssize_t tpm_transmit_internal(struct tpm_chip *chip,
+				     struct tpm_space *space,
+				     u8 *buf, size_t bufsiz,
+				     unsigned int flags)
 {
 	struct tpm_output_header *header = (void *)buf;
 	int rc;
@@ -550,6 +539,62 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
 }
 
 /**
+ * tpm_transmit - Internal kernel interface to transmit TPM commands.
+ *
+ * @chip: TPM chip to use
+ * @space: tpm space
+ * @buf: TPM command buffer
+ * @bufsiz: length of the TPM command buffer
+ * @flags: tpm transmit flags - bitmap
+ *
+ * A wrapper around tpm_transmit_internal that handles TPM2_RC_RETRY
+ * returns from the TPM and retransmits the command after a delay up
+ * to a maximum wait of TPM2_DURATION_LONG.
+ *
+ * Note: TPM1 never returns TPM2_RC_RETRY so the retry logic is TPM2
+ * only
+ *
+ * Return:
+ *     the length of the return when the operation is successful.
+ *     A negative number for system errors (errno).
+ */
+ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
+		     u8 *buf, size_t bufsiz, unsigned int flags)
+{
+	struct tpm_output_header *header = (struct tpm_output_header *)buf;
+	/* space for header and handles */
+	u8 save[TPM_HEADER_SIZE + 3*sizeof(u32)];
+	unsigned int delay_msec = TPM2_DURATION_SHORT;
+	u32 rc = 0;
+	ssize_t ret;
+	const size_t save_size = min(space ? sizeof(save): TPM_HEADER_SIZE,
+				     bufsiz);
+
+	/*
+	 * Subtlety here: if we have a space, the handles will be
+	 * transformed, so when we restore the header we also have to
+	 * restore the handles.
+	 */
+	memcpy(save, buf, save_size);
+
+	for (;;) {
+		ret = tpm_transmit_internal(chip, space, buf, bufsiz, flags);
+		if (ret < 0)
+			break;
+		rc = be32_to_cpu(header->return_code);
+		if (rc != TPM2_RC_RETRY)
+			break;
+		delay_msec *= 2;
+		if (delay_msec > TPM2_DURATION_LONG) {
+			dev_err(&chip->dev, "TPM is in retry loop\n");
+			break;
+		}
+		tpm_msleep(delay_msec);
+		memcpy(buf, save, save_size);
+	}
+	return ret;
+}
+/**
  * tpm_transmit_cmd - send a tpm command to the device
  *    The function extracts tpm out header return code
  *
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index b2547a11271a..c542f877cea7 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -113,6 +113,7 @@ enum tpm2_return_codes {
 	TPM2_RC_COMMAND_CODE    = 0x0143,
 	TPM2_RC_TESTING		= 0x090A, /* RC_WARN */
 	TPM2_RC_REFERENCE_H0	= 0x0910,
+	TPM2_RC_RETRY		= 0x0922,
 };
 
 enum tpm2_algorithms {
-- 
2.12.3

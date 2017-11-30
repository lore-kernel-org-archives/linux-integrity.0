Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:47077 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750783AbdK3HjL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 Nov 2017 02:39:11 -0500
Received: by mail-wm0-f68.google.com with SMTP id r78so11089188wme.5
        for <linux-integrity@vger.kernel.org>; Wed, 29 Nov 2017 23:39:11 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javierm@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Philip Tricca <philip.b.tricca@intel.com>,
        linux-integrity@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: [PATCH v3] tpm: return a TPM_RC_COMMAND_CODE response if command is not implemented
Date: Thu, 30 Nov 2017 08:39:07 +0100
Message-Id: <20171130073907.20708-1-javierm@redhat.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

According to the TPM Library Specification, a TPM device must do a command
header validation before processing and return a TPM_RC_COMMAND_CODE code
if the command is not implemented.

So user-space will expect to handle that response as an error. But if the
in-kernel resource manager is used (/dev/tpmrm?), an -EINVAL errno code is
returned instead if the command isn't implemented. This confuses userspace
since it doesn't expect that error value.

This also isn't consistent with the behavior when not using TPM spaces and
accessing the TPM directly (/dev/tpm?). In this case, the command is sent
to the TPM even when not implemented and the TPM responds with an error.

Instead of returning an -EINVAL errno code when the tpm_validate_command()
function fails, synthesize a TPM command response so user-space can get a
TPM_RC_COMMAND_CODE as expected when a chip doesn't implement the command.

The TPM only sets 12 of the 32 bits in the TPM_RC response, so the TSS and
TAB specifications define that higher layers in the stack should use some
of the unused 20 bits to specify from which level of the stack the error
is coming from.

Since the TPM_RC_COMMAND_CODE response code is sent by the kernel resource
manager, set the error level to the TAB/RM layer so user-space is aware of
this.

Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Philip Tricca <philip.b.tricca@intel.com>

---

Changes since v2:
- Use TSS2 as prefix instead of TPM2 to match the spec (suggested by Jarkko
  Sakkinen).
- Add Philip's Reviewed-by tag as he asked and I missed in previous version.

Changes since v1:
- Remove the unused macros for the driver and resmgr RC layers (suggested by
  Philip Tricca).
- Use naming conventions from the latest version of the TSS spec (suggested
  by Philip Tricca).

Changes since RFCv2:
- Set the error level to the TAB/RM layer so user-space is aware that the error
  is not coming from the TPM (suggested by Philip Tricca and Jarkko Sakkinen).

Changes since RFCv1:
- Don't pass not validated commands to the TPM, instead return a synthesized
  response with the correct TPM return code (suggested by Jason Gunthorpe).

And example of user-space getting confused by the TPM chardev returning -EINVAL
when sending a not supported TPM command can be seen in this tpm2-tools issue:

https://github.com/intel/tpm2-tools/issues/621

Best regards,
Javier

 drivers/char/tpm/tpm-interface.c | 28 ++++++++++++++++++++--------
 drivers/char/tpm/tpm.h           |  5 +++++
 2 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 1d6729be4cd6..c5da6d3f7058 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -328,7 +328,7 @@ unsigned long tpm_calc_ordinal_duration(struct tpm_chip *chip,
 }
 EXPORT_SYMBOL_GPL(tpm_calc_ordinal_duration);
 
-static bool tpm_validate_command(struct tpm_chip *chip,
+static int tpm_validate_command(struct tpm_chip *chip,
 				 struct tpm_space *space,
 				 const u8 *cmd,
 				 size_t len)
@@ -340,10 +340,10 @@ static bool tpm_validate_command(struct tpm_chip *chip,
 	unsigned int nr_handles;
 
 	if (len < TPM_HEADER_SIZE)
-		return false;
+		return -EINVAL;
 
 	if (!space)
-		return true;
+		return 0;
 
 	if (chip->flags & TPM_CHIP_FLAG_TPM2 && chip->nr_commands) {
 		cc = be32_to_cpu(header->ordinal);
@@ -352,7 +352,7 @@ static bool tpm_validate_command(struct tpm_chip *chip,
 		if (i < 0) {
 			dev_dbg(&chip->dev, "0x%04X is an invalid command\n",
 				cc);
-			return false;
+			return -EOPNOTSUPP;
 		}
 
 		attrs = chip->cc_attrs_tbl[i];
@@ -362,11 +362,11 @@ static bool tpm_validate_command(struct tpm_chip *chip,
 			goto err_len;
 	}
 
-	return true;
+	return 0;
 err_len:
 	dev_dbg(&chip->dev,
 		"%s: insufficient command length %zu", __func__, len);
-	return false;
+	return -EINVAL;
 }
 
 /**
@@ -391,8 +391,20 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
 	unsigned long stop;
 	bool need_locality;
 
-	if (!tpm_validate_command(chip, space, buf, bufsiz))
-		return -EINVAL;
+	rc = tpm_validate_command(chip, space, buf, bufsiz);
+	if (rc == -EINVAL)
+		return rc;
+	/*
+	 * If the command is not implemented by the TPM, synthesize a
+	 * response with a TPM2_RC_COMMAND_CODE return for user-space.
+	 */
+	if (rc == -EOPNOTSUPP) {
+		header->length = cpu_to_be32(sizeof(*header));
+		header->tag = cpu_to_be16(TPM2_ST_NO_SESSIONS);
+		header->return_code = cpu_to_be32(TPM2_RC_COMMAND_CODE |
+						  TSS2_RESMGR_TPM_RC_LAYER);
+		return bufsiz;
+	}
 
 	if (bufsiz > TPM_BUFSIZE)
 		bufsiz = TPM_BUFSIZE;
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 2d5466a72e40..0b5b499f726a 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -93,12 +93,17 @@ enum tpm2_structures {
 	TPM2_ST_SESSIONS	= 0x8002,
 };
 
+/* Indicates from what layer of the software stack the error comes from */
+#define TSS2_RC_LAYER_SHIFT	 16
+#define TSS2_RESMGR_TPM_RC_LAYER (11 << TSS2_RC_LAYER_SHIFT)
+
 enum tpm2_return_codes {
 	TPM2_RC_SUCCESS		= 0x0000,
 	TPM2_RC_HASH		= 0x0083, /* RC_FMT1 */
 	TPM2_RC_HANDLE		= 0x008B,
 	TPM2_RC_INITIALIZE	= 0x0100, /* RC_VER1 */
 	TPM2_RC_DISABLED	= 0x0120,
+	TPM2_RC_COMMAND_CODE    = 0x0143,
 	TPM2_RC_TESTING		= 0x090A, /* RC_WARN */
 	TPM2_RC_REFERENCE_H0	= 0x0910,
 };
-- 
2.14.3

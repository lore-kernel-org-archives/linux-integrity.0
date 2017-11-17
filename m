Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:43040 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752696AbdKQKHd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 Nov 2017 05:07:33 -0500
Received: by mail-wm0-f66.google.com with SMTP id x63so5322017wmf.2
        for <linux-integrity@vger.kernel.org>; Fri, 17 Nov 2017 02:07:32 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javierm@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Philip Tricca <philip.b.tricca@intel.com>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        linux-integrity@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>
Subject: [RFC PATCH] tpm: don't return -EINVAL if TPM command validation fails
Date: Fri, 17 Nov 2017 11:07:24 +0100
Message-Id: <20171117100724.19257-1-javierm@redhat.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

According to the TPM Library Specification, a TPM device must do a command
header validation before processing and return a TPM_RC_COMMAND_CODE code
if the command is not implemented and the TPM_RC_COMMAND_SIZE code if the
command buffer size is not correct.

So user-space will expect to handle these response codes as errors, but if
the in-kernel resource manager is used (/dev/tpmrm?) then an -EINVAL errno
code is returned instead if the command isn't implemented or the buffer
size isn't correct. This confuses user-space since doesn't expect that.

This is also not consistent with the behavior when not using TPM spaces
and accessing the TPM directly (/dev/tpm?), in this case the command is
is sent to the TPM anyways and user-space can get an error from the TPM.

Instead of returning an -EINVAL errno code when the tpm_validate_command()
function fails, allow the command to be sent to the TPM but just don't do
any TPM space management. That way the TPM can report back a proper error
and the behavior be consistent when using either /dev/tpm? or /dev/tpmrm?.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

---

Hello,

This patch is an RFC because I'm not sure if this is the correct way to fix this
issue. I'm not that familiar with the TPM driver so may had missed some details.

And example of user-space getting confused by the TPM chardev returning -EINVAL
when sending a not supported TPM command can be seen in this tpm2-tools issue:

https://github.com/intel/tpm2-tools/issues/621

Best regards,
Javier

 drivers/char/tpm/tpm-interface.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 1d6729be4cd6..86527e9a27cc 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -390,9 +390,14 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
 	u32 count, ordinal;
 	unsigned long stop;
 	bool need_locality;
+	bool cmd_validated;
 
-	if (!tpm_validate_command(chip, space, buf, bufsiz))
-		return -EINVAL;
+	/*
+	 * If command validation fails, sent it to the TPM anyways so it can
+	 * report a proper error to user-space. Just don't do any TPM space
+	 * management in this case.
+	 */
+	cmd_validated = tpm_validate_command(chip, space, buf, bufsiz);
 
 	if (bufsiz > TPM_BUFSIZE)
 		bufsiz = TPM_BUFSIZE;
@@ -424,9 +429,11 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
 		chip->locality = rc;
 	}
 
-	rc = tpm2_prepare_space(chip, space, ordinal, buf);
-	if (rc)
-		goto out;
+	if (cmd_validated) {
+		rc = tpm2_prepare_space(chip, space, ordinal, buf);
+		if (rc)
+			goto out;
+	}
 
 	rc = chip->ops->send(chip, (u8 *) buf, count);
 	if (rc < 0) {
@@ -481,7 +488,8 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
 		goto out;
 	}
 
-	rc = tpm2_commit_space(chip, space, ordinal, buf, &len);
+	if (cmd_validated)
+		rc = tpm2_commit_space(chip, space, ordinal, buf, &len);
 
 out:
 	if (need_locality && chip->ops->relinquish_locality) {
-- 
2.14.3

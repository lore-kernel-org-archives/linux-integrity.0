Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga18.intel.com ([134.134.136.126]:20787 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935523AbeEISzg (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 9 May 2018 14:55:36 -0400
Subject: [PATCH] tpm: fix use after free in tpm2_load_context
From: Tadeusz Struk <tadeusz.struk@intel.com>
To: jarkko.sakkinen@linux.intel.com
Cc: jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        tpmdd-devel@lists.sourceforge.net, tadeusz.struk@intel.com
Date: Wed, 09 May 2018 11:55:35 -0700
Message-ID: <152589213590.23382.13567986597921947843.stgit@tstruk-mobl1.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

If load context command returns with TPM2_RC_HANDLE or
TPM2_RC_REFERENCE_H0 then we have use after free in
line 114 and double free in 117.

Fixes: 4d57856a21ed2 ("tpm2: add session handle context saving and restoring to the space code")

Signed-off-by: Tadeusz Struk <tadeusz.struk@intel.com>
---
 drivers/char/tpm/tpm2-space.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
index 4e4014eabdb9..6122d3276f72 100644
--- a/drivers/char/tpm/tpm2-space.c
+++ b/drivers/char/tpm/tpm2-space.c
@@ -102,8 +102,9 @@ static int tpm2_load_context(struct tpm_chip *chip, u8 *buf,
 		 * TPM_RC_REFERENCE_H0 means the session has been
 		 * flushed outside the space
 		 */
-		rc = -ENOENT;
+		*handle = 0;
 		tpm_buf_destroy(&tbuf);
+		return -ENOENT;
 	} else if (rc > 0) {
 		dev_warn(&chip->dev, "%s: failed with a TPM error 0x%04X\n",
 			 __func__, rc);

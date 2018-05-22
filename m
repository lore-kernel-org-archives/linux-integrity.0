Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:33710 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751272AbeEVRcr (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 22 May 2018 13:32:47 -0400
Subject: [PATCH] tpm: fix race condition in tpm_common_write()
From: Tadeusz Struk <tadeusz.struk@intel.com>
To: jarkko.sakkinen@linux.intel.com
Cc: jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        tadeusz.struk@intel.com
Date: Tue, 22 May 2018 10:32:46 -0700
Message-ID: <152701036671.19968.17347263774570787595.stgit@tstruk-mobl1.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

There is a race condition in tpm_common_write function allowing two
threads on the same /dev/tpm<N>, or two different applications on
the same /dev/tpmrm<N> to overwrite eachother requests/responses.

Signed-off-by: Tadeusz Struk <tadeusz.struk@intel.com>
---
 drivers/char/tpm/tpm-dev-common.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
index 230b99288024..1ce6f989f40a 100644
--- a/drivers/char/tpm/tpm-dev-common.c
+++ b/drivers/char/tpm/tpm-dev-common.c
@@ -91,17 +91,19 @@ ssize_t tpm_common_write(struct file *file, const char __user *buf,
 	size_t in_size = size;
 	ssize_t out_size;
 
+	if (in_size > TPM_BUFSIZE)
+		return -E2BIG;
+
+	mutex_lock(&priv->buffer_mutex);
+
 	/* Cannot perform a write until the read has cleared either via
 	 * tpm_read or a user_read_timer timeout. This also prevents split
 	 * buffered writes from blocking here.
 	 */
-	if (atomic_read(&priv->data_pending) != 0)
+	if (atomic_read(&priv->data_pending) != 0) {
+		mutex_unlock(&priv->buffer_mutex);
 		return -EBUSY;
-
-	if (in_size > TPM_BUFSIZE)
-		return -E2BIG;
-
-	mutex_lock(&priv->buffer_mutex);
+	}
 
 	if (copy_from_user
 	    (priv->data_buffer, (void __user *) buf, in_size)) {

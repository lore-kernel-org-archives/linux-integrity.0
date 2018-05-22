Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:52298 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752713AbeEVVhT (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 22 May 2018 17:37:19 -0400
Subject: [PATCH v2] tpm: fix race condition in tpm_common_write()
From: Tadeusz Struk <tadeusz.struk@intel.com>
To: jarkko.sakkinen@linux.intel.com
Cc: jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        tadeusz.struk@intel.com
Date: Tue, 22 May 2018 14:37:18 -0700
Message-ID: <152702503883.25871.17829919385428251068.stgit@tstruk-mobl1.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

There is a race condition in tpm_common_write function allowing
two threads on the same /dev/tpm<N>, or two different applications
on the same /dev/tpmrm<N> to overwrite each other commands/responses.
Fixed this by taking the priv->buffer_mutex early in the function.

Also converted the priv->data_pending from atomic to a regular size_t
type. There is no need for it to be atomic since it is only touched
under the protection of the priv->buffer_mutex.

v2: convert data_pending from atomic to a regular size_t type.

Signed-off-by: Tadeusz Struk <tadeusz.struk@intel.com>
---
 drivers/char/tpm/tpm-dev-common.c |   40 +++++++++++++++++--------------------
 drivers/char/tpm/tpm-dev.h        |    2 +-
 2 files changed, 19 insertions(+), 23 deletions(-)

diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
index 230b99288024..e4a04b2d3c32 100644
--- a/drivers/char/tpm/tpm-dev-common.c
+++ b/drivers/char/tpm/tpm-dev-common.c
@@ -37,7 +37,7 @@ static void timeout_work(struct work_struct *work)
 	struct file_priv *priv = container_of(work, struct file_priv, work);
 
 	mutex_lock(&priv->buffer_mutex);
-	atomic_set(&priv->data_pending, 0);
+	priv->data_pending = 0;
 	memset(priv->data_buffer, 0, sizeof(priv->data_buffer));
 	mutex_unlock(&priv->buffer_mutex);
 }
@@ -46,7 +46,6 @@ void tpm_common_open(struct file *file, struct tpm_chip *chip,
 		     struct file_priv *priv)
 {
 	priv->chip = chip;
-	atomic_set(&priv->data_pending, 0);
 	mutex_init(&priv->buffer_mutex);
 	timer_setup(&priv->user_read_timer, user_reader_timeout, 0);
 	INIT_WORK(&priv->work, timeout_work);
@@ -58,29 +57,24 @@ ssize_t tpm_common_read(struct file *file, char __user *buf,
 			size_t size, loff_t *off)
 {
 	struct file_priv *priv = file->private_data;
-	ssize_t ret_size;
-	ssize_t orig_ret_size;
+	ssize_t ret_size = 0;
 	int rc;
 
 	del_singleshot_timer_sync(&priv->user_read_timer);
 	flush_work(&priv->work);
-	ret_size = atomic_read(&priv->data_pending);
-	if (ret_size > 0) {	/* relay data */
-		orig_ret_size = ret_size;
-		if (size < ret_size)
-			ret_size = size;
+	mutex_lock(&priv->buffer_mutex);
 
-		mutex_lock(&priv->buffer_mutex);
+	if (priv->data_pending) {
+		ret_size = min_t(ssize_t, size, priv->data_pending);
 		rc = copy_to_user(buf, priv->data_buffer, ret_size);
-		memset(priv->data_buffer, 0, orig_ret_size);
+		memset(priv->data_buffer, 0, priv->data_pending);
 		if (rc)
 			ret_size = -EFAULT;
 
-		mutex_unlock(&priv->buffer_mutex);
+		priv->data_pending = 0;
 	}
 
-	atomic_set(&priv->data_pending, 0);
-
+	mutex_unlock(&priv->buffer_mutex);
 	return ret_size;
 }
 
@@ -91,17 +85,19 @@ ssize_t tpm_common_write(struct file *file, const char __user *buf,
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
+	if (priv->data_pending != 0) {
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
@@ -132,7 +128,7 @@ ssize_t tpm_common_write(struct file *file, const char __user *buf,
 		return out_size;
 	}
 
-	atomic_set(&priv->data_pending, out_size);
+	priv->data_pending = out_size;
 	mutex_unlock(&priv->buffer_mutex);
 
 	/* Set a timeout by which the reader must come claim the result */
@@ -149,5 +145,5 @@ void tpm_common_release(struct file *file, struct file_priv *priv)
 	del_singleshot_timer_sync(&priv->user_read_timer);
 	flush_work(&priv->work);
 	file->private_data = NULL;
-	atomic_set(&priv->data_pending, 0);
+	priv->data_pending = 0;
 }
diff --git a/drivers/char/tpm/tpm-dev.h b/drivers/char/tpm/tpm-dev.h
index ba3b6f9dacf7..b24cfb4d3ee1 100644
--- a/drivers/char/tpm/tpm-dev.h
+++ b/drivers/char/tpm/tpm-dev.h
@@ -8,7 +8,7 @@ struct file_priv {
 	struct tpm_chip *chip;
 
 	/* Data passed to and from the tpm via the read/write calls */
-	atomic_t data_pending;
+	size_t data_pending;
 	struct mutex buffer_mutex;
 
 	struct timer_list user_read_timer;      /* user needs to claim result */

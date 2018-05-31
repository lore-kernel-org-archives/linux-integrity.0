Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:53323 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750714AbeEaX3K (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 31 May 2018 19:29:10 -0400
Subject: [PATCH] tpm: add support for nonblocking operation
From: Tadeusz Struk <tadeusz.struk@intel.com>
To: jarkko.sakkinen@linux.intel.com
Cc: jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        tadeusz.struk@intel.com
Date: Thu, 31 May 2018 16:29:09 -0700
Message-ID: <152780934926.32219.7291994735609525171.stgit@tstruk-mobl1.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

The TCG SAPI specification [1] defines a set of functions, which allows
applications to use the TPM device in either blocking or non-blocking fashion.
Each command defined by the specification has a corresponding
Tss2_Sys_<COMMAND>_Prepare() and Tss2_Sys_<COMMAND>_Complete() call, which
together with Tss2_Sys_ExecuteAsync() is designed to allow asynchronous
mode of operation. Currently the driver supports only blocking calls, which
doesn't allow asynchronous operation. This patch changes it and adds support
for nonblocking write and a new poll function to enable applications using
the API as designed by the spec.
The new functionality can be tested using standard TPM tools implemented
in [2], with modified TCTI from [3].

[1] https://trustedcomputinggroup.org/wp-content/uploads/TSS_SAPI_Version-1.1_Revision-22_review_030918.pdf
[2] https://github.com/tpm2-software/tpm2-tools
[3] https://github.com/tstruk/tpm2-tss/tree/async

Signed-off-by: Tadeusz Struk <tadeusz.struk@intel.com>
---
 drivers/char/tpm/tpm-dev-common.c |  170 +++++++++++++++++++++++++++++++------
 drivers/char/tpm/tpm-dev.c        |    1 
 drivers/char/tpm/tpm-dev.h        |    9 +-
 drivers/char/tpm/tpmrm-dev.c      |    1 
 4 files changed, 149 insertions(+), 32 deletions(-)

diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
index e4a04b2d3c32..0f3378b5198a 100644
--- a/drivers/char/tpm/tpm-dev-common.c
+++ b/drivers/char/tpm/tpm-dev-common.c
@@ -17,11 +17,46 @@
  * License.
  *
  */
+#include <linux/poll.h>
+#include <linux/sched/signal.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
+#include <linux/workqueue.h>
 #include "tpm.h"
 #include "tpm-dev.h"
 
+static DECLARE_WAIT_QUEUE_HEAD(tpm_dev_wait);
+static struct workqueue_struct *tpm_dev_wq;
+
+struct tpm_dev_work {
+	struct work_struct work;
+	struct file_priv *priv;
+	struct tpm_space *space;
+	ssize_t resp_size;
+	bool nonblocking;
+};
+
+static void tpm_async_work(struct work_struct *work)
+{
+	struct tpm_dev_work *tpm_work =
+		container_of(work, struct tpm_dev_work, work);
+	struct file_priv *priv = tpm_work->priv;
+
+	tpm_work->resp_size = tpm_transmit(priv->chip, tpm_work->space,
+					   priv->data_buffer,
+					   sizeof(priv->data_buffer), 0);
+	if (!tpm_work->nonblocking) {
+		wake_up_interruptible(&tpm_dev_wait);
+		return;
+	}
+
+	tpm_put_ops(priv->chip);
+	priv->data_pending = tpm_work->resp_size;
+	mutex_unlock(&priv->buffer_mutex);
+	mod_timer(&priv->user_read_timer, jiffies + (120 * HZ));
+	kfree(tpm_work);
+}
+
 static void user_reader_timeout(struct timer_list *t)
 {
 	struct file_priv *priv = from_timer(priv, t, user_read_timer);
@@ -40,6 +75,7 @@ static void timeout_work(struct work_struct *work)
 	priv->data_pending = 0;
 	memset(priv->data_buffer, 0, sizeof(priv->data_buffer));
 	mutex_unlock(&priv->buffer_mutex);
+	wake_up_interruptible(&tpm_dev_wait);
 }
 
 void tpm_common_open(struct file *file, struct tpm_chip *chip,
@@ -66,10 +102,12 @@ ssize_t tpm_common_read(struct file *file, char __user *buf,
 
 	if (priv->data_pending) {
 		ret_size = min_t(ssize_t, size, priv->data_pending);
-		rc = copy_to_user(buf, priv->data_buffer, ret_size);
-		memset(priv->data_buffer, 0, priv->data_pending);
-		if (rc)
-			ret_size = -EFAULT;
+		if (ret_size > 0) {
+			rc = copy_to_user(buf, priv->data_buffer, ret_size);
+			memset(priv->data_buffer, 0, priv->data_pending);
+			if (rc)
+				ret_size = -EFAULT;
+		}
 
 		priv->data_pending = 0;
 	}
@@ -82,10 +120,11 @@ ssize_t tpm_common_write(struct file *file, const char __user *buf,
 			 size_t size, loff_t *off, struct tpm_space *space)
 {
 	struct file_priv *priv = file->private_data;
-	size_t in_size = size;
-	ssize_t out_size;
+	struct tpm_dev_work *work;
+	DECLARE_WAITQUEUE(wait, current);
+	int ret = 0;
 
-	if (in_size > TPM_BUFSIZE)
+	if (size > TPM_BUFSIZE)
 		return -E2BIG;
 
 	mutex_lock(&priv->buffer_mutex);
@@ -95,20 +134,19 @@ ssize_t tpm_common_write(struct file *file, const char __user *buf,
 	 * buffered writes from blocking here.
 	 */
 	if (priv->data_pending != 0) {
-		mutex_unlock(&priv->buffer_mutex);
-		return -EBUSY;
+		ret = -EBUSY;
+		goto out;
 	}
 
-	if (copy_from_user
-	    (priv->data_buffer, (void __user *) buf, in_size)) {
-		mutex_unlock(&priv->buffer_mutex);
-		return -EFAULT;
+	if (copy_from_user(priv->data_buffer, buf, size)) {
+		ret = -EFAULT;
+		goto out;
 	}
 
-	if (in_size < 6 ||
-	    in_size < be32_to_cpu(*((__be32 *) (priv->data_buffer + 2)))) {
-		mutex_unlock(&priv->buffer_mutex);
-		return -EINVAL;
+	if (size < 6 ||
+	    size < be32_to_cpu(*((__be32 *)(priv->data_buffer + 2)))) {
+		ret = -EINVAL;
+		goto out;
 	}
 
 	/* atomic tpm command send and result receive. We only hold the ops
@@ -116,25 +154,85 @@ ssize_t tpm_common_write(struct file *file, const char __user *buf,
 	 * the char dev is held open.
 	 */
 	if (tpm_try_get_ops(priv->chip)) {
-		mutex_unlock(&priv->buffer_mutex);
-		return -EPIPE;
+		ret = -EPIPE;
+		goto out;
 	}
-	out_size = tpm_transmit(priv->chip, space, priv->data_buffer,
-				sizeof(priv->data_buffer), 0);
 
+	/*
+	 * Schedule an async job to send the command
+	 */
+	work = kzalloc(sizeof(*work), GFP_KERNEL);
+	if (!work) {
+		tpm_put_ops(priv->chip);
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	work->priv = priv;
+	work->space = space;
+	work->nonblocking = file->f_flags & O_NONBLOCK;
+	INIT_WORK(&work->work, tpm_async_work);
+	queue_work(tpm_dev_wq, &work->work);
+
+	/*
+	 * If in nonblocking mode, return the size.
+	 * In case of an error the error code will be
+	 * returned in the subsequent read call.
+	 */
+	if (work->nonblocking)
+		return size;
+
+	add_wait_queue(&tpm_dev_wait, &wait);
+	current->state = TASK_INTERRUPTIBLE;
+	for (;;) {
+		if (work->resp_size)
+			break;
+
+		if (signal_pending(current)) {
+			ret = -ERESTARTSYS;
+			break;
+		}
+		schedule();
+	}
+	current->state = TASK_RUNNING;
+	remove_wait_queue(&tpm_dev_wait, &wait);
 	tpm_put_ops(priv->chip);
-	if (out_size < 0) {
-		mutex_unlock(&priv->buffer_mutex);
-		return out_size;
+
+	if (ret)
+		goto out_free;
+
+	if (work->resp_size < 0) {
+		ret = work->resp_size;
+		goto out_free;
 	}
 
-	priv->data_pending = out_size;
+	priv->data_pending = work->resp_size;
+	kfree(work);
 	mutex_unlock(&priv->buffer_mutex);
-
-	/* Set a timeout by which the reader must come claim the result */
+	wake_up_interruptible(&tpm_dev_wait);
 	mod_timer(&priv->user_read_timer, jiffies + (120 * HZ));
+	return size;
+
+out_free:
+	kfree(work);
+out:
+	mutex_unlock(&priv->buffer_mutex);
+	return ret;
+}
+
+__poll_t tpm_common_poll(struct file *file, poll_table *wait)
+{
+	struct file_priv *priv = file->private_data;
+	__poll_t mask = 0;
+
+	poll_wait(file, &tpm_dev_wait, wait);
+
+	if (priv->data_pending)
+		mask = EPOLLIN | EPOLLRDNORM;
+	else
+		mask = EPOLLOUT | EPOLLWRNORM;
 
-	return in_size;
+	return mask;
 }
 
 /*
@@ -147,3 +245,19 @@ void tpm_common_release(struct file *file, struct file_priv *priv)
 	file->private_data = NULL;
 	priv->data_pending = 0;
 }
+
+static int __init tpm_dev_common_init(void)
+{
+	tpm_dev_wq = alloc_workqueue("tpm_dev_wq", WQ_MEM_RECLAIM, 0);
+
+	return !tpm_dev_wq ? -ENOMEM : 0;
+}
+
+late_initcall(tpm_dev_common_init);
+
+static void __exit tpm_dev_common_exit(void)
+{
+	destroy_workqueue(tpm_dev_wq);
+}
+
+__exitcall(tpm_dev_common_exit);
diff --git a/drivers/char/tpm/tpm-dev.c b/drivers/char/tpm/tpm-dev.c
index ebd74ab5abef..dc0fdfdf24c4 100644
--- a/drivers/char/tpm/tpm-dev.c
+++ b/drivers/char/tpm/tpm-dev.c
@@ -74,5 +74,6 @@ const struct file_operations tpm_fops = {
 	.open = tpm_open,
 	.read = tpm_common_read,
 	.write = tpm_write,
+	.poll = tpm_common_poll,
 	.release = tpm_release,
 };
diff --git a/drivers/char/tpm/tpm-dev.h b/drivers/char/tpm/tpm-dev.h
index b24cfb4d3ee1..61a3ee0024e4 100644
--- a/drivers/char/tpm/tpm-dev.h
+++ b/drivers/char/tpm/tpm-dev.h
@@ -2,13 +2,13 @@
 #ifndef _TPM_DEV_H
 #define _TPM_DEV_H
 
+#include <linux/poll.h>
 #include "tpm.h"
 
 struct file_priv {
 	struct tpm_chip *chip;
-
-	/* Data passed to and from the tpm via the read/write calls */
-	size_t data_pending;
+	/* Holds the amount of data passed or an error code from async op */
+	ssize_t data_pending;
 	struct mutex buffer_mutex;
 
 	struct timer_list user_read_timer;      /* user needs to claim result */
@@ -23,6 +23,7 @@ ssize_t tpm_common_read(struct file *file, char __user *buf,
 			size_t size, loff_t *off);
 ssize_t tpm_common_write(struct file *file, const char __user *buf,
 			 size_t size, loff_t *off, struct tpm_space *space);
-void tpm_common_release(struct file *file, struct file_priv *priv);
+__poll_t tpm_common_poll(struct file *file, poll_table *wait);
 
+void tpm_common_release(struct file *file, struct file_priv *priv);
 #endif
diff --git a/drivers/char/tpm/tpmrm-dev.c b/drivers/char/tpm/tpmrm-dev.c
index 1a0e97a5da5a..bbfd384b67b2 100644
--- a/drivers/char/tpm/tpmrm-dev.c
+++ b/drivers/char/tpm/tpmrm-dev.c
@@ -60,6 +60,7 @@ const struct file_operations tpmrm_fops = {
 	.open = tpmrm_open,
 	.read = tpm_common_read,
 	.write = tpmrm_write,
+	.poll = tpm_common_poll,
 	.release = tpmrm_release,
 };
 

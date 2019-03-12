Return-Path: <SRS0=+0OV=RP=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 116EEC43381
	for <linux-integrity@archiver.kernel.org>; Tue, 12 Mar 2019 22:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D18A12087C
	for <linux-integrity@archiver.kernel.org>; Tue, 12 Mar 2019 22:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfCLWmB (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 12 Mar 2019 18:42:01 -0400
Received: from mga02.intel.com ([134.134.136.20]:30966 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726418AbfCLWmB (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Mar 2019 18:42:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2019 15:42:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,471,1544515200"; 
   d="scan'208";a="126406526"
Received: from tstruk-mobl1.ra.intel.com (HELO tstruk-mobl1.jf.intel.com) ([10.7.196.56])
  by orsmga006.jf.intel.com with ESMTP; 12 Mar 2019 15:42:00 -0700
Subject: Re: Kernel 5.0 regression in /dev/tpm0 access
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     =?UTF-8?Q?Mantas_Mikul=c4=97nas?= <grawity@gmail.com>,
        linux-integrity@vger.kernel.org
References: <CAPWNY8Xg=Xyfdczqkiv+DNXh41ez1BH-KjcaJG9hcp_taOc+PA@mail.gmail.com>
 <1552168908.3442.5.camel@HansenPartnership.com>
 <1552171467.3442.13.camel@HansenPartnership.com>
 <20190311130908.GA7264@linux.intel.com>
From:   Tadeusz Struk <tadeusz.struk@intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=tadeusz.struk@intel.com; prefer-encrypt=mutual; keydata=
 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
 FheFfUJaD4iEjuL98uUjS/AI
Message-ID: <14297706-74ef-f178-3b65-e63289919117@intel.com>
Date:   Tue, 12 Mar 2019 15:42:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190311130908.GA7264@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Jarkko,
On 3/11/19 6:09 AM, Jarkko Sakkinen wrote:
> Tadeusz, why on earth the code does not lock buffer_mutex?? Just noticed
> when I checked the function in question. It is an awful bug alone.

Because the tpm_common_poll() just reads the flags and doesn't modify
them, so the logic was that if the response_length is not 0 or
response_read is flase then the first poll should return EPOLLIN
and if not, the application should call the poll again and only call read
if the EPOLLIN is set in the mask. It looks like the tpm_timeout_work()
kicks in and messes things out.
Looking at it again I think the response_read flag is redundant
and only the response_length should be used.

>
> Maybe I'm missing something but that is the root cause for this mess
> i.e. race condition with tpm_common_write().
>
> I'm sorry for not noticing that during the review process  So
> obviously wrong...

Mantas, could you please give this below a quick try and see if it helps.
I have tested this quickly, but couldn't reproduce the original problem.
If it will help I will send a proper patch.
Thanks,

--- 8< ---
diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
index 5eecad233ea1..496b965c865f 100644
--- a/drivers/char/tpm/tpm-dev-common.c
+++ b/drivers/char/tpm/tpm-dev-common.c
@@ -63,7 +63,6 @@ static void tpm_timeout_work(struct work_struct *work)
 					      timeout_work);
 
 	mutex_lock(&priv->buffer_mutex);
-	priv->response_read = true;
 	priv->response_length = 0;
 	memset(priv->data_buffer, 0, sizeof(priv->data_buffer));
 	mutex_unlock(&priv->buffer_mutex);
@@ -75,7 +74,6 @@ void tpm_common_open(struct file *file, struct tpm_chip *chip,
 {
 	priv->chip = chip;
 	priv->space = space;
-	priv->response_read = true;
 
 	mutex_init(&priv->buffer_mutex);
 	timer_setup(&priv->user_read_timer, user_reader_timeout, 0);
@@ -95,8 +93,6 @@ ssize_t tpm_common_read(struct file *file, char __user *buf,
 	mutex_lock(&priv->buffer_mutex);
 
 	if (priv->response_length) {
-		priv->response_read = true;
-
 		ret_size = min_t(ssize_t, size, priv->response_length);
 		if (!ret_size) {
 			priv->response_length = 0;
@@ -140,8 +136,7 @@ ssize_t tpm_common_write(struct file *file, const char __user *buf,
 	 * tpm_read or a user_read_timer timeout. This also prevents split
 	 * buffered writes from blocking here.
 	 */
-	if ((!priv->response_read && priv->response_length) ||
-	    priv->command_enqueued) {
+	if (priv->response_length || priv->command_enqueued) {
 		ret = -EBUSY;
 		goto out;
 	}
@@ -167,7 +162,6 @@ ssize_t tpm_common_write(struct file *file, const char __user *buf,
 	}
 
 	priv->response_length = 0;
-	priv->response_read = false;
 	*off = 0;
 
 	/*
@@ -202,13 +196,15 @@ __poll_t tpm_common_poll(struct file *file, poll_table *wait)
 	struct file_priv *priv = file->private_data;
 	__poll_t mask = 0;
 
+	mutex_lock(&priv->buffer_mutex);
 	poll_wait(file, &priv->async_wait, wait);
 
-	if (!priv->response_read || priv->response_length)
+	if (priv->response_length)
 		mask = EPOLLIN | EPOLLRDNORM;
 	else
 		mask = EPOLLOUT | EPOLLWRNORM;
 
+	mutex_unlock(&priv->buffer_mutex);
 	return mask;
 }
 
diff --git a/drivers/char/tpm/tpm-dev.h b/drivers/char/tpm/tpm-dev.h
index 1089fc0bb290..403ae3efc6e0 100644
--- a/drivers/char/tpm/tpm-dev.h
+++ b/drivers/char/tpm/tpm-dev.h
@@ -15,7 +15,6 @@ struct file_priv {
 	struct work_struct async_work;
 	wait_queue_head_t async_wait;
 	size_t response_length;
-	bool response_read;
 	bool command_enqueued;
 
 	u8 data_buffer[TPM_BUFSIZE];

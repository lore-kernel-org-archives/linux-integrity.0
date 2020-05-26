Return-Path: <SRS0=pAxC=7I=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EAA5C433E1
	for <linux-integrity@archiver.kernel.org>; Tue, 26 May 2020 19:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB969208B8
	for <linux-integrity@archiver.kernel.org>; Tue, 26 May 2020 19:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="H4T37HFK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="H4T37HFK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403979AbgEZTOS (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 26 May 2020 15:14:18 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:39442 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392156AbgEZTOR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 May 2020 15:14:17 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id D8AB78EE181;
        Tue, 26 May 2020 12:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1590520455;
        bh=1riJEDBNgSCVf7jkch7dm+3/1NkeVaflehjozpLPb3c=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=H4T37HFKxn8vwLL4D3+Az25gwQT6IArhj41gqGeEa/k1UFw37FlmFg7rUafbj95pH
         1iJPGDeiWKMFNBzedpGMKDzGwNaKSSP1f7PfLcn8t3/pwnlIolh902LzzhtVl+j+56
         PoyqPuoiBInHBAlZQ0UcHMsbWM7jQGXNYoWqjJ8c=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id czvt4mIAJ9Lv; Tue, 26 May 2020 12:14:15 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 2A9948EE0D4;
        Tue, 26 May 2020 12:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1590520455;
        bh=1riJEDBNgSCVf7jkch7dm+3/1NkeVaflehjozpLPb3c=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=H4T37HFKxn8vwLL4D3+Az25gwQT6IArhj41gqGeEa/k1UFw37FlmFg7rUafbj95pH
         1iJPGDeiWKMFNBzedpGMKDzGwNaKSSP1f7PfLcn8t3/pwnlIolh902LzzhtVl+j+56
         PoyqPuoiBInHBAlZQ0UcHMsbWM7jQGXNYoWqjJ8c=
Message-ID: <1590520454.11810.40.camel@HansenPartnership.com>
Subject: Re: [PATCH] tpm: Revert "tpm: fix invalid locking in NONBLOCKING
 mode"
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Mario Limonciello <mario.limonciello@dell.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeffrin Jose T <jeffrin@rajagiritech.edu.in>,
        Alex Guzman <alex@guzman.io>
Date:   Tue, 26 May 2020 12:14:14 -0700
In-Reply-To: <20200526183213.20720-1-mario.limonciello@dell.com>
References: <20200526183213.20720-1-mario.limonciello@dell.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-05-26 at 13:32 -0500, Mario Limonciello wrote:
> This reverts commit d23d12484307b40eea549b8a858f5fffad913897.
> 
> This commit has caused regressions for the XPS 9560 containing
> a Nuvoton TPM.

Presumably this is using the tis driver?

> As mentioned by the reporter all TPM2 commands are failing with:
>   ERROR:tcti:src/tss2-tcti/tcti-device.c:290:tcti_device_receive()
>   Failed to read response from fd 3, got errno 1: Operation not
> permitted
> 
> The reporter bisected this issue back to this commit which was
> backported to stable as commit 4d6ebc4.

I think the problem is request_locality ... for some inexplicable
reason a failure there returns -1, which is EPERM to user space.

That seems to be a bug in the async code since everything else gives a
ESPIPE error if tpm_try_get_ops fails ... at least no-one assumes it
gives back a sensible return code.

What I think is happening is that with the patch the TPM goes through a
quick sequence of request, relinquish, request, relinquish and it's the
third request which is failing (likely timing out).  Without the patch,
the patch there's only one request,relinquish cycle because the ops are
held while the async work is executed.  I have a vague recollection
that there is a problem with too many locality request in quick
succession, but I'll defer to Jason, who I think understands the
intricacies of localities better than I do.

If that's the problem, the solution looks simple enough: just move the
ops get down because the priv state is already protected by the buffer
mutex

James

---

diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
index 87f449340202..1784530b8387 100644
--- a/drivers/char/tpm/tpm-dev-common.c
+++ b/drivers/char/tpm/tpm-dev-common.c
@@ -189,15 +189,6 @@ ssize_t tpm_common_write(struct file *file, const char __user *buf,
 		goto out;
 	}
 
-	/* atomic tpm command send and result receive. We only hold the ops
-	 * lock during this period so that the tpm can be unregistered even if
-	 * the char dev is held open.
-	 */
-	if (tpm_try_get_ops(priv->chip)) {
-		ret = -EPIPE;
-		goto out;
-	}
-
 	priv->response_length = 0;
 	priv->response_read = false;
 	*off = 0;
@@ -211,11 +202,19 @@ ssize_t tpm_common_write(struct file *file, const char __user *buf,
 	if (file->f_flags & O_NONBLOCK) {
 		priv->command_enqueued = true;
 		queue_work(tpm_dev_wq, &priv->async_work);
-		tpm_put_ops(priv->chip);
 		mutex_unlock(&priv->buffer_mutex);
 		return size;
 	}
 
+	/* atomic tpm command send and result receive. We only hold the ops
+	 * lock during this period so that the tpm can be unregistered even if
+	 * the char dev is held open.
+	 */
+	if (tpm_try_get_ops(priv->chip)) {
+		ret = -EPIPE;
+		goto out;
+	}
+
 	ret = tpm_dev_transmit(priv->chip, priv->space, priv->data_buffer,
 			       sizeof(priv->data_buffer));
 	tpm_put_ops(priv->chip);

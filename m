Return-Path: <SRS0=+0OV=RP=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE9AC43381
	for <linux-integrity@archiver.kernel.org>; Tue, 12 Mar 2019 22:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A74742173C
	for <linux-integrity@archiver.kernel.org>; Tue, 12 Mar 2019 22:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="tSMnCYvh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbfCLWuy (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 12 Mar 2019 18:50:54 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:49028 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727304AbfCLWuv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Mar 2019 18:50:51 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id DEE998EE0F5;
        Tue, 12 Mar 2019 15:50:50 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Qjim-mzm6zaD; Tue, 12 Mar 2019 15:50:50 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 5D7E68EE21A;
        Tue, 12 Mar 2019 15:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1552431050;
        bh=Vsqs6yyMcHSt34wmM1v76Vp93gUqflz/67y8Tj/pEZ0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=tSMnCYvhUHG094P67GNebwMgUhyhSiF6O+B3+9rBtSuiF63zt7cXD/WxkZJd4Mec+
         KgfnbSlVy62AtuMncHTlqYEDkLnCcYpHbG/4Ni17v8hbGB03T1t0QRgHlgAPY5V27O
         j6Vraa0QWI5hmUvf8ftbM1ql5108KaDXoRu8YLcY=
Message-ID: <1552431049.14432.42.camel@HansenPartnership.com>
Subject: Re: Kernel 5.0 regression in /dev/tpm0 access
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Tadeusz Struk <tadeusz.struk@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Mantas =?UTF-8?Q?Mikul=C4=97nas?= <grawity@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Tue, 12 Mar 2019 15:50:49 -0700
In-Reply-To: <14297706-74ef-f178-3b65-e63289919117@intel.com>
References: <CAPWNY8Xg=Xyfdczqkiv+DNXh41ez1BH-KjcaJG9hcp_taOc+PA@mail.gmail.com>
         <1552168908.3442.5.camel@HansenPartnership.com>
         <1552171467.3442.13.camel@HansenPartnership.com>
         <20190311130908.GA7264@linux.intel.com>
         <14297706-74ef-f178-3b65-e63289919117@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2019-03-12 at 15:42 -0700, Tadeusz Struk wrote:
> @@ -202,13 +196,15 @@ __poll_t tpm_common_poll(struct file *file,
> poll_table *wait)
>  	struct file_priv *priv = file->private_data;
>  	__poll_t mask = 0;
>  
> +	mutex_lock(&priv->buffer_mutex);
>  	poll_wait(file, &priv->async_wait, wait);
>  
> -	if (!priv->response_read || priv->response_length)
> +	if (priv->response_length)
>  		mask = EPOLLIN | EPOLLRDNORM;
>  	else
>  		mask = EPOLLOUT | EPOLLWRNORM;
>  
> +	mutex_unlock(&priv->buffer_mutex);

Isn't this setting us up for a deadlock?  If the work queued by write
hasn't run by the time you call poll, you take the buffer mutex and
sleep.  Now if the work runs, it blocks acquiring the mutex in
tpm_async_work and never calls wakeup on async_wait.

James


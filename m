Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-lf0-f41.google.com ([209.85.215.41]:56348 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751027AbdJZJDd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 26 Oct 2017 05:03:33 -0400
Received: by mail-lf0-f41.google.com with SMTP id 90so2879777lfs.13
        for <linux-integrity@vger.kernel.org>; Thu, 26 Oct 2017 02:03:32 -0700 (PDT)
Date: Thu, 26 Oct 2017 12:03:30 +0300
From: Mikhail Kurinnoi <viewizard@viewizard.com>
To: Matthew Garrett <mjg59@google.com>
Cc: linux-integrity@vger.kernel.org, zohar@linux.vnet.ibm.com,
        Dmitry Kasatkin <dmitry.kasatkin@huawei.com>
Subject: Re: [RFC] EVM: Add support for portable signature format
Message-ID: <20171026120330.5360e427@totoro>
In-Reply-To: <20171026083144.16247-1-mjg59@google.com>
References: <20171026083144.16247-1-mjg59@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

? Thu, 26 Oct 2017 01:31:44 -0700
Matthew Garrett <mjg59@google.com> ?????:

> @@ -317,7 +319,7 @@ void ima_update_xattr(struct integrity_iint_cache
> *iint, struct file *file) int rc = 0;
>  
>  	/* do not collect and update hash for digital signatures */
> -	if (iint->flags & IMA_DIGSIG)
> +	if (iint->flags & IMA_DIGSIG || iint->flags &
> EVM_IMMUTABLE_DIGSIG) return;
>  

Isn't this mean, we already changed files data, and we just don't allow
IMA xattr update? This file will not pass integrity verification
next time.

I thought, the idea was prevent data changes, and in this way prevent
IMA xattr update.


-- 
Best regards,
Mikhail Kurinnoi

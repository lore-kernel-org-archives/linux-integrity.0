Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52208 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752202AbeA1UQF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 28 Jan 2018 15:16:05 -0500
Received: by mail-wm0-f68.google.com with SMTP id r71so10393484wmd.1
        for <linux-integrity@vger.kernel.org>; Sun, 28 Jan 2018 12:16:05 -0800 (PST)
Date: Sun, 28 Jan 2018 13:15:59 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tomas Winkler <tomas.winkler@intel.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2 v2] tpm: cmd_ready command can be issued only after
 granting locality
Message-ID: <20180128201559.GG23869@ziepe.ca>
References: <20180128075101.6883-1-tomas.winkler@intel.com>
 <20180128075101.6883-2-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180128075101.6883-2-tomas.winkler@intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Sun, Jan 28, 2018 at 09:51:00AM +0200, Tomas Winkler wrote:

> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index bcdd3790e94d..06639fb6ab85 100644
> +++ b/include/linux/tpm.h
> @@ -44,7 +44,7 @@ struct tpm_class_ops {
>  	bool (*update_timeouts)(struct tpm_chip *chip,
>  				unsigned long *timeout_cap);
>  	int (*request_locality)(struct tpm_chip *chip, int loc);
> -	void (*relinquish_locality)(struct tpm_chip *chip, int loc);
> +	int (*relinquish_locality)(struct tpm_chip *chip, int loc);

This seems wrong.. What is the core code supposed to do if relinquish
fails?

Just returning an error code from transmit doesn't really do anything
helpful from a broad subsytem perspective.

I think if a driver can fail reliquish then it needs some kind of
strategy to recover.

Suggest trying the reliquish again on every next request until
success, otherwise fail request locality, potentially permanently.

Jason

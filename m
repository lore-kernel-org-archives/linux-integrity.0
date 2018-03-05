Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:46857 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752063AbeCEVMM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 5 Mar 2018 16:12:12 -0500
Received: by mail-wr0-f195.google.com with SMTP id m12so18747878wrm.13
        for <linux-integrity@vger.kernel.org>; Mon, 05 Mar 2018 13:12:11 -0800 (PST)
Date: Mon, 5 Mar 2018 14:12:06 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tomas Winkler <tomas.winkler@intel.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] tpm: sort objects in the Makefile
Message-ID: <20180305211206.GB9335@ziepe.ca>
References: <20180305202017.24008-1-tomas.winkler@intel.com>
 <20180305202017.24008-2-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180305202017.24008-2-tomas.winkler@intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, Mar 05, 2018 at 10:20:12PM +0200, Tomas Winkler wrote:
> Make the tpm Makefile a bit more in order by putting
> objects in one column and group together tpm2 modules
> 
> Prefer tpm-objs += instead of tpm-y += notation.
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
>  drivers/char/tpm/Makefile | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
> index acd758381c58..2fc0e9a73cd6 100644
> +++ b/drivers/char/tpm/Makefile
> @@ -3,9 +3,17 @@
>  # Makefile for the kernel tpm device drivers.
>  #
>  obj-$(CONFIG_TCG_TPM) += tpm.o
> -tpm-y := tpm-interface.o tpm-dev.o tpm-sysfs.o tpm-chip.o tpm2-cmd.o \
> -	 tpm-dev-common.o tpmrm-dev.o tpm1_eventlog.o tpm2_eventlog.o \
> -         tpm2-space.o
> +tpm-objs := tpm-interface.o
> +tpm-objs += tpm-dev.o
> +tpm-objs += tpm-chip.o
> +tpm-objs += tpm-dev-common.o
> +tpm-objs += tpmrm-dev.o
> +tpm-objs += tpm-sysfs.o
> +tpm-objs += tpm1_eventlog.o
> +tpm-objs += tpm2-cmd.o
> +tpm-objs += tpm2-space.o
> +tpm-objs += tpm2_eventlog.o

If you are going to do this then sort the list please

Seems weird to me though, there are not that many examples of this
pattern in the kernel.

What is wrong with:

tpm-objs := \
	 tpm-interface.o \
	 tpm-dev.o \
	 [..]

?
 
Jason

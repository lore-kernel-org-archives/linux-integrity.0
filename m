Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:46807 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752901AbdLVCtI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 21 Dec 2017 21:49:08 -0500
Received: by mail-it0-f68.google.com with SMTP id t1so12791724ite.5
        for <linux-integrity@vger.kernel.org>; Thu, 21 Dec 2017 18:49:08 -0800 (PST)
Date: Thu, 21 Dec 2017 19:49:06 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Azhar Shaikh <azhar.shaikh@intel.com>
Cc: jarkko.sakkinen@linux.intel.com, javierm@redhat.com,
        peterhuewe@gmx.de, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tpm: Fix the driver cleanup code
Message-ID: <20171222024906.GB23946@ziepe.ca>
References: <1513898019-164487-1-git-send-email-azhar.shaikh@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1513898019-164487-1-git-send-email-azhar.shaikh@intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, Dec 21, 2017 at 03:13:39PM -0800, Azhar Shaikh wrote:
> Commit 3c1701339284353c41 ("tpm: Keep CLKRUN enabled throughout
> the duration of transmit_cmd()") added code which accessed
> chip->ops, even after it was set to NULL in tpm_del_char_device(),
> called from tpm_chip_unregister() in error / driver exit paths.
> So fix this code.
> 
> Fixes: 3c1701339284353c41 ("tpm: Keep CLKRUN enabled throughout
> the duration of transmit_cmd()")
> 
> Suggested-by: Javier Martinez Canillas <javierm@redhat.com>
> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
> Signed-off-by: Azhar Shaikh <azhar.shaikh@intel.com>
> Changes in v2:
> - Remove TPM_CHIP_FLAG_DO_NOT_CLEAR_OPS flag, instead call
>   tpm_tis_clkrun_enable() directly in tpm_tis_remove()
> - Add comment to tpm_tis_clkrun_enable()

Looks Ok to me

Reviewed-by: Jason Gunthorpe <jgg@ziepe.ca>

Jason

Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:42305 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750794AbdKCO2p (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Nov 2017 10:28:45 -0400
Date: Fri, 3 Nov 2017 16:28:41 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm: Update MAINTAINERS for Jason Gunthorpe
Message-ID: <20171103142841.2nphkjojzamrdezm@linux.intel.com>
References: <20171031202357.GA1030@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171031202357.GA1030@ziepe.ca>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, Oct 31, 2017 at 02:23:57PM -0600, Jason Gunthorpe wrote:
> My email address for open source work is moving to this new permanent
> personal address.
> 
> Signed-off-by: Jason Gunthorpe <jgunthorpe@ziepe.ca>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6671f375f7fcdd..b79eb071475ffc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13588,7 +13588,7 @@ TPM DEVICE DRIVER
>  M:	Peter Huewe <peterhuewe@gmx.de>
>  M:	Marcel Selhorst <tpmdd@selhorst.net>
>  M:	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> -R:	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> +R:	Jason Gunthorpe <jgg@ziepe.ca>
>  W:	http://tpmdd.sourceforge.net
>  L:	tpmdd-devel@lists.sourceforge.net (moderated for non-subscribers)
>  Q:	https://patchwork.kernel.org/project/tpmdd-devel/list/
> -- 
> 2.7.4
> 

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Should these updates go to my tree? I posted previous update to
linux-kernel@vger.kernel.org.

/Jarkko

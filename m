Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:52625 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751699AbdJDMOu (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 Oct 2017 08:14:50 -0400
Date: Wed, 4 Oct 2017 15:14:49 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: =?iso-8859-1?B?Suly6W15?= Lefaure <jeremy.lefaure@lse.epita.fr>
Cc: Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/18] tpm: use ARRAY_SIZE
Message-ID: <20171004121449.kywykfgyxtkmu2ar@linux.intel.com>
References: <20171001193101.8898-1-jeremy.lefaure@lse.epita.fr>
 <20171001193101.8898-14-jeremy.lefaure@lse.epita.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20171001193101.8898-14-jeremy.lefaure@lse.epita.fr>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Sun, Oct 01, 2017 at 03:30:51PM -0400, Jeremy Lefaure wrote:
> Using the ARRAY_SIZE macro improves the readability of the code.
> 
> Found with Coccinelle with the following semantic patch:
> @r depends on (org || report)@
> type T;
> T[] E;
> position p;
> @@
> (
>  (sizeof(E)@p /sizeof(*E))
> |
>  (sizeof(E)@p /sizeof(E[...]))
> |
>  (sizeof(E)@p /sizeof(T))
> )
> 
> Signed-off-by: Jeremy Lefaure <jeremy.lefaure@lse.epita.fr>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko

> ---
>  drivers/char/tpm/tpm_tis.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
> index ebd0e75a3e4d..e2d1055fb814 100644
> --- a/drivers/char/tpm/tpm_tis.c
> +++ b/drivers/char/tpm/tpm_tis.c
> @@ -30,6 +30,7 @@
>  #include <linux/freezer.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> +#include <linux/kernel.h>
>  #include "tpm.h"
>  #include "tpm_tis_core.h"
>  
> @@ -365,7 +366,7 @@ static struct pnp_driver tis_pnp_driver = {
>  	},
>  };
>  
> -#define TIS_HID_USR_IDX sizeof(tpm_pnp_tbl)/sizeof(struct pnp_device_id) -2
> +#define TIS_HID_USR_IDX (ARRAY_SIZE(tpm_pnp_tbl) - 2)
>  module_param_string(hid, tpm_pnp_tbl[TIS_HID_USR_IDX].id,
>  		    sizeof(tpm_pnp_tbl[TIS_HID_USR_IDX].id), 0444);
>  MODULE_PARM_DESC(hid, "Set additional specific HID for this driver to probe");
> -- 
> 2.14.1
> 

Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38219 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbeINBb0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Sep 2018 21:31:26 -0400
Received: by mail-pl1-f196.google.com with SMTP id u11-v6so3105216plq.5
        for <linux-integrity@vger.kernel.org>; Thu, 13 Sep 2018 13:20:23 -0700 (PDT)
Date: Thu, 13 Sep 2018 14:20:21 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, jgross@suse.com, dunlapg@umich.edu,
        "Dr. Greg Wettstein" <greg@wind.enjellic.com>,
        "Dr . Greg Wettstein" <greg@enjellic.com>, stable@vger.kernel.org
Subject: Re: [PATCH RESEND] tpm: Restore functionality to xen vtpm driver.
Message-ID: <20180913202021.GD31953@ziepe.ca>
References: <20180913194749.32178-1-boris.ostrovsky@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180913194749.32178-1-boris.ostrovsky@oracle.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, Sep 13, 2018 at 03:47:49PM -0400, Boris Ostrovsky wrote:
> From: "Dr. Greg Wettstein" <greg@wind.enjellic.com>
> 
> Functionality of the xen-tpmfront driver was lost secondary to
> the introduction of xenbus multi-page support in commit ccc9d90a9a8b
> ("xenbus_client: Extend interface to support multi-page ring").

This should be in a Fixes: line..

> In this commit a pointer to the shared page address was being
> passed to the xenbus_grant_ring() function rather then the
> address of the shared page itself.  This resulted in a situation
> where the driver would attach to the vtpm-stubdom but any attempt
> to send a command to the stub domain would timeout.
> 
> A diagnostic finding for this regression is the following error
> message being generated when the xen-tpmfront driver probes for a
> device:
> 
> <3>vtpm vtpm-0: tpm_transmit: tpm_send: error -62
> 
> <3>vtpm vtpm-0: A TPM error (-62) occurred attempting to determine
> the timeouts
> 
> This fix is relevant to all kernels from 4.1 forward which is the
> release in which multi-page xenbus support was introduced.
> 
> Daniel De Graaf formulated the fix by code inspection after the
> regression point was located.
> 
> Signed-off-by: Dr. Greg Wettstein <greg@enjellic.com>
> 
> [boris: fixed commit message formatting]
> Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: stable@vger.kernel.org # v4.1+
> We've lost this patch a couple of years ago, re-submitting.
> 
> 
>  drivers/char/tpm/xen-tpmfront.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/xen-tpmfront.c b/drivers/char/tpm/xen-tpmfront.c
> index 911475d36800..b150f87f38f5 100644
> +++ b/drivers/char/tpm/xen-tpmfront.c
> @@ -264,7 +264,7 @@ static int setup_ring(struct xenbus_device *dev, struct tpm_private *priv)
>  		return -ENOMEM;
>  	}
>  
> -	rv = xenbus_grant_ring(dev, &priv->shr, 1, &gref);
> +	rv = xenbus_grant_ring(dev, priv->shr, 1, &gref);
>  	if (rv < 0)
>  		return rv;
>  

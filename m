Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:36158 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751863AbdLSM73 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 19 Dec 2017 07:59:29 -0500
Date: Tue, 19 Dec 2017 14:59:23 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, James Ettle <james@ettle.org.uk>,
        linux-integrity@vger.kernel.org, azhar.shaikh@intel.com,
        linux-kernel@vger.kernel.org, james.l.morris@oracle.com
Subject: Re: [BISECTED] tpm CLKRUN breaks PS/2 keyboard and touchpad on
 Braswell system
Message-ID: <20171219125923.b46fwqfmeaimsonx@linux.intel.com>
References: <57d96314-cc9c-0656-186e-4eb77a132b70@ettle.org.uk>
 <34b361bf-cce7-a1ac-f8a3-76ef22f5b6b0@redhat.com>
 <5fb5de24-5a4c-4c01-1f72-49fc5844516c@ettle.org.uk>
 <011b4d29-9d93-4b7a-90dd-0c25cf184c3e@redhat.com>
 <20171214191052.GA20833@ziepe.ca>
 <20171215145630.ftsnj4azqqhzqwsh@linux.intel.com>
 <20171215173826.GD12434@ziepe.ca>
 <1513443676.29063.0.camel@linux.intel.com>
 <d3984354-56d4-747a-1266-bf28c657daae@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d3984354-56d4-747a-1266-bf28c657daae@redhat.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

James, Javier, thank you for sorting this out. I'll just have couple of
minor comments on the patch.

On Mon, Dec 18, 2017 at 01:22:28PM +0100, Javier Martinez Canillas wrote:
> +	u32 vendor, intfcaps, intmask, clkrun_val;

Could these split into four lines (one declaration per line)?

>  	u8 rid;
>  	int rc, probe;
>  	struct tpm_chip *chip;
> @@ -772,6 +772,15 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>  					ILB_REMAP_SIZE);
>  		if (!priv->ilb_base_addr)
>  			return -ENOMEM;
> +
> +		clkrun_val = ioread32(priv->ilb_base_addr + LPC_CNTRL_OFFSET);
> +		/* Check if CLKRUN# is already not enabled in the LPC bus */

/* 

> +		if (!(clkrun_val & LPC_CLKRUN_EN)) {
> +			priv->flags |= TPM_TIS_CLK_ENABLE;

Is the flag added just so surpress those WARN()'s?

I've forgot why the WARN()'s even exist assuming that driver is
functioning correctly.

/Jarkko

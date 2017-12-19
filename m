Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32942 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751973AbdLSNK2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 19 Dec 2017 08:10:28 -0500
Received: by mail-wm0-f67.google.com with SMTP id g130so11386418wme.0
        for <linux-integrity@vger.kernel.org>; Tue, 19 Dec 2017 05:10:28 -0800 (PST)
Subject: Re: [BISECTED] tpm CLKRUN breaks PS/2 keyboard and touchpad on
 Braswell system
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, James Ettle <james@ettle.org.uk>,
        linux-integrity@vger.kernel.org, azhar.shaikh@intel.com,
        linux-kernel@vger.kernel.org, james.l.morris@oracle.com
References: <57d96314-cc9c-0656-186e-4eb77a132b70@ettle.org.uk>
 <34b361bf-cce7-a1ac-f8a3-76ef22f5b6b0@redhat.com>
 <5fb5de24-5a4c-4c01-1f72-49fc5844516c@ettle.org.uk>
 <011b4d29-9d93-4b7a-90dd-0c25cf184c3e@redhat.com>
 <20171214191052.GA20833@ziepe.ca>
 <20171215145630.ftsnj4azqqhzqwsh@linux.intel.com>
 <20171215173826.GD12434@ziepe.ca> <1513443676.29063.0.camel@linux.intel.com>
 <d3984354-56d4-747a-1266-bf28c657daae@redhat.com>
 <20171219125923.b46fwqfmeaimsonx@linux.intel.com>
From: Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <4e7f8b67-9818-b0be-ac69-2fac7a6539b2@redhat.com>
Date: Tue, 19 Dec 2017 14:10:25 +0100
MIME-Version: 1.0
In-Reply-To: <20171219125923.b46fwqfmeaimsonx@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hello Jarkko,

On 12/19/2017 01:59 PM, Jarkko Sakkinen wrote:
> James, Javier, thank you for sorting this out. I'll just have couple of
> minor comments on the patch.
> 
> On Mon, Dec 18, 2017 at 01:22:28PM +0100, Javier Martinez Canillas wrote:
>> +	u32 vendor, intfcaps, intmask, clkrun_val;
> 
> Could these split into four lines (one declaration per line)?
>

Yes, I didn't like that either but did this way for consistency with the driver.

>>  	u8 rid;
>>  	int rc, probe;
>>  	struct tpm_chip *chip;
>> @@ -772,6 +772,15 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>>  					ILB_REMAP_SIZE);
>>  		if (!priv->ilb_base_addr)
>>  			return -ENOMEM;
>> +
>> +		clkrun_val = ioread32(priv->ilb_base_addr + LPC_CNTRL_OFFSET);
>> +		/* Check if CLKRUN# is already not enabled in the LPC bus */
> 
> /* 
> 
>> +		if (!(clkrun_val & LPC_CLKRUN_EN)) {
>> +			priv->flags |= TPM_TIS_CLK_ENABLE;
> 
> Is the flag added just so surpress those WARN()'s?
>

I believe so. I just included here again for consistency, but I think the flag
and the warns can just go away.

> I've forgot why the WARN()'s even exist assuming that driver is
> functioning correctly.
> 
> /Jarkko
>

If you agree with the patch, I can post it as a formal patch on a series that
do these cleanups as preparatory work. I've also noticed a NULL pointer deref
bug in an error path so I'll also fix that too.

Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat

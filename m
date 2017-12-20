Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:45502 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755773AbdLTSVg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Dec 2017 13:21:36 -0500
Received: by mail-wm0-f65.google.com with SMTP id 9so11601714wme.4
        for <linux-integrity@vger.kernel.org>; Wed, 20 Dec 2017 10:21:35 -0800 (PST)
Subject: Re: [PATCH 1/4] tpm: fix access attempt to an already unmapped I/O
 memory region
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-kernel@vger.kernel.org, James Ettle <james@ettle.org.uk>,
        Hans de Goede <hdegoede@redhat.com>,
        Azhar Shaikh <azhar.shaikh@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org
References: <20171220113538.16099-1-javierm@redhat.com>
 <20171220113538.16099-2-javierm@redhat.com> <20171220180855.GB22908@ziepe.ca>
From: Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <f9da193f-e1b4-c126-d272-b98bafda3b99@redhat.com>
Date: Wed, 20 Dec 2017 19:21:31 +0100
MIME-Version: 1.0
In-Reply-To: <20171220180855.GB22908@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 12/20/2017 07:08 PM, Jason Gunthorpe wrote:
> On Wed, Dec 20, 2017 at 12:35:35PM +0100, Javier Martinez Canillas wrote:
>> The driver maps the I/O memory address to control the LPC bus CLKRUN_EN,
>> but on the error path the memory is accessed by the .clk_enable handler
>> after this was already unmapped. So only unmap the I/O memory region if
>> it will not be used anymore.
>>
>> Also, the correct thing to do is to cleanup the resources in the inverse
>> order that were acquired to prevent issues like these.
>>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>>
>>  drivers/char/tpm/tpm_tis_core.c | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
>> index c2227983ed88..3455abbb2035 100644
>> +++ b/drivers/char/tpm/tpm_tis_core.c
> 
> Yoiks. This patch is helping but the more I look at this the wronger
> everything looks..
>
> 1) tpm_chip_unregister makes chip->ops == NULL, so this sequence:
> 
> static int tpm_tis_plat_remove(struct platform_device *pdev)
> 	tpm_chip_unregister(chip);
> 	tpm_tis_remove(chip);
> void tpm_tis_remove(struct tpm_chip *chip)
> 	if (chip->ops->clk_enable != NULL)
> 
> Will oops
>
> 2) tpm_chip_register can also NULL ops in error cases, so this
>    sequence can oops:
> 
>        rc = tpm_chip_register(chip);
>        if (rc && is_bsw())
>                iounmap(priv->ilb_base_addr);
> 
>         if (chip->ops->clk_enable != NULL)
>                 chip->ops->clk_enable(chip, false);
> 
> 3) iounmap should not be split between tpm_tis and tpm_tis_core
>    Put it at the end of tpm_tis_remove.
> 
> 4) This sequence:
> 
> +       return tpm_chip_register(chip);
> +out_err:
> +       tpm_tis_remove(chip);
> +       return rc;
> 
>    Doesn't look right. If tpm_chip_register fails then
>    tpm_tis_remove will never be called. This was sort of OK when
>    tpm_tis_remove didn't manage any resources, but now that it does
>    the above needs fixing too.
>

Right, I only noticed the issue this patch fixes and (wrongly) assumed the
rest was correct.

> The below draft fixes everything except #1. That needs a more thoughtful
> idea..
>

I'll just drop this patch from the series and you can fix all the issues in
the error / driver removal paths. It's not a dependency anyways, I included
it just because noticed the issue while reading the code.

Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat

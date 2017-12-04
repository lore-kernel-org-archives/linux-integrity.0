Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:43305 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752600AbdLDSDg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 4 Dec 2017 13:03:36 -0500
Received: by mail-wr0-f193.google.com with SMTP id z34so18300809wrz.10
        for <linux-integrity@vger.kernel.org>; Mon, 04 Dec 2017 10:03:35 -0800 (PST)
Date: Mon, 4 Dec 2017 11:03:24 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: Re: [PATCH] tpm: remove type and name fields from the I2C Infineon
 OF table entries
Message-ID: <20171204180324.GB18059@ziepe.ca>
References: <20171204173916.4874-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171204173916.4874-1-javierm@redhat.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, Dec 04, 2017 at 06:39:16PM +0100, Javier Martinez Canillas wrote:
> The commit 21dc02eab989 ("tpm/tpm_i2c_infineon.c: Add OF attributes type
> and name to the of_device_id table entries") added type and name fields
> to the OF device ID table entries for the I2C Infineon TPM driver.
> 
> The only justification for the change in the commit message is that it's
> probably a good idea to have these fields populated in the OF entries.
> 
> But I don't think that's true. In fact, I believe that's not correct to
> add these fields for the following reasons:
> 
>  * The struct of_device_id .type field matches the device_type property
>    in the Device Tree nodes. The ePAPR document says that new use of the
>    property is deprecated and should only be included in cpu and memory
>    nodes for compatibility with the IEEE 1275-derived Device Trees.
>    Also, mainline Device Tree source files don't include this property
>    in the TPM nodes defined.
> 
>  * The struct of_device_id .name field matches the Device Tree node name
>    but the ePAPR document says that the node name should be generic and
>    reflect the function of the device, not it's programming model. So in
>    the case of TPM chips, it should just be "tpm" but the name fields are
>    set in the OF table entries to the actual device model (i.e: slb9645tt).
> 
> Now, from a practical point of view this means that the OF module aliases
> for the supported devices include the name and type of the device entries:
> 
> $ modinfo drivers/char/tpm/tpm_i2c_infineon.ko | grep alias
> alias:          of:Nslb9645ttTtpm*Cinfineon,slb9645ttC*
> alias:          of:Nslb9645ttTtpm*Cinfineon,slb9645tt
> alias:          of:Nslb9635ttTtpm*Cinfineon,slb9635ttC*
> alias:          of:Nslb9635ttTtpm*Cinfineon,slb9635tt
> alias:          of:Ntpm_i2c_infineonTtpm*Cinfineon,tpm_i2c_infineonC*
> alias:          of:Ntpm_i2c_infineonTtpm*Cinfineon,tpm_i2c_infineon
> 
> But since the device_type isn't set in the tpm DT nodes and the node name
> is a generic one, the reported MODALIAS when a device is registered via OF
> won't match the driver's module aliases:
> 
> $ cat /sys/class/tpm/tpm0/device/modalias
> of:NtpmT<NULL>Cinfineon,slb9645tt
> 
> So remove these fields from the OF entries to allow the module aliases to
> match the MODALIAS reported by the kernel when the device is registered:
> 
> $ modinfo drivers/char/tpm/tpm_i2c_infineon.ko | grep alias
> alias:          of:N*T*Cinfineon,slb9645ttC*
> alias:          of:N*T*Cinfineon,slb9645tt
> alias:          of:N*T*Cinfineon,slb9635ttC*
> alias:          of:N*T*Cinfineon,slb9635tt
> alias:          of:N*T*Cinfineon,tpm_i2c_infineonC*
> alias:          of:N*T*Cinfineon,tpm_i2c_infineon
> 
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

I concur

Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

Jason

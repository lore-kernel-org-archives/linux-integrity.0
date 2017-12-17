Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:47636 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751350AbdLQQ2B (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 17 Dec 2017 11:28:01 -0500
Date: Sun, 17 Dec 2017 18:27:57 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH] tpm: remove type and name fields from the I2C Infineon
 OF table entries
Message-ID: <20171217162757.sndccozrmeci5o4c@linux.intel.com>
References: <20171204173916.4874-1-javierm@redhat.com>
 <20171215120303.v3jh6g43lgktaykp@linux.intel.com>
 <f42f69dc-0c0b-64bc-fe4c-7ce7a9bb9a4e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f42f69dc-0c0b-64bc-fe4c-7ce7a9bb9a4e@redhat.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Sat, Dec 16, 2017 at 08:59:06PM +0100, Javier Martinez Canillas wrote:
> On 12/15/2017 01:03 PM, Jarkko Sakkinen wrote:
> > Hi
> > 
> > Some basic questions about DT, which I'm not expert of.
> > 
> > On Mon, Dec 04, 2017 at 06:39:16PM +0100, Javier Martinez Canillas wrote:
> >> The commit 21dc02eab989 ("tpm/tpm_i2c_infineon.c: Add OF attributes type
> >> and name to the of_device_id table entries") added type and name fields
> >> to the OF device ID table entries for the I2C Infineon TPM driver.
> >>
> >> The only justification for the change in the commit message is that it's
> >> probably a good idea to have these fields populated in the OF entries.
> >>
> >> But I don't think that's true. In fact, I believe that's not correct to
> >> add these fields for the following reasons:
> >>
> >>  * The struct of_device_id .type field matches the device_type property
> >>    in the Device Tree nodes. The ePAPR document says that new use of the
> >>    property is deprecated and should only be included in cpu and memory
> >>    nodes for compatibility with the IEEE 1275-derived Device Trees.
> >>    Also, mainline Device Tree source files don't include this property
> >>    in the TPM nodes defined.
> >>
> >>  * The struct of_device_id .name field matches the Device Tree node name
> >>    but the ePAPR document says that the node name should be generic and
> >>    reflect the function of the device, not it's programming model. So in
> >>    the case of TPM chips, it should just be "tpm" but the name fields are
> >>    set in the OF table entries to the actual device model (i.e: slb9645tt).
> > 
> > So why the name field is not changed to "tpm"?
> >
> 
> We could, but why would do that? Drivers usually don't care about the node name
> used by the DTS and most DT bindings are not strict about that. There are some
> exceptions (e.g: regulators bindings) but in most cases is up to the developer
> to define whatever node name is suitable for that DT node.
> 
> In fact, this driver is the first one I have ever seen that sets a .name field.
> What most drivers only use to match is the compatible string.
> 
> Also, it seems that "tpm" is not the only used node name for TPM device nodes.
> At least "tpm_tis" and "vtpm" are used by looking at mainline DTS and bindings
> documents. And who knows if an out-of-tree DTB uses "tpm2" for example?
> 
> Finally, the other two drivers for I2C TPM devices (atmel and nuvoton) don't
> set a .name, so if we change in this driver we probably would need to change
> in those too for consistency. And have a proper DT binding doc so users know
> that using "tpm" as node name is a requirement.
> 
> >> Now, from a practical point of view this means that the OF module aliases
> >> for the supported devices include the name and type of the device entries:
> >>
> >> $ modinfo drivers/char/tpm/tpm_i2c_infineon.ko | grep alias
> >> alias:          of:Nslb9645ttTtpm*Cinfineon,slb9645ttC*
> >> alias:          of:Nslb9645ttTtpm*Cinfineon,slb9645tt
> >> alias:          of:Nslb9635ttTtpm*Cinfineon,slb9635ttC*
> >> alias:          of:Nslb9635ttTtpm*Cinfineon,slb9635tt
> >> alias:          of:Ntpm_i2c_infineonTtpm*Cinfineon,tpm_i2c_infineonC*
> >> alias:          of:Ntpm_i2c_infineonTtpm*Cinfineon,tpm_i2c_infineon
> >>
> >> But since the device_type isn't set in the tpm DT nodes and the node name
> >> is a generic one, the reported MODALIAS when a device is registered via OF
> >> won't match the driver's module aliases:
> >>
> >> $ cat /sys/class/tpm/tpm0/device/modalias
> >> of:NtpmT<NULL>Cinfineon,slb9645tt
> >>
> >> So remove these fields from the OF entries to allow the module aliases to
> >> match the MODALIAS reported by the kernel when the device is registered:
> >>
> >> $ modinfo drivers/char/tpm/tpm_i2c_infineon.ko | grep alias
> >> alias:          of:N*T*Cinfineon,slb9645ttC*
> >> alias:          of:N*T*Cinfineon,slb9645tt
> >> alias:          of:N*T*Cinfineon,slb9635ttC*
> >> alias:          of:N*T*Cinfineon,slb9635tt
> >> alias:          of:N*T*Cinfineon,tpm_i2c_infineonC*
> >> alias:          of:N*T*Cinfineon,tpm_i2c_infineon
> >>
> >> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> >> ---
> >>
> >>  drivers/char/tpm/tpm_i2c_infineon.c | 21 +++------------------
> >>  1 file changed, 3 insertions(+), 18 deletions(-)
> >>
> >> diff --git a/drivers/char/tpm/tpm_i2c_infineon.c b/drivers/char/tpm/tpm_i2c_infineon.c
> >> index 79d6bbb58e39..005c38879b2e 100644
> >> --- a/drivers/char/tpm/tpm_i2c_infineon.c
> >> +++ b/drivers/char/tpm/tpm_i2c_infineon.c
> >> @@ -675,24 +675,9 @@ MODULE_DEVICE_TABLE(i2c, tpm_tis_i2c_table);
> >>  
> >>  #ifdef CONFIG_OF
> >>  static const struct of_device_id tpm_tis_i2c_of_match[] = {
> >> -	{
> >> -		.name = "tpm_i2c_infineon",
> >> -		.type = "tpm",
> >> -		.compatible = "infineon,tpm_i2c_infineon",
> >> -		.data = (void *)0
> >> -	},
> >> -	{
> >> -		.name = "slb9635tt",
> >> -		.type = "tpm",
> >> -		.compatible = "infineon,slb9635tt",
> >> -		.data = (void *)0
> >> -	},
> >> -	{
> >> -		.name = "slb9645tt",
> >> -		.type = "tpm",
> >> -		.compatible = "infineon,slb9645tt",
> >> -		.data = (void *)1
> >> -	},
> >> +	{ .compatible = "infineon,tpm_i2c_infineon", .data = (void *)0 },
> >> +	{ .compatible = "infineon,slb9635tt", .data = (void *)0 },
> >> +	{ .compatible = "infineon,slb9645tt", .data = (void *)1 },
> >>  	{},
> >>  };
> >>  MODULE_DEVICE_TABLE(of, tpm_tis_i2c_of_match);
> >> -- 
> >> 2.14.3
> >>
> > 
> > What does the "data" field mean?
> >
> 
> The field is used to store data that's associated with an entry in the OF table.
> It's used by drivers to have per device configuration data to avoid the need to
> have different drivers for similar devices.
> 
> Although it seems that's not used by this particular driver, so they might be
> removed on a follow-up patch. Hard to say that the 0 and 1 magic numbers mean.
> 
> As an example, the tpm_i2c_nuvoton driver store in the .data field whether a
> TPM device is a 2.0 or 1.2:
> 
> static const struct of_device_id i2c_nuvoton_of_match[] = {
> 	{.compatible = "nuvoton,npct501"},
> 	{.compatible = "winbond,wpct301"},
> 	{.compatible = "nuvoton,npct601", .data = OF_IS_TPM2},
> 	{},
> };
> 
> static int i2c_nuvoton_probe(struct i2c_client *client,
> 			     const struct i2c_device_id *id)
> {
> ...
> 	if (dev->of_node) {
> 		const struct of_device_id *of_id;
> 
> 		of_id = of_match_device(dev->driver->of_match_table, dev);
> 		if (of_id && of_id->data == OF_IS_TPM2)
> 			chip->flags |= TPM_CHIP_FLAG_TPM2;
> 	} else
> 		if (id->driver_data == I2C_IS_TPM2)
> 			chip->flags |= TPM_CHIP_FLAG_TPM2;
> ...
> }
> 
> > /Jarkko
> > 
> 
> Best regards,
> -- 
> Javier Martinez Canillas
> Software Engineer - Desktop Hardware Enablement
> Red Hat

Thank you for the lessons :-)

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko

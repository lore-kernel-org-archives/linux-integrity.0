Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35856 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751349AbdLDRjW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 4 Dec 2017 12:39:22 -0500
Received: by mail-wr0-f193.google.com with SMTP id v105so18185759wrc.3
        for <linux-integrity@vger.kernel.org>; Mon, 04 Dec 2017 09:39:21 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javierm@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH] tpm: remove type and name fields from the I2C Infineon OF table entries
Date: Mon,  4 Dec 2017 18:39:16 +0100
Message-Id: <20171204173916.4874-1-javierm@redhat.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

The commit 21dc02eab989 ("tpm/tpm_i2c_infineon.c: Add OF attributes type
and name to the of_device_id table entries") added type and name fields
to the OF device ID table entries for the I2C Infineon TPM driver.

The only justification for the change in the commit message is that it's
probably a good idea to have these fields populated in the OF entries.

But I don't think that's true. In fact, I believe that's not correct to
add these fields for the following reasons:

 * The struct of_device_id .type field matches the device_type property
   in the Device Tree nodes. The ePAPR document says that new use of the
   property is deprecated and should only be included in cpu and memory
   nodes for compatibility with the IEEE 1275-derived Device Trees.
   Also, mainline Device Tree source files don't include this property
   in the TPM nodes defined.

 * The struct of_device_id .name field matches the Device Tree node name
   but the ePAPR document says that the node name should be generic and
   reflect the function of the device, not it's programming model. So in
   the case of TPM chips, it should just be "tpm" but the name fields are
   set in the OF table entries to the actual device model (i.e: slb9645tt).

Now, from a practical point of view this means that the OF module aliases
for the supported devices include the name and type of the device entries:

$ modinfo drivers/char/tpm/tpm_i2c_infineon.ko | grep alias
alias:          of:Nslb9645ttTtpm*Cinfineon,slb9645ttC*
alias:          of:Nslb9645ttTtpm*Cinfineon,slb9645tt
alias:          of:Nslb9635ttTtpm*Cinfineon,slb9635ttC*
alias:          of:Nslb9635ttTtpm*Cinfineon,slb9635tt
alias:          of:Ntpm_i2c_infineonTtpm*Cinfineon,tpm_i2c_infineonC*
alias:          of:Ntpm_i2c_infineonTtpm*Cinfineon,tpm_i2c_infineon

But since the device_type isn't set in the tpm DT nodes and the node name
is a generic one, the reported MODALIAS when a device is registered via OF
won't match the driver's module aliases:

$ cat /sys/class/tpm/tpm0/device/modalias
of:NtpmT<NULL>Cinfineon,slb9645tt

So remove these fields from the OF entries to allow the module aliases to
match the MODALIAS reported by the kernel when the device is registered:

$ modinfo drivers/char/tpm/tpm_i2c_infineon.ko | grep alias
alias:          of:N*T*Cinfineon,slb9645ttC*
alias:          of:N*T*Cinfineon,slb9645tt
alias:          of:N*T*Cinfineon,slb9635ttC*
alias:          of:N*T*Cinfineon,slb9635tt
alias:          of:N*T*Cinfineon,tpm_i2c_infineonC*
alias:          of:N*T*Cinfineon,tpm_i2c_infineon

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/char/tpm/tpm_i2c_infineon.c | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/drivers/char/tpm/tpm_i2c_infineon.c b/drivers/char/tpm/tpm_i2c_infineon.c
index 79d6bbb58e39..005c38879b2e 100644
--- a/drivers/char/tpm/tpm_i2c_infineon.c
+++ b/drivers/char/tpm/tpm_i2c_infineon.c
@@ -675,24 +675,9 @@ MODULE_DEVICE_TABLE(i2c, tpm_tis_i2c_table);
 
 #ifdef CONFIG_OF
 static const struct of_device_id tpm_tis_i2c_of_match[] = {
-	{
-		.name = "tpm_i2c_infineon",
-		.type = "tpm",
-		.compatible = "infineon,tpm_i2c_infineon",
-		.data = (void *)0
-	},
-	{
-		.name = "slb9635tt",
-		.type = "tpm",
-		.compatible = "infineon,slb9635tt",
-		.data = (void *)0
-	},
-	{
-		.name = "slb9645tt",
-		.type = "tpm",
-		.compatible = "infineon,slb9645tt",
-		.data = (void *)1
-	},
+	{ .compatible = "infineon,tpm_i2c_infineon", .data = (void *)0 },
+	{ .compatible = "infineon,slb9635tt", .data = (void *)0 },
+	{ .compatible = "infineon,slb9645tt", .data = (void *)1 },
 	{},
 };
 MODULE_DEVICE_TABLE(of, tpm_tis_i2c_of_match);
-- 
2.14.3

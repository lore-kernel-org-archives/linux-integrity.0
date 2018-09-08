Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from userp2130.oracle.com ([156.151.31.86]:37820 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbeIHRwP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 8 Sep 2018 13:52:15 -0400
Date: Sat, 8 Sep 2018 16:06:22 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: azhar.shaikh@intel.com
Cc: linux-integrity@vger.kernel.org
Subject: [bug report] tpm: Keep CLKRUN enabled throughout the duration of
 transmit_cmd()
Message-ID: <20180908130622.o4xl7dwlu7f6amqi@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hello Azhar Shaikh,

This is a semi-automatic email about new static checker warnings.

The patch b3e958ce4c58: "tpm: Keep CLKRUN enabled throughout the 
duration of transmit_cmd()" from Dec 22, 2017, leads to the following 
Smatch complaint:

    drivers/char/tpm/tpm_tis_core.c:1004 tpm_tis_core_init()
     warn: variable dereferenced before check 'chip->ops' (see line 902)

drivers/char/tpm/tpm_tis_core.c
   901	
   902		if (chip->ops->clk_enable != NULL)
                    ^^^^^^^^^^^
The patch adds a new unchecked dereference.

   903			chip->ops->clk_enable(chip, true);
   904	
   905		if (wait_startup(chip, 0) != 0) {
   906			rc = -ENODEV;
   907			goto out_err;
   908		}
   909	
   910		/* Take control of the TPM's interrupt hardware and shut it off */
   911		rc = tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask);
   912		if (rc < 0)
   913			goto out_err;
   914	
   915		intmask |= TPM_INTF_CMD_READY_INT | TPM_INTF_LOCALITY_CHANGE_INT |
   916			   TPM_INTF_DATA_AVAIL_INT | TPM_INTF_STS_VALID_INT;
   917		intmask &= ~TPM_GLOBAL_INT_ENABLE;
   918		tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), intmask);
   919	
   920		rc = tpm2_probe(chip);
   921		if (rc)
   922			goto out_err;
   923	
   924		rc = tpm_tis_read32(priv, TPM_DID_VID(0), &vendor);
   925		if (rc < 0)
   926			goto out_err;
   927	
   928		priv->manufacturer_id = vendor;
   929	
   930		rc = tpm_tis_read8(priv, TPM_RID(0), &rid);
   931		if (rc < 0)
   932			goto out_err;
   933	
   934		dev_info(dev, "%s TPM (device-id 0x%X, rev-id %d)\n",
   935			 (chip->flags & TPM_CHIP_FLAG_TPM2) ? "2.0" : "1.2",
   936			 vendor >> 16, rid);
   937	
   938		probe = probe_itpm(chip);
   939		if (probe < 0) {
   940			rc = -ENODEV;
   941			goto out_err;
   942		}
   943	
   944		/* Figure out the capabilities */
   945		rc = tpm_tis_read32(priv, TPM_INTF_CAPS(priv->locality), &intfcaps);
   946		if (rc < 0)
   947			goto out_err;
   948	
   949		dev_dbg(dev, "TPM interface capabilities (0x%x):\n",
   950			intfcaps);
   951		if (intfcaps & TPM_INTF_BURST_COUNT_STATIC)
   952			dev_dbg(dev, "\tBurst Count Static\n");
   953		if (intfcaps & TPM_INTF_CMD_READY_INT)
   954			dev_dbg(dev, "\tCommand Ready Int Support\n");
   955		if (intfcaps & TPM_INTF_INT_EDGE_FALLING)
   956			dev_dbg(dev, "\tInterrupt Edge Falling\n");
   957		if (intfcaps & TPM_INTF_INT_EDGE_RISING)
   958			dev_dbg(dev, "\tInterrupt Edge Rising\n");
   959		if (intfcaps & TPM_INTF_INT_LEVEL_LOW)
   960			dev_dbg(dev, "\tInterrupt Level Low\n");
   961		if (intfcaps & TPM_INTF_INT_LEVEL_HIGH)
   962			dev_dbg(dev, "\tInterrupt Level High\n");
   963		if (intfcaps & TPM_INTF_LOCALITY_CHANGE_INT)
   964			dev_dbg(dev, "\tLocality Change Int Support\n");
   965		if (intfcaps & TPM_INTF_STS_VALID_INT)
   966			dev_dbg(dev, "\tSts Valid Int Support\n");
   967		if (intfcaps & TPM_INTF_DATA_AVAIL_INT)
   968			dev_dbg(dev, "\tData Avail Int Support\n");
   969	
   970		/* INTERRUPT Setup */
   971		init_waitqueue_head(&priv->read_queue);
   972		init_waitqueue_head(&priv->int_queue);
   973		if (irq != -1) {
   974			/* Before doing irq testing issue a command to the TPM in polling mode
   975			 * to make sure it works. May as well use that command to set the
   976			 * proper timeouts for the driver.
   977			 */
   978			if (tpm_get_timeouts(chip)) {
   979				dev_err(dev, "Could not get TPM timeouts and durations\n");
   980				rc = -ENODEV;
   981				goto out_err;
   982			}
   983	
   984			if (irq) {
   985				tpm_tis_probe_irq_single(chip, intmask, IRQF_SHARED,
   986							 irq);
   987				if (!(chip->flags & TPM_CHIP_FLAG_IRQ))
   988					dev_err(&chip->dev, FW_BUG
   989						"TPM interrupt not working, polling instead\n");
   990			} else {
   991				tpm_tis_probe_irq(chip, intmask);
   992			}
   993		}
   994	
   995		rc = tpm_chip_register(chip);
   996		if (rc)
   997			goto out_err;
   998	
   999		if (chip->ops->clk_enable != NULL)
  1000			chip->ops->clk_enable(chip, false);
  1001	
  1002		return 0;
  1003	out_err:
  1004		if ((chip->ops != NULL) && (chip->ops->clk_enable != NULL))
                     ^^^^^^^^^
And a new check.  Presumably the check can be removed.

  1005			chip->ops->clk_enable(chip, false);
  1006	

regards,
dan carpenter

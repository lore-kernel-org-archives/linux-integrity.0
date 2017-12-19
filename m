Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:10419 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751488AbdLSVI6 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 19 Dec 2017 16:08:58 -0500
Date: Wed, 20 Dec 2017 05:08:23 +0800
From: kbuild test robot <lkp@intel.com>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: kbuild-all@01.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        James Ettle <james@ettle.org.uk>,
        linux-integrity@vger.kernel.org, azhar.shaikh@intel.com,
        linux-kernel@vger.kernel.org, james.l.morris@oracle.com
Subject: Re: [PATCH 1/1] tpm: only attempt to disable the LPC CLKRUN if is
 already
Message-ID: <201712200557.hwFgwPwf%fengguang.wu@intel.com>
References: <d3984354-56d4-747a-1266-bf28c657daae@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="LQksG6bCIzRHxTLp"
In-Reply-To: <d3984354-56d4-747a-1266-bf28c657daae@redhat.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi Javier,

I love your patch! Yet something to improve:

[auto build test ERROR on next-20171214]
[cannot apply to char-misc/char-misc-testing v4.15-rc3 v4.15-rc2 v4.15-rc1 v4.15-rc4]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Javier-Martinez-Canillas/tpm-only-attempt-to-disable-the-LPC-CLKRUN-if-is-already/20171220-041605
config: x86_64-randconfig-x007-201751 (attached as .config)
compiler: gcc-7 (Debian 7.2.0-12) 7.2.1 20171025
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers/char/tpm/tpm_tis_core.c: In function 'tpm_tis_core_init':
>> drivers/char/tpm/tpm_tis_core.c:836:26: error: assignment of member 'clk_enable' in read-only object
       chip->ops->clk_enable = NULL;
                             ^

vim +/clk_enable +836 drivers/char/tpm/tpm_tis_core.c

   815	
   816		/* Maximum timeouts */
   817		chip->timeout_a = msecs_to_jiffies(TIS_TIMEOUT_A_MAX);
   818		chip->timeout_b = msecs_to_jiffies(TIS_TIMEOUT_B_MAX);
   819		chip->timeout_c = msecs_to_jiffies(TIS_TIMEOUT_C_MAX);
   820		chip->timeout_d = msecs_to_jiffies(TIS_TIMEOUT_D_MAX);
   821		priv->phy_ops = phy_ops;
   822		dev_set_drvdata(&chip->dev, priv);
   823	
   824		if (is_bsw()) {
   825			priv->ilb_base_addr = ioremap(INTEL_LEGACY_BLK_BASE_ADDR,
   826						ILB_REMAP_SIZE);
   827			if (!priv->ilb_base_addr)
   828				return -ENOMEM;
   829	
   830			clkrun_val = ioread32(priv->ilb_base_addr + LPC_CNTRL_OFFSET);
   831			/* Check if CLKRUN# is already not enabled in the LPC bus */
   832			if (!(clkrun_val & LPC_CLKRUN_EN)) {
   833				priv->flags |= TPM_TIS_CLK_ENABLE;
   834				iounmap(priv->ilb_base_addr);
   835				priv->ilb_base_addr = NULL;
 > 836				chip->ops->clk_enable = NULL;
   837			}
   838		}
   839	
   840		if (chip->ops->clk_enable != NULL)
   841			chip->ops->clk_enable(chip, true);
   842	
   843		if (wait_startup(chip, 0) != 0) {
   844			rc = -ENODEV;
   845			goto out_err;
   846		}
   847	
   848		/* Take control of the TPM's interrupt hardware and shut it off */
   849		rc = tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask);
   850		if (rc < 0)
   851			goto out_err;
   852	
   853		intmask |= TPM_INTF_CMD_READY_INT | TPM_INTF_LOCALITY_CHANGE_INT |
   854			   TPM_INTF_DATA_AVAIL_INT | TPM_INTF_STS_VALID_INT;
   855		intmask &= ~TPM_GLOBAL_INT_ENABLE;
   856		tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), intmask);
   857	
   858		rc = tpm2_probe(chip);
   859		if (rc)
   860			goto out_err;
   861	
   862		rc = tpm_tis_read32(priv, TPM_DID_VID(0), &vendor);
   863		if (rc < 0)
   864			goto out_err;
   865	
   866		priv->manufacturer_id = vendor;
   867	
   868		rc = tpm_tis_read8(priv, TPM_RID(0), &rid);
   869		if (rc < 0)
   870			goto out_err;
   871	
   872		dev_info(dev, "%s TPM (device-id 0x%X, rev-id %d)\n",
   873			 (chip->flags & TPM_CHIP_FLAG_TPM2) ? "2.0" : "1.2",
   874			 vendor >> 16, rid);
   875	
   876		probe = probe_itpm(chip);
   877		if (probe < 0) {
   878			rc = -ENODEV;
   879			goto out_err;
   880		}
   881	
   882		/* Figure out the capabilities */
   883		rc = tpm_tis_read32(priv, TPM_INTF_CAPS(priv->locality), &intfcaps);
   884		if (rc < 0)
   885			goto out_err;
   886	
   887		dev_dbg(dev, "TPM interface capabilities (0x%x):\n",
   888			intfcaps);
   889		if (intfcaps & TPM_INTF_BURST_COUNT_STATIC)
   890			dev_dbg(dev, "\tBurst Count Static\n");
   891		if (intfcaps & TPM_INTF_CMD_READY_INT)
   892			dev_dbg(dev, "\tCommand Ready Int Support\n");
   893		if (intfcaps & TPM_INTF_INT_EDGE_FALLING)
   894			dev_dbg(dev, "\tInterrupt Edge Falling\n");
   895		if (intfcaps & TPM_INTF_INT_EDGE_RISING)
   896			dev_dbg(dev, "\tInterrupt Edge Rising\n");
   897		if (intfcaps & TPM_INTF_INT_LEVEL_LOW)
   898			dev_dbg(dev, "\tInterrupt Level Low\n");
   899		if (intfcaps & TPM_INTF_INT_LEVEL_HIGH)
   900			dev_dbg(dev, "\tInterrupt Level High\n");
   901		if (intfcaps & TPM_INTF_LOCALITY_CHANGE_INT)
   902			dev_dbg(dev, "\tLocality Change Int Support\n");
   903		if (intfcaps & TPM_INTF_STS_VALID_INT)
   904			dev_dbg(dev, "\tSts Valid Int Support\n");
   905		if (intfcaps & TPM_INTF_DATA_AVAIL_INT)
   906			dev_dbg(dev, "\tData Avail Int Support\n");
   907	
   908		/* INTERRUPT Setup */
   909		init_waitqueue_head(&priv->read_queue);
   910		init_waitqueue_head(&priv->int_queue);
   911		if (irq != -1) {
   912			/* Before doing irq testing issue a command to the TPM in polling mode
   913			 * to make sure it works. May as well use that command to set the
   914			 * proper timeouts for the driver.
   915			 */
   916			if (tpm_get_timeouts(chip)) {
   917				dev_err(dev, "Could not get TPM timeouts and durations\n");
   918				rc = -ENODEV;
   919				goto out_err;
   920			}
   921	
   922			if (irq) {
   923				tpm_tis_probe_irq_single(chip, intmask, IRQF_SHARED,
   924							 irq);
   925				if (!(chip->flags & TPM_CHIP_FLAG_IRQ))
   926					dev_err(&chip->dev, FW_BUG
   927						"TPM interrupt not working, polling instead\n");
   928			} else {
   929				tpm_tis_probe_irq(chip, intmask);
   930			}
   931		}
   932	
   933		rc = tpm_chip_register(chip);
   934		if (rc && is_bsw() && priv->ilb_base_addr)
   935			iounmap(priv->ilb_base_addr);
   936	
   937		if (chip->ops->clk_enable != NULL)
   938			chip->ops->clk_enable(chip, false);
   939	
   940		return rc;
   941	out_err:
   942		tpm_tis_remove(chip);
   943		if (is_bsw())
   944			iounmap(priv->ilb_base_addr);
   945	
   946		if (chip->ops->clk_enable != NULL)
   947			chip->ops->clk_enable(chip, false);
   948	
   949		return rc;
   950	}
   951	EXPORT_SYMBOL_GPL(tpm_tis_core_init);
   952	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation


    [ Part 2, Application/GZIP 30 KB. ]
    [ Unable to print this part. ]

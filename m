Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45426 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755735AbdLON1K (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 15 Dec 2017 08:27:10 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vBFDOUZ3107415
        for <linux-integrity@vger.kernel.org>; Fri, 15 Dec 2017 08:27:10 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2evcfr1shp-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 15 Dec 2017 08:27:09 -0500
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Fri, 15 Dec 2017 13:27:07 -0000
Subject: Re: Aw: Re:  Re:  Re:  tpm_tis_spi gets initialized long after IMA
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Peter Huewe <PeterHuewe@gmx.de>, pau <pau@linux.vnet.ibm.com>
Cc: Nayna Jain <nayna@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Date: Fri, 15 Dec 2017 08:26:56 -0500
In-Reply-To: <trinity-3e6c2430-417d-4eef-b067-e30d68592b4d-1506716047790@3c-app-gmx-bs69>
References: <trinity-d76a5983-fa13-4ac4-8e48-d94d22a80e86-1506633490200@3c-app-gmx-bs75>
         <trinity-e306a773-6b97-4508-8894-89da4b67f01f-1506634575541@3c-app-gmx-bs75>
         <1506647389.5691.76.camel@linux.vnet.ibm.com>
         <trinity-868e9e34-679a-4aff-97a3-9edf65a2fcda-1506673263842@3c-app-gmx-bs15>
         <1506685208.5691.109.camel@linux.vnet.ibm.com>
         <trinity-14f61785-1f5f-4f45-9b7e-5cd197936a6d-1506710663754@3c-app-gmx-bs57>
         <44c1e36d3113badfe4b76fcdafbb6df7@linux.vnet.ibm.com>
         <trinity-3e6c2430-417d-4eef-b067-e30d68592b4d-1506716047790@3c-app-gmx-bs69>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1513344416.6488.30.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi Peter,

On Fri, 2017-09-29 at 22:14 +0200, Peter Huewe wrote:
> Hi pau,
> 
> thanks for your answer,
> SPI is enabled in DT and compiled in
> TPM is enabled in DT via overlay and compiled in.
> I have a working /dev/tpm0
> 
> However, the problem lays elsewhere - I added some debug prints to figure out what is going on:
> It looks like this
> 
> 
> [    0.027898] RPIFirmware: Calling rpi_firmware_get
> [    0.027929] bcm2835-clk 3f101000.cprman: Probing FW
> [    0.027949] bcm2835-clk 3f101000.cprman: FW not ready, defering probe                                                                                     
> [    0.028385] bcm2835-mbox 3f00b880.mailbox: mailbox enabled
> [    0.028847] uart-pl011 3f201000.serial: could not find pctldev for node /soc/gpio@7e200000/uart0_pins, deferring probe
> [    0.061353] bcm2835-dma 3f007000.dma: DMA legacy API manager at bb80f000, dmachans=0x1
> [    0.062828] SCSI subsystem initialized
> [    0.062950] usbcore: registered new interface driver usbfs
> [    0.063001] usbcore: registered new interface driver hub
> [    0.063084] usbcore: registered new device driver usb
> [    0.063362] raspberrypi-firmware soc:firmware: Calling rpi_firmware_probe
> 
> So the bcm2835-clk calls rpi_firmware_get, which returns with NULL since the pdev has not been set yet,
> as the rpi_firmware_probe gets called only later :/
> 
> That defers the probing of the bcm2835-clk, so it it not available for the bcm2835-spi which also gets defered, consequently making the tpm not available until ima is done :/

Sorry for the long delay!  At the end of last year we were able to
boot the pi with IMA using the TPM.

On the rpi-4.8.y kernel with tip commit 061dccc ("BCM270X_DT: Add pi3-
disable-wifi overlay"), I had to disable the full TPM selftest in
order for the TPM to be initialized prior to IMA.

-       rc = tpm2_start_selftest(chip, true);
+       rc = tpm2_start_selftest(chip, false);

I now have it working on the rpi-4.9.y kernel with tip commit e80a8a5
("Merge remote-tracking branch 'stable/linux-4.9.y' into rpi-4.9.y")
as well.  In addition to disabling the full selftest, I had to revert
commit b76c8d5 ("clk-bcm2835: Read max core clock from firmware") in
order for the TPM to initialize prior to IMA.

Mimi

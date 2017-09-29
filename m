Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.19]:59383 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752534AbdI2UOL (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 29 Sep 2017 16:14:11 -0400
MIME-Version: 1.0
Message-ID: <trinity-3e6c2430-417d-4eef-b067-e30d68592b4d-1506716047790@3c-app-gmx-bs69>
From: "Peter Huewe" <PeterHuewe@gmx.de>
To: pau <pau@linux.vnet.ibm.com>
Cc: "Mimi Zohar" <zohar@linux.vnet.ibm.com>,
        "Nayna Jain" <nayna@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Subject: Aw: Re:  Re:  Re:  tpm_tis_spi gets initialized long after IMA
Content-Type: text/plain; charset=UTF-8
Date: Fri, 29 Sep 2017 22:14:07 +0200
In-Reply-To: <44c1e36d3113badfe4b76fcdafbb6df7@linux.vnet.ibm.com>
References: <trinity-d76a5983-fa13-4ac4-8e48-d94d22a80e86-1506633490200@3c-app-gmx-bs75>
 <trinity-e306a773-6b97-4508-8894-89da4b67f01f-1506634575541@3c-app-gmx-bs75>
 <1506647389.5691.76.camel@linux.vnet.ibm.com>
 <trinity-868e9e34-679a-4aff-97a3-9edf65a2fcda-1506673263842@3c-app-gmx-bs15>
 <1506685208.5691.109.camel@linux.vnet.ibm.com>
 <trinity-14f61785-1f5f-4f45-9b7e-5cd197936a6d-1506710663754@3c-app-gmx-bs57>
 <44c1e36d3113badfe4b76fcdafbb6df7@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi pau,
 
thanks for your answer,
SPI is enabled in DT and compiled in
TPM is enabled in DT via overlay and compiled in.
I have a working /dev/tpm0
 
However, the problem lays elsewhere - I added some debug prints to figure out what is going on:
It looks like this
 
 
[    0.027898] RPIFirmware: Calling rpi_firmware_get
[    0.027929] bcm2835-clk 3f101000.cprman: Probing FW
[    0.027949] bcm2835-clk 3f101000.cprman: FW not ready, defering probe                                                                                     
[    0.028385] bcm2835-mbox 3f00b880.mailbox: mailbox enabled
[    0.028847] uart-pl011 3f201000.serial: could not find pctldev for node /soc/gpio@7e200000/uart0_pins, deferring probe
[    0.061353] bcm2835-dma 3f007000.dma: DMA legacy API manager at bb80f000, dmachans=0x1
[    0.062828] SCSI subsystem initialized
[    0.062950] usbcore: registered new interface driver usbfs
[    0.063001] usbcore: registered new interface driver hub
[    0.063084] usbcore: registered new device driver usb
[    0.063362] raspberrypi-firmware soc:firmware: Calling rpi_firmware_probe
 
So the bcm2835-clk calls rpi_firmware_get, which returns with NULL since the pdev has not been set yet,
as the rpi_firmware_probe gets called only later :/
 
That defers the probing of the bcm2835-clk, so it it not available for the bcm2835-spi which also gets defered, consequently making the tpm not available until ima is done :/
 
Peter

 

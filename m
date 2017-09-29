Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.20]:49810 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752351AbdI2So1 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 29 Sep 2017 14:44:27 -0400
MIME-Version: 1.0
Message-ID: <trinity-14f61785-1f5f-4f45-9b7e-5cd197936a6d-1506710663754@3c-app-gmx-bs57>
From: "Peter Huewe" <PeterHuewe@gmx.de>
To: "Mimi Zohar" <zohar@linux.vnet.ibm.com>
Cc: "Nayna Jain" <nayna@linux.vnet.ibm.com>, pau@linux.vnet.ibm.com,
        linux-integrity@vger.kernel.org
Subject: Aw: Re:  Re:  tpm_tis_spi gets initialized long after IMA
Content-Type: text/plain; charset=UTF-8
Date: Fri, 29 Sep 2017 20:44:23 +0200
In-Reply-To: <1506685208.5691.109.camel@linux.vnet.ibm.com>
References: <trinity-d76a5983-fa13-4ac4-8e48-d94d22a80e86-1506633490200@3c-app-gmx-bs75>
 <trinity-e306a773-6b97-4508-8894-89da4b67f01f-1506634575541@3c-app-gmx-bs75>
 <1506647389.5691.76.camel@linux.vnet.ibm.com>
 <trinity-868e9e34-679a-4aff-97a3-9edf65a2fcda-1506673263842@3c-app-gmx-bs15>
 <1506685208.5691.109.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi Mimi, Hi Nayna,


> The patch replaces the call to builtin_platform_driver(), with a call
> to core_initcall().

> https://github.com/raspberrypi/linux/blob/rpi-4.8.y/drivers/clk/bcm/cl
> k-bcm2835.c

> static int __init __bcm2835_clk_driver_init(void)
> {
> return platform_driver_register(&bcm2835_clk_driver);
> }
> core_initcall(__bcm2835_clk_driver_init);

Ah it is already in the rpi sources - however I *am* using these, but it does not work?
Any ideas or pointers highly appreciated.

Peter

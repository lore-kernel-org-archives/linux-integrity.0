Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41534 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752572AbdI2Tpn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 29 Sep 2017 15:45:43 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v8TJhw7a159853
        for <linux-integrity@vger.kernel.org>; Fri, 29 Sep 2017 15:45:42 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2d9rpdupw7-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 29 Sep 2017 15:45:42 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <pau@linux.vnet.ibm.com>;
        Fri, 29 Sep 2017 15:45:41 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Fri, 29 Sep 2017 15:49:44 -0400
From: pau <pau@linux.vnet.ibm.com>
To: Peter Huewe <PeterHuewe@gmx.de>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Subject: Re: Aw: Re:  Re:  tpm_tis_spi gets initialized long after IMA
In-Reply-To: <trinity-14f61785-1f5f-4f45-9b7e-5cd197936a6d-1506710663754@3c-app-gmx-bs57>
References: <trinity-d76a5983-fa13-4ac4-8e48-d94d22a80e86-1506633490200@3c-app-gmx-bs75>
 <trinity-e306a773-6b97-4508-8894-89da4b67f01f-1506634575541@3c-app-gmx-bs75>
 <1506647389.5691.76.camel@linux.vnet.ibm.com>
 <trinity-868e9e34-679a-4aff-97a3-9edf65a2fcda-1506673263842@3c-app-gmx-bs15>
 <1506685208.5691.109.camel@linux.vnet.ibm.com>
 <trinity-14f61785-1f5f-4f45-9b7e-5cd197936a6d-1506710663754@3c-app-gmx-bs57>
Message-Id: <44c1e36d3113badfe4b76fcdafbb6df7@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 2017-09-29 14:44, Peter Huewe wrote:
> Hi Mimi, Hi Nayna,
> 
> 
>> The patch replaces the call to builtin_platform_driver(), with a call
>> to core_initcall().
> 
>> https://github.com/raspberrypi/linux/blob/rpi-4.8.y/drivers/clk/bcm/cl
>> k-bcm2835.c
> 
>> static int __init __bcm2835_clk_driver_init(void)
>> {
>> return platform_driver_register(&bcm2835_clk_driver);
>> }
>> core_initcall(__bcm2835_clk_driver_init);
> 
> Ah it is already in the rpi sources - however I *am* using these, but
> it does not work?
> Any ideas or pointers highly appreciated.
> 

Peter,

     I made TPM work on my RPI 3 Model B running a version of rpi-4.8.y.

     From the dmesg you provided in the previous email, there could be
     several possible reasons why the kernel is not detecting the
     TPM-SPI chip :

     1. The SPI bus is not enabled on the Pi. You can use the 
raspi-config
        command with sudo.

           sudo raspi-config
            then select Advanced Options,
            then select SPI.

        
https://www.raspberrypi.org/documentation/configuration/raspi-config.md

     2. A node for the TPM chip is not properly added to the device tree.

     3. A node is added to the device tree source, but it is not compiled 
into
        binary from.

     4. The node is compiled, but you did not tell the kernel to use it 
during boot.

         The binary overlay files (.dtbo) are placed under 
/boot/overlays.
         To activate the TPM overlay, place the line

             dtoverlay=tpm_tis_spi

         in /boot/config.txt.

         But first make sure there is this file 
/boot/overlays/tpm_tis_spi.dtbo


     Regarding device tree (points 2. and 3.), it is more involved and I 
did not have
     time now to give a detailed answer. But as a starter, besides the 
dmesg msgs in
     your previous email, did dmesg give any other message on TPM ?

     Also, it is possible that TPM initialization was delayed but 
eventually completed
     at a later time during boot (although not in time for IMA). After 
the completion
     of the boot process, is there a /dev/tpm0 char special file (or 
/dev/tpm*) ?


  Pau-Chen

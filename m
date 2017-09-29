Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39704 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751091AbdI2LkQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 29 Sep 2017 07:40:16 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v8TBdZhi103869
        for <linux-integrity@vger.kernel.org>; Fri, 29 Sep 2017 07:40:16 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2d9fsh3402-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 29 Sep 2017 07:40:16 -0400
Received: from localhost
        by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Fri, 29 Sep 2017 21:40:14 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
        by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v8TBeCAu47906998
        for <linux-integrity@vger.kernel.org>; Fri, 29 Sep 2017 21:40:12 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
        by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id v8TBeFoe021410
        for <linux-integrity@vger.kernel.org>; Fri, 29 Sep 2017 21:40:15 +1000
Subject: Re: Aw: Re:  tpm_tis_spi gets initialized long after IMA
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Peter Huewe <PeterHuewe@gmx.de>
Cc: Nayna Jain <nayna@linux.vnet.ibm.com>, pau@linux.vnet.ibm.com,
        linux-integrity@vger.kernel.org
Date: Fri, 29 Sep 2017 07:40:08 -0400
In-Reply-To: <trinity-868e9e34-679a-4aff-97a3-9edf65a2fcda-1506673263842@3c-app-gmx-bs15>
References: <trinity-d76a5983-fa13-4ac4-8e48-d94d22a80e86-1506633490200@3c-app-gmx-bs75>
         <trinity-e306a773-6b97-4508-8894-89da4b67f01f-1506634575541@3c-app-gmx-bs75>
         <1506647389.5691.76.camel@linux.vnet.ibm.com>
         <trinity-868e9e34-679a-4aff-97a3-9edf65a2fcda-1506673263842@3c-app-gmx-bs15>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1506685208.5691.109.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2017-09-29 at 10:21 +0200, Peter Huewe wrote:
> Hi Mimi,
> 
> On Thu, 2017-09-28 at 23:36 +0200, Peter Huewe wrote:
> >> Okay,
> >> first error - CONFIG_SPI_BCM2835 has to be compiled in.
> >> That explains the 2.5 sec.
> 
> > Last December we were able to initialize the TPM before IMA.   It
> > required commit 29c7854 - "Register the clocks early during the boot
> > process, so that special/critical clocks can get enabled early
> > on in the boot process avoiding the risk of disabling a clock,
> > pll_divider or pll when a claiming driver fails to install
> > propperly - maybe it needs to defer."
> 
> > We built a custom kernel with both commit 29c7854 and building in
> > BCM2835_SPI (thanks Nayna).
> 
> To which tree is the commit id related to?
> i.e. where can I find the patch?

The patch replaces the call to builtin_platform_driver(), with a call
to core_initcall().

https://github.com/raspberrypi/linux/blob/rpi-4.8.y/drivers/clk/bcm/cl
k-bcm2835.c

static int __init __bcm2835_clk_driver_init(void)
{
	return platform_driver_register(&bcm2835_clk_driver);
}
core_initcall(__bcm2835_clk_driver_init);


Mimi

Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:50095 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750967AbdI2IVI (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 29 Sep 2017 04:21:08 -0400
MIME-Version: 1.0
Message-ID: <trinity-868e9e34-679a-4aff-97a3-9edf65a2fcda-1506673263842@3c-app-gmx-bs15>
From: "Peter Huewe" <PeterHuewe@gmx.de>
To: "Mimi Zohar" <zohar@linux.vnet.ibm.com>
Cc: "Nayna Jain" <nayna@linux.vnet.ibm.com>, pau@linux.vnet.ibm.com,
        linux-integrity@vger.kernel.org
Subject: Aw: Re:  tpm_tis_spi gets initialized long after IMA
Content-Type: text/plain; charset=UTF-8
Date: Fri, 29 Sep 2017 10:21:03 +0200
In-Reply-To: <1506647389.5691.76.camel@linux.vnet.ibm.com>
References: <trinity-d76a5983-fa13-4ac4-8e48-d94d22a80e86-1506633490200@3c-app-gmx-bs75>
 <trinity-e306a773-6b97-4508-8894-89da4b67f01f-1506634575541@3c-app-gmx-bs75>
 <1506647389.5691.76.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi Mimi,

On Thu, 2017-09-28 at 23:36 +0200, Peter Huewe wrote:
>> Okay,
>> first error - CONFIG_SPI_BCM2835 has to be compiled in.
>> That explains the 2.5 sec.

> Last December we were able to initialize the TPM before IMA.   It
> required commit 29c7854 - "Register the clocks early during the boot
> process, so that special/critical clocks can get enabled early
> on in the boot process avoiding the risk of disabling a clock,
> pll_divider or pll when a claiming driver fails to install
> propperly - maybe it needs to defer."

> We built a custom kernel with both commit 29c7854 and building in
> BCM2835_SPI (thanks Nayna).

To which tree is the commit id related to?
i.e. where can I find the patch?

Searching for it I found only some rejected versions of the patch.

Thanks,
Peter

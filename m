Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:64599 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753673AbdJaAdh (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Oct 2017 20:33:37 -0400
From: Peter Huewe <peterhuewe@gmx.de>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: <zohar@linux.vnet.ibm.com>, <linux-kernel@vger.kernel.org>,
        <linux-integrity@vger.kernel.org>, <peterhuewe@gmx.de>
Subject: Re: [PATCH] MAINTAINERS: update TPM driver infrastructure changes
Date: Tue, 31 Oct 2017 01:41:42 +0100
MIME-Version: 1.0
Message-ID: <5ac2c392-3ec2-4656-a185-6c9c554b8b2e@gmx.de>
In-Reply-To: <20170929202313.6g46pv7j3sp7z73q@linux.intel.com>
References: <20170915223811.21368-1-jarkko.sakkinen@linux.intel.com>
 <1506442580.3677.97.camel@linux.vnet.ibm.com>
 <31979c8601c5472f9ba413375e034b34@infineon.com>
 <20170929202313.6g46pv7j3sp7z73q@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi,

Am Freitag, 29. September 2017 22:23:13 CEST schrieb Jarkko Sakkinen:
> On Fri, Sep 29, 2017 at 08:29:09AM +0000, Peter.Huewe@infineon.com wrote:
>>> ...
>> Spinics is archiving us at
>> https://www.spinics.net/lists/linux-integrity/
>> 
>> It would be good to add this to the vger page + documented on 
>> the wiki, which should be added to MAINTAINERS.
>> http://kernsec.org/wiki/index.php/Linux_Kernel_Integrity as wiki page
>> 
>> 
>> Peter ...
>
> Can you submit a follow-up patch that adds this information?

I added the information to the kernsec wiki at
http://kernsec.org/wiki/index.php/Linux_Kernel_Integrity

However, since your MAINTAINERS patch is neither upstream, nor in any of 
your
branches (next / master) I cannot send an update.

About the wiki - I added quite a few other links, especially about tpm 2.0.
If anyone wants to have any information added, please let me know.

I definitely would like to extend the wiki usage.
So if you have any documents, e.g. 
- about how the patch flow is/should be,
- how stuff gets tested
- subsystem specific rules
- subsystem architecuture

but also links to interesting pages/projects PLEASE let me know.

Thanks,
Peter

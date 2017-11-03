Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:23374 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750821AbdKCOVN (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Nov 2017 10:21:13 -0400
Date: Fri, 3 Nov 2017 16:21:07 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Peter Huewe <peterhuewe@gmx.de>
Cc: zohar@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: update TPM driver infrastructure changes
Message-ID: <20171103142107.gdlooejtpehfkeez@linux.intel.com>
References: <20170915223811.21368-1-jarkko.sakkinen@linux.intel.com>
 <1506442580.3677.97.camel@linux.vnet.ibm.com>
 <31979c8601c5472f9ba413375e034b34@infineon.com>
 <20170929202313.6g46pv7j3sp7z73q@linux.intel.com>
 <5ac2c392-3ec2-4656-a185-6c9c554b8b2e@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5ac2c392-3ec2-4656-a185-6c9c554b8b2e@gmx.de>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, Oct 31, 2017 at 01:41:42AM +0100, Peter Huewe wrote:
> Hi,
> 
> Am Freitag, 29. September 2017 22:23:13 CEST schrieb Jarkko Sakkinen:
> > On Fri, Sep 29, 2017 at 08:29:09AM +0000, Peter.Huewe@infineon.com wrote:
> > > > ...
> > > Spinics is archiving us at
> > > https://www.spinics.net/lists/linux-integrity/
> > > 
> > > It would be good to add this to the vger page + documented on the
> > > wiki, which should be added to MAINTAINERS.
> > > http://kernsec.org/wiki/index.php/Linux_Kernel_Integrity as wiki page
> > > 
> > > 
> > > Peter ...
> > 
> > Can you submit a follow-up patch that adds this information?
> 
> I added the information to the kernsec wiki at
> http://kernsec.org/wiki/index.php/Linux_Kernel_Integrity
> 
> However, since your MAINTAINERS patch is neither upstream, nor in any of
> your
> branches (next / master) I cannot send an update.
> 
> About the wiki - I added quite a few other links, especially about tpm 2.0.
> If anyone wants to have any information added, please let me know.
> 
> I definitely would like to extend the wiki usage.
> So if you have any documents, e.g. - about how the patch flow is/should be,
> - how stuff gets tested
> - subsystem specific rules
> - subsystem architecuture
> 
> but also links to interesting pages/projects PLEASE let me know.
> 
> Thanks,
> Peter

Looks good to me.

/Jarkko

Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from smtprelay0172.hostedemail.com ([216.40.44.172]:51669 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750880AbdJRKtV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Oct 2017 06:49:21 -0400
Message-ID: <1508323753.6806.5.camel@perches.com>
Subject: Re: char-TPM: Adjustments for ten function implementations
From: Joe Perches <joe@perches.com>
To: Alexander.Steffen@infineon.com, julia.lawall@lip6.fr
Cc: elfring@users.sourceforge.net, linux-integrity@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        James.Bottomley@HansenPartnership.com, dan.carpenter@oracle.com,
        jarkko.sakkinen@linux.intel.com, andriy.shevchenko@linux.intel.com,
        benh@kernel.crashing.org, clabbe.montjoie@gmail.com,
        jgunthorpe@obsidianresearch.com, jsnitsel@redhat.com,
        kgold@linux.vnet.ibm.com, mpe@ellerman.id.au,
        nayna@linux.vnet.ibm.com, paulus@samba.org, PeterHuewe@gmx.de,
        stefanb@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Date: Wed, 18 Oct 2017 03:49:13 -0700
In-Reply-To: <b2772ac342ca4cb19149dd2c91f26087@infineon.com>
References: <1d3516a2-a8e6-9e95-d438-f115fac84c7f@users.sourceforge.net>
         <20171016183139.otyh3m5c5yurtmow@linux.intel.com>
         <20171016183512.3bz6x4b6lbhpbkje@linux.intel.com>
         <20171017085124.pkrjzghcf5wmcydc@mwanda>
         <f9b35a67-bd7f-b140-bdc1-cb4886a6b1ea@users.sourceforge.net>
         <1508255833.3129.33.camel@HansenPartnership.com>
         <1508280210.6530.32.camel@perches.com>
         <bf7fc26c-bdc9-c752-72c7-f44c22f4a328@users.sourceforge.net>
         <1508318326.6806.1.camel@perches.com>
         <026d582729b849b780fbaa06fb8bc79e@infineon.com>
         <alpine.DEB.2.20.1710181154390.3524@hadrien>
         <b2772ac342ca4cb19149dd2c91f26087@infineon.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, 2017-10-18 at 10:44 +0000, Alexander.Steffen@infineon.com wrote:
> > For instance, nothing about
> > > > 	sizeof(type)
> > > > vs
> > > > 	sizeof(*ptr)
> > > > makes it easier for a human to read the code.
> > > 
> > > If it does not make it easier to read the code for you, then maybe you
> > > should consider that this might not be true for all humans. For me, it
> > > makes it much easier to see at a glance, that code like
> > > ptr=malloc(sizeof(*ptr)) is correct.
> > 
> > I don't think there is a perfect solution.
> 
> Maybe. But for the second variant the correctness is easier to check,

How often should
	ptr = alloc(sizeof(*ptr))
be
	ptr = alloc(sizeof(**ptr))

>  both mentally and programmatically, because there is no need for any context (the type of ptr does not matter).

Context matters.

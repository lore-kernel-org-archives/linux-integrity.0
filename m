Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from smtp-out6.electric.net ([192.162.217.192]:58457 "EHLO
        smtp-out6.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753275AbdJRNUk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Oct 2017 09:20:40 -0400
From: David Laight <David.Laight@ACULAB.COM>
To: 'SF Markus Elfring' <elfring@users.sourceforge.net>,
        Joe Perches <joe@perches.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
CC: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "Stefan Berger" <stefanb@linux.vnet.ibm.com>,
        Alexander Steffen <Alexander.Steffen@infineon.com>,
        Nayna Jain <nayna@linux.vnet.ibm.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Kenneth Goldman <kgold@linux.vnet.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        =?utf-8?B?UGV0ZXIgSMO8d2U=?= <PeterHuewe@gmx.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: RE: Adjusting further size determinations?
Date: Wed, 18 Oct 2017 12:58:43 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD009ACE3@AcuExch.aculab.com>
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
 <1508322510.6806.3.camel@perches.com>
 <ab5730c4-fb69-4791-a2a6-c726493d4564@users.sourceforge.net>
 <1508327383.6806.7.camel@perches.com>
 <0fc1f522-8772-d859-a9b0-cb3b6931c862@users.sourceforge.net>
In-Reply-To: <0fc1f522-8772-d859-a9b0-cb3b6931c862@users.sourceforge.net>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

From: SF Markus Elfring
> >>>> Unpleasant consequences are possible in both cases.
> >> How much do you care to reduce the failure probability further?
> >
> > Zero.
> 
> I am interested to improve the software situation a bit more here.

There are probably better places to spend your time!

If you want 'security' for kmalloc() then:

#define KMALLOC_TYPE(flags) (type *)kmalloc(sizeof (type), flags)
#define KMALLOC(ptr, flags) *(ptr) = KMALLOC_TYPE(typeof *(ptr), flags)

and change:
	ptr = kmalloc(sizeof *ptr, flags);
to:
	KMALLOC(&ptr, flags);

But it is all churn for churn's sake.

	David

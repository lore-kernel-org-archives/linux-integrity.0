Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.12]:52657 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757790AbdJRJBE (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Oct 2017 05:01:04 -0400
Subject: Re: char-TPM: Adjustments for ten function implementations
To: Joe Perches <joe@perches.com>, linux-integrity@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Kenneth Goldman <kgold@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nayna Jain <nayna@linux.vnet.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        =?UTF-8?Q?Peter_H=c3=bcwe?= <PeterHuewe@gmx.de>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <1d3516a2-a8e6-9e95-d438-f115fac84c7f@users.sourceforge.net>
 <20171016183139.otyh3m5c5yurtmow@linux.intel.com>
 <20171016183512.3bz6x4b6lbhpbkje@linux.intel.com>
 <20171017085124.pkrjzghcf5wmcydc@mwanda>
 <f9b35a67-bd7f-b140-bdc1-cb4886a6b1ea@users.sourceforge.net>
 <1508255833.3129.33.camel@HansenPartnership.com>
 <1508280210.6530.32.camel@perches.com>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <bf7fc26c-bdc9-c752-72c7-f44c22f4a328@users.sourceforge.net>
Date: Wed, 18 Oct 2017 11:00:14 +0200
MIME-Version: 1.0
In-Reply-To: <1508280210.6530.32.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

> The printk removals do change the objects.
> 
> The value of that type of change is only for resource limited systems.

I imagine that such small code adjustments are also useful for other systems.


> Markus' changelogs leave much to be desired.

Would you like to help more to improve the provided information
for the shown change patterns?

Regards,
Markus

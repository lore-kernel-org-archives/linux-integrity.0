Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.3]:53772 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754520AbdJQHVh (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 Oct 2017 03:21:37 -0400
Subject: Re: [PATCH 0/4] char-TPM: Adjustments for ten function
 implementations
To: Joe Perches <joe@perches.com>, linux-integrity@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
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
 <1508193989.6530.17.camel@perches.com>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <34574b21-4925-c7f4-0b85-ebe62867c651@users.sourceforge.net>
Date: Tue, 17 Oct 2017 09:20:40 +0200
MIME-Version: 1.0
In-Reply-To: <1508193989.6530.17.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

>> A minor complaint: all commits are missing "Fixes:" tag.
> 
> None of these patches fix anything.

It depends on the view which you prefer.


> All are trivial changes without much of any impact.

I find that they improve the affected software another bit.
Other adjustments can be more noticeable.

Regards,
Markus

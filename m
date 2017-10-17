Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:41185
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1759645AbdJQI4s (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 Oct 2017 04:56:48 -0400
Date: Tue, 17 Oct 2017 10:56:42 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
To: Dan Carpenter <dan.carpenter@oracle.com>
cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        SF Markus Elfring <elfring@users.sourceforge.net>,
        linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Kenneth Goldman <kgold@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nayna Jain <nayna@linux.vnet.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        =?ISO-8859-15?Q?Peter_H=FCwe?= <PeterHuewe@gmx.de>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 0/4] char-TPM: Adjustments for ten function
 implementations
In-Reply-To: <20171017085124.pkrjzghcf5wmcydc@mwanda>
Message-ID: <alpine.DEB.2.20.1710171055100.5035@hadrien>
References: <1d3516a2-a8e6-9e95-d438-f115fac84c7f@users.sourceforge.net> <20171016183139.otyh3m5c5yurtmow@linux.intel.com> <20171016183512.3bz6x4b6lbhpbkje@linux.intel.com> <20171017085124.pkrjzghcf5wmcydc@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>



On Tue, 17 Oct 2017, Dan Carpenter wrote:

> On Mon, Oct 16, 2017 at 09:35:12PM +0300, Jarkko Sakkinen wrote:
> >
> > A minor complaint: all commits are missing "Fixes:" tag.
> >
>
> Fixes is only for bug fixes.  These don't fix any bugs.

0-day seems to put Fixes for everything.  Should they be removed when the
old code is undesirable but doesn't actually cause a crash, eg out of date
API.

julia


>
> regards,
> dan carpenter
>
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

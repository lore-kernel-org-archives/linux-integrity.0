Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:39368 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753902AbdJQIw2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 Oct 2017 04:52:28 -0400
Date: Tue, 17 Oct 2017 11:51:25 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: SF Markus Elfring <elfring@users.sourceforge.net>,
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
        Peter =?iso-8859-1?Q?H=FCwe?= <PeterHuewe@gmx.de>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 0/4] char-TPM: Adjustments for ten function
 implementations
Message-ID: <20171017085124.pkrjzghcf5wmcydc@mwanda>
References: <1d3516a2-a8e6-9e95-d438-f115fac84c7f@users.sourceforge.net>
 <20171016183139.otyh3m5c5yurtmow@linux.intel.com>
 <20171016183512.3bz6x4b6lbhpbkje@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171016183512.3bz6x4b6lbhpbkje@linux.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, Oct 16, 2017 at 09:35:12PM +0300, Jarkko Sakkinen wrote:
> 
> A minor complaint: all commits are missing "Fixes:" tag.
> 

Fixes is only for bug fixes.  These don't fix any bugs.

regards,
dan carpenter

Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:28171 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750847AbeCPMVh (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Mar 2018 08:21:37 -0400
Date: Fri, 16 Mar 2018 14:21:29 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/5] tpm: migrate tpm2_probe() to use struct tpm_buf
Message-ID: <20180316122129.GA2458@linux.intel.com>
References: <20180305165614.5469-1-jarkko.sakkinen@linux.intel.com>
 <20180305165614.5469-4-jarkko.sakkinen@linux.intel.com>
 <1520290344.10396.357.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1520290344.10396.357.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, Mar 05, 2018 at 05:52:24PM -0500, Mimi Zohar wrote:
> Hi Jarrko,
> 
> On Mon, 2018-03-05 at 18:56 +0200, Jarkko Sakkinen wrote:
> > In order to make struct tpm_buf the first class object for constructing TPM
> > commands, migrate tpm2_probe() to use it.
> > 
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> 
> With this patch, the Pi doesn't find the TPM.  I'm seeing the
> following line in dmesg.
> 
> [    1.087414] tpm_tis_spi: probe of spi0.0 failed with error 256

Thank you for reporting this Mimi. Does it have TPM1/TPM2?

/Jarkko

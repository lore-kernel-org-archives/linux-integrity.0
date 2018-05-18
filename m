Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:44936 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751418AbeERIFV (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 18 May 2018 04:05:21 -0400
Date: Fri, 18 May 2018 11:05:16 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Nayna Jain <nayna@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/4] tpm: migrate tpm2_get_tpm_pt() to use struct
 tpm_buf
Message-ID: <20180518080516.GB14777@linux.intel.com>
References: <20180326121406.14548-1-jarkko.sakkinen@linux.intel.com>
 <20180326121406.14548-4-jarkko.sakkinen@linux.intel.com>
 <95828353-43e1-0a02-ea54-544b709584b9@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <95828353-43e1-0a02-ea54-544b709584b9@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, May 18, 2018 at 12:01:46PM +0530, Nayna Jain wrote:
> 
> 
> On 03/26/2018 05:44 PM, Jarkko Sakkinen wrote:
> > In order to make struct tpm_buf the first class object for constructing TPM
> > commands, migrate tpm2_get_tpm_pt() to use it.
> > 
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Reviewed-by: Nayna Jain<nayna@linux.vnet.ibm.com>
> Tested-by: Nayna Jain<nayna@linux.vnet.ibm.com>

For all the rest, thanks. I'll still do one more revision of these
patches to update the kdoc comments (but they do not involve any
code changes).

/Jarkko

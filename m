Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:31330 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbeJBHc5 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 Oct 2018 03:32:57 -0400
Date: Tue, 2 Oct 2018 03:52:08 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Tomas Winkler <tomas.winkler@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
        Nayna Jain <nayna@linux.vnet.ibm.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 12/21] tpm: move pcr extend code to tpm2-cmd.c
Message-ID: <20181002005208.GH23753@linux.intel.com>
References: <20180928223035.14471-1-tomas.winkler@intel.com>
 <20180928223035.14471-13-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180928223035.14471-13-tomas.winkler@intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Sat, Sep 29, 2018 at 01:30:26AM +0300, Tomas Winkler wrote:
> Add tpm2_pcr_extend() function to tpm2-cmd.c with signature required
> by tpm-interface.c. It wraps the original open code
> implementation. The original original tpm2_pcr_extend() function
> is renamed to __tpm2_pcr_extend() and made static, it is called
> only from new tpm2_pcr_extend().
> 
> Fix warnings in __tpm2_pcr_extend()
> tpm2-cmd.c:251:16: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
> tpm2-cmd.c:252:17: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

We do not want the signature change, especially because as we are
working on getting Roberto's changes in and also because it has
absolutely a zero gain. Who cares if those functions take different
parameters? I don't.

/Jarkko

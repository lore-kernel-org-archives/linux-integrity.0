Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga17.intel.com ([192.55.52.151]:55855 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbeJBHVB (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 Oct 2018 03:21:01 -0400
Date: Tue, 2 Oct 2018 03:40:24 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Tomas Winkler <tomas.winkler@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
        Nayna Jain <nayna@linux.vnet.ibm.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 01/21] tpm2: add new tpm2 commands according to TCG
 1.36
Message-ID: <20181002004024.GB23753@linux.intel.com>
References: <20180928223035.14471-1-tomas.winkler@intel.com>
 <20180928223035.14471-2-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180928223035.14471-2-tomas.winkler@intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Sat, Sep 29, 2018 at 01:30:15AM +0300, Tomas Winkler wrote:
> 1. TPM2_CC_LAST has moved from 182 to 193
> 2. Convert tpm2_ordinal_duration from an array into a switch statement,
>    as there are not so many commands that require special duration
>    relative to a number of commands, the switch statement function
>    is called tpm2_ordinal_duration_index().
> 3. Fix kdoc comments for tpm2_calc_ordinal_duration().
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
> 
> V2-V3: Rebase.
> V4: 1. Fix kdoc
>     2. Rename tpm2_ordinal_duration() to tpm2_ordinal_duration_index()
>     3. Move the two functions close to each other in the file.
> V5: Adjust the kdoc to the new standard.

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko

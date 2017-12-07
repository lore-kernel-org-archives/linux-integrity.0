Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:12310 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752413AbdLGKgX (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Dec 2017 05:36:23 -0500
Date: Thu, 7 Dec 2017 12:36:18 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Philip Tricca <philip.b.tricca@intel.com>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        linux-integrity@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH] tpm: return a TPM_RC_COMMAND_CODE response if a command
 isn't implemented
Message-ID: <20171207103618.2wk37zjh2pxfqxws@linux.intel.com>
References: <20171126233012.24528-1-javierm@redhat.com>
 <20171207013216.vdyaxcanpmaecx6p@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171207013216.vdyaxcanpmaecx6p@linux.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, Dec 07, 2017 at 03:32:16AM +0200, Jarkko Sakkinen wrote:
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> 
> /Jarkko


```
$ python -m unittest -v tpm2_smoke.SpaceTest.test_invalid_cc
test_invalid_cc (tpm2_smoke.SpaceTest) ... ok

----------------------------------------------------------------------
Ran 1 test in 5.833s

OK
``` [1]

Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko

Philip, are you sure you don't want to give tested-by?

[1] https://github.com/jsakkine-intel/tpm2-scripts/commit/4398af02a90442a85751148aebf725992a2949f3

/Jarkko

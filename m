Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:23288 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755842AbeARSq1 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Jan 2018 13:46:27 -0500
Date: Thu, 18 Jan 2018 20:46:22 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Alexander Steffen <Alexander.Steffen@infineon.com>
Cc: pmenzel@molgen.mpg.de, jgg@ziepe.ca,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm2-cmd: try full selftest once if continue selftest
 failed
Message-ID: <20180118184622.5iox24xbmovwraht@linux.intel.com>
References: <20171222135610.7056-1-Alexander.Steffen@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171222135610.7056-1-Alexander.Steffen@infineon.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Dec 22, 2017 at 02:56:10PM +0100, Alexander Steffen wrote:
> If the usual approach of triggering only the missing selftests failed, give
> the TPM another chance by requesting all selftests once.
> 
> With the current implementation, this will only help for TPMs that then
> choose to run the selftests synchronously and return the selftest result.
> There is no retry loop that again polls a TPM returning TPM_RC_TESTING in
> this case.
> 
> Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
> ---
> Patch depends on https://patchwork.kernel.org/patch/10105483/

NAK because of dependency.

/Jarkko

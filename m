Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:54892 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751494AbeDFKbH (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 6 Apr 2018 06:31:07 -0400
Date: Fri, 6 Apr 2018 13:31:01 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        open list <linux-kernel@vger.kernel.org>,
        tomas.winkler@intel.com,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH v4 0/4] Migrate all TPM 2.0 commands to use struct tpm_buf
Message-ID: <20180406103101.GA14379@linux.intel.com>
References: <20180326121406.14548-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180326121406.14548-1-jarkko.sakkinen@linux.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, Mar 26, 2018 at 03:14:02PM +0300, Jarkko Sakkinen wrote:
> In order to make struct tpm_buf the first class object for constructing TPM
> commands, this patch set migrates all TPM 2.0 commands to use it. Eventually,
> tpm_transmit_cmd() can take simply struct tpm_buf as its argument and this
> interface can be exported to be used by the kernel keyring and potentially
> other subsystems.
> 
> The ultimate goal of this work is to make constructing TPM commands inside
> the kernel simple and robust.

I pushed these commits to the master branch. Please report if you have
any issues. If the master branch continues working for you, as you test
it maybe for other reasons, I'm happy to get tested-by's for them. At
worst they have regressions. I seriously don't think that the code
changes have any major structural issues.

I would guess that Tomas' similar changes for TPM 1.x will follow at
some point. I'm looking forward to change the existing tpm_send()
as one that takes tpm_buf in. That will allow to remove a lot of
cruft code from keyring.

I take no rush to merge these to 'next' but I think it is fine to
have these in the bleeding edge.

/Jarkko

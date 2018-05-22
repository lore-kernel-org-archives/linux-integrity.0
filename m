Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:51988 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750733AbeEVJRk (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 22 May 2018 05:17:40 -0400
Date: Tue, 22 May 2018 12:17:32 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Tomas Winkler <tomas.winkler@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: separate cmd_ready/go_idle from runtime_pm
Message-ID: <20180522091732.GA5228@linux.intel.com>
References: <20180516194600.28189-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180516194600.28189-1-tomas.winkler@intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, May 16, 2018 at 10:46:00PM +0300, Tomas Winkler wrote:
> New wrappers are added tpm_cmd_ready() and tpm_go_idle() wrappers to
> streamline tpm_try_transmit code. TPM_TRANSMIT_UNLOCKED flag is abused to
> resolve tpm spaces recursive calls to tpm_transmit().

This looks good and all but I don't think we want to abuse anything in
the driver code, do we?

In other words, either

1. New flag is to be added.
2. Rename the existing flag to something else than UNLOCKED (perhaps
   SPACE).

 /Jarkko

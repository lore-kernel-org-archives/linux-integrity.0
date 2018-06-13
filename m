Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from orcrist.hmeau.com ([104.223.48.154]:53500 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754377AbeFMG2d (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 Jun 2018 02:28:33 -0400
Date: Wed, 13 Jun 2018 14:28:24 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Matthew Garrett <mjg59@google.com>
Cc: linux-integrity@vger.kernel.org, zohar@linux.vnet.ibm.com,
        linux-crypto@vger.kernel.org, davem@davemloft.net
Subject: Re: [PATCH V2 1/2] evm: Don't deadlock if a crypto algorithm is
 unavailable
Message-ID: <20180613062824.3h5dgsbsfkml7zs4@gondor.apana.org.au>
References: <20180606215712.121747-1-mjg59@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180606215712.121747-1-mjg59@google.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Jun 06, 2018 at 02:57:11PM -0700, Matthew Garrett wrote:
> When EVM attempts to appraise a file signed with a crypto algorithm the
> kernel doesn't have support for, it will cause the kernel to trigger a
> module load. If the EVM policy includes appraisal of kernel modules this
> will in turn call back into EVM - since EVM is holding a lock until the
> crypto initialisation is complete, this triggers a deadlock. Add a
> CRYPTO_NOLOAD flag and skip module loading if it's set, and add that flag
> in the EVM case in order to fail gracefully with an error message
> instead of deadlocking.
> 
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> ---
>  crypto/api.c                        | 2 +-
>  include/linux/crypto.h              | 5 +++++
>  security/integrity/evm/evm_crypto.c | 3 ++-
>  3 files changed, 8 insertions(+), 2 deletions(-)

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from orcrist.hmeau.com ([104.223.48.154]:59072 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751381AbeFBPy1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 2 Jun 2018 11:54:27 -0400
Date: Sat, 2 Jun 2018 23:54:18 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Matthew Garrett <mjg59@google.com>
Cc: linux-integrity@vger.kernel.org, zohar@linux.vnet.ibm.com,
        linux-crypto@vger.kernel.org, davem@davemloft.net
Subject: Re: [PATCH 1/2] evm: Don't deadlock if a crypto algorithm is
 unavailable
Message-ID: <20180602155418.nsumhiicugt26747@gondor.apana.org.au>
References: <20180601230244.138560-1-mjg59@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180601230244.138560-1-mjg59@google.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Jun 01, 2018 at 04:02:43PM -0700, Matthew Garrett wrote:
> Trying to instantiate a non-existent crypto algorithm will cause the
> kernel to trigger a module load. If EVM appraisal is enabled, this will
> in turn trigger appraisal of the module, which will fail because the
> crypto algorithm isn't available. Add a CRYPTO_NOLOAD flag and skip
> module loading if it's set, and add that flag in the EVM case.
> 
> Signed-off-by: Matthew Garrett <mjg59@google.com>

I don't get it.  Without your patch it will fail because the
EVM appraisal fails.  With your patch it will fail because there
is no algorithm registered.  So what's the difference?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

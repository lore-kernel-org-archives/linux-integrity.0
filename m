Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:31379 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752019AbeENKy1 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 May 2018 06:54:27 -0400
Date: Mon, 14 May 2018 13:54:22 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Tadeusz Struk <tadeusz.struk@intel.com>
Cc: jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        tpmdd-devel@lists.sourceforge.net
Subject: Re: [PATCH] tpm: fix use after free in tpm2_load_context
Message-ID: <20180514105422.GF8228@linux.intel.com>
References: <152589213590.23382.13567986597921947843.stgit@tstruk-mobl1.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <152589213590.23382.13567986597921947843.stgit@tstruk-mobl1.jf.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, May 09, 2018 at 11:55:35AM -0700, Tadeusz Struk wrote:
> If load context command returns with TPM2_RC_HANDLE or
> TPM2_RC_REFERENCE_H0 then we have use after free in
> line 114 and double free in 117.
> 
> Fixes: 4d57856a21ed2 ("tpm2: add session handle context saving and restoring to the space code")
> 
> Signed-off-by: Tadeusz Struk <tadeusz.struk@intel.com>

Thank you, appreciate this!

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko

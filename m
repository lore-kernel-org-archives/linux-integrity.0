Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:5076 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932845AbeEWNXV (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 May 2018 09:23:21 -0400
Date: Wed, 23 May 2018 16:23:18 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Tadeusz Struk <tadeusz.struk@intel.com>
Cc: jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] tpm: fix race condition in tpm_common_write()
Message-ID: <20180523132318.GE363@linux.intel.com>
References: <152701036671.19968.17347263774570787595.stgit@tstruk-mobl1.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <152701036671.19968.17347263774570787595.stgit@tstruk-mobl1.jf.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, May 22, 2018 at 10:32:46AM -0700, Tadeusz Struk wrote:
> There is a race condition in tpm_common_write function allowing two
> threads on the same /dev/tpm<N>, or two different applications on
> the same /dev/tpmrm<N> to overwrite eachother requests/responses.
> 
> Signed-off-by: Tadeusz Struk <tadeusz.struk@intel.com>

Ouch o_O Do you have a fixes tag for this one?

Thank you.

Reviewed-by: Jarkko Sakkien <jarkko.sakkinen@linux.intel.com>

/Jarkko

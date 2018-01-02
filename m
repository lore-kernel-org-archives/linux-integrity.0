Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:18982 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751561AbeABPgt (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 Jan 2018 10:36:49 -0500
Date: Tue, 2 Jan 2018 17:36:43 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Azhar Shaikh <azhar.shaikh@intel.com>,
        James Morris <james.l.morris@oracle.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: remove unused variables
Message-ID: <20180102153643.hb7eukts7j7dqkdz@linux.intel.com>
References: <20180102103924.1035536-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180102103924.1035536-1-arnd@arndb.de>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, Jan 02, 2018 at 11:38:54AM +0100, Arnd Bergmann wrote:
> The CLKRUN fix caused a few harmless compile-time warnings:
> 
> drivers/char/tpm/tpm_tis.c: In function 'tpm_tis_pnp_remove':
> drivers/char/tpm/tpm_tis.c:274:23: error: unused variable 'priv' [-Werror=unused-variable]
> drivers/char/tpm/tpm_tis.c: In function 'tpm_tis_plat_remove':
> drivers/char/tpm/tpm_tis.c:324:23: error: unused variable 'priv' [-Werror=unused-variable]
> 
> This removes the variables that have now become unused.
> 
> Fixes: 6d0866cbc2d3 ("tpm: Keep CLKRUN enabled throughout the duration of transmit_cmd()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks.

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko

Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from userp2120.oracle.com ([156.151.31.85]:53000 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754649AbeAGXld (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 7 Jan 2018 18:41:33 -0500
Date: Mon, 8 Jan 2018 10:40:33 +1100 (AEDT)
From: James Morris <james.l.morris@oracle.com>
To: Arnd Bergmann <arnd@arndb.de>
cc: Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Azhar Shaikh <azhar.shaikh@intel.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: remove unused variables
In-Reply-To: <20180102103924.1035536-1-arnd@arndb.de>
Message-ID: <alpine.LFD.2.20.1801081040250.8436@localhost>
References: <20180102103924.1035536-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, 2 Jan 2018, Arnd Bergmann wrote:

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


Reviewed-by: James Morris <james.l.morris@oracle.com>

-- 
James Morris
<james.l.morris@oracle.com>

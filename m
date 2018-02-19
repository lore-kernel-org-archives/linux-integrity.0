Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:5676 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752657AbeBSM32 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Feb 2018 07:29:28 -0500
Date: Mon, 19 Feb 2018 14:29:24 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: linux-integrity@vger.kernel.org
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: rename TPM_TRANSMIT_RAW ->
 TPM_TRANSMIT_IGNORE_LOCALITY
Message-ID: <20180219122924.eng5flgdjrdi7qs7@linux.intel.com>
References: <20180216083818.5483-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180216083818.5483-1-jarkko.sakkinen@linux.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Feb 16, 2018 at 10:38:18AM +0200, Jarkko Sakkinen wrote:
> The previous name does not give any picture of the behaviour.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>  drivers/char/tpm/tpm-interface.c  | 2 +-
>  drivers/char/tpm/tpm.h            | 4 ++--
>  drivers/char/tpm/tpm_vtpm_proxy.c | 3 ++-
>  3 files changed, 5 insertions(+), 4 deletions(-)

Are there people who are against of merging this change?

/Jarkko

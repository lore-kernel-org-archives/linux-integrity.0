Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:20004 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933360AbeFUQt3 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 21 Jun 2018 12:49:29 -0400
Date: Thu, 21 Jun 2018 19:49:25 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Ricardo Schwarzmeier <Ricardo.Schwarzmeier@infineon.com>
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterhuewe@gmx.de, jgg@ziepe.ca, arnd@arndb.de,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v3] tpm: Return the actual size when receiving an
 unsupported command
Message-ID: <20180621164925.GF11859@linux.intel.com>
References: <20180620143823.14718-1-Ricardo.Schwarzmeier@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180620143823.14718-1-Ricardo.Schwarzmeier@infineon.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Jun 20, 2018 at 04:38:23PM +0200, Ricardo Schwarzmeier wrote:
> The userpace expects to read the number of bytes stated in the header.
> Returning the size of the buffer instead would be unexpected.
> 
> Fixes: 095531f891e6 ("tpm: return a TPM_RC_COMMAND_CODE response if command is not implemented")
> 

No empty line here.

> Signed-off-by: Ricardo Schwarzmeier <Ricardo.Schwarzmeier@infineon.com>
> ---
> Changes since v2:
>  * Made commit message more clear
>  * Avoided endianness problems
> ---

The change log hould be here in order not to be included as part of
the commit message.

/Jarkko

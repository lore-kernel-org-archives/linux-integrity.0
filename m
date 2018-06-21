Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:57895 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933391AbeFUQsX (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 21 Jun 2018 12:48:23 -0400
Date: Thu, 21 Jun 2018 19:48:19 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Ricardo Schwarzmeier <Ricardo.Schwarzmeier@infineon.com>
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterhuewe@gmx.de, jgg@ziepe.ca, arnd@arndb.de,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v2] tpm: Return the actual size when receiving an
 unsupported command
Message-ID: <20180621164819.GE11859@linux.intel.com>
References: <20180620095507.682-1-Ricardo.Schwarzmeier@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180620095507.682-1-Ricardo.Schwarzmeier@infineon.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Jun 20, 2018 at 11:55:07AM +0200, Ricardo Schwarzmeier wrote:
> The command size is computed for the header anyway.
> It can as well indicate the correct number of bytes to read from the driver.
> Fixes: 095531f891e6 ("tpm: return a TPM_RC_COMMAND_CODE response if command is not implemented")
> 
> Signed-off-by: Ricardo Schwarzmeier <Ricardo.Schwarzmeier@infineon.com>

Can you fix the kbuild error and send v3? Otherwise, LGMT.

/Jarkko

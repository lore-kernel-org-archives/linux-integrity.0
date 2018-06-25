Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:27138 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752658AbeFYQHb (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 25 Jun 2018 12:07:31 -0400
Message-ID: <09e36b0d97b5f01ea5925b5a3031198049714ce8.camel@linux.intel.com>
Subject: Re: [PATCH v4] tpm: Return the actual size when receiving an
 unsupported command
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Ricardo Schwarzmeier <Ricardo.Schwarzmeier@infineon.com>,
        linux-integrity@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
        arnd@arndb.de, gregkh@linuxfoundation.org
Date: Mon, 25 Jun 2018 19:07:23 +0300
In-Reply-To: <20180622065000.31139-1-Ricardo.Schwarzmeier@infineon.com>
References: <20180622065000.31139-1-Ricardo.Schwarzmeier@infineon.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2018-06-22 at 08:50 +0200, Ricardo Schwarzmeier wrote:
> The userpace expects to read the number of bytes stated in the header.
> Returning the size of the buffer instead would be unexpected.
> Fixes: 095531f891e6 ("tpm: return a TPM_RC_COMMAND_CODE response if command is
> not implemented")
> 
> Signed-off-by: Ricardo Schwarzmeier <Ricardo.Schwarzmeier@infineon.com>
> ---

Do you have a changelog?

/Jarkko

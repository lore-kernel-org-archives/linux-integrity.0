Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:8453 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755173AbeARSaF (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Jan 2018 13:30:05 -0500
Date: Thu, 18 Jan 2018 20:30:00 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Alexander Steffen <Alexander.Steffen@infineon.com>
Cc: nayna@linux.vnet.ibm.com, kgold@linux.vnet.ibm.com,
        linux-integrity@vger.kernel.org
Subject: Re: [RFC][PATCH 7/9] tpm_tis_spi: release CS line when wait state
 handling fails
Message-ID: <20180118183000.dfljlvpkw2rxia3z@linux.intel.com>
References: <20171208184658.9588-1-Alexander.Steffen@infineon.com>
 <20171208184658.9588-8-Alexander.Steffen@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171208184658.9588-8-Alexander.Steffen@infineon.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Dec 08, 2017 at 07:46:56PM +0100, Alexander Steffen wrote:
> By setting cs_change=1 multiple messages are kept within the same
> transaction, i.e. the CS line is not released after the first message. This
> is fine during normal transactions, when the last message sets cs_change=0,
> so that the CS line is released at the end.
> 
> But when transactions cannot be completed, e.g. when the wait state
> handling times out, the CS line is not released before leaving the
> function, because no message is sent with cs_change=0. This breaks future
> SPI transactions, so ensure that the CS line is correcly released in this
> error case by sending an empty message.
> 
> Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko

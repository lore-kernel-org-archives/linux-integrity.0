Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:16720 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753501AbeARSEY (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Jan 2018 13:04:24 -0500
Date: Thu, 18 Jan 2018 20:04:19 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Alexander Steffen <Alexander.Steffen@infineon.com>
Cc: nayna@linux.vnet.ibm.com, kgold@linux.vnet.ibm.com,
        linux-integrity@vger.kernel.org
Subject: Re: [RFC][PATCH 4/9] tpm_tis_core: send all data in single operation
Message-ID: <20180118180419.xoppbjzavivwgviq@linux.intel.com>
References: <20171208184658.9588-1-Alexander.Steffen@infineon.com>
 <20171208184658.9588-5-Alexander.Steffen@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171208184658.9588-5-Alexander.Steffen@infineon.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Dec 08, 2017 at 07:46:53PM +0100, Alexander Steffen wrote:
> tpm_tis_send_data splits all commands sent to the TPM into at least two
> transfers, even if the commands are small enough to fit into a single
> transfer. The intention seems to be to make extra sure that the TPM has
> received all data correctly by observing the Expect flag flipping from 1 to
> 0 when writing the last byte.
> 
> Unfortunately, this does not work as intended, because the Expect flag will
> change not when the last byte is written to the FIFO, but when the TPM
> processes the last byte from the FIFO. With a large FIFO and long commands
> it might well be that there are still many bytes left in the FIFO when the
> Expect flag is checked. Obviously, the flag will be 1 then, even if the
> FIFO contains more bytes than expected. Since there is no indication
> whether the FIFO is already empty or not, there is no way to implement this
> check reliably.
> 
> But then again, this check is not necessary at all. The driver already
> ensures that not more data is sent to the TPM than is announced in the
> header. In addition, the TPM is required to throw away all extraneous bytes
> anyway. So if the Expect flag is 0 after all bytes have been sent to the
> TPM, the TPM has received the command correctly and is ready to execute it.
> 
> Therefore, remove this intermediary check and send all data in a single
> operation. This simplifies the code and improves the performance,
> especially for short commands.
> 
> Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>

LGTM

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko

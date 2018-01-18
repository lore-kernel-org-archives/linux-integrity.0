Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:34172 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753332AbeARSUX (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Jan 2018 13:20:23 -0500
Date: Thu, 18 Jan 2018 20:20:18 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Alexander Steffen <Alexander.Steffen@infineon.com>
Cc: nayna@linux.vnet.ibm.com, kgold@linux.vnet.ibm.com,
        linux-integrity@vger.kernel.org
Subject: Re: [RFC][PATCH 5/9] tpm_tis_core: use XDATA_FIFO for transfers if
 available
Message-ID: <20180118182018.u6sw2rh4dbcsbawn@linux.intel.com>
References: <20171208184658.9588-1-Alexander.Steffen@infineon.com>
 <20171208184658.9588-6-Alexander.Steffen@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171208184658.9588-6-Alexander.Steffen@infineon.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Dec 08, 2017 at 07:46:54PM +0100, Alexander Steffen wrote:
> The TPM indicates in DataTransferSizeSupport in TPM_INTF_CAPABILITY what
> the maximum supported transfer size is. Transfers larger than four bytes
> are only supported for the XDATA_FIFO, not the legacy DATA_FIFO. Therefore,
> always use the XDATA_FIFO when the TPM indicates support for non-legacy
> transfer sizes for maximum throughput.
> 
> Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
> ---

The commit message should say something about the introduced new macro.

/Jarkko

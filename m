Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:18143 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751796AbdKTXR7 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Nov 2017 18:17:59 -0500
Date: Tue, 21 Nov 2017 01:17:55 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Azhar Shaikh <azhar.shaikh@intel.com>
Cc: jgunthorpe@obsidianresearch.com, peterhuewe@gmx.de,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH RFC v3 1/2] tpm: Keep CLKRUN enabled throughout the
 duration of transmit_cmd()
Message-ID: <20171120231755.bokuy53zxt6nrygb@linux.intel.com>
References: <1510783632-55866-1-git-send-email-azhar.shaikh@intel.com>
 <1510783632-55866-2-git-send-email-azhar.shaikh@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1510783632-55866-2-git-send-email-azhar.shaikh@intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Nov 15, 2017 at 02:07:11PM -0800, Azhar Shaikh wrote:
> Commit 5e572cab92f0bb5 ("tpm: Enable CLKRUN protocol for Braswell
> systems") disabled CLKRUN protocol during TPM transactions and re-enabled
> once the transaction is completed. But there were still some corner cases
> observed where, reading of TPM header failed for savestate command
> while going to suspend, which resulted in suspend failure.
> To fix this issue keep the CLKRUN protocol disabled for the entire
> duration of a single TPM command and not disabling and re-enabling
> again for every TPM transaction.
> 
> Fixes: 5e572cab92f0bb5 ("tpm: Enable CLKRUN protocol for Braswell systems")
> 
> Signed-off-by: Azhar Shaikh <azhar.shaikh@intel.com>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.om>

/Jarkko

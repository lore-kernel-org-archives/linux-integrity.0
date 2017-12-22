Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:32041 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756218AbdLVSd3 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 Dec 2017 13:33:29 -0500
Date: Fri, 22 Dec 2017 20:33:24 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: linux-kernel@vger.kernel.org, James Ettle <james@ettle.org.uk>,
        Hans de Goede <hdegoede@redhat.com>,
        Azhar Shaikh <azhar.shaikh@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH 2/4] tpm: delete the TPM_TIS_CLK_ENABLE flag
Message-ID: <20171222183324.hqav6npybepqn5tz@linux.intel.com>
References: <20171220113538.16099-1-javierm@redhat.com>
 <20171220113538.16099-3-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171220113538.16099-3-javierm@redhat.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Dec 20, 2017 at 12:35:36PM +0100, Javier Martinez Canillas wrote:
> This flag is only used to warn if CLKRUN_EN wasn't disabled on Braswell
> systems, but the only way this can happen is if the code is not correct.
> 
> So it's an unnecessary check that just makes the code harder to read.
> 
> Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko

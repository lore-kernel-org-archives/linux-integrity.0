Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:19539 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752533AbeABOlY (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 Jan 2018 09:41:24 -0500
Date: Tue, 2 Jan 2018 16:41:18 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: linux-kernel@vger.kernel.org, James Ettle <james@ettle.org.uk>,
        Hans de Goede <hdegoede@redhat.com>,
        Azhar Shaikh <azhar.shaikh@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH v2 0/3] tpm: fix PS/2 devices not working on Braswell
 systems due CLKRUN enabled
Message-ID: <20180102144118.77ihmux3coi6uxkt@linux.intel.com>
References: <20171225022251.6464-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171225022251.6464-1-javierm@redhat.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, Dec 25, 2017 at 03:22:48AM +0100, Javier Martinez Canillas wrote:
> Hello,
> 
> Commit 5e572cab92f0 ("tpm: Enable CLKRUN protocol for Braswell systems")
> added logic in the TPM TIS driver to disable the Low Pin Count CLKRUN
> signal during TPM transactions.
> 
> Unfortunately this breaks other devices that are attached to the LPC bus
> like for example PS/2 mouse and keyboards.
> 
> The bug was reported to the Fedora kernel [0] and the kernel bugzilla [1].
> This issue and the propossed solution were discussed in this [2] thread,
> and the reporter (Jame Ettle) confirmed that his system works again after
> the fix in this series.
> 
> The patches are based on top or Jarkko Sakkinen's linux-tpmdd [3] tree.
> 
> Changes since v1:
> - Add collected tags
> - Drop patch that fixed a bug in the error path since was already fixed.
> 
> [0]: https://bugzilla.redhat.com/show_bug.cgi?id=1498987
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=197287
> [2]: https://patchwork.kernel.org/patch/10119417/
> [3]: git.infradead.org/users/jjs/linux-tpmdd.git
> 
> Best regards,
> Javier
> 
> 
> Javier Martinez Canillas (3):
>   tpm: delete the TPM_TIS_CLK_ENABLE flag
>   tpm: follow coding style for variable declaration in
>     tpm_tis_core_init()
>   tpm: only attempt to disable the LPC CLKRUN if is already enabled
> 
>  drivers/char/tpm/tpm_tis.c      | 15 ---------------
>  drivers/char/tpm/tpm_tis_core.c | 17 +++++++++++++----
>  drivers/char/tpm/tpm_tis_core.h |  1 -
>  3 files changed, 13 insertions(+), 20 deletions(-)
> 
> -- 
> 2.14.3
> 

Thanks, these are now applied.

/Jarkko

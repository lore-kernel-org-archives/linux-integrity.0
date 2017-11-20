Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:33856 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751350AbdKTP60 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Nov 2017 10:58:26 -0500
From: "Shaikh, Azhar" <azhar.shaikh@intel.com>
To: "jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>,
        "jgunthorpe@obsidianresearch.com" <jgunthorpe@obsidianresearch.com>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: RE: [PATCH RFC v3 0/2] Fix corner cases with disabling CLKRUN in
 tpm_tis
Date: Mon, 20 Nov 2017 15:58:23 +0000
Message-ID: <5FFFAD06ADE1CA4381B3F0F7C6AF582896E867@ORSMSX109.amr.corp.intel.com>
References: <1510783632-55866-1-git-send-email-azhar.shaikh@intel.com>
In-Reply-To: <1510783632-55866-1-git-send-email-azhar.shaikh@intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi Jarkko, Jason,

Could you please provide your review comments on this patchset.

Thank you!

Regards,
Azhar Shaikh

>-----Original Message-----
>From: Shaikh, Azhar
>Sent: Wednesday, November 15, 2017 2:07 PM
>To: jarkko.sakkinen@linux.intel.com; jgunthorpe@obsidianresearch.com;
>peterhuewe@gmx.de; linux-integrity@vger.kernel.org
>Cc: Shaikh, Azhar <azhar.shaikh@intel.com>
>Subject: [PATCH RFC v3 0/2] Fix corner cases with disabling CLKRUN in tpm_tis
>
>Changes from v1:
>- Patch 1: "tpm: Keep CLKRUN enabled throughout the duration of
>transmit_cmd()"
>  - Add NULL checks before calling clk_toggle callback
>  - Use IS_ENABLED instead of ifdef in tpm_tis_clkrun_toggle()
>  - Do not call tpm_platform_begin_xfer() and tpm_platform_end_xfer()
>    from tpm_tis_clkrun_toggle(). Make them static again.
>
>- Patch 2: "tpm_tis: Move ilb_base_addr to tpm_tis_tcg_phy"
>  - This is a new patch in this series as per suggestion from Jason.
>  - Is the current implementation ok or I should move the code in
>tpm_tis_pnp_remove()
>    and tpm_tis_plat_remove() inside tpm_tis_remove(). That way all the
>unmapping
>    can be done in one place, instead of 3 different places now. Also the
>unmapping
>    in tpm_tis_init() can be moved to tpm_tis_remove(), since in case of error
>    tpm_tis_core_init() calls tpm_tis_remove(). Kindly suggest.
>
>Changes from v2:
>- Patch 1: "tpm: Keep CLKRUN enabled throughout the duration of
>transmit_cmd()"
>  - No changes
>
>- Patch 2: "tpm_tis: Move ilb_base_addr to tpm_tis_tcg_phy"
>  - Updated is_bsw() function to have the #ifdef CONFIG_X86 check within the
>function
>    itself. Also removed the #ifdef CONFIG_X86 from all other places around
>is_bsw()
>
>Azhar Shaikh (2):
>  tpm: Keep CLKRUN enabled throughout the duration of transmit_cmd()
>  tpm_tis: Move ilb_base_addr to tpm_tis_tcg_phy
>
> drivers/char/tpm/tpm-interface.c |   6 +++
> drivers/char/tpm/tpm_tis.c       | 111 ++++++++++++++++++++++-----------------
> drivers/char/tpm/tpm_tis_core.c  |  21 ++++++++
> drivers/char/tpm/tpm_tis_core.h  |   1 +
> include/linux/tpm.h              |   1 +
> 5 files changed, 93 insertions(+), 47 deletions(-)
>
>--
>1.9.1

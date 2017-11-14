Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:53267 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753132AbdKNViz (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Nov 2017 16:38:55 -0500
Date: Tue, 14 Nov 2017 23:38:50 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Azhar Shaikh <azhar.shaikh@intel.com>
Cc: linux-integrity@vger.kernel.org, jarkko.sakkinen@intel.com
Subject: Re: [PATCH RFC v2 0/2] Fix corner cases with disabling CLKRUN in
 tpm_tis
Message-ID: <20171114213850.iwm4no3rerjefxht@linux.intel.com>
References: <1510090328-153106-1-git-send-email-azhar.shaikh@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1510090328-153106-1-git-send-email-azhar.shaikh@intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, Nov 07, 2017 at 01:32:06PM -0800, Azhar Shaikh wrote:
> Changes from v1:
> - Patch 1: "tpm: Keep CLKRUN enabled throughout the duration of transmit_cmd()"
>   - Add NULL checks before calling clk_toggle callback
>   - Use IS_ENABLED instead of ifdef in tpm_tis_clkrun_toggle()
>   - Do not call tpm_platform_begin_xfer() and tpm_platform_end_xfer()
>     from tpm_tis_clkrun_toggle(). Make them static again.
> 
> - Patch 2: "tpm_tis: Move ilb_base_addr to tpm_tis_tcg_phy"
>   - This is a new patch in this series as per suggestion from Jason.
>   - Is the current implementation ok or I should move the code in tpm_tis_pnp_remove()
>     and tpm_tis_plat_remove() inside tpm_tis_remove(). That way all the unmapping
>     can be done in one place, instead of 3 different places now. Also the unmapping
>     in tpm_tis_init() can be moved to tpm_tis_remove(), since in case of error
>     tpm_tis_core_init() calls tpm_tis_remove(). Kindly suggest.
> 
> 
> Azhar Shaikh (2):
>   tpm: Keep CLKRUN enabled throughout the duration of transmit_cmd()
>   tpm_tis: Move ilb_base_addr to tpm_tis_tcg_phy
> 
>  drivers/char/tpm/tpm-interface.c |   6 +++
>  drivers/char/tpm/tpm_tis.c       | 102 ++++++++++++++++++++++++---------------
>  drivers/char/tpm/tpm_tis_core.c  |  21 ++++++++
>  drivers/char/tpm/tpm_tis_core.h  |   1 +
>  include/linux/tpm.h              |   1 +
>  5 files changed, 93 insertions(+), 38 deletions(-)
> 
> -- 
> 1.9.1
> 

Please include my email (@linux.intel.com) to the TO-field for all TPM
patches (and the cover letter).

I will eventually catch these as I go through the ML but sometimes there
is more latency to do that when I have a busy period. In a less busy
period there is of course less latency.

As this is a shared list with IMA and EVM I have to check every message
whether it is a TPM patch. Thus, in a shared list including maintainers
is even more important. You can find maintainers for every subsystem
from MAINTAINERS file in the root of the Linux GIT tree.

Right now I have a very busy period as I'm upstream the SGX driver. That
is why it took a week to even spot this (just did).

I'll try to find time this week to properly review your changes but
cannot promise it will be tomorrow because, well, I just saw the patch
set.

With a quick oversight I do not see anything that would shock me but I
still have to look into it with time and care.

/Jarkko

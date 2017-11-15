Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:22460 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933196AbdKOWHN (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Nov 2017 17:07:13 -0500
From: Azhar Shaikh <azhar.shaikh@intel.com>
To: jarkko.sakkinen@linux.intel.com, jgunthorpe@obsidianresearch.com,
        peterhuewe@gmx.de, linux-integrity@vger.kernel.org
Cc: azhar.shaikh@intel.com
Subject: [PATCH RFC v3 0/2] Fix corner cases with disabling CLKRUN in tpm_tis
Date: Wed, 15 Nov 2017 14:07:10 -0800
Message-Id: <1510783632-55866-1-git-send-email-azhar.shaikh@intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Changes from v1:
- Patch 1: "tpm: Keep CLKRUN enabled throughout the duration of transmit_cmd()"
  - Add NULL checks before calling clk_toggle callback
  - Use IS_ENABLED instead of ifdef in tpm_tis_clkrun_toggle()
  - Do not call tpm_platform_begin_xfer() and tpm_platform_end_xfer()
    from tpm_tis_clkrun_toggle(). Make them static again.

- Patch 2: "tpm_tis: Move ilb_base_addr to tpm_tis_tcg_phy"
  - This is a new patch in this series as per suggestion from Jason.
  - Is the current implementation ok or I should move the code in tpm_tis_pnp_remove()
    and tpm_tis_plat_remove() inside tpm_tis_remove(). That way all the unmapping
    can be done in one place, instead of 3 different places now. Also the unmapping
    in tpm_tis_init() can be moved to tpm_tis_remove(), since in case of error
    tpm_tis_core_init() calls tpm_tis_remove(). Kindly suggest.

Changes from v2:
- Patch 1: "tpm: Keep CLKRUN enabled throughout the duration of transmit_cmd()"
  - No changes

- Patch 2: "tpm_tis: Move ilb_base_addr to tpm_tis_tcg_phy"
  - Updated is_bsw() function to have the #ifdef CONFIG_X86 check within the function
    itself. Also removed the #ifdef CONFIG_X86 from all other places around is_bsw()

Azhar Shaikh (2):
  tpm: Keep CLKRUN enabled throughout the duration of transmit_cmd()
  tpm_tis: Move ilb_base_addr to tpm_tis_tcg_phy

 drivers/char/tpm/tpm-interface.c |   6 +++
 drivers/char/tpm/tpm_tis.c       | 111 ++++++++++++++++++++++-----------------
 drivers/char/tpm/tpm_tis_core.c  |  21 ++++++++
 drivers/char/tpm/tpm_tis_core.h  |   1 +
 include/linux/tpm.h              |   1 +
 5 files changed, 93 insertions(+), 47 deletions(-)

-- 
1.9.1

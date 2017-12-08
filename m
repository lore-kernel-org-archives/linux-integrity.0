Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from smtp2.infineon.com ([217.10.52.18]:31893 "EHLO
        smtp2.infineon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751937AbdLHSrS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 8 Dec 2017 13:47:18 -0500
From: Alexander Steffen <Alexander.Steffen@infineon.com>
To: <jarkko.sakkinen@linux.intel.com>, <nayna@linux.vnet.ibm.com>,
        <kgold@linux.vnet.ibm.com>, <linux-integrity@vger.kernel.org>
CC: Alexander Steffen <Alexander.Steffen@infineon.com>
Subject: [RFC][PATCH 0/9] tpm: fix driver so that burstcount can be safely ignored
Date: Fri, 8 Dec 2017 19:46:49 +0100
Message-ID: <20171208184658.9588-1-Alexander.Steffen@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Disclaimer: This is RFC because unfortunately I do not have the time to bring it up to the usual standards. But from lying around on my hard disk it definitely won't improve, so I've decided to publish it now, to get at least some feedback or maybe for somebody else to pick it up. Since the work began some time ago, it is probably not rebased against the current state (but hopefully still applies).

This is a collection of all the fixes I made during the investigation of the problems with the "ignore burstcount" change. These are mainly fixes for the wait state handling in tpm_tis_spi, that probably was not really tested so far, since the previous implementation avoided wait states as far as possible. It also includes changes to tpm_tis_core, so that it follows the specification more closely. Finally, I've included a rebased version of the original "ignore burstcount" patch. Together, those patches pass all my tests and also each intermediate step is fine (so that bisecting still works).

Alexander Steffen (8):
  tpm_tis_core: clean up whitespace
  tpm_tis_core: access single TIS registers before doing complex
    transfers
  tpm_tis_core: correctly wait for flags to become zero
  tpm_tis_core: send all data in single operation
  tpm_tis_core: use XDATA_FIFO for transfers if available
  tpm_tis_spi: fix sending wrong data during wait state handling
  tpm_tis_spi: release CS line when wait state handling fails
  tpm_tis_spi: add delay between wait state retries

Nayna Jain (1):
  tpm: ignore burstcount to improve tpm_tis send() performance

 drivers/char/tpm/tpm_tis_core.c | 131 ++++++++++++++++++++--------------------
 drivers/char/tpm/tpm_tis_core.h |  26 ++++----
 drivers/char/tpm/tpm_tis_spi.c  |  21 +++++--
 3 files changed, 95 insertions(+), 83 deletions(-)

-- 
2.7.4

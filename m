Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:7844 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754402AbeDYKoj (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 Apr 2018 06:44:39 -0400
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: stable@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Azhar Shaikh <azhar.shaikh@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org (open list:TPM DEVICE DRIVER),
        linux-kernel@vger.kernel.org (open list),
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH 0/3] v4.16 tpmdd backports
Date: Wed, 25 Apr 2018 13:44:20 +0300
Message-Id: <20180425104425.5803-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

"tpm: add retry logic" caused merge conflicts so I picked couple of
other fixes in order to get it apply cleanly.

James Bottomley (1):
  tpm: add retry logic

Tomas Winkler (1):
  tpm: cmd_ready command can be issued only after granting locality

Winkler, Tomas (1):
  tpm: tpm-interface: fix tpm_transmit/_cmd kdoc

 drivers/char/tpm/tpm-interface.c | 131 ++++++++++++++++++++++++-------
 drivers/char/tpm/tpm.h           |   1 +
 drivers/char/tpm/tpm_crb.c       | 108 +++++++++++++++++--------
 drivers/char/tpm/tpm_tis_core.c  |   4 +-
 include/linux/tpm.h              |   2 +-
 5 files changed, 183 insertions(+), 63 deletions(-)

-- 
2.17.0

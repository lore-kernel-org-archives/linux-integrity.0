Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:5774 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751713AbeA1Hx3 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 28 Jan 2018 02:53:29 -0500
From: Tomas Winkler <tomas.winkler@intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH 0/2] tpm: fix locality and power saving handling
Date: Sun, 28 Jan 2018 09:50:59 +0200
Message-Id: <20180128075101.6883-1-tomas.winkler@intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Devices that support locality has failed to transmit due to
reserved order of locality request and cmdReady/goIdle handshake.
The cmdReady/goIdle should be performed on the requested locality.

The first patch corrects the locality and power-save order,
adds required polling for completion of goIdle and locality relinquish.

The second patch removes cmdRead/goIdle handshake from runtime_pm as it's
rather a part of TPM2 protocol  then true device power management,
and on device it's no longer optional.

Tomas Winkler (2):
  tpm: cmd_ready command can be issued only after granting locality
  tpm: separate cmd_ready/go_idle from runtime_pm

 drivers/char/tpm/tpm-interface.c |  21 ++++--
 drivers/char/tpm/tpm_crb.c       | 157 +++++++++++++++++++++++----------------
 drivers/char/tpm/tpm_tis_core.c  |   4 +-
 include/linux/tpm.h              |   4 +-
 4 files changed, 115 insertions(+), 71 deletions(-)

-- 
2.14.3

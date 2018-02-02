Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:49770 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754060AbeBBRXp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 2 Feb 2018 12:23:45 -0500
Message-ID: <1517592221.3137.18.camel@HansenPartnership.com>
Subject: [PATCH 0/2] Fix kernel buffer overruns caused by bit flips
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-integrity@vger.kernel.org
Cc: Jeremy Boone <Jeremy.Boone@nccgroup.trust>
Date: Fri, 02 Feb 2018 18:23:41 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

If a TPM is attached to a system via a serial bus on a platform that
suffers bit flips, we can get back dangerously wrong data.  This patch
series aims never to do a direct copy into a kernel buffer based on an
unchecked size value returned from the TPM.

Jeremy Boone (2):
  tpm: fix potential buffer overruns caused by bit glitches on the bus
  tpm drivers: fix potential buffer overruns caused by bit glitches on
    the bus

 drivers/char/tpm/st33zp24/st33zp24.c | 4 ++--
 drivers/char/tpm/tpm-interface.c     | 1 +
 drivers/char/tpm/tpm2-cmd.c          | 4 ++++
 drivers/char/tpm/tpm_i2c_infineon.c  | 5 +++--
 drivers/char/tpm/tpm_i2c_nuvoton.c   | 5 +++--
 drivers/char/tpm/tpm_tis_core.c      | 5 +++--
 6 files changed, 16 insertions(+), 8 deletions(-)

-- 
2.12.3

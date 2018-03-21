Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:41608 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752355AbeCUSm3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 21 Mar 2018 14:42:29 -0400
Message-ID: <1521657747.6397.18.camel@HansenPartnership.com>
Subject: [PATCH v2 0/2] retry handling and intermittent self test failure fix
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Date: Wed, 21 Mar 2018 11:42:27 -0700
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

The original fix for the intermittent self test failure contained a bug
in the retry loop that resent the command with a mangled header.  This
was discovered when coding up the TPM2_RC_RETRY handling, so this two
patch series bases the intermittent self test failure fix on the
working TPM2_RC_RETRY handling code.  This time I actually created an
emulator that sends TPM2_RC_TESTING and verified it does work.

James

---

James Bottomley (2):
  tpm: add retry logic
  tpm: fix intermittent failure with self tests

 drivers/char/tpm/tpm-interface.c | 87 +++++++++++++++++++++++++++++++++-------
 drivers/char/tpm/tpm.h           |  2 +
 drivers/char/tpm/tpm2-cmd.c      | 54 ++++++++-----------------
 3 files changed, 90 insertions(+), 53 deletions(-)

-- 
2.12.3

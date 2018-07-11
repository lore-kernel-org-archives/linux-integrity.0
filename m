Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:56330 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388374AbeGKRQb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Jul 2018 13:16:31 -0400
Message-ID: <1531329074.3260.9.camel@HansenPartnership.com>
Subject: [PATCH] tpm.h: increase poll timings to fix tpm_tis regression
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Nayna Jain <nayna@linux.vnet.ibm.com>
Date: Wed, 11 Jul 2018 10:11:14 -0700
In-Reply-To: <1531328689.3260.8.camel@HansenPartnership.com>
References: <1531328689.3260.8.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

tpm_tis regressed recently to the point where the TPM being driven by
it falls off the bus and cannot be contacted after some hours of use.
This is the failure trace:

jejb@jarvis:~> dmesg|grep tpm
[    3.282605] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0xFE, rev-id 2)
[14566.626614] tpm tpm0: Operation Timed out
[14566.626621] tpm tpm0: tpm2_load_context: failed with a system error -62
[14568.626607] tpm tpm0: tpm_try_transmit: tpm_send: error -62
[14570.626594] tpm tpm0: tpm_try_transmit: tpm_send: error -62
[14570.626605] tpm tpm0: tpm2_load_context: failed with a system error -62
[14572.626526] tpm tpm0: tpm_try_transmit: tpm_send: error -62
[14577.710441] tpm tpm0: tpm_try_transmit: tpm_send: error -62
...

The problem is caused by a change that caused us to poke the TPM far
more often to see if it's ready.  Apparently something about the bus
its on and the TPM means that it crashes or falls off the bus if you
poke it too often and once this happens, only a reboot will recover
it.

The fix I've come up with is to adjust the timings so the TPM no
longer falls of the bus.  Obviously, this fix works for my Nuvoton
NPCT6xxx but that's the only TPM I've tested it with.

Fixes: 424eaf910c32 tpm: reduce polling time to usecs for even finer granularity
Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 drivers/char/tpm/tpm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 8114ea88449f..5d147a8dcca8 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -58,8 +58,8 @@ enum tpm_timeout {
 	TPM_TIMEOUT_RETRY = 100, /* msecs */
 	TPM_TIMEOUT_RANGE_US = 300,	/* usecs */
 	TPM_TIMEOUT_POLL = 1,	/* msecs */
-	TPM_TIMEOUT_USECS_MIN = 100,      /* usecs */
-	TPM_TIMEOUT_USECS_MAX = 500      /* usecs */
+	TPM_TIMEOUT_USECS_MIN = 750,      /* usecs */
+	TPM_TIMEOUT_USECS_MAX = 1000,      /* usecs */
 };
 
 /* TPM addresses */
-- 
2.13.7

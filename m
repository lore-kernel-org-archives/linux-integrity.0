Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from g2t2353.austin.hpe.com ([15.233.44.26]:56651 "EHLO
        g2t2353.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750841AbdJCUsK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Oct 2017 16:48:10 -0400
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2353.austin.hpe.com (Postfix) with ESMTP id 2983C8C
        for <linux-integrity@vger.kernel.org>; Tue,  3 Oct 2017 20:48:10 +0000 (UTC)
From: Guilherme Magalhaes <guilherme.magalhaes@hpe.com>
To: linux-integrity@vger.kernel.org
Cc: Guilherme Magalhaes <guilherme.magalhaes@hpe.com>
Subject: [PATCH] tpm: adjust command response sleep time for vTPM
Date: Tue,  3 Oct 2017 17:46:40 -0300
Message-Id: <20171003204640.62236-1-guilherme.magalhaes@hpe.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Once vTPM is actually a software, it is able to respond the commands much
quicker than physical TPMs. What we propose is to adjust the response
polling time to a usec value when the chip is detected as a vTPM.
With this change, the kernel TPM interface identifies whether the chip is
vTPM and on this case sets the polling sleep time to an optimized value.

The performance result was 12x improvement when comparing PCR extends
using vTPM with the current sleep time and with the adjusted sleep time.
---
 drivers/char/tpm/tpm-interface.c | 6 +++++-
 drivers/char/tpm/tpm.h           | 2 ++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 1d6729be4cd6..d213a3d4b305 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -455,7 +455,11 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
 			goto out;
 		}
 
-		tpm_msleep(TPM_TIMEOUT);
+		if (chip->flags & TPM_CHIP_FLAG_VIRTUAL)
+			usleep_range(TPM_TIMEOUT_VTPM_US, TPM_TIMEOUT_VTPM_RANGE_US);
+		else
+			tpm_msleep(TPM_TIMEOUT);
+
 		rmb();
 	} while (time_before(jiffies, stop));
 
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 2d5466a72e40..02d2dd761543 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -50,6 +50,8 @@ enum tpm_const {
 
 enum tpm_timeout {
 	TPM_TIMEOUT = 5,	/* msecs */
+	TPM_TIMEOUT_VTPM_US = 1,	/* usecs */
+	TPM_TIMEOUT_VTPM_RANGE_US = 5,	/* usecs */
 	TPM_TIMEOUT_RETRY = 100, /* msecs */
 	TPM_TIMEOUT_RANGE_US = 300	/* usecs */
 };
-- 
2.11.0

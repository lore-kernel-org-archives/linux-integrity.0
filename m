Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39378 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753473AbeDQNN4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 Apr 2018 09:13:56 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w3HD9mOr026115
        for <linux-integrity@vger.kernel.org>; Tue, 17 Apr 2018 09:13:56 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2hdekvhc2d-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 17 Apr 2018 09:13:42 -0400
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <nayna@linux.vnet.ibm.com>;
        Tue, 17 Apr 2018 14:12:56 +0100
From: Nayna Jain <nayna@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.vnet.ibm.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterhuewe@gmx.de,
        jarkko.sakkinen@linux.intel.com, tpmdd@selhorst.net,
        jgunthorpe@obsidianresearch.com, patrickc@us.ibm.com,
        Nayna Jain <nayna@linux.vnet.ibm.com>
Subject: [PATCH v2 1/2] tpm: reduce poll sleep time in tpm_transmit()
Date: Tue, 17 Apr 2018 09:12:45 -0400
In-Reply-To: <20180417131246.434-1-nayna@linux.vnet.ibm.com>
References: <20180417131246.434-1-nayna@linux.vnet.ibm.com>
Message-Id: <20180417131246.434-2-nayna@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

The TPM polling code in tpm_transmit sleeps in each loop iteration for
5 msecs. However, the TPM might return earlier, and thus waiting for
5 msecs adds an unnecessary delay. This patch reduces the polling sleep
time in tpm_transmit() from 5 msecs to 1 msecs.

Additionally, this patch renames TPM_POLL_SLEEP and moves it to tpm.h as
an enum value.

After this change, performance on a TPM 1.2 with an 8 byte burstcount
for 1000 extends improved from ~14 sec to ~10.7 sec.

Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>
---
 drivers/char/tpm/tpm-interface.c |  2 +-
 drivers/char/tpm/tpm.h           |  3 ++-
 drivers/char/tpm/tpm_tis_core.c  | 10 ++--------
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 9e80a953d693..a676d8ad5992 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -470,7 +470,7 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
 			goto out;
 		}
 
-		tpm_msleep(TPM_TIMEOUT);
+		tpm_msleep(TPM_TIMEOUT_POLL);
 		rmb();
 	} while (time_before(jiffies, stop));
 
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index f895fba4e20d..7e797377e1eb 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -53,7 +53,8 @@ enum tpm_const {
 enum tpm_timeout {
 	TPM_TIMEOUT = 5,	/* msecs */
 	TPM_TIMEOUT_RETRY = 100, /* msecs */
-	TPM_TIMEOUT_RANGE_US = 300	/* usecs */
+	TPM_TIMEOUT_RANGE_US = 300,	/* usecs */
+	TPM_TIMEOUT_POLL = 1	/* msecs */
 };
 
 /* TPM addresses */
diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index da074e3db19b..021e6b68f2db 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -31,12 +31,6 @@
 #include "tpm.h"
 #include "tpm_tis_core.h"
 
-/* This is a polling delay to check for status and burstcount.
- * As per ddwg input, expectation is that status check and burstcount
- * check should return within few usecs.
- */
-#define TPM_POLL_SLEEP	1  /* msec */
-
 static void tpm_tis_clkrun_enable(struct tpm_chip *chip, bool value);
 
 static bool wait_for_tpm_stat_cond(struct tpm_chip *chip, u8 mask,
@@ -90,7 +84,7 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
 		}
 	} else {
 		do {
-			tpm_msleep(TPM_POLL_SLEEP);
+			tpm_msleep(TPM_TIMEOUT_POLL);
 			status = chip->ops->status(chip);
 			if ((status & mask) == mask)
 				return 0;
@@ -232,7 +226,7 @@ static int get_burstcount(struct tpm_chip *chip)
 		burstcnt = (value >> 8) & 0xFFFF;
 		if (burstcnt)
 			return burstcnt;
-		tpm_msleep(TPM_POLL_SLEEP);
+		tpm_msleep(TPM_TIMEOUT_POLL);
 	} while (time_before(jiffies, stop));
 	return -EBUSY;
 }
-- 
2.13.3

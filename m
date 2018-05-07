Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37934 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752791AbeEGQHw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 7 May 2018 12:07:52 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w47FsSus057386
        for <linux-integrity@vger.kernel.org>; Mon, 7 May 2018 12:07:51 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2htqdgytjt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 07 May 2018 12:07:50 -0400
Received: from localhost
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <nayna@linux.vnet.ibm.com>;
        Mon, 7 May 2018 17:07:49 +0100
From: Nayna Jain <nayna@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.vnet.ibm.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterhuewe@gmx.de,
        jarkko.sakkinen@linux.intel.com, tpmdd@selhorst.net,
        jgunthorpe@obsidianresearch.com, patrickc@us.ibm.com,
        Nayna Jain <nayna@linux.vnet.ibm.com>
Subject: [PATCH v3 1/2] tpm: reduce poll sleep time in tpm_transmit()
Date: Mon,  7 May 2018 12:07:32 -0400
In-Reply-To: <20180507160733.8817-1-nayna@linux.vnet.ibm.com>
References: <20180507160733.8817-1-nayna@linux.vnet.ibm.com>
Message-Id: <20180507160733.8817-2-nayna@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

tpm_try_transmit currently checks TPM status every 5 msecs between
send and recv. It does so in a loop for the maximum timeout as defined
in the TPM Interface Specification. However, the TPM may return before
5 msecs. Thus the polling interval for each iteration can be reduced,
which improves overall performance. This patch changes the polling sleep
time from 5 msecs to 1 msec.

Additionally, this patch renames TPM_POLL_SLEEP to TPM_TIMEOUT_POLL and
moves it to tpm.h as an enum value.

After this change, performance on a system[1] with a TPM 1.2 with an 8 byte
burstcount for 1000 extends improved from ~14 sec to ~10.7 sec.

[1] All tests are performed on an x86 based, locked down, single purpose
closed system. It has Infineon TPM 1.2 using LPC Bus.

Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>
---
 drivers/char/tpm/tpm-interface.c |  2 +-
 drivers/char/tpm/tpm.h           |  3 ++-
 drivers/char/tpm/tpm_tis_core.c  | 10 ++--------
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 6201aab374e6..e32f6e85dc6d 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -489,7 +489,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
 			goto out;
 		}
 
-		tpm_msleep(TPM_TIMEOUT);
+		tpm_msleep(TPM_TIMEOUT_POLL);
 		rmb();
 	} while (time_before(jiffies, stop));
 
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index eedcd9cf30bc..ca05828b6981 100644
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
index 5a1f47b43947..493401f5fd39 100644
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
@@ -234,7 +228,7 @@ static int get_burstcount(struct tpm_chip *chip)
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

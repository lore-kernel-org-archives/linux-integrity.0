Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37664 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934845AbdJQUdC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 Oct 2017 16:33:02 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9HKTvTv034221
        for <linux-integrity@vger.kernel.org>; Tue, 17 Oct 2017 16:33:01 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2dnk89h18h-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 17 Oct 2017 16:33:01 -0400
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <nayna@linux.vnet.ibm.com>;
        Tue, 17 Oct 2017 21:32:59 +0100
From: Nayna Jain <nayna@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.vnet.ibm.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterhuewe@gmx.de,
        jarkko.sakkinen@linux.intel.com, tpmdd@selhorst.net,
        jgunthorpe@obsidianresearch.com, patrickc@us.ibm.com,
        Nayna Jain <nayna@linux.vnet.ibm.com>
Subject: [PATCH v4 3/4] tpm: reduce tpm polling delay in tpm_tis_core
Date: Tue, 17 Oct 2017 16:32:31 -0400
In-Reply-To: <20171017203232.2262-1-nayna@linux.vnet.ibm.com>
References: <20171017203232.2262-1-nayna@linux.vnet.ibm.com>
Message-Id: <20171017203232.2262-4-nayna@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

The existing wait_for_tpm_stat() polls for the chip status after
5msec sleep. As per TCG ddwg input, it is expected that tpm might
return status in few usec. So, reducing the delay in polling to
1msec.
Similarly, get_burstcount() function sleeps for 5msec before
retrying for next query to burstcount in a loop. If it takes
lesser time for TPM to return, this 5msec delay is longer than
necessary.

After this change, performance on a TPM 1.2 with an 8 byte
burstcount for 1000 extends improved from ~14sec to ~9sec.

Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>
---
 drivers/char/tpm/tpm_tis_core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 993328ae988c..8b55fdaa67f2 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -31,6 +31,12 @@
 #include "tpm.h"
 #include "tpm_tis_core.h"
 
+/* This is a polling delay to check for status and burstcount.
+ * As per ddwg input, expectation is that status check and burstcount
+ * check should return within few usecs.
+ */
+#define TPM_POLL_SLEEP	1  /* msec */
+
 static bool wait_for_tpm_stat_cond(struct tpm_chip *chip, u8 mask,
 					bool check_cancel, bool *canceled)
 {
@@ -82,7 +88,7 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
 		}
 	} else {
 		do {
-			tpm_msleep(TPM_TIMEOUT);
+			tpm_msleep(TPM_POLL_SLEEP);
 			status = chip->ops->status(chip);
 			if ((status & mask) == mask)
 				return 0;
@@ -224,7 +230,7 @@ static int get_burstcount(struct tpm_chip *chip)
 		burstcnt = (value >> 8) & 0xFFFF;
 		if (burstcnt)
 			return burstcnt;
-		tpm_msleep(TPM_TIMEOUT);
+		tpm_msleep(TPM_POLL_SLEEP);
 	} while (time_before(jiffies, stop));
 	return -EBUSY;
 }
-- 
2.13.3

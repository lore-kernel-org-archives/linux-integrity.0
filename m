Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33092 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751474AbdJDKbL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 Oct 2017 06:31:11 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v94ATSVO125183
        for <linux-integrity@vger.kernel.org>; Wed, 4 Oct 2017 06:31:11 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2dcwessp77-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 04 Oct 2017 06:31:10 -0400
Received: from localhost
        by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <nayna@linux.vnet.ibm.com>;
        Wed, 4 Oct 2017 20:31:08 +1000
From: Nayna Jain <nayna@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.vnet.ibm.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterhuewe@gmx.de,
        jarkko.sakkinen@linux.intel.com, tpmdd@selhorst.net,
        jgunthorpe@obsidianresearch.com, patrickc@us.ibm.com,
        Nayna Jain <nayna@linux.vnet.ibm.com>
Subject: [PATCH v3 3/5] tpm: reduce polling delay in tpm_tis wait_for_tpm_stat()
Date: Wed,  4 Oct 2017 06:29:22 -0400
In-Reply-To: <20171004102924.12355-1-nayna@linux.vnet.ibm.com>
References: <20171004102924.12355-1-nayna@linux.vnet.ibm.com>
Message-Id: <20171004102924.12355-4-nayna@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

The existing wait_for_tpm_stat() polls for the chip status after
5msec sleep. As per TCG ddwg input, it is expected that tpm might
return status in few usec. So, reducing the delay in polling to
1msec.

After this change, performance on a TPM 1.2 with an 8 byte
burstcount for 1000 extends improved from ~14sec to ~10sec.

Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>
---
 drivers/char/tpm/tpm_tis_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 8da425e1783f..224842e06105 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -31,6 +31,8 @@
 #include "tpm.h"
 #include "tpm_tis_core.h"
 
+#define TPM_POLL_SLEEP	1
+
 static bool wait_for_tpm_stat_cond(struct tpm_chip *chip, u8 mask,
 					bool check_cancel, bool *canceled)
 {
@@ -82,7 +84,7 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
 		}
 	} else {
 		do {
-			tpm_msleep(TPM_TIMEOUT);
+			tpm_msleep(TPM_POLL_SLEEP);
 			status = chip->ops->status(chip);
 			if ((status & mask) == mask)
 				return 0;
-- 
2.13.3

Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60336 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751657AbdJDKaC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 Oct 2017 06:30:02 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v94AT942140504
        for <linux-integrity@vger.kernel.org>; Wed, 4 Oct 2017 06:30:02 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2dcvyxucr1-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 04 Oct 2017 06:30:02 -0400
Received: from localhost
        by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <nayna@linux.vnet.ibm.com>;
        Wed, 4 Oct 2017 20:29:59 +1000
From: Nayna Jain <nayna@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.vnet.ibm.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterhuewe@gmx.de,
        jarkko.sakkinen@linux.intel.com, tpmdd@selhorst.net,
        jgunthorpe@obsidianresearch.com, patrickc@us.ibm.com,
        Nayna Jain <nayna@linux.vnet.ibm.com>
Subject: [PATCH v3 4/5] tpm: reduce tpm_msleep() time in get_burstcount()
Date: Wed,  4 Oct 2017 06:29:23 -0400
In-Reply-To: <20171004102924.12355-1-nayna@linux.vnet.ibm.com>
References: <20171004102924.12355-1-nayna@linux.vnet.ibm.com>
Message-Id: <20171004102924.12355-5-nayna@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Currently, get_burstcount() function sleeps for 5msec in a loop
before retrying for next query to burstcount. However, if it takes
lesser time for TPM to return, this 5msec delay is longer
than necessary.

This patch replaces the tpm_msleep time from 5msec to 1msec.

After this change, performance on a TPM 1.2 with an 8 byte
burstcount for 1000 extends improved from ~10sec to ~9sec.

Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>
Acked-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 drivers/char/tpm/tpm_tis_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 224842e06105..826a0b9c9201 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -226,7 +226,7 @@ static int get_burstcount(struct tpm_chip *chip)
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

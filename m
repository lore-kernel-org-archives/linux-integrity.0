Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34878 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751094AbeFZQ2C (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 Jun 2018 12:28:02 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5QGO2Q8037729
        for <linux-integrity@vger.kernel.org>; Tue, 26 Jun 2018 12:28:01 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jup4a0fwg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 26 Jun 2018 12:28:01 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <gcwilson@linux.ibm.com>;
        Tue, 26 Jun 2018 12:28:01 -0400
From: George Wilson <gcwilson@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>
Subject: [PATCH] ima-evm-utils: check the return code from tpm_pcr_read() in ima_measurement()
Date: Tue, 26 Jun 2018 10:27:18 -0600
Message-Id: <20180626162718.4916-1-gcwilson@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Don't log garbage when neither /sys/class/tpm/tpm0/device/pcrs nor
/sys/class/misc/tpm0/device/pcrs can be read and exit nicely with a
value of 1.

Signed-off-by: George Wilson <gcwilson@linux.ibm.com>
---
 src/evmctl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 2ffee78..a5c6221 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -1514,7 +1514,8 @@ static int ima_measurement(const char *file)
 		log_info("PCRAgg %.2d: ", i);
 		log_dump(pcr[i], SHA_DIGEST_LENGTH);
 
-		tpm_pcr_read(i, hwpcr, sizeof(hwpcr));
+		if (tpm_pcr_read(i, hwpcr, sizeof(hwpcr)))
+			exit(1);
 		log_info("HW PCR-%d: ", i);
 		log_dump(hwpcr, sizeof(hwpcr));
 
-- 
2.17.0.582.gccdcbd5

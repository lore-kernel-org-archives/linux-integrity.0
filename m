Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38618 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751380AbdJDKaK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 Oct 2017 06:30:10 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v94ATFSO094841
        for <linux-integrity@vger.kernel.org>; Wed, 4 Oct 2017 06:30:09 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2dcws70ksh-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 04 Oct 2017 06:30:09 -0400
Received: from localhost
        by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <nayna@linux.vnet.ibm.com>;
        Wed, 4 Oct 2017 20:30:06 +1000
From: Nayna Jain <nayna@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.vnet.ibm.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterhuewe@gmx.de,
        jarkko.sakkinen@linux.intel.com, tpmdd@selhorst.net,
        jgunthorpe@obsidianresearch.com, patrickc@us.ibm.com,
        Nayna Jain <nayna@linux.vnet.ibm.com>
Subject: [PATCH v3 5/5] tpm: use tpm_msleep() value as max delay
Date: Wed,  4 Oct 2017 06:29:24 -0400
In-Reply-To: <20171004102924.12355-1-nayna@linux.vnet.ibm.com>
References: <20171004102924.12355-1-nayna@linux.vnet.ibm.com>
Message-Id: <20171004102924.12355-6-nayna@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Currently, tpm_msleep() uses delay_msec as the minimum value in
usleep_range. However, that is the maximum time we want to wait.
The function is modified to use the delay_msec as the maximum
value, not the minimum value.

After this change, performance on a TPM 1.2 with an 8 byte
burstcount for 1000 extends improved from ~9sec to ~8sec.

Fixes: 3b9af007869("tpm: replace msleep() with usleep_range() in TPM 1.2/
2.0 generic drivers")

Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>
Acked-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 drivers/char/tpm/tpm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 4fc83ac7abeb..644de70de2cc 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -528,8 +528,8 @@ int tpm_pm_resume(struct device *dev);
 
 static inline void tpm_msleep(unsigned int delay_msec)
 {
-	usleep_range(delay_msec * 1000,
-		     (delay_msec * 1000) + TPM_TIMEOUT_RANGE_US);
+	usleep_range((delay_msec * 1000) - TPM_TIMEOUT_RANGE_US,
+		     delay_msec * 1000);
 };
 
 struct tpm_chip *tpm_chip_find_get(int chip_num);
-- 
2.13.3

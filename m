Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42792 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932780AbeB1TTI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 28 Feb 2018 14:19:08 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w1SJJ7mV106348
        for <linux-integrity@vger.kernel.org>; Wed, 28 Feb 2018 14:19:07 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2gdyyspxug-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 28 Feb 2018 14:19:07 -0500
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <nayna@linux.vnet.ibm.com>;
        Wed, 28 Feb 2018 19:18:57 -0000
From: Nayna Jain <nayna@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.vnet.ibm.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterhuewe@gmx.de,
        jarkko.sakkinen@linux.intel.com, tpmdd@selhorst.net,
        jgunthorpe@obsidianresearch.com, patrickc@us.ibm.com,
        Nayna Jain <nayna@linux.vnet.ibm.com>
Subject: [RFC PATCH 3/3] tpm: tpm_msleep() with finer granularity improves performance
Date: Wed, 28 Feb 2018 14:18:28 -0500
In-Reply-To: <20180228191828.20056-1-nayna@linux.vnet.ibm.com>
References: <20180228191828.20056-1-nayna@linux.vnet.ibm.com>
Message-Id: <20180228191828.20056-3-nayna@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

When 'commit 9f3fc7bcddcb ("tpm: replace msleep() with  usleep_range()
in TPM 1.2/2.0 generic drivers")' was upstreamed, it replaced the
msleep() calls with usleep_range(), but did not change the
granularity of the calls. They're still defined in terms of msec.
Test results show that refining the granularity further improves
the performance. We're posting this patch as an RFC to show that there
needs to be another function which allows finer granularity.

After this change, performance on a TPM 1.2 with an 8 byte
burstcount for 1000 extends improved from ~10.7sec to ~6.9sec.

Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>
---
 drivers/char/tpm/tpm.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 7e797377e1eb..8cad6bfc5f46 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -522,8 +522,7 @@ int tpm_pm_resume(struct device *dev);
 
 static inline void tpm_msleep(unsigned int delay_msec)
 {
-	usleep_range((delay_msec * 1000) - TPM_TIMEOUT_RANGE_US,
-		     delay_msec * 1000);
+	usleep_range((delay_msec * 1000) / 10, (delay_msec * 1000) / 2);
 };
 
 struct tpm_chip *tpm_chip_find_get(struct tpm_chip *chip);
-- 
2.13.3

Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18229 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754442AbeFTQUG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Jun 2018 12:20:06 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5KGEEgA083239
        for <linux-integrity@vger.kernel.org>; Wed, 20 Jun 2018 12:20:05 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jqsbntr19-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 20 Jun 2018 12:20:05 -0400
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <stefanb@linux.vnet.ibm.com>;
        Wed, 20 Jun 2018 10:20:04 -0600
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com,
        zohar@linux.vnet.ibm.com
Cc: jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH 4/6] ima: Implement ima_shutdown and register it as a reboot_notifier
Date: Wed, 20 Jun 2018 12:19:46 -0400
In-Reply-To: <20180620161948.1464255-1-stefanb@linux.vnet.ibm.com>
References: <20180620161948.1464255-1-stefanb@linux.vnet.ibm.com>
Message-Id: <20180620161948.1464255-5-stefanb@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Implement ima_shutdown so that we can release the tpm_chip before
devices are shut down. Register it as a low-priority reboot_notifier.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 security/integrity/ima/ima_init.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index 29b72cd2502e..8a5258eb32b6 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -21,6 +21,7 @@
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
 #include <linux/err.h>
+#include <linux/reboot.h>
 
 #include "ima.h"
 
@@ -104,11 +105,24 @@ void __init ima_load_x509(void)
 }
 #endif
 
+static int ima_shutdown(struct notifier_block *this, unsigned long action,
+			void *data)
+{
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block ima_reboot_notifier = {
+	.notifier_call = ima_shutdown,
+	.priority = 0,
+};
+
 int __init ima_init(void)
 {
 	u8 pcr_i[TPM_DIGEST_SIZE];
 	int rc;
 
+	register_reboot_notifier(&ima_reboot_notifier);
+
 	ima_used_chip = 0;
 	rc = tpm_pcr_read(NULL, 0, pcr_i);
 	if (rc == 0)
-- 
2.13.6

Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58862 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751647AbeDBQVw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 2 Apr 2018 12:21:52 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w32GKRwC126079
        for <linux-integrity@vger.kernel.org>; Mon, 2 Apr 2018 12:21:52 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2h3ks8kd8w-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 02 Apr 2018 12:21:51 -0400
Received: from localhost
        by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <nayna@linux.vnet.ibm.com>;
        Mon, 2 Apr 2018 17:21:50 +0100
From: Nayna Jain <nayna@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.vnet.ibm.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterhuewe@gmx.de,
        jarkko.sakkinen@linux.intel.com, tpmdd@selhorst.net,
        jgunthorpe@obsidianresearch.com,
        Nayna Jain <nayna@linux.vnet.ibm.com>
Subject: [PATCH] tpm: moves the delay_msec increment after sleep in tpm_transmit() 
Date: Mon,  2 Apr 2018 21:50:06 +0530
Message-Id: <20180402162006.5030-1-nayna@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Commit e2fb992d82c6 ("tpm: add retry logic") introduced a new loop to
handle the TPM2_RC_RETRY error. The loop retries the command after
sleeping for the specified time, which is incremented exponentially in
every iteration. This patch fixes the initial sleep to be the default
sleep time.

Fixes: commit e2fb992d82c6 ("tpm: add retry logic")
Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>
Reviewed-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 drivers/char/tpm/tpm-interface.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index c43a9e28995e..6201aab374e6 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -587,7 +587,7 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
 		 */
 		if (rc == TPM2_RC_TESTING && cc == TPM2_CC_SELF_TEST)
 			break;
-		delay_msec *= 2;
+
 		if (delay_msec > TPM2_DURATION_LONG) {
 			if (rc == TPM2_RC_RETRY)
 				dev_err(&chip->dev, "in retry loop\n");
@@ -597,6 +597,7 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
 			break;
 		}
 		tpm_msleep(delay_msec);
+		delay_msec *= 2;
 		memcpy(buf, save, save_size);
 	}
 	return ret;
-- 
2.13.6

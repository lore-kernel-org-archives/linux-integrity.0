Return-Path: <SRS0=e5UK=OX=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3A2C67839
	for <linux-integrity@archiver.kernel.org>; Fri, 14 Dec 2018 13:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C5D420C85
	for <linux-integrity@archiver.kernel.org>; Fri, 14 Dec 2018 13:21:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C5D420C85
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729728AbeLNNVS (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 14 Dec 2018 08:21:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45930 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729641AbeLNNVS (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 14 Dec 2018 08:21:18 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E4AF23082138;
        Fri, 14 Dec 2018 13:21:17 +0000 (UTC)
Received: from rtux.redhat.com (unknown [10.33.36.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8113B5D717;
        Fri, 14 Dec 2018 13:21:16 +0000 (UTC)
From:   Alexey Klimov <aklimov@redhat.com>
To:     linux-integrity@vger.kernel.org
Cc:     jsnitsel@redhat.com, jarkko.sakkinen@linux.intel.com,
        peterhuewe@gmx.de, jgg@ziepe.ca, aklimov@redhat.com
Subject: [PATCH REVIEW 1/2] tpm: provide a way to override the chip returned durations
Date:   Fri, 14 Dec 2018 13:21:14 +0000
Message-Id: <20181214132115.26223-1-aklimov@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 14 Dec 2018 13:21:18 +0000 (UTC)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Patch adds method ->update_durations to override returned
durations in case TPM chip misbehaves for TPM 1.2 drivers.

Cc: Jerry Snitselaar <jsnitsel@redhat.com>
Signed-off-by: Alexey Klimov <aklimov@redhat.com>
---
 drivers/char/tpm/tpm-interface.c | 18 ++++++++++++++++++
 include/linux/tpm.h              |  2 ++
 2 files changed, 20 insertions(+)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 129f640424b7..5cb90918938d 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -768,6 +768,7 @@ int tpm_get_timeouts(struct tpm_chip *chip)
 {
 	cap_t cap;
 	unsigned long timeout_old[4], timeout_chip[4], timeout_eff[4];
+	unsigned long durations[3];
 	ssize_t rc;
 
 	if (chip->flags & TPM_CHIP_FLAG_HAVE_TIMEOUTS)
@@ -877,6 +878,23 @@ int tpm_get_timeouts(struct tpm_chip *chip)
 		usecs_to_jiffies(be32_to_cpu(cap.duration.tpm_long));
 	chip->duration[TPM_LONG_LONG] = 0; /* not used under 1.2 */
 
+	/*
+	 * Provide ability for vendor overrides of duration values in case
+	 * of misreporting.
+	 */
+	if (chip->ops->update_durations != NULL)
+		chip->duration_adjusted =
+			chip->ops->update_durations(chip, durations);
+
+	/* Report and set adjusted timeouts */
+	if (chip->duration_adjusted) {
+
+		dev_info(&chip->dev, HW_ERR "Adjusting reported durations\n");
+		chip->duration[TPM_SHORT] = durations[0];
+		chip->duration[TPM_MEDIUM] = durations[1];
+		chip->duration[TPM_LONG] = durations[2];
+	}
+
 	/* The Broadcom BCM0102 chipset in a Dell Latitude D820 gets the above
 	 * value wrong and apparently reports msecs rather than usecs. So we
 	 * fix up the resulting too-small TPM_SHORT value to make things work.
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 4609b94142d4..d6018431b478 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -43,6 +43,8 @@ struct tpm_class_ops {
 	u8 (*status) (struct tpm_chip *chip);
 	bool (*update_timeouts)(struct tpm_chip *chip,
 				unsigned long *timeout_cap);
+	bool (*update_durations)(struct tpm_chip *chip,
+				unsigned long *durations_cap);
 	int (*go_idle)(struct tpm_chip *chip);
 	int (*cmd_ready)(struct tpm_chip *chip);
 	int (*request_locality)(struct tpm_chip *chip, int loc);
-- 
2.14.4


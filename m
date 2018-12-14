Return-Path: <SRS0=e5UK=OX=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36429C6786C
	for <linux-integrity@archiver.kernel.org>; Fri, 14 Dec 2018 13:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06B4E208E7
	for <linux-integrity@archiver.kernel.org>; Fri, 14 Dec 2018 13:21:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06B4E208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729815AbeLNNVT (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 14 Dec 2018 08:21:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57508 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729641AbeLNNVT (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 14 Dec 2018 08:21:19 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 662CD356E7;
        Fri, 14 Dec 2018 13:21:19 +0000 (UTC)
Received: from rtux.redhat.com (unknown [10.33.36.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2D4F85D762;
        Fri, 14 Dec 2018 13:21:18 +0000 (UTC)
From:   Alexey Klimov <aklimov@redhat.com>
To:     linux-integrity@vger.kernel.org
Cc:     jsnitsel@redhat.com, jarkko.sakkinen@linux.intel.com,
        peterhuewe@gmx.de, jgg@ziepe.ca, aklimov@redhat.com
Subject: [PATCH REVIEW 2/2] tpm_tis: override durations for STM tpm with firmware 1.2.8.28
Date:   Fri, 14 Dec 2018 13:21:15 +0000
Message-Id: <20181214132115.26223-2-aklimov@redhat.com>
In-Reply-To: <20181214132115.26223-1-aklimov@redhat.com>
References: <20181214132115.26223-1-aklimov@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 14 Dec 2018 13:21:19 +0000 (UTC)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

There was revealed a bug in the STM TPM chipset used in Dell R415s.
Bug is observed so far only on chipset firmware 1.2.8.28
(1.2 TPM, device-id 0x0, rev-id 78). After some number of
operations chipset hangs and stays in inconsistent state:

tpm_tis 00:09: Operation Timed out
tpm_tis 00:09: tpm_transmit: tpm_send: error -5

Durations returned by the chip are the same like on other
firmware revisions but apparently with specifically 1.2.8.28 fw
durations should be reset to 2 minutes to enable tpm chip work
properly. No working way of updating firmware was found.

This patch adds implementation of ->update_durations method
that matches only STM devices with specific firmware version.

Cc: Jerry Snitselaar <jsnitsel@redhat.com>
Signed-off-by: Alexey Klimov <aklimov@redhat.com>
---
 drivers/char/tpm/tpm_tis_core.c | 90 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index d2345d9fd7b5..e0bdca647460 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -514,6 +514,95 @@ static int tpm_tis_send(struct tpm_chip *chip, u8 *buf, size_t len)
 	return rc;
 }
 
+struct tis_vendor_durations_override {
+	u32 did_vid;
+	struct tpm_version_t tpm_version;
+	unsigned long durs[3];
+};
+
+static
+const struct tis_vendor_durations_override vendor_dur_overrides[] = {
+	/* STMicroelectronics 0x104a */
+	{ 0x0000104A,
+	{ 1, 2, 8, 28 },
+	{ (2 * 60 * HZ), (2 * 60 * HZ), (2 * 60 * HZ) } },
+};
+
+static bool tpm_tis_update_durations(struct tpm_chip *chip,
+					unsigned long *duration_cap)
+{
+	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
+	u32 did_vid;
+	int i, rc;
+	cap_t cap;
+
+	if (chip->ops->clk_enable != NULL)
+		chip->ops->clk_enable(chip, true);
+
+	rc = tpm_tis_read32(priv, TPM_DID_VID(0), &did_vid);
+	if (rc < 0)
+		goto out;
+
+	for (i = 0; i != ARRAY_SIZE(vendor_dur_overrides); i++) {
+		if (vendor_dur_overrides[i].did_vid != did_vid)
+			continue;
+
+		/* Try to get a TPM version 1.2 TPM_CAP_VERSION_INFO */
+		rc = tpm_getcap(chip, TPM_CAP_VERSION_1_2, &cap,
+			"attempting to determine the 1.2 version",
+			sizeof(cap.tpm_version_1_2));
+		if (!rc) {
+			if ((cap.tpm_version_1_2.Major ==
+				vendor_dur_overrides[i].tpm_version.Major) &&
+				(cap.tpm_version_1_2.Minor ==
+				vendor_dur_overrides[i].tpm_version.Minor) &&
+				(cap.tpm_version_1_2.revMajor ==
+				vendor_dur_overrides[i].tpm_version.revMajor) &&
+				(cap.tpm_version_1_2.revMinor ==
+				vendor_dur_overrides[i].tpm_version.revMinor)) {
+
+				memcpy(duration_cap,
+					vendor_dur_overrides[i].durs,
+					sizeof(vendor_dur_overrides[i].durs));
+				rc = true;
+				goto out;
+			}
+		} else {
+			rc = tpm_getcap(chip, TPM_CAP_VERSION_1_1, &cap,
+				"attempting to determine the 1.1 version",
+				sizeof(cap.tpm_version));
+			if (rc) {
+				rc = false;
+				goto out;
+			}
+			if ((cap.tpm_version.Major ==
+				vendor_dur_overrides[i].tpm_version.Major) &&
+				(cap.tpm_version.Minor ==
+				vendor_dur_overrides[i].tpm_version.Minor) &&
+				(cap.tpm_version.revMajor ==
+				vendor_dur_overrides[i].tpm_version.revMajor) &&
+				(cap.tpm_version.revMinor ==
+				vendor_dur_overrides[i].tpm_version.revMinor)) {
+
+				memcpy(duration_cap,
+					vendor_dur_overrides[i].durs,
+					sizeof(vendor_dur_overrides[i].durs));
+				rc = true;
+				goto out;
+			}
+		}
+	}
+
+	rc = false;
+
+out:
+	if (chip->ops->clk_enable != NULL)
+		chip->ops->clk_enable(chip, false);
+
+	return rc;
+}
+
+
 struct tis_vendor_timeout_override {
 	u32 did_vid;
 	unsigned long timeout_us[4];
@@ -847,6 +936,7 @@ static const struct tpm_class_ops tpm_tis = {
 	.send = tpm_tis_send,
 	.cancel = tpm_tis_ready,
 	.update_timeouts = tpm_tis_update_timeouts,
+	.update_durations = tpm_tis_update_durations,
 	.req_complete_mask = TPM_STS_DATA_AVAIL | TPM_STS_VALID,
 	.req_complete_val = TPM_STS_DATA_AVAIL | TPM_STS_VALID,
 	.req_canceled = tpm_tis_req_canceled,
-- 
2.14.4


Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:35863 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932475AbeEIANC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 May 2018 20:13:02 -0400
From: Ji-Hun Kim <ji_hun.kim@samsung.com>
To: peterhuewe@gmx.de, tweek@google.com
Cc: jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca, arnd@arndb.de,
        gregkh@linuxfoundation.org, javierm@redhat.com,
        sonnyrao@chromium.org, ji_hun.kim@samsung.com,
        enric.balletbo@collabora.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 1/2] tpm: replace kmalloc() + memcpy() with kmemdup()
Date: Wed, 09 May 2018 09:12:36 +0900
Message-id: <1525824757-21835-1-git-send-email-ji_hun.kim@samsung.com>
References: <CGME20180509001258epcas1p4e8db163d8babd90284dd6afb6a96eb0f@epcas1p4.samsung.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Use kmemdup rather than duplicating its implementation.

Signed-off-by: Ji-Hun Kim <ji_hun.kim@samsung.com>
---
 drivers/char/tpm/eventlog/of.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/char/tpm/eventlog/of.c b/drivers/char/tpm/eventlog/of.c
index b7cac47..bba5fba 100644
--- a/drivers/char/tpm/eventlog/of.c
+++ b/drivers/char/tpm/eventlog/of.c
@@ -69,14 +69,12 @@ int tpm_read_log_of(struct tpm_chip *chip)
 		return -EIO;
 	}
 
-	log->bios_event_log = kmalloc(size, GFP_KERNEL);
+	log->bios_event_log = kmemdup(__va(base), size, GFP_KERNEL);
 	if (!log->bios_event_log)
 		return -ENOMEM;
 
 	log->bios_event_log_end = log->bios_event_log + size;
 
-	memcpy(log->bios_event_log, __va(base), size);
-
 	if (chip->flags & TPM_CHIP_FLAG_TPM2)
 		return EFI_TCG2_EVENT_LOG_FORMAT_TCG_2;
 	return EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2;
-- 
1.9.1

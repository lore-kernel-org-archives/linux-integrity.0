Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:12893 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932593AbeEIAND (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 May 2018 20:13:03 -0400
From: Ji-Hun Kim <ji_hun.kim@samsung.com>
To: peterhuewe@gmx.de, tweek@google.com
Cc: jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca, arnd@arndb.de,
        gregkh@linuxfoundation.org, javierm@redhat.com,
        sonnyrao@chromium.org, ji_hun.kim@samsung.com,
        enric.balletbo@collabora.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 2/2] tpm: replace kmalloc() + memcpy() with kmemdup()
Date: Wed, 09 May 2018 09:12:37 +0900
Message-id: <1525824757-21835-2-git-send-email-ji_hun.kim@samsung.com>
In-reply-to: <1525824757-21835-1-git-send-email-ji_hun.kim@samsung.com>
References: <1525824757-21835-1-git-send-email-ji_hun.kim@samsung.com>
        <CGME20180509001300epcas2p3971900d48408aef6a80f59b9480aac16@epcas2p3.samsung.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Use kmemdup rather than duplicating its implementation.

Signed-off-by: Ji-Hun Kim <ji_hun.kim@samsung.com>
---
 drivers/char/tpm/eventlog/efi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/char/tpm/eventlog/efi.c b/drivers/char/tpm/eventlog/efi.c
index 68f1e7e..3e673ab 100644
--- a/drivers/char/tpm/eventlog/efi.c
+++ b/drivers/char/tpm/eventlog/efi.c
@@ -51,10 +51,9 @@ int tpm_read_log_efi(struct tpm_chip *chip)
 	}
 
 	/* malloc EventLog space */
-	log->bios_event_log = kmalloc(log_size, GFP_KERNEL);
+	log->bios_event_log = kmemdup(log_tbl->log, log_size, GFP_KERNEL);
 	if (!log->bios_event_log)
 		goto err_memunmap;
-	memcpy(log->bios_event_log, log_tbl->log, log_size);
 	log->bios_event_log_end = log->bios_event_log + log_size;
 
 	tpm_log_version = log_tbl->version;
-- 
1.9.1

Return-Path: <SRS0=a4os=QS=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55615C169C4
	for <linux-integrity@archiver.kernel.org>; Mon, 11 Feb 2019 21:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 235E421855
	for <linux-integrity@archiver.kernel.org>; Mon, 11 Feb 2019 21:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tEJjNaLX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbfBKVza (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 11 Feb 2019 16:55:30 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:50348 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfBKVza (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 11 Feb 2019 16:55:30 -0500
Received: by mail-pl1-f201.google.com with SMTP id v16so341955plo.17
        for <linux-integrity@vger.kernel.org>; Mon, 11 Feb 2019 13:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=q6kHGtuoUsiwGY5sETWJIfCiAVLYldqNUnuro8SqLhY=;
        b=tEJjNaLX8nTahSSMRiPQVI2a6hMLsGIrFwS01rA7tTn/tZZh0Is77mPki8On1DigQd
         c4ZyCZetB7GLOSiF31L7bIi0QXnZzSxLU2ByRG2KB1N5i47DbbnHEX8vuI2VlwIXG454
         iZ+MXOnMS3XS1Oed5XhbymCR7Tm6zW7zcBKK5+oqYRaDKQeS9GGXiWGm1RwL+dG2deiV
         yyOVzN5PZhnlHV11YBnA3o+laG63vQhENGfXONeXAf8F6VBibWY1yYdEVcpWcy542OI9
         DL/h4iQREwwN8r6G8/ewWa1TBAenwkg1tDgp1XMiGQRic3+VShI8SfIPDZlJ4TDWic3+
         i7lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=q6kHGtuoUsiwGY5sETWJIfCiAVLYldqNUnuro8SqLhY=;
        b=KvEHEd00+w1DoJya7QGJPT6JKt0YPjDCSpH6dpWOoIg3aHALaLF/aAPdbzYcZgNpIY
         fvD/qtrmPftMzMJxVsxZ+y0QQ2vKu6fO/XH9tWp2c0eKLvwgKeBpF57zggjAZ5IJN26I
         dnZgrZWQB3vrrD0VV/9RUISqYtWXPTxM/HUZ7I5WfnMFOIB4bje+oQ4LoVfU558RIfDU
         vtrrS5VVZHZpv3yokKdS7pGVixHSGZEzlxc7DoZ8nVrByJ4XpOrEiZlEpNqUunW54eLI
         VTqxD0JE0y5e8vyzD++HKn8+jrCf5B9/XTmiWWanbaTeTt1eFq2QbBZiTCeXrzS2O9Ux
         xNIQ==
X-Gm-Message-State: AHQUAuaTKS+HiWDcPpmuDyXoNNt/TEJ6kN1qLCSehjkU1a3CPMNp6HdL
        VRpflbqDx/tXigX2AijFtftsGM6zE7UnZ1Ok3oG0teBfXaHAOhM63LO8lXHuI0o94ybIwKM/DJ6
        NNjXCfjrgeCMbJaEQMTsV6aIBuHDsxuX+DKaNMEt9Iv4Lyv0PTn1eiyL+2u3FpNy+iMy1xCZOLO
        cZpSfI66Ersf+q04nH0/s=
X-Google-Smtp-Source: AHgI3IYYBs5BfwY360LcHQQv8pvFdhgXDN/ewuPamCZuNqLg1/m0rq+XN++1N3Y34hkCCoHKqdr38cUTOBFswabRFnTULQ==
X-Received: by 2002:a63:8dca:: with SMTP id z193mr209373pgd.124.1549922129991;
 Mon, 11 Feb 2019 13:55:29 -0800 (PST)
Date:   Mon, 11 Feb 2019 13:55:17 -0800
In-Reply-To: <20190211215518.81419-1-matthewgarrett@google.com>
Message-Id: <20190211215518.81419-4-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190211215518.81419-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.20.1.791.gb4d0f1c61a-goog
Subject: [PATCH V3 3/4] tpm: Append the final event log to the TPM event log
From:   Matthew Garrett <matthewgarrett@google.com>
To:     linux-integrity@vger.kernel.org
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        roberto.sassu@huawei.com, Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Matthew Garrett <mjg59@google.com>

Any events that are logged after GetEventsLog() is called are logged to
the EFI Final Events table. These events are defined as being in the
crypto agile log format, so we can just append them directly to the
existing log if it's in the same format. In theory we can also construct
old-style SHA1 log entries for devices that only return logs in that
format, but EDK2 doesn't generate the final event log in that case so
it doesn't seem worth it at the moment.

Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 drivers/char/tpm/eventlog/efi.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/eventlog/efi.c b/drivers/char/tpm/eventlog/efi.c
index 3e673ab22cb4..80e9ec28a9be 100644
--- a/drivers/char/tpm/eventlog/efi.c
+++ b/drivers/char/tpm/eventlog/efi.c
@@ -21,10 +21,12 @@
 int tpm_read_log_efi(struct tpm_chip *chip)
 {
 
+	struct efi_tcg2_final_events_table *final_tbl = NULL;
 	struct linux_efi_tpm_eventlog *log_tbl;
 	struct tpm_bios_log *log;
 	u32 log_size;
 	u8 tpm_log_version;
+	void *tmp;
 
 	if (!(chip->flags & TPM_CHIP_FLAG_TPM2))
 		return -ENODEV;
@@ -55,12 +57,41 @@ int tpm_read_log_efi(struct tpm_chip *chip)
 	if (!log->bios_event_log)
 		goto err_memunmap;
 	log->bios_event_log_end = log->bios_event_log + log_size;
-
 	tpm_log_version = log_tbl->version;
+
+	if (efi.tpm_final_log != EFI_INVALID_TABLE_ADDR &&
+	    efi_tpm_final_log_size != 0) {
+		if (tpm_log_version == EFI_TCG2_EVENT_LOG_FORMAT_TCG_2) {
+			final_tbl = memremap(efi.tpm_final_log,
+				   sizeof(*final_tbl) + efi_tpm_final_log_size,
+				   MEMREMAP_WB);
+			if (!final_tbl) {
+				pr_err("Could not map UEFI TPM final log\n");
+				kfree(log->bios_event_log);
+				goto err_memunmap;
+			}
+
+			tmp = krealloc(log->bios_event_log,
+				       log_size + efi_tpm_final_log_size,
+				       GFP_KERNEL);
+			if (!tmp) {
+				kfree(log->bios_event_log);
+				goto err_memunmap;
+			}
+
+			log->bios_event_log = tmp;
+			memcpy((void *)log->bios_event_log + log_size,
+			       final_tbl->events, efi_tpm_final_log_size);
+			log->bios_event_log_end = log->bios_event_log +
+				log_size + efi_tpm_final_log_size;
+		}
+	}
+	memunmap(final_tbl);
 	memunmap(log_tbl);
 	return tpm_log_version;
 
 err_memunmap:
+	memunmap(final_tbl);
 	memunmap(log_tbl);
 	return -ENOMEM;
 }
-- 
2.20.1.791.gb4d0f1c61a-goog


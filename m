Return-Path: <SRS0=d4Rs=PR=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83945C43387
	for <linux-integrity@archiver.kernel.org>; Wed,  9 Jan 2019 01:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5510F20883
	for <linux-integrity@archiver.kernel.org>; Wed,  9 Jan 2019 01:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AhnEYhGn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbfAIBtE (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 8 Jan 2019 20:49:04 -0500
Received: from mail-yw1-f73.google.com ([209.85.161.73]:52980 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729102AbfAIBtE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Jan 2019 20:49:04 -0500
Received: by mail-yw1-f73.google.com with SMTP id v131so3119866ywb.19
        for <linux-integrity@vger.kernel.org>; Tue, 08 Jan 2019 17:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=a2/g6WvX/TfCcgWUWv30CCvvLsF3HVjVhKobZPS9laM=;
        b=AhnEYhGn0oQbQJID7WRlTTTXprjANm8bo9i6Py0XZv04H5ZBDBr7QW8EgAqxcxURw3
         uU9r8f2DXSgNTG72JV2L0qAJPqRT6MXBFBGxWLEPmZKcbJVqzky5SqldFq/GgZikYTXE
         zUnlKM8KLIywWQZQQRfVRQl7DO7VWhtQX0hpcaRRQKlpebvtuFUEhfcPxPyuB7S9bPqv
         YSoBdefDQ9KrJ+iR9Qq+smpDFW3FFVa9T1s5YS8Bpq1Ygwaf58lFxGcxKUByhyFy1AyE
         lZePF022cJZ430LH2QFtqogNOcizxT/4W2y5YkEe0JGadplf9I9ETN7cjSv4MHIthB1P
         2Awg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=a2/g6WvX/TfCcgWUWv30CCvvLsF3HVjVhKobZPS9laM=;
        b=Eq0CkOqb7lOTP7bH/k+o8jirlVQzKnPCJOykBzytYvPW9eTlMgZYaKPiiFuYObl6Sm
         Q5XNnM09Nxxz8hiCcG+YPS3JUwTbIFp+KZABSJ92QFmPl/ykDxontqI0A92kvy/Jf0ZT
         z1z/ekLULxdAc/D3i77sb80Kh4DggF0WW4mUJHQ0aZh9x3NCmJjoYAZm3NXl7MGf24Hl
         6xr81dOX1Pg04hBljYwBXxU8rMOmRo/1RiclUAwbgR0ZdFM0Z3E/s3iIRI+vYkWpOZGV
         O6QK7pnrgc3pACU8We0/0KH5FkvTQlmisdf8+RunumgUrTRJ8bpLoWocc5LxotuGvXnC
         RJhA==
X-Gm-Message-State: AJcUukfiC16vpCoi1cjsZls55rr4dXvx+ysw+Kb3Xrt9mwLS6SVl3ZBQ
        QmJdgssOVWCra3yJ/4oNNF41bM7Du7rgGS3ppHnpWnUkhRCwoVzxj0UQptkN6LTJrOYjejUkBhN
        JwZwxafj1qgAmilwrggevVWkQ+Zpuoh64n2xEQH0N2WgGEe92K02bwy9VRyile83uWN9M/2ca1O
        OMschzdn6DGa2z8z6LQYI=
X-Google-Smtp-Source: ALg8bN45HWGCMnksZOzdN/vo4fTpb2i12uLDvxaFFPK/Xph571Cs6roj8t9fCfpiNOAvw7SVVG3BNv3+tSHJQ2IB3FF3VQ==
X-Received: by 2002:a5b:c:: with SMTP id a12mr1914054ybp.18.1546998542803;
 Tue, 08 Jan 2019 17:49:02 -0800 (PST)
Date:   Tue,  8 Jan 2019 17:48:46 -0800
In-Reply-To: <20190109014847.39980-1-matthewgarrett@google.com>
Message-Id: <20190109014847.39980-5-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190109014847.39980-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
Subject: [PATCH 4/5] tpm: Append the final event log to the TPM event log
From:   Matthew Garrett <matthewgarrett@google.com>
To:     linux-integrity@vger.kernel.org
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        Matthew Garrett <mjg59@google.com>
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
2.20.1.97.g81188d93c3-goog


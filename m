Return-Path: <SRS0=H4GS=QL=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C48C282CB
	for <linux-integrity@archiver.kernel.org>; Mon,  4 Feb 2019 21:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 280AE2083B
	for <linux-integrity@archiver.kernel.org>; Mon,  4 Feb 2019 21:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LvrbOnu7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725952AbfBDVdP (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 4 Feb 2019 16:33:15 -0500
Received: from mail-yb1-f202.google.com ([209.85.219.202]:39884 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbfBDVdO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 4 Feb 2019 16:33:14 -0500
Received: by mail-yb1-f202.google.com with SMTP id x11so288525ybp.6
        for <linux-integrity@vger.kernel.org>; Mon, 04 Feb 2019 13:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jiJbGG2eTAgdEhFPhBeLSv9aZNZ48nNzk4yHYLfD/9k=;
        b=LvrbOnu7Knh+fE/QTdhBHJ4M0clQhBoNgPbeOTk2ogQd1WuLDXhjA4aTDw2PmSjNA8
         WvMHuXzggBwcQlG//tjEzYdDBL5yaThNr0MQQP3R/UBiP095EUKophN55bnst0YcBOGo
         h2GktAmLjcwirGHVvK4//BGWh2a7J7Y2jJy8VH7zoruvoz3mkrrgFazu4VfEtBUaafRD
         8auLhQ+s6h4zrj9JFVChhDp0yST+1SqgTdClYyzsXe6PLRUuEcyR6YdrGB90RtWpJO43
         SZxwd3vlxn6HphYXhFHUv7CuZUG5JX3LsE7DgJ9OUe7wKM+wxNJhDBHMlJTnva3+JDwi
         K9lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jiJbGG2eTAgdEhFPhBeLSv9aZNZ48nNzk4yHYLfD/9k=;
        b=L5Y5MA/Hym7o2WWdh4bcXHaXOC/EDkg0EzS6JGmcUDfyKc7cOxfdEU2JUP5cVuzS7I
         /1L1LLsrVBRjWlSvohOw41JB0abp+YEW+czXMt7J3xatZX7k2dcd8TKvLXsv7aHYSLf/
         pgdwsCyI2WIWr2nMZL7vWNgtT2yRlN5ogkSQ9jcAlys33iveUaPLWqOlCbnpJyGbMKge
         8QR56WKGuD8IBx83A8s6btytujsI2cKLyMtMk1IwqfPgQMcA6i0+tPXkppJcK+owmPCb
         sWjpBlNz8dMtjcBq13WBzycz6Cs5GuU/mcqAMyinO5m7PtWqfMfwGErkmZ8ibNLacxvg
         VnvQ==
X-Gm-Message-State: AHQUAuYjP+WhnqoD1PIuIG8HWzgAlL6SWTw7C9lPp9pJ3lsoC9E2g7iA
        BAEF3yiko+v5J4mZjLNkD96yvxR8cXEMUTLC+8xHEzAqZaEEVoB+t3R+eJv0xdIrDhkzzadzUo8
        zjnRD2DftOC0eIBiMFWQGqAlc9H1CWPOIypg/xjvv1Z1SRdkWgym4zZewP1XqdO6/LAj4EuzBeG
        GCKU0VrBAp6FH+sUkmC50=
X-Google-Smtp-Source: AHgI3IZ9rR2MaRD3GuyNA9VqdMrThqTVp5hdms/Szs6BTeMljpbiH3SiVbH64DX9xuqRSBuWbVPG+3bKBwpEvEdb429QgQ==
X-Received: by 2002:a25:4149:: with SMTP id o70mr692676yba.59.1549315993596;
 Mon, 04 Feb 2019 13:33:13 -0800 (PST)
Date:   Mon,  4 Feb 2019 13:33:01 -0800
In-Reply-To: <20190204213303.131064-1-matthewgarrett@google.com>
Message-Id: <20190204213303.131064-3-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190204213303.131064-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.20.1.611.gfbb209baf1-goog
Subject: [PATCH V2 2/4] tpm: Reserve the TPM final events table
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

UEFI systems provide a boot services protocol for obtaining the TPM
event log, but this is unusable after ExitBootServices() is called.
Unfortunately ExitBootServices() itself triggers additional TPM events
that then can't be obtained using this protocol. The platform provides a
mechanism for the OS to obtain these events by recording them to a
separate UEFI configuration table which the OS can then map.

Unfortunately this table isn't self describing in terms of providing its
length, so we need to parse the events inside it to figure out how long
it is. Since the table isn't mapped at this point, we need to extend the
length calculation function to be able to map the event as it goes
along.

Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 drivers/char/tpm/eventlog/tpm2.c |  2 +-
 drivers/firmware/efi/efi.c       |  2 +
 drivers/firmware/efi/tpm.c       | 67 ++++++++++++++++++----
 include/linux/efi.h              |  9 +++
 include/linux/tpm_eventlog.h     | 98 +++++++++++++++++++++++++++++---
 5 files changed, 160 insertions(+), 18 deletions(-)

diff --git a/drivers/char/tpm/eventlog/tpm2.c b/drivers/char/tpm/eventlog/tpm2.c
index 89a8b1c10939..54976643ea2d 100644
--- a/drivers/char/tpm/eventlog/tpm2.c
+++ b/drivers/char/tpm/eventlog/tpm2.c
@@ -40,7 +40,7 @@
 static int calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
 				struct tcg_pcr_event *event_header)
 {
-	return _calc_tpm2_event_size(event, event_header);
+	return _calc_tpm2_event_size(event, event_header, NULL, NULL);
 }
 
 static void *tpm2_bios_measurements_start(struct seq_file *m, loff_t *pos)
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 4c46ff6f2242..bf4e9a254e23 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -53,6 +53,7 @@ struct efi __read_mostly efi = {
 	.mem_attr_table		= EFI_INVALID_TABLE_ADDR,
 	.rng_seed		= EFI_INVALID_TABLE_ADDR,
 	.tpm_log		= EFI_INVALID_TABLE_ADDR,
+	.tpm_final_log		= EFI_INVALID_TABLE_ADDR,
 	.mem_reserve		= EFI_INVALID_TABLE_ADDR,
 };
 EXPORT_SYMBOL(efi);
@@ -485,6 +486,7 @@ static __initdata efi_config_table_type_t common_tables[] = {
 	{EFI_MEMORY_ATTRIBUTES_TABLE_GUID, "MEMATTR", &efi.mem_attr_table},
 	{LINUX_EFI_RANDOM_SEED_TABLE_GUID, "RNG", &efi.rng_seed},
 	{LINUX_EFI_TPM_EVENT_LOG_GUID, "TPMEventLog", &efi.tpm_log},
+	{LINUX_EFI_TPM_FINAL_LOG_GUID, "TPMFinalLog", &efi.tpm_final_log},
 	{LINUX_EFI_MEMRESERVE_TABLE_GUID, "MEMRESERVE", &efi.mem_reserve},
 	{NULL_GUID, NULL, NULL},
 };
diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
index 0cbeb3d46b18..19f742cf0d33 100644
--- a/drivers/firmware/efi/tpm.c
+++ b/drivers/firmware/efi/tpm.c
@@ -10,31 +10,78 @@
 #include <linux/efi.h>
 #include <linux/init.h>
 #include <linux/memblock.h>
+#include <linux/tpm_eventlog.h>
 
 #include <asm/early_ioremap.h>
 
+int efi_tpm_final_log_size;
+EXPORT_SYMBOL(efi_tpm_final_log_size);
+
+int tpm2_event_log_length(void *data, int count, void *size_info)
+{
+	struct tcg_pcr_event2_head *header;
+	int event_size, size = 0;
+
+	while (count > 0) {
+		header = data + size;
+		event_size = _calc_tpm2_event_size(header, size_info,
+						   early_memremap,
+						   early_memunmap);
+		if (event_size == 0)
+			return -1;
+		size += event_size;
+	}
+	return size;
+}
+
 /*
  * Reserve the memory associated with the TPM Event Log configuration table.
  */
 int __init efi_tpm_eventlog_init(void)
 {
 	struct linux_efi_tpm_eventlog *log_tbl;
+	struct efi_tcg2_final_events_table *final_tbl;
 	unsigned int tbl_size;
 
-	if (efi.tpm_log == EFI_INVALID_TABLE_ADDR)
+	if (efi.tpm_log != EFI_INVALID_TABLE_ADDR) {
+		log_tbl = early_memremap(efi.tpm_log, sizeof(*log_tbl));
+		if (!log_tbl) {
+			pr_err("Failed to map TPM Event Log table @ 0x%lx\n",
+			       efi.tpm_log);
+			efi.tpm_log = EFI_INVALID_TABLE_ADDR;
+			return -ENOMEM;
+		}
+
+		tbl_size = sizeof(*log_tbl) + log_tbl->size;
+		memblock_reserve(efi.tpm_log, tbl_size);
+		early_memunmap(log_tbl, sizeof(*log_tbl));
+	} else {
+		/*
+		 * We can't calculate the size of the final events without the
+		 * first entry in the TPM log, so bail here.
+		 */
 		return 0;
+	}
+
+	if (efi.tpm_final_log != EFI_INVALID_TABLE_ADDR) {
+		final_tbl = early_memremap(efi.tpm_final_log,
+					   sizeof(*final_tbl));
+		if (!final_tbl) {
+			pr_err("Failed to map TPM Final Event Log table @ 0x%lx\n",
+			       efi.tpm_final_log);
+			efi.tpm_final_log = EFI_INVALID_TABLE_ADDR;
+			return -ENOMEM;
+		}
 
-	log_tbl = early_memremap(efi.tpm_log, sizeof(*log_tbl));
-	if (!log_tbl) {
-		pr_err("Failed to map TPM Event Log table @ 0x%lx\n",
-			efi.tpm_log);
-		efi.tpm_log = EFI_INVALID_TABLE_ADDR;
-		return -ENOMEM;
+		tbl_size = tpm2_event_log_length(final_tbl->events,
+						 final_tbl->number_of_events,
+						 (void *)efi.tpm_log);
+		memblock_reserve((unsigned long)final_tbl,
+				 tbl_size + sizeof(*final_tbl));
+		early_memunmap(final_tbl, sizeof(*final_tbl));
+		efi_tpm_final_log_size = tbl_size;
 	}
 
-	tbl_size = sizeof(*log_tbl) + log_tbl->size;
-	memblock_reserve(efi.tpm_log, tbl_size);
-	early_memunmap(log_tbl, sizeof(*log_tbl));
 	return 0;
 }
 
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 45ff763fba76..a6134c301fa7 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -676,6 +676,7 @@ void efi_native_runtime_setup(void);
 #define LINUX_EFI_LOADER_ENTRY_GUID		EFI_GUID(0x4a67b082, 0x0a4c, 0x41cf,  0xb6, 0xc7, 0x44, 0x0b, 0x29, 0xbb, 0x8c, 0x4f)
 #define LINUX_EFI_RANDOM_SEED_TABLE_GUID	EFI_GUID(0x1ce1e5bc, 0x7ceb, 0x42f2,  0x81, 0xe5, 0x8a, 0xad, 0xf1, 0x80, 0xf5, 0x7b)
 #define LINUX_EFI_TPM_EVENT_LOG_GUID		EFI_GUID(0xb7799cb0, 0xeca2, 0x4943,  0x96, 0x67, 0x1f, 0xae, 0x07, 0xb7, 0x47, 0xfa)
+#define LINUX_EFI_TPM_FINAL_LOG_GUID		EFI_GUID(0x1e2ed096, 0x30e2, 0x4254,  0xbd, 0x89, 0x86, 0x3b, 0xbe, 0xf8, 0x23, 0x25)
 #define LINUX_EFI_MEMRESERVE_TABLE_GUID		EFI_GUID(0x888eb0c6, 0x8ede, 0x4ff5,  0xa8, 0xf0, 0x9a, 0xee, 0x5c, 0xb9, 0x77, 0xc2)
 
 typedef struct {
@@ -983,6 +984,7 @@ extern struct efi {
 	unsigned long mem_attr_table;	/* memory attributes table */
 	unsigned long rng_seed;		/* UEFI firmware random seed */
 	unsigned long tpm_log;		/* TPM2 Event Log table */
+	unsigned long tpm_final_log;	/* TPM2 Final Events Log table */
 	unsigned long mem_reserve;	/* Linux EFI memreserve table */
 	efi_get_time_t *get_time;
 	efi_set_time_t *set_time;
@@ -1700,6 +1702,13 @@ struct linux_efi_tpm_eventlog {
 
 extern int efi_tpm_eventlog_init(void);
 
+struct efi_tcg2_final_events_table {
+	u64 version;
+	u64 number_of_events;
+	u8 events[];
+};
+extern int efi_tpm_final_log_size;
+
 /*
  * efi_runtime_service() function identifiers.
  * "NONE" is used by efi_recover_from_page_fault() to check if the page
diff --git a/include/linux/tpm_eventlog.h b/include/linux/tpm_eventlog.h
index b1b8350c238f..72e995bfc3e7 100644
--- a/include/linux/tpm_eventlog.h
+++ b/include/linux/tpm_eventlog.h
@@ -112,11 +112,37 @@ struct tcg_pcr_event2_head {
 	struct tpm_digest digests[];
 } __packed;
 
+struct tcg_algorithm_size {
+	u16 algorithm_id;
+	u16 algorithm_size;
+};
+
+struct tcg_algorithm_info {
+	u8 signature[16];
+	u32 platform_class;
+	u8 spec_version_minor;
+	u8 spec_version_major;
+	u8 spec_errata;
+	u8 uintn_size;
+	u32 number_of_algorithms;
+	struct tcg_algorithm_size digest_sizes[];
+};
+
+/*
+ * This can be called in two contexts - when the event is already mapped,
+ * and when it isn't. In the latter case we don't know how much space we
+ * need to map in advance so need to jump through this repeated map/unmap
+ * dance as we learn more about the size of the event.
+ */
 static inline int _calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
-					struct tcg_pcr_event *event_header)
+				  struct tcg_pcr_event *event_header,
+				  void *(*map)(resource_size_t, unsigned long),
+				  void (*unmap)(void *, unsigned long))
 {
 	struct tcg_efi_specid_event_head *efispecid;
 	struct tcg_event_field *event_field;
+	void *mapping = NULL;
+	int mapping_size;
 	void *marker;
 	void *marker_start;
 	u32 halg_size;
@@ -130,36 +156,94 @@ static inline int _calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
 	marker = marker + sizeof(event->pcr_idx) + sizeof(event->event_type)
 		+ sizeof(event->count);
 
+	/* Map the event header */
+	if (map) {
+		mapping_size = marker - marker_start;
+		mapping = map((unsigned long)marker_start, mapping_size);
+		if (!mapping) {
+			size = 0;
+			goto out;
+		}
+	}
+
 	efispecid = (struct tcg_efi_specid_event_head *)event_header->event;
 
 	/* Check if event is malformed. */
-	if (event->count > efispecid->num_algs)
-		return 0;
+	if (event->count > efispecid->num_algs) {
+		size = 0;
+		goto out;
+	}
 
 	for (i = 0; i < event->count; i++) {
 		halg_size = sizeof(event->digests[i].alg_id);
+
+		/* Map the digest's algorithm identifier */
+		if (map && unmap) {
+			unmap(mapping, mapping_size);
+			mapping_size = marker - marker_start + halg_size;
+			mapping = map((unsigned long)marker_start,
+				      mapping_size);
+			if (!mapping) {
+				size = 0;
+				goto out;
+			}
+		}
+
 		memcpy(&halg, marker, halg_size);
 		marker = marker + halg_size;
+
 		for (j = 0; j < efispecid->num_algs; j++) {
 			if (halg == efispecid->digest_sizes[j].alg_id) {
 				marker +=
 					efispecid->digest_sizes[j].digest_size;
+
+				/* Map the digest content itself */
+				if (map && unmap) {
+					unmap(mapping, mapping_size);
+					mapping_size = marker - marker_start;
+					mapping = map((unsigned long)marker_start,
+						      mapping_size);
+					if (!mapping) {
+						size = 0;
+						goto out;
+					}
+				}
 				break;
 			}
 		}
 		/* Algorithm without known length. Such event is unparseable. */
-		if (j == efispecid->num_algs)
-			return 0;
+		if (j == efispecid->num_algs) {
+			size = 0;
+			goto out;
+		}
 	}
 
 	event_field = (struct tcg_event_field *)marker;
+
+	/*
+	 * Map the event size - we don't read from the event itself, so
+	 * we don't need to map it
+	 */
+	if (map && unmap) {
+		unmap(marker_start, mapping_size);
+		mapping_size += sizeof(event_field->event_size);
+		mapping = map((unsigned long)marker_start, mapping_size);
+		if (!mapping) {
+			size = 0;
+			goto out;
+		}
+	}
+
 	marker = marker + sizeof(event_field->event_size)
 		+ event_field->event_size;
 	size = marker - marker_start;
 
 	if ((event->event_type == 0) && (event_field->event_size == 0))
-		return 0;
-
+		size = 0;
+out:
+	if (unmap)
+		unmap(mapping, mapping_size);
 	return size;
 }
+
 #endif
-- 
2.20.1.611.gfbb209baf1-goog


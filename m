Return-Path: <SRS0=d4Rs=PR=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B879C43387
	for <linux-integrity@archiver.kernel.org>; Wed,  9 Jan 2019 01:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 320CE20883
	for <linux-integrity@archiver.kernel.org>; Wed,  9 Jan 2019 01:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ryM8ikXy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbfAIBtC (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 8 Jan 2019 20:49:02 -0500
Received: from mail-io1-f73.google.com ([209.85.166.73]:41299 "EHLO
        mail-io1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729102AbfAIBtB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Jan 2019 20:49:01 -0500
Received: by mail-io1-f73.google.com with SMTP id a12so4954790iok.8
        for <linux-integrity@vger.kernel.org>; Tue, 08 Jan 2019 17:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=s2+alvcRvFkRmPP4iRh2C5hWnObYLHtxbuHqeX3fJ28=;
        b=ryM8ikXy2eUdQlh7u4ByTLnoDpZq93Xb0xhdUr+uD0XQ+0zfVVXE1TMFqeUtA6jUEP
         V4VgLXdlwKYki0r0vSWZRVKNMTGTB637b/njRvUVitt6/XKskd3fyiNtP+rn+7GfjnCa
         ybA+cEmXaZLxgIoR98dVo1WdvTlWDVysSeLmx0KxHW0YwWYfP5G1zlu7ceNwq3QpCqC+
         lD6tUE+2J2iI36BTCsj1FZfbfP54AKWk5oUarr8BNC/Cgq/a+7cA4wf/BZQqYBPF7xaW
         jwDC62j9tAAfaNjGMDG++xdnQMG14bzNd3FVwwWNHhFbQ6hMDFBnWHFm2imsTfWe9tVw
         k9CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=s2+alvcRvFkRmPP4iRh2C5hWnObYLHtxbuHqeX3fJ28=;
        b=cXF0wK9sDBA2UzvAIxStfYYw6W1b3EJUbiO2YbOWBJy0gcL2Lru6gMbwnpG/137cY4
         jbRYQwIXND5LMS7KcNLfrn921jsFuLTiffJpLwTb1wl+K+Bjz6SXf6G1WpRYBH+MMyDe
         0OoluSq1wiHPsfp1wjuqy2ySTkgD2RKIZDCxC+9lGtkb0FQS4CnDM3Gha2XHdv/SR4EM
         SxtudPVKmrNFmrLQuh90Hm/daTICxk67v3vOvlK9dniNcNeYWDX6LLrLOUdawlWtlBEF
         DM1pilNAAw/K88Icykt+3ONluw7ZBHbVif1Jt2yMXQw+sxMH8PLrzmJhIQxWW13Ul3jN
         mI2g==
X-Gm-Message-State: AJcUukejRCC7TRIlhBuILO1VGN9e3aj5kmPuYFTs+YmRTzLfuzRMro72
        7ZoCorVKccYMw+jKYedTk0bDwntXUamkd153+NjRqYzDQ6H2tIlzLGjU1KtDDi3x45eQj2JTooL
        v/IiPOs/FevsRShlVKLYj0u6iJSr7G2KsWjYUyqO9jBiarKSwVipPiu01lH8YZat2QA6sZPt8fT
        EGUO6LnVN5490l0R++fag=
X-Google-Smtp-Source: ALg8bN5Q4Mv+WI+z+wu15KSKZz+/Y6tnWXXLKLSd1Ih/d//d3qEt2BxdJPGflaUlvNdg8AMen6rbnZHQMCYyW3S3zSKOpw==
X-Received: by 2002:a24:74e:: with SMTP id f75mr3191244itf.22.1546998540475;
 Tue, 08 Jan 2019 17:49:00 -0800 (PST)
Date:   Tue,  8 Jan 2019 17:48:45 -0800
In-Reply-To: <20190109014847.39980-1-matthewgarrett@google.com>
Message-Id: <20190109014847.39980-4-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190109014847.39980-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
Subject: [PATCH 3/5] tpm: Reserve the TPM final events table
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
 drivers/firmware/efi/tpm.c       | 67 ++++++++++++++++++++++----
 include/linux/efi.h              |  9 ++++
 include/linux/tpm_eventlog.h     | 82 +++++++++++++++++++++++++++++---
 5 files changed, 144 insertions(+), 18 deletions(-)

diff --git a/drivers/char/tpm/eventlog/tpm2.c b/drivers/char/tpm/eventlog/tpm2.c
index 1343179c0a0e..45e379448a02 100644
--- a/drivers/char/tpm/eventlog/tpm2.c
+++ b/drivers/char/tpm/eventlog/tpm2.c
@@ -40,7 +40,7 @@
 static int calc_tpm2_event_size(struct tcg_pcr_event2_hdr *event,
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
index 0cbeb3d46b18..9d843af088b3 100644
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
+	struct tcg_pcr_event2_hdr *header;
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
index 6363c8b08908..612f177d09af 100644
--- a/include/linux/tpm_eventlog.h
+++ b/include/linux/tpm_eventlog.h
@@ -136,11 +136,21 @@ struct tcg_algorithm_info {
 	struct tcg_algorithm_size digest_sizes[];
 };
 
+/*
+ * This can be called in two contexts - when the event is already mapped,
+ * and when it isn't. In the latter case we don't know how much space we
+ * need to map in advance so need to jump through this repeated map/unmap
+ * dance as we learn more about the size of the event.
+ */
 static inline int _calc_tpm2_event_size(struct tcg_pcr_event2_hdr *event,
-					struct tcg_pcr_event *event_header)
+				  struct tcg_pcr_event *event_header,
+				  void *(*map)(resource_size_t, unsigned long),
+				  void (*unmap)(void *, unsigned long))
 {
 	struct tcg_efi_specid_event *efispecid;
 	struct tcg_event_field *event_field;
+	void *mapping = NULL;
+	int mapping_size;
 	void *marker;
 	void *marker_start;
 	u32 halg_size;
@@ -154,36 +164,94 @@ static inline int _calc_tpm2_event_size(struct tcg_pcr_event2_hdr *event,
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
 	efispecid = (struct tcg_efi_specid_event *)event_header->event;
 
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
2.20.1.97.g81188d93c3-goog


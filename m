Return-Path: <SRS0=d4Rs=PR=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE36C43387
	for <linux-integrity@archiver.kernel.org>; Wed,  9 Jan 2019 01:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2C6420883
	for <linux-integrity@archiver.kernel.org>; Wed,  9 Jan 2019 01:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NzI2516V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbfAIBtG (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 8 Jan 2019 20:49:06 -0500
Received: from mail-qk1-f201.google.com ([209.85.222.201]:39550 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729102AbfAIBtG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Jan 2019 20:49:06 -0500
Received: by mail-qk1-f201.google.com with SMTP id d196so4862025qkb.6
        for <linux-integrity@vger.kernel.org>; Tue, 08 Jan 2019 17:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fmceAa53ADyVwcjwEGe3ntrNImDgoRPn1GmIc7NTZv8=;
        b=NzI2516VT9pxylOPL0lN9XHDmFy8HP5szx3mWFhU/uwVA1MQTsidlmsKFJGy7XMDX9
         G6GbTiIe2o9DmUIWr1xT6KJyU4TyokCGFEKeNAWcHMl03QvnhoFn6Am05xOmX7Xr7uYb
         d+jZX3046aHbuxWBTUYRvwrLXrbAaOcBJy2f85ilNyQy4X0Niv0lwx3FPBeFywXdbtSO
         bQqJMPBjsVcKDybe5z+GiNkPHkYXPDYq3gjR/gMc9dOyaQUMJEJDE12kLKkuWWxO0C0t
         s13BLyqN1dYGfvWrgHiE1wW6wjo4KLLV/agdFYb21oGVmz5QIR9vlig/AnDLBqt/Yuqc
         vRmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fmceAa53ADyVwcjwEGe3ntrNImDgoRPn1GmIc7NTZv8=;
        b=IbSrroSg9m7rqKUJdTxIWdSf4Wx4+xfgPS5Tiuj+Se/5cOXi4Pu3GShdDXKmu6oI4D
         EFeaXkCG6lip0/RuZ4BlXZpKSf4KO5YQR/49koX5DoAVwrYratiaExYEtpLKGSX/SK1I
         dpEk3j5dXYWe5nDQQCtFXbHRyO+24wwEgq6HjUNZOotCmOjc0N0XYmWyHIsNmNAvVhPe
         fyVW5w/Zyp9CjnuDjQpkBcjT/7WMQUNCZu+fofP3kYyVBcbAr5gmKzLgMnTla6dZjzEl
         LD5WqVV6+U6fNziLghIiBjnnA3UFlqKeBEVtWM7K/kUwDhTqSTj8XvKBqCrsl4Wsmkfj
         XVqA==
X-Gm-Message-State: AJcUukf7xVzyzzWqdp3G4fp3yflhB2j+zotGVqePhFAI9cCcVoua8EQN
        G2EHDisS3xyKLcejhoVbVomhcM9gO1jUS3og0jfSE35wLj7Gz/9GQStTm4QHKJ7sW/TAe8m49dp
        7szkXUVX63/CP6H3OJw4tJktn8ZSbLAAwRF1HaeAfpQ1DZ+EAxMrge9Yuj1y5dRMVrUBf7mcO1O
        JFPNytz83y8gsnQaI9H9Y=
X-Google-Smtp-Source: ALg8bN66qCcGAC3D2a0fxnCw9HaJXNajUR7r2nbuOwwX03o8vyWuXjzDHfQ0lKJtIh3EDRlGlrYGv9QDN5rPbV8gjo+gbw==
X-Received: by 2002:ac8:2d46:: with SMTP id o6mr2859252qta.35.1546998545157;
 Tue, 08 Jan 2019 17:49:05 -0800 (PST)
Date:   Tue,  8 Jan 2019 17:48:47 -0800
In-Reply-To: <20190109014847.39980-1-matthewgarrett@google.com>
Message-Id: <20190109014847.39980-6-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190109014847.39980-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
Subject: [PATCH 5/5] efi: Attempt to get the TCG2 event log in the boot stub
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

Right now we only attempt to obtain the SHA1-only event log. The
protocol also supports a crypto agile log format, which contains digests
for all algorithms in use. Attempt to obtain this first, and fall back
to obtaining the older format if the system doesn't support it. This is
lightly complicated by the event sizes being variable (as we don't know
in advance which algorithms are in use), and the interface giving us
back a pointer to the start of the final entry rather than a pointer to
the end of the log - as a result, we need to parse the final entry to
figure out its length in order to know how much data to copy up to the
OS.

Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 drivers/firmware/efi/libstub/tpm.c | 50 ++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 17 deletions(-)

diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/efi/libstub/tpm.c
index a90b0b8fc69a..7d4a045aa2c4 100644
--- a/drivers/firmware/efi/libstub/tpm.c
+++ b/drivers/firmware/efi/libstub/tpm.c
@@ -59,7 +59,7 @@ void efi_enable_reset_attack_mitigation(efi_system_table_t *sys_table_arg)
 
 #endif
 
-static void efi_retrieve_tpm2_eventlog_1_2(efi_system_table_t *sys_table_arg)
+void efi_retrieve_tpm2_eventlog(efi_system_table_t *sys_table_arg)
 {
 	efi_guid_t tcg2_guid = EFI_TCG2_PROTOCOL_GUID;
 	efi_guid_t linux_eventlog_guid = LINUX_EFI_TPM_EVENT_LOG_GUID;
@@ -69,6 +69,7 @@ static void efi_retrieve_tpm2_eventlog_1_2(efi_system_table_t *sys_table_arg)
 	unsigned long first_entry_addr, last_entry_addr;
 	size_t log_size, last_entry_size;
 	efi_bool_t truncated;
+	int version = EFI_TCG2_EVENT_LOG_FORMAT_TCG_2;
 	void *tcg2_protocol = NULL;
 
 	status = efi_call_early(locate_protocol, &tcg2_guid, NULL,
@@ -76,14 +77,20 @@ static void efi_retrieve_tpm2_eventlog_1_2(efi_system_table_t *sys_table_arg)
 	if (status != EFI_SUCCESS)
 		return;
 
-	status = efi_call_proto(efi_tcg2_protocol, get_event_log, tcg2_protocol,
-				EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2,
-				&log_location, &log_last_entry, &truncated);
-	if (status != EFI_SUCCESS)
-		return;
+	status = efi_call_proto(efi_tcg2_protocol, get_event_log,
+				tcg2_protocol, version, &log_location,
+				&log_last_entry, &truncated);
+
+	if (status != EFI_SUCCESS || !log_location) {
+		version = EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2;
+		status = efi_call_proto(efi_tcg2_protocol, get_event_log,
+					tcg2_protocol, version, &log_location,
+					&log_last_entry, &truncated);
+		if (status != EFI_SUCCESS || !log_location)
+			return;
+
+	}
 
-	if (!log_location)
-		return;
 	first_entry_addr = (unsigned long) log_location;
 
 	/*
@@ -98,8 +105,23 @@ static void efi_retrieve_tpm2_eventlog_1_2(efi_system_table_t *sys_table_arg)
 		 * We need to calculate its size to deduce the full size of
 		 * the logs.
 		 */
-		last_entry_size = sizeof(struct tcpa_event) +
-			((struct tcpa_event *) last_entry_addr)->event_size;
+		if (version == EFI_TCG2_EVENT_LOG_FORMAT_TCG_2) {
+			/*
+			 * The TCG2 log format has variable length entries,
+			 * and the information to decode the hash algorithms
+			 * back into a size is contained in the first entry -
+			 * pass a pointer to the final entry (to calculate its
+			 * size) and the first entry (so we know how long each
+			 * digest is)
+			 */
+			last_entry_size =
+				_calc_tpm2_event_size((void *)last_entry_addr,
+						      (void *)log_location,
+						      NULL, NULL);
+		} else {
+			last_entry_size = sizeof(struct tcpa_event) +
+			   ((struct tcpa_event *) last_entry_addr)->event_size;
+		}
 		log_size = log_last_entry - log_location + last_entry_size;
 	}
 
@@ -116,7 +138,7 @@ static void efi_retrieve_tpm2_eventlog_1_2(efi_system_table_t *sys_table_arg)
 
 	memset(log_tbl, 0, sizeof(*log_tbl) + log_size);
 	log_tbl->size = log_size;
-	log_tbl->version = EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2;
+	log_tbl->version = version;
 	memcpy(log_tbl->log, (void *) first_entry_addr, log_size);
 
 	status = efi_call_early(install_configuration_table,
@@ -128,9 +150,3 @@ static void efi_retrieve_tpm2_eventlog_1_2(efi_system_table_t *sys_table_arg)
 err_free:
 	efi_call_early(free_pool, log_tbl);
 }
-
-void efi_retrieve_tpm2_eventlog(efi_system_table_t *sys_table_arg)
-{
-	/* Only try to retrieve the logs in 1.2 format. */
-	efi_retrieve_tpm2_eventlog_1_2(sys_table_arg);
-}
-- 
2.20.1.97.g81188d93c3-goog


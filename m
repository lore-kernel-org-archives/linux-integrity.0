Return-Path: <SRS0=H4GS=QL=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59428C282C4
	for <linux-integrity@archiver.kernel.org>; Mon,  4 Feb 2019 21:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2514C2082E
	for <linux-integrity@archiver.kernel.org>; Mon,  4 Feb 2019 21:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EAFtNljD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbfBDVdV (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 4 Feb 2019 16:33:21 -0500
Received: from mail-ot1-f74.google.com ([209.85.210.74]:38876 "EHLO
        mail-ot1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbfBDVdV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 4 Feb 2019 16:33:21 -0500
Received: by mail-ot1-f74.google.com with SMTP id q16so1177240otf.5
        for <linux-integrity@vger.kernel.org>; Mon, 04 Feb 2019 13:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zspt5hAEpk1Wa7UbiRsO/fK0cybj1rAv6Rl9209LpJY=;
        b=EAFtNljDn3yDkyNkTFLJ5hc2VZftoHcQ+F14iCyHoxDD9xLyZledT282GID0/veP20
         C3jhgcnZeYFTJu8YtUPH5Gi/JI97uf2n/rE+T8HcJ7xCLm1Fo38tVZgAwenxbTQr8PL+
         oEskzET877qth/y6bzocv8bLML1s9rUqRRXv2ZUC4sMXtmA7VGs+4CWOrRgqEBCyMpiK
         N1VxU4o7eivL3PI5IS5BPHWyhMUPVSZm4hh20Je4jtDePuNgCBDQuxMxt9McBfgB9meI
         ZKaDiQW5VvId4Sh75awMaeEYdyQxWMuR0mb2TLcaJW03a09Jq5v8M56jKkHVgZaCCcvI
         tNJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zspt5hAEpk1Wa7UbiRsO/fK0cybj1rAv6Rl9209LpJY=;
        b=PP7rECDnfklTRhKjRb7yhGHe9Lv7+5AQyOALb/NMyb820cq/uRfwasYqP+rFyxOOmY
         dJER7lCK771/lzZ2PF5YlGYA71zFgyhvtGiT6Tm8Ajib/wYFzJcUchd6/eRiFgLsPGzV
         0J8EooJujDL0+YYM5/gOlZhM4bHnXFGIQGHUcHmsI2+TYqh7tePjoNnQzjHJap4jOpwc
         JS2jkGceG/oX6faxz98BJFOuo7vo9ZnpYBpWVPmu7QFTx2/q8pnMx2zyXtxJk3aziWAe
         14Ll0Fk3h/diqDvoG3DKrfVbljbAzKDO3dPYkuWmP9SJF7K4OainuCWsNPOnCy4X1Hd9
         N+cw==
X-Gm-Message-State: AHQUAuZsTjC3j0AwCaoT8hh4QP50uIVmdkJrfvGxmK1yIbI1/poxrVEW
        ioAROdGlnnRtjxxM42RpwQIY8Rj4QwRWDF+3fZwTcDkVKQ++JCR9rT/IIvns2X34wLd+lAvsXP5
        VE0MikKg8QVM8SbOpsMU5BlzjOcjAhmS0lzTSkye83PFj9oqHHGWhjHS4fCMseVhqgLEOt6JD2U
        9CzDUaABZ0zXY9ZBaXdjA=
X-Google-Smtp-Source: AHgI3IZlHZ831SVwg4ZjbX12+w9UaHm2OWS7QqfdC4CKPkVvkWOSp7G4ZM/IDxlS9iFBeYUV/WhISnEQ26e/xUZ5rGPvEw==
X-Received: by 2002:aca:f246:: with SMTP id q67mr963090oih.7.1549316000573;
 Mon, 04 Feb 2019 13:33:20 -0800 (PST)
Date:   Mon,  4 Feb 2019 13:33:03 -0800
In-Reply-To: <20190204213303.131064-1-matthewgarrett@google.com>
Message-Id: <20190204213303.131064-5-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190204213303.131064-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.20.1.611.gfbb209baf1-goog
Subject: [PATCH V2 4/4] efi: Attempt to get the TCG2 event log in the boot stub
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
2.20.1.611.gfbb209baf1-goog


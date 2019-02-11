Return-Path: <SRS0=a4os=QS=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85800C282CE
	for <linux-integrity@archiver.kernel.org>; Mon, 11 Feb 2019 21:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52C9C214DA
	for <linux-integrity@archiver.kernel.org>; Mon, 11 Feb 2019 21:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m/8IFXhp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbfBKVze (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 11 Feb 2019 16:55:34 -0500
Received: from mail-ot1-f74.google.com ([209.85.210.74]:54770 "EHLO
        mail-ot1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfBKVzd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 11 Feb 2019 16:55:33 -0500
Received: by mail-ot1-f74.google.com with SMTP id d5so458415otl.21
        for <linux-integrity@vger.kernel.org>; Mon, 11 Feb 2019 13:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=p7qdT/9qk7l5kSQz2+wHVxTc/rlusKl3aEzIsfiIitU=;
        b=m/8IFXhpllZy5LzTUT0PFDIy8qvk3EhHbEj5RF8o2L88n4n6Sdp2Wx3Ix5l/4tgRX9
         GA8LNmHfrF/LEiFWNczZy9v8ZTd026xrzq3KdFl6igvb2X7NKoOXdALSVG8fpSqbeIKu
         tafLg5jGlc+hHs2gzRBL+o/dZ+dig74aFRdlihCsM73hFAU9HhP6A/vpMDV2hGTd6wmw
         1aMlb2spSHmBWDcaRHad/IW9fSu83Xz8y4oeZeyrBnMRo6TUv5k2yUggMIQdSmGMKXn4
         GBv0JKuj4AO9hxHKzWDTxXvxTNTaVh1mAPUDKF9jmwH1WyOfvWg6qVXiSGvRcFS7n3gk
         yPXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=p7qdT/9qk7l5kSQz2+wHVxTc/rlusKl3aEzIsfiIitU=;
        b=EURMakPG2tjA8XsMZpE4ogCUGpS9iIke5ByjRehODJTO8Wbu/0UQIQ9v3e8/Eov+p0
         KL4q7WVc6M3gvOk9BeVq/L6GxUu0MOavYm+5OiiZrtNXSZ3Mxxs57EMpWWTrhA9BW7p9
         w7iSXPdqbfN4sqddeLZy0WhT7SgwWQvr57MAjSgUDVvoJ8EMPUlL58gNCihv9iX5L9mr
         uEfxy/Fm1PQq61V4L2dRzAuYlANNJJkVwsZz1x7IFr6GnxPXZS0Yd/dFlS/gprmuMegZ
         Z7bTqjV8fjpNR0qweq0rvJwWT/7ZPnPXPX1N4wrTebv3AmTOQgSMSbT2relj8Cmhnako
         cFuQ==
X-Gm-Message-State: AHQUAuaUQ0rNGoY+261oLSy4Jg0gH361kipsS9O9G8oWJPcm5xMaQrXn
        Qz7eXDMIWUwJsH76pNJ7hfLGY09zP8OaimltmUL8rvC9/iy3YsudfJ0ywHA2jzqEg9C2ExhPYgF
        7Gt8JNyVBtJnHHKAmru/5iGAi/YR9EJ70G6VYozIppFWdn9oJ58jp94AX1y0xjlVbgvtfISYH0l
        Q4KeXh5erhvkojS8RJAUw=
X-Google-Smtp-Source: AHgI3IZC+Qd00Cp0xkjMBYB5vZNYsSxR0b/0lVVRabt4MmL9u/oQaZqs7NT0+tebTHJH92Vqj7o1Vjd/VlbtSNhwC1eeeQ==
X-Received: by 2002:a9d:6d93:: with SMTP id x19mr262443otp.30.1549922132649;
 Mon, 11 Feb 2019 13:55:32 -0800 (PST)
Date:   Mon, 11 Feb 2019 13:55:18 -0800
In-Reply-To: <20190211215518.81419-1-matthewgarrett@google.com>
Message-Id: <20190211215518.81419-5-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190211215518.81419-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.20.1.791.gb4d0f1c61a-goog
Subject: [PATCH V3 4/4] efi: Attempt to get the TCG2 event log in the boot stub
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
index a90b0b8fc69a..523cd07c551c 100644
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
+				__calc_tpm2_event_size((void *)last_entry_addr,
+						       (void *)log_location,
+						       false);
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
2.20.1.791.gb4d0f1c61a-goog


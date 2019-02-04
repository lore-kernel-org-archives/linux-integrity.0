Return-Path: <SRS0=H4GS=QL=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE1DC282CB
	for <linux-integrity@archiver.kernel.org>; Mon,  4 Feb 2019 21:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05D7C2082E
	for <linux-integrity@archiver.kernel.org>; Mon,  4 Feb 2019 21:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KkPTOCYi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725967AbfBDVdS (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 4 Feb 2019 16:33:18 -0500
Received: from mail-qt1-f201.google.com ([209.85.160.201]:38976 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbfBDVdS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 4 Feb 2019 16:33:18 -0500
Received: by mail-qt1-f201.google.com with SMTP id u20so1491505qtk.6
        for <linux-integrity@vger.kernel.org>; Mon, 04 Feb 2019 13:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/ISosBGzvVz6Es3NpbY9q4oz+VaRPR0t9N8MOMI1nqw=;
        b=KkPTOCYiOBzJKuqYV/Y86xmb5O2S0UeCt7yH2pQLGLlrYitPPaHLG7aGWYELaWzOy5
         qzwuuDu+FmUb8gO74ZM5sVxTWWVlJU63qJ8iP7OtrEcjvJQ0uj0iyIilWvkvDPdjYRsn
         /ds3gvJ7ndXAjXXIk7L3leZ92ABbaRRF6lGoQmzrXsh2Nc0QLASwnusBZiClnWHkFAw3
         JCmakHtwJjU8NnW3nPhXLzFXTLBwJz2cRkN1/YFBE+ZMWSdPh0agUY7aPxz/pJBt7WA+
         bfN9Os1qFvwSLE83wSP2LLPyOuWId05hR6BOk4fvGBNQs983Rp9UVqod4jOAzmEzIjMc
         Uq7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/ISosBGzvVz6Es3NpbY9q4oz+VaRPR0t9N8MOMI1nqw=;
        b=J1KYjELtZOa6pfYMELiu1OJ1ujwXmxa8h/tyloGMu639lAG+sTD8pQnOMPYmxH9/QE
         5S3/UAOtLlz25pUZ/iqI5JGgrAXF2s6rIx+ORhTx/xHCK3YJGcK5ySQ7NZBGpaZ/o3j/
         xuzft1QzkYJ9YKASHIJGXqedcU+kdrLRYhNedyVYDOw+nU9xwYjTCLeRF0CFZxDtINHi
         cyqr/Z4VVdVpoZEHGcn8eM2hRRmBLnOH4G8jbYaAl0ESGAt/HS34eVsLFWq3pMUbtbsL
         EjtFZL3/CikeYOgOjhbGytXDnyhnXOiXcljLxY6qTS2Ndt5QlVzbIbC6ITXJB6WVPcPn
         QSzw==
X-Gm-Message-State: AHQUAubMb1klylNm3d8iNnzyPTNCLHnMVDpJMAI6yvv7m+k0+jTDJAc0
        UdqiRh4z8u7EmLMH6JMadT/pbLmABCRCZpKh/GOqX5YW5htKE9Dp1V4IrcC5zK/fBFwa+d61EKP
        ddVxd8N9fQN2WodiVT1+ubpoa+u93RLuvXBAdgzFueQYzVaUkCw7T5/GKIVEq+m/dqdpeUKNUZF
        NGsw6JxLB+1HDjPl2uGRM=
X-Google-Smtp-Source: AHgI3IYQt10XCG25PXG17zfSv6DGsFdnHUtOBai/1jWTOTg0bYf0wivlGcNL6JO2BCSPkgo02i40axDDjLrf49N0JrNqVg==
X-Received: by 2002:aed:3a25:: with SMTP id n34mr983126qte.17.1549315997832;
 Mon, 04 Feb 2019 13:33:17 -0800 (PST)
Date:   Mon,  4 Feb 2019 13:33:02 -0800
In-Reply-To: <20190204213303.131064-1-matthewgarrett@google.com>
Message-Id: <20190204213303.131064-4-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190204213303.131064-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.20.1.611.gfbb209baf1-goog
Subject: [PATCH V2 3/4] tpm: Append the final event log to the TPM event log
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
2.20.1.611.gfbb209baf1-goog


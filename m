Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wr0-f201.google.com ([209.85.128.201]:43171 "EHLO
        mail-wr0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751809AbdITIOL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Sep 2017 04:14:11 -0400
Received: by mail-wr0-f201.google.com with SMTP id w12so190272wrc.2
        for <linux-integrity@vger.kernel.org>; Wed, 20 Sep 2017 01:14:10 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 20 Sep 2017 10:13:38 +0200
In-Reply-To: <20170920081340.7413-1-tweek@google.com>
Message-Id: <20170920081340.7413-4-tweek@google.com>
References: <20170920081340.7413-1-tweek@google.com>
Subject: [PATCH v3 3/5] tpm: add event log format version
From: Thiebaud Weksteen <tweek@google.com>
To: linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org,
        tpmdd-devel@lists.sourceforge.net
Cc: ard.biesheuvel@linaro.org, matt@codeblueprint.co.uk,
        linux-kernel@vger.kernel.org, mjg59@google.com, peterhuewe@gmx.de,
        jarkko.sakkinen@linux.intel.com, jgunthorpe@obsidianresearch.com,
        tpmdd@selhorst.net, Thiebaud Weksteen <tweek@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Although defined as part of the TCG EFI specification, we add these
definitions here so that any event log provider may reference them.

Signed-off-by: Thiebaud Weksteen <tweek@google.com>
---
 include/linux/tpm_eventlog.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/tpm_eventlog.h b/include/linux/tpm_eventlog.h
index 446656d1f317..6337614b0855 100644
--- a/include/linux/tpm_eventlog.h
+++ b/include/linux/tpm_eventlog.h
@@ -8,6 +8,9 @@
 #define ACPI_TCPA_SIG		"TCPA"	/* 0x41504354 /'TCPA' */
 #define TPM2_ACTIVE_PCR_BANKS	3
 
+#define EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2 0x1
+#define EFI_TCG2_EVENT_LOG_FORMAT_TCG_2   0x2
+
 #ifdef CONFIG_PPC64
 #define do_endian_conversion(x) be32_to_cpu(x)
 #else
-- 
2.14.1.821.g8fa685d3b7-goog

Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wr0-f202.google.com ([209.85.128.202]:42262 "EHLO
        mail-wr0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751813AbdITIOH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Sep 2017 04:14:07 -0400
Received: by mail-wr0-f202.google.com with SMTP id p37so191499wrb.1
        for <linux-integrity@vger.kernel.org>; Wed, 20 Sep 2017 01:14:06 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 20 Sep 2017 10:13:37 +0200
In-Reply-To: <20170920081340.7413-1-tweek@google.com>
Message-Id: <20170920081340.7413-3-tweek@google.com>
References: <20170920081340.7413-1-tweek@google.com>
Subject: [PATCH v3 2/5] tpm: rename event log provider files
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

Rename the current TPM Event Log provider files (ACPI and OF)
for clarity.

Signed-off-by: Thiebaud Weksteen <tweek@google.com>
---
 drivers/char/tpm/Makefile                            | 4 ++--
 drivers/char/tpm/{tpm_acpi.c => tpm_eventlog_acpi.c} | 0
 drivers/char/tpm/{tpm_of.c => tpm_eventlog_of.c}     | 0
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename drivers/char/tpm/{tpm_acpi.c => tpm_eventlog_acpi.c} (100%)
 rename drivers/char/tpm/{tpm_of.c => tpm_eventlog_of.c} (100%)

diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
index 23681f01f95a..c8509cd723a1 100644
--- a/drivers/char/tpm/Makefile
+++ b/drivers/char/tpm/Makefile
@@ -5,8 +5,8 @@ obj-$(CONFIG_TCG_TPM) += tpm.o
 tpm-y := tpm-interface.o tpm-dev.o tpm-sysfs.o tpm-chip.o tpm2-cmd.o \
 	 tpm-dev-common.o tpmrm-dev.o tpm1_eventlog.o tpm2_eventlog.o \
          tpm2-space.o
-tpm-$(CONFIG_ACPI) += tpm_ppi.o tpm_acpi.o
-tpm-$(CONFIG_OF) += tpm_of.o
+tpm-$(CONFIG_ACPI) += tpm_ppi.o tpm_eventlog_acpi.o
+tpm-$(CONFIG_OF) += tpm_eventlog_of.o
 obj-$(CONFIG_TCG_TIS_CORE) += tpm_tis_core.o
 obj-$(CONFIG_TCG_TIS) += tpm_tis.o
 obj-$(CONFIG_TCG_TIS_SPI) += tpm_tis_spi.o
diff --git a/drivers/char/tpm/tpm_acpi.c b/drivers/char/tpm/tpm_eventlog_acpi.c
similarity index 100%
rename from drivers/char/tpm/tpm_acpi.c
rename to drivers/char/tpm/tpm_eventlog_acpi.c
diff --git a/drivers/char/tpm/tpm_of.c b/drivers/char/tpm/tpm_eventlog_of.c
similarity index 100%
rename from drivers/char/tpm/tpm_of.c
rename to drivers/char/tpm/tpm_eventlog_of.c
-- 
2.14.1.821.g8fa685d3b7-goog

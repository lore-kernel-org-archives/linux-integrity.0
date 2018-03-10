Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga18.intel.com ([134.134.136.126]:3557 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932329AbeCJQQr (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 10 Mar 2018 11:16:47 -0500
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, Sahil Rihan <srihan@fb.com>,
        Alexei Starovoitov <ast@fb.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        stable@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] tpm: allow TCPA log area to be empty
Date: Sat, 10 Mar 2018 18:16:37 +0200
Message-Id: <20180310161637.7723-1-jarkko.sakkinen@linux.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

TCPA log are can be empty when the TPM is disabled. This commit changes the
behavior of tpm_read_log_acpi() to return successfully in this case.

Cc: stable@vger.kernel.org
Fixes: 55a82ab3181b ("[PATCH] tpm: add bios measurement log")
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 drivers/char/tpm/tpm_eventlog_acpi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_eventlog_acpi.c b/drivers/char/tpm/tpm_eventlog_acpi.c
index 66f19e93c216..f5f66dcd6f30 100644
--- a/drivers/char/tpm/tpm_eventlog_acpi.c
+++ b/drivers/char/tpm/tpm_eventlog_acpi.c
@@ -84,8 +84,8 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
 		break;
 	}
 	if (!len) {
-		dev_warn(&chip->dev, "%s: TCPA log area empty\n", __func__);
-		return -EIO;
+		dev_info(&chip->dev, "TCPA log area is empty\n");
+		return 0;
 	}
 
 	/* malloc EventLog space */
-- 
2.15.1

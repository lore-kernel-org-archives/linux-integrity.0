Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-qk0-f201.google.com ([209.85.220.201]:39672 "EHLO
        mail-qk0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754303AbeDYN0s (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 Apr 2018 09:26:48 -0400
Received: by mail-qk0-f201.google.com with SMTP id b202so5449820qkc.6
        for <linux-integrity@vger.kernel.org>; Wed, 25 Apr 2018 06:26:48 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 25 Apr 2018 15:26:41 +0200
Message-Id: <20180425132641.106385-1-tweek@google.com>
Subject: [PATCH v3 1/4] tpm: Add explicit endianness cast
From: Thiebaud Weksteen <tweek@google.com>
To: jarkko.sakkinen@linux.intel.com, nayna@linux.vnet.ibm.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        tweek@google.com
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thiebaud Weksteen <tweek@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Signed-off-by: Thiebaud Weksteen <tweek@google.com>
---
 drivers/char/tpm/tpm_eventlog_of.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_eventlog_of.c b/drivers/char/tpm/tpm_eventlog_of.c
index 96fd5646f866..ea0f16f19d73 100644
--- a/drivers/char/tpm/tpm_eventlog_of.c
+++ b/drivers/char/tpm/tpm_eventlog_of.c
@@ -56,8 +56,8 @@ int tpm_read_log_of(struct tpm_chip *chip)
 	 * but physical tpm needs the conversion.
 	 */
 	if (of_property_match_string(np, "compatible", "IBM,vtpm") < 0) {
-		size = be32_to_cpup(sizep);
-		base = be64_to_cpup(basep);
+		size = be32_to_cpup((__force __be32 *)sizep);
+		base = be64_to_cpup((__force __be64 *)basep);
 	} else {
 		size = *sizep;
 		base = *basep;
-- 
2.17.0.484.g0c8726318c-goog

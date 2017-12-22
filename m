Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from smtp11.infineon.com ([217.10.52.105]:47182 "EHLO
        smtp11.infineon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751770AbdLVN4i (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 Dec 2017 08:56:38 -0500
From: Alexander Steffen <Alexander.Steffen@infineon.com>
To: <pmenzel@molgen.mpg.de>, <jgg@ziepe.ca>,
        <jarkko.sakkinen@linux.intel.com>,
        <linux-integrity@vger.kernel.org>
CC: Alexander Steffen <Alexander.Steffen@infineon.com>
Subject: [PATCH] tpm2-cmd: try full selftest once if continue selftest failed
Date: Fri, 22 Dec 2017 14:56:10 +0100
Message-ID: <20171222135610.7056-1-Alexander.Steffen@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

If the usual approach of triggering only the missing selftests failed, give
the TPM another chance by requesting all selftests once.

With the current implementation, this will only help for TPMs that then
choose to run the selftests synchronously and return the selftest result.
There is no retry loop that again polls a TPM returning TPM_RC_TESTING in
this case.

Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
---
Patch depends on https://patchwork.kernel.org/patch/10105483/

 drivers/char/tpm/tpm2-cmd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index c17e753..b5c34d8 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -871,6 +871,14 @@ static int tpm2_do_selftest(struct tpm_chip *chip)
 		tpm_msleep(delay_msec);
 	}
 
+	if (rc != TPM2_RC_SUCCESS) {
+		cmd.header.in = tpm2_selftest_header;
+		cmd.params.selftest_in.full_test = 1;
+
+		rc = tpm_transmit_cmd(chip, NULL, &cmd, TPM2_SELF_TEST_IN_SIZE,
+				      0, 0, "full selftest");
+	}
+
 	return rc;
 }
 
-- 
2.7.4

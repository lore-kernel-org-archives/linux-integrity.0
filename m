Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:59584 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752054AbeBHUbR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 8 Feb 2018 15:31:17 -0500
Message-ID: <1518121876.21828.16.camel@HansenPartnership.com>
Subject: [PATCH v2 4/5] tpm_i2c_nuvoton: fix potential buffer overruns
 caused by bit glitches on the bus
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-integrity@vger.kernel.org
Cc: Jeremy Boone <Jeremy.Boone@nccgroup.trust>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Thu, 08 Feb 2018 12:31:16 -0800
In-Reply-To: <1518121576.21828.10.camel@HansenPartnership.com>
References: <1518121576.21828.10.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

From: Jeremy Boone <jeremy.boone@nccgroup.trust>

Discrete TPMs are often connected over slow serial buses which, on
some platforms, can have glitches causing bit flips.  In all the
driver _recv() functions, we need to use a u32 to unmarshal the
response size, otherwise a bit flip of the 31st bit would cause the
expected variable to go negative, which would then try to read a huge
amount of data.  Also sanity check that the expected amount of data is
large enough for the TPM header.

Signed-off-by: Jeremy Boone <jeremy.boone@nccgroup.trust>
Cc: stable@vger.kernel.org
Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 drivers/char/tpm/tpm_i2c_nuvoton.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_i2c_nuvoton.c b/drivers/char/tpm/tpm_i2c_nuvoton.c
index c6428771841f..17cf7af9a2c5 100644
--- a/drivers/char/tpm/tpm_i2c_nuvoton.c
+++ b/drivers/char/tpm/tpm_i2c_nuvoton.c
@@ -281,7 +281,8 @@ static int i2c_nuvoton_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 	struct device *dev = chip->dev.parent;
 	struct i2c_client *client = to_i2c_client(dev);
 	s32 rc;
-	int expected, status, burst_count, retries, size = 0;
+	int status, burst_count, retries, size = 0;
+	u32 expected;
 
 	if (count < TPM_HEADER_SIZE) {
 		i2c_nuvoton_ready(chip);    /* return to idle */
@@ -323,7 +324,7 @@ static int i2c_nuvoton_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 		 * to machine native
 		 */
 		expected = be32_to_cpu(*(__be32 *) (buf + 2));
-		if (expected > count) {
+		if (expected > count || expected < size) {
 			dev_err(dev, "%s() expected > count\n", __func__);
 			size = -EIO;
 			continue;
-- 
2.12.3

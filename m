Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:49822 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753772AbeBBRZh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 2 Feb 2018 12:25:37 -0500
Message-ID: <1517592333.3137.20.camel@HansenPartnership.com>
Subject: [PATCH 2/2] tpm drivers: fix potential buffer overruns caused by
 bit glitches on the bus
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-integrity@vger.kernel.org
Cc: Jeremy Boone <Jeremy.Boone@nccgroup.trust>
Date: Fri, 02 Feb 2018 18:25:33 +0100
In-Reply-To: <1517592221.3137.18.camel@HansenPartnership.com>
References: <1517592221.3137.18.camel@HansenPartnership.com>
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
 drivers/char/tpm/st33zp24/st33zp24.c | 4 ++--
 drivers/char/tpm/tpm_i2c_infineon.c  | 5 +++--
 drivers/char/tpm/tpm_i2c_nuvoton.c   | 5 +++--
 drivers/char/tpm/tpm_tis_core.c      | 5 +++--
 4 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/char/tpm/st33zp24/st33zp24.c b/drivers/char/tpm/st33zp24/st33zp24.c
index 4d1dc8b46877..f95b9c75175b 100644
--- a/drivers/char/tpm/st33zp24/st33zp24.c
+++ b/drivers/char/tpm/st33zp24/st33zp24.c
@@ -457,7 +457,7 @@ static int st33zp24_recv(struct tpm_chip *chip, unsigned char *buf,
 			    size_t count)
 {
 	int size = 0;
-	int expected;
+	u32 expected;
 
 	if (!chip)
 		return -EBUSY;
@@ -474,7 +474,7 @@ static int st33zp24_recv(struct tpm_chip *chip, unsigned char *buf,
 	}
 
 	expected = be32_to_cpu(*(__be32 *)(buf + 2));
-	if (expected > count) {
+	if (expected > count || expected < TPM_HEADER_SIZE) {
 		size = -EIO;
 		goto out;
 	}
diff --git a/drivers/char/tpm/tpm_i2c_infineon.c b/drivers/char/tpm/tpm_i2c_infineon.c
index 79d6bbb58e39..d5b44cadac56 100644
--- a/drivers/char/tpm/tpm_i2c_infineon.c
+++ b/drivers/char/tpm/tpm_i2c_infineon.c
@@ -473,7 +473,8 @@ static int recv_data(struct tpm_chip *chip, u8 *buf, size_t count)
 static int tpm_tis_i2c_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 {
 	int size = 0;
-	int expected, status;
+	int status;
+	u32 expected;
 
 	if (count < TPM_HEADER_SIZE) {
 		size = -EIO;
@@ -488,7 +489,7 @@ static int tpm_tis_i2c_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 	}
 
 	expected = be32_to_cpu(*(__be32 *)(buf + 2));
-	if ((size_t) expected > count) {
+	if (((size_t) expected > count) || (expected < TPM_HEADER_SIZE)) {
 		size = -EIO;
 		goto out;
 	}
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
diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index fdde971bc810..7561922bc8f8 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -202,7 +202,8 @@ static int tpm_tis_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 {
 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
 	int size = 0;
-	int expected, status;
+	int status;
+	u32 expected;
 
 	if (count < TPM_HEADER_SIZE) {
 		size = -EIO;
@@ -217,7 +218,7 @@ static int tpm_tis_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 	}
 
 	expected = be32_to_cpu(*(__be32 *) (buf + 2));
-	if (expected > count) {
+	if (expected > count || expected < TPM_HEADER_SIZE) {
 		size = -EIO;
 		goto out;
 	}
-- 
2.12.3

Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:59540 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752248AbeBHU3L (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 8 Feb 2018 15:29:11 -0500
Message-ID: <1518121749.21828.13.camel@HansenPartnership.com>
Subject: [PATCH v2 2/5] tpm: st33zp24: fix potential buffer overruns caused
 by bit glitches on the bus
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-integrity@vger.kernel.org
Cc: Jeremy Boone <Jeremy.Boone@nccgroup.trust>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Thu, 08 Feb 2018 12:29:09 -0800
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
 drivers/char/tpm/st33zp24/st33zp24.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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
-- 
2.12.3

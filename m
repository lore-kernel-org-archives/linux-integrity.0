Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:59498 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751786AbeBHU2J (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 8 Feb 2018 15:28:09 -0500
Message-ID: <1518121688.21828.12.camel@HansenPartnership.com>
Subject: [PATCH v2 1/5] tpm: fix potential buffer overruns caused by bit
 glitches on the bus
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-integrity@vger.kernel.org
Cc: Jeremy Boone <Jeremy.Boone@nccgroup.trust>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Thu, 08 Feb 2018 12:28:08 -0800
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

From: Jeremy Boone <jeremy.boone@nccgroup.trust>

Discrete TPMs are often connected over slow serial buses which, on
some platforms, can have glitches causing bit flips.  If a bit does
flip it could cause an overrun if it's in one of the size parameters,
so sanity check that we're not overrunning the provided buffer when
doing a memcpy().

Signed-off-by: Jeremy Boone <jeremy.boone@nccgroup.trust>
Cc: stable@vger.kernel.org
Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
v2: add -EFAULT for received being too big

 drivers/char/tpm/tpm-interface.c | 4 ++++
 drivers/char/tpm/tpm2-cmd.c      | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 1d6729be4cd6..3cec403a80b3 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -1228,6 +1228,10 @@ int tpm_get_random(u32 chip_num, u8 *out, size_t max)
 			break;
 
 		recd = be32_to_cpu(tpm_cmd.params.getrandom_out.rng_data_len);
+		if (recd > num_bytes) {
+			total = -EFAULT;
+			break;
+		}
 
 		rlength = be32_to_cpu(tpm_cmd.header.out.length);
 		if (rlength < offsetof(struct tpm_getrandom_out, rng_data) +
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index f40d20671a78..f6be08483ae6 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -683,6 +683,10 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
 	if (!rc) {
 		data_len = be16_to_cpup(
 			(__be16 *) &buf.data[TPM_HEADER_SIZE + 4]);
+		if (data_len < MIN_KEY_SIZE ||  data_len > MAX_KEY_SIZE + 1) {
+			rc = -EFAULT;
+			goto out;
+		}
 
 		rlength = be32_to_cpu(((struct tpm2_cmd *)&buf)
 					->header.out.length);
-- 
2.12.3

Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:49804 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754013AbeBBRYl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 2 Feb 2018 12:24:41 -0500
Message-ID: <1517592278.3137.19.camel@HansenPartnership.com>
Subject: [PATCH 1/2] tpm: fix potential buffer overruns caused by bit
 glitches on the bus
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-integrity@vger.kernel.org
Cc: Jeremy Boone <Jeremy.Boone@nccgroup.trust>
Date: Fri, 02 Feb 2018 18:24:38 +0100
In-Reply-To: <1517592221.3137.18.camel@HansenPartnership.com>
References: <1517592221.3137.18.camel@HansenPartnership.com>
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
 drivers/char/tpm/tpm-interface.c | 1 +
 drivers/char/tpm/tpm2-cmd.c      | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 1d6729be4cd6..e99f4f71c74f 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -1228,6 +1228,7 @@ int tpm_get_random(u32 chip_num, u8 *out, size_t max)
 			break;
 
 		recd = be32_to_cpu(tpm_cmd.params.getrandom_out.rng_data_len);
+		recd = min_t(u32, recd, num_bytes);
 
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

Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.35.192.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AB051EE0C;
	Wed, 23 Sep 2026 14:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.35.192.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790173728; cv=none; b=ZT2BoLVfFn3hbGR0/U9FpIyNOFYIlpdzEGuYzwxLxgpbvE3FDXeIYRy9w9YT2zl8ZycE2D5JRXilQu/Eo61946Os4GpFa3VW/lZKTYBueQYachdNbFPw408+dwpMypUQYlg2r/hLKcNsn3PlpZURd2m7PMCJUlTJodS5FyV02b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790173728; c=relaxed/simple;
	bh=6V/FPNOvBFH748T/14kaf9xryzKAI/Hhv8yBkrgQ8tM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rrbtMih2gCPdHdD+efoH1Jx76yNPqGn7KkKPQdE3dIlwszyShIaAHXCeKTIuX1iDUo3K6saNwK5Wze2TxO3ZizETuxpglBT4QhwfNECqGvKUiacXTXwj4IdG5x9lNqoDlPaA8rQ/nMGxaaCD5K1uTHAa+uybOtBDOLzChDcdd0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=EIKtNL8J; arc=none smtp.client-ip=52.35.192.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="EIKtNL8J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1790173727; x=1821709727;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Uuh0YXIr7uQKnXZCShNmV0tXrf6ZnfjJ1uvKFzeXwzg=;
  b=EIKtNL8JIQr64CBJmz22V406XE9RMIM0A0+7S9MZTprUOCnHn3VhWg08
   RJZ9sNSfaiZxZdFBhknLlkPrIirL0vXdmvv6hAJgLyTs46kjfGQ6HBu0U
   io8TNkJRtQr/LQp+QB3EVf+dMcHcAtOeNFAyKux0koWctbVyT2Zf5rRm4
   8hictxqAWM1zBqwH0T+VGpSfaA0tLETUFWOruLgQR6A2GMTAGahqej6/1
   LHvS1vtQo53nSWmO7oP/30I9kHQGQStqxoGJFPq1LBJBTFfOQJQKhDCdJ
   5wCUU1hksn83obmUKO8EumZV2xBJLJAbVuymURFsWsNY1qCndkgG+zi+X
   A==;
X-CSE-ConnectionGUID: BvbQbaySQTeQB1toT4DSQw==
X-CSE-MsgGUID: cu2qSgygRjm9oSH+s6qQlA==
X-IronPort-AV: E=Sophos;i="6.27,118,1787011200"; 
   d="scan'208";a="29212466"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 14:28:44 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:31476]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.16.27:2525] with esmtp (Farcaster)
 id c86b4e3d-b198-4e80-99fc-abd7bd81db9e; Wed, 23 Sep 2026 14:28:44 +0000 (UTC)
X-Farcaster-Flow-ID: c86b4e3d-b198-4e80-99fc-abd7bd81db9e
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Wed, 23 Sep 2026 14:28:44 +0000
Received: from dev-dsk-surenkj-2b-416930d2.us-west-2.amazon.com (10.169.26.94)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Wed, 23 Sep 2026 14:28:43 +0000
From: Surendran Kanagaraj <surenkj@amazon.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>
CC: <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nh-open-source@amazon.com>, Alexander Graf <graf@amazon.de>, "Gunnar
 Kudrjavets" <gunnarku@amazon.com>, Josh Levinson <joshlev@amazon.com>
Subject: [PATCH 1/2] tpm: Add per-chip timeout for transient unavailability
Date: Wed, 23 Sep 2026 14:28:33 +0000
Message-ID: <20260923142834.16786-2-surenkj@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260923142834.16786-1-surenkj@amazon.com>
References: <20260923142834.16786-1-surenkj@amazon.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWB003.ant.amazon.com (10.13.138.85) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

TPM commands need to complete within the command duration defined
in the TPM2 spec or to keep answering TPM2_RC_RETRY for at most
TPM2_DURATION_LONG (2s).

Devices that have different timeout requirements than the TPM2 spec
could exhaust the retry budget or exceed the command duration. These
failures disable the device during an auth session, failing all
subsequent TPM requests. Worse, when a TPM2_CC_FLUSH_CONTEXT command
fails, it leaks the TPM's transient memory:

    tpm tpm0: in retry loop
    tpm tpm0: tpm2_load_context: failed with a TPM error 0x0922
    ...
    tpm tpm0: A TPM error (2338) occurred flushing context

Fix this by adding chip->busy_timeout_ms to support devices that know
the expected delay window. This value raises the TPM2_RC_RETRY retry
budget and per-command durations to at least busy_timeout_ms. Chips
that leave it at 0 keep the current timeouts. The driver sets it for
NitroTPM in the following patch.

Tested with CONFIG_TCG_TPM2_HMAC=y and the following patch with the
NitroTPM quirk applied, in QEMU with swtpm by stalling commands and
holding the TPM in TPM2_RC_RETRY.

Assisted-by: LLM
Signed-off-by: Surendran Kanagaraj <surenkj@amazon.com>
---
 drivers/char/tpm/tpm-interface.c | 11 ++++++++---
 drivers/char/tpm/tpm.h           |  2 +-
 drivers/char/tpm/tpm2-cmd.c      | 17 ++++++++++++-----
 include/linux/tpm.h              |  7 +++++++
 4 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 0bab78c8767c..a423395b201a 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -53,7 +53,7 @@ MODULE_PARM_DESC(suspend_pcr,
 unsigned long tpm_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal)
 {
 	if (chip->flags & TPM_CHIP_FLAG_TPM2)
-		return tpm2_calc_ordinal_duration(ordinal);
+		return tpm2_calc_ordinal_duration(chip, ordinal);
 	else
 		return tpm1_calc_ordinal_duration(chip, ordinal);
 }
@@ -213,7 +213,8 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
  *
  * A wrapper around tpm_try_transmit() that handles TPM2_RC_RETRY returns from
  * the TPM and retransmits the command after a delay up to a maximum wait of
- * TPM2_DURATION_LONG.
+ * TPM2_DURATION_LONG, or chip->busy_timeout_ms when the driver declared a
+ * longer transient unavailability window.
  *
  * Note that TPM 1.x never returns TPM2_RC_RETRY so the retry logic is TPM 2.0
  * only.
@@ -228,6 +229,7 @@ ssize_t tpm_transmit(struct tpm_chip *chip, u8 *buf, size_t bufsiz)
 	/* space for header and handles */
 	u8 save[TPM_HEADER_SIZE + 3*sizeof(u32)];
 	unsigned int delay_msec = TPM2_DURATION_SHORT;
+	unsigned int max_delay_msec = TPM2_DURATION_LONG;
 	u32 rc = 0;
 	ssize_t ret;
 	const size_t save_size = min(sizeof(save), bufsiz);
@@ -241,6 +243,9 @@ ssize_t tpm_transmit(struct tpm_chip *chip, u8 *buf, size_t bufsiz)
 	 */
 	memcpy(save, buf, save_size);
 
+	if (chip->busy_timeout_ms > max_delay_msec)
+		max_delay_msec = chip->busy_timeout_ms;
+
 	for (;;) {
 		ret = tpm_try_transmit(chip, buf, bufsiz);
 		if (ret < 0)
@@ -255,7 +260,7 @@ ssize_t tpm_transmit(struct tpm_chip *chip, u8 *buf, size_t bufsiz)
 		if (rc == TPM2_RC_TESTING && cc == TPM2_CC_SELF_TEST)
 			break;
 
-		if (delay_msec > TPM2_DURATION_LONG) {
+		if (delay_msec > max_delay_msec) {
 			if (rc == TPM2_RC_RETRY)
 				dev_err(&chip->dev, "in retry loop\n");
 			else
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index fa554c5ad80b..457eba8d03dd 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -119,7 +119,7 @@ ssize_t tpm2_get_tpm_pt(struct tpm_chip *chip, u32 property_id,
 ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip);
 int tpm2_auto_startup(struct tpm_chip *chip);
 void tpm2_shutdown(struct tpm_chip *chip, u16 shutdown_type);
-unsigned long tpm2_calc_ordinal_duration(u32 ordinal);
+unsigned long tpm2_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal);
 int tpm2_probe(struct tpm_chip *chip);
 int tpm2_get_cc_attrs_tbl(struct tpm_chip *chip);
 int tpm2_find_cc(struct tpm_chip *chip, u32 cc);
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index ae22295df798..dc5ed57fefe1 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -78,20 +78,27 @@ static const struct {
 
 /**
  * tpm2_calc_ordinal_duration() - Calculate the maximum command duration
+ * @chip:	TPM chip to use.
  * @ordinal: TPM command ordinal.
  *
  * Returns the maximum amount of time the chip is expected by kernel to
- * take in jiffies.
+ * take in jiffies. The duration is never lower than chip->busy_timeout_ms.
  */
-unsigned long tpm2_calc_ordinal_duration(u32 ordinal)
+unsigned long tpm2_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal)
 {
+	unsigned long duration = TPM2_DURATION_DEFAULT;
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(tpm2_ordinal_duration_map); i++)
-		if (ordinal == tpm2_ordinal_duration_map[i].ordinal)
-			return msecs_to_jiffies(tpm2_ordinal_duration_map[i].duration);
+		if (ordinal == tpm2_ordinal_duration_map[i].ordinal) {
+			duration = tpm2_ordinal_duration_map[i].duration;
+			break;
+		}
+
+	if (duration < chip->busy_timeout_ms)
+		duration = chip->busy_timeout_ms;
 
-	return msecs_to_jiffies(TPM2_DURATION_DEFAULT);
+	return msecs_to_jiffies(duration);
 }
 
 /**
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 0db277af45c3..7089067412d3 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -140,6 +140,13 @@ struct tpm_chip {
 	unsigned long duration[TPM_NUM_DURATIONS]; /* jiffies */
 	bool duration_adjusted;
 
+	/*
+	 * Longest unavailability expected from the chip in ms. Raises the
+	 * TPM2_RC_RETRY retry budget and the per-command durations to at
+	 * least this value; 0 keeps the defaults.
+	 */
+	unsigned int busy_timeout_ms;
+
 	struct dentry *bios_dir;
 
 	const struct attribute_group *groups[3 + TPM_MAX_HASHES];
-- 
2.47.3


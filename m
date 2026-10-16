Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.35.192.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556C1195B1A;
	Fri, 16 Oct 2026 04:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.35.192.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792125479; cv=none; b=WpRv2829yRx1WvOLxUNzJes2DlzZy3I4wgl14x8CwAGTU/Uwt2TuF0cv7TpF8qnRWE87NBShsOds3bC8s/zP2GMbrmi2LGFXwd/PtnH4eE+WlEm7ml0jMiKKd90WN//gggv6PUG/olGwiy4e7rqxzjuUHFKHmJLBbOfPNR6HQbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792125479; c=relaxed/simple;
	bh=/n37cvqygxqRsk7m3swwrV0SoW3HDjFVpl1HY36MuqY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MHXzD23N5t6LeuABV45gg/19jDvmj5MAvKCLCBsc/+82WvAMIOsvNmBeZsw6F8ZXzEHYITDHv30PJSiwh3orpVQ1zLL2vH+//nYEzabZ8Pfm39wY91i36g/LjpeLBEDdigf9WtG1InJrE5l2V1TLMaZob8MUwdf0HcV9z3fmdCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=LYcs8Tw5; arc=none smtp.client-ip=52.35.192.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="LYcs8Tw5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1792125478; x=1823661478;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=97BoQVnGSM158glx0QRyKA2yNBmZOhBj32cKPdypWco=;
  b=LYcs8Tw5hWD01nKAn84w2vmw2NEfk3pEQOtG+LHc/uBIjcPGyhuByom3
   qTPjC2u+tyi+p972FENkIEk8Z4i2POWSTp4v4dIumK0pwO3+dzqDTdWDy
   RJray2t5SiOsTMuEv+xUk4SY+45rOXp7pXMzBVrr3G/rs+cB/EZ8tmHpd
   0HSGxzZSj41N9P7YiNrLx/qodAUbM4x168b0Jl3+5EcX5zNMobGezOW7V
   zIcPaaXaHthaDxfZavWJDxwKDPTRA8/uOX3/RTAUlpj5aOFpfAaUzifRD
   fu0Zz1GZlwb4Jt7IyuJATXLe3KLLd8omRV+IaJj7GTwFVhLBDtdauyiDk
   A==;
X-CSE-ConnectionGUID: TtfTAuETQWq782Q1EPBT/g==
X-CSE-MsgGUID: 7cZDpVNrSf24vNGwVwXTmA==
X-IronPort-AV: E=Sophos;i="6.27,161,1787011200"; 
   d="scan'208";a="31174092"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 04:37:55 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:28912]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.104:2525] with esmtp (Farcaster)
 id 90ee4d78-061d-43d3-9010-9e828081ed8b; Fri, 16 Oct 2026 04:37:55 +0000 (UTC)
X-Farcaster-Flow-ID: 90ee4d78-061d-43d3-9010-9e828081ed8b
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Fri, 16 Oct 2026 04:37:54 +0000
Received: from dev-dsk-surenkj-2b-416930d2.us-west-2.amazon.com (10.169.26.94)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53;
 Fri, 16 Oct 2026 04:37:54 +0000
From: Surendran Kanagaraj <surenkj@amazon.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>
CC: <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Breno
 Leitao" <leitao@debian.org>, <nh-open-source@amazon.com>, Alexander Graf
	<graf@amazon.de>, Gunnar Kudrjavets <gunnarku@amazon.com>, Josh Levinson
	<joshlev@amazon.com>
Subject: [PATCH v2 1/2] tpm: Add support for updating TPM2 durations
Date: Fri, 16 Oct 2026 04:37:32 +0000
Message-ID: <20261016043733.30589-2-surenkj@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261016043733.30589-1-surenkj@amazon.com>
References: <20261016043733.30589-1-surenkj@amazon.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA001.ant.amazon.com (10.13.139.88) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

TPM commands need to complete within the command duration defined
in the TPM2 spec or keep answering TPM2_RC_RETRY for at most
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

Fix this by overriding the command durations and retry budget
based on chip->duration and letting the driver modify the durations
during tpm2_get_timeouts() as TPM 1.x does. Chips without
the override keep the current durations.

Tested in QEMU with swtpm on tpm_crb, tpm_tis, tpm_tis_i2c, tpm_ibmvtpm
and tpm_vtpm_proxy.

Assisted-by: LLM
Signed-off-by: Surendran Kanagaraj <surenkj@amazon.com>
---
V1 -> V2:
- Drop chip->busy_timeout_ms. TPM2 durations and the TPM2_RC_RETRY
  budget now come from chip->duration, which drivers adjust through
  ->update_durations() as TPM 1.x does.
- Map TPM2_CC_SELF_TEST and TPM2_CC_VERIFY_SIGNATURE to TPM_LONG with
  floors of 3s and 30s since their durations do not fit SHORT, MEDIUM,
  LONG durations.
- Keep the TPM2 defaults for commands sent before tpm2_get_timeouts()
  has run such as the one in tpm2_probe() and keep the 2s retry
  budget for TPM 1.x chips.
- Keep the first TPM2_RC_RETRY wait at TPM2_DURATION_SHORT instead of
  chip->duration[TPM_SHORT].
- Return early from tpm_tis_update_durations() for TPM2 chips, since
  its overrides are for TPM 1.x.
- Rename from "tpm: Add per-chip timeout for transient unavailability".

v1: https://lore.kernel.org/linux-integrity/20260923142834.16786-2-surenkj@amazon.com/
---
 drivers/char/tpm/tpm-interface.c | 11 ++--
 drivers/char/tpm/tpm.h           |  2 +-
 drivers/char/tpm/tpm2-cmd.c      | 90 ++++++++++++++++++++++++--------
 drivers/char/tpm/tpm_tis_core.c  |  4 ++
 4 files changed, 81 insertions(+), 26 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index e0385b16616b..747e20ab421b 100644
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
@@ -214,7 +214,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
  *
  * A wrapper around tpm_try_transmit() that handles TPM2_RC_RETRY returns from
  * the TPM and retransmits the command after a delay up to a maximum wait of
- * TPM2_DURATION_LONG.
+ * chip->duration[TPM_LONG] (TPM2_DURATION_LONG until the durations are set).
  *
  * Note that TPM 1.x never returns TPM2_RC_RETRY so the retry logic is TPM 2.0
  * only.
@@ -229,12 +229,17 @@ ssize_t tpm_transmit(struct tpm_chip *chip, u8 *buf, size_t bufsiz)
 	/* space for header and handles */
 	u8 save[TPM_HEADER_SIZE + 3*sizeof(u32)];
 	unsigned int delay_msec = TPM2_DURATION_SHORT;
+	unsigned int max_delay_msec = TPM2_DURATION_LONG;
 	u32 rc = 0;
 	ssize_t ret;
 	const size_t save_size = min(sizeof(save), bufsiz);
 	/* the command code is where the return code will be */
 	u32 cc = be32_to_cpu(header->return_code);
 
+	if ((chip->flags & TPM_CHIP_FLAG_TPM2) &&
+	    (chip->flags & TPM_CHIP_FLAG_HAVE_TIMEOUTS))
+		max_delay_msec = jiffies_to_msecs(chip->duration[TPM_LONG]);
+
 	/*
 	 * Subtlety here: if we have a space, the handles will be
 	 * transformed, so when we restore the header we also have to
@@ -256,7 +261,7 @@ ssize_t tpm_transmit(struct tpm_chip *chip, u8 *buf, size_t bufsiz)
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
index 4b2bb2ddc321..83a9e78ac843 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -41,55 +41,101 @@ int tpm2_find_hash_alg(unsigned int crypto_id)
 }
 EXPORT_SYMBOL_GPL(tpm2_find_hash_alg);
 
+/*
+ * The TPM2 defaults of chip->duration[] in milliseconds, indexed by
+ * enum tpm_duration.
+ */
+static const unsigned int tpm2_durations_ms[TPM_NUM_DURATIONS] = {
+	[TPM_SHORT] = TPM2_DURATION_SHORT,
+	[TPM_MEDIUM] = TPM2_DURATION_MEDIUM,
+	[TPM_LONG] = TPM2_DURATION_LONG,
+	[TPM_LONG_LONG] = TPM2_DURATION_LONG_LONG,
+};
+
 int tpm2_get_timeouts(struct tpm_chip *chip)
 {
+	unsigned long durations[3];
+	int i;
+
 	chip->timeout_a = msecs_to_jiffies(TPM2_TIMEOUT_A);
 	chip->timeout_b = msecs_to_jiffies(TPM2_TIMEOUT_B);
 	chip->timeout_c = msecs_to_jiffies(TPM2_TIMEOUT_C);
 	chip->timeout_d = msecs_to_jiffies(TPM2_TIMEOUT_D);
+
+	for (i = 0; i < TPM_NUM_DURATIONS; i++)
+		chip->duration[i] = msecs_to_jiffies(tpm2_durations_ms[i]);
+
+	/* Provide the ability for vendor overrides of duration values. */
+	if (chip->ops->update_durations)
+		chip->ops->update_durations(chip, durations);
+
+	if (chip->duration_adjusted) {
+		chip->duration[TPM_SHORT] = durations[0];
+		chip->duration[TPM_MEDIUM] = durations[1];
+		chip->duration[TPM_LONG] = durations[2];
+	}
+
 	chip->flags |= TPM_CHIP_FLAG_HAVE_TIMEOUTS;
 	return 0;
 }
 
 /*
- * Contains the maximum durations in milliseconds for TPM2 commands.
+ * Maps each TPM2 command to the chip->duration[] entry that holds its
+ * maximum duration. min_ms, when set, is a lower bound in milliseconds.
  */
 static const struct {
 	unsigned long ordinal;
-	unsigned long duration;
+	enum tpm_duration index;
+	unsigned int min_ms;
 } tpm2_ordinal_duration_map[] = {
-	{TPM2_CC_STARTUP, 750},
-	{TPM2_CC_SELF_TEST, 3000},
-	{TPM2_CC_GET_RANDOM, 2000},
-	{TPM2_CC_SEQUENCE_UPDATE, 750},
-	{TPM2_CC_SEQUENCE_COMPLETE, 750},
-	{TPM2_CC_EVENT_SEQUENCE_COMPLETE, 750},
-	{TPM2_CC_HASH_SEQUENCE_START, 750},
-	{TPM2_CC_VERIFY_SIGNATURE, 30000},
-	{TPM2_CC_PCR_EXTEND, 750},
-	{TPM2_CC_HIERARCHY_CONTROL, 2000},
-	{TPM2_CC_HIERARCHY_CHANGE_AUTH, 2000},
-	{TPM2_CC_GET_CAPABILITY, 750},
-	{TPM2_CC_NV_READ, 2000},
-	{TPM2_CC_CREATE_PRIMARY, 300000},
-	{TPM2_CC_CREATE, 300000},
-	{TPM2_CC_CREATE_LOADED, 300000},
+	{TPM2_CC_STARTUP, TPM_MEDIUM},
+	{TPM2_CC_SELF_TEST, TPM_LONG, 3000},
+	{TPM2_CC_GET_RANDOM, TPM_LONG},
+	{TPM2_CC_SEQUENCE_UPDATE, TPM_MEDIUM},
+	{TPM2_CC_SEQUENCE_COMPLETE, TPM_MEDIUM},
+	{TPM2_CC_EVENT_SEQUENCE_COMPLETE, TPM_MEDIUM},
+	{TPM2_CC_HASH_SEQUENCE_START, TPM_MEDIUM},
+	{TPM2_CC_VERIFY_SIGNATURE, TPM_LONG, 30000},
+	{TPM2_CC_PCR_EXTEND, TPM_MEDIUM},
+	{TPM2_CC_HIERARCHY_CONTROL, TPM_LONG},
+	{TPM2_CC_HIERARCHY_CHANGE_AUTH, TPM_LONG},
+	{TPM2_CC_GET_CAPABILITY, TPM_MEDIUM},
+	{TPM2_CC_NV_READ, TPM_LONG},
+	{TPM2_CC_CREATE_PRIMARY, TPM_LONG_LONG},
+	{TPM2_CC_CREATE, TPM_LONG_LONG},
+	{TPM2_CC_CREATE_LOADED, TPM_LONG_LONG},
 };
 
 /**
  * tpm2_calc_ordinal_duration() - Calculate the maximum command duration
+ * @chip: TPM chip to use.
  * @ordinal: TPM command ordinal.
  *
  * Returns the maximum amount of time the chip is expected by kernel to
  * take in jiffies.
  */
-unsigned long tpm2_calc_ordinal_duration(u32 ordinal)
+unsigned long tpm2_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal)
 {
+	enum tpm_duration index;
+	unsigned long duration;
+	unsigned int min_ms;
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(tpm2_ordinal_duration_map); i++)
-		if (ordinal == tpm2_ordinal_duration_map[i].ordinal)
-			return msecs_to_jiffies(tpm2_ordinal_duration_map[i].duration);
+	for (i = 0; i < ARRAY_SIZE(tpm2_ordinal_duration_map); i++) {
+		if (ordinal != tpm2_ordinal_duration_map[i].ordinal)
+			continue;
+
+		index = tpm2_ordinal_duration_map[i].index;
+		min_ms = tpm2_ordinal_duration_map[i].min_ms;
+
+		/* chip->duration[] is unset until tpm2_get_timeouts() runs. */
+		if (chip->flags & TPM_CHIP_FLAG_HAVE_TIMEOUTS)
+			duration = chip->duration[index];
+		else
+			duration = msecs_to_jiffies(tpm2_durations_ms[index]);
+
+		return max(duration, msecs_to_jiffies(min_ms));
+	}
 
 	return msecs_to_jiffies(TPM2_DURATION_DEFAULT);
 }
diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 143ef160820e..3738a5dd33e9 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -645,6 +645,10 @@ static void tpm_tis_update_durations(struct tpm_chip *chip,
 	int i, rc;
 	cap_t cap;
 
+	/* The vendor overrides below are for TPM 1.x chips only. */
+	if (chip->flags & TPM_CHIP_FLAG_TPM2)
+		return;
+
 	chip->duration_adjusted = false;
 
 	if (chip->ops->clk_enable != NULL)
-- 
2.47.3


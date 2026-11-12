Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.12.53.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794501534;
	b=oJPSit+xTHGJkc67kU7Wd1d2ut0VBWJw9HDypl1PFoDmKFljvEVonWKh9EfcTtA7mPwm
	 9XEEvCJ+UZ9tDR8POpU0b7d/P1mdZzlsEmPxLnfScx7UtY+jBRRggvDN79eKNapPVIYDE
	 ldidE5w8HUP4ORzi///xZga7Q82G5kCi6Hjxrt64O0GctpV8BwjohKmgRMmDEXhkGrGKM
	 JMPT93nnQQl1iUa8nKT2nha03WHOEoUVJBbydPYdpbJey7J1kIMdVtmn0oQi9++JpFGJV
	 XSm0uOBNC5gEBveQ2N3/TumFu/x2KIGuhCtz9JMlvjCFs3ffNwA4CMutEELOxFkftUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794501534;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=VQ2dpBL7BKNbP97T/YcmevvQv5HGHABl73Y36Coef1U=;
	b=2t6rwoGujtEphLxazcY/CmbjwizCT7eQtvB1EnAsGTnQ0Hjj4G1F0hbNgO3TKO5lPaFz
	 RzSsvKTrJpOaTJh7ou3wSnnodG9Y4/WmhkaCzP8nwUaCJYZffmfzBR3Ngs1tLk+nEBkPr
	 SIdvBo6vJzYZoRyecNg1VDOYdMdrL+1/hL28UrSt43QdAZny0NsnHhfTMJQXoXn0Ujc+9
	 z1BdxlJBFaLZqOIWngyL7UHIRYxcAP0W0fSRW0U2i8fG2NfRs5THTzVQSnqqOEZwLqXoQ
	 FM179aZsstoBYcv1C/mHrCDcCiXKOEuuQ6cxbxkh2urFLLUCkw6moNcrhE+TmK/WACw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=baHvFL9t;
	arc=none smtp.remote-ip=52.12.53.23
Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C545C606A33D;
	Thu, 12 Nov 2026 16:38:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C545C606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=baHvFL9t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794501533; x=1826037533;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VQ2dpBL7BKNbP97T/YcmevvQv5HGHABl73Y36Coef1U=;
  b=baHvFL9t6z6UNcOp4q9iZcz5/ai9Pk/yha2dtU+OuuXqZFEdIFJabtdS
   cnX0ITkxKbrtC0sCk76qBneeK6zOjb924LW1Zd5bGRi/vPF1ZB6m7abY9
   6MJblbWSWAmjsukblXF7m5x2EXDbwDv2gLwXqdZIVQUO8e6DlxVjiUsWC
   Ov659vREPMzmVMj6HGRlCzB0zUhATe5JgVu3njQVG4ZJKXU7AbeCPh1si
   gR6kK9idN4GlG73r1T7eU/3Y3z4owZOfgEDypHP2t+tzhu88a94nM0o+E
   qrGMfaJkNJDT4Pa+gm1iyRpzWkfToxZAhWdhmeDzdHZRcLKKqGguI4zsN
   g==;
X-CSE-ConnectionGUID: gDMplQ+wR6KR5cH5QIk/ow==
X-CSE-MsgGUID: I2DBV+EASCetJNAhdZZl4Q==
X-IronPort-AV: E=Sophos;i="6.27,210,1787011200"; 
   d="scan'208";a="33699582"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 16:38:51 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:26362]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.34.255:2525] with esmtp (Farcaster)
 id e5879bda-9f83-4712-8e50-d5ac7aa5b1a4; Thu, 12 Nov 2026 16:38:50 +0000 (UTC)
X-Farcaster-Flow-ID: e5879bda-9f83-4712-8e50-d5ac7aa5b1a4
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Thu, 12 Nov 2026 16:38:50 +0000
Received: from dev-dsk-surenkj-2b-416930d2.us-west-2.amazon.com (10.169.26.94)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Thu, 12 Nov 2026 16:38:50 +0000
From: Surendran Kanagaraj <surenkj@amazon.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, Peter Huewe <peterhuewe@gmx.de>
CC: Jason Gunthorpe <jgg@ziepe.ca>, <linux-integrity@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, Jonathan McDowell <noodles@earth.li>, "Breno
 Leitao" <leitao@debian.org>, <nh-open-source@amazon.com>, Alexander Graf
	<graf@amazon.de>, Gunnar Kudrjavets <gunnarku@amazon.com>, Josh Levinson
	<joshlev@amazon.com>
Subject: [RFC PATCH v3 4/8] tpm: Bound core and CRB waits by the limits table
Date: Thu, 12 Nov 2026 16:38:42 +0000
Message-ID: <20261112163846.97654-5-surenkj@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261112163846.97654-1-surenkj@amazon.com>
References: <20261112163846.97654-1-surenkj@amazon.com>
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC004.ant.amazon.com (10.13.139.246) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Polls in tpm_try_transmit() still use fixed 1 ms sleeps and
tpm_transmit() stops retrying once the next backoff would pass
TPM2_DURATION_LONG and tpm_crb always waits TPM2_TIMEOUT_C.
A value set through ->adjust_limits() reaches neither the retry
loop nor the crb waits.

Poll for completion with tpm_poll_timeout(). Its sleeps start at 100 us
and double up to 1 ms. It checks the condition once more after the
deadline and an expired wait logs the limit and where its value came
from. Bound the total sleep of the retry loop  by the LONG duration,
whose 3 s TPM 2.0 default keeps the current seven retries. Until the
timing query sets the family, LONG holds the 120 s TPM 1.x default,
so the loop uses the TPM 2.0 one instead. tpm_crb waits on TIMEOUT_C
through tpm_poll_timeout(). The Pluton doorbell's completion wait,
which no spec names keeps its 200 ms through tpm_poll_timeout_us().

Two waits behave differently. Completion polling first sleeps at most
100 us instead of 1 ms. Until tpm2_get_timeouts() runs, tpm_crb waits
up to 750 ms for TIMEOUT_C, the larger of the two families' defaults,
instead of 200 ms. From then on it waits 200 ms as before.

Signed-off-by: Surendran Kanagaraj <surenkj@amazon.com>
---
 drivers/char/tpm/tpm-interface.c | 57 +++++++++++++-------------
 drivers/char/tpm/tpm-limits.c    | 19 +++++++++
 drivers/char/tpm/tpm.h           |  2 +-
 drivers/char/tpm/tpm_crb.c       | 70 +++++++++++++++++---------------
 4 files changed, 87 insertions(+), 61 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 8e6ea9c04019..0df39f4ba30b 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -103,6 +103,16 @@ static void tpm_go_idle(struct tpm_chip *chip)
 		chip->ops->go_idle(chip);
 }
 
+/* Poll condition: the command completed or was canceled. */
+static bool tpm_cmd_done(struct tpm_chip *chip, void *arg)
+{
+	u8 *status = arg;
+
+	*status = tpm_chip_status(chip);
+	return tpm_transmit_completed(*status, chip) ||
+	       tpm_chip_req_canceled(chip, *status);
+}
+
 DEFINE_FREE(tpm_go_idle, struct tpm_chip *, if (_T) tpm_go_idle(_T))
 
 static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
@@ -112,7 +122,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
 	int rc;
 	ssize_t len = 0;
 	u32 count, ordinal;
-	unsigned long stop;
+	u8 status;
 
 	if (bufsiz < TPM_HEADER_SIZE)
 		return -EINVAL;
@@ -173,31 +183,19 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
 	if (chip->flags & TPM_CHIP_FLAG_IRQ)
 		goto out_recv;
 
-	stop = jiffies + tpm_calc_ordinal_duration(chip, ordinal);
-	do {
-		u8 status = tpm_chip_status(chip);
-		if (tpm_transmit_completed(status, chip))
-			goto out_recv;
-
-		if (tpm_chip_req_canceled(chip, status)) {
-			dev_err(&chip->dev, "Operation Canceled\n");
-			return -ECANCELED;
-		}
-
-		tpm_msleep(TPM_TIMEOUT_POLL);
-		rmb();
-	} while (time_before(jiffies, stop));
-
-	/*
-	 * Check for completion one more time, just in case the device reported
-	 * it while the driver was sleeping in the busy loop above.
-	 */
-	if (tpm_transmit_completed(tpm_chip_status(chip), chip))
-		goto out_recv;
+	if (tpm_poll_timeout(chip, tpm_duration_limit(chip, ordinal),
+			     tpm_cmd_done, &status)) {
+		tpm_chip_cancel(chip);
+		dev_err(&chip->dev, "Operation Timed out\n");
+		return -ETIME;
+	}
+	/* Read the response only after the status reported completion. */
+	rmb();
 
-	tpm_chip_cancel(chip);
-	dev_err(&chip->dev, "Operation Timed out\n");
-	return -ETIME;
+	if (!tpm_transmit_completed(status, chip)) {
+		dev_err(&chip->dev, "Operation Canceled\n");
+		return -ECANCELED;
+	}
 
 out_recv:
 	len = chip->ops->recv(chip, buf, bufsiz);
@@ -220,8 +218,8 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
  * @bufsiz:	length of the TPM command buffer
  *
  * A wrapper around tpm_try_transmit() that handles TPM2_RC_RETRY returns from
- * the TPM and retransmits the command after a delay up to a maximum wait of
- * TPM2_DURATION_LONG.
+ * the TPM and retransmits the command after a doubling delay, for as long as
+ * the sleeps fit in the chip's LONG duration limit.
  *
  * Note that TPM 1.x never returns TPM2_RC_RETRY so the retry logic is TPM 2.0
  * only.
@@ -236,6 +234,7 @@ ssize_t tpm_transmit(struct tpm_chip *chip, u8 *buf, size_t bufsiz)
 	/* space for header and handles */
 	u8 save[TPM_HEADER_SIZE + 3*sizeof(u32)];
 	unsigned int delay_msec = TPM2_DURATION_SHORT;
+	unsigned int slept_msec = 0;
 	u32 rc = 0;
 	ssize_t ret;
 	const size_t save_size = min(sizeof(save), bufsiz);
@@ -263,7 +262,8 @@ ssize_t tpm_transmit(struct tpm_chip *chip, u8 *buf, size_t bufsiz)
 		if (rc == TPM2_RC_TESTING && cc == TPM2_CC_SELF_TEST)
 			break;
 
-		if (delay_msec > TPM2_DURATION_LONG) {
+		if ((slept_msec + delay_msec) * USEC_PER_MSEC >
+		    tpm_limits_retry_us(chip)) {
 			if (rc == TPM2_RC_RETRY)
 				dev_err(&chip->dev, "in retry loop\n");
 			else
@@ -272,6 +272,7 @@ ssize_t tpm_transmit(struct tpm_chip *chip, u8 *buf, size_t bufsiz)
 			break;
 		}
 		tpm_msleep(delay_msec);
+		slept_msec += delay_msec;
 		delay_msec *= 2;
 		memcpy(buf, save, save_size);
 	}
diff --git a/drivers/char/tpm/tpm-limits.c b/drivers/char/tpm/tpm-limits.c
index 8e3c2afdd439..a68c39b1e5ea 100644
--- a/drivers/char/tpm/tpm-limits.c
+++ b/drivers/char/tpm/tpm-limits.c
@@ -288,6 +288,25 @@ void tpm_limits_apply_quirks(struct tpm_limits *p,
 }
 EXPORT_SYMBOL_GPL(tpm_limits_apply_quirks);
 
+/**
+ * tpm_limits_retry_us() - the total sleep allowed between resubmissions
+ * @chip:	the TPM chip
+ *
+ * The LONG duration bounds how long tpm_transmit() keeps resubmitting a
+ * command the TPM asked to retry. Until the timing query sets the family,
+ * LONG holds the larger TPM 1.x default, so use the TPM 2.0 one: only a
+ * TPM 2.0 chip asks for a retry.
+ *
+ * Return: the bound in microseconds.
+ */
+u32 tpm_limits_retry_us(struct tpm_chip *chip)
+{
+	if (chip->limits.family == TPM_FAMILY_UNKNOWN)
+		return tpm2_defaults[TPM_LIMIT_LONG];
+
+	return chip->limits.entry[TPM_LIMIT_LONG].time_us;
+}
+
 static u32 tpm_limits_us(struct tpm_chip *chip, enum tpm_limit limit)
 {
 	if (!chip)
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 1e023f12a400..152cd392fa22 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -40,7 +40,6 @@ enum tpm_timeout {
 	TPM_TIMEOUT = 5,	/* msecs */
 	TPM_TIMEOUT_RETRY = 100, /* msecs */
 	TPM_TIMEOUT_RANGE_US = 300,	/* usecs */
-	TPM_TIMEOUT_POLL = 1,	/* msecs */
 	TPM_TIMEOUT_USECS_MIN = 100,      /* usecs */
 	TPM_TIMEOUT_USECS_MAX = 500      /* usecs */
 };
@@ -82,6 +81,7 @@ void tpm_limits_driver_set(struct tpm_limits *p, enum tpm_limit limit, u32 us);
 void tpm_limits_apply_quirks(struct tpm_limits *p,
 			     const struct tpm_limits_quirk *quirks, size_t n,
 			     u32 id);
+u32 tpm_limits_retry_us(struct tpm_chip *chip);
 int tpm_poll_timeout(struct tpm_chip *chip, enum tpm_limit limit,
 		     bool (*cond)(struct tpm_chip *chip, void *arg), void *arg);
 int tpm_poll_timeout_us(struct tpm_chip *chip, u32 timeout_us,
diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index 4749a9183726..7c1011eb855a 100644
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -112,6 +112,7 @@ struct crb_priv {
 	u8 ffa_flags;
 	u8 ffa_attributes;
 	u32 intf_id;
+	struct tpm_chip *chip;	/* NULL until tpmm_chip_alloc() */
 };
 
 struct tpm2_crb_smc {
@@ -135,6 +136,12 @@ struct tpm2_crb_pluton {
 	u64 reply_addr;
 };
 
+struct crb_reg_wait {
+	u32 __iomem *reg;
+	u32 mask;
+	u32 value;
+};
+
 /*
  * Returns true if the start method supports idle.
  */
@@ -145,39 +152,40 @@ static inline bool tpm_crb_has_idle(u32 start_method)
 	       start_method == ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC);
 }
 
-static bool crb_wait_for_reg_32(u32 __iomem *reg, u32 mask, u32 value,
-				unsigned long timeout)
+static bool crb_reg_matches(struct tpm_chip *chip, void *arg)
 {
-	ktime_t start;
-	ktime_t stop;
+	struct crb_reg_wait *w = arg;
 
-	start = ktime_get();
-	stop = ktime_add(start, ms_to_ktime(timeout));
-
-	do {
-		if ((ioread32(reg) & mask) == value)
-			return true;
+	return (ioread32(w->reg) & w->mask) == w->value;
+}
 
-		usleep_range(50, 100);
-	} while (ktime_before(ktime_get(), stop));
+/* Wait up to TIMEOUT_C for the @mask bits of @reg to read as @value. */
+static bool crb_wait_for_reg_32(struct crb_priv *priv, u32 __iomem *reg,
+				u32 mask, u32 value)
+{
+	struct crb_reg_wait w = { .reg = reg, .mask = mask, .value = value };
 
-	return ((ioread32(reg) & mask) == value);
+	return !tpm_poll_timeout(priv->chip, TPM_LIMIT_C, crb_reg_matches, &w);
 }
 
 static int crb_try_pluton_doorbell(struct crb_priv *priv, bool wait_for_complete)
 {
+	struct crb_reg_wait w = {
+		.reg = priv->pluton_start_addr, .mask = 0xffffffff, .value = 0,
+	};
+
 	if (priv->sm != ACPI_TPM2_COMMAND_BUFFER_WITH_PLUTON)
 		return 0;
 
-	if (!crb_wait_for_reg_32(priv->pluton_reply_addr, ~0, 1, TPM2_TIMEOUT_C))
+	if (!crb_wait_for_reg_32(priv, priv->pluton_reply_addr, ~0, 1))
 		return -ETIME;
 
 	iowrite32(1, priv->pluton_start_addr);
 	if (wait_for_complete == false)
 		return 0;
 
-	if (!crb_wait_for_reg_32(priv->pluton_start_addr,
-				 0xffffffff, 0, 200))
+	if (tpm_poll_timeout_us(priv->chip, 200 * USEC_PER_MSEC,
+				crb_reg_matches, &w))
 		return -ETIME;
 
 	return 0;
@@ -219,10 +227,9 @@ static int __crb_go_idle(struct device *dev, struct crb_priv *priv, int loc)
 	if (rc)
 		return rc;
 
-	if (!crb_wait_for_reg_32(&priv->regs_t->ctrl_req,
+	if (!crb_wait_for_reg_32(priv, &priv->regs_t->ctrl_req,
 				 CRB_CTRL_REQ_GO_IDLE/* mask */,
-				 0, /* value */
-				 TPM2_TIMEOUT_C)) {
+				 0 /* value */)) {
 		dev_warn(dev, "goIdle timed out\n");
 		return -ETIME;
 	}
@@ -273,10 +280,9 @@ static int __crb_cmd_ready(struct device *dev, struct crb_priv *priv, int loc)
 	if (rc)
 		return rc;
 
-	if (!crb_wait_for_reg_32(&priv->regs_t->ctrl_req,
+	if (!crb_wait_for_reg_32(priv, &priv->regs_t->ctrl_req,
 				 CRB_CTRL_REQ_CMD_READY /* mask */,
-				 0, /* value */
-				 TPM2_TIMEOUT_C)) {
+				 0 /* value */)) {
 		dev_warn(dev, "cmdReady timed out\n");
 		return -ETIME;
 	}
@@ -309,8 +315,8 @@ static int __crb_request_locality(struct device *dev,
 			return rc;
 	}
 
-	if (!crb_wait_for_reg_32(&priv->regs_h->loc_state, value, value,
-				 TPM2_TIMEOUT_C)) {
+	if (!crb_wait_for_reg_32(priv, &priv->regs_h->loc_state, value,
+				 value)) {
 		dev_warn(dev, "TPM_LOC_STATE_x.requestAccess timed out\n");
 		return -ETIME;
 	}
@@ -343,8 +349,8 @@ static int __crb_relinquish_locality(struct device *dev,
 			return rc;
 	}
 
-	if (!crb_wait_for_reg_32(&priv->regs_h->loc_state, mask, value,
-				 TPM2_TIMEOUT_C)) {
+	if (!crb_wait_for_reg_32(priv, &priv->regs_h->loc_state, mask,
+				 value)) {
 		dev_warn(dev, "TPM_LOC_STATE_x.Relinquish timed out\n");
 		return -ETIME;
 	}
@@ -429,9 +435,8 @@ static int tpm_crb_recv_chunks(struct tpm_chip *chip, u8 *buf, size_t count,
 		if (rc)
 			return rc;
 
-		expired = !crb_wait_for_reg_32(&priv->regs_t->ctrl_start,
-						CRB_START_NEXT_CHUNK, 0,
-						TPM2_TIMEOUT_C);
+		expired = !crb_wait_for_reg_32(priv, &priv->regs_t->ctrl_start,
+						CRB_START_NEXT_CHUNK, 0);
 		if (expired) {
 			dev_err(&chip->dev,
 				"Timeout waiting for backend response\n");
@@ -588,9 +593,9 @@ static int tpm_crb_send_chunks(struct tpm_chip *chip, u8 *buf, size_t len)
 			rc = tpm_crb_start(chip, CRB_START_NEXT_CHUNK);
 			if (rc)
 				return rc;
-			expired = !crb_wait_for_reg_32(&priv->regs_t->ctrl_start,
-							CRB_START_NEXT_CHUNK, 0,
-							TPM2_TIMEOUT_C);
+			expired = !crb_wait_for_reg_32(priv,
+							&priv->regs_t->ctrl_start,
+							CRB_START_NEXT_CHUNK, 0);
 			if (expired) {
 				dev_err(&chip->dev,
 					"Timeout waiting for backend to consume chunk\n");
@@ -1027,6 +1032,7 @@ static int crb_acpi_probe(struct platform_device *pdev)
 		goto out;
 	}
 
+	priv->chip = chip;
 	dev_set_drvdata(&chip->dev, priv);
 	chip->acpi_dev_handle = device->handle;
 	chip->flags = TPM_CHIP_FLAG_TPM2;
-- 
2.47.3


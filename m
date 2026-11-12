Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.35.192.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794501535;
	b=u45BEXBagAcl5X/xh0q1xJE/YRD1Uy7FL26Eix1TrrUam7UxX9ZXMoLsnqIwmfJ0qCBF
	 KmSviFCRvMmDB4S9ONaC6ER55/R31qldmAzG4mEnUKAQ3LiIzh4XlwQbIpx/vmCzKk7fB
	 jzYLqiWcHTUPGLQdbQ7OC5INnwmzM/2AiyZOMflUj0Z9agd4X8jxXQZM+IcYZnbPSuGAf
	 hENo42AqXEhXs55x/4kbIMT1dJuQnwg1aF61s/mJhuD1MHJf3DjVlSfqGKdnleP0n76uW
	 5wtEfo63Rf7JaIYsZuOrcRkrFPNqsmBd9VnW+Ql1MeBrZwnfhKUbd487q5z6Zf08NQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794501535;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=mha3f3SCUtcXXRBf0scjEMV8nKmuCaWD4P1mhQgC/es=;
	b=fHHeW3HFUEqauLNqQf+nA0TtUZu65tR5+CxXlfWZjzDfLK6Fr8seEiG5alwk0yDyCG9f
	 nBAs6CDxkXSZmtwKz6NBJBHhmu7PuX093lp87kEjAkZdoykVbLckaQY60O9vJUBKF1Qlv
	 0p723CeDheeW83Pm0j5E9xmdYDf8lXGLf1/6Re3fk8md1Uqjr5Rx/E6uyD8YNn2Kd8AD4
	 DKK7EwZRGNmW0IO57WXQ8mTNtmR7HGl6SC51OD+1jiZIftn+4ySMECu3+OdJPbh8jn0Jy
	 FXazn54MQYaYuhvaaIrBL9IkxeM65zZWMZe7nhZMPybvM3twIfHam3l/wioJv7QKuPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=XZnqp8TA;
	arc=none smtp.remote-ip=52.35.192.45
Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.35.192.45])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BC060A5BCC;
	Thu, 12 Nov 2026 16:38:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71BC060A5BCC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=XZnqp8TA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794501534; x=1826037534;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mha3f3SCUtcXXRBf0scjEMV8nKmuCaWD4P1mhQgC/es=;
  b=XZnqp8TA1wXlOJwX6tRbWNzQxzJHejW5O7m9YUGC6m/1HVhDEpwapbw3
   zSSwYrIT9QXM2dp+dDBJkbPn4jAEFU3ntioJ0c/C1v5q/nGgPzA/XQbp5
   AoVWXAvk0RbNCZiDu7zaBt7twtrgdltQHdrZKcQt9lR73A6xeP2d0q96f
   BkBswAsPn6AMutA/RGbJVzItIZrZ0QP6DpEpe+l9JodmZ2wmvBPRPKt/p
   qas6+yexO4fETPAu3+VHXK7QYnvGF+W/H3udImzvRV0ybqdbkDPaswTw3
   RLRWG9pQhPOW9Oa1yiMR9NUCa1APCnIfSdkMskcbaiF7uFrEuv9XaXOy7
   w==;
X-CSE-ConnectionGUID: wkzlndWcSW+V+LioZlyACg==
X-CSE-MsgGUID: 2wN/AkD+RNepuk3BNwEstg==
X-IronPort-AV: E=Sophos;i="6.27,210,1787011200"; 
   d="scan'208";a="33603628"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 16:38:50 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:22209]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.142:2525] with esmtp (Farcaster)
 id 0207b799-f8b1-4e49-a406-1688bef4a493; Thu, 12 Nov 2026 16:38:50 +0000 (UTC)
X-Farcaster-Flow-ID: 0207b799-f8b1-4e49-a406-1688bef4a493
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
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
Subject: [RFC PATCH v3 2/8] tpm: Wire the timing setup to the limits table
Date: Thu, 12 Nov 2026 16:38:40 +0000
Message-ID: <20261112163846.97654-3-surenkj@amazon.com>
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

tpm1_get_timeouts() and tpm2_get_timeouts() still write the jiffies
fields of struct tpm_chip directly and tpm_tis patches the TPM 1.x
values through ->update_timeouts() and ->update_durations(). Build the
limits table instead.

Both functions now call tpm_limits_update(). The TPM 1.x path passes
what the chip reported after the existing fixups for chips. The table
already keeps the default where the chip reports a zero. When the final
values differ from the reported ones tpm1_get_timeouts() logs both
for the durations as well as the timeouts.

The waits/polls still read the jiffies fields so tpm_limits_commit()
copies the table into them. Since that already fills them with the
defaults at tpm_chip_alloc(), tpm_tis_core_init() no longer uses
TIS_TIMEOUT_*_MAX macros which are removed and xen-tpmfront gets
a nonzero TIMEOUT_C for its timeout query.

The Atmel 3204 timeout quirk and the STMicroelectronics 0x104a
duration quirk move to tpm_tis_adjust_limits() and the two old hooks
are removed. The quirks use the DID/VID that tpm_tis_core_init()
already reads so they no longer read the register under ->clk_enable().

The "[adjusted]" marker in the timeouts and durations sysfs files now
means that a final value differs from what the chip reported. That
was already true for the quirks and the fixups above. A value changed
by validation is the new case. Update the ABI text which only
described the msec scaling.

Signed-off-by: Surendran Kanagaraj <surenkj@amazon.com>
---
 Documentation/ABI/stable/sysfs-class-tpm |  12 +-
 drivers/char/tpm/tpm-limits.c            |  14 +++
 drivers/char/tpm/tpm1-cmd.c              | 147 +++++++++++------------
 drivers/char/tpm/tpm2-cmd.c              |   5 +-
 drivers/char/tpm/tpm_tis_core.c          | 143 ++++++----------------
 include/linux/tpm.h                      |   5 +-
 include/linux/tpm_ptp.h                  |   9 --
 7 files changed, 129 insertions(+), 206 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-class-tpm b/Documentation/ABI/stable/sysfs-class-tpm
index 411d5895bed4..73b69f63b298 100644
--- a/Documentation/ABI/stable/sysfs-class-tpm
+++ b/Documentation/ABI/stable/sysfs-class-tpm
@@ -61,10 +61,10 @@ Description:	The "durations" property shows the 3 vendor-specific values
 		Here the short, medium and long durations are displayed in
 		usecs. "[original]" indicates that the values are displayed
 		unmodified from when they were queried from the chip.
-		Durations can be modified in the case where a buggy chip
-		reports them in msec instead of usec and they need to be
-		scaled to be displayed in usecs. In this case "[adjusted]"
-		will be displayed in place of "[original]".
+		"[adjusted]" is displayed in place of "[original]" when a
+		value differs from what the chip reported, for example
+		because the chip reported msecs instead of usecs or a driver
+		quirk replaced the value.
 
 What:		/sys/class/tpm/tpmX/device/enabled
 Date:		April 2006
@@ -181,8 +181,8 @@ Description:	The "timeouts" property shows the 4 vendor-specific values
 		  750000 750000 750000 750000 [original]
 
 		The four timeout values are shown in usecs, with a trailing
-		"[original]" or "[adjusted]" depending on whether the values
-		were scaled by the driver to be reported in usec from msecs.
+		"[adjusted]" if any value differs from what the chip
+		reported, and "[original]" otherwise.
 
 What:		/sys/class/tpm/tpmX/tpm_version_major
 Date:		October 2019
diff --git a/drivers/char/tpm/tpm-limits.c b/drivers/char/tpm/tpm-limits.c
index 3fe5affa1522..8e3c2afdd439 100644
--- a/drivers/char/tpm/tpm-limits.c
+++ b/drivers/char/tpm/tpm-limits.c
@@ -174,6 +174,20 @@ static void tpm_limits_commit(struct tpm_chip *chip,
 
 	chip->limits = *p;
 
+	/* Copy the limits into the jiffies fields that the waits still read. */
+	chip->timeout_a = usecs_to_jiffies(e[TPM_LIMIT_A].time_us);
+	chip->timeout_b = usecs_to_jiffies(e[TPM_LIMIT_B].time_us);
+	chip->timeout_c = usecs_to_jiffies(e[TPM_LIMIT_C].time_us);
+	chip->timeout_d = usecs_to_jiffies(e[TPM_LIMIT_D].time_us);
+	chip->duration[TPM_SHORT] =
+		usecs_to_jiffies(e[TPM_LIMIT_SHORT].time_us);
+	chip->duration[TPM_MEDIUM] =
+		usecs_to_jiffies(e[TPM_LIMIT_MEDIUM].time_us);
+	chip->duration[TPM_LONG] =
+		usecs_to_jiffies(e[TPM_LIMIT_LONG].time_us);
+	chip->duration[TPM_LONG_LONG] =
+		usecs_to_jiffies(e[TPM_LIMIT_LONG_LONG].time_us);
+
 	for (limit = 0; limit < TPM_NR_LIMITS; limit++)
 		dev_dbg(&chip->dev, "limit %s = %u us (%s%s)\n",
 			tpm_limit_names[limit], e[limit].time_us,
diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index 7a8606e8c711..9586b4944578 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -332,12 +332,48 @@ static int tpm1_startup(struct tpm_chip *chip)
 	return tpm_transmit_cmd(chip, buf, 0, "attempting to start the TPM");
 }
 
+/*
+ * Set the "[adjusted]" flags that sysfs shows, and log the reported and final
+ * values, when a final value differs from what the chip sent.
+ */
+static void tpm1_report_adjusted(struct tpm_chip *chip, const u32 *raw,
+				 unsigned long mask)
+{
+	const struct tpm_limit_entry *e = chip->limits.entry;
+	unsigned long changed = 0;
+	int limit;
+
+	for_each_set_bit(limit, &mask, TPM_NR_LIMITS) {
+		if (e[limit].time_us != raw[limit])
+			changed |= BIT(limit);
+	}
+
+	chip->timeout_adjusted = changed & TPM_LIMIT_INTF_MASK;
+	chip->duration_adjusted = changed & TPM1_LIMIT_DURATION_MASK;
+
+	if (chip->timeout_adjusted)
+		dev_info(&chip->dev, HW_ERR "Adjusting reported timeouts: A %u->%uus B %u->%uus C %u->%uus D %u->%uus\n",
+			 raw[TPM_LIMIT_A], e[TPM_LIMIT_A].time_us,
+			 raw[TPM_LIMIT_B], e[TPM_LIMIT_B].time_us,
+			 raw[TPM_LIMIT_C], e[TPM_LIMIT_C].time_us,
+			 raw[TPM_LIMIT_D], e[TPM_LIMIT_D].time_us);
+
+	if (chip->duration_adjusted)
+		dev_info(&chip->dev, HW_ERR "Adjusting reported durations: SHORT %u->%uus MEDIUM %u->%uus LONG %u->%uus\n",
+			 raw[TPM_LIMIT_SHORT], e[TPM_LIMIT_SHORT].time_us,
+			 raw[TPM_LIMIT_MEDIUM], e[TPM_LIMIT_MEDIUM].time_us,
+			 raw[TPM_LIMIT_LONG], e[TPM_LIMIT_LONG].time_us);
+}
+
 int tpm1_get_timeouts(struct tpm_chip *chip)
 {
+	unsigned long mask = TPM_LIMIT_INTF_MASK;
+	u32 reported[TPM_NR_LIMITS] = {};
+	u32 raw[TPM_NR_LIMITS] = {};
+	u64 val[TPM_NR_LIMITS];	/* u64 so the scaling by 1000 cannot overflow */
 	cap_t cap;
-	unsigned long timeout_old[4], timeout_chip[4], timeout_eff[4];
-	unsigned long durations[3];
 	ssize_t rc;
+	int limit;
 
 	rc = tpm1_getcap(chip, TPM_CAP_PROP_TIS_TIMEOUT, &cap, NULL,
 			 sizeof(cap.timeout));
@@ -356,83 +392,28 @@ int tpm1_get_timeouts(struct tpm_chip *chip)
 		return rc;
 	}
 
-	timeout_old[0] = jiffies_to_usecs(chip->timeout_a);
-	timeout_old[1] = jiffies_to_usecs(chip->timeout_b);
-	timeout_old[2] = jiffies_to_usecs(chip->timeout_c);
-	timeout_old[3] = jiffies_to_usecs(chip->timeout_d);
-	timeout_chip[0] = be32_to_cpu(cap.timeout.a);
-	timeout_chip[1] = be32_to_cpu(cap.timeout.b);
-	timeout_chip[2] = be32_to_cpu(cap.timeout.c);
-	timeout_chip[3] = be32_to_cpu(cap.timeout.d);
-	memcpy(timeout_eff, timeout_chip, sizeof(timeout_eff));
-
-	/*
-	 * Provide ability for vendor overrides of timeout values in case
-	 * of misreporting.
-	 */
-	if (chip->ops->update_timeouts)
-		chip->ops->update_timeouts(chip, timeout_eff);
-
-	if (!chip->timeout_adjusted) {
-		/* Restore default if chip reported 0 */
-		unsigned int i;
-
-		for (i = 0; i < ARRAY_SIZE(timeout_eff); i++) {
-			if (timeout_eff[i])
-				continue;
-
-			timeout_eff[i] = timeout_old[i];
-			chip->timeout_adjusted = true;
-		}
-
-		if (timeout_eff[0] != 0 && timeout_eff[0] < 1000) {
-			/* timeouts in msec rather usec */
-			for (i = 0; i != ARRAY_SIZE(timeout_eff); i++)
-				timeout_eff[i] *= 1000;
-			chip->timeout_adjusted = true;
-		}
-	}
-
-	/* Report adjusted timeouts */
-	if (chip->timeout_adjusted) {
-		dev_info(&chip->dev, HW_ERR "Adjusting reported timeouts: A %lu->%luus B %lu->%luus C %lu->%luus D %lu->%luus\n",
-			 timeout_chip[0], timeout_eff[0],
-			 timeout_chip[1], timeout_eff[1],
-			 timeout_chip[2], timeout_eff[2],
-			 timeout_chip[3], timeout_eff[3]);
-	}
-
-	chip->timeout_a = usecs_to_jiffies(timeout_eff[0]);
-	chip->timeout_b = usecs_to_jiffies(timeout_eff[1]);
-	chip->timeout_c = usecs_to_jiffies(timeout_eff[2]);
-	chip->timeout_d = usecs_to_jiffies(timeout_eff[3]);
+	raw[TPM_LIMIT_A] = be32_to_cpu(cap.timeout.a);
+	raw[TPM_LIMIT_B] = be32_to_cpu(cap.timeout.b);
+	raw[TPM_LIMIT_C] = be32_to_cpu(cap.timeout.c);
+	raw[TPM_LIMIT_D] = be32_to_cpu(cap.timeout.d);
 
 	rc = tpm1_getcap(chip, TPM_CAP_PROP_TIS_DURATION, &cap,
 			 "attempting to determine the durations",
 			  sizeof(cap.duration));
-	if (rc)
-		return rc;
+	if (!rc) {
+		raw[TPM_LIMIT_SHORT] = be32_to_cpu(cap.duration.tpm_short);
+		raw[TPM_LIMIT_MEDIUM] = be32_to_cpu(cap.duration.tpm_medium);
+		raw[TPM_LIMIT_LONG] = be32_to_cpu(cap.duration.tpm_long);
+		mask |= TPM1_LIMIT_DURATION_MASK;
+	}
 
-	chip->duration[TPM_SHORT] =
-		usecs_to_jiffies(be32_to_cpu(cap.duration.tpm_short));
-	chip->duration[TPM_MEDIUM] =
-		usecs_to_jiffies(be32_to_cpu(cap.duration.tpm_medium));
-	chip->duration[TPM_LONG] =
-		usecs_to_jiffies(be32_to_cpu(cap.duration.tpm_long));
-	chip->duration[TPM_LONG_LONG] = 0; /* not used under 1.2 */
+	for (limit = 0; limit < TPM_NR_LIMITS; limit++)
+		val[limit] = raw[limit];
 
-	/*
-	 * Provide the ability for vendor overrides of duration values in case
-	 * of misreporting.
-	 */
-	if (chip->ops->update_durations)
-		chip->ops->update_durations(chip, durations);
-
-	if (chip->duration_adjusted) {
-		dev_info(&chip->dev, HW_ERR "Adjusting reported durations.");
-		chip->duration[TPM_SHORT] = durations[0];
-		chip->duration[TPM_MEDIUM] = durations[1];
-		chip->duration[TPM_LONG] = durations[2];
+	/* TIMEOUT_A below 1000 means the four timeouts are in milliseconds. */
+	if (val[TPM_LIMIT_A] && val[TPM_LIMIT_A] < 1000) {
+		for (limit = TPM_LIMIT_A; limit <= TPM_LIMIT_D; limit++)
+			val[limit] *= 1000;
 	}
 
 	/* The Broadcom BCM0102 chipset in a Dell Latitude D820 gets the above
@@ -440,14 +421,22 @@ int tpm1_get_timeouts(struct tpm_chip *chip)
 	 * fix up the resulting too-small TPM_SHORT value to make things work.
 	 * We also scale the TPM_MEDIUM and -_LONG values by 1000.
 	 */
-	if (chip->duration[TPM_SHORT] < (HZ / 100)) {
-		chip->duration[TPM_SHORT] = HZ;
-		chip->duration[TPM_MEDIUM] *= 1000;
-		chip->duration[TPM_LONG] *= 1000;
-		chip->duration_adjusted = true;
-		dev_info(&chip->dev, "Adjusting TPM timeout parameters.");
+	if ((mask & BIT(TPM_LIMIT_SHORT)) &&
+	    val[TPM_LIMIT_SHORT] < 10 * USEC_PER_MSEC) {
+		val[TPM_LIMIT_SHORT] = USEC_PER_SEC;
+		val[TPM_LIMIT_MEDIUM] *= 1000;
+		val[TPM_LIMIT_LONG] *= 1000;
 	}
 
+	for_each_set_bit(limit, &mask, TPM_NR_LIMITS)
+		reported[limit] = min_t(u64, val[limit], U32_MAX);
+
+	/* The reported timeouts apply even when the durations query failed. */
+	tpm_limits_update(chip, reported);
+	tpm1_report_adjusted(chip, raw, mask);
+	if (rc)
+		return rc;
+
 	chip->flags |= TPM_CHIP_FLAG_HAVE_TIMEOUTS;
 	return 0;
 }
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 4b2bb2ddc321..f943f1c05721 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -43,10 +43,7 @@ EXPORT_SYMBOL_GPL(tpm2_find_hash_alg);
 
 int tpm2_get_timeouts(struct tpm_chip *chip)
 {
-	chip->timeout_a = msecs_to_jiffies(TPM2_TIMEOUT_A);
-	chip->timeout_b = msecs_to_jiffies(TPM2_TIMEOUT_B);
-	chip->timeout_c = msecs_to_jiffies(TPM2_TIMEOUT_C);
-	chip->timeout_d = msecs_to_jiffies(TPM2_TIMEOUT_D);
+	tpm_limits_update(chip, NULL);
 	chip->flags |= TPM_CHIP_FLAG_HAVE_TIMEOUTS;
 	return 0;
 }
diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 143ef160820e..64ae82e435d0 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -623,127 +623,68 @@ static int tpm_tis_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
 	return rc;
 }
 
+/* Atmel 3204 misreports its timeouts; use the TIS defaults */
+static const struct tpm_limits_quirk tis_timeout_quirks[] = {
+	{
+		.id = 0x32041114,
+		.time_us = {
+			[TPM_LIMIT_A] = TIS_SHORT_TIMEOUT * USEC_PER_MSEC,
+			[TPM_LIMIT_B] = TIS_LONG_TIMEOUT * USEC_PER_MSEC,
+			[TPM_LIMIT_C] = TIS_SHORT_TIMEOUT * USEC_PER_MSEC,
+			[TPM_LIMIT_D] = TIS_SHORT_TIMEOUT * USEC_PER_MSEC,
+		},
+	},
+};
+
 struct tis_vendor_durations_override {
 	u32 did_vid;
 	struct tpm1_version version;
-	unsigned long durations[3];
+	u32 durations_us[3];
 };
 
-static const struct  tis_vendor_durations_override vendor_dur_overrides[] = {
+static const struct tis_vendor_durations_override vendor_dur_overrides[] = {
 	/* STMicroelectronics 0x104a */
 	{ 0x0000104a,
 	  { 1, 2, 8, 28 },
-	  { (2 * 60 * HZ), (2 * 60 * HZ), (2 * 60 * HZ) } },
+	  { 120 * USEC_PER_SEC, 120 * USEC_PER_SEC, 120 * USEC_PER_SEC } },
 };
 
-static void tpm_tis_update_durations(struct tpm_chip *chip,
-				     unsigned long *duration_cap)
+static void tpm_tis_adjust_limits(struct tpm_chip *chip, struct tpm_limits *p)
 {
 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
+	const struct tis_vendor_durations_override *o;
 	struct tpm1_version *version;
-	u32 did_vid;
-	int i, rc;
 	cap_t cap;
+	int i;
 
-	chip->duration_adjusted = false;
-
-	if (chip->ops->clk_enable != NULL)
-		chip->ops->clk_enable(chip, true);
+	if (p->family != TPM_FAMILY_1)
+		return;
 
-	rc = tpm_tis_read32(priv, TPM_DID_VID(0), &did_vid);
-	if (rc < 0) {
-		dev_warn(&chip->dev, "%s: failed to read did_vid. %d\n",
-			 __func__, rc);
-		goto out;
-	}
+	tpm_limits_apply_quirks(p, tis_timeout_quirks,
+				ARRAY_SIZE(tis_timeout_quirks), priv->did_vid);
 
-	/* Try to get a TPM version 1.2 or 1.1 TPM_CAP_VERSION_INFO */
-	rc = tpm1_getcap(chip, TPM_CAP_VERSION_1_2, &cap,
+	if (!tpm1_getcap(chip, TPM_CAP_VERSION_1_2, &cap,
 			 "attempting to determine the 1.2 version",
-			 sizeof(cap.version2));
-	if (!rc) {
+			 sizeof(cap.version2)))
 		version = &cap.version2.version;
-	} else {
-		rc = tpm1_getcap(chip, TPM_CAP_VERSION_1_1, &cap,
-				 "attempting to determine the 1.1 version",
-				 sizeof(cap.version1));
-
-		if (rc)
-			goto out;
-
+	else if (!tpm1_getcap(chip, TPM_CAP_VERSION_1_1, &cap,
+			      "attempting to determine the 1.1 version",
+			      sizeof(cap.version1)))
 		version = &cap.version1;
-	}
+	else
+		return;
 
-	for (i = 0; i != ARRAY_SIZE(vendor_dur_overrides); i++) {
-		if (vendor_dur_overrides[i].did_vid != did_vid)
+	for (i = 0; i < ARRAY_SIZE(vendor_dur_overrides); i++) {
+		o = &vendor_dur_overrides[i];
+		if (o->did_vid != priv->did_vid ||
+		    memcmp(&o->version, version, sizeof(*version)))
 			continue;
 
-		if ((version->major ==
-		     vendor_dur_overrides[i].version.major) &&
-		    (version->minor ==
-		     vendor_dur_overrides[i].version.minor) &&
-		    (version->rev_major ==
-		     vendor_dur_overrides[i].version.rev_major) &&
-		    (version->rev_minor ==
-		     vendor_dur_overrides[i].version.rev_minor)) {
-
-			memcpy(duration_cap,
-			       vendor_dur_overrides[i].durations,
-			       sizeof(vendor_dur_overrides[i].durations));
-
-			chip->duration_adjusted = true;
-			goto out;
-		}
-	}
-
-out:
-	if (chip->ops->clk_enable != NULL)
-		chip->ops->clk_enable(chip, false);
-}
-
-struct tis_vendor_timeout_override {
-	u32 did_vid;
-	unsigned long timeout_us[4];
-};
-
-static const struct tis_vendor_timeout_override vendor_timeout_overrides[] = {
-	/* Atmel 3204 */
-	{ 0x32041114, { (TIS_SHORT_TIMEOUT*1000), (TIS_LONG_TIMEOUT*1000),
-			(TIS_SHORT_TIMEOUT*1000), (TIS_SHORT_TIMEOUT*1000) } },
-};
-
-static void tpm_tis_update_timeouts(struct tpm_chip *chip,
-				    unsigned long *timeout_cap)
-{
-	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
-	int i, rc;
-	u32 did_vid;
-
-	chip->timeout_adjusted = false;
-
-	if (chip->ops->clk_enable != NULL)
-		chip->ops->clk_enable(chip, true);
-
-	rc = tpm_tis_read32(priv, TPM_DID_VID(0), &did_vid);
-	if (rc < 0) {
-		dev_warn(&chip->dev, "%s: failed to read did_vid: %d\n",
-			 __func__, rc);
-		goto out;
-	}
-
-	for (i = 0; i != ARRAY_SIZE(vendor_timeout_overrides); i++) {
-		if (vendor_timeout_overrides[i].did_vid != did_vid)
-			continue;
-		memcpy(timeout_cap, vendor_timeout_overrides[i].timeout_us,
-		       sizeof(vendor_timeout_overrides[i].timeout_us));
-		chip->timeout_adjusted = true;
+		tpm_limits_driver_set(p, TPM_LIMIT_SHORT, o->durations_us[0]);
+		tpm_limits_driver_set(p, TPM_LIMIT_MEDIUM, o->durations_us[1]);
+		tpm_limits_driver_set(p, TPM_LIMIT_LONG, o->durations_us[2]);
+		return;
 	}
-
-out:
-	if (chip->ops->clk_enable != NULL)
-		chip->ops->clk_enable(chip, false);
-
-	return;
 }
 
 /*
@@ -1112,8 +1053,7 @@ static const struct tpm_class_ops tpm_tis = {
 	.recv = tpm_tis_recv,
 	.send = tpm_tis_send,
 	.cancel = tpm_tis_ready,
-	.update_timeouts = tpm_tis_update_timeouts,
-	.update_durations = tpm_tis_update_durations,
+	.adjust_limits = tpm_tis_adjust_limits,
 	.req_complete_mask = TPM_STS_DATA_AVAIL | TPM_STS_VALID,
 	.req_complete_val = TPM_STS_DATA_AVAIL | TPM_STS_VALID,
 	.req_canceled = tpm_tis_req_canceled,
@@ -1145,11 +1085,6 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 
 	chip->hwrng.quality = priv->rng_quality;
 
-	/* Maximum timeouts */
-	chip->timeout_a = msecs_to_jiffies(TIS_TIMEOUT_A_MAX);
-	chip->timeout_b = msecs_to_jiffies(TIS_TIMEOUT_B_MAX);
-	chip->timeout_c = msecs_to_jiffies(TIS_TIMEOUT_C_MAX);
-	chip->timeout_d = msecs_to_jiffies(TIS_TIMEOUT_D_MAX);
 	priv->chip = chip;
 	priv->timeout_min = TPM_TIMEOUT_USECS_MIN;
 	priv->timeout_max = TPM_TIMEOUT_USECS_MAX;
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 5454d87f43ba..0b9661ffe45e 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -49,10 +49,6 @@ struct tpm_class_ops {
 		    size_t cmd_len);
 	void (*cancel) (struct tpm_chip *chip);
 	u8 (*status) (struct tpm_chip *chip);
-	void (*update_timeouts)(struct tpm_chip *chip,
-				unsigned long *timeout_cap);
-	void (*update_durations)(struct tpm_chip *chip,
-				 unsigned long *duration_cap);
 	void (*adjust_limits)(struct tpm_chip *chip, struct tpm_limits *p);
 	int (*go_idle)(struct tpm_chip *chip);
 	int (*cmd_ready)(struct tpm_chip *chip);
@@ -91,6 +87,7 @@ enum tpm_limit {
 };
 
 #define TPM_LIMIT_INTF_MASK		GENMASK(TPM_LIMIT_D, TPM_LIMIT_A)
+#define TPM1_LIMIT_DURATION_MASK	GENMASK(TPM_LIMIT_LONG, TPM_LIMIT_SHORT)
 
 enum tpm_family {
 	TPM_FAMILY_1,		/* TPM 1.1 and 1.2 */
diff --git a/include/linux/tpm_ptp.h b/include/linux/tpm_ptp.h
index e80ed810a269..3b6e7a854f70 100644
--- a/include/linux/tpm_ptp.h
+++ b/include/linux/tpm_ptp.h
@@ -79,15 +79,6 @@ enum tis_x86_defaults {
 	LPC_CLKRUN_EN			= (1 << 2),
 };
 
-/*
- * Some timeout values are needed before it is known whether the chip is
- * TPM 1.0 or TPM 2.0.
- */
-#define TIS_TIMEOUT_A_MAX	max_t(int, TIS_SHORT_TIMEOUT, TPM2_TIMEOUT_A)
-#define TIS_TIMEOUT_B_MAX	max_t(int, TIS_LONG_TIMEOUT, TPM2_TIMEOUT_B)
-#define TIS_TIMEOUT_C_MAX	max_t(int, TIS_SHORT_TIMEOUT, TPM2_TIMEOUT_C)
-#define TIS_TIMEOUT_D_MAX	max_t(int, TIS_SHORT_TIMEOUT, TPM2_TIMEOUT_D)
-
 #define	TPM_ACCESS(l)			(0x0000 | ((l) << 12))
 #define	TPM_INT_ENABLE(l)		(0x0008 | ((l) << 12))
 #define	TPM_INT_VECTOR(l)		(0x000C | ((l) << 12))
-- 
2.47.3


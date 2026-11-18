Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.155.198.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794988153;
	b=1v5NPmVksprgarFGUN1z5snTYcCAqVCd0l95xHOiCLGMDGqjKeBopZv+FeBp7skWulkT
	 +mYVbsKCfw+TY1wwVjaqC+77n+UEBCPmOe7CGidPzJwS1B+MnMUjzJmjJaIky+SyvSXWB
	 A1VcbwEpkZdOQrUoC/jW4ZrDLOs4szzo6AoO1nJ4J6gZQA4WUjzQ9CmHLGiZAAbBCCKKO
	 izW/nFFRHXmLzSUG3fqRTlYPneQ0tnUJ1DDGUQikTLhlNo9KGmkAiW69M2fR7ug/bDU3D
	 lVZuc+V/Y56DmHkdFrqxKgEQd++9/1OBYTQq9Y3IPFQkQvAYlW8tFB8XxKR8KDE93XA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794988153;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=nVZAAVuLf1aSEHcWU6BvK/DwkdncU+SDrQkGzhOvQE4=;
	b=0JD4pLOXXeSmszvHmnEKPklgs12f/7afhKtwDMSlLuC7yi9kqBJzyB+zwZlcO/HWCzgK
	 J79SdeRXybSQ3lZarN+MG5AbyvsWWd3h7WlUxqULqSMDntm6ljEnoCCeHF7dCiasP8Hor
	 JKnVF+zvxhl0HIWrfGVRepel4olvyCHsaJp2gwHbIc5EpEXziFYBWUGUqNURIbQXAIwFG
	 HuUYJhZBLia1Q+3GtML8SeTTyvGue4evQPbPWCDyd+CEnGbYt5DaAmi9VWD/evvMEbJ8q
	 zxpV8uGvlpmKhes3RuhmhODY/C7OiSMx5GKFpX59pK7pWRTnSc+i5khbEat17np6Sqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=lZAs5ZFX;
	arc=none smtp.remote-ip=35.155.198.111
Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083E0606A332;
	Wed, 18 Nov 2026 07:49:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 083E0606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=lZAs5ZFX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794988153; x=1826524153;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nVZAAVuLf1aSEHcWU6BvK/DwkdncU+SDrQkGzhOvQE4=;
  b=lZAs5ZFXAvlC8vaqHvJoa7QenQOTCEifzpBQOPRoawzEycu326q9D2rb
   xKEzpMez8CUlTnuxjCs0qE0AlDfgPAg90wwVEJ+DW/9/tjaeAGSHlIIgy
   LiIpzOOGHskN3sM6YBtWJ1XlEpjD7/2QvKJ9lc53CsTPviWSEWHQthnjy
   C6RcFP/GBVrvjtdOFwBL6EE+9ow9rGWzWYjsikNkKZgJ7c1NUmXm69Xg/
   w4dhHmLd1Xwwrkhuqacs0PcSMfLlAYtjy5vLEEGiBlNIKLaU86Pg/0IWE
   Tc0nryXgl+Q2dw8lOFbFcFr04uMZZN/ZWjRsQ5RYEELRA2ZNbG0O8CNvB
   g==;
X-CSE-ConnectionGUID: KGX2Srj3RYOgz3kuTkhQKA==
X-CSE-MsgGUID: 89Kft63eQ1qwjJXR1Y9Iew==
X-IronPort-AV: E=Sophos;i="6.27,219,1787011200"; 
   d="scan'208";a="34351802"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 07:49:09 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:17624]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.141:2525] with esmtp (Farcaster)
 id 189fe113-b801-4a54-bc0e-dc2c55200a22; Wed, 18 Nov 2026 07:49:09 +0000 (UTC)
X-Farcaster-Flow-ID: 189fe113-b801-4a54-bc0e-dc2c55200a22
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 18 Nov 2026 07:49:09 +0000
Received: from dev-dsk-surenkj-2b-416930d2.us-west-2.amazon.com (10.169.26.94)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 18 Nov 2026 07:49:09 +0000
From: Surendran Kanagaraj <surenkj@amazon.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, Peter Huewe <peterhuewe@gmx.de>
CC: Jason Gunthorpe <jgg@ziepe.ca>, <linux-integrity@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
	<linux-doc@vger.kernel.org>, Jonathan McDowell <noodles@earth.li>, "Breno
 Leitao" <leitao@debian.org>, <nh-open-source@amazon.com>, Alexander Graf
	<graf@amazon.de>, Gunnar Kudrjavets <gunnarku@amazon.com>, Josh Levinson
	<joshlev@amazon.com>
Subject: [RFC PATCH v4 5/8] tpm: Drop the jiffies timing fields from struct tpm_chip
Date: Wed, 18 Nov 2026 07:49:01 +0000
Message-ID: <20261118074904.60624-1-surenkj@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261118073852.81107-1-surenkj@amazon.com>
References: <20261118073852.81107-1-surenkj@amazon.com>
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

timeout_a to timeout_d and duration[] in struct tpm_chip now only
mirror the limits table. Some drivers still write initial values
into the timeout fields at probe and tpm_limits_update() overwrites
them.

Remove the fields and enum tpm_duration which only indexed
duration[]. Add tpm_limits_jiffies(), which returns the value the
field held, for the drivers that wait in jiffies. The timeouts and
durations sysfs files read the table directly.

Two things behave differently. Until the timing query runs at
registration, st33zp24, tpm_i2c_infineon and tpm_i2c_nuvoton wait up
to 4 s for TIMEOUT_B, the larger of the two families' defaults,
instead of 2 s. tpm_i2c_atmel also set 2 s but never waits on an
interface timeout, and tpm_tis_i2c_cr50 already used 4 s. The
timeouts and durations files print exact microseconds instead of a
value rounded to a jiffy.

Signed-off-by: Surendran Kanagaraj <surenkj@amazon.com>
---
 drivers/char/tpm/st33zp24/st33zp24.c | 28 ++++++++----------------
 drivers/char/tpm/tpm-limits.c        | 15 +------------
 drivers/char/tpm/tpm-sysfs.c         | 27 ++++++++++-------------
 drivers/char/tpm/tpm.h               |  6 ++++++
 drivers/char/tpm/tpm1-cmd.c          |  4 ++--
 drivers/char/tpm/tpm_i2c_atmel.c     |  9 --------
 drivers/char/tpm/tpm_i2c_infineon.c  | 25 +++++++---------------
 drivers/char/tpm/tpm_i2c_nuvoton.c   | 32 +++++++++++++---------------
 drivers/char/tpm/tpm_tis_core.c      | 31 +++++++++++++++------------
 drivers/char/tpm/tpm_tis_i2c_cr50.c  | 15 +++++--------
 drivers/char/tpm/xen-tpmfront.c      | 10 +++++----
 include/linux/tpm.h                  | 15 -------------
 12 files changed, 80 insertions(+), 137 deletions(-)

diff --git a/drivers/char/tpm/st33zp24/st33zp24.c b/drivers/char/tpm/st33zp24/st33zp24.c
index 91d1278fe95a..5a2cf76ddea7 100644
--- a/drivers/char/tpm/st33zp24/st33zp24.c
+++ b/drivers/char/tpm/st33zp24/st33zp24.c
@@ -56,11 +56,6 @@ enum st33zp24_int_flags {
 	TPM_INTF_DATA_AVAIL_INT = 0x001,
 };
 
-enum tis_defaults {
-	TIS_SHORT_TIMEOUT = 750,
-	TIS_LONG_TIMEOUT = 2000,
-};
-
 /*
  * clear the pending interrupt.
  */
@@ -132,7 +127,7 @@ static int request_locality(struct tpm_chip *chip)
 	if (ret < 0)
 		return ret;
 
-	stop = jiffies + chip->timeout_a;
+	stop = jiffies + tpm_limits_jiffies(chip, TPM_LIMIT_A);
 
 	/* Request locality is usually effective after the request */
 	do {
@@ -165,7 +160,7 @@ static int get_burstcount(struct tpm_chip *chip)
 	int burstcnt, status;
 	u8 temp;
 
-	stop = jiffies + chip->timeout_d;
+	stop = jiffies + tpm_limits_jiffies(chip, TPM_LIMIT_D);
 	do {
 		status = tpm_dev->ops->recv(tpm_dev->phy_id, TPM_STS + 1,
 					    &temp, 1);
@@ -270,7 +265,7 @@ static int recv_data(struct tpm_chip *chip, u8 *buf, size_t count)
 	while (size < count &&
 	       wait_for_stat(chip,
 			     TPM_STS_DATA_AVAIL | TPM_STS_VALID,
-			     chip->timeout_c,
+			     tpm_limits_jiffies(chip, TPM_LIMIT_C),
 			     &tpm_dev->read_queue, true) == 0) {
 		burstcnt = get_burstcount(chip);
 		if (burstcnt < 0)
@@ -320,9 +315,9 @@ static int st33zp24_send(struct tpm_chip *chip, unsigned char *buf,
 	status = st33zp24_status(chip);
 	if ((status & TPM_STS_COMMAND_READY) == 0) {
 		st33zp24_cancel(chip);
-		if (wait_for_stat
-		    (chip, TPM_STS_COMMAND_READY, chip->timeout_b,
-		     &tpm_dev->read_queue, false) < 0) {
+		if (wait_for_stat(chip, TPM_STS_COMMAND_READY,
+				  tpm_limits_jiffies(chip, TPM_LIMIT_B),
+				  &tpm_dev->read_queue, false) < 0) {
 			ret = -ETIME;
 			goto out_err;
 		}
@@ -467,11 +462,6 @@ int st33zp24_probe(void *phy_id, const struct st33zp24_phy_ops *ops,
 	tpm_dev->ops = ops;
 	dev_set_drvdata(&chip->dev, tpm_dev);
 
-	chip->timeout_a = msecs_to_jiffies(TIS_SHORT_TIMEOUT);
-	chip->timeout_b = msecs_to_jiffies(TIS_LONG_TIMEOUT);
-	chip->timeout_c = msecs_to_jiffies(TIS_SHORT_TIMEOUT);
-	chip->timeout_d = msecs_to_jiffies(TIS_SHORT_TIMEOUT);
-
 	tpm_dev->locality = LOCALITY0;
 
 	if (ACPI_COMPANION(dev)) {
@@ -569,9 +559,9 @@ int st33zp24_pm_resume(struct device *dev)
 
 	if (tpm_dev->io_lpcpd) {
 		gpiod_set_value_cansleep(tpm_dev->io_lpcpd, 1);
-		ret = wait_for_stat(chip,
-				TPM_STS_VALID, chip->timeout_b,
-				&tpm_dev->read_queue, false);
+		ret = wait_for_stat(chip, TPM_STS_VALID,
+				    tpm_limits_jiffies(chip, TPM_LIMIT_B),
+				    &tpm_dev->read_queue, false);
 	} else {
 		ret = tpm_pm_resume(dev);
 		if (!ret)
diff --git a/drivers/char/tpm/tpm-limits.c b/drivers/char/tpm/tpm-limits.c
index bdaa0339195e..0efca95eec62 100644
--- a/drivers/char/tpm/tpm-limits.c
+++ b/drivers/char/tpm/tpm-limits.c
@@ -4,6 +4,7 @@
  * timeouts and the SHORT to DEFAULT command durations. Each chip owns one
  * table, built from the family defaults, the values a TPM chip reports and
  * the driver's ->adjust_limits() hook, each overriding the one before.
+ * Every TPM wait on one of these limits reads it from this table.
  */
 
 #include <linux/kernel.h>
@@ -177,20 +178,6 @@ static void tpm_limits_commit(struct tpm_chip *chip,
 
 	chip->limits = *p;
 
-	/* Copy the limits into the jiffies fields that the waits still read. */
-	chip->timeout_a = usecs_to_jiffies(e[TPM_LIMIT_A].time_us);
-	chip->timeout_b = usecs_to_jiffies(e[TPM_LIMIT_B].time_us);
-	chip->timeout_c = usecs_to_jiffies(e[TPM_LIMIT_C].time_us);
-	chip->timeout_d = usecs_to_jiffies(e[TPM_LIMIT_D].time_us);
-	chip->duration[TPM_SHORT] =
-		usecs_to_jiffies(e[TPM_LIMIT_SHORT].time_us);
-	chip->duration[TPM_MEDIUM] =
-		usecs_to_jiffies(e[TPM_LIMIT_MEDIUM].time_us);
-	chip->duration[TPM_LONG] =
-		usecs_to_jiffies(e[TPM_LIMIT_LONG].time_us);
-	chip->duration[TPM_LONG_LONG] =
-		usecs_to_jiffies(e[TPM_LIMIT_LONG_LONG].time_us);
-
 	for (limit = 0; limit < TPM_NR_LIMITS; limit++)
 		dev_dbg(&chip->dev, "limit %s = %u us (%s%s)\n",
 			tpm_limit_names[limit], e[limit].time_us,
diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
index d915307ae833..b289a7f6f085 100644
--- a/drivers/char/tpm/tpm-sysfs.c
+++ b/drivers/char/tpm/tpm-sysfs.c
@@ -275,16 +275,13 @@ static ssize_t durations_show(struct device *dev, struct device_attribute *attr,
 			      char *buf)
 {
 	struct tpm_chip *chip = to_tpm_chip(dev);
+	const struct tpm_limit_entry *e = chip->limits.entry;
 
-	if (chip->duration[TPM_LONG] == 0)
-		return 0;
-
-	return sprintf(buf, "%d %d %d [%s]\n",
-		       jiffies_to_usecs(chip->duration[TPM_SHORT]),
-		       jiffies_to_usecs(chip->duration[TPM_MEDIUM]),
-		       jiffies_to_usecs(chip->duration[TPM_LONG]),
-		       chip->duration_adjusted
-		       ? "adjusted" : "original");
+	return sysfs_emit(buf, "%u %u %u [%s]\n",
+			  e[TPM_LIMIT_SHORT].time_us,
+			  e[TPM_LIMIT_MEDIUM].time_us,
+			  e[TPM_LIMIT_LONG].time_us,
+			  chip->duration_adjusted ? "adjusted" : "original");
 }
 static DEVICE_ATTR_RO(durations);
 
@@ -292,14 +289,12 @@ static ssize_t timeouts_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
 {
 	struct tpm_chip *chip = to_tpm_chip(dev);
+	const struct tpm_limit_entry *e = chip->limits.entry;
 
-	return sprintf(buf, "%d %d %d %d [%s]\n",
-		       jiffies_to_usecs(chip->timeout_a),
-		       jiffies_to_usecs(chip->timeout_b),
-		       jiffies_to_usecs(chip->timeout_c),
-		       jiffies_to_usecs(chip->timeout_d),
-		       chip->timeout_adjusted
-		       ? "adjusted" : "original");
+	return sysfs_emit(buf, "%u %u %u %u [%s]\n",
+			  e[TPM_LIMIT_A].time_us, e[TPM_LIMIT_B].time_us,
+			  e[TPM_LIMIT_C].time_us, e[TPM_LIMIT_D].time_us,
+			  chip->timeout_adjusted ? "adjusted" : "original");
 }
 static DEVICE_ATTR_RO(timeouts);
 
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index b3dc5c7161cf..29161a142306 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -79,6 +79,12 @@ void tpm_limits_init(struct tpm_chip *chip);
 void tpm_limits_update(struct tpm_chip *chip, const u32 *reported);
 void tpm_limits_driver_set(struct tpm_limits *p, enum tpm_limit limit, u32 us);
 u32 tpm_limits_retry_us(struct tpm_chip *chip);
+static inline unsigned long tpm_limits_jiffies(struct tpm_chip *chip,
+					       enum tpm_limit limit)
+{
+	return usecs_to_jiffies(chip->limits.entry[limit].time_us);
+}
+
 u32 tpm_limits_us(struct tpm_chip *chip, enum tpm_limit limit);
 int __tpm_poll(struct tpm_chip *chip, u32 timeout_us, enum tpm_limit limit,
 	       bool (*cond)(struct tpm_chip *chip, void *arg), void *arg);
diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index 853bb1cee2ed..f0f733904d6f 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -406,8 +406,8 @@ int tpm1_get_timeouts(struct tpm_chip *chip)
 
 	/* The Broadcom BCM0102 chipset in a Dell Latitude D820 gets the above
 	 * value wrong and apparently reports msecs rather than usecs. So we
-	 * fix up the resulting too-small TPM_SHORT value to make things work.
-	 * We also scale the TPM_MEDIUM and -_LONG values by 1000.
+	 * fix up the resulting too-small SHORT value to make things work.
+	 * We also scale the MEDIUM and LONG values by 1000.
 	 */
 	if ((mask & BIT(TPM_LIMIT_SHORT)) &&
 	    val[TPM_LIMIT_SHORT] < 10 * USEC_PER_MSEC) {
diff --git a/drivers/char/tpm/tpm_i2c_atmel.c b/drivers/char/tpm/tpm_i2c_atmel.c
index ab058bfc9c99..78b193eb3da6 100644
--- a/drivers/char/tpm/tpm_i2c_atmel.c
+++ b/drivers/char/tpm/tpm_i2c_atmel.c
@@ -24,9 +24,6 @@
 
 #define I2C_DRIVER_NAME "tpm_i2c_atmel"
 
-#define TPM_I2C_SHORT_TIMEOUT  750     /* ms */
-#define TPM_I2C_LONG_TIMEOUT   2000    /* 2 sec */
-
 #define ATMEL_STS_OK 1
 
 struct priv_data {
@@ -174,12 +171,6 @@ static int i2c_atmel_probe(struct i2c_client *client)
 	if (!priv)
 		return -ENOMEM;
 
-	/* Default timeouts */
-	chip->timeout_a = msecs_to_jiffies(TPM_I2C_SHORT_TIMEOUT);
-	chip->timeout_b = msecs_to_jiffies(TPM_I2C_LONG_TIMEOUT);
-	chip->timeout_c = msecs_to_jiffies(TPM_I2C_SHORT_TIMEOUT);
-	chip->timeout_d = msecs_to_jiffies(TPM_I2C_SHORT_TIMEOUT);
-
 	dev_set_drvdata(&chip->dev, priv);
 
 	/*
diff --git a/drivers/char/tpm/tpm_i2c_infineon.c b/drivers/char/tpm/tpm_i2c_infineon.c
index fffa235068df..0e7d08e0851d 100644
--- a/drivers/char/tpm/tpm_i2c_infineon.c
+++ b/drivers/char/tpm/tpm_i2c_infineon.c
@@ -299,11 +299,6 @@ enum tis_status {
 	TPM_STS_DATA_EXPECT = 0x08,
 };
 
-enum tis_defaults {
-	TIS_SHORT_TIMEOUT = 750,	/* ms */
-	TIS_LONG_TIMEOUT = 2000,	/* 2 sec */
-};
-
 #define	TPM_ACCESS(l)			(0x0000 | ((l) << 4))
 #define	TPM_STS(l)			(0x0001 | ((l) << 4))
 #define	TPM_DATA_FIFO(l)		(0x0005 | ((l) << 4))
@@ -352,7 +347,7 @@ static int request_locality(struct tpm_chip *chip, int loc)
 	iic_tpm_write(TPM_ACCESS(loc), &buf, 1);
 
 	/* wait for burstcount */
-	stop = jiffies + chip->timeout_a;
+	stop = jiffies + tpm_limits_jiffies(chip, TPM_LIMIT_A);
 	do {
 		if (check_locality(chip, loc))
 			return loc;
@@ -394,7 +389,7 @@ static ssize_t get_burstcount(struct tpm_chip *chip)
 
 	/* wait for burstcount */
 	/* which timeout value, spec has 2 answers (c & d) */
-	stop = jiffies + chip->timeout_d;
+	stop = jiffies + tpm_limits_jiffies(chip, TPM_LIMIT_D);
 	do {
 		/* Note: STS is little endian */
 		if (iic_tpm_read(TPM_STS(tpm_dev.locality)+1, buf, 3) < 0)
@@ -497,7 +492,8 @@ static int tpm_tis_i2c_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 		goto out;
 	}
 
-	wait_for_stat(chip, TPM_STS_VALID, chip->timeout_c, &status);
+	wait_for_stat(chip, TPM_STS_VALID,
+		      tpm_limits_jiffies(chip, TPM_LIMIT_C), &status);
 	if (status & TPM_STS_DATA_AVAIL) {	/* retry? */
 		dev_err(&chip->dev, "Error left over data\n");
 		size = -EIO;
@@ -534,7 +530,7 @@ static int tpm_tis_i2c_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
 		tpm_tis_i2c_ready(chip);
 		if (wait_for_stat
 		    (chip, TPM_STS_COMMAND_READY,
-		     chip->timeout_b, &status) < 0) {
+		     tpm_limits_jiffies(chip, TPM_LIMIT_B), &status) < 0) {
 			rc = -ETIME;
 			goto out_err;
 		}
@@ -566,7 +562,7 @@ static int tpm_tis_i2c_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
 		}
 
 		wait_for_stat(chip, TPM_STS_VALID,
-			      chip->timeout_c, &status);
+			      tpm_limits_jiffies(chip, TPM_LIMIT_C), &status);
 
 		if ((status & TPM_STS_DATA_EXPECT) == 0) {
 			rc = -EIO;
@@ -576,7 +572,8 @@ static int tpm_tis_i2c_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
 
 	/* write last byte */
 	iic_tpm_write(TPM_DATA_FIFO(tpm_dev.locality), &(buf[count]), 1);
-	wait_for_stat(chip, TPM_STS_VALID, chip->timeout_c, &status);
+	wait_for_stat(chip, TPM_STS_VALID,
+		      tpm_limits_jiffies(chip, TPM_LIMIT_C), &status);
 	if ((status & TPM_STS_DATA_EXPECT) != 0) {
 		rc = -EIO;
 		goto out_err;
@@ -622,12 +619,6 @@ static int tpm_tis_i2c_init(struct device *dev)
 	if (IS_ERR(chip))
 		return PTR_ERR(chip);
 
-	/* Default timeouts */
-	chip->timeout_a = msecs_to_jiffies(TIS_SHORT_TIMEOUT);
-	chip->timeout_b = msecs_to_jiffies(TIS_LONG_TIMEOUT);
-	chip->timeout_c = msecs_to_jiffies(TIS_SHORT_TIMEOUT);
-	chip->timeout_d = msecs_to_jiffies(TIS_SHORT_TIMEOUT);
-
 	if (request_locality(chip, 0) != 0) {
 		dev_err(dev, "could not request locality\n");
 		rc = -ENODEV;
diff --git a/drivers/char/tpm/tpm_i2c_nuvoton.c b/drivers/char/tpm/tpm_i2c_nuvoton.c
index b01e42ad121e..15b70939ee39 100644
--- a/drivers/char/tpm/tpm_i2c_nuvoton.c
+++ b/drivers/char/tpm/tpm_i2c_nuvoton.c
@@ -82,9 +82,6 @@ static s32 i2c_nuvoton_write_buf(struct i2c_client *client, u8 offset, u8 size,
 #define TPM_STS_RESPONSE_RETRY 0x02
 #define TPM_STS_ERR_VAL        0x07    /* bit2...bit0 reads always 0 */
 
-#define TPM_I2C_SHORT_TIMEOUT  750     /* ms */
-#define TPM_I2C_LONG_TIMEOUT   2000    /* 2 sec */
-
 /* read TPM_STS register */
 static u8 i2c_nuvoton_read_status(struct tpm_chip *chip)
 {
@@ -136,7 +133,7 @@ static void i2c_nuvoton_ready(struct tpm_chip *chip)
 static int i2c_nuvoton_get_burstcount(struct i2c_client *client,
 				      struct tpm_chip *chip)
 {
-	unsigned long stop = jiffies + chip->timeout_d;
+	unsigned long stop = jiffies + tpm_limits_jiffies(chip, TPM_LIMIT_D);
 	s32 status;
 	int burst_count = -1;
 	u8 data;
@@ -235,10 +232,11 @@ static int i2c_nuvoton_recv_data(struct i2c_client *client,
 	struct priv_data *priv = dev_get_drvdata(&chip->dev);
 	s32 rc;
 	int burst_count, bytes2read, size = 0;
+	unsigned long timeout_c = tpm_limits_jiffies(chip, TPM_LIMIT_C);
 
 	while (size < count &&
 	       i2c_nuvoton_wait_for_data_avail(chip,
-					       chip->timeout_c,
+					       timeout_c,
 					       &priv->read_queue) == 0) {
 		burst_count = i2c_nuvoton_get_burstcount(client, chip);
 		if (burst_count < 0) {
@@ -275,6 +273,7 @@ static int i2c_nuvoton_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 	int retries;
 	int size = 0;
 	u32 expected;
+	unsigned long timeout_c = tpm_limits_jiffies(chip, TPM_LIMIT_C);
 
 	if (count < TPM_HEADER_SIZE) {
 		i2c_nuvoton_ready(chip);    /* return to idle */
@@ -292,7 +291,7 @@ static int i2c_nuvoton_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 		 * tag, paramsize, and result
 		 */
 		status = i2c_nuvoton_wait_for_data_avail(
-			chip, chip->timeout_c, &priv->read_queue);
+			chip, timeout_c, &priv->read_queue);
 		if (status != 0) {
 			dev_err(dev, "%s() timeout on dataAvail\n", __func__);
 			size = -ETIMEDOUT;
@@ -332,7 +331,7 @@ static int i2c_nuvoton_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 		}
 		if (i2c_nuvoton_wait_for_stat(
 			    chip, TPM_STS_VALID | TPM_STS_DATA_AVAIL,
-			    TPM_STS_VALID, chip->timeout_c,
+			    TPM_STS_VALID, timeout_c,
 			    NULL)) {
 			dev_err(dev, "%s() error left over data\n", __func__);
 			size = -ETIMEDOUT;
@@ -362,12 +361,14 @@ static int i2c_nuvoton_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
 	unsigned long duration;
 	size_t count = 0;
 	int burst_count, bytes2write, retries, rc = -EIO;
+	unsigned long timeout_b = tpm_limits_jiffies(chip, TPM_LIMIT_B);
+	unsigned long timeout_c = tpm_limits_jiffies(chip, TPM_LIMIT_C);
 
 	for (retries = 0; retries < TPM_RETRY; retries++) {
 		i2c_nuvoton_ready(chip);
 		if (i2c_nuvoton_wait_for_stat(chip, TPM_STS_COMMAND_READY,
 					      TPM_STS_COMMAND_READY,
-					      chip->timeout_b, NULL)) {
+					      timeout_b, NULL)) {
 			dev_err(dev, "%s() timeout on commandReady\n",
 				__func__);
 			rc = -EIO;
@@ -399,7 +400,7 @@ static int i2c_nuvoton_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
 						       TPM_STS_EXPECT,
 						       TPM_STS_VALID |
 						       TPM_STS_EXPECT,
-						       chip->timeout_c,
+						       timeout_c,
 						       NULL);
 			if (rc < 0) {
 				dev_err(dev, "%s() timeout on Expect\n",
@@ -424,7 +425,7 @@ static int i2c_nuvoton_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
 		rc = i2c_nuvoton_wait_for_stat(chip,
 					       TPM_STS_VALID | TPM_STS_EXPECT,
 					       TPM_STS_VALID,
-					       chip->timeout_c, NULL);
+					       timeout_c, NULL);
 		if (rc) {
 			dev_err(dev, "%s() timeout on Expect to clear\n",
 				__func__);
@@ -554,12 +555,6 @@ static int i2c_nuvoton_probe(struct i2c_client *client)
 
 	init_waitqueue_head(&priv->read_queue);
 
-	/* Default timeouts */
-	chip->timeout_a = msecs_to_jiffies(TPM_I2C_SHORT_TIMEOUT);
-	chip->timeout_b = msecs_to_jiffies(TPM_I2C_LONG_TIMEOUT);
-	chip->timeout_c = msecs_to_jiffies(TPM_I2C_SHORT_TIMEOUT);
-	chip->timeout_d = msecs_to_jiffies(TPM_I2C_SHORT_TIMEOUT);
-
 	dev_set_drvdata(&chip->dev, priv);
 
 	/*
@@ -578,6 +573,9 @@ static int i2c_nuvoton_probe(struct i2c_client *client)
 		if (rc) {
 			priv->irq = 0;
 		} else {
+			unsigned long timeout_b =
+				tpm_limits_jiffies(chip, TPM_LIMIT_B);
+
 			chip->flags |= TPM_CHIP_FLAG_IRQ;
 			/* Clear any pending interrupt */
 			i2c_nuvoton_ready(chip);
@@ -585,7 +583,7 @@ static int i2c_nuvoton_probe(struct i2c_client *client)
 			rc = i2c_nuvoton_wait_for_stat(chip,
 						       TPM_STS_COMMAND_READY,
 						       TPM_STS_COMMAND_READY,
-						       chip->timeout_b,
+						       timeout_b,
 						       NULL);
 			if (rc == 0) {
 				/*
diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 384468920b5d..6f06739c05a8 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -137,7 +137,7 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
 static int wait_startup(struct tpm_chip *chip, int l)
 {
 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
-	unsigned long stop = jiffies + chip->timeout_a;
+	unsigned long stop = jiffies + tpm_limits_jiffies(chip, TPM_LIMIT_A);
 
 	do {
 		int rc;
@@ -210,7 +210,7 @@ static int __tpm_tis_request_locality(struct tpm_chip *chip, int l)
 	if (rc < 0)
 		return rc;
 
-	stop = jiffies + chip->timeout_a;
+	stop = jiffies + tpm_limits_jiffies(chip, TPM_LIMIT_A);
 
 	if (chip->flags & TPM_CHIP_FLAG_IRQ) {
 again:
@@ -303,9 +303,9 @@ static int get_burstcount(struct tpm_chip *chip)
 
 	/* wait for burstcount */
 	if (chip->flags & TPM_CHIP_FLAG_TPM2)
-		stop = jiffies + chip->timeout_a;
+		stop = jiffies + tpm_limits_jiffies(chip, TPM_LIMIT_A);
 	else
-		stop = jiffies + chip->timeout_d;
+		stop = jiffies + tpm_limits_jiffies(chip, TPM_LIMIT_D);
 	do {
 		rc = tpm_tis_read32(priv, TPM_STS(priv->locality), &value);
 		if (rc < 0)
@@ -327,7 +327,7 @@ static int recv_data(struct tpm_chip *chip, u8 *buf, size_t count)
 	while (size < count) {
 		rc = wait_for_tpm_stat(chip,
 				 TPM_STS_DATA_AVAIL | TPM_STS_VALID,
-				 chip->timeout_c,
+				 tpm_limits_jiffies(chip, TPM_LIMIT_C),
 				 &priv->read_queue, true);
 		if (rc < 0)
 			return rc;
@@ -382,8 +382,9 @@ static int tpm_tis_try_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 		goto out;
 	}
 
-	if (wait_for_tpm_stat(chip, TPM_STS_VALID, chip->timeout_c,
-				&priv->int_queue, false) < 0) {
+	if (wait_for_tpm_stat(chip, TPM_STS_VALID,
+			      tpm_limits_jiffies(chip, TPM_LIMIT_C),
+			      &priv->int_queue, false) < 0) {
 		size = -ETIME;
 		goto out;
 	}
@@ -447,9 +448,9 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
 	status = tpm_tis_status(chip);
 	if ((status & TPM_STS_COMMAND_READY) == 0) {
 		tpm_tis_ready(chip);
-		if (wait_for_tpm_stat
-		    (chip, TPM_STS_COMMAND_READY, chip->timeout_b,
-		     &priv->int_queue, false) < 0) {
+		if (wait_for_tpm_stat(chip, TPM_STS_COMMAND_READY,
+				      tpm_limits_jiffies(chip, TPM_LIMIT_B),
+				      &priv->int_queue, false) < 0) {
 			rc = -ETIME;
 			goto out_err;
 		}
@@ -470,8 +471,9 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
 
 		count += burstcnt;
 
-		if (wait_for_tpm_stat(chip, TPM_STS_VALID, chip->timeout_c,
-					&priv->int_queue, false) < 0) {
+		if (wait_for_tpm_stat(chip, TPM_STS_VALID,
+				      tpm_limits_jiffies(chip, TPM_LIMIT_C),
+				      &priv->int_queue, false) < 0) {
 			if (test_bit(TPM_TIS_STATUS_VALID_RETRY, &priv->flags))
 				rc = -EAGAIN;
 			else
@@ -492,8 +494,9 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
 	if (rc < 0)
 		goto out_err;
 
-	if (wait_for_tpm_stat(chip, TPM_STS_VALID, chip->timeout_c,
-				&priv->int_queue, false) < 0) {
+	if (wait_for_tpm_stat(chip, TPM_STS_VALID,
+			      tpm_limits_jiffies(chip, TPM_LIMIT_C),
+			      &priv->int_queue, false) < 0) {
 		if (test_bit(TPM_TIS_STATUS_VALID_RETRY, &priv->flags))
 			rc = -EAGAIN;
 		else
diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm_tis_i2c_cr50.c
index 0acfc36eff16..3a39ec49d3f3 100644
--- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
+++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
@@ -95,6 +95,7 @@ static irqreturn_t tpm_cr50_i2c_int_handler(int dummy, void *tpm_info)
 static int tpm_cr50_i2c_wait_tpm_ready(struct tpm_chip *chip)
 {
 	struct tpm_i2c_cr50_priv_data *priv = dev_get_drvdata(&chip->dev);
+	unsigned long timeout = tpm_limits_jiffies(chip, TPM_LIMIT_A);
 
 	/* Use a safe fixed delay if interrupt is not supported */
 	if (priv->irq <= 0) {
@@ -103,7 +104,7 @@ static int tpm_cr50_i2c_wait_tpm_ready(struct tpm_chip *chip)
 	}
 
 	/* Wait for interrupt to indicate TPM is ready to respond */
-	if (!wait_for_completion_timeout(&priv->tpm_ready, chip->timeout_a)) {
+	if (!wait_for_completion_timeout(&priv->tpm_ready, timeout)) {
 		dev_warn(&chip->dev, "Timeout waiting for TPM ready\n");
 		return -ETIMEDOUT;
 	}
@@ -362,7 +363,7 @@ static int tpm_cr50_request_locality(struct tpm_chip *chip, int loc)
 	if (rc < 0)
 		goto unlock_out;
 
-	stop = jiffies + chip->timeout_a;
+	stop = jiffies + tpm_limits_jiffies(chip, TPM_LIMIT_A);
 	do {
 		if (tpm_cr50_check_locality(chip, loc) == loc)
 			return loc;
@@ -433,7 +434,7 @@ static int tpm_cr50_i2c_get_burst_and_status(struct tpm_chip *chip, u8 mask,
 	*status = 0;
 
 	/* wait for burstcount */
-	stop = jiffies + chip->timeout_b;
+	stop = jiffies + tpm_limits_jiffies(chip, TPM_LIMIT_B);
 
 	do {
 		if (tpm_cr50_i2c_read(chip, TPM_I2C_STS(chip->locality), buf, sizeof(buf)) < 0) {
@@ -563,7 +564,7 @@ static int tpm_cr50_i2c_tis_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
 	int rc;
 
 	/* Wait until TPM is ready for a command */
-	stop = jiffies + chip->timeout_b;
+	stop = jiffies + tpm_limits_jiffies(chip, TPM_LIMIT_B);
 	while (!(tpm_cr50_i2c_tis_status(chip) & TPM_STS_COMMAND_READY)) {
 		if (time_after(jiffies, stop)) {
 			rc = -ETIMEDOUT;
@@ -738,12 +739,6 @@ static int tpm_cr50_i2c_probe(struct i2c_client *client)
 	if (tpm_cr50_i2c_is_firmware_power_managed(dev))
 		chip->flags |= TPM_CHIP_FLAG_FIRMWARE_POWER_MANAGED;
 
-	/* Default timeouts */
-	chip->timeout_a = msecs_to_jiffies(TIS_SHORT_TIMEOUT);
-	chip->timeout_b = msecs_to_jiffies(TIS_LONG_TIMEOUT);
-	chip->timeout_c = msecs_to_jiffies(TIS_SHORT_TIMEOUT);
-	chip->timeout_d = msecs_to_jiffies(TIS_SHORT_TIMEOUT);
-
 	dev_set_drvdata(&chip->dev, priv);
 	init_completion(&priv->tpm_ready);
 
diff --git a/drivers/char/tpm/xen-tpmfront.c b/drivers/char/tpm/xen-tpmfront.c
index 3c0cce57c4ae..b1624345891a 100644
--- a/drivers/char/tpm/xen-tpmfront.c
+++ b/drivers/char/tpm/xen-tpmfront.c
@@ -148,8 +148,9 @@ static int vtpm_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
 		return -EINVAL;
 
 	/* Wait for completion of any existing command or cancellation */
-	if (wait_for_tpm_stat(chip, VTPM_STATUS_IDLE, chip->timeout_c,
-			&priv->read_queue, true) < 0) {
+	if (wait_for_tpm_stat(chip, VTPM_STATUS_IDLE,
+			      tpm_limits_jiffies(chip, TPM_LIMIT_C),
+			      &priv->read_queue, true) < 0) {
 		vtpm_cancel(chip);
 		return -ETIME;
 	}
@@ -185,8 +186,9 @@ static int vtpm_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 		return -ECANCELED;
 
 	/* In theory the wait at the end of _send makes this one unnecessary */
-	if (wait_for_tpm_stat(chip, VTPM_STATUS_RESULT, chip->timeout_c,
-			&priv->read_queue, true) < 0) {
+	if (wait_for_tpm_stat(chip, VTPM_STATUS_RESULT,
+			      tpm_limits_jiffies(chip, TPM_LIMIT_C),
+			      &priv->read_queue, true) < 0) {
 		vtpm_cancel(chip);
 		return -ETIME;
 	}
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 25c30f3fc269..506b81ed3239 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -59,16 +59,6 @@ struct tpm_class_ops {
 
 #define TPM_NUM_EVENT_LOG_FILES		3
 
-/* Indexes the duration array */
-enum tpm_duration {
-	TPM_SHORT = 0,
-	TPM_MEDIUM = 1,
-	TPM_LONG = 2,
-	TPM_LONG_LONG = 3,
-	TPM_UNDEFINED,
-	TPM_NUM_DURATIONS = TPM_UNDEFINED,
-};
-
 enum tpm_limit {
 	/* Interface handshake timeouts */
 	TPM_LIMIT_A,
@@ -175,12 +165,7 @@ struct tpm_chip {
 
 	struct mutex tpm_mutex;	/* tpm is processing */
 
-	unsigned long timeout_a; /* jiffies */
-	unsigned long timeout_b; /* jiffies */
-	unsigned long timeout_c; /* jiffies */
-	unsigned long timeout_d; /* jiffies */
 	bool timeout_adjusted;
-	unsigned long duration[TPM_NUM_DURATIONS]; /* jiffies */
 	bool duration_adjusted;
 
 	struct tpm_limits limits;
-- 
2.47.3


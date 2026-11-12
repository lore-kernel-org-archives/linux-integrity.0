Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.246.1.125
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794501850;
	b=VG4MzW6UDpdLu3duSww8iq6YcbuzNaXsObkDl6TXk2HisHvlTH+qbEeH+4/m75no6ZrJ
	 tCJBeWGmQlF7vrwdb6PGZ7djHOqsqVBVbHL40St88CQSzJfnT+yklis1Dt3jVpUGS/a2G
	 /oaOzcgJsa8e0P5zrYwiyx1BAIb+vAivLy5OUKPvGdwpboLxN4vkLv2Ttdirur85/r9xc
	 xMcOBEoFaynFMc9wEyW4TiwIIQy4fTDlx0bbKMCTppEg28tF8pcX6m1Xw0TvSiH5XsDu+
	 kxjOZQ839wxzIwZnm9jwv5dDvQgAU3s17bfQX44oKG8cwC0BUFgAC2mfAwXj+CR5q2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794501850;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=5Xyookw3idw+kX8Luu7Tsb3UEECqIFpoekW+J8OdzE8=;
	b=ywZoBzsFghZ67ViZ8W3MRP7PQy3jqH2/YxhrGMUzFp4YVC0KKL85OszgmiU9TsWvOgif
	 yXfZiXF9S9/98jI5HqnZCvKQ0/hUNmcJUkcqc1DF6D9Th9u48s4q9i7Hu3Omcn4Su+Bqh
	 hj9maLsfsX2he9gMbwxiCaj/L789NCRustlleZiju0b13pvp44NPUsUuFo1EgQ0NVtCJ2
	 qNfzMNhWI5Bl4nhrj5UPyVD12G2B5EucG9DQpoeGmwVaj+7wL3YWADHqI4tu2Yc5/no4o
	 Ssp60EHfH/vCrBvtqBWLdXgyWHELF8Ec3ZYN0oU1MnueOj6oh8hgLXRe/3L6Vc8l+aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=lyjwA1yj;
	arc=none smtp.remote-ip=44.246.1.125
Received: from pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.1.125])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C68606A327;
	Thu, 12 Nov 2026 16:44:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57C68606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=lyjwA1yj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794501850; x=1826037850;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5Xyookw3idw+kX8Luu7Tsb3UEECqIFpoekW+J8OdzE8=;
  b=lyjwA1yjfSpIyn1+mHo4k59trB1TN6Bd3U5zhx5U2/9n7LCcOurgWjis
   nl3vSX/2QBj6l8gUTxWsAzv4HKRrknEMj3pCaInlu+3ut1w7HtaJ7nqgJ
   3BejaVQoIT+96LvnHO3nTz5pdkOMPOuTHkkVKCN91Me4hNnOdSbPBf86M
   7+pb5JRgIQcnRlsj4TMzmHapf5nKWlqekUZm1wfTF/H26e2ICUcKcT02f
   hinqTFU285qUaK7kktd1nxVeuXN+o0v1/ohvq7144890zPZw/79795x5D
   o0qy/ozjhDEaUv62ieqcEuegZyrFSNGZ0fGzG35Dj42sion+2L4WtHBNN
   g==;
X-CSE-ConnectionGUID: qXyTVadzRxmEKchkNBDuVQ==
X-CSE-MsgGUID: dd7GvnwBS5a4m95Fg6FVUw==
X-IronPort-AV: E=Sophos;i="6.27,210,1787011200"; 
   d="scan'208";a="33840138"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 16:44:07 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:30908]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.12.127:2525] with esmtp (Farcaster)
 id 7870cf77-2ea5-4f81-afd0-3e555662edd6; Thu, 12 Nov 2026 16:44:07 +0000 (UTC)
X-Farcaster-Flow-ID: 7870cf77-2ea5-4f81-afd0-3e555662edd6
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Thu, 12 Nov 2026 16:44:06 +0000
Received: from dev-dsk-surenkj-2b-416930d2.us-west-2.amazon.com (10.169.26.94)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Thu, 12 Nov 2026 16:44:06 +0000
From: Surendran Kanagaraj <surenkj@amazon.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, Peter Huewe <peterhuewe@gmx.de>
CC: Jason Gunthorpe <jgg@ziepe.ca>, <linux-integrity@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, Jonathan McDowell <noodles@earth.li>, "Breno
 Leitao" <leitao@debian.org>, <nh-open-source@amazon.com>, Alexander Graf
	<graf@amazon.de>, Gunnar Kudrjavets <gunnarku@amazon.com>, Josh Levinson
	<joshlev@amazon.com>
Subject: [RFC PATCH v3 6/8] tpm: Add the tpm.limits= parameter
Date: Thu, 12 Nov 2026 16:43:50 +0000
Message-ID: <20261112164350.707-1-surenkj@amazon.com>
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
X-ClientProxiedBy: EX19D031UWA003.ant.amazon.com (10.13.139.47) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

When a TPM needs more time than its limits allow, the only way to give
it more is to change its driver and rebuild the kernel.

Add tpm.limits=, which takes name:usecs pairs such as
tpm.limits=timeout_c:2000000,long:600000000. The values apply when the
chip is allocated and again after the driver's ->adjust_limits() hook,
both times before validation, so they carry the new PARAM source and
still get the floor and the ceiling. Document the parameter in
kernel-parameters.txt.

Signed-off-by: Surendran Kanagaraj <surenkj@amazon.com>
---
 .../admin-guide/kernel-parameters.txt         |  13 +++
 drivers/char/tpm/tpm-limits.c                 | 102 +++++++++++++++++-
 include/linux/tpm.h                           |   1 +
 3 files changed, 112 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0b3c140babd9..3c4d6f3101d4 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -7667,6 +7667,19 @@ Kernel parameters
 			causing a major performance hit, and the space where
 			machines are deployed is by other means guarded.
 
+	tpm.limits=	[HW,TPM]
+			Format: <name>:<usecs>[,<name>:<usecs>...]
+			Override how long the kernel waits for the TPM.
+			The names are timeout_a, timeout_b, timeout_c and
+			timeout_d for the interface timeouts, and short,
+			medium, long, long_long and default for command
+			execution. long also bounds the total sleep between
+			resubmissions of a command a TPM 2.0 chip asked to
+			retry. Values are in microseconds, and the TPM core
+			still applies its floor and ceiling. A value of 0
+			leaves that limit unchanged.
+			Example: tpm.limits=timeout_c:2000000,long:600000000
+
 	tpm_crb_ffa.busy_timeout_ms= [ARM64,TPM]
 			Maximum time in milliseconds to retry sending a message
 			to the TPM service before giving up. This parameter controls
diff --git a/drivers/char/tpm/tpm-limits.c b/drivers/char/tpm/tpm-limits.c
index 2cd51a9f27ba..251772b286a1 100644
--- a/drivers/char/tpm/tpm-limits.c
+++ b/drivers/char/tpm/tpm-limits.c
@@ -5,6 +5,7 @@
 
 #include <linux/kernel.h>
 #include <linux/ktime.h>
+#include <linux/moduleparam.h>
 #include <linux/string.h>
 #include <linux/tpm_ptp.h>
 #include "tpm.h"
@@ -72,8 +73,87 @@ static const char * const tpm_limit_src_names[] = {
 	[TPM_LSRC_DEFAULT]	= "DEFAULT",
 	[TPM_LSRC_TPM]		= "TPM",
 	[TPM_LSRC_DRIVER]	= "DRIVER",
+	[TPM_LSRC_PARAM]	= "PARAM",
 };
 
+/* tpm.limits=, in usecs per limit; 0 leaves the limit alone. */
+static u32 tpm_param_us[TPM_NR_LIMITS];
+
+/*
+ * Parse "name:usecs[,name:usecs...]" into @us. Built-in params are parsed
+ * before slab is up, so parse a stack copy; over 255 characters is -E2BIG.
+ */
+static int tpm_limits_parse_param(const char *val, u32 *us)
+{
+	char buf[256], *cur = buf, *tok;
+	int limit, rc;
+
+	memset(us, 0, TPM_NR_LIMITS * sizeof(*us));
+	if (strscpy(buf, val, sizeof(buf)) < 0)
+		return -E2BIG;
+
+	while ((tok = strsep(&cur, ",")) != NULL) {
+		char *num;
+
+		tok = strim(tok);
+		if (!*tok)
+			continue;
+
+		num = strchr(tok, ':');
+		if (!num)
+			return -EINVAL;
+		*num++ = '\0';
+
+		limit = match_string(tpm_limit_names, TPM_NR_LIMITS, tok);
+		if (limit < 0)
+			return -EINVAL;
+
+		rc = kstrtou32(num, 0, &us[limit]);
+		if (rc)
+			return rc;
+	}
+
+	return 0;
+}
+
+/* A rejected string applies none of its values. */
+static int tpm_limits_param_set(const char *val,
+				const struct kernel_param *kp)
+{
+	u32 us[TPM_NR_LIMITS];
+	int rc;
+
+	rc = tpm_limits_parse_param(val, us);
+	if (!rc)
+		memcpy(tpm_param_us, us, sizeof(us));
+
+	return rc;
+}
+
+static int tpm_limits_param_get(char *buf, const struct kernel_param *kp)
+{
+	int len = 0;
+	int limit;
+
+	for (limit = 0; limit < TPM_NR_LIMITS; limit++) {
+		if (!tpm_param_us[limit])
+			continue;
+		len += scnprintf(buf + len, PAGE_SIZE - len, "%s%s:%u",
+				 len ? "," : "", tpm_limit_names[limit],
+				 tpm_param_us[limit]);
+	}
+
+	return len + scnprintf(buf + len, PAGE_SIZE - len, "\n");
+}
+
+static const struct kernel_param_ops tpm_limits_param_ops = {
+	.set = tpm_limits_param_set,
+	.get = tpm_limits_param_get,
+};
+module_param_cb(limits, &tpm_limits_param_ops, NULL, 0444);
+MODULE_PARM_DESC(limits,
+		 "TPM wait limits in usecs, e.g. timeout_c:2000000,long:600000000");
+
 static u32 tpm_limits_default_us(enum tpm_family family, enum tpm_limit limit)
 {
 	switch (family) {
@@ -137,6 +217,17 @@ static void tpm_limits_stage_reported(struct tpm_limits *p,
 	}
 }
 
+static void tpm_limits_stage_param(struct tpm_limits *p)
+{
+	int limit;
+
+	for (limit = 0; limit < TPM_NR_LIMITS; limit++) {
+		if (tpm_param_us[limit])
+			tpm_limits_store(p, limit, tpm_param_us[limit],
+					 TPM_LSRC_PARAM, 0);
+	}
+}
+
 static void tpm_limits_stage_validate(struct tpm_limits *p)
 {
 	int limit;
@@ -186,7 +277,7 @@ static void tpm_limits_commit(struct tpm_chip *chip,
  * @chip: the chip tpm_chip_alloc() is setting up
  *
  * The family is not known yet, so each limit gets the larger of the two
- * families' defaults before validation applies.
+ * families' defaults before the tpm.limits= parameter and validation apply.
  * The driver's data is not attached yet, so its ->adjust_limits() hook first
  * runs from tpm_limits_update().
  */
@@ -195,6 +286,7 @@ void tpm_limits_init(struct tpm_chip *chip)
 	struct tpm_limits p;
 
 	tpm_limits_stage_defaults(&p, TPM_FAMILY_UNKNOWN);
+	tpm_limits_stage_param(&p);
 	tpm_limits_stage_validate(&p);
 	tpm_limits_commit(chip, &p);
 }
@@ -206,9 +298,10 @@ void tpm_limits_init(struct tpm_chip *chip)
  *		zero where the TPM reported nothing; or NULL
  *
  * Runs the stages in order: the family defaults, @reported, the driver's
- * ->adjust_limits() hook, then validation. The hook may send commands, so
- * the chip must be started. Call it before the chip is registered or with
- * tpm_mutex held, so that no command sees half-built limits.
+ * ->adjust_limits() hook, the tpm.limits= parameter, then validation. The
+ * hook may send commands, so the chip must be started. Call it before the
+ * chip is registered or with tpm_mutex held, so that no command sees
+ * half-built limits.
  */
 void tpm_limits_update(struct tpm_chip *chip, const u32 *reported)
 {
@@ -221,6 +314,7 @@ void tpm_limits_update(struct tpm_chip *chip, const u32 *reported)
 		tpm_limits_stage_reported(&p, reported);
 	if (chip->ops->adjust_limits)
 		chip->ops->adjust_limits(chip, &p);
+	tpm_limits_stage_param(&p);
 	tpm_limits_stage_validate(&p);
 	tpm_limits_commit(chip, &p);
 }
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 8ff1683f21ea..a4b7282d88b5 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -89,6 +89,7 @@ enum tpm_limit_src {
 	TPM_LSRC_DEFAULT,	/* default values */
 	TPM_LSRC_TPM,		/* reported by the TPM */
 	TPM_LSRC_DRIVER,	/* set by the driver */
+	TPM_LSRC_PARAM,		/* tpm.limits= */
 };
 
 #define TPM_LF_CLAMPED		BIT(0)	/* limit validation replaced the value */
-- 
2.47.3


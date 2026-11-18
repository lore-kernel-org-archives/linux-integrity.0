Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.42.203.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794988162;
	b=MJtzg7ARWyqzx7dwZWOjaQ8sL8p9EmDIpZ1+NE4GrT53RYjR2qaH+jDiLr+4sZP/68KJ
	 QRHmx66a2lD6uPlmKg/KOgjmalxIdJIvlgH+ywA4dJgW1CS6J/wYKpfXcCdOmKJBWnj+w
	 dvX8EIPsak4TKooRaUOXZEA36wDSU6a07lowGvA0++xcQVO7Ly/1ybkxWnycckHPsEM1+
	 8QgTryEFT10JLQSpFTARiKWdHxZbCdUxP8KQ8FFGOf8A05y4zGlK7BpDqG3ymzkZJ+3ua
	 i6EtqpqgiTqlu0yccXyQyMS2NTyRqytYpTuPdRvqnRDfRjU8meFhScgZOlAXxm5cLbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794988162;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=q0chSUmfEpiQ0FAxpsDP5muDnrqGrrA5rjY/81tmS2Y=;
	b=ecCPHLw8jgo8S2nu438Sc8IQRhazgOZGfwE7cO38NRd6E3jb8XNy8g2PTgCJ+uQy1+WI
	 xApqgRKWjK1BtX4dPxNQIi00jSG2WWSz/OUG1KVfc2xYL+xU1SZsjADKcekD3IprM/I/r
	 D7jhwFWXyshxUU/rT+XUcy3h9W+GKf3/zSNRWWlZgqZcKv57DRe4Q3PJLCGY8LGwnu/KS
	 AjAe82qu0J5zn2QpQxh6fBCEzNpHZ2DaL1jtrHXyQhBBaE1rrClmVVkdGnqVKDgtlzV5i
	 9yi/kNfOLe0ADa1ftwQL8lvKFhOZzk6kANVg/vMC15PzHxMJli37CqIxTf/x/MoWJng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=NXoQjIc2;
	arc=none smtp.remote-ip=52.42.203.116
Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.42.203.116])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C626A606A31C;
	Wed, 18 Nov 2026 07:49:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C626A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=NXoQjIc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794988161; x=1826524161;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q0chSUmfEpiQ0FAxpsDP5muDnrqGrrA5rjY/81tmS2Y=;
  b=NXoQjIc21j5/K6NtsFL7qGU4TaNRgNLganwo/k11y+3Ngsae4nuU4Rtc
   oIsrUYL3Sz557zv72QyLvjH2wCQC36CbOjFsiNYrFRMt2jyA+A8tzAQG0
   c5YWb+B6WgnC7rXwAVvLhB1zvW8Cnb56MRMt4iX0VTM2Z629TqpNs+CFV
   Zo1x+x5W+hd/Zkx6X2fNANoJLXl2MmHuIqg/EZwha3Fd5CcRQ7Dd5AzKZ
   p7wxnGhpaGCTd+iMAKLXe3/OjEt7ILRS3/o2vHwYeuK1crVD8ygZjbn4T
   zWG8+yNzNDm6iK8Z8K4i3xSYLMkknQqNvqKW6wQ1zfNZ1WZ7VsIXMkjDg
   g==;
X-CSE-ConnectionGUID: l+K23fvkQ/yvRzgYS8cx/w==
X-CSE-MsgGUID: UScSh9/VTA+h71LaOx6Ocw==
X-IronPort-AV: E=Sophos;i="6.27,219,1787011200"; 
   d="scan'208";a="34460745"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 07:49:19 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:6038]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.50.212:2525] with esmtp (Farcaster)
 id b548e667-593e-4a7e-8c37-c71f1c8dc80f; Wed, 18 Nov 2026 07:49:18 +0000 (UTC)
X-Farcaster-Flow-ID: b548e667-593e-4a7e-8c37-c71f1c8dc80f
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 18 Nov 2026 07:49:18 +0000
Received: from dev-dsk-surenkj-2b-416930d2.us-west-2.amazon.com (10.169.26.94)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 18 Nov 2026 07:49:18 +0000
From: Surendran Kanagaraj <surenkj@amazon.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, Peter Huewe <peterhuewe@gmx.de>
CC: Jason Gunthorpe <jgg@ziepe.ca>, <linux-integrity@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
	<linux-doc@vger.kernel.org>, Jonathan McDowell <noodles@earth.li>, "Breno
 Leitao" <leitao@debian.org>, <nh-open-source@amazon.com>, Alexander Graf
	<graf@amazon.de>, Gunnar Kudrjavets <gunnarku@amazon.com>, Josh Levinson
	<joshlev@amazon.com>
Subject: [RFC PATCH v4 6/8] tpm: Add the tpm.limits= parameter
Date: Wed, 18 Nov 2026 07:49:02 +0000
Message-ID: <20261118074904.60624-2-surenkj@amazon.com>
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
X-ClientProxiedBy: EX19D031UWC001.ant.amazon.com (10.13.139.241) To
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
 drivers/char/tpm/tpm-limits.c                 | 106 +++++++++++++++++-
 include/linux/tpm.h                           |   1 +
 3 files changed, 114 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 176648941aec..05202b0a97f3 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -7660,6 +7660,19 @@ Kernel parameters
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
index 0efca95eec62..96d678220084 100644
--- a/drivers/char/tpm/tpm-limits.c
+++ b/drivers/char/tpm/tpm-limits.c
@@ -2,13 +2,15 @@
 /*
  * Per-chip time limits for TPM waits: the TIMEOUT_A to TIMEOUT_D interface
  * timeouts and the SHORT to DEFAULT command durations. Each chip owns one
- * table, built from the family defaults, the values a TPM chip reports and
- * the driver's ->adjust_limits() hook, each overriding the one before.
- * Every TPM wait on one of these limits reads it from this table.
+ * table, built from the family defaults, the values a TPM chip reports, the
+ * driver's ->adjust_limits() hook and the tpm.limits= parameter, each
+ * overriding the one before. Every TPM wait on one of these limits reads it
+ * from this table.
  */
 
 #include <linux/kernel.h>
 #include <linux/ktime.h>
+#include <linux/moduleparam.h>
 #include <linux/string.h>
 #include <linux/tpm_ptp.h>
 #include "tpm.h"
@@ -76,8 +78,87 @@ static const char * const tpm_limit_src_names[] = {
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
@@ -141,6 +222,17 @@ static void tpm_limits_stage_reported(struct tpm_limits *p,
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
@@ -190,7 +282,7 @@ static void tpm_limits_commit(struct tpm_chip *chip,
  * @chip: the chip tpm_chip_alloc() is setting up
  *
  * The family is not known yet, so each limit gets the larger of the two
- * families' defaults before validation applies.
+ * families' defaults before the tpm.limits= parameter and validation apply.
  * The driver's data is not attached yet, so its ->adjust_limits() hook first
  * runs from tpm_limits_update().
  */
@@ -199,6 +291,7 @@ void tpm_limits_init(struct tpm_chip *chip)
 	struct tpm_limits p;
 
 	tpm_limits_stage_defaults(&p, TPM_FAMILY_UNKNOWN);
+	tpm_limits_stage_param(&p);
 	tpm_limits_stage_validate(&p);
 	tpm_limits_commit(chip, &p);
 }
@@ -210,8 +303,8 @@ void tpm_limits_init(struct tpm_chip *chip)
  *		zero where the TPM reported nothing; or NULL
  *
  * Runs the stages in order: the family defaults, @reported, the driver's
- * ->adjust_limits() hook, then validation. The hook may send commands, so
- * the chip must be started.
+ * ->adjust_limits() hook, the tpm.limits= parameter, then validation. The
+ * hook may send commands, so the chip must be started.
  */
 void tpm_limits_update(struct tpm_chip *chip, const u32 *reported)
 {
@@ -224,6 +317,7 @@ void tpm_limits_update(struct tpm_chip *chip, const u32 *reported)
 		tpm_limits_stage_reported(&p, reported);
 	if (chip->ops->adjust_limits)
 		chip->ops->adjust_limits(chip, &p);
+	tpm_limits_stage_param(&p);
 	tpm_limits_stage_validate(&p);
 	tpm_limits_commit(chip, &p);
 }
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 506b81ed3239..b88c7b133bdd 100644
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


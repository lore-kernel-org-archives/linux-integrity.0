Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.34.181.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794501533;
	b=WlGIT2aNWuBjtvbJ43MRhT+9uV1ilTeragpqJjQJYVX2WYv/hNRfH6SGPsOPjHAc1CT7
	 KGFVcoG+qV7KKHkS7pgU2xC8dVVSBYrNQ7NEiNVUU5kvfyJx3mEe/VoTQNIxavravTl3g
	 BJT7umgX3q7qxyAtTfjNA+WBl/Dgv/4kt/1qSy/7RzSi5xuwGwiP3YvN+NrdAT9regeSv
	 6GSf8X2odBFQUO9wdteG4YanVBrMYvmrkQzP0629+vVERbuHPNZhhJweqELUGvtN1ynX9
	 Vi3j/oDb+Lu681zFQtNY+3YsKZ0Ig1Yu3Tn3r/gEpK6+X/mYQEc8gJvQMKNYK1Xyl+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794501533;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=S0NOAvNsy2O0DFJHbbWBCZrA7P2aZL+2vuTfscCO/DM=;
	b=bjRpz6x+nRzuzE9efSfE4OCAEvZnGSnN68aezovB1A7ZMBGGgmoq7zfWR3eCxxqFXS91
	 /NggYVexfIMSl6zCAN8vaovws8Dv5Z2A8/2tqjt5tjCVNq6pCGs4oz1+P0yIyTgqf0G2A
	 NQ50B8zHfoDybT50mnznha2U8+pk3uzrbPuYhcvyXMP1X6GiINV6hcTfvV0JCVd4GfV0G
	 G8ekfUyU68BUVPW8fSCM12KOSvezbgmvlhSp9fqUkeCMj85BBFv+4PSXB0qL4TAc1M79C
	 QAqf/g5HjrS4qTg2H56SiRYML6evOA7eGTyE+L5v1EHomOlbOE/gRlwTJS60+HyK5sA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=XN9ZXYjk;
	arc=none smtp.remote-ip=52.34.181.151
Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C3E606A330;
	Thu, 12 Nov 2026 16:38:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60C3E606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=XN9ZXYjk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794501533; x=1826037533;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S0NOAvNsy2O0DFJHbbWBCZrA7P2aZL+2vuTfscCO/DM=;
  b=XN9ZXYjkeL7jRadVI94iQkW9CagpmViwi7SmE8beMdQVfc8EE92L5yUq
   A4RAZYt9OkqIum1VaphDuMmWb4UNMElGo0cYxjKFbN+BlWD0mzt+bNBxf
   1e7vEFdJNoQeA4gCzkoD09QdIBNlaotlqgp+3uEUChAS+2KvUNJjfS1U7
   JhxcSukOhXOW2q2Vz5ywqmZ2pcSInV2GMAm9X2UMzU2XgISITcUtVGYkB
   r6XcMKj2JsnQcrYJYtexnUVWYDMfKv3yny3A+iQQVeDTWb6g26EGt7H61
   SKxMGezqHA6RAalBhCqg4GwQ0p5B6iGFeXqv9UdwfxPZAu0H9TzMugMmq
   w==;
X-CSE-ConnectionGUID: euqIrGhkRfKGtLSxI4MJ0A==
X-CSE-MsgGUID: sxw/XaqySw+9XMRZpuvYww==
X-IronPort-AV: E=Sophos;i="6.27,210,1787011200"; 
   d="scan'208";a="33826407"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 16:38:51 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:26362]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.34.255:2525] with esmtp (Farcaster)
 id 19a4b56d-2474-43be-9930-9f83efeb2f5a; Thu, 12 Nov 2026 16:38:50 +0000 (UTC)
X-Farcaster-Flow-ID: 19a4b56d-2474-43be-9930-9f83efeb2f5a
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
Subject: [RFC PATCH v3 3/8] tpm: Take command durations from the limits table
Date: Thu, 12 Nov 2026 16:38:41 +0000
Message-ID: <20261112163846.97654-4-surenkj@amazon.com>
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

TPM 2.0 commands still get their wait from a fixed map of durations.
The limits table never sees those values so they have no bounds and a
driver cannot adjust them. TPM 1.x already maps each ordinal to a class
through tpm1_ordinal_duration[] but reads the value from the jiffies
copies in struct tpm_chip.

Map each TPM 2.0 ordinal to a class too and have
tpm_calc_ordinal_duration() read the class's limit from the table for
both families. An ordinal neither table knows gets DEFAULT.

With the default limits, TPM2_VerifySignature is the only command whose
wait changes. Its 30 s matched no class, so it now gets DEFAULT 120 s.
On TPM 1.x an unknown ordinal still waits two minutes, unless LONG
ends up above that and validation raises DEFAULT to match.

Signed-off-by: Surendran Kanagaraj <surenkj@amazon.com>
---
 drivers/char/tpm/tpm-interface.c |  15 +-
 drivers/char/tpm/tpm.h           |   4 +-
 drivers/char/tpm/tpm1-cmd.c      | 518 +++++++++++++++----------------
 drivers/char/tpm/tpm2-cmd.c      |  58 ++--
 4 files changed, 294 insertions(+), 301 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index e0385b16616b..8e6ea9c04019 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -40,6 +40,14 @@ module_param_named(suspend_pcr, tpm_suspend_pcr, uint, 0644);
 MODULE_PARM_DESC(suspend_pcr,
 		 "PCR to use for dummy writes to facilitate flush on suspend.");
 
+static enum tpm_limit tpm_duration_limit(struct tpm_chip *chip, u32 ordinal)
+{
+	if (chip->flags & TPM_CHIP_FLAG_TPM2)
+		return tpm2_duration_limit(ordinal);
+
+	return tpm1_duration_limit(ordinal);
+}
+
 /**
  * tpm_calc_ordinal_duration() - calculate the maximum command duration
  * @chip:    TPM chip to use.
@@ -52,10 +60,9 @@ MODULE_PARM_DESC(suspend_pcr,
  */
 unsigned long tpm_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal)
 {
-	if (chip->flags & TPM_CHIP_FLAG_TPM2)
-		return tpm2_calc_ordinal_duration(ordinal);
-	else
-		return tpm1_calc_ordinal_duration(chip, ordinal);
+	enum tpm_limit limit = tpm_duration_limit(chip, ordinal);
+
+	return usecs_to_jiffies(chip->limits.entry[limit].time_us);
 }
 EXPORT_SYMBOL_GPL(tpm_calc_ordinal_duration);
 
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index be88011f9618..1e023f12a400 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -66,7 +66,7 @@ int tpm1_pm_suspend(struct tpm_chip *chip, u32 tpm_suspend_pcr);
 int tpm1_auto_startup(struct tpm_chip *chip);
 int tpm1_do_selftest(struct tpm_chip *chip);
 int tpm1_get_timeouts(struct tpm_chip *chip);
-unsigned long tpm1_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal);
+enum tpm_limit tpm1_duration_limit(u32 ordinal);
 int tpm1_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash,
 		    const char *log_msg);
 int tpm1_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf);
@@ -132,7 +132,7 @@ ssize_t tpm2_get_tpm_pt(struct tpm_chip *chip, u32 property_id,
 ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip);
 int tpm2_auto_startup(struct tpm_chip *chip);
 void tpm2_shutdown(struct tpm_chip *chip, u16 shutdown_type);
-unsigned long tpm2_calc_ordinal_duration(u32 ordinal);
+enum tpm_limit tpm2_duration_limit(u32 ordinal);
 int tpm2_probe(struct tpm_chip *chip);
 int tpm2_get_cc_attrs_tbl(struct tpm_chip *chip);
 int tpm2_find_cc(struct tpm_chip *chip, u32 cc);
diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index 9586b4944578..117948a2b318 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -31,279 +31,267 @@
  * from the chip during initialization with a call to tpm_get_timeouts.
  */
 static const u8 tpm1_ordinal_duration[TPM_MAX_ORDINAL] = {
-	TPM_UNDEFINED,		/* 0 */
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,		/* 5 */
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_SHORT,		/* 10 */
-	TPM_SHORT,
-	TPM_MEDIUM,
-	TPM_LONG,
-	TPM_LONG,
-	TPM_MEDIUM,		/* 15 */
-	TPM_SHORT,
-	TPM_SHORT,
-	TPM_MEDIUM,
-	TPM_LONG,
-	TPM_SHORT,		/* 20 */
-	TPM_SHORT,
-	TPM_MEDIUM,
-	TPM_MEDIUM,
-	TPM_MEDIUM,
-	TPM_SHORT,		/* 25 */
-	TPM_SHORT,
-	TPM_MEDIUM,
-	TPM_SHORT,
-	TPM_SHORT,
-	TPM_MEDIUM,		/* 30 */
-	TPM_LONG,
-	TPM_MEDIUM,
-	TPM_SHORT,
-	TPM_SHORT,
-	TPM_SHORT,		/* 35 */
-	TPM_MEDIUM,
-	TPM_MEDIUM,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_MEDIUM,		/* 40 */
-	TPM_LONG,
-	TPM_MEDIUM,
-	TPM_SHORT,
-	TPM_SHORT,
-	TPM_SHORT,		/* 45 */
-	TPM_SHORT,
-	TPM_SHORT,
-	TPM_SHORT,
-	TPM_LONG,
-	TPM_MEDIUM,		/* 50 */
-	TPM_MEDIUM,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,		/* 55 */
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_MEDIUM,		/* 60 */
-	TPM_MEDIUM,
-	TPM_MEDIUM,
-	TPM_SHORT,
-	TPM_SHORT,
-	TPM_MEDIUM,		/* 65 */
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_SHORT,		/* 70 */
-	TPM_SHORT,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,		/* 75 */
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_LONG,		/* 80 */
-	TPM_UNDEFINED,
-	TPM_MEDIUM,
-	TPM_LONG,
-	TPM_SHORT,
-	TPM_UNDEFINED,		/* 85 */
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_SHORT,		/* 90 */
-	TPM_SHORT,
-	TPM_SHORT,
-	TPM_SHORT,
-	TPM_SHORT,
-	TPM_UNDEFINED,		/* 95 */
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_MEDIUM,		/* 100 */
-	TPM_SHORT,
-	TPM_SHORT,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,		/* 105 */
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_SHORT,		/* 110 */
-	TPM_SHORT,
-	TPM_SHORT,
-	TPM_SHORT,
-	TPM_SHORT,
-	TPM_SHORT,		/* 115 */
-	TPM_SHORT,
-	TPM_SHORT,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_LONG,		/* 120 */
-	TPM_LONG,
-	TPM_MEDIUM,
-	TPM_UNDEFINED,
-	TPM_SHORT,
-	TPM_SHORT,		/* 125 */
-	TPM_SHORT,
-	TPM_LONG,
-	TPM_SHORT,
-	TPM_SHORT,
-	TPM_SHORT,		/* 130 */
-	TPM_MEDIUM,
-	TPM_UNDEFINED,
-	TPM_SHORT,
-	TPM_MEDIUM,
-	TPM_UNDEFINED,		/* 135 */
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_SHORT,		/* 140 */
-	TPM_SHORT,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,		/* 145 */
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_SHORT,		/* 150 */
-	TPM_MEDIUM,
-	TPM_MEDIUM,
-	TPM_SHORT,
-	TPM_SHORT,
-	TPM_UNDEFINED,		/* 155 */
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_SHORT,		/* 160 */
-	TPM_SHORT,
-	TPM_SHORT,
-	TPM_SHORT,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,		/* 165 */
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_LONG,		/* 170 */
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,		/* 175 */
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_MEDIUM,		/* 180 */
-	TPM_SHORT,
-	TPM_MEDIUM,
-	TPM_MEDIUM,
-	TPM_MEDIUM,
-	TPM_MEDIUM,		/* 185 */
-	TPM_SHORT,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,		/* 190 */
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,		/* 195 */
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_SHORT,		/* 200 */
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_SHORT,
-	TPM_SHORT,		/* 205 */
-	TPM_SHORT,
-	TPM_SHORT,
-	TPM_SHORT,
-	TPM_SHORT,
-	TPM_MEDIUM,		/* 210 */
-	TPM_UNDEFINED,
-	TPM_MEDIUM,
-	TPM_MEDIUM,
-	TPM_MEDIUM,
-	TPM_UNDEFINED,		/* 215 */
-	TPM_MEDIUM,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_SHORT,
-	TPM_SHORT,		/* 220 */
-	TPM_SHORT,
-	TPM_SHORT,
-	TPM_SHORT,
-	TPM_SHORT,
-	TPM_UNDEFINED,		/* 225 */
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_SHORT,		/* 230 */
-	TPM_LONG,
-	TPM_MEDIUM,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,		/* 235 */
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_SHORT,		/* 240 */
-	TPM_UNDEFINED,
-	TPM_MEDIUM,
+	TPM_LIMIT_DEFAULT,	/* 0 */
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,	/* 5 */
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_SHORT,	/* 10 */
+	TPM_LIMIT_SHORT,
+	TPM_LIMIT_MEDIUM,
+	TPM_LIMIT_LONG,
+	TPM_LIMIT_LONG,
+	TPM_LIMIT_MEDIUM,	/* 15 */
+	TPM_LIMIT_SHORT,
+	TPM_LIMIT_SHORT,
+	TPM_LIMIT_MEDIUM,
+	TPM_LIMIT_LONG,
+	TPM_LIMIT_SHORT,	/* 20 */
+	TPM_LIMIT_SHORT,
+	TPM_LIMIT_MEDIUM,
+	TPM_LIMIT_MEDIUM,
+	TPM_LIMIT_MEDIUM,
+	TPM_LIMIT_SHORT,	/* 25 */
+	TPM_LIMIT_SHORT,
+	TPM_LIMIT_MEDIUM,
+	TPM_LIMIT_SHORT,
+	TPM_LIMIT_SHORT,
+	TPM_LIMIT_MEDIUM,	/* 30 */
+	TPM_LIMIT_LONG,
+	TPM_LIMIT_MEDIUM,
+	TPM_LIMIT_SHORT,
+	TPM_LIMIT_SHORT,
+	TPM_LIMIT_SHORT,	/* 35 */
+	TPM_LIMIT_MEDIUM,
+	TPM_LIMIT_MEDIUM,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_MEDIUM,	/* 40 */
+	TPM_LIMIT_LONG,
+	TPM_LIMIT_MEDIUM,
+	TPM_LIMIT_SHORT,
+	TPM_LIMIT_SHORT,
+	TPM_LIMIT_SHORT,	/* 45 */
+	TPM_LIMIT_SHORT,
+	TPM_LIMIT_SHORT,
+	TPM_LIMIT_SHORT,
+	TPM_LIMIT_LONG,
+	TPM_LIMIT_MEDIUM,	/* 50 */
+	TPM_LIMIT_MEDIUM,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,	/* 55 */
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_MEDIUM,	/* 60 */
+	TPM_LIMIT_MEDIUM,
+	TPM_LIMIT_MEDIUM,
+	TPM_LIMIT_SHORT,
+	TPM_LIMIT_SHORT,
+	TPM_LIMIT_MEDIUM,	/* 65 */
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_SHORT,	/* 70 */
+	TPM_LIMIT_SHORT,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,	/* 75 */
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_LONG,		/* 80 */
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_MEDIUM,
+	TPM_LIMIT_LONG,
+	TPM_LIMIT_SHORT,
+	TPM_LIMIT_DEFAULT,	/* 85 */
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_SHORT,	/* 90 */
+	TPM_LIMIT_SHORT,
+	TPM_LIMIT_SHORT,
+	TPM_LIMIT_SHORT,
+	TPM_LIMIT_SHORT,
+	TPM_LIMIT_DEFAULT,	/* 95 */
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_MEDIUM,	/* 100 */
+	TPM_LIMIT_SHORT,
+	TPM_LIMIT_SHORT,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,	/* 105 */
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_SHORT,	/* 110 */
+	TPM_LIMIT_SHORT,
+	TPM_LIMIT_SHORT,
+	TPM_LIMIT_SHORT,
+	TPM_LIMIT_SHORT,
+	TPM_LIMIT_SHORT,	/* 115 */
+	TPM_LIMIT_SHORT,
+	TPM_LIMIT_SHORT,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_LONG,		/* 120 */
+	TPM_LIMIT_LONG,
+	TPM_LIMIT_MEDIUM,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_SHORT,
+	TPM_LIMIT_SHORT,	/* 125 */
+	TPM_LIMIT_SHORT,
+	TPM_LIMIT_LONG,
+	TPM_LIMIT_SHORT,
+	TPM_LIMIT_SHORT,
+	TPM_LIMIT_SHORT,	/* 130 */
+	TPM_LIMIT_MEDIUM,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_SHORT,
+	TPM_LIMIT_MEDIUM,
+	TPM_LIMIT_DEFAULT,	/* 135 */
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_SHORT,	/* 140 */
+	TPM_LIMIT_SHORT,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,	/* 145 */
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_SHORT,	/* 150 */
+	TPM_LIMIT_MEDIUM,
+	TPM_LIMIT_MEDIUM,
+	TPM_LIMIT_SHORT,
+	TPM_LIMIT_SHORT,
+	TPM_LIMIT_DEFAULT,	/* 155 */
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_SHORT,	/* 160 */
+	TPM_LIMIT_SHORT,
+	TPM_LIMIT_SHORT,
+	TPM_LIMIT_SHORT,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,	/* 165 */
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_LONG,		/* 170 */
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,	/* 175 */
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_MEDIUM,	/* 180 */
+	TPM_LIMIT_SHORT,
+	TPM_LIMIT_MEDIUM,
+	TPM_LIMIT_MEDIUM,
+	TPM_LIMIT_MEDIUM,
+	TPM_LIMIT_MEDIUM,	/* 185 */
+	TPM_LIMIT_SHORT,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,	/* 190 */
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,	/* 195 */
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_SHORT,	/* 200 */
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_SHORT,
+	TPM_LIMIT_SHORT,	/* 205 */
+	TPM_LIMIT_SHORT,
+	TPM_LIMIT_SHORT,
+	TPM_LIMIT_SHORT,
+	TPM_LIMIT_SHORT,
+	TPM_LIMIT_MEDIUM,	/* 210 */
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_MEDIUM,
+	TPM_LIMIT_MEDIUM,
+	TPM_LIMIT_MEDIUM,
+	TPM_LIMIT_DEFAULT,	/* 215 */
+	TPM_LIMIT_MEDIUM,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_SHORT,
+	TPM_LIMIT_SHORT,	/* 220 */
+	TPM_LIMIT_SHORT,
+	TPM_LIMIT_SHORT,
+	TPM_LIMIT_SHORT,
+	TPM_LIMIT_SHORT,
+	TPM_LIMIT_DEFAULT,	/* 225 */
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_SHORT,	/* 230 */
+	TPM_LIMIT_LONG,
+	TPM_LIMIT_MEDIUM,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,	/* 235 */
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_SHORT,	/* 240 */
+	TPM_LIMIT_DEFAULT,
+	TPM_LIMIT_MEDIUM,
 };
 
 /**
- * tpm1_calc_ordinal_duration() - calculate the maximum command duration
- * @chip:    TPM chip to use.
+ * tpm1_duration_limit() - the execution class of a TPM 1.x command
  * @ordinal: TPM command ordinal.
  *
- * The function returns the maximum amount of time the chip could take
- * to return the result for a particular ordinal in jiffies.
- *
- * Return: A maximal duration time for an ordinal in jiffies.
+ * Return: The limit that bounds the execution of @ordinal.
  */
-unsigned long tpm1_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal)
+enum tpm_limit tpm1_duration_limit(u32 ordinal)
 {
-	int duration_idx = TPM_UNDEFINED;
-	int duration = 0;
-
 	/*
-	 * We only have a duration table for protected commands, where the upper
-	 * 16 bits are 0. For the few other ordinals the fallback will be used.
+	 * The table covers protected commands, where the upper 16 bits are 0.
+	 * The few other ordinals use the DEFAULT limit.
 	 */
-	if (ordinal < TPM_MAX_ORDINAL)
-		duration_idx = tpm1_ordinal_duration[ordinal];
-
-	if (duration_idx != TPM_UNDEFINED)
-		duration = chip->duration[duration_idx];
-	if (duration <= 0)
-		return 2 * 60 * HZ;
-	else
-		return duration;
+	if (ordinal >= TPM_MAX_ORDINAL)
+		return TPM_LIMIT_DEFAULT;
+
+	return tpm1_ordinal_duration[ordinal];
 }
 
 /**
@@ -612,7 +600,7 @@ int tpm1_do_selftest(struct tpm_chip *chip)
 	unsigned long duration;
 	u8 dummy[TPM_DIGEST_SIZE];
 
-	duration = tpm1_calc_ordinal_duration(chip, TPM_ORD_CONTINUE_SELFTEST);
+	duration = tpm_calc_ordinal_duration(chip, TPM_ORD_CONTINUE_SELFTEST);
 
 	loops = jiffies_to_msecs(duration) / delay_msec;
 
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index f943f1c05721..629caaeffa17 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -48,47 +48,45 @@ int tpm2_get_timeouts(struct tpm_chip *chip)
 	return 0;
 }
 
-/*
- * Contains the maximum durations in milliseconds for TPM2 commands.
- */
+/* The execution class of each TPM2 command with a known limit. */
 static const struct {
-	unsigned long ordinal;
-	unsigned long duration;
-} tpm2_ordinal_duration_map[] = {
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
+	u32 ordinal;
+	u8 limit;
+} tpm2_duration_limits[] = {
+	{TPM2_CC_STARTUP, TPM_LIMIT_SHORT},
+	{TPM2_CC_SELF_TEST, TPM_LIMIT_LONG},
+	{TPM2_CC_GET_RANDOM, TPM_LIMIT_MEDIUM},
+	{TPM2_CC_SEQUENCE_UPDATE, TPM_LIMIT_SHORT},
+	{TPM2_CC_SEQUENCE_COMPLETE, TPM_LIMIT_SHORT},
+	{TPM2_CC_EVENT_SEQUENCE_COMPLETE, TPM_LIMIT_SHORT},
+	{TPM2_CC_HASH_SEQUENCE_START, TPM_LIMIT_SHORT},
+	/* LONG, 3 s, is too short for signature verification. */
+	{TPM2_CC_VERIFY_SIGNATURE, TPM_LIMIT_DEFAULT},
+	{TPM2_CC_PCR_EXTEND, TPM_LIMIT_SHORT},
+	{TPM2_CC_HIERARCHY_CONTROL, TPM_LIMIT_MEDIUM},
+	{TPM2_CC_HIERARCHY_CHANGE_AUTH, TPM_LIMIT_MEDIUM},
+	{TPM2_CC_GET_CAPABILITY, TPM_LIMIT_SHORT},
+	{TPM2_CC_NV_READ, TPM_LIMIT_MEDIUM},
+	{TPM2_CC_CREATE_PRIMARY, TPM_LIMIT_LONG_LONG},
+	{TPM2_CC_CREATE, TPM_LIMIT_LONG_LONG},
+	{TPM2_CC_CREATE_LOADED, TPM_LIMIT_LONG_LONG},
 };
 
 /**
- * tpm2_calc_ordinal_duration() - Calculate the maximum command duration
+ * tpm2_duration_limit() - the execution class of a TPM2 command
  * @ordinal: TPM command ordinal.
  *
- * Returns the maximum amount of time the chip is expected by kernel to
- * take in jiffies.
+ * Return: The limit that bounds the execution of @ordinal.
  */
-unsigned long tpm2_calc_ordinal_duration(u32 ordinal)
+enum tpm_limit tpm2_duration_limit(u32 ordinal)
 {
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(tpm2_ordinal_duration_map); i++)
-		if (ordinal == tpm2_ordinal_duration_map[i].ordinal)
-			return msecs_to_jiffies(tpm2_ordinal_duration_map[i].duration);
+	for (i = 0; i < ARRAY_SIZE(tpm2_duration_limits); i++)
+		if (ordinal == tpm2_duration_limits[i].ordinal)
+			return tpm2_duration_limits[i].limit;
 
-	return msecs_to_jiffies(TPM2_DURATION_DEFAULT);
+	return TPM_LIMIT_DEFAULT;
 }
 
 /**
-- 
2.47.3


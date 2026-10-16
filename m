Received: from pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.13.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB3B2FC00D;
	Fri, 16 Oct 2026 04:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.13.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792125480; cv=none; b=CnrRxvef0eZxDqm5VwY1PgQ11uOLhnOYWbpuzrgsCOJbtAPFwleKquQlSWau0wkqZjFSlglUVCkr1P/31un2b0UeC6Hl/dHrKsuZq0Xdg9bYujoIu2onMclwmwioQUSOV9OXm5Lgrp8twmlkqi0b16i4xVTRpKhkbA+DdxqFViU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792125480; c=relaxed/simple;
	bh=RNjRL0EltQc7enwcFPVj/kltKz6tH5kv9sDzzt79uWA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G8uBk4aPkfZj6qphiLHhnbevX6hZO8JU9rwFWYMKNy1UIGh0szd9C4YHgEOgOM6QCOPi6jq7awei6s2XsULWT0thy2JXv9NjfrrEYeN5Aitravbj2PVkVbpJNayrpy10ce0FEYpvpp5tDYYA4XaZV6YFRArCS1EyvoYGo5S/m2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=faE1rqjB; arc=none smtp.client-ip=52.13.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="faE1rqjB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1792125479; x=1823661479;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S8QDK/kZ0uul9N1yPR8wrvRf7wrrRAXPj7Rb0VckG/Q=;
  b=faE1rqjBDv0HwFvUk/bNcf0jnC/B2rNvjEtJb1W3cWJbcjEXj8mSS5k/
   WXpwPy848Vchwtfp65TLDeIY8UMgyb43Y9pjeOywRRdj+JLjxabUuyHwt
   2Y+vCZVfi4NpLPlvIccXInYoJm9/vNnJVYq3GDhFfY9GBjD8/xzYLotwY
   ljHylvgplE0LE9gN65cnHnlgoElxynD0dBzpvLwJ0xulMDI52H3yRDTFV
   NUVs3miJtlqBre5t2VnxDzhva9UMOSIUgdBHCPCKMdTqt0yctgBIrHFfd
   F7QP1/4tB48Wod0TJjix0pwbskSRMRieowOXDwUaAOFkuPdczGiNVhiVn
   Q==;
X-CSE-ConnectionGUID: Gyo090YCQMKkAQHuaZ9mRQ==
X-CSE-MsgGUID: t135JWQOQyWVBMnxlx+afA==
X-IronPort-AV: E=Sophos;i="6.27,161,1787011200"; 
   d="scan'208";a="31383993"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 04:37:57 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:22207]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.5:2525] with esmtp (Farcaster)
 id a8b19963-32b9-43b7-a9a2-fe9dc9471d92; Fri, 16 Oct 2026 04:37:57 +0000 (UTC)
X-Farcaster-Flow-ID: a8b19963-32b9-43b7-a9a2-fe9dc9471d92
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Fri, 16 Oct 2026 04:37:56 +0000
Received: from dev-dsk-surenkj-2b-416930d2.us-west-2.amazon.com (10.169.26.94)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53;
 Fri, 16 Oct 2026 04:37:56 +0000
From: Surendran Kanagaraj <surenkj@amazon.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>
CC: <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Breno
 Leitao" <leitao@debian.org>, <nh-open-source@amazon.com>, Alexander Graf
	<graf@amazon.de>, Gunnar Kudrjavets <gunnarku@amazon.com>, Josh Levinson
	<joshlev@amazon.com>
Subject: [PATCH v2 2/2] tpm_crb: Raise durations for Amazon NitroTPM
Date: Fri, 16 Oct 2026 04:37:33 +0000
Message-ID: <20261016043733.30589-3-surenkj@amazon.com>
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

TPM commands need to complete within the command duration defined in
the TPM2 spec or keep answering TPM2_RC_RETRY for at most
TPM2_DURATION_LONG (2s).

In rare scenarios NitroTPM can enter a mode where it either sends
TPM2_RC_RETRY for more than 2s or delays command completion. When
this happens during auth session start, the driver disables the chip
and every subsequent request fails:

    tpm tpm0: in retry loop
    tpm tpm0: tpm2_load_context: failed with a TPM error 0x0922

Add support for vendor duration overrides to the CRB driver, based on
the vendor ID read from the interface ID register. For NitroTPM, raise
TPM_SHORT, TPM_MEDIUM and TPM_LONG to 30s which covers the longest
unavailability time along with some headroom.

Tested on an EC2 instance with NitroTPM by inducing multiple
unavailability windows with no TPM errors, and in QEMU with swtpm by
holding the TPM in TPM2_RC_RETRY and stalling command completion for
longer than 2s.

Assisted-by: LLM
Signed-off-by: Surendran Kanagaraj <surenkj@amazon.com>
---
V1 -> V2:
- Raise the durations through ->update_durations() instead of setting
  chip->busy_timeout_ms.
- Raise TPM_SHORT, TPM_MEDIUM and TPM_LONG to 30s.
- Replace the vendor quirk table with a plain vendor ID check.
- Use the TPM_CRB_ prefix for the new macros.
- Rename from "tpm_crb: Raise timeouts for Amazon NitroTPM".

v1: https://lore.kernel.org/linux-integrity/20260923142834.16786-3-surenkj@amazon.com/
---
 drivers/char/tpm/tpm_crb.c | 44 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index ceb4100ba400..6ba9016d6463 100644
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -13,6 +13,7 @@
 
 #include <linux/acpi.h>
 #include <linux/highmem.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/rculist.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
@@ -26,6 +27,15 @@
 #define ACPI_SIG_TPM2 "TPM2"
 #define TPM_CRB_MAX_RESOURCES 3
 
+/* TPM_CRB_INTF_ID_x vendor ID field, bits 47:32 of the 64-bit register */
+#define TPM_CRB_INTF_ID_VID(intf_id)	(((intf_id) >> 32) & 0xffff)
+
+/* Amazon NitroTPM */
+#define TPM_CRB_INTF_VID_AMZN		0x0ec2
+
+/* Longest NitroTPM unavailability, with some headroom */
+#define TPM_CRB_AMZN_DURATION_MS	30000
+
 static const guid_t crb_acpi_start_guid =
 	GUID_INIT(0x6BBF6CAB, 0x5463, 0x4714,
 		  0xB7, 0xCD, 0xF0, 0x20, 0x3C, 0x03, 0x68, 0xD4);
@@ -521,6 +531,39 @@ static bool crb_req_canceled(struct tpm_chip *chip, u8 status)
 	return (cancel & CRB_CANCEL_INVOKE) == CRB_CANCEL_INVOKE;
 }
 
+/*
+ * Read the vendor ID from the interface ID register. Returns -ENODEV when
+ * the head registers are not mapped for this start method.
+ */
+static int crb_vendor_id(struct crb_priv *priv)
+{
+	u64 intf_id;
+
+	if (!priv->regs_h)
+		return -ENODEV;
+
+	intf_id = lo_hi_readq(&priv->regs_h->intf_id);
+
+	return TPM_CRB_INTF_ID_VID(intf_id);
+}
+
+static void crb_update_durations(struct tpm_chip *chip,
+				 unsigned long *duration_cap)
+{
+	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
+	unsigned long duration;
+
+	chip->duration_adjusted = false;
+
+	if (crb_vendor_id(priv) == TPM_CRB_INTF_VID_AMZN) {
+		duration = msecs_to_jiffies(TPM_CRB_AMZN_DURATION_MS);
+		duration_cap[TPM_SHORT] = duration;
+		duration_cap[TPM_MEDIUM] = duration;
+		duration_cap[TPM_LONG] = duration;
+		chip->duration_adjusted = true;
+	}
+}
+
 static const struct tpm_class_ops tpm_crb = {
 	.flags = TPM_OPS_AUTO_STARTUP,
 	.status = crb_status,
@@ -532,6 +575,7 @@ static const struct tpm_class_ops tpm_crb = {
 	.cmd_ready = crb_cmd_ready,
 	.request_locality = crb_request_locality,
 	.relinquish_locality = crb_relinquish_locality,
+	.update_durations = crb_update_durations,
 	.req_complete_mask = CRB_DRV_STS_COMPLETE,
 	.req_complete_val = CRB_DRV_STS_COMPLETE,
 };
-- 
2.47.3


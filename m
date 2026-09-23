Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.245.243.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8643A9636;
	Wed, 23 Sep 2026 14:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.245.243.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790173729; cv=none; b=AZvRQsiNE1dBv4vBcVgFpB0GFTXzqDM6IbN6g1Kgs+Q5r+oSM7EED8BAW9fdj3e42PxnDE8ltOIe38kvMGlrc9sxentWsZ519sw2+nfaHPJuG9HfU4NwExdAZOrfBk6xfYn9dzBiEBfQ1Zc9fda9+NGR1Cixv+/H4jFvK1jfxww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790173729; c=relaxed/simple;
	bh=rbox5PiX4IRjzrRyDEAzQ8FCibdyFXPow4fhXrs0Acg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a8aaYCWlzSMyeec6EWar6moEmzO1Oj+c6LvT3WZrfOvuZYoySSSD7dVuUM89xzKvfCIYSMj9fFt1zPQps+kYBgYlHp1j8dSUX65gIzHUp6sgH3xBnOLCHBDrmW567VINM7ttyhycjSr7usJtiuYfox1XqhwFK1AznvjQyh3UVrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Om3/IJCN; arc=none smtp.client-ip=44.245.243.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="Om3/IJCN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1790173728; x=1821709728;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ngPqdiOd/HTapC2oXTHu96HVXyI5Gv/DHYh7ueCEPUg=;
  b=Om3/IJCNCpJFEEhsVABEW3Rg/tLFoQZ+yONI3xoig8ne19Pz0xZmcHNH
   IIWVU04W0u7mLrRxsrfkpx0KiMkHAIMU0UlmH9Aumwv5Z0L1bREz1zIav
   3q/BJNANYoKPrVJEl4U8AVRlFH2MjJZiWwep5lHo+MNvXY31i6/Hl29AJ
   eBvBejdQCiKfWe9F3NAMRAkjihdxm7C1Cq6j1lt7mGvde0YyM0Eq5dzhz
   OjHoUKjBfWxLQYdd0OO+d6ElGY+bpJJC1y69RD14vQksWlM1Nca4t8sn1
   WyEL5FeH+Ob7DKgyb7pG9BevC6fzOvyjrjl8M4VyCCptFIYZUYCWu3GOH
   A==;
X-CSE-ConnectionGUID: o06THioiST6r6ZvPabAHog==
X-CSE-MsgGUID: QKLTSGAySNud9r/ndOharg==
X-IronPort-AV: E=Sophos;i="6.27,118,1787011200"; 
   d="scan'208";a="28948323"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 14:28:44 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:28313]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.15.186:2525] with esmtp (Farcaster)
 id 008b42e8-e499-4538-839b-fff08e80c615; Wed, 23 Sep 2026 14:28:44 +0000 (UTC)
X-Farcaster-Flow-ID: 008b42e8-e499-4538-839b-fff08e80c615
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Wed, 23 Sep 2026 14:28:44 +0000
Received: from dev-dsk-surenkj-2b-416930d2.us-west-2.amazon.com (10.169.26.94)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Wed, 23 Sep 2026 14:28:44 +0000
From: Surendran Kanagaraj <surenkj@amazon.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>
CC: <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nh-open-source@amazon.com>, Alexander Graf <graf@amazon.de>, "Gunnar
 Kudrjavets" <gunnarku@amazon.com>, Josh Levinson <joshlev@amazon.com>
Subject: [PATCH 2/2] tpm_crb: Raise timeouts for Amazon NitroTPM
Date: Wed, 23 Sep 2026 14:28:34 +0000
Message-ID: <20260923142834.16786-3-surenkj@amazon.com>
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

TPM commands need to complete within the command duration defined in
the TPM2 spec or keep answering TPM2_RC_RETRY for at most
TPM2_DURATION_LONG (2s).

In rare scenarios NitroTPM can enter a mode where it either sends
TPM2_RC_RETRY for more than 2s or delays command completion. When
this happens during auth session start, the driver disables the chip
and every subsequent request fails:

    tpm tpm0: in retry loop
    tpm tpm0: tpm2_load_context: failed with a TPM error 0x0922

Add support for vendor quirks to the CRB driver. The table is keyed by
the vendor ID read from the interface ID register. For NitroTPM, set
busy_timeout_ms to 30s, which covers the longest unavailability time
along with some headroom.

Tested on an EC2 instance with NitroTPM by inducing multiple
unavailability windows with no TPM errors, and in QEMU with swtpm by
holding the TPM in TPM2_RC_RETRY and stalling command completion for
longer than 2s with the quirk applied.

Assisted-by: LLM
Signed-off-by: Surendran Kanagaraj <surenkj@amazon.com>
---
 drivers/char/tpm/tpm_crb.c | 54 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index ceb4100ba400..4107203beec9 100644
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
+#define CRB_INTF_ID_VID(intf_id)	(((intf_id) >> 32) & 0xffff)
+
+/* Amazon NitroTPM */
+#define CRB_INTF_VID_AMZN		0x0ec2
+
+/* Longest unavailability seen from NitroTPM */
+#define CRB_AMZN_BUSY_TIMEOUT_MS	30000
+
 static const guid_t crb_acpi_start_guid =
 	GUID_INIT(0x6BBF6CAB, 0x5463, 0x4714,
 		  0xB7, 0xCD, 0xF0, 0x20, 0x3C, 0x03, 0x68, 0xD4);
@@ -783,6 +793,48 @@ static int crb_map_pluton(struct device *dev, struct crb_priv *priv,
 	return 0;
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
+	return CRB_INTF_ID_VID(intf_id);
+}
+
+static void crb_amzn_quirk(struct tpm_chip *chip)
+{
+	/* NitroTPM requires larger timeouts */
+	chip->busy_timeout_ms = CRB_AMZN_BUSY_TIMEOUT_MS;
+}
+
+static const struct crb_vendor_quirk {
+	u16 vendor_id;
+	void (*apply)(struct tpm_chip *chip);
+} crb_vendor_quirks[] = {
+	{ CRB_INTF_VID_AMZN, crb_amzn_quirk },
+};
+
+static void crb_apply_vendor_quirks(struct crb_priv *priv, struct tpm_chip *chip)
+{
+	int vendor_id = crb_vendor_id(priv);
+	unsigned int i;
+
+	if (vendor_id < 0)
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(crb_vendor_quirks); i++)
+		if (crb_vendor_quirks[i].vendor_id == vendor_id)
+			crb_vendor_quirks[i].apply(chip);
+}
+
 static int crb_acpi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -887,6 +939,8 @@ static int crb_acpi_probe(struct platform_device *pdev)
 	chip->acpi_dev_handle = device->handle;
 	chip->flags = TPM_CHIP_FLAG_TPM2;
 
+	crb_apply_vendor_quirks(priv, chip);
+
 	rc = tpm_chip_bootstrap(chip);
 	if (rc)
 		goto out;
-- 
2.47.3


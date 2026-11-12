Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.245.243.92
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794501996;
	b=mllLM3jtvxP53NVHFJgB3DaL6+xr4nriRjba+hLjWzvYBspAWbF4IH5h2NUGwxjiYv9F
	 jvAN3//kTanhrgkjRPLEs496qCDVJ+1a0EEsHypH+f55jTPgcOOz45f4MKteBjUm2zx4f
	 7ZRGxBZxU2gUdDGETGzaR5icHMKgbx2JnFEuyaUQIWYNb3z6LWuaQr9OdepZ2ICCkUxSP
	 ZVdLxUTtKfa3+W+0KFXx5uysBSJphM24JjiF7N41LnKQCMsyVZqX47PrMPYiFYlh511WK
	 EP/YKL2gcsswu9yaG6p6jsszzs1XOr3UMQ6ZmcDOxKfMDz+kVwt6Glo2O/K6Gg6H7kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794501996;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=xNz64j0McT9dIRYa5D9GRgq1blnxgnKU+6IqC8Q3v5U=;
	b=DLTHCN909Fi1Vu8Wz9nzt56V7TmOQIGwvxLgW29RlB3Z5w/fb0zYGahmiGDjuU5FE0mC
	 78LsFq9+iujOO6SRR4KD5FGJYtSa6dmOtI2nAAxN720stme4Sups1h3CnKGYSphBuUwEq
	 qS193BUX8B7qAoU42c/X1pdQd/8IrhjnH99PMU8cqp/jjDaCvx1HWDPyxuv15dma1q5lp
	 3F23vyLZvwEvXoYTXIkEtIlkjMtgDRNJ6BrZAoDWMG28j/w07IggyGvu+7e7tQLJmuQ2c
	 t+PKzXixIFijAIkkoueNndqUtEZbVlz61jYee+60KgJdBNsFu5frf7bbQmLvqexoaGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=VRGsWl26;
	arc=none smtp.remote-ip=44.245.243.92
Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.245.243.92])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F528606A8A3;
	Thu, 12 Nov 2026 16:46:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F528606A8A3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=VRGsWl26
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794501996; x=1826037996;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xNz64j0McT9dIRYa5D9GRgq1blnxgnKU+6IqC8Q3v5U=;
  b=VRGsWl26zKFYIrK9qB9P9cO92sRjJ9swVfa0mvRfWsYqYYsptSFrkMtz
   acj2ZTKT6cNkTcbDO84C69ESgnZbbG4d8dv0Eu+2XbAmkgukesNYQJVQT
   HH3v+iaABhLYef3nLlRhlCexRHTfj3Dc/EJZGuYu1/9+PltXHtZ0/e7Lr
   N6WPr4ZnUtqWJ4XfU3jfJ+dTXKFrmSi2DDAU+b9X006PftnFzJ2Im5zFr
   HQl6sijtwT7DE/Pg2Mb7XU3lAfxj7nAbXgAA65RbNAnrOkX95fgBSg5zY
   cQAvOIY/7gPtv2A6z5Osa6c7ESVIioTuBGhv58ZztofXxEGeUQUxEc4jq
   A==;
X-CSE-ConnectionGUID: M3uxj+oWTaGVnVFTezF7+w==
X-CSE-MsgGUID: T6xCuqlBQraj/j04FJr78w==
X-IronPort-AV: E=Sophos;i="6.27,210,1787011200"; 
   d="scan'208";a="33343779"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 16:46:36 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:5075]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.16.231:2525] with esmtp (Farcaster)
 id ee27b830-e949-4985-8d33-62faba8a9563; Thu, 12 Nov 2026 16:46:35 +0000 (UTC)
X-Farcaster-Flow-ID: ee27b830-e949-4985-8d33-62faba8a9563
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Thu, 12 Nov 2026 16:46:35 +0000
Received: from dev-dsk-surenkj-2b-416930d2.us-west-2.amazon.com (10.169.26.94)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Thu, 12 Nov 2026 16:46:35 +0000
From: Surendran Kanagaraj <surenkj@amazon.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, Peter Huewe <peterhuewe@gmx.de>
CC: Jason Gunthorpe <jgg@ziepe.ca>, <linux-integrity@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, Jonathan McDowell <noodles@earth.li>, "Breno
 Leitao" <leitao@debian.org>, <nh-open-source@amazon.com>, Alexander Graf
	<graf@amazon.de>, Gunnar Kudrjavets <gunnarku@amazon.com>, Josh Levinson
	<joshlev@amazon.com>
Subject: [RFC PATCH v3 8/8] tpm_crb: Raise the limits for Amazon NitroTPM
Date: Thu, 12 Nov 2026 16:46:21 +0000
Message-ID: <20261112164621.62645-1-surenkj@amazon.com>
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
X-ClientProxiedBy: EX19D031UWC003.ant.amazon.com (10.13.139.252) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

In rare scenarios NitroTPM can enter a mode where it either sends
TPM2_RC_RETRY for longer than LONG duration or delays
command completion for longer than the TPM 2.0 durations allow.
When this happens during auth session start, the driver disables
the chip and every subsequent request fails:

    tpm tpm0: in retry loop
    tpm tpm0: tpm2_load_context: failed with a TPM error 0x0922

Add a quirk table to the CRB driver keyed by the vendor ID from the
interface ID register, and apply it from ->adjust_limits(). For
NitroTPM, raise the SHORT and MEDIUM durations to 30 s, which covers
the longest unavailability with some headroom, and LONG to 45 s. With
the back-off doubling from 20 ms, a 45 s LONG duration lets the driver
resubmit a command for about 40.9 s, so the retry loop covers the
entire unavailability window.

These are upper bounds, not expected waits. A command that completes
sooner ends the wait as soon as the poll sees it. Add TPM_VID_AMZN
next to the vendor ID list in tpm.h.

Tested on an EC2 instance with NitroTPM by inducing multiple
unavailability windows with no TPM errors, and in QEMU with swtpm by
holding the TPM in TPM2_RC_RETRY and stalling command completion for
longer than 2s.

Signed-off-by: Surendran Kanagaraj <surenkj@amazon.com>
---
 drivers/char/tpm/tpm_crb.c | 50 ++++++++++++++++++++++++++++++++++++++
 include/linux/tpm.h        |  1 +
 2 files changed, 51 insertions(+)

diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index 7c1011eb855a..0e18f61cfddf 100644
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -13,6 +13,7 @@
 
 #include <linux/acpi.h>
 #include <linux/highmem.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/rculist.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
@@ -26,6 +27,14 @@
 #define ACPI_SIG_TPM2 "TPM2"
 #define TPM_CRB_MAX_RESOURCES 3
 
+/* TPM_CRB_INTF_ID_x vendor ID field, bits 47:32 of the 64-bit register */
+#define TPM_CRB_INTF_ID_VID(intf_id)	(((intf_id) >> 32) & 0xffff)
+
+/* Longest NitroTPM unavailability, with some headroom */
+#define TPM_CRB_AMZN_LIMIT_US		(30 * USEC_PER_SEC)
+/* LONG also bounds the retry loop: 45 s lets it resubmit for 40.9 s */
+#define TPM_CRB_AMZN_LONG_US		(45 * USEC_PER_SEC)
+
 static const guid_t crb_acpi_start_guid =
 	GUID_INIT(0x6BBF6CAB, 0x5463, 0x4714,
 		  0xB7, 0xCD, 0xF0, 0x20, 0x3C, 0x03, 0x68, 0xD4);
@@ -663,6 +672,46 @@ static bool crb_req_canceled(struct tpm_chip *chip, u8 status)
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
+/* Limits keyed by the vendor ID of the interface ID register */
+static const struct tpm_limits_quirk crb_limits_quirks[] = {
+	{
+		.id = TPM_VID_AMZN,
+		.time_us = {
+			[TPM_LIMIT_SHORT]	= TPM_CRB_AMZN_LIMIT_US,
+			[TPM_LIMIT_MEDIUM]	= TPM_CRB_AMZN_LIMIT_US,
+			[TPM_LIMIT_LONG]	= TPM_CRB_AMZN_LONG_US,
+		},
+	},
+};
+
+static void crb_adjust_limits(struct tpm_chip *chip, struct tpm_limits *p)
+{
+	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
+	int vid = crb_vendor_id(priv);
+
+	if (vid < 0)
+		return;
+
+	tpm_limits_apply_quirks(p, crb_limits_quirks,
+				ARRAY_SIZE(crb_limits_quirks), vid);
+}
+
 static const struct tpm_class_ops tpm_crb = {
 	.flags = TPM_OPS_AUTO_STARTUP,
 	.status = crb_status,
@@ -674,6 +723,7 @@ static const struct tpm_class_ops tpm_crb = {
 	.cmd_ready = crb_cmd_ready,
 	.request_locality = crb_request_locality,
 	.relinquish_locality = crb_relinquish_locality,
+	.adjust_limits = crb_adjust_limits,
 	.req_complete_mask = CRB_DRV_STS_COMPLETE,
 	.req_complete_val = CRB_DRV_STS_COMPLETE,
 };
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index a4b7282d88b5..f557c1a32388 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -220,6 +220,7 @@ static inline enum tpm2_mso_type tpm2_handle_mso(u32 handle)
 #define TPM_VID_STM      0x104A
 #define TPM_VID_ATML     0x1114
 #define TPM_VID_IFX      0x15D1
+#define TPM_VID_AMZN     0x0EC2
 
 enum tpm_chip_flags {
 	TPM_CHIP_FLAG_BOOTSTRAPPED		= BIT(0),
-- 
2.47.3


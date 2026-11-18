Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.34.181.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794988190;
	b=Fe5jtm3FpamOwm7tyycaPKzndpBdtyKwTbKAtbdKSc2NervQDg6WalPjL0bRNCpqaSOL
	 VRKrV0aViMJfPKEkya/tJwCOTYx4EN5Ce9u28iCYiK1VyNH8m44/FXu1+PcBCvbpYJk3k
	 enSAz3jDsw8R8/ZXg2cfVufUQfvsH1Oh8eaNSp8kQhARE80AwebLvU6h4BATJyQeiUdMA
	 Ds6eVUoQ0K4DiJCDNcZiHw8Dza2E1Cr61br0itk8u6eG5vGNSbb0fy5XLHZSVPBQgKdIk
	 QJvWux//YyxtgTV+GfHq9b+DHUZFHTnUBbSsKGNzJ/hK3t83Bc6vQUtNSaRyxqx6lSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794988190;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=bkoESdRYxl9U+aKFr3D57OW3pCZJhVLHVeNl5Ly2gb8=;
	b=wOxicTqetN+Nfeo99X2Lolf0ZBXXBLN/0YfwM09QM2a/qiUfsQYe5Kl0/zhmxRUj4Bvb
	 kMeOaoDUa9Zlis3Fk1K3tsjDgqhJW0DolLKSTf22KMFoM7o6KkpxnbhzQgm00TUQrqpMV
	 E6tZOnngDvdJty5XjkjTylgzLpsZEiFh8WIMCduvAXjgHlSj6uSSp1BXvpxUY3+sWfrTi
	 ld74CLv1yud/vWvkjBmvJHgQeU5cHQH6w3hIjNWcFdCGkHwwNW0ytN0Hl73+OvY3itorz
	 +omgtZ97pY9lM0vAet3K5UMpl3L7cJz7k2Gp9XecBX2FpsJJbwMwuh5ml1UzYwUY4Rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=lRNfWbq3;
	arc=none smtp.remote-ip=52.34.181.151
Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25735606A31C;
	Wed, 18 Nov 2026 07:49:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25735606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=lRNfWbq3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794988190; x=1826524190;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bkoESdRYxl9U+aKFr3D57OW3pCZJhVLHVeNl5Ly2gb8=;
  b=lRNfWbq3moSDygnO3bZWqBDCEVp1KHKVWPvRF4mTZYWWy0/4nA9oEdkD
   xi/icK05zN5sJd7XsZZXKRXO0Yr4lqvuG7d1i3Jpda07b8K/9vjayNAWH
   SVDfd2Gw52KWAJsQfQHW4tywpx8RgY+8qnDpZgKloi7fRhFioxRQWLyyk
   /gmgC5Azq+Gwe4Luih20VoRY86W6K2nPs2MauaWffANLyRhimGcRXvbkG
   vMOP2XFoX61f6qsJWqv1wgws2HfsS9OLBYnZEqjFaPidInM1btBTq32dH
   D9LdtSuEeEMAQ4u48q2RrMvCSQBAvFquvKtUhYvLfqgdDA0TgcEDuhaMd
   w==;
X-CSE-ConnectionGUID: cKI70s/ZQSqAIYmy5NAEQQ==
X-CSE-MsgGUID: 7jL979ZdTGq4XphSGNKZBw==
X-IronPort-AV: E=Sophos;i="6.27,219,1787011200"; 
   d="scan'208";a="34415360"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 07:49:38 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:15939]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.50.212:2525] with esmtp (Farcaster)
 id 56a30b5d-85c7-415b-ac6e-094fc94bf93c; Wed, 18 Nov 2026 07:49:37 +0000 (UTC)
X-Farcaster-Flow-ID: 56a30b5d-85c7-415b-ac6e-094fc94bf93c
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 18 Nov 2026 07:49:37 +0000
Received: from dev-dsk-surenkj-2b-416930d2.us-west-2.amazon.com (10.169.26.94)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 18 Nov 2026 07:49:37 +0000
From: Surendran Kanagaraj <surenkj@amazon.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, Peter Huewe <peterhuewe@gmx.de>
CC: Jason Gunthorpe <jgg@ziepe.ca>, <linux-integrity@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
	<linux-doc@vger.kernel.org>, Jonathan McDowell <noodles@earth.li>, "Breno
 Leitao" <leitao@debian.org>, <nh-open-source@amazon.com>, Alexander Graf
	<graf@amazon.de>, Gunnar Kudrjavets <gunnarku@amazon.com>, Josh Levinson
	<joshlev@amazon.com>
Subject: [RFC PATCH v4 8/8] tpm_crb: Raise the limits for Amazon NitroTPM
Date: Wed, 18 Nov 2026 07:49:04 +0000
Message-ID: <20261118074904.60624-4-surenkj@amazon.com>
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
X-ClientProxiedBy: EX19D031UWC002.ant.amazon.com (10.13.139.212) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

In rare scenarios NitroTPM can enter a mode where it either sends
TPM2_RC_RETRY for longer than LONG duration or delays
command completion for longer than the TPM 2.0 durations allow.
When this happens during auth session start, the driver disables
the chip and every subsequent request fails:

    tpm tpm0: in retry loop
    tpm tpm0: tpm2_load_context: failed with a TPM error 0x0922

Add an ->adjust_limits() hook to the CRB driver that reads the vendor
ID from the interface ID register. For NitroTPM, raise the SHORT and
MEDIUM durations to 30 s, which covers the longest unavailability with
some headroom, and LONG to 45 s. With the back-off doubling from 20 ms,
a 45 s LONG duration lets the driver resubmit a command for about
40.9 s, so the retry loop covers the entire unavailability window.

These are upper bounds, not expected waits. A command that completes
sooner ends the wait as soon as the poll sees it. Add TPM_VID_AMZN
next to the vendor ID list in tpm.h.

Tested on an EC2 instance with NitroTPM by inducing multiple
unavailability windows with no TPM errors, and in QEMU with swtpm by
holding the TPM in TPM2_RC_RETRY and stalling command completion for
longer than 2s.

Signed-off-by: Surendran Kanagaraj <surenkj@amazon.com>
---
 drivers/char/tpm/tpm_crb.c | 37 +++++++++++++++++++++++++++++++++++++
 include/linux/tpm.h        |  1 +
 2 files changed, 38 insertions(+)

diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index 5f29eabf2413..81e6593911dc 100644
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
@@ -662,6 +671,33 @@ static bool crb_req_canceled(struct tpm_chip *chip, u8 status)
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
+static void crb_adjust_limits(struct tpm_chip *chip, struct tpm_limits *p)
+{
+	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
+
+	if (crb_vendor_id(priv) == TPM_VID_AMZN) {
+		tpm_limits_driver_set(p, TPM_LIMIT_SHORT, TPM_CRB_AMZN_LIMIT_US);
+		tpm_limits_driver_set(p, TPM_LIMIT_MEDIUM, TPM_CRB_AMZN_LIMIT_US);
+		tpm_limits_driver_set(p, TPM_LIMIT_LONG, TPM_CRB_AMZN_LONG_US);
+	}
+}
+
 static const struct tpm_class_ops tpm_crb = {
 	.flags = TPM_OPS_AUTO_STARTUP,
 	.status = crb_status,
@@ -673,6 +709,7 @@ static const struct tpm_class_ops tpm_crb = {
 	.cmd_ready = crb_cmd_ready,
 	.request_locality = crb_request_locality,
 	.relinquish_locality = crb_relinquish_locality,
+	.adjust_limits = crb_adjust_limits,
 	.req_complete_mask = CRB_DRV_STS_COMPLETE,
 	.req_complete_val = CRB_DRV_STS_COMPLETE,
 };
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index b88c7b133bdd..6d90861a1047 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -214,6 +214,7 @@ static inline enum tpm2_mso_type tpm2_handle_mso(u32 handle)
 #define TPM_VID_STM      0x104A
 #define TPM_VID_ATML     0x1114
 #define TPM_VID_IFX      0x15D1
+#define TPM_VID_AMZN     0x0EC2
 
 enum tpm_chip_flags {
 	TPM_CHIP_FLAG_BOOTSTRAPPED		= BIT(0),
-- 
2.47.3


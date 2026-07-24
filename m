Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1576E446C17
	for <linux-integrity@vger.kernel.org>; Fri, 24 Jul 2026 16:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784911647; cv=none; b=ieXOFDAdT4FcgAotkZgsvQJDBZBDpAHpnVkrV1HDoMOvnay2X/DVjMhZ40AqFdpZSgiQMwaqiEEbd2MDfV/1sFvA5BOfrS7xRpj92x7ULUooveMBsLtQ970XDXvCjhuPz/+ljdSt4suWucgpzb/8pJAUzLqjYWBOKDw3EchoKbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784911647; c=relaxed/simple;
	bh=FFFpGIB531o8c167/WQHpfJrFsCnpwaLHErYAnoCO+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FFIvVcwetN75rUmcSW1s+rg37qVBaa8fuvhlBtTc1yEJDQ860YXnR2YNjvZbUmLdTokcrEkJ2TqXu7E5y6JzfwdmCUc11dMzbLt8Qc9eXjRRQr2Kpqjm4OlkOEhl9bd3AkpSsUYm0YPovZpPZH2zF3GPepPX7qEdA8qqZ9Tqb3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZnS2G3kU; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZnS2G3kU"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cace91f112so8501155ad.0
        for <linux-integrity@vger.kernel.org>; Fri, 24 Jul 2026 09:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784911645; x=1785516445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5u91OXTJKFbcF00+Q/uuRlO/lNDvMJ8xKMudAoQ8DSI=;
        b=ZnS2G3kU8JXYzF7dwokX3zdAS7zVDQONicp0aDUtzst9uqgARTGf6Vxkye1NSibgbM
         fCnu+/Jzawcq4/utKzpXlzi0LCOWA24UK3OVqpPy71WruK1qV7Fssr3TzzJRaKZyi8uw
         bhV0e/+VbMWkh5MFqg23A0VLOvSyuDh3XldLIVJ0luGA6VMiFToXXpO2S3I+HZJziGb3
         bmVBRfcBjrUJysYpWNZJu3w0KwOmfDoS/rmwo4w9JpW8kN+CiJ+eWVDqqsEQqw9D5tCn
         /dQay/pw157P1yBrbZdUwUx/o/WK6OMRQ1ISkFi7figPThchF/0aBvThivejccYviuFM
         7/yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784911645; x=1785516445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5u91OXTJKFbcF00+Q/uuRlO/lNDvMJ8xKMudAoQ8DSI=;
        b=jRJl7D8SYoshksri/z1KZQQi8NsKcpz8skWzEUGXW++67wtCO3KKjZELfDzxeorzIz
         W+qBlMDJj3PSySbgH+BbGpesWIEdE8IgB5Nre2VYLqjACtbQ9X9j8E+8S80pCzH4B+ql
         DqmmWhwY1zJMHx2UQfR+bcWNJBWtQRDoDui2n/PRjZJdi08U4eAwBY2gynqBAHUFZoBm
         nb9ly7l3kXxtHCczriE+5p1IQIdUAF3dfgfmOiU0iUAWKf7DknyxPZ0+Djqquj82QpMl
         O6ZKRVRHMaAve9bLxMLZFsNAvv5dNaLXxYplFc0Gd+WbbB5Fn5PY8jDTjt/KglMqkaBo
         FtsQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqgf9CTz8YhgZva3ZuH/nOHDk61Z/+DvwsryBxH2JRvTZcrbzoHgX5wZWXZWYpKRDd8wQwiH0U+FP42tcJ2hqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyltBgZmtPAwWNRvEzxNh6DcgzV+2qKxSnquUVLk6ierqfQV9iH
	AixHHcYtbNdLfpCyqvqXW01asIL8YJtjHc+en71rijHw5mhQKzvqg2I=
X-Gm-Gg: AR+sD12i3+g35+lSgw9Qdg7EPtnGlh9eHf/A5eGGeflck7yzgpi1qljC3snBSTeB6lO
	xs987uPVAe5WmqtwlL0AS/1wyuZMxLCG/5/YLJp2CDePutFPvT55r0OymW1ZGHE29Qk/seT2KCq
	r7BWym29LfnmE6QkHOxhsLRlkoXmuz3ZUFhp60uJrzJYPoSowQehGt1J3Yji4uTn4ONQv7/Zmc1
	noB9N0N8lPDXzWacOSj5ea+vKaEttbtEywIzAiaiU0ucJpUytpkZp+HcVJzwe9uGySd+4K4nQYP
	OsE09q8wHpI5S7nt5JqTvCC3zK2BHjg5wKZ3QBXFVa51O9Cg6Gn/PhKFaBFUNInyGExxlAMyZUs
	q5PxNXdkQuQYB+dluOWBnlfOSXLZJzRrEUpuc4Q9HHyBL4NmI1riiNfB0j29kkM/sC318JtekEd
	zFXLMH4fUaHTn7nFYWmWRiOcKbPb3R7kjnQBR0Vg==
X-Received: by 2002:a17:902:ecd0:b0:2c6:9f6a:9f6f with SMTP id d9443c01a7336-2cfa6c66734mr90588615ad.28.1784911645204;
        Fri, 24 Jul 2026 09:47:25 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009.. ([27.60.19.161])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc548e29sm918244eec.15.2026.07.24.09.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 09:47:24 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
	Andre Eikmeyer <andre@negmaster.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v4 2/2] thunderbolt: Add device links for Apple T2 NHI
Date: Fri, 24 Jul 2026 12:46:37 -0400
Message-ID: <20260724164641.2239-3-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724164641.2239-1-atharvatiwarilinuxdev@gmail.com>
References: <20260724164641.2239-1-atharvatiwarilinuxdev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andre Eikmeyer <andre@negmaster.com>

Icelake Thunderbolt NHI on T2 Macs (2018-2020). The NHI and its
associated PCIe root ports all sit directly on the root complex
with no upstream port. Apple's ACPI tables name Thunderbolt root
ports as TRP0, TRP1, etc. Find them and create device links back
to the NHI so that PCIe tunnels can be re-established after sleep.

And on other Thunderbolt NHI's, like Titan Ridge, the default method
is used to add device links.

Co-developed-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>

Signed-off-by: Andre Eikmeyer <andre@negmaster.com>
---
 drivers/thunderbolt/tb.c | 58 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 56 insertions(+), 2 deletions(-)

diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index c69c323e6952..625451ff3ea0 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -6,9 +6,11 @@
  * Copyright (C) 2019, Intel Corporation
  */
 
+#include <linux/acpi.h>
 #include <linux/slab.h>
 #include <linux/errno.h>
 #include <linux/delay.h>
+#include <linux/pci.h>
 #include <linux/pm_runtime.h>
 #include <linux/platform_data/x86/apple.h>
 
@@ -3305,21 +3307,73 @@ static const struct tb_cm_ops tb_cm_ops = {
 static bool tb_apple_add_links(struct tb_nhi *nhi)
 {
 	struct pci_dev *upstream, *pdev;
-	bool ret;
+	bool ret = false;
 
 	if (!x86_apple_machine)
 		return false;
 
+	/* On T2 Macs with Icelake thunderbolt NHI's.
+	 * the root ports are stored in ACPI as TRP0,
+	 * TRP1, etc. Find them and create device links
+	 * so that PCIe tunnels can be re-established after
+	 * sleep.
+	 */
+#if IS_ENABLED(CONFIG_ACPI)
+	if (has_apple_t2_chip && (nhi->pdev->device == PCI_DEVICE_ID_INTEL_ICL_NHI0 ||
+				nhi->pdev->device == PCI_DEVICE_ID_INTEL_ICL_NHI1)) {
+		struct acpi_device *adev;
+		unsigned int slot, func;
+		const struct device_link *link;
+		const char *bid;
+
+		for (slot = 0; slot < 32; slot++) {
+			for (func = 0; func < 8; func++) {
+				struct pci_dev *current_pdev __free(pci_dev_put) =
+					pci_get_slot(nhi->pdev->bus, PCI_DEVFN(slot, func));
+				if (!current_pdev)
+					continue;
+
+				if (!pci_is_pcie(current_pdev) || pci_pcie_type(current_pdev) !=
+						PCI_EXP_TYPE_ROOT_PORT)
+					continue;
+
+				adev = ACPI_COMPANION(&current_pdev->dev);
+				if (!adev)
+					continue;
+
+				bid = acpi_device_bid(adev);
+				if (strncmp(bid, "TRP", 3) != 0)
+					continue;
+
+				link = device_link_add(&current_pdev->dev, &nhi->pdev->dev,
+						DL_FLAG_AUTOREMOVE_SUPPLIER |
+						DL_FLAG_PM_RUNTIME);
+				if (link) {
+					dev_dbg(&nhi->pdev->dev, "created link from %s\n",
+						dev_name(&current_pdev->dev));
+					ret = true;
+				} else {
+					dev_warn(&nhi->pdev->dev,
+						"device link creation from %s failed\n",
+						dev_name(&current_pdev->dev));
+				}
+			}
+		}
+		return ret;
+	}
+#endif
+
 	switch (nhi->pdev->device) {
 	case PCI_DEVICE_ID_INTEL_LIGHT_RIDGE:
 	case PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C:
 	case PCI_DEVICE_ID_INTEL_FALCON_RIDGE_2C_NHI:
 	case PCI_DEVICE_ID_INTEL_FALCON_RIDGE_4C_NHI:
+	case PCI_DEVICE_ID_INTEL_TITAN_RIDGE_2C_NHI:
+	case PCI_DEVICE_ID_INTEL_TITAN_RIDGE_4C_NHI:
 		break;
 	default:
 		return false;
 	}
-
 	upstream = pci_upstream_bridge(nhi->pdev);
 	while (upstream) {
 		if (!pci_is_pcie(upstream))
-- 
2.43.0


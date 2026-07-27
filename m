Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F3640E8FA
	for <linux-integrity@vger.kernel.org>; Mon, 27 Jul 2026 21:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785187127; cv=none; b=RlfGX8mgMjECojztfHFEGgaF6MdA6tDd9BerQiR3RxTvOSI7JROT4FqaiHWiIufris1BPaty5ljqs2N+buVvybrPMaH5WCZ7FMe8CRf/4PrqxfosA0d3lgt400rpP1Omg3q6EYdS1rgw3SYW1iS+yQSw8Pjtscro+RmOYuzjQkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785187127; c=relaxed/simple;
	bh=u2+nVHt7la9YltrGQzMce5hV2xgh2wYAZUlmBJxwuuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LRB/xsE0FydnBhKfLe1MRKA6chw+qyNsZsF/7QQh+G4gWw1PyriUyRTLf/XBe8hUI41RTnNbEUJ6uz6glz+z4v5vBq7K/ChPWCFtbXMHkbVk+vd9QeMTSuaeUJcoNdzNn/9OgfJ4r7IZR/MYeG5KOlYToUgU9FRQmBDO0AlrTio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cKTWo/gF; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKTWo/gF"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cbb7926836eso1786717a12.3
        for <linux-integrity@vger.kernel.org>; Mon, 27 Jul 2026 14:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785187125; x=1785791925; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VTr/js81B4miTEjNI6MC5wSeZgIjJ1qNbYXRJnSwtn0=;
        b=cKTWo/gFYe/HMutElxueFdzZvVXRMwKh4FPy4yJN4/t72rOrmUiqAuQ1WJtKtkLD/Y
         cKJkKpHJc+E8GSBp5HGyr+3hAlvLM2CR707C05zk2tInYD1/66byo2Oo4CxUnzQ5I195
         FHP4w5ctTcTqQBKSfhRjhkG0XeoU0TGn3qyIfw0S2tZt2o+F+UkXBpfDpoF1Jr25Qjx6
         nZAQpMgL8t3HbFylrGRqY45VGix9jEF2bB1pApGWPb1gsli/zA9p8gQpB5+0SMVYvTK+
         oSHEui5f1MmzuW5riNQJIPD2O+29rQtvNaLqGzC49RerHz0+Yf+k4jHxznInNW3lxcoI
         q8gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785187125; x=1785791925;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VTr/js81B4miTEjNI6MC5wSeZgIjJ1qNbYXRJnSwtn0=;
        b=fvvLqUVKshhIkcoJR49gqYK/hXL+bX8hFseXggTdZGoPsfEIMNLXwUrsEKjbci2dZA
         wE5iIbdFdZ5xDCrd3/TvgswfEepe04PN508Cdak7tKr6CUDExxB3FtjyH6zviDjE029s
         VnF1PFuBQArsU/SlkrCT8byCy0TWCfz+3VUgvnYEGZVVY1eXEcL/rXbv3OJTNCp/+ni4
         ZQuvp4dgX04Mnpq4VRarunI/R/IVPHwqW8p9i5l3lHBVBUutcwbN+eqoTl1pf3UG9lxC
         xiry7AvdMgpmNfmB1L/xsyYCNq/VsnUaUeHzR3052mLaDDThO9d3flSuNTRnSb33Jw4x
         gUFg==
X-Forwarded-Encrypted: i=1; AHgh+RrPBtG6L+NKxI66M9XxFV0T7H+LgiJiLBJngoiuCBEg24C7JKdrm36/IEXJVLQ6xzGlB1frTybfJIiaoT9Icls=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOt/09Ibv8Td3CZy28SqA96UvooE13Cmxp+xW2DWh179k+75LC
	fFQwb7yyvHyDnUCETTdgszy48QtLVReIPsUwV9nGV/qS3NBw2KKxUkA=
X-Gm-Gg: AR+sD13ccqlp7eCXmzdGiuSxeYP7VS3xZM33d02b5zV73JhDI7uHZdUacEUbP2u9l3T
	U46cc541mnNpQptCTbM5FPZPVFV8gc9gtRHAPutuMcROSbXQf13tzFX9jZq7pDaVKvU45JSKskl
	oLL1HDOwRwgODW19M5wqzsCtg3hvnsgGcqQJPnK3+rNydnw+nn3l6a4N/6uBc15tpSr3rFsCEsd
	UxElZuKQxXu3mqbZUX0oxhm4L2NN9Z2PaCSHkHf5JyN/Z+a418bYOIpwOoWAkOIEq0v+u29xT+3
	ngq6guOIL39XTquuBqzDBBd3tNw0Rw5Ck2cFyLlWmgKTEXmGdZsm3F5Q5cdlWYe9OaTGTZ9H1Jt
	HBQ2wkRFfA49oRmphbMk+qekTjmn2AAeDJTe0Lf7QBqoVW5RYupxRpd2yB9a+g9uU6ls1mf+R5l
	mvXRKXA0AIpY+VkSAw/PW7ZqX9ZpaP5KpTgtZY/VX2N///8PM=
X-Received: by 2002:a05:6a21:7116:b0:3c3:a9e1:a819 with SMTP id adf61e73a8af0-3c6c7b9562amr1345956637.24.1785187125217;
        Mon, 27 Jul 2026 14:18:45 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009.. ([27.59.84.42])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314e17a6f5fsm7916699eec.31.2026.07.27.14.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 14:18:44 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
	Andre Eikmeyer <dev@deq.rocks>,
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
Subject: [PATCH v5 2/2] thunderbolt: Add device links for Apple T2 NHI
Date: Mon, 27 Jul 2026 17:18:03 -0400
Message-ID: <20260727211807.1223-3-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260727211807.1223-1-atharvatiwarilinuxdev@gmail.com>
References: <20260727211807.1223-1-atharvatiwarilinuxdev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Ice Lake Thunderbolt NHI on T2 Macs (2018–2020). The NHI and its
associated PCIe Root Ports all sit directly on the Root Complex
with no upstream port. Identify the tunneled PCIe Root Ports by
their PCI IDs and create device links back to the NHI so that
PCIe tunnels can be re-established after sleep.

And on other T2 Thunderbolt NHI's, like Titan Ridge, the default method
is used to add device links.

Co-developed-by: Andre Eikmeyer <dev@deq.rocks>
Signed-off-by: Andre Eikmeyer <dev@deq.rocks>

Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
 drivers/thunderbolt/tb.c | 54 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index c69c323e6952..9b80e9339728 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -9,6 +9,7 @@
 #include <linux/slab.h>
 #include <linux/errno.h>
 #include <linux/delay.h>
+#include <linux/pci.h>
 #include <linux/pm_runtime.h>
 #include <linux/platform_data/x86/apple.h>
 
@@ -3305,21 +3306,70 @@ static const struct tb_cm_ops tb_cm_ops = {
 static bool tb_apple_add_links(struct tb_nhi *nhi)
 {
 	struct pci_dev *upstream, *pdev;
-	bool ret;
+	bool ret = false;
 
 	if (!x86_apple_machine)
 		return false;
 
+	/* On T2 Macs with Ice Lake Thunderbolt NHIs,
+	 * identify the tunneled PCIe Root Ports by their PCI IDs
+	 * and create device links so that
+	 * PCIe tunnels can be re-established after sleep.
+	 */
+	if (has_apple_t2_chip && (nhi->pdev->device == PCI_DEVICE_ID_INTEL_ICL_NHI0 ||
+				nhi->pdev->device == PCI_DEVICE_ID_INTEL_ICL_NHI1)) {
+		unsigned int slot, func;
+		const struct device_link *link;
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
+				switch (current_pdev->device) {
+				case 0x8a1d:
+				case 0x8a1f:
+				case 0x8a21:
+				case 0x8a23:
+					break;
+				default:
+					continue;
+				}
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


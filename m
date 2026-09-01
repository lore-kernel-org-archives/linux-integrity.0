Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB06313540;
	Tue,  1 Sep 2026 14:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788273002; cv=none; b=AQWd5RQpjK88w+wilvpyA2V2TaYcWjdRQzOcSZHOBHUmiAko256UvgQVONiAEFQnRc6/u+hLXz5btpHKcKMnxbdh8hdhfcQJgBAOoPGBFmyw1BkRZ45TIBsmEjqvzbGBNIl1603/wadmW9ue/WgkXAsZ9zfs0CPd28cP89RSOsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788273002; c=relaxed/simple;
	bh=ShLRn3DIOFQmncFiXePazjOX56EhJyN//PJ0AIMW4KY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pFDMKrC0m5kV3AipvsgGGO1fER1qqjl+H2L1dmNdUFSYm9mO4W3PYMHRomAkWxq5DYOAyPhY+S3jxeUYkgNxzqF8FnJwtnshYdoxIzu0uPtWeDaoq9+Joqp5e4Ka7Rm6jXHcnExve5J3MaqRUxbP4DCYuUB1weZC1tybwoNmOO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IlPKKpD0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IlPKKpD0"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id BFA961F000E9;
	Tue,  1 Sep 2026 14:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788273001;
	bh=A2AYh5SSryGrBO/HuHjQ4hxDZb/wBIY2xwZDbl2gNUA=;
	h=From:To:Cc:Subject:Date;
	b=IlPKKpD0RIgV63tQfh/tikjhcMlecq+P3F98DByODk4RXDVuWFTI3qDcH8iksBvCG
	 SoUxcSyLOMdrdJo91rU05hl+qf/UrbU48LmxB329h2N0xD2UCJFxLf1y4IZ6VCIIPd
	 gt1z5zK3ooHIZf77NWUQ/0dAxoXJRdOPY/IGCFagKRfKlhlAzMWfryW2dVU9WD7oJt
	 ENYCiSjDN8Lvel4egfRaBzQazHuvDsm+zEcg9SUnnGPAi0cLCrx1Cj5QhC2YpFaYcZ
	 j/jmzSH/CgLiUiN2rIlejEgDuDAjefuMvaS5YzMqpv6E8znlZf0pxTQUONNE2CaqCr
	 rEjQY/hQOLCRg==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Stuart Yoder <stuart.yoder@arm.com>,
	Chu Guangqing <chuguangqing@inspur.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tpm_crb: Remove dead code from crb_map_res()
Date: Tue,  1 Sep 2026 17:29:46 +0300
Message-ID: <20260901142955.187856-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In all the pre-existing call sites both @iomem and @iobase_ptr are
either NULL or non-NULL.

Thus, add invariant for this and remove a dead basic block.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/tpm_crb.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index ceb4100ba400..e7a61f36c58b 100644
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -570,15 +570,12 @@ static void __iomem *crb_map_res(struct device *dev, struct resource *iores,
 	if (start != new_res.start)
 		return IOMEM_ERR_PTR(-EINVAL);
 
+	if ((iores == NULL) != (iobase_ptr == NULL))
+		return IOMEM_ERR_PTR(-EINVAL);
+
 	if (!iores)
 		return devm_ioremap_resource(dev, &new_res);
 
-	if (!*iobase_ptr) {
-		*iobase_ptr = devm_ioremap_resource(dev, iores);
-		if (IS_ERR(*iobase_ptr))
-			return *iobase_ptr;
-	}
-
 	return *iobase_ptr + (new_res.start - iores->start);
 }
 
-- 
2.47.3


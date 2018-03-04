Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:9158 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932258AbeCDMPl (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 4 Mar 2018 07:15:41 -0500
From: Tomas Winkler <tomas.winkler@intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH 3/3] tpm_crb: use __le64 annotated variable for response buffer address
Date: Sun,  4 Mar 2018 14:12:05 +0200
Message-Id: <20180304121205.16934-3-tomas.winkler@intel.com>
In-Reply-To: <20180304121205.16934-1-tomas.winkler@intel.com>
References: <20180304121205.16934-1-tomas.winkler@intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

This suppresses sparse warning
drivers/char/tpm/tpm_crb.c:558:18: warning: cast to restricted __le64

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/char/tpm/tpm_crb.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index acfcdc6f31af..29fecdea0b2d 100644
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -489,6 +489,7 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
 	u32 pa_high, pa_low;
 	u64 cmd_pa;
 	u32 cmd_size;
+	__le64 __rsp_pa;
 	u64 rsp_pa;
 	u32 rsp_size;
 	int ret;
@@ -554,8 +555,8 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
 		goto out;
 	}
 
-	memcpy_fromio(&rsp_pa, &priv->regs_t->ctrl_rsp_pa, 8);
-	rsp_pa = le64_to_cpu(rsp_pa);
+	memcpy_fromio(&__rsp_pa, &priv->regs_t->ctrl_rsp_pa, 8);
+	rsp_pa = le64_to_cpu(__rsp_pa);
 	rsp_size = crb_fixup_cmd_size(dev, &io_res, rsp_pa,
 				      ioread32(&priv->regs_t->ctrl_rsp_size));
 
-- 
2.14.3

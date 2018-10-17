Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga18.intel.com ([134.134.136.126]:4116 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727570AbeJQOpB (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Oct 2018 10:45:01 -0400
From: Tomas Winkler <tomas.winkler@intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Nayna Jain <nayna@linux.vnet.ibm.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH v6 14/20] tpm: tpm-space.c remove unneeded semicolon
Date: Wed, 17 Oct 2018 09:46:07 +0300
Message-Id: <20181017064613.19746-15-tomas.winkler@intel.com>
In-Reply-To: <20181017064613.19746-1-tomas.winkler@intel.com>
References: <20181017064613.19746-1-tomas.winkler@intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Remove unneeded semicolon in tpm2_map_response_header()

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
V3: New in the series.
V4-V6: Resend.

 drivers/char/tpm/tpm2-space.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
index d2e101b32482..dcdfde3c253e 100644
--- a/drivers/char/tpm/tpm2-space.c
+++ b/drivers/char/tpm/tpm2-space.c
@@ -373,7 +373,7 @@ static int tpm2_map_response_header(struct tpm_chip *chip, u32 cc, u8 *rsp,
 		dev_err(&chip->dev, "%s: unknown handle 0x%08X\n",
 			__func__, phandle);
 		break;
-	};
+	}
 
 	return 0;
 out_no_slots:
-- 
2.14.4

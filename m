Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:46551 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751643AbeDFQVs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 6 Apr 2018 12:21:48 -0400
From: Colin King <colin.king@canonical.com>
To: Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tpm: st33zp24: remove redundant null check on chip
Date: Fri,  6 Apr 2018 17:21:44 +0100
Message-Id: <20180406162144.14717-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

Currently chip is being dereferenced by the call to dev_get_drvdata
before it is being null checked, however, chip can never be null, so
this check is misleading and redundant. Remove it.

Detected by CoverityScan, CID#1357806 ("Dereference before null check")

Signed-off-by: Colin Ian King <colin.king@canonical.com>

---

V2: don't check for null, just remove redundant null check,
    thanks to Jason Gunthorpe for spotting that.

---
 drivers/char/tpm/st33zp24/st33zp24.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/char/tpm/st33zp24/st33zp24.c b/drivers/char/tpm/st33zp24/st33zp24.c
index f95b9c75175b..abd675bec88c 100644
--- a/drivers/char/tpm/st33zp24/st33zp24.c
+++ b/drivers/char/tpm/st33zp24/st33zp24.c
@@ -373,8 +373,6 @@ static int st33zp24_send(struct tpm_chip *chip, unsigned char *buf,
 	int ret;
 	u8 data;
 
-	if (!chip)
-		return -EBUSY;
 	if (len < TPM_HEADER_SIZE)
 		return -EBUSY;
 
-- 
2.15.1

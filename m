Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:46304 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751874AbeDFQFr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 6 Apr 2018 12:05:47 -0400
From: Colin King <colin.king@canonical.com>
To: Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tpm: st33zp24: check if chip is null before dereferencing
Date: Fri,  6 Apr 2018 17:05:41 +0100
Message-Id: <20180406160541.8188-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

Currently chip is being dereferenced by the call to dev_get_drvdata
before it is being null checked, hence we have a potential null
pointer dereference bug. Fix this by only dereferencing it after the
null check.

Detected by CoverityScan, CID#1357806 ("Dereference before null check")

Fixes: 9e0d39d8a6a0 ("tpm: Remove useless priv field in struct tpm_vendor_specific")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/char/tpm/st33zp24/st33zp24.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/st33zp24/st33zp24.c b/drivers/char/tpm/st33zp24/st33zp24.c
index f95b9c75175b..476865d66a0e 100644
--- a/drivers/char/tpm/st33zp24/st33zp24.c
+++ b/drivers/char/tpm/st33zp24/st33zp24.c
@@ -367,7 +367,7 @@ static irqreturn_t tpm_ioserirq_handler(int irq, void *dev_id)
 static int st33zp24_send(struct tpm_chip *chip, unsigned char *buf,
 			 size_t len)
 {
-	struct st33zp24_dev *tpm_dev = dev_get_drvdata(&chip->dev);
+	struct st33zp24_dev *tpm_dev;
 	u32 status, i, size, ordinal;
 	int burstcnt = 0;
 	int ret;
@@ -378,6 +378,7 @@ static int st33zp24_send(struct tpm_chip *chip, unsigned char *buf,
 	if (len < TPM_HEADER_SIZE)
 		return -EBUSY;
 
+	tpm_dev = dev_get_drvdata(&chip->dev);
 	ret = request_locality(chip);
 	if (ret < 0)
 		return ret;
-- 
2.15.1

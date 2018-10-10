Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from gateway21.websitewelcome.com ([192.185.45.133]:33986 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726515AbeJJVXb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 10 Oct 2018 17:23:31 -0400
Received: from cm15.websitewelcome.com (cm15.websitewelcome.com [100.42.49.9])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id BC784400DEBB4
        for <linux-integrity@vger.kernel.org>; Wed, 10 Oct 2018 08:38:41 -0500 (CDT)
Date: Wed, 10 Oct 2018 15:38:17 +0200
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Tomas Winkler <tomas.winkler@intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] tpm: fix unused-value issues in tpm_try_transmit
Message-ID: <20181010133817.GA11485@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Currently, there are some values assigned to variable *rc*, which
are never actually used in any computation, because such variable
is updated at line 550, before they can be used:

549out:
550        rc = tpm_go_idle(chip, flags);
551        if (rc)
552                goto out;

Fix this by removing such assignments. 

Addresses-Coverity-ID: 1470245 ("Unused value")
Addresses-Coverity-ID: 1470250 ("Unused value")
Addresses-Coverity-ID: 1470251 ("Unused value")
Fixes: 627448e85c76 ("tpm: separate cmd_ready/go_idle from runtime_pm")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/char/tpm/tpm-interface.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 129f640..8062736 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -512,7 +512,6 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
 
 		if (chip->ops->req_canceled(chip, status)) {
 			dev_err(&chip->dev, "Operation Canceled\n");
-			rc = -ECANCELED;
 			goto out;
 		}
 
@@ -522,7 +521,6 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
 
 	chip->ops->cancel(chip);
 	dev_err(&chip->dev, "Operation Timed out\n");
-	rc = -ETIME;
 	goto out;
 
 out_recv:
@@ -533,14 +531,12 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
 			"tpm_transmit: tpm_recv: error %d\n", rc);
 		goto out;
 	} else if (len < TPM_HEADER_SIZE) {
-		rc = -EFAULT;
 		goto out;
 	}
 
-	if (len != be32_to_cpu(header->length)) {
-		rc = -EFAULT;
+	if (len != be32_to_cpu(header->length))
 		goto out;
-	}
+
 
 	rc = tpm2_commit_space(chip, space, ordinal, buf, &len);
 	if (rc)
-- 
2.7.4

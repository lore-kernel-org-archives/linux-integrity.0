Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga18.intel.com ([134.134.136.126]:15518 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726456AbeJOTD1 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 15 Oct 2018 15:03:27 -0400
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
Subject: [PATCH] tpm: tpm_try_transmit() ignore value of go_to_idle()
Date: Mon, 15 Oct 2018 14:14:34 +0300
Message-Id: <20181015111434.7777-1-tomas.winkler@intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Ignore the return value of go_to_idle() in tpm_try_transmit().
Once it may shadow the return value of actual tpm operation,
second the consequent command will fail as well and the error
will be caought anyway.
Last fix wrong goto, that jumped back instead of forward.

Fixes: 627448e85c76 ("tpm: separate cmd_ready/go_idle from runtime_pm")
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/char/tpm/tpm-interface.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 129f640424b7..f69c711bf74a 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -547,9 +547,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
 		dev_err(&chip->dev, "tpm2_commit_space: error %d\n", rc);
 
 out:
-	rc = tpm_go_idle(chip, flags);
-	if (rc)
-		goto out;
+	(void)tpm_go_idle(chip, flags);
 
 	if (need_locality)
 		tpm_relinquish_locality(chip, flags);
-- 
2.14.4

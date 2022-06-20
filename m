Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE6CC43334
	for <linux-integrity@archiver.kernel.org>; Mon, 20 Jun 2022 15:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244653AbiFTPZN (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 20 Jun 2022 11:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243879AbiFTPYt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Jun 2022 11:24:49 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281292FB
        for <linux-integrity@vger.kernel.org>; Mon, 20 Jun 2022 08:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1655738509;
  x=1687274509;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qshvmpCut8Dx65M0RL6pZPgb6mfqccyZtIAu+d2j3Oo=;
  b=iuxC+3JHLleNsLGroI7LMQq9QUEifZLjd5rqrE8TCMWTxeIq9FuOzS1v
   E8OcolsreyR3juEtO6XxxU66ngg8ro82eJ+37IIFERGjgQuFDTpSrJt6M
   cq3Ld/ybmFK2A+9m8jQUoh6YayNPmx0knHCzxUQ3TkB4x1H4qXcD0jPAZ
   hASSJFJvJtD/KSAqkt4xFC3ubgE7Yh5M4VFNS+DXdC8TJfznsGmp7ClZt
   JEaMrwz0roKmUO3q848LnY3crT94tO399+2xcU8ffnne8A0n5/qoICgYh
   jG58T/cyHFK6cLRDAjQS7C0/9fs22VruP2Sf1RqwR+7NTp7PCG/lUQ4Sj
   Q==;
From:   =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>
CC:     Jason Gunthorpe <jgg@ziepe.ca>, <linux-integrity@vger.kernel.org>,
        <kernel@axis.com>,
        =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
Subject: [PATCH v2] tpm: Add check for Failure mode for TPM2 modules
Date:   Mon, 20 Jun 2022 17:21:29 +0200
Message-ID: <20220620152129.551199-1-marten.lindahl@axis.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

In commit 0aa698787aa2 ("tpm: Add Upgrade/Reduced mode support for
TPM2 modules") it was said that:

"If the TPM is in Failure mode, it will successfully respond to both
tpm2_do_selftest() and tpm2_startup() calls. Although, will fail to
answer to tpm2_get_cc_attrs_tbl(). Use this fact to conclude that TPM
is in Failure mode."

But a check was never added in the commit when calling
tpm2_get_cc_attrs_tbl() to conclude that the TPM is in Failure mode.
This commit corrects this by adding a check.

Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
---

v2:
 - Add missed check for TPM error code.

 drivers/char/tpm/tpm2-cmd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index c1eb5d223839..65d03867e114 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -752,6 +752,12 @@ int tpm2_auto_startup(struct tpm_chip *chip)
 	}
 
 	rc = tpm2_get_cc_attrs_tbl(chip);
+	if (rc == TPM2_RC_FAILURE || (rc < 0 && rc != -ENOMEM)) {
+		dev_info(&chip->dev,
+			 "TPM in field failure mode, requires firmware upgrade\n");
+		chip->flags |= TPM_CHIP_FLAG_FIRMWARE_UPGRADE;
+		rc = 0;
+	}
 
 out:
 	/*
-- 
2.30.2


Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E1EC433EF
	for <linux-integrity@archiver.kernel.org>; Thu, 17 Mar 2022 01:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345725AbiCQBVE (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 16 Mar 2022 21:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240599AbiCQBVE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 16 Mar 2022 21:21:04 -0400
Received: from out199-9.us.a.mail.aliyun.com (out199-9.us.a.mail.aliyun.com [47.90.199.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD2C1D33F;
        Wed, 16 Mar 2022 18:19:47 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R411e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V7Okujx_1647479982;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V7Okujx_1647479982)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 17 Mar 2022 09:19:43 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     peterhuewe@gmx.de
Cc:     jarkko@kernel.org, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] char: tpm: cr50: Fix tpm_cr50_i2c_probe() kernel-doc comment
Date:   Thu, 17 Mar 2022 09:19:41 +0800
Message-Id: <20220317011941.102301-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Remove the description of @id in tpm_cr50_i2c_probe()
kernel-doc comment to remove warning found by running
scripts/kernel-doc, which is caused by using 'make W=1'.

drivers/char/tpm/tpm_tis_i2c_cr50.c:681: warning: Excess function
parameter 'id' description in 'tpm_cr50_i2c_probe'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/char/tpm/tpm_tis_i2c_cr50.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm_tis_i2c_cr50.c
index f6c0affbb456..d9bd58c3518e 100644
--- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
+++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
@@ -671,7 +671,6 @@ MODULE_DEVICE_TABLE(of, of_cr50_i2c_match);
 /**
  * tpm_cr50_i2c_probe() - Driver probe function.
  * @client:	I2C client information.
- * @id:		I2C device id.
  *
  * Return:
  * - 0:		Success.
-- 
2.20.1.7.g153144c


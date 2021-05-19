Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A78C433ED
	for <linux-integrity@archiver.kernel.org>; Wed, 19 May 2021 06:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA9456135B
	for <linux-integrity@archiver.kernel.org>; Wed, 19 May 2021 06:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbhESGv0 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 19 May 2021 02:51:26 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:3037 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237325AbhESGvZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 May 2021 02:51:25 -0400
Received: from dggems703-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FlNjH3hD8zmWx8;
        Wed, 19 May 2021 14:47:47 +0800 (CST)
Received: from dggeme759-chm.china.huawei.com (10.3.19.105) by
 dggems703-chm.china.huawei.com (10.3.19.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 19 May 2021 14:50:03 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggeme759-chm.china.huawei.com (10.3.19.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 19 May 2021 14:50:03 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <peterhuewe@gmx.de>, <jarkko@kernel.org>
CC:     <linux-integrity@vger.kernel.org>,
        Tian Tao <tiantao6@hisilicon.com>
Subject: [PATCH v3] char: tpm: move to use request_irq by IRQF_NO_AUTOEN flag
Date:   Wed, 19 May 2021 14:49:59 +0800
Message-ID: <1621406999-16816-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggeme759-chm.china.huawei.com (10.3.19.105)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

disable_irq() after request_irq() still has a time gap in which
interrupts can come. request_irq() with IRQF_NO_AUTOEN flag will
disable IRQ auto-enable because of requesting.

Link: https://lore.kernel.org/patchwork/patch/1388765/
Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
v2: add the Link.
v3: put sob last.
---
 drivers/char/tpm/tpm_tis_i2c_cr50.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm_tis_i2c_cr50.c
index f19c227..44dde2f 100644
--- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
+++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
@@ -706,14 +706,14 @@ static int tpm_cr50_i2c_probe(struct i2c_client *client,
 
 	if (client->irq > 0) {
 		rc = devm_request_irq(dev, client->irq, tpm_cr50_i2c_int_handler,
-				      IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+				      IRQF_TRIGGER_FALLING | IRQF_ONESHOT |
+				      IRQF_NO_AUTOEN,
 				      dev->driver->name, chip);
 		if (rc < 0) {
 			dev_err(dev, "Failed to probe IRQ %d\n", client->irq);
 			return rc;
 		}
 
-		disable_irq(client->irq);
 		priv->irq = client->irq;
 	} else {
 		dev_warn(dev, "No IRQ, will use %ums delay for TPM ready\n",
-- 
2.7.4


Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64354C433EF
	for <linux-integrity@archiver.kernel.org>; Tue, 12 Oct 2021 12:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47B456101D
	for <linux-integrity@archiver.kernel.org>; Tue, 12 Oct 2021 12:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236553AbhJLMv2 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 12 Oct 2021 08:51:28 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:13727 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236326AbhJLMv2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Oct 2021 08:51:28 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HTFnJ4KyGzWldj;
        Tue, 12 Oct 2021 20:47:48 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 12 Oct 2021 20:49:21 +0800
Received: from mdc.huawei.com (10.175.112.208) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 12 Oct 2021 20:49:20 +0800
From:   Chen Jun <chenjun102@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-integrity@vger.kernel.org>
CC:     <peterhuewe@gmx.de>, <jarkko@kernel.org>, <jgg@ziepe.ca>,
        <rui.xiang@huawei.com>
Subject: [PATCH v2 1/1] tpm: add request_locality before write TPM_INT_ENABLE
Date:   Tue, 12 Oct 2021 12:48:03 +0000
Message-ID: <20211012124803.11956-1-chenjun102@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

the addr can not be written without request_locality.

Fixes: e6aef069b6e9 ("tpm_tis: convert to using locality callbacks")
Signed-off-by: Chen Jun <chenjun102@huawei.com>
---
 drivers/char/tpm/tpm_tis_core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 69579efb247b..bea587301917 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -978,7 +978,15 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 	intmask |= TPM_INTF_CMD_READY_INT | TPM_INTF_LOCALITY_CHANGE_INT |
 		   TPM_INTF_DATA_AVAIL_INT | TPM_INTF_STS_VALID_INT;
 	intmask &= ~TPM_GLOBAL_INT_ENABLE;
+
+	rc = request_locality(chip, 0);
+	if (rc < 0) {
+		rc = -ENODEV;
+		goto out_err;
+	}
+
 	tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), intmask);
+	release_locality(chip, 0);
 
 	rc = tpm_chip_start(chip);
 	if (rc)
-- 
2.17.1


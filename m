Return-Path: <SRS0=el+A=3D=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1497C33CB1
	for <linux-integrity@archiver.kernel.org>; Tue, 14 Jan 2020 11:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 823252467A
	for <linux-integrity@archiver.kernel.org>; Tue, 14 Jan 2020 11:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbgANL4u (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 14 Jan 2020 06:56:50 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9172 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725956AbgANL4u (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Jan 2020 06:56:50 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D9E49CC318F77E6BF210;
        Tue, 14 Jan 2020 19:56:46 +0800 (CST)
Received: from huawei.com (10.175.107.192) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Tue, 14 Jan 2020
 19:56:38 +0800
From:   wanghongzhe <wanghongzhe@huawei.com>
To:     <peterhuewe@gmx.de>
CC:     <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <zhangchenfeng1@huawei.com>, <wanghongzhe@huawei.com>
Subject: [PATCH] tpm: tpm_tis_spi: set cs_change = 0 when timesout
Date:   Tue, 14 Jan 2020 20:31:59 +0800
Message-ID: <1579005119-16318-1-git-send-email-wanghongzhe@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.107.192]
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

when i reach TPM_RETRY, the cs cannot  change back to 'high'.So the TPM chips thinks this communication is not over. 
And next times communication cannot be effective because the communications mixed up with the last time.

Signed-off-by: wanghongzhe <wanghongzhe@huawei.com>
---
 drivers/char/tpm/tpm_tis_spi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/char/tpm/tpm_tis_spi.c b/drivers/char/tpm/tpm_tis_spi.c
index d1754fd..a1ae4f6 100644
--- a/drivers/char/tpm/tpm_tis_spi.c
+++ b/drivers/char/tpm/tpm_tis_spi.c
@@ -67,7 +67,14 @@ static int tpm_tis_spi_flow_control(struct tpm_tis_spi_phy *phy,
 		}
 
 		if (i == TPM_RETRY)
+ 		{
+ 			spi_xfer.cs_change = 0;
+ 			spi_xfer->len = 1;
+ 			spi_message_init(&m);
+ 			spi_message_add_tail(spi_xfer, &m);
+ 			ret = spi_sync_locked(phy->spi_device, &m);
 			return -ETIMEDOUT;
+ 		}
 	}
 
 	return 0;
-- 
1.7.12.4


Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C126EB64DA
	for <linux-integrity@archiver.kernel.org>; Mon, 10 Jul 2023 14:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbjGJO32 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 10 Jul 2023 10:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbjGJO31 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 Jul 2023 10:29:27 -0400
X-Greylist: delayed 3021 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 10 Jul 2023 07:29:26 PDT
Received: from mx.mylinuxtime.de (mx.mylinuxtime.de [195.201.174.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E44F2
        for <linux-integrity@vger.kernel.org>; Mon, 10 Jul 2023 07:29:26 -0700 (PDT)
Received: from leda.eworm.de (unknown [194.36.25.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mx.mylinuxtime.de (Postfix) with ESMTPSA id 266AB234AF1;
        Mon, 10 Jul 2023 16:29:25 +0200 (CEST)
Received: by leda.eworm.de (Postfix, from userid 1000)
        id E2E4B1831C3; Mon, 10 Jul 2023 16:29:24 +0200 (CEST)
From:   Christian Hesse <mail@eworm.de>
To:     linux-integrity@vger.kernel.org
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        Peter Huewe <peterhuewe@gmx.de>,
        Christian Hesse <mail@eworm.de>, stable@vger.kernel.org,
        roubro1991@gmail.com
Subject: [PATCH v2 2/2] tpm/tpm_tis: Disable interrupts for Framework Laptop Intel 13th gen
Date:   Mon, 10 Jul 2023 16:28:44 +0200
Message-ID: <20230710142916.18162-2-mail@eworm.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230710142916.18162-1-mail@eworm.de>
References: <20230710133836.4367-1-mail@eworm.de>
 <20230710142916.18162-1-mail@eworm.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This device suffer an irq storm, so add it in tpm_tis_dmi_table to
force polling.

Link: https://community.frame.work/t/boot-and-shutdown-hangs-with-arch-linux-kernel-6-4-1-mainline-and-arch/33118
Fixes: e644b2f498d2 ("tpm, tpm_tis: Enable interrupt test")
Cc: stable@vger.kernel.org
Reported-by: <roubro1991@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217631
Signed-off-by: Christian Hesse <mail@eworm.de>
---
 drivers/char/tpm/tpm_tis.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
index 2979f8b9aaa0..a8bcd2134e6b 100644
--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -122,6 +122,14 @@ static const struct dmi_system_id tpm_tis_dmi_table[] = {
 			DMI_MATCH(DMI_PRODUCT_VERSION, "A4"),
 		},
 	},
+	{
+		.callback = tpm_tis_disable_irq,
+		.ident = "Framework Laptop Intel 13th gen",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Framework"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "A6"),
+		},
+	},
 	{
 		.callback = tpm_tis_disable_irq,
 		.ident = "ThinkPad T490s",
-- 
2.41.0


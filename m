Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABD0C432BE
	for <linux-integrity@archiver.kernel.org>; Tue, 27 Jul 2021 17:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E551961006
	for <linux-integrity@archiver.kernel.org>; Tue, 27 Jul 2021 17:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbhG0RN0 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 27 Jul 2021 13:13:26 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55396 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhG0RNZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Jul 2021 13:13:25 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: aratiu)
        with ESMTPSA id 6DFF91F43360
From:   Adrian Ratiu <adrian.ratiu@collabora.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, stable@vger.kernel.org
Subject: [PATCH v2 1/2] char: tpm: Kconfig: remove bad i2c cr50 select
Date:   Tue, 27 Jul 2021 20:13:12 +0300
Message-Id: <20210727171313.2452236-1-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This fixes a minor bug which went unnoticed during the initial
driver upstreaming review: TCG_CR50 does not exist in mainline
kernels, so remove it.

Fixes: 3a253caaad11 ("char: tpm: add i2c driver for cr50")
Cc: stable@vger.kernel.org
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 drivers/char/tpm/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
index 4308f9ca7a43..d6ba644f6b00 100644
--- a/drivers/char/tpm/Kconfig
+++ b/drivers/char/tpm/Kconfig
@@ -89,7 +89,6 @@ config TCG_TIS_SYNQUACER
 config TCG_TIS_I2C_CR50
 	tristate "TPM Interface Specification 2.0 Interface (I2C - CR50)"
 	depends on I2C
-	select TCG_CR50
 	help
 	  This is a driver for the Google cr50 I2C TPM interface which is a
 	  custom microcontroller and requires a custom i2c protocol interface
-- 
2.32.0


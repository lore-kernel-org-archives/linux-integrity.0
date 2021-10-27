Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E021C433F5
	for <linux-integrity@archiver.kernel.org>; Wed, 27 Oct 2021 12:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DC5660E54
	for <linux-integrity@archiver.kernel.org>; Wed, 27 Oct 2021 12:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241715AbhJ0MPh (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 27 Oct 2021 08:15:37 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57306 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232242AbhJ0MPh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 Oct 2021 08:15:37 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id D6CF71F44425
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     linux-integrity@vger.kernel.org
Cc:     apronin@chromium.org, peterhuewe@gmx.de, jarkko@kernel.org,
        jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [RESEND PATCH] tpm: tpm_tis_spi_cr50: Add default RNG quality
Date:   Wed, 27 Oct 2021 14:12:58 +0200
Message-Id: <20211027121258.2501124-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

To allow this device to fill the kernel's entropy pool at boot,
setup a default quality for the hwrng found in Cr50.

After some testing with rngtest and dieharder it was, in short,
discovered that the RNG produces fair quality randomness, giving
around 99.93% successes in rngtest FIPS140-2.

Notably, though, when testing with dieharder it was noticed that
the p-values distribution wasn't uniform in all the cases, so a
conservative quality value was chosen.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---

Sorry for the resend, I forgot to include linux-kernel@vger.kernel.org the
first time.

 drivers/char/tpm/tpm_tis_spi_cr50.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/tpm/tpm_tis_spi_cr50.c b/drivers/char/tpm/tpm_tis_spi_cr50.c
index ea759af25634..d6195fb58036 100644
--- a/drivers/char/tpm/tpm_tis_spi_cr50.c
+++ b/drivers/char/tpm/tpm_tis_spi_cr50.c
@@ -264,6 +264,7 @@ int cr50_spi_probe(struct spi_device *spi)
 	phy = &cr50_phy->spi_phy;
 	phy->flow_control = cr50_spi_flow_control;
 	phy->wake_after = jiffies;
+	phy->priv.rng_quality = 700;
 	init_completion(&phy->ready);
 
 	cr50_phy->access_delay = CR50_NOIRQ_ACCESS_DELAY;
-- 
2.33.0


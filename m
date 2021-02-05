Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7505C433DB
	for <linux-integrity@archiver.kernel.org>; Fri,  5 Feb 2021 20:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6357464F31
	for <linux-integrity@archiver.kernel.org>; Fri,  5 Feb 2021 20:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbhBESrq (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 5 Feb 2021 13:47:46 -0500
Received: from services.gouders.net ([141.101.32.176]:55090 "EHLO
        services.gouders.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233162AbhBESqW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Feb 2021 13:46:22 -0500
Received: from lena.gouders.net (ltea-047-066-017-037.pools.arcor-ip.net [47.66.17.37])
        (authenticated bits=0)
        by services.gouders.net (8.14.8/8.14.8) with ESMTP id 115KND7P010254
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Fri, 5 Feb 2021 21:23:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
        t=1612556596; bh=ePhxPehd8NJvb5Bp+taoe4FVpJuQgR2FKjPv9jRtHaU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=WfGCeRbKzBsGWfFTRO0n1/hPgJtjWtofWnDQmOzTldrhUlL7V4LsEe2U8mYjBAqvk
         4Rn6KsMoCbPvNFalOgWujkJUffjRFv9M2gNCt7AE6tNPfJG4bgETPR4hK5U5M3HnNJ
         9S10XX0kxHzFX/ZNGSYRBb6sxlq/3as+6F7cq6gI=
From:   Dirk Gouders <dirk@gouders.net>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Dirk Gouders <dirk@gouders.net>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] tpm_tis: handle -EPROBE_DEFER in tpm_tis_plat_probe()
Date:   Fri,  5 Feb 2021 21:20:22 +0100
Message-Id: <20210205202022.4515-2-dirk@gouders.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210205202022.4515-1-dirk@gouders.net>
References: <20210205202022.4515-1-dirk@gouders.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

tpm_tis does not consider -EPROBE_DEFER in tpm_tis_plat_probe().
Instead, without notification it falls back to polling mode if
platform_get_irq_optional() returns a negative value.

This could lead to different behavior depending on wether tpm_tis was
compiled builtin or as a module; in the latter case
platform_get_irq_optional() often if not always returns a valid IRQ
number on the first attempt.

Harmonize builtin and module behavior by returning -EPROBE_DEFER,
effectively putting the device on the deferred probe list for later
probe attempts.

Signed-off-by: Dirk Gouders <dirk@gouders.net>
---
 drivers/char/tpm/tpm_tis.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
index 4ed6e660273a..4cf863704aa1 100644
--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -320,6 +320,9 @@ static int tpm_tis_plat_probe(struct platform_device *pdev)
 
 	tpm_info.irq = platform_get_irq_optional(pdev, 0);
 	if (tpm_info.irq <= 0) {
+                if (tpm_info.irq == -EPROBE_DEFER)
+                        /* Enter deferred probe list and try again, later. */
+                        return -EPROBE_DEFER;
 		if (pdev != force_pdev)
 			tpm_info.irq = -1;
 		else
-- 
2.26.2


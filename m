Return-Path: <SRS0=nt+s=DG=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E89C4727C
	for <linux-integrity@archiver.kernel.org>; Tue, 29 Sep 2020 22:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA8A8206CA
	for <linux-integrity@archiver.kernel.org>; Tue, 29 Sep 2020 22:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="WXgFuk85"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbgI2Wdy (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 29 Sep 2020 18:33:54 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:51312 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728115AbgI2Wdy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Sep 2020 18:33:54 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 49D8C8EE17F;
        Tue, 29 Sep 2020 15:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1601418834;
        bh=RAm3gZB5rA1bNgfItFHyy+w+DOdLSwh6BmXF3tC6hhI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WXgFuk85mSzkPt4C+PXH4r3GbNgthK3aIVE2EUkLGEBS6qOuS+PSY3VKEu9yszEO8
         poNzMJ6ZKnpO2NwTqdhXVfrfcE901aEHYT5DnfkpDcRb9v/VTqT7qDgOyul7ahFGKR
         7rUXYWyNZ2paU9P8u7hvnGOeIjQfYdD/Ssvp1UwM=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id nXa9NK7CeVBx; Tue, 29 Sep 2020 15:33:54 -0700 (PDT)
Received: from jarvis.int.hansenpartnership.com (jarvis.ext.hansenpartnership.com [153.66.160.226])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id DAE858EE119;
        Tue, 29 Sep 2020 15:33:53 -0700 (PDT)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>
Subject: [PATCH 3/4] tpm_tis: fix IRQ probing
Date:   Tue, 29 Sep 2020 15:32:15 -0700
Message-Id: <20200929223216.22584-4-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200929223216.22584-1-James.Bottomley@HansenPartnership.com>
References: <20200929223216.22584-1-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Unless the TPM_CHIP_FLAG_IRQ is set somewhere, an initial probe of the
IRQ never gets done.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 drivers/char/tpm/tpm_tis_core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 02cc384fdaea..b8ab26077cb1 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -808,6 +808,19 @@ static int tpm_tis_probe_irq_single(struct tpm_chip *chip,
 	}
 	priv->irq = irq;
 
+	/*
+	 * note writes to the interrupt registers are only effective
+	 * when the TPM is in the active locality, so we have to
+	 * request the locality here to get the interrupt set up.
+	 * This request has no corresponding release, because the
+	 * locality will be relinquished at the end of the tpm command
+	 * that probes the interrupts
+	 */
+	if (request_locality(chip, 0) != 0) {
+		dev_err(&chip->dev, "failed to gain locality for irq probe\n");
+		return -EBUSY;
+	}
+
 	rc = tpm_tis_read8(priv, TPM_INT_VECTOR(priv->locality),
 			   &original_int_vec);
 	if (rc < 0)
@@ -835,6 +848,7 @@ static int tpm_tis_probe_irq_single(struct tpm_chip *chip,
 		return rc;
 
 	priv->irq_tested = false;
+	chip->flags |= TPM_CHIP_FLAG_IRQ;
 
 	/* Generate an interrupt by having the core call through to
 	 * tpm_tis_send
-- 
2.28.0


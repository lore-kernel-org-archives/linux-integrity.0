Return-Path: <SRS0=nhA0=54=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2003C2BB86
	for <linux-integrity@archiver.kernel.org>; Sun, 12 Apr 2020 17:13:17 +0000 (UTC)
X-Greylist: delayed 183 seconds by postgrey-1.34 at mail.kernel.org; Sun, 12 Apr 2020 17:13:17 UTC
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B552F206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B552F206E9
	for <linux-integrity@archiver.kernel.org>; Sun, 12 Apr 2020 17:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbgDLRKJ (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sun, 12 Apr 2020 13:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:58964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbgDLRKG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 12 Apr 2020 13:10:06 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F17AC0A3BF9;
        Sun, 12 Apr 2020 10:04:22 -0700 (PDT)
IronPort-SDR: 7LuXZj+dZEiceUCK23Pi75vIRpBaYJzdgXmuW9+ZwiRqt7GXnucH6eKa+2gv0c4wUuo5AEzU65
 KyrtoDeCfcVA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2020 10:04:22 -0700
IronPort-SDR: DTTdKPJHO0uXGagxqHZl2vgjFStjmywwfVSPECr7jUaNvuTE4PuiP7PhBzKK+tCJhqa2W1kmBw
 ICtY9IPRFwPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,375,1580803200"; 
   d="scan'208";a="298228946"
Received: from apresura-mobl.ger.corp.intel.com (HELO localhost) ([10.252.61.246])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Apr 2020 10:04:19 -0700
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-integrity@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] tpm/tpm_tis: Free IRQ if probing fails
Date:   Sun, 12 Apr 2020 20:04:12 +0300
Message-Id: <20200412170412.324200-1-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Call devm_free_irq() if we have to revert to polling in order not to
unnecessarily reserve the IRQ for the life-cycle of the driver.

Cc: stable@vger.kernel.org # 4.5.x
Reported-by: Hans de Goede <hdegoede@redhat.com>
Fixes: e3837e74a06d ("tpm_tis: Refactor the interrupt setup")
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 drivers/char/tpm/tpm_tis_core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 27c6ca031e23..ae6868e7b696 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -1062,9 +1062,12 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 		if (irq) {
 			tpm_tis_probe_irq_single(chip, intmask, IRQF_SHARED,
 						 irq);
-			if (!(chip->flags & TPM_CHIP_FLAG_IRQ))
+			if (!(chip->flags & TPM_CHIP_FLAG_IRQ)) {
 				dev_err(&chip->dev, FW_BUG
 					"TPM interrupt not working, polling instead\n");
+				devm_free_irq(chip->dev.parent, priv->irq,
+					      chip);
+			}
 		} else {
 			tpm_tis_probe_irq(chip, intmask);
 		}
-- 
2.25.1


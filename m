Return-Path: <SRS0=GpUp=C7=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B4C9C2D0E2
	for <linux-integrity@archiver.kernel.org>; Tue, 22 Sep 2020 09:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD107221F0
	for <linux-integrity@archiver.kernel.org>; Tue, 22 Sep 2020 09:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600767709;
	bh=ttUaxpIoiZeqwIvQOhaNFmyYIhNSRt/G+yBAvPlz2is=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Jc/TmAVUbzTrm50xv2jAPT1lnwwT9acMNpfwSXV2Y5T182mK7RdlHHsEF/UtS9JMG
	 P/I9hcc+Cytut14+YDQ9pPdv2A8YWBQ0z5gOQw0qUwQarA2vNTHi0VYVbpx7Rdeozm
	 u+vlM+BqSdcvMehKp8A3PoyWuOdpIZWNBmAiRY5I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgIVJlt (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 22 Sep 2020 05:41:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:42778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbgIVJlt (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 22 Sep 2020 05:41:49 -0400
Received: from e123331-lin.nice.arm.com (lfbn-nic-1-188-42.w2-15.abo.wanadoo.fr [2.15.37.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE322239A1;
        Tue, 22 Sep 2020 09:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600767708;
        bh=ttUaxpIoiZeqwIvQOhaNFmyYIhNSRt/G+yBAvPlz2is=;
        h=From:To:Cc:Subject:Date:From;
        b=BJ39ovw6VE7ZMD0AA2u98IyiuiYME3jBM9sXvoNy8Ft+JWMjZyHcVJwtvmPFPE//W
         /iK5le6ma37lYtFiGtTrtRTAx1/r1AShY/LYID9q0S/5Fd76/JbiG+jtmNHxPpZ6g5
         i7VSqgb94mZiYrIHEvum2OdY3lHxtJiL9rNlW/5s=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH] tpm: of: avoid __va() translation for event log address
Date:   Tue, 22 Sep 2020 11:41:28 +0200
Message-Id: <20200922094128.26245-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The TPM event log is provided to the OS by the firmware, by loading
it into an area in memory and passing the physical address via a node
in the device tree.

Currently, we use __va() to access the memory via the kernel's linear
map: however, it is not guaranteed that the linear map covers this
particular address, as we may be running under HIGHMEM on a 32-bit
architecture, or running firmware that uses a memory type for the
event log that is omitted from the linear map (such as EfiReserved).

So instead, use memremap(), which will reuse the linear mapping if
it is valid, or create another mapping otherwise.

Cc: Peter Huewe <peterhuewe@gmx.de>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/char/tpm/eventlog/of.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/eventlog/of.c b/drivers/char/tpm/eventlog/of.c
index a9ce66d09a75..9178547589a3 100644
--- a/drivers/char/tpm/eventlog/of.c
+++ b/drivers/char/tpm/eventlog/of.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/slab.h>
+#include <linux/io.h>
 #include <linux/of.h>
 #include <linux/tpm_eventlog.h>
 
@@ -25,6 +26,7 @@ int tpm_read_log_of(struct tpm_chip *chip)
 	struct tpm_bios_log *log;
 	u32 size;
 	u64 base;
+	void *p;
 
 	log = &chip->log;
 	if (chip->dev.parent && chip->dev.parent->of_node)
@@ -65,7 +67,11 @@ int tpm_read_log_of(struct tpm_chip *chip)
 		return -EIO;
 	}
 
-	log->bios_event_log = kmemdup(__va(base), size, GFP_KERNEL);
+	p = memremap(base, size, MEMREMAP_WB);
+	if (!p)
+		return -ENOMEM;
+	log->bios_event_log = kmemdup(p, size, GFP_KERNEL);
+	memunmap(p);
 	if (!log->bios_event_log)
 		return -ENOMEM;
 
-- 
2.17.1


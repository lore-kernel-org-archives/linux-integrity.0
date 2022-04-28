Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB2BC4332F
	for <linux-integrity@archiver.kernel.org>; Thu, 28 Apr 2022 08:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344241AbiD1IbM (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 28 Apr 2022 04:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344190AbiD1IbI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 28 Apr 2022 04:31:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FEA0A0BE9;
        Thu, 28 Apr 2022 01:27:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5F85421870;
        Thu, 28 Apr 2022 08:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651134471; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CI5eCbbUh0HTvUxNvVm6rOMW68v7G6W10HjxAtg/ngA=;
        b=plhuxsR5eHWXzBK0P+35/4qRW5X11ur7K+VFwBQHFjrUXz367eeCDl5N4tO+2yDtlkMhzg
        YYPWBfxbelagkQWT0RoqKtMDb6YfVYgzvvOjcOzLMU+1dV3acvtrEjUNtANR3KBuDqcv2V
        NXaoQzG58L0ZWkmi9psNZD7qJZerN9M=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 27BFC13491;
        Thu, 28 Apr 2022 08:27:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2Fd3CAdQamIBLgAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 28 Apr 2022 08:27:51 +0000
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH v2 13/19] xen/tpmfront: use xenbus_setup_ring() and xenbus_teardown_ring()
Date:   Thu, 28 Apr 2022 10:27:37 +0200
Message-Id: <20220428082743.16593-14-jgross@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220428082743.16593-1-jgross@suse.com>
References: <20220428082743.16593-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Simplify tpmfront's ring creation and removal via xenbus_setup_ring()
and xenbus_teardown_ring().

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/char/tpm/xen-tpmfront.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/char/tpm/xen-tpmfront.c b/drivers/char/tpm/xen-tpmfront.c
index 69df04ae2401..379291826261 100644
--- a/drivers/char/tpm/xen-tpmfront.c
+++ b/drivers/char/tpm/xen-tpmfront.c
@@ -253,20 +253,12 @@ static int setup_ring(struct xenbus_device *dev, struct tpm_private *priv)
 	struct xenbus_transaction xbt;
 	const char *message = NULL;
 	int rv;
-	grant_ref_t gref;
 
-	priv->shr = (void *)__get_free_page(GFP_KERNEL|__GFP_ZERO);
-	if (!priv->shr) {
-		xenbus_dev_fatal(dev, -ENOMEM, "allocating shared ring");
-		return -ENOMEM;
-	}
-
-	rv = xenbus_grant_ring(dev, priv->shr, 1, &gref);
+	rv = xenbus_setup_ring(dev, GFP_KERNEL, (void **)&priv->shr, 1,
+			       &priv->ring_ref);
 	if (rv < 0)
 		return rv;
 
-	priv->ring_ref = gref;
-
 	rv = xenbus_alloc_evtchn(dev, &priv->evtchn);
 	if (rv)
 		return rv;
@@ -331,11 +323,7 @@ static void ring_free(struct tpm_private *priv)
 	if (!priv)
 		return;
 
-	if (priv->ring_ref)
-		gnttab_end_foreign_access(priv->ring_ref,
-				(unsigned long)priv->shr);
-	else
-		free_page((unsigned long)priv->shr);
+	xenbus_teardown_ring((void **)&priv->shr, 1, &priv->ring_ref);
 
 	if (priv->irq)
 		unbind_from_irqhandler(priv->irq, priv);
-- 
2.34.1


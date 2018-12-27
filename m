Return-Path: <SRS0=eq0w=PE=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE2EC43387
	for <linux-integrity@archiver.kernel.org>; Thu, 27 Dec 2018 05:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BD7121741
	for <linux-integrity@archiver.kernel.org>; Thu, 27 Dec 2018 05:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbeL0Fvx (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 27 Dec 2018 00:51:53 -0500
Received: from guitar.tcltek.co.il ([192.115.133.116]:51625 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729055AbeL0Fvw (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 Dec 2018 00:51:52 -0500
Received: from sapphire.tkos.co.il (unknown [10.0.4.3])
        by mx.tkos.co.il (Postfix) with ESMTP id 3CB5644004E;
        Thu, 27 Dec 2018 07:51:49 +0200 (IST)
From:   Baruch Siach <baruch@tkos.co.il>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org, Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH] MAINTAINERS: fix typo in Mimi Zohar's address
Date:   Thu, 27 Dec 2018 07:50:49 +0200
Message-Id: <e186bbae367ceb7a2a71e2dea216838ac19dee8f.1545889849.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Fixes: ("MAINTAINERS: Update from @linux.vnet.ibm.com to @linux.ibm.com")
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 705555d9b3af..0b8b0d60833a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8339,7 +8339,7 @@ F:	security/keys/encrypted-keys/
 KEYS-TRUSTED
 M:	James Bottomley <jejb@linux.ibm.com>
 M:      Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
-M:	Mimi Zohar <zohar@linuxibm.com>
+M:	Mimi Zohar <zohar@linux.ibm.com>
 L:	linux-integrity@vger.kernel.org
 L:	keyrings@vger.kernel.org
 S:	Supported
-- 
2.19.2


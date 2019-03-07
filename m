Return-Path: <SRS0=us8B=RK=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1463BC43381
	for <linux-integrity@archiver.kernel.org>; Thu,  7 Mar 2019 18:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAD4320675
	for <linux-integrity@archiver.kernel.org>; Thu,  7 Mar 2019 18:59:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbfCGS7K (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 7 Mar 2019 13:59:10 -0500
Received: from guitar.tcltek.co.il ([192.115.133.116]:55883 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726127AbfCGS7K (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Mar 2019 13:59:10 -0500
Received: from tarshish.tkos.co.il (unknown [10.0.8.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 1CBB34403F9;
        Thu,  7 Mar 2019 20:58:50 +0200 (IST)
From:   Baruch Siach <baruch@tkos.co.il>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH v2] MAINTAINERS: fix typo in Mimi Zohar's address
Date:   Thu,  7 Mar 2019 20:57:17 +0200
Message-Id: <bfe5434476b9e70445e6c416c31d88b85078d186.1551985037.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Fixes: ("MAINTAINERS: Update from @linux.vnet.ibm.com to @linux.ibm.com")
Reviewed-by: Paul E. McKenney <paulmck@linux.ibm.com>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
Hi Linus,

Paul suggested that I send this to you directly since otherwise it would
miss v5.1 after missing v5.0. I hope you are fine with that.

baruch

v2: add Paul's review tag
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ae76b5853ffe..3456651e5c72 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8494,7 +8494,7 @@ F:	security/keys/encrypted-keys/
 KEYS-TRUSTED
 M:	James Bottomley <jejb@linux.ibm.com>
 M:      Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
-M:	Mimi Zohar <zohar@linuxibm.com>
+M:	Mimi Zohar <zohar@linux.ibm.com>
 L:	linux-integrity@vger.kernel.org
 L:	keyrings@vger.kernel.org
 S:	Supported
-- 
2.20.1


Return-Path: <SRS0=/BKP=BX=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25BF9C433E4
	for <linux-integrity@archiver.kernel.org>; Thu, 13 Aug 2020 18:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11E1A20885
	for <linux-integrity@archiver.kernel.org>; Thu, 13 Aug 2020 18:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgHMSZl (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 13 Aug 2020 14:25:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:54154 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbgHMSZl (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Aug 2020 14:25:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CC7A9AE46;
        Thu, 13 Aug 2020 18:26:02 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        "Bruno E . O . Meneguele" <bmeneg@redhat.com>
Subject: [PATCH ima-evm-utils 4/9] install-swtpm.sh: Ignore certificate for download
Date:   Thu, 13 Aug 2020 20:25:27 +0200
Message-Id: <20200813182532.6931-5-pvorel@suse.cz>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200813182532.6931-1-pvorel@suse.cz>
References: <20200813182532.6931-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Some distros in Travis CI (e.g. Debian and Ubuntu) have problems with
downloading from sourceforge.net due unknown certificate issuer:

--2020-08-11 14:47:51--  https://sourceforge.net/projects/ibmswtpm2/files/ibmtpm1332.tar.gz/download
Resolving sourceforge.net (sourceforge.net)... 216.105.38.13
Connecting to sourceforge.net (sourceforge.net)|216.105.38.13|:443... connected.
ERROR: The certificate of 'sourceforge.net' is not trusted.
ERROR: The certificate of 'sourceforge.net' doesn't have a known issuer.

This is a preparation for future commit (moving to docker based Travis CI).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 tests/install-swtpm.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/install-swtpm.sh b/tests/install-swtpm.sh
index 071e9c9..2afcf17 100755
--- a/tests/install-swtpm.sh
+++ b/tests/install-swtpm.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 
 set -ex
-wget https://sourceforge.net/projects/ibmswtpm2/files/ibmtpm1332.tar.gz/download
+wget --no-check-certificate https://sourceforge.net/projects/ibmswtpm2/files/ibmtpm1332.tar.gz/download
 mkdir ibmtpm1332
 cd ibmtpm1332
 tar -xvzf ../download
-- 
2.28.0


Return-Path: <SRS0=/BKP=BX=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2410FC433EB
	for <linux-integrity@archiver.kernel.org>; Thu, 13 Aug 2020 18:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09C1120885
	for <linux-integrity@archiver.kernel.org>; Thu, 13 Aug 2020 18:25:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgHMSZm (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 13 Aug 2020 14:25:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:54178 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726593AbgHMSZm (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Aug 2020 14:25:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 061A0AE8C;
        Thu, 13 Aug 2020 18:26:03 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        "Bruno E . O . Meneguele" <bmeneg@redhat.com>
Subject: [PATCH ima-evm-utils 5/9] install-swtpm.sh: Update ibmtpm to version 1637
Date:   Thu, 13 Aug 2020 20:25:28 +0200
Message-Id: <20200813182532.6931-6-pvorel@suse.cz>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200813182532.6931-1-pvorel@suse.cz>
References: <20200813182532.6931-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 tests/install-swtpm.sh | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tests/install-swtpm.sh b/tests/install-swtpm.sh
index 2afcf17..2d8293a 100755
--- a/tests/install-swtpm.sh
+++ b/tests/install-swtpm.sh
@@ -1,9 +1,11 @@
 #!/bin/sh
-
 set -ex
-wget --no-check-certificate https://sourceforge.net/projects/ibmswtpm2/files/ibmtpm1332.tar.gz/download
-mkdir ibmtpm1332
-cd ibmtpm1332
+
+version=1637
+
+wget --no-check-certificate https://sourceforge.net/projects/ibmswtpm2/files/ibmtpm${version}.tar.gz/download
+mkdir ibmtpm$version
+cd ibmtpm$version
 tar -xvzf ../download
 cd src
 make -j$(nproc)
-- 
2.28.0


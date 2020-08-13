Return-Path: <SRS0=/BKP=BX=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B79C433EC
	for <linux-integrity@archiver.kernel.org>; Thu, 13 Aug 2020 18:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81EC7206B2
	for <linux-integrity@archiver.kernel.org>; Thu, 13 Aug 2020 18:25:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgHMSZn (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 13 Aug 2020 14:25:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:54180 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726578AbgHMSZm (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Aug 2020 14:25:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3175CAEA6;
        Thu, 13 Aug 2020 18:26:03 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        "Bruno E . O . Meneguele" <bmeneg@redhat.com>
Subject: [PATCH ima-evm-utils 6/9] Remove install-tpm2-tss.sh
Date:   Thu, 13 Aug 2020 20:25:29 +0200
Message-Id: <20200813182532.6931-7-pvorel@suse.cz>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200813182532.6931-1-pvorel@suse.cz>
References: <20200813182532.6931-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

tpm2-software is being packaged in major distros nowadays.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 tests/install-tpm2-tss.sh | 19 -------------------
 1 file changed, 19 deletions(-)
 delete mode 100755 tests/install-tpm2-tss.sh

diff --git a/tests/install-tpm2-tss.sh b/tests/install-tpm2-tss.sh
deleted file mode 100755
index 7a71b57..0000000
--- a/tests/install-tpm2-tss.sh
+++ /dev/null
@@ -1,19 +0,0 @@
-#!/bin/sh
-
-git clone https://github.com/tpm2-software/tpm2-tss.git
-cd tpm2-tss
-./bootstrap
-./configure
-make -j$(nproc)
-sudo make install
-sudo ldconfig
-cd ..
-rm -rf tpm2-tss
-
-git clone https://github.com/tpm2-software/tpm2-tools.git
-cd tpm2-tools
-./bootstrap && ./configure --prefix=/usr
-make -j$(nproc)
-sudo make install
-cd ..
-rm -rf tpm2-tools
-- 
2.28.0


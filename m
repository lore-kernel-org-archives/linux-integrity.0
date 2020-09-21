Return-Path: <SRS0=63nm=C6=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A3E8C43464
	for <linux-integrity@archiver.kernel.org>; Mon, 21 Sep 2020 12:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0359A20EDD
	for <linux-integrity@archiver.kernel.org>; Mon, 21 Sep 2020 12:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbgIUMtv (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 21 Sep 2020 08:49:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:60522 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726384AbgIUMtv (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 21 Sep 2020 08:49:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 985A2AEFE;
        Mon, 21 Sep 2020 12:50:26 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH ima-evm-utils 1/1] help: Add missing new line for --ignore-violations
Date:   Mon, 21 Sep 2020 14:49:41 +0200
Message-Id: <20200921124941.8355-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Fixes: 62534f2 ("Rename "--validate" to "--ignore-violations"")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 src/evmctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index c7f6732..1815f55 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -2467,7 +2467,7 @@ static void usage(void)
 		"      --caps         use custom Capabilities for EVM(unspecified: from FS, empty: do not use)\n"
 		"      --verify-sig   verify measurement list signatures\n"
 		"      --engine e     preload OpenSSL engine e (such as: gost)\n"
-		"      --ignore-violations ignore ToMToU measurement violations"
+		"      --ignore-violations ignore ToMToU measurement violations\n"
 		"  -v                 increase verbosity level\n"
 		"  -h, --help         display this help and exit\n"
 		"\n");
-- 
2.28.0


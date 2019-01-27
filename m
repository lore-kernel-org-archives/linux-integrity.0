Return-Path: <SRS0=3VMh=QD=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D573AC282C7
	for <linux-integrity@archiver.kernel.org>; Sun, 27 Jan 2019 02:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6FF421726
	for <linux-integrity@archiver.kernel.org>; Sun, 27 Jan 2019 02:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfA0CjU (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sat, 26 Jan 2019 21:39:20 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:48828 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbfA0CjU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 26 Jan 2019 21:39:20 -0500
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 7F06872CC61;
        Sun, 27 Jan 2019 05:39:18 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id 57A464A4A16;
        Sun, 27 Jan 2019 05:39:18 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH] ima-evm-utils: remove redundant call to OpenSSL_add_all_algorithms
Date:   Sun, 27 Jan 2019 05:39:16 +0300
Message-Id: <20190127023916.2425-1-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Because of call to OPENSSL_add_all_algorithms_conf() calling
OpenSSL_add_all_algorithms() is not needed. There was not be any
problems though because double initialization is permitted.
---
 src/libimaevm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/libimaevm.c b/src/libimaevm.c
index 7501303..b038d0c 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -995,7 +995,6 @@ int sign_hash(const char *hashalgo, const unsigned char *hash, int size, const c
 
 static void libinit()
 {
-	OpenSSL_add_all_algorithms();
 	OPENSSL_add_all_algorithms_conf();
 	ERR_load_crypto_strings();
 }
-- 
2.11.0


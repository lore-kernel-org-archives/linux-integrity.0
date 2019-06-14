Return-Path: <SRS0=mSwu=UN=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2107C31E49
	for <linux-integrity@archiver.kernel.org>; Fri, 14 Jun 2019 01:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B156020B7C
	for <linux-integrity@archiver.kernel.org>; Fri, 14 Jun 2019 01:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfFNBy2 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 13 Jun 2019 21:54:28 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:41132 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfFNBy2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Jun 2019 21:54:28 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 7CF2672CCAE;
        Fri, 14 Jun 2019 04:54:26 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id 5F5944A4AE7;
        Fri, 14 Jun 2019 04:54:26 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v4 1/5] ima-avm-utils: Make sure sig buffer is always MAX_SIGNATURE_SIZE
Date:   Fri, 14 Jun 2019 04:54:06 +0300
Message-Id: <20190614015410.26039-2-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190614015410.26039-1-vt@altlinux.org>
References: <20190614015410.26039-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Fix off-by-one error of the output buffer passed to sign_hash().

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 src/evmctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 15a7226..b6333bf 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -510,7 +510,7 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
 static int sign_evm(const char *file, const char *key)
 {
 	unsigned char hash[MAX_DIGEST_SIZE];
-	unsigned char sig[MAX_SIGNATURE_SIZE];
+	unsigned char sig[MAX_SIGNATURE_SIZE + 1];
 	int len, err;
 
 	len = calc_evm_hash(file, hash);
@@ -519,7 +519,7 @@ static int sign_evm(const char *file, const char *key)
 		return len;
 
 	len = sign_hash(params.hash_algo, hash, len, key, NULL, sig + 1);
-	assert(len < sizeof(sig));
+	assert(len < MAX_SIGNATURE_SIZE);
 	if (len <= 1)
 		return len;
 
-- 
2.11.0


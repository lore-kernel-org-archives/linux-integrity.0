Return-Path: <SRS0=quz6=VJ=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28646C742D7
	for <linux-integrity@archiver.kernel.org>; Fri, 12 Jul 2019 21:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07714208E4
	for <linux-integrity@archiver.kernel.org>; Fri, 12 Jul 2019 21:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbfGLV2o (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 12 Jul 2019 17:28:44 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:32796 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727994AbfGLV2o (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 12 Jul 2019 17:28:44 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id C863372CCD6;
        Sat, 13 Jul 2019 00:28:42 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id ABA2D4A4AE8;
        Sat, 13 Jul 2019 00:28:42 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v1 2/5] ima-evm-utils: Fix possible strcpy overflow
Date:   Sat, 13 Jul 2019 00:28:30 +0300
Message-Id: <20190712212833.29280-2-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190712212833.29280-1-vt@altlinux.org>
References: <20190712212833.29280-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

caps_str is passed from command line but copied into fixed-size buffer.
CID 229895.
---
 src/evmctl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 39bc3d9..e07cff4 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -409,8 +409,9 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
 		} else if (!strcmp(*xattrname, XATTR_NAME_CAPS) && (hmac_flags & HMAC_FLAG_CAPS_SET)) {
 			if (!caps_str)
 				continue;
-			strcpy(xattr_value, caps_str);
 			err = strlen(caps_str);
+			assert(err < sizeof(xattr_value));
+			strcpy(xattr_value, caps_str);
 		} else {
 			err = lgetxattr(file, *xattrname, xattr_value, sizeof(xattr_value));
 			if (err < 0) {
-- 
2.11.0


Return-Path: <SRS0=cYyd=R2=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39D7C4360F
	for <linux-integrity@archiver.kernel.org>; Sat, 23 Mar 2019 01:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1F04218E2
	for <linux-integrity@archiver.kernel.org>; Sat, 23 Mar 2019 01:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbfCWBmP (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 22 Mar 2019 21:42:15 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:58248 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727982AbfCWBmP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 Mar 2019 21:42:15 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 4A19D72CCAC;
        Sat, 23 Mar 2019 04:42:13 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id 0E9C84A4A16;
        Sat, 23 Mar 2019 04:42:12 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH 2/2] ima-evm-utils: try to load digest by its alias
Date:   Sat, 23 Mar 2019 04:41:52 +0300
Message-Id: <20190323014152.14701-3-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190323014152.14701-1-vt@altlinux.org>
References: <20190323014152.14701-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Primary names of the algorithms are different for OpenSSL and Kernel.
Allow to use both of them.

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 src/libimaevm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/src/libimaevm.c b/src/libimaevm.c
index bc7be1e..6783110 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -61,6 +61,7 @@
 #include "imaevm.h"
 #include "hash_info.h"
 
+/* Names that are primary for OpenSSL. */
 const char *const pkey_hash_algo[PKEY_HASH__LAST] = {
 	[PKEY_HASH_MD4]		= "md4",
 	[PKEY_HASH_MD5]		= "md5",
@@ -70,6 +71,12 @@ const char *const pkey_hash_algo[PKEY_HASH__LAST] = {
 	[PKEY_HASH_SHA384]	= "sha384",
 	[PKEY_HASH_SHA512]	= "sha512",
 	[PKEY_HASH_SHA224]	= "sha224",
+	[PKEY_HASH_STREEBOG_256] = "md_gost12_256",
+	[PKEY_HASH_STREEBOG_512] = "md_gost12_512",
+};
+
+/* Names that are primary for the kernel. */
+const char *const pkey_hash_algo_kern[PKEY_HASH__LAST] = {
 	[PKEY_HASH_STREEBOG_256] = "streebog256",
 	[PKEY_HASH_STREEBOG_512] = "streebog512",
 };
@@ -551,6 +558,11 @@ int get_hash_algo(const char *algo)
 		    !strcmp(algo, pkey_hash_algo[i]))
 			return i;
 
+	for (i = 0; i < PKEY_HASH__LAST; i++)
+		if (pkey_hash_algo_kern[i] &&
+		    !strcmp(algo, pkey_hash_algo_kern[i]))
+			return i;
+
 	/* iterate over algorithms provided by kernel-headers */
 	for (i = 0; i < HASH_ALGO__LAST; i++)
 		if (hash_algo_name[i] &&
-- 
2.11.0


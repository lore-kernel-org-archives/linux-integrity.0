Return-Path: <SRS0=ZzAI=OJ=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664F2C04EB8
	for <linux-integrity@archiver.kernel.org>; Fri, 30 Nov 2018 20:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 315A620863
	for <linux-integrity@archiver.kernel.org>; Fri, 30 Nov 2018 20:05:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 315A620863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbeLAHQM (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sat, 1 Dec 2018 02:16:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51878 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbeLAHQM (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 1 Dec 2018 02:16:12 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 706EF3E2CB;
        Fri, 30 Nov 2018 20:05:48 +0000 (UTC)
Received: from localhost (ovpn-116-19.gru2.redhat.com [10.97.116.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F161C104C53F;
        Fri, 30 Nov 2018 20:05:47 +0000 (UTC)
From:   "Bruno E. O. Meneguele" <bmeneg@redhat.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.vnet.ibm.com, dmitry.kasatkin@gmail.com
Subject: [PATCH] ima-evm-utils: libimaevm: get key description out of verbose condition
Date:   Fri, 30 Nov 2018 18:05:47 -0200
Message-Id: <20181130200547.20490-1-bmeneg@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 30 Nov 2018 20:05:48 +0000 (UTC)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Key description in keyring is being filled with memory garbage during import
process if the LOG_LEVEL is not satisfied (using '-vv').

Testing in kernels without trusted keyring support, and importing a v1 (RSA) key
pair, the kernel fails to find the key since it looks for the key description,
which is not found due to this issue:

    "digsig: key not found, id: DD0558FEB7DDBD26"

Looking at:
    # keyctl show
    Session Keyring
     635748007 --alswrv      0     0  keyring: _ses
     673181018 --alswrv      0 65534   \_ keyring: _uid.0
     360651479 --alswrv      0     0       \_ keyring: _ima
     499360916 --alswrv      0     0       |   \_ user: .N=
     266933436 --alswrv      0     0       |   \_ user: B641632DA94DEE26

Key id 499360916 and 266933436 are both the same key, but the first was added
without '-vv' in the command line, while the second one was using it.

Signed-off-by: Bruno E. O. Meneguele <bmeneg@redhat.com>
---
 src/libimaevm.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/src/libimaevm.c b/src/libimaevm.c
index 6fa0ed4..b6f9b9f 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -672,12 +672,11 @@ void calc_keyid_v1(uint8_t *keyid, char *str, const unsigned char *pkey, int len
 	memcpy(keyid, sha1 + 12, 8);
 	log_debug("keyid: ");
 	log_debug_dump(keyid, 8);
+	id = __be64_to_cpup((__be64 *) keyid);
+	sprintf(str, "%llX", (unsigned long long)id);
 
-	if (params.verbose > LOG_INFO) {
-		id = __be64_to_cpup((__be64 *) keyid);
-		sprintf(str, "%llX", (unsigned long long)id);
+	if (params.verbose > LOG_INFO)
 		log_info("keyid-v1: %s\n", str);
-	}
 }
 
 void calc_keyid_v2(uint32_t *keyid, char *str, RSA *key)
@@ -694,11 +693,10 @@ void calc_keyid_v2(uint32_t *keyid, char *str, RSA *key)
 	memcpy(keyid, sha1 + 16, 4);
 	log_debug("keyid: ");
 	log_debug_dump(keyid, 4);
+	sprintf(str, "%x", __be32_to_cpup(keyid));
 
-	if (params.verbose > LOG_INFO) {
-		sprintf(str, "%x", __be32_to_cpup(keyid));
+	if (params.verbose > LOG_INFO)
 		log_info("keyid: %s\n", str);
-	}
 
 	free(pkey);
 }
-- 
2.19.1


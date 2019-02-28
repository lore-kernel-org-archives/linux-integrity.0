Return-Path: <SRS0=BEGI=RD=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5892CC43381
	for <linux-integrity@archiver.kernel.org>; Thu, 28 Feb 2019 23:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2879F218B0
	for <linux-integrity@archiver.kernel.org>; Thu, 28 Feb 2019 23:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbfB1Xak (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 28 Feb 2019 18:30:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:40392 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726631AbfB1Xak (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 28 Feb 2019 18:30:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 87183B645;
        Thu, 28 Feb 2019 23:30:39 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-kselftest@vger.kernel.org, shuah <shuah@kernel.org>
Subject: [PATCH] selftests/ima: Add missing '=y' to config options
Date:   Fri,  1 Mar 2019 00:30:30 +0100
Message-Id: <20190228233030.10480-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

so the file can be used as kernel config snippet.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 tools/testing/selftests/ima/config | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/ima/config b/tools/testing/selftests/ima/config
index 6bc86d4d9bb4..9b968cd55199 100644
--- a/tools/testing/selftests/ima/config
+++ b/tools/testing/selftests/ima/config
@@ -1,4 +1,4 @@
-CONFIG_IMA_APPRAISE
-CONFIG_IMA_ARCH_POLICY
-CONFIG_SECURITYFS
-CONFIG_KEXEC_VERIFY_SIG
+CONFIG_IMA_APPRAISE=y
+CONFIG_IMA_ARCH_POLICY=y
+CONFIG_SECURITYFS=y
+CONFIG_KEXEC_VERIFY_SIG=y
-- 
2.20.1


Return-Path: <SRS0=/BKP=BX=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ECCBC433E8
	for <linux-integrity@archiver.kernel.org>; Thu, 13 Aug 2020 18:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E581E206B2
	for <linux-integrity@archiver.kernel.org>; Thu, 13 Aug 2020 18:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgHMSZm (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 13 Aug 2020 14:25:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:54188 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbgHMSZm (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Aug 2020 14:25:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 891C5AEAB;
        Thu, 13 Aug 2020 18:26:03 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        "Bruno E . O . Meneguele" <bmeneg@redhat.com>
Subject: [PATCH ima-evm-utils 8/9] tests: Require cmp
Date:   Thu, 13 Aug 2020 20:25:31 +0200
Message-Id: <20200813182532.6931-9-pvorel@suse.cz>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200813182532.6931-1-pvorel@suse.cz>
References: <20200813182532.6931-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

cmp is not by default installed on some containers
(unlike other tools e.g. cut, tr from coreutils or grep).

Also cmp implementation from busybox doesn't support -b, thus detect it.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 tests/sign_verify.test | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tests/sign_verify.test b/tests/sign_verify.test
index 118c3f6..4f08bed 100755
--- a/tests/sign_verify.test
+++ b/tests/sign_verify.test
@@ -18,7 +18,14 @@
 cd "$(dirname "$0")" || exit 1
 PATH=../src:$PATH
 source ./functions.sh
-_require evmctl openssl xxd getfattr
+
+_require cmp evmctl getfattr openssl xxd
+
+if cmp -b 2>&1 | grep -q "invalid option"; then
+	echo "cmp does not support -b (cmp from busybox?) Use cmp from diffutils"
+	exit "$HARDFAIL"
+fi
+
 ./gen-keys.sh >/dev/null 2>&1
 
 trap _report_exit EXIT
-- 
2.28.0


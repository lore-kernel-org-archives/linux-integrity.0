Return-Path: <SRS0=mqgK=SH=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217C0C282DC
	for <linux-integrity@archiver.kernel.org>; Fri,  5 Apr 2019 16:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3DA920989
	for <linux-integrity@archiver.kernel.org>; Fri,  5 Apr 2019 16:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731153AbfDEQwh (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 5 Apr 2019 12:52:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:52552 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730587AbfDEQwh (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Apr 2019 12:52:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 67593B112;
        Fri,  5 Apr 2019 16:52:36 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Ignaz Forster <iforster@suse.de>, Fabian Vogt <FVogt@suse.com>,
        Marcus Meissner <meissner@suse.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v2 1/3] ima: Call test's cleanup inside ima_setup.sh cleanup
Date:   Fri,  5 Apr 2019 18:52:23 +0200
Message-Id: <20190405165225.27216-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190405165225.27216-1-pvorel@suse.cz>
References: <20190405165225.27216-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

to work the same way as setup

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/security/integrity/ima/tests/ima_setup.sh  | 6 +++++-
 .../kernel/security/integrity/ima/tests/ima_violations.sh   | 2 --
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index 52551190a..cbded42c2 100644
--- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -20,7 +20,8 @@
 TST_TESTFUNC="test"
 TST_SETUP_CALLER="$TST_SETUP"
 TST_SETUP="ima_setup"
-TST_CLEANUP="${TST_CLEANUP:-ima_cleanup}"
+TST_CLEANUP_CALLER="$TST_CLEANUP"
+TST_CLEANUP="ima_cleanup"
 TST_NEEDS_TMPDIR=1
 TST_NEEDS_ROOT=1
 
@@ -95,6 +96,9 @@ ima_setup()
 ima_cleanup()
 {
 	local dir
+
+	[ -n "$TST_CLEANUP_CALLER" ] && $TST_CLEANUP_CALLER
+
 	for dir in $UMOUNT; do
 		umount $dir
 	done
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
index 74223c221..a44bd1230 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
@@ -51,8 +51,6 @@ cleanup()
 {
 	[ "$PRINTK_RATE_LIMIT" != "0" ] && \
 		sysctl -wq kernel.printk_ratelimit=$PRINTK_RATE_LIMIT
-
-	ima_cleanup
 }
 
 open_file_read()
-- 
2.21.0


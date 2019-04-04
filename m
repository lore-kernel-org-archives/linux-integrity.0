Return-Path: <SRS0=GWgT=SG=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5172C4360F
	for <linux-integrity@archiver.kernel.org>; Thu,  4 Apr 2019 18:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3BAB206DD
	for <linux-integrity@archiver.kernel.org>; Thu,  4 Apr 2019 18:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfDDSXa (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 4 Apr 2019 14:23:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:42652 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726698AbfDDSXa (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Apr 2019 14:23:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F0D98B02F;
        Thu,  4 Apr 2019 18:23:28 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH] doc/kernel-parameters.txt: Deprecate ima_appraise_tcb
Date:   Thu,  4 Apr 2019 20:23:22 +0200
Message-Id: <20190404182322.25646-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 Documentation/admin-guide/kernel-parameters.txt | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 2b8ee90bb644..45147fc40a57 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1585,7 +1585,7 @@
 			Format: { "off" | "enforce" | "fix" | "log" }
 			default: "enforce"
 
-	ima_appraise_tcb [IMA]
+	ima_appraise_tcb [IMA] Deprecated.  Use ima_policy= instead.
 			The builtin appraise policy appraises all files
 			owned by uid=0.
 
@@ -1612,8 +1612,7 @@
 			uid=0.
 
 			The "appraise_tcb" policy appraises the integrity of
-			all files owned by root. (This is the equivalent
-			of ima_appraise_tcb.)
+			all files owned by root.
 
 			The "secure_boot" policy appraises the integrity
 			of files (eg. kexec kernel image, kernel modules,
-- 
2.21.0


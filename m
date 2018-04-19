Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:38421 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753484AbeDSTz2 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Apr 2018 15:55:28 -0400
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Subject: [RFC PATCH v3 04/10] ima/ima_policy.sh: Load whole policy with cat
Date: Thu, 19 Apr 2018 21:54:57 +0200
Message-Id: <20180419195503.7194-5-pvorel@suse.cz>
In-Reply-To: <20180419195503.7194-1-pvorel@suse.cz>
References: <20180419195503.7194-1-pvorel@suse.cz>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Originally writing the policy was done one rule at a time, but that's
not required since kernel 2.6.35 (6ccd04563005 "ima: handle multiple rules per write")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
Suggested-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 testcases/kernel/security/integrity/ima/tests/ima_policy.sh | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_policy.sh b/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
index 35eb4055b..1c4a0b922 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
@@ -53,17 +53,9 @@ load_policy()
 	exec 2>/dev/null 4>$IMA_POLICY
 	[ $? -eq 0 ] || exit 1
 
-	cat $1 |
-	while read line; do
-		if [ "${line#\#}" = "${line}" ]; then
-			echo "$line" >&4 2> /dev/null
-			if [ $? -ne 0 ]; then
-				exec 4>&-
-				return 1
-			fi
-		fi
-	done
+	cat $1 >&4 2> /dev/null
 	ret=$?
+	exec 4>&-
 
 	[ $ret -eq 0 ] && \
 		tst_res TINFO "IMA policy updated, please reboot after testing to restore settings"
-- 
2.16.3

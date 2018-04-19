Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:38430 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752558AbeDSTza (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Apr 2018 15:55:30 -0400
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Subject: [RFC PATCH v3 07/10] ima/ima_mmap: Reduce sleep + log it
Date: Thu, 19 Apr 2018 21:55:00 +0200
Message-Id: <20180419195503.7194-8-pvorel@suse.cz>
In-Reply-To: <20180419195503.7194-1-pvorel@suse.cz>
References: <20180419195503.7194-1-pvorel@suse.cz>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Sleep reduced to 3s (30s is way too much).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/security/integrity/ima/src/ima_mmap.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/security/integrity/ima/src/ima_mmap.c b/testcases/kernel/security/integrity/ima/src/ima_mmap.c
index 335f8525c..9045e79a0 100644
--- a/testcases/kernel/security/integrity/ima/src/ima_mmap.c
+++ b/testcases/kernel/security/integrity/ima/src/ima_mmap.c
@@ -25,6 +25,8 @@
 char *TCID = "ima_mmap";
 int TST_TOTAL = 1;
 
+#define SLEEP_AFTER_CLOSE 3
+
 int main(int argc, char *argv[])
 {
 	int fd;
@@ -47,7 +49,10 @@ int main(int argc, char *argv[])
 		return (-1);
 	}
 	close(fd);
-	sleep(30);
+
+	tst_resm(TINFO, "sleep %ds", SLEEP_AFTER_CLOSE);
+	sleep(SLEEP_AFTER_CLOSE);
+
 	if (munmap(file, 1024) < 0) {
 		perror("unmap");
 		return (-1);
-- 
2.16.3

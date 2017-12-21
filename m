Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:46357 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751220AbdLUP4F (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 21 Dec 2017 10:56:05 -0500
From: Vasyl Gomonovych <gomonovych@gmail.com>
To: zohar@linux.vnet.ibm.com, dmitry.kasatkin@gmail.com,
        james.l.morris@oracle.com, serge@hallyn.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, gomonovych@gmail.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] ima: Fix warn potential negative subtraction from max
Date: Thu, 21 Dec 2017 16:55:53 +0100
Message-Id: <1513871754-13943-1-git-send-email-gomonovych@gmail.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Found by smatch:
security/integrity/ima/ima_queue.c:122 ima_add_digest_entry() warn:
potential negative subtraction from max '(~0)- size'

Signed-off-by: Vasyl Gomonovych <gomonovych@gmail.com>
---
 security/integrity/ima/ima_queue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index a02a86d51102..446018478b81 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -116,7 +116,7 @@ static int ima_add_digest_entry(struct ima_template_entry *entry,
 	}
 
 	if (binary_runtime_size != ULONG_MAX) {
-		int size;
+		unsigned int size;
 
 		size = get_binary_runtime_size(entry);
 		binary_runtime_size = (binary_runtime_size < ULONG_MAX - size) ?
-- 
1.9.1

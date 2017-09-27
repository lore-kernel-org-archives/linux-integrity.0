Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:46623 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751088AbdI0Gkx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 Sep 2017 02:40:53 -0400
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org, kernel@pengutronix.de,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH] ima: Use i_version only when filesystem supports it
Date: Wed, 27 Sep 2017 08:39:54 +0200
Message-Id: <20170927063954.8475-1-s.hauer@pengutronix.de>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

i_version is only supported by a filesystem when the SB_I_VERSION
flag is set. This patch tests for the SB_I_VERSION flag before using
i_version. If we can't use i_version to detect a file change then we
must assume the file has changed in the last_writer path and remeasure
it.

On filesystems without i_version support IMA used to measure a file
only once and didn't detect any changes to a file. With this patch
IMA now works properly on these filesystems.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 security/integrity/ima/ima_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 2aebb7984437..0d9b9beb0dd2 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -123,7 +123,8 @@ static void ima_check_last_writer(struct integrity_iint_cache *iint,
 
 	inode_lock(inode);
 	if (atomic_read(&inode->i_writecount) == 1) {
-		if ((iint->version != inode->i_version) ||
+		if (!IS_I_VERSION(inode) ||
+		    (iint->version != inode->i_version) ||
 		    (iint->flags & IMA_NEW_FILE)) {
 			iint->flags &= ~(IMA_DONE_MASK | IMA_NEW_FILE);
 			iint->measured_pcrs = 0;
-- 
2.11.0

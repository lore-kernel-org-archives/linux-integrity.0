Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:52071 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755053AbeDTN3J (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Apr 2018 09:29:09 -0400
From: Petr Vorel <pvorel@suse.cz>
To: linux-integrity@vger.kernel.org
Cc: Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH] ima: Reflect correct permissions for policy
Date: Fri, 20 Apr 2018 15:28:57 +0200
Message-Id: <20180420132857.31332-1-pvorel@suse.cz>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Kernel configured as CONFIG_IMA_READ_POLICY=y && CONFIG_IMA_WRITE_POLICY=n
keeps 0600 mode after loading policy. Remove write permission to state
that policy file no longer be written.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 security/integrity/ima/ima_fs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index fa540c0469da..c1265127d1b6 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -434,6 +434,8 @@ static int ima_release_policy(struct inode *inode, struct file *file)
 	ima_policy = NULL;
 #elif defined(CONFIG_IMA_WRITE_POLICY)
 	clear_bit(IMA_FS_BUSY, &ima_fs_flags);
+#elif defined(CONFIG_IMA_READ_POLICY)
+	inode->i_mode &= ~S_IWUSR;
 #endif
 	return 0;
 }
-- 
2.12.3

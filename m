Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:42332 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751532AbeE0WPH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 27 May 2018 18:15:07 -0400
From: Colin King <colin.king@canonical.com>
To: Matthew Garrett <mjg59@google.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] EVM: fix memory leak of temporary buffer 'temp'
Date: Sun, 27 May 2018 23:15:02 +0100
Message-Id: <20180527221502.25073-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

The allocation of 'temp' is not kfree'd and hence there is a memory
leak on each call of evm_read_xattrs.  Fix this by kfree'ing it
after copying data from it back to the user space buffer 'buf'.

Detected by CoverityScan, CID#1469386 ("Resource Leak")

Fixes: fa516b66a1bf ("EVM: Allow runtime modification of the set of verified xattrs")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 security/integrity/evm/evm_secfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/integrity/evm/evm_secfs.c b/security/integrity/evm/evm_secfs.c
index a7a0a1acae99..fb8bc950aceb 100644
--- a/security/integrity/evm/evm_secfs.c
+++ b/security/integrity/evm/evm_secfs.c
@@ -158,6 +158,8 @@ static ssize_t evm_read_xattrs(struct file *filp, char __user *buf,
 	mutex_unlock(&xattr_list_mutex);
 	rc = simple_read_from_buffer(buf, count, ppos, temp, strlen(temp));
 
+	kfree(temp);
+
 	return rc;
 }
 
-- 
2.17.0

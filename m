Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from aserp2120.oracle.com ([141.146.126.78]:56864 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751258AbeFAIAZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 1 Jun 2018 04:00:25 -0400
Date: Fri, 1 Jun 2018 11:00:05 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Matthew Garrett <mjg59@google.com>
Cc: James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] EVM: unlock on error path in evm_read_xattrs()
Message-ID: <20180601075946.wpyly2mgmaynfm4c@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

We need to unlock before returning on this error path.

Fixes: fa516b66a1bf ("EVM: Allow runtime modification of the set of verified xattrs")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/security/integrity/evm/evm_secfs.c b/security/integrity/evm/evm_secfs.c
index a7a0a1acae99..6d3b34ae8499 100644
--- a/security/integrity/evm/evm_secfs.c
+++ b/security/integrity/evm/evm_secfs.c
@@ -147,8 +147,10 @@ static ssize_t evm_read_xattrs(struct file *filp, char __user *buf,
 		size += strlen(xattr->name) + 1;
 
 	temp = kmalloc(size + 1, GFP_KERNEL);
-	if (!temp)
+	if (!temp) {
+		mutex_unlock(&xattr_list_mutex);
 		return -ENOMEM;
+	}
 
 	list_for_each_entry(xattr, &evm_config_xattrnames, list) {
 		sprintf(temp + offset, "%s\n", xattr->name);

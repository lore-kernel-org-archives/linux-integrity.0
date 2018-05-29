Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from aserp2130.oracle.com ([141.146.126.79]:33276 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934263AbeE2NLs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 May 2018 09:11:48 -0400
Date: Tue, 29 May 2018 16:11:28 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Matthew Garrett <mjg59@google.com>
Cc: James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] EVM: prevent array underflow in evm_write_xattrs()
Message-ID: <20180529131128.3rkzzv66uy6h5ts7@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1527597092.10176.17.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

If the user sets xattr->name[0] to NUL then we would read one character
before the start of the array.  This bug seems harmless as far as I can
see but perhaps it would trigger a warning in KASAN.

Fixes: fa516b66a1bf ("EVM: Allow runtime modification of the set of verified xattrs")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
The user can pass a zeroed buffer to memdup_user_nul() so we can't rely
on "count" to test this.

diff --git a/security/integrity/evm/evm_secfs.c b/security/integrity/evm/evm_secfs.c
index a7a0a1acae99..94c739180a0b 100644
--- a/security/integrity/evm/evm_secfs.c
+++ b/security/integrity/evm/evm_secfs.c
@@ -207,7 +207,7 @@ static ssize_t evm_write_xattrs(struct file *file, const char __user *buf,
 
 	/* Remove any trailing newline */
 	len = strlen(xattr->name);
-	if (xattr->name[len-1] == '\n')
+	if (len && xattr->name[len-1] == '\n')
 		xattr->name[len-1] = '\0';
 
 	if (strcmp(xattr->name, ".") == 0) {

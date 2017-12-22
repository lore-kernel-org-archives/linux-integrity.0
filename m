Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:43814 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756214AbdLVObc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 Dec 2017 09:31:32 -0500
Received: by mail-wm0-f65.google.com with SMTP id n138so22132059wmg.2
        for <linux-integrity@vger.kernel.org>; Fri, 22 Dec 2017 06:31:31 -0800 (PST)
From: Dongsu Park <dongsu@kinvolk.io>
To: linux-kernel@vger.kernel.org
Cc: containers@lists.linux-foundation.org,
        Alban Crequy <alban@kinvolk.io>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Dongsu Park <dongsu@kinvolk.io>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James Morris <james.l.morris@oracle.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        "Serge E. Hallyn" <serge@hallyn.com>
Subject: [PATCH 11/11] evm: Don't update hmacs in user ns mounts
Date: Fri, 22 Dec 2017 15:32:35 +0100
Message-Id: <1f2233a1a028f1eb1e9bea7d06efa6d34e69e752.1512041070.git.dongsu@kinvolk.io>
In-Reply-To: <cover.1512741134.git.dongsu@kinvolk.io>
References: <cover.1512741134.git.dongsu@kinvolk.io>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

From: Seth Forshee <seth.forshee@canonical.com>

The kernel should not calculate new hmacs for mounts done by
non-root users. Update evm_calc_hmac_or_hash() to refuse to
calculate new hmacs for mounts for non-init user namespaces.

Cc: linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: James Morris <james.l.morris@oracle.com>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
Signed-off-by: Dongsu Park <dongsu@kinvolk.io>
---
 security/integrity/evm/evm_crypto.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index bcd64baf..729f4545 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -190,7 +190,8 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
 	int error;
 	int size;
 
-	if (!(inode->i_opflags & IOP_XATTR))
+	if (!(inode->i_opflags & IOP_XATTR) ||
+	    inode->i_sb->s_user_ns != &init_user_ns)
 		return -EOPNOTSUPP;
 
 	desc = init_desc(type);
-- 
2.13.6

Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52674 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751381AbdKCPIy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Nov 2017 11:08:54 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vA3F8n6K032998
        for <linux-integrity@vger.kernel.org>; Fri, 3 Nov 2017 11:08:54 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2e0t1rk1n7-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 03 Nov 2017 11:08:51 -0400
Received: from localhost
        by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Fri, 3 Nov 2017 15:08:40 -0000
Subject: [PATCH] MAINTAINERS: update the IMA, EVM, trusted-keys,
 encrypted-keys entries
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: James Morris <jmorris@namei.org>
Cc: linux-security-module <linux-security-module@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>
Date: Fri, 03 Nov 2017 11:08:36 -0400
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1509721716.3416.51.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi James,

With all the changes to MAINTAINERS there's a conflict with the patch
in my next branch.  Could you carry this patch?

thanks,

Mimi
---

Update the mailing list information.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 MAINTAINERS | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2c43cfabd438..1b41b99be98e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5213,8 +5213,7 @@ F:	fs/ext4/
 
 Extended Verification Module (EVM)
 M:	Mimi Zohar <zohar@linux.vnet.ibm.com>
-L:	linux-ima-devel@lists.sourceforge.net
-L:	linux-security-module@vger.kernel.org
+L:	linux-integrity@vger.kernel.org
 S:	Supported
 F:	security/integrity/evm/
 
@@ -6840,9 +6839,7 @@ L:	linux-crypto@vger.kernel.org
 INTEGRITY MEASUREMENT ARCHITECTURE (IMA)
 M:	Mimi Zohar <zohar@linux.vnet.ibm.com>
 M:	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
-L:	linux-ima-devel@lists.sourceforge.net
-L:	linux-ima-user@lists.sourceforge.net
-L:	linux-security-module@vger.kernel.org
+L:	linux-integrity@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
 S:	Supported
 F:	security/integrity/ima/
@@ -7625,7 +7622,7 @@ F:	kernel/kexec*
 
 KEYS-ENCRYPTED
 M:	Mimi Zohar <zohar@linux.vnet.ibm.com>
-L:	linux-security-module@vger.kernel.org
+L:	linux-integrity@vger.kernel.org
 L:	keyrings@vger.kernel.org
 S:	Supported
 F:	Documentation/security/keys/trusted-encrypted.rst
@@ -7634,7 +7631,7 @@ F:	security/keys/encrypted-keys/
 
 KEYS-TRUSTED
 M:	Mimi Zohar <zohar@linux.vnet.ibm.com>
-L:	linux-security-module@vger.kernel.org
+L:	linux-integrity@vger.kernel.org
 L:	keyrings@vger.kernel.org
 S:	Supported
 F:	Documentation/security/keys/trusted-encrypted.rst
-- 
2.7.4

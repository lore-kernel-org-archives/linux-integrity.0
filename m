Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-oi0-f74.google.com ([209.85.218.74]:54111 "EHLO
        mail-oi0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751081AbdJMWJh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 13 Oct 2017 18:09:37 -0400
Received: by mail-oi0-f74.google.com with SMTP id q4so6982552oic.12
        for <linux-integrity@vger.kernel.org>; Fri, 13 Oct 2017 15:09:37 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 13 Oct 2017 15:09:25 -0700
Message-Id: <20171013220925.6420-1-mjg59@google.com>
Subject: [PATCH] EVM: Include security.apparmor in EVM measurements
From: Matthew Garrett <mjg59@google.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.vnet.ibm.com, john.johansen@canonical.com,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Apparmor will be gaining support for security.apparmor labels, and it
would be helpful to include these in EVM validation now so appropriate
signatures can be generated even before full support is merged.

Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 include/uapi/linux/xattr.h        | 3 +++
 security/integrity/evm/evm_main.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/include/uapi/linux/xattr.h b/include/uapi/linux/xattr.h
index 1590c49cae57..e630b9cd70cb 100644
--- a/include/uapi/linux/xattr.h
+++ b/include/uapi/linux/xattr.h
@@ -65,6 +65,9 @@
 #define XATTR_NAME_SMACKTRANSMUTE XATTR_SECURITY_PREFIX XATTR_SMACK_TRANSMUTE
 #define XATTR_NAME_SMACKMMAP XATTR_SECURITY_PREFIX XATTR_SMACK_MMAP
 
+#define XATTR_APPARMOR_SUFFIX "apparmor"
+#define XATTR_NAME_APPARMOR XATTR_SECURITY_PREFIX XATTR_APPARMOR_SUFFIX
+
 #define XATTR_CAPS_SUFFIX "capability"
 #define XATTR_NAME_CAPS XATTR_SECURITY_PREFIX XATTR_CAPS_SUFFIX
 
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 40bf3a20605d..78a5b1fddfc7 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -49,6 +49,9 @@ char *evm_config_xattrnames[] = {
 	XATTR_NAME_SMACKMMAP,
 #endif
 #endif
+#ifdef CONFIG_SECURITY_APPARMOR
+	XATTR_NAME_APPARMOR,
+#endif
 #ifdef CONFIG_IMA_APPRAISE
 	XATTR_NAME_IMA,
 #endif
-- 
2.15.0.rc0.271.g36b669edcc-goog

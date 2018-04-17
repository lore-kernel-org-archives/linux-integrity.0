Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-yw0-f202.google.com ([209.85.161.202]:48064 "EHLO
        mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751879AbeDQW4R (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 Apr 2018 18:56:17 -0400
Received: by mail-yw0-f202.google.com with SMTP id i204so13456005ywb.14
        for <linux-integrity@vger.kernel.org>; Tue, 17 Apr 2018 15:56:17 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 17 Apr 2018 15:56:01 -0700
In-Reply-To: <20180417225601.6965-1-mjg59@google.com>
Message-Id: <20180417225601.6965-2-mjg59@google.com>
References: <20180417225601.6965-1-mjg59@google.com>
Subject: [USER] [PATCH 2/2] Add security.apparmor to the set of extended
 attributes used by EVM
From: Matthew Garrett <mjg59@google.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.vnet.ibm.com, Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

The kernel is taking security.apparmor into account when validating EVM,
so evmctl should be doing the same.

Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 src/evmctl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/evmctl.c b/src/evmctl.c
index 43d261f..e350f69 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -69,6 +69,7 @@
 static char *evm_default_xattrs[] = {
 	XATTR_NAME_SELINUX,
 	XATTR_NAME_SMACK,
+	XATTR_NAME_APPARMOR,
 	XATTR_NAME_IMA,
 	XATTR_NAME_CAPS,
 	NULL
@@ -80,6 +81,7 @@ static char *evm_extra_smack_xattrs[] = {
 	XATTR_NAME_SMACKEXEC,
 	XATTR_NAME_SMACKTRANSMUTE,
 	XATTR_NAME_SMACKMMAP,
+	XATTR_NAME_APPARMOR,
 	XATTR_NAME_IMA,
 	XATTR_NAME_CAPS,
 	NULL
-- 
2.17.0.484.g0c8726318c-goog

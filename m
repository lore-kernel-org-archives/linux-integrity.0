Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbeJDHHk (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Oct 2018 03:07:40 -0400
From: Eric Biggers <ebiggers@kernel.org>
To: linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Subject: [PATCH v2] security/integrity: remove unnecessary 'init_keyring' variable
Date: Wed,  3 Oct 2018 17:15:44 -0700
Message-Id: <20181004001544.161035-1-ebiggers@kernel.org>
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

The 'init_keyring' variable actually just gave the value of
CONFIG_INTEGRITY_TRUSTED_KEYRING.  We should check the config option
directly instead.  No change in behavior; this just simplifies the code.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 security/integrity/digsig.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index 9bb0a7f2863e3..22110fa5ea3ab 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -37,12 +37,6 @@ static const char *keyring_name[INTEGRITY_KEYRING_MAX] = {
 	"_module",
 };
 
-#ifdef CONFIG_INTEGRITY_TRUSTED_KEYRING
-static bool init_keyring __initdata = true;
-#else
-static bool init_keyring __initdata;
-#endif
-
 #ifdef CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
 #define restrict_link_to_ima restrict_link_by_builtin_and_secondary_trusted
 #else
@@ -85,7 +79,7 @@ int __init integrity_init_keyring(const unsigned int id)
 	struct key_restriction *restriction;
 	int err = 0;
 
-	if (!init_keyring)
+	if (!IS_ENABLED(CONFIG_INTEGRITY_TRUSTED_KEYRING))
 		return 0;
 
 	restriction = kzalloc(sizeof(struct key_restriction), GFP_KERNEL);
-- 
2.19.0.605.g01d371f741-goog

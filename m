Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-it0-f74.google.com ([209.85.214.74]:50016 "EHLO
        mail-it0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752123AbdJKTLX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Oct 2017 15:11:23 -0400
Received: by mail-it0-f74.google.com with SMTP id a125so2037827ita.8
        for <linux-integrity@vger.kernel.org>; Wed, 11 Oct 2017 12:11:23 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 11 Oct 2017 12:11:12 -0700
In-Reply-To: <20171011191014.4426-1-mjg59@google.com>
Message-Id: <20171011191112.4861-1-mjg59@google.com>
References: <20171011191014.4426-1-mjg59@google.com>
Subject: [PATCH V2] EVM: Only complain about a missing HMAC key once
From: Matthew Garrett <mjg59@google.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.vnet.ibm.com, Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

A system can validate EVM digital signatures without requiring an HMAC
key, but every EVM validation will generate a kernel error. Change this
so we only generate an error once.

Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 security/integrity/evm/evm_crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index 6435f12b0067..abe53b28f3e3 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -80,7 +80,7 @@ static struct shash_desc *init_desc(char type)
 
 	if (type == EVM_XATTR_HMAC) {
 		if (!(evm_initialized & EVM_INIT_HMAC)) {
-			pr_err("HMAC key is not set\n");
+			pr_err_once("HMAC key is not set\n");
 			return ERR_PTR(-ENOKEY);
 		}
 		tfm = &hmac_tfm;
-- 
2.15.0.rc0.271.g36b669edcc-goog

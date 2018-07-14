Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:50965 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbeGNQpx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 14 Jul 2018 12:45:53 -0400
From: Colin King <colin.king@canonical.com>
To: James Bottomley <jejb@linux.vnet.ibm.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] keys: trusted: remove redundant variable keyhndl
Date: Sat, 14 Jul 2018 17:26:11 +0100
Message-Id: <20180714162611.8381-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

Variable keyhndl is being assigned but is never used hence it is
redundant and can be removed.

Cleans up clang warning:
warning: variable 'keyhndl' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 security/keys/trusted.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/security/keys/trusted.c b/security/keys/trusted.c
index b69d3b1777c2..0400c1a00467 100644
--- a/security/keys/trusted.c
+++ b/security/keys/trusted.c
@@ -585,7 +585,6 @@ static int tpm_unseal(struct tpm_buf *tb,
 	uint32_t authhandle2 = 0;
 	unsigned char cont = 0;
 	uint32_t ordinal;
-	uint32_t keyhndl;
 	int ret;
 
 	/* sessions for unsealing key and data */
@@ -601,7 +600,6 @@ static int tpm_unseal(struct tpm_buf *tb,
 	}
 
 	ordinal = htonl(TPM_ORD_UNSEAL);
-	keyhndl = htonl(SRKHANDLE);
 	ret = tpm_get_random(NULL, nonceodd, TPM_NONCE_SIZE);
 	if (ret != TPM_NONCE_SIZE) {
 		pr_info("trusted_key: tpm_get_random failed (%d)\n", ret);
-- 
2.17.1

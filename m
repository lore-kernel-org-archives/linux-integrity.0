Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54476 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753802AbeCPUjk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Mar 2018 16:39:40 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2GKdEUJ035567
        for <linux-integrity@vger.kernel.org>; Fri, 16 Mar 2018 16:39:40 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2grhkfyy6j-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 16 Mar 2018 16:39:39 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <bauerman@linux.vnet.ibm.com>;
        Fri, 16 Mar 2018 14:39:39 -0600
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jessica Yu <jeyu@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "AKASHI, Takahiro" <takahiro.akashi@linaro.org>,
        Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: [PATCH v6 03/12] PKCS#7: Introduce pkcs7_get_digest()
Date: Fri, 16 Mar 2018 17:38:28 -0300
In-Reply-To: <20180316203837.10174-1-bauerman@linux.vnet.ibm.com>
References: <20180316203837.10174-1-bauerman@linux.vnet.ibm.com>
Message-Id: <20180316203837.10174-4-bauerman@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

IMA will need to access the digest of the PKCS7 message (as calculated by
the kernel) before the signature is verified, so introduce
pkcs7_get_digest() for that purpose.

Also, modify pkcs7_digest() to detect when the digest was already
calculated so that it doesn't have to do redundant work. Verifying that
sinfo->sig->digest isn't NULL is sufficient because both places which
allocate sinfo->sig (pkcs7_parse_message() and pkcs7_note_signed_info())
use kzalloc() so sig->digest is always initialized to zero.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
---
 crypto/asymmetric_keys/pkcs7_verify.c | 25 +++++++++++++++++++++++++
 include/crypto/pkcs7.h                |  3 +++
 2 files changed, 28 insertions(+)

diff --git a/crypto/asymmetric_keys/pkcs7_verify.c b/crypto/asymmetric_keys/pkcs7_verify.c
index 39e6de0c2761..bd02360f8be5 100644
--- a/crypto/asymmetric_keys/pkcs7_verify.c
+++ b/crypto/asymmetric_keys/pkcs7_verify.c
@@ -33,6 +33,10 @@ static int pkcs7_digest(struct pkcs7_message *pkcs7,
 
 	kenter(",%u,%s", sinfo->index, sinfo->sig->hash_algo);
 
+	/* The digest was calculated already. */
+	if (sig->digest)
+		return 0;
+
 	if (!sinfo->sig->hash_algo)
 		return -ENOPKG;
 
@@ -122,6 +126,27 @@ static int pkcs7_digest(struct pkcs7_message *pkcs7,
 	return ret;
 }
 
+int pkcs7_get_digest(struct pkcs7_message *pkcs7, const u8 **buf, u8 *len)
+{
+	struct pkcs7_signed_info *sinfo = pkcs7->signed_infos;
+	int ret;
+
+	/*
+	 * This function doesn't support messages with more than one signature.
+	 */
+	if (sinfo == NULL || sinfo->next != NULL)
+		return -EBADMSG;
+
+	ret = pkcs7_digest(pkcs7, sinfo);
+	if (ret)
+		return ret;
+
+	*buf = sinfo->sig->digest;
+	*len = sinfo->sig->digest_size;
+
+	return 0;
+}
+
 /*
  * Find the key (X.509 certificate) to use to verify a PKCS#7 message.  PKCS#7
  * uses the issuer's name and the issuing certificate serial number for
diff --git a/include/crypto/pkcs7.h b/include/crypto/pkcs7.h
index 6f51d0cb6d12..cfaea9c37f4a 100644
--- a/include/crypto/pkcs7.h
+++ b/include/crypto/pkcs7.h
@@ -46,4 +46,7 @@ extern int pkcs7_verify(struct pkcs7_message *pkcs7,
 extern int pkcs7_supply_detached_data(struct pkcs7_message *pkcs7,
 				      const void *data, size_t datalen);
 
+extern int pkcs7_get_digest(struct pkcs7_message *pkcs7, const u8 **buf,
+			    u8 *len);
+
 #endif /* _CRYPTO_PKCS7_H */

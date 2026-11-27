Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795748397;
	b=EBmcurKa/V951bEdLyFWq0Oc4zR6qMYAGAbnfJ48aZRPYrbaO4FgSP0swemKpFLmS6lO
	 J9rTQ8Y+1mqw0h2QlSWy5Ev6SDIfVqYVl8zwjI7c3ZZfTe9z4ixZgWcG6BSMfguGMOBHb
	 eCmYrjL2+0P/sy4fDm5u5uBe70oqgHNLjP80OrVoru5p10xKLoKsFCnzUcr6o7t6CQVC+
	 Ejf8dl3+GIT77nS7IklMQnOCQzTfzSeToX62I3lUaLpdTo7142KecHK7KnSirWXGqT7+Z
	 f3lBpPXzBj12zNQShZE3XFH64P7zrz9qmUTUwA+jGBoQUxxW6ATHLTooUqcKQTZ6Ylg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795748397;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=/9Mh6Wxu4Z/jsve9fIJULnjNQ4Rs7c/R79y9gFpmxBA=;
	b=u6m4yzQfxG1FIHekSLOAM2sR8yDJiNFTP0il0z//fDWsmmk+qa0N5/FfeSlIoUUgUqZk
	 9/EwLHwwq0c+HZ5dMebqsr59iA/vMVM30AkN8Z7Ls7J6htRPlPgaLWx2uDWVzcDy74/u8
	 jNc8/T6QVnWmDGfFwSY3wiDoqXmU9gG9L2v6W/7biBjmO/5tNF/QI7Wamx9/K5oXJFK6m
	 k3wfCZ+i9Cb4pXOSP1k2/UFI27vEv9kt0BBLceyd8kNYBxgtgcvS1wSnkbTsly8RGScSA
	 eMt3abODNtu6btcXljP2oeCy6yBgV9YoCavXPlW8s8yuLtEbJNIo95Uzd170wXnHHZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IKPFrAhI;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CF0606A32E
	for <linux-integrity@vger.kernel.org>; Fri, 27 Nov 2026 02:59:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0CF0606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IKPFrAhI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795748395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/9Mh6Wxu4Z/jsve9fIJULnjNQ4Rs7c/R79y9gFpmxBA=;
	b=IKPFrAhIsjxRVNJgosIk/NNasgUqoc7DZCvs+sn3mFpBPkhz/6MiDj0qWxizPoPrglqPlM
	OqW/NVSvWODO4gZqoqcMSj51vqezWqes/02KpLZLdlZW6n+UM/OmUMFU8YXTYtSMYoSZ4x
	Yk8W8KvJGlCPoeQe/r0XvEChZLcqZYU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-6eMJdjT8OB2chWZreHWpXg-1; Fri,
 27 Nov 2026 02:59:51 +0000
X-MC-Unique: 6eMJdjT8OB2chWZreHWpXg-1
X-Mimecast-MFC-AGG-ID: 6eMJdjT8OB2chWZreHWpXg_1795748390
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0DFC7195608B;
	Fri, 27 Nov 2026 02:59:50 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 54A8C180054C;
	Fri, 27 Nov 2026 02:59:49 +0000 (UTC)
From: Bruno Meneguele <bmeneg@redhat.com>
To: linux-integrity@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org,
	zohar@linux.ibm.com,
	roberto.sassu@huawei.com,
	dhowells@redhat.com,
	bauerman@linux.ibm.com,
	Bruno Meneguele <bmeneg@redhat.com>
Subject: [RFC PATCH 4/8] ima: get the modsig content digest of each signer
Date: Thu, 26 Nov 2026 23:59:07 -0300
Message-ID: <20261127025912.1383750-5-bmeneg@redhat.com>
In-Reply-To: <20261127025912.1383750-1-bmeneg@redhat.com>
References: <20261127025912.1383750-1-bmeneg@redhat.com>
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The current code supports only one signer through ima_collect_modsig(),
which is used for the 'd-modsig' field (from 'ima-modsig' template) and the
is_binary_blacklisted() check. This single signer digest is taken from the
PKCS#7/CMS message and kept in the modsig structure. However, in case of
multiple signatures, PKCS#7 code already keeps the digest of each signer,
thus we can use pkcs7_get_digest() to collect the digest of any of them
without storing the data anywhere.

Stop keeping a copy of content digest in struct modsig and have
ima_get_modsig_digest() get the digest lazily based on signer's index in
the DER blob. To keep backwards compatibility, 'd-modsig' and the blacklist
check still ask the digest of a single signed (index 0) modsig, so the
behavior doesn't change.

Signed-off-by: Bruno Meneguele <bmeneg@redhat.com>
---
 security/integrity/ima/ima.h              | 15 +++++--
 security/integrity/ima/ima_appraise.c     |  8 ++--
 security/integrity/ima/ima_modsig.c       | 54 ++++++++++-------------
 security/integrity/ima/ima_template_lib.c | 10 ++++-
 4 files changed, 48 insertions(+), 39 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index b502854f28ee..055a2a696071 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -560,8 +560,10 @@ static inline void __init init_ima_appraise_lsm(const struct lsm_id *lsmid)
 int ima_read_modsig(enum ima_hooks func, const void *buf, loff_t buf_len,
 		    struct modsig **modsig);
 void ima_collect_modsig(struct modsig *modsig, const void *buf, loff_t size);
-int ima_get_modsig_digest(const struct modsig *modsig, enum hash_algo *algo,
-			  const u8 **digest, u32 *digest_size);
+unsigned int ima_get_modsig_signer_count(const struct modsig *modsig);
+int ima_get_modsig_digest(const struct modsig *modsig, unsigned int index,
+			  enum hash_algo *algo, const u8 **digest,
+			  u32 *digest_size, const char **sig_algo);
 int ima_get_raw_modsig(const struct modsig *modsig, const void **data,
 		       u32 *data_len);
 void ima_free_modsig(struct modsig *modsig);
@@ -577,9 +579,16 @@ static inline void ima_collect_modsig(struct modsig *modsig, const void *buf,
 {
 }
 
+static inline unsigned int
+ima_get_modsig_signer_count(const struct modsig *modsig)
+{
+	return 0;
+}
+
 static inline int ima_get_modsig_digest(const struct modsig *modsig,
+					unsigned int index,
 					enum hash_algo *algo, const u8 **digest,
-					u32 *digest_size)
+					u32 *digest_size, const char **sig_algo)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 134174d2e3f0..8aeec2778984 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -429,6 +429,7 @@ int ima_check_blacklist(struct ima_iint_cache *iint,
 			const struct modsig *modsig, int pcr)
 {
 	enum hash_algo hash_algo;
+	const char *sig_algo;
 	const u8 *digest = NULL;
 	u32 digestsize = 0;
 	int rc = 0;
@@ -437,9 +438,10 @@ int ima_check_blacklist(struct ima_iint_cache *iint,
 		return 0;
 
 	if (iint->flags & IMA_MODSIG_ALLOWED && modsig) {
-		ima_get_modsig_digest(modsig, &hash_algo, &digest, &digestsize);
-
-		rc = is_binary_blacklisted(digest, digestsize);
+		if (ima_get_modsig_signer_count(modsig) == 1 &&
+		    !ima_get_modsig_digest(modsig, 0, &hash_algo, &digest,
+					   &digestsize, &sig_algo))
+			rc = is_binary_blacklisted(digest, digestsize);
 	} else if (iint->flags & IMA_DIGSIG_REQUIRED && iint->ima_hash)
 		rc = is_binary_blacklisted(iint->ima_hash->digest, iint->ima_hash->length);
 
diff --git a/security/integrity/ima/ima_modsig.c b/security/integrity/ima/ima_modsig.c
index 15e499f7dba1..f69102d6b0f0 100644
--- a/security/integrity/ima/ima_modsig.c
+++ b/security/integrity/ima/ima_modsig.c
@@ -18,11 +18,8 @@
 struct modsig {
 	struct pkcs7_message *pkcs7_msg;
 
-	enum hash_algo hash_algo;
-
-	/* This digest will go in the 'd-modsig' field of the IMA template. */
-	const u8 *digest;
-	u32 digest_size;
+	/* The file content was supplied datached. */
+	bool detached;
 
 	/*
 	 * This is what will go to the measurement list if the template requires
@@ -79,47 +76,31 @@ int ima_read_modsig(enum ima_hooks func, const void *buf, loff_t buf_len,
 
 	memcpy(hdr->raw_pkcs7, buf + buf_len, sig_len);
 
-	/* We don't know the hash algorithm yet. */
-	hdr->hash_algo = HASH_ALGO__LAST;
-
 	*modsig = hdr;
 
 	return 0;
 }
 
 /**
- * ima_collect_modsig - Calculate the file hash without the appended signature.
+ * ima_collect_modsig - Supply the file content without the appended signature.
  * @modsig: parsed module signature
  * @buf: data to verify the signature on
  * @size: data size
  *
  * Since the modsig is part of the file contents, the hash used in its signature
  * isn't the same one ordinarily calculated by IMA. Therefore PKCS7 code
- * calculates a separate one for signature verification.
+ * calculates a separate one for each signer when it's first needed.
  */
 void ima_collect_modsig(struct modsig *modsig, const void *buf, loff_t size)
 {
-	const char *pkey_algo;
-	int rc;
-
 	/*
 	 * Provide the file contents (minus the appended sig) so that the PKCS7
 	 * code can calculate the file hash.
 	 */
 	size -= modsig->raw_pkcs7_len + strlen(MODULE_SIGNATURE_MARKER) +
 		sizeof(struct module_signature);
-	rc = pkcs7_supply_detached_data(modsig->pkcs7_msg, buf, size);
-	if (rc)
-		return;
-
-	/* There's room for the digest of a single signer only. */
-	if (pkcs7_get_signer_count(modsig->pkcs7_msg) != 1)
-		return;
-
-	/* Ask the PKCS7 code to calculate the file hash. */
-	rc = pkcs7_get_digest(modsig->pkcs7_msg, 0, &modsig->digest,
-			      &modsig->digest_size, &modsig->hash_algo,
-			      &pkey_algo);
+	modsig->detached = !pkcs7_supply_detached_data(modsig->pkcs7_msg,
+						       buf, size);
 }
 
 int ima_modsig_verify(struct key *keyring, const struct modsig *modsig)
@@ -128,14 +109,25 @@ int ima_modsig_verify(struct key *keyring, const struct modsig *modsig)
 					VERIFYING_MODULE_SIGNATURE, NULL, NULL);
 }
 
-int ima_get_modsig_digest(const struct modsig *modsig, enum hash_algo *algo,
-			  const u8 **digest, u32 *digest_size)
+unsigned int ima_get_modsig_signer_count(const struct modsig *modsig)
 {
-	*algo = modsig->hash_algo;
-	*digest = modsig->digest;
-	*digest_size = modsig->digest_size;
+	return pkcs7_get_signer_count(modsig->pkcs7_msg);
+}
 
-	return 0;
+/*
+ * ima_get_modsig_digest - Get the content digest of one signer of the modsig.
+ *
+ * See pkcs7_get_digest() for the results.
+ */
+int ima_get_modsig_digest(const struct modsig *modsig, unsigned int index,
+			  enum hash_algo *algo, const u8 **digest,
+			  u32 *digest_size, const char **sig_algo)
+{
+	if (!modsig->detached)
+		return -EBADMSG;
+
+	return pkcs7_get_digest(modsig->pkcs7_msg, index, digest, digest_size,
+				algo, sig_algo);
 }
 
 int ima_get_raw_modsig(const struct modsig *modsig, const void **data,
diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
index 9bd80ca1159a..0609a8f7a127 100644
--- a/security/integrity/ima/ima_template_lib.c
+++ b/security/integrity/ima/ima_template_lib.c
@@ -471,10 +471,16 @@ int ima_eventdigest_modsig_init(struct ima_event_data *event_data,
 		cur_digest = NULL;
 		cur_digestsize = 0;
 	} else {
+		const char *sig_algo;
 		int rc;
 
-		rc = ima_get_modsig_digest(event_data->modsig, &hash_algo,
-					   &cur_digest, &cur_digestsize);
+		/* 'd-modsig' supports the digest of a single signer only. */
+		if (ima_get_modsig_signer_count(event_data->modsig) != 1)
+			return -EINVAL;
+
+		rc = ima_get_modsig_digest(event_data->modsig, 0, &hash_algo,
+					   &cur_digest, &cur_digestsize,
+					   &sig_algo);
 		if (rc)
 			return rc;
 		else if (hash_algo == HASH_ALGO__LAST || cur_digestsize == 0)
-- 
2.55.0


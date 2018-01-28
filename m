Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51000 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750713AbeA1FHQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 28 Jan 2018 00:07:16 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w0S54LsR027277
        for <linux-integrity@vger.kernel.org>; Sun, 28 Jan 2018 00:07:16 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2fs7ud0bpv-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Sun, 28 Jan 2018 00:07:16 -0500
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Sun, 28 Jan 2018 05:07:13 -0000
Subject: Re: [PATCH] ima-evm-utils: migrate to the new openssl 1.1 api
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
        "Bruno E. O. Meneguele" <brdeoliv@redhat.com>,
        dmitry.kasatkin@gmail.com, jarkko.sakkinen@linux.intel.com
Cc: linux-integrity@vger.kernel.org
Date: Sun, 28 Jan 2018 00:07:09 -0500
In-Reply-To: <1517034216.3034.50.camel@HansenPartnership.com>
References: <20171207190508.28292-1-brdeoliv@redhat.com>
         <1517034216.3034.50.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1517116029.29187.214.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2018-01-26 at 22:23 -0800, James Bottomley wrote:
> On Thu, 2017-12-07 at 17:05 -0200, Bruno E. O. Meneguele wrote:
> > This patch adds and changes the points needed to support the new
> > OpenSSL
> > 1.1 API, considering the older one, OpenSSL 1.0.z, will be dropped by
> > the major distros in following releases.
> 
> This would break compilation on every 1.0 distro:
> 
> gcc -DHAVE_CONFIG_H -I. -I.. -I.. -include config.h    -g -O2 -g -O1
> -Wall -Wstrict-prototypes -pipe -MT evmctl-evmctl.o -MD -MP -MF
> .deps/evmctl-evmctl.Tpo -c -o evmctl-evmctl.o `test -f 'evmctl.c' ||
> echo './'`evmctl.c
> evmctl.c: In function 'calc_evm_hash':
> evmctl.c:369:2: warning: implicit declaration of function
> 'EVP_MD_CTX_new' [-Wimplicit-function-declaration]
>   ctx = EVP_MD_CTX_new();
> ...
> 
> Unfortunately you have to ifdef the compilations if you want it to work
> on both 1.0 and 1.1.
> 
> How about this?

Thanks, James.  It compiles and works with both libraries now.

Mimi

> ---
> 
> diff --git a/src/evmctl.c b/src/evmctl.c
> index c54efbb..6471404 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -314,7 +314,7 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
>  	struct stat st;
>  	int err;
>  	uint32_t generation = 0;
> -	EVP_MD_CTX ctx;
> +	EVP_MD_CTX *pctx;
>  	unsigned int mdlen;
>  	char **xattrname;
>  	char xattr_value[1024];
> @@ -323,6 +323,12 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
>  	char uuid[16];
>  	struct h_misc_64 hmac_misc;
>  	int hmac_size;
> +#if OPENSSL_VERSION_NUMBER < 0x10100000
> +	EVP_MD_CTX ctx;
> +	pctx = &ctx;
> +#else
> +	pctx = EVP_MD_CTX_new();
> +#endif
> 
>  	if (lstat(file, &st)) {
>  		log_err("Failed to stat: %s\n", file);
> @@ -366,7 +372,7 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
>  		return -1;
>  	}
> 
> -	err = EVP_DigestInit(&ctx, EVP_sha1());
> +	err = EVP_DigestInit(pctx, EVP_sha1());
>  	if (!err) {
>  		log_err("EVP_DigestInit() failed\n");
>  		return 1;
> @@ -398,7 +404,7 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
>  		/*log_debug("name: %s, value: %s, size: %d\n", *xattrname, xattr_value, err);*/
>  		log_info("name: %s, size: %d\n", *xattrname, err);
>  		log_debug_dump(xattr_value, err);
> -		err = EVP_DigestUpdate(&ctx, xattr_value, err);
> +		err = EVP_DigestUpdate(pctx, xattr_value, err);
>  		if (!err) {
>  			log_err("EVP_DigestUpdate() failed\n");
>  			return 1;
> @@ -446,7 +452,7 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
>  	log_debug("hmac_misc (%d): ", hmac_size);
>  	log_debug_dump(&hmac_misc, hmac_size);
> 
> -	err = EVP_DigestUpdate(&ctx, &hmac_misc, hmac_size);
> +	err = EVP_DigestUpdate(pctx, &hmac_misc, hmac_size);
>  	if (!err) {
>  		log_err("EVP_DigestUpdate() failed\n");
>  		return 1;
> @@ -457,14 +463,14 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
>  		if (err)
>  			return -1;
> 
> -		err = EVP_DigestUpdate(&ctx, (const unsigned char *)uuid, sizeof(uuid));
> +		err = EVP_DigestUpdate(pctx, (const unsigned char *)uuid, sizeof(uuid));
>  		if (!err) {
>  			log_err("EVP_DigestUpdate() failed\n");
>  			return 1;
>  		}
>  	}
> 
> -	err = EVP_DigestFinal(&ctx, hash, &mdlen);
> +	err = EVP_DigestFinal(pctx, hash, &mdlen);
>  	if (!err) {
>  		log_err("EVP_DigestFinal() failed\n");
>  		return 1;
> @@ -908,7 +914,7 @@ static int calc_evm_hmac(const char *file, const char *keyfile, unsigned char *h
>  	struct stat st;
>  	int err = -1;
>  	uint32_t generation = 0;
> -	HMAC_CTX ctx;
> +	HMAC_CTX *pctx;
>  	unsigned int mdlen;
>  	char **xattrname;
>  	unsigned char xattr_value[1024];
> @@ -919,6 +925,12 @@ static int calc_evm_hmac(const char *file, const char *keyfile, unsigned char *h
>  	ssize_t list_size;
>  	struct h_misc_64 hmac_misc;
>  	int hmac_size;
> +#if OPENSSL_VERSION_NUMBER < 0x10100000
> +	HMAC_CTX ctx;
> +	pctx = &ctx;
> +#else
> +	pctx = HMAC_CTX_new();
> +#endif
> 
>  	key = file2bin(keyfile, NULL, &keylen);
>  	if (!key) {
> @@ -965,7 +977,7 @@ static int calc_evm_hmac(const char *file, const char *keyfile, unsigned char *h
>  		goto out;
>  	}
> 
> -	err = !HMAC_Init(&ctx, evmkey, sizeof(evmkey), EVP_sha1());
> +	err = !HMAC_Init_ex(pctx, evmkey, sizeof(evmkey), EVP_sha1(), NULL);
>  	if (err) {
>  		log_err("HMAC_Init() failed\n");
>  		goto out;
> @@ -984,7 +996,7 @@ static int calc_evm_hmac(const char *file, const char *keyfile, unsigned char *h
>  		/*log_debug("name: %s, value: %s, size: %d\n", *xattrname, xattr_value, err);*/
>  		log_info("name: %s, size: %d\n", *xattrname, err);
>  		log_debug_dump(xattr_value, err);
> -		err = !HMAC_Update(&ctx, xattr_value, err);
> +		err = !HMAC_Update(pctx, xattr_value, err);
>  		if (err) {
>  			log_err("HMAC_Update() failed\n");
>  			goto out_ctx_cleanup;
> @@ -1025,16 +1037,20 @@ static int calc_evm_hmac(const char *file, const char *keyfile, unsigned char *h
>  	log_debug("hmac_misc (%d): ", hmac_size);
>  	log_debug_dump(&hmac_misc, hmac_size);
> 
> -	err = !HMAC_Update(&ctx, (const unsigned char *)&hmac_misc, hmac_size);
> +	err = !HMAC_Update(pctx, (const unsigned char *)&hmac_misc, hmac_size);
>  	if (err) {
>  		log_err("HMAC_Update() failed\n");
>  		goto out_ctx_cleanup;
>  	}
> -	err = !HMAC_Final(&ctx, hash, &mdlen);
> +	err = !HMAC_Final(pctx, hash, &mdlen);
>  	if (err)
>  		log_err("HMAC_Final() failed\n");
>  out_ctx_cleanup:
> -	HMAC_CTX_cleanup(&ctx);
> +#if OPENSSL_VERSION_NUMBER < 0x10100000
> +	HMAC_CTX_cleanup(pctx);
> +#else
> +	HMAC_CTX_free(pctx);
> +#endif
>  out:
>  	free(key);
>  	return err ?: mdlen;
> diff --git a/src/libimaevm.c b/src/libimaevm.c
> index eedffb4..fd1bde6 100644
> --- a/src/libimaevm.c
> +++ b/src/libimaevm.c
> @@ -271,9 +271,15 @@ int ima_calc_hash(const char *file, uint8_t *hash)
>  {
>  	const EVP_MD *md;
>  	struct stat st;
> -	EVP_MD_CTX ctx;
> +	EVP_MD_CTX *pctx;
>  	unsigned int mdlen;
>  	int err;
> +#if OPENSSL_VERSION_NUMBER < 0x10100000
> +	EVP_MD_CTX ctx;
> +	pctx = &ctx;
> +#else
> +	pctx = EVP_MD_CTX_new();
> +#endif
> 
>  	/*  Need to know the file length */
>  	err = lstat(file, &st);
> @@ -288,7 +294,7 @@ int ima_calc_hash(const char *file, uint8_t *hash)
>  		return 1;
>  	}
> 
> -	err = EVP_DigestInit(&ctx, md);
> +	err = EVP_DigestInit(pctx, md);
>  	if (!err) {
>  		log_err("EVP_DigestInit() failed\n");
>  		return 1;
> @@ -296,17 +302,17 @@ int ima_calc_hash(const char *file, uint8_t *hash)
> 
>  	switch (st.st_mode & S_IFMT) {
>  	case S_IFREG:
> -		err = add_file_hash(file, &ctx);
> +		err = add_file_hash(file, pctx);
>  		break;
>  	case S_IFDIR:
> -		err = add_dir_hash(file, &ctx);
> +		err = add_dir_hash(file, pctx);
>  		break;
>  	case S_IFLNK:
> -		err = add_link_hash(file, &ctx);
> +		err = add_link_hash(file, pctx);
>  		break;
>  	case S_IFIFO: case S_IFSOCK:
>  	case S_IFCHR: case S_IFBLK:
> -		err = add_dev_hash(&st, &ctx);
> +		err = add_dev_hash(&st, pctx);
>  		break;
>  	default:
>  		log_errno("Unsupported file type");
> @@ -316,7 +322,7 @@ int ima_calc_hash(const char *file, uint8_t *hash)
>  	if (err)
>  		return err;
> 
> -	err = EVP_DigestFinal(&ctx, hash, &mdlen);
> +	err = EVP_DigestFinal(pctx, hash, &mdlen);
>  	if (!err) {
>  		log_err("EVP_DigestFinal() failed\n");
>  		return 1;
> @@ -549,6 +555,14 @@ int key2bin(RSA *key, unsigned char *pub)
>  {
>  	int len, b, offset = 0;
>  	struct pubkey_hdr *pkh = (struct pubkey_hdr *)pub;
> +	const BIGNUM *n, *e;
> +
> +#if OPENSSL_VERSION_NUMBER < 0x10100000
> +	n = key->n;
> +	e = key->e;
> +#else
> +	RSA_get0_key(key, &n, &e, NULL);
> +#endif
> 
>  	/* add key header */
>  	pkh->version = 1;
> @@ -558,18 +572,18 @@ int key2bin(RSA *key, unsigned char *pub)
> 
>  	offset += sizeof(*pkh);
> 
> -	len = BN_num_bytes(key->n);
> -	b = BN_num_bits(key->n);
> +	len = BN_num_bytes(n);
> +	b = BN_num_bits(n);
>  	pub[offset++] = b >> 8;
>  	pub[offset++] = b & 0xff;
> -	BN_bn2bin(key->n, &pub[offset]);
> +	BN_bn2bin(n, &pub[offset]);
>  	offset += len;
> 
> -	len = BN_num_bytes(key->e);
> -	b = BN_num_bits(key->e);
> +	len = BN_num_bytes(e);
> +	b = BN_num_bits(e);
>  	pub[offset++] = b >> 8;
>  	pub[offset++] = b & 0xff;
> -	BN_bn2bin(key->e, &pub[offset]);
> +	BN_bn2bin(e, &pub[offset]);
>  	offset += len;
> 
>  	return offset;
> 

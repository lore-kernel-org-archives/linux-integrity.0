Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43652 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751377AbeFVUZg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 Jun 2018 16:25:36 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5MKOElE029505
        for <linux-integrity@vger.kernel.org>; Fri, 22 Jun 2018 16:25:36 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2js3383yw8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 22 Jun 2018 16:25:36 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Fri, 22 Jun 2018 21:25:34 +0100
Subject: Re: [USER] [PATCH 1/2] Remove hardcoding of SHA1 in EVM signatures
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthew Garrett <mjg59@google.com>, linux-integrity@vger.kernel.org
In-Reply-To: <20180417225601.6965-1-mjg59@google.com>
References: <20180417225601.6965-1-mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 22 Jun 2018 16:24:24 -0400
Mime-Version: 1.0
Message-Id: <1529699064.3883.14.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi Matthew,

On Tue, 2018-04-17 at 15:56 -0700, Matthew Garrett wrote:
> EVM signatures are always being generated with SHA1 even if the -a
> argument has been provided to evmctl. Fix this so the provided hash
> algorithm is used instead.

> Signed-off-by: Matthew Garrett <mjg59@google.com>
> ---
>  src/evmctl.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/src/evmctl.c b/src/evmctl.c
> index 2ffee78..43d261f 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -313,6 +313,7 @@ err:
> 
>  static int calc_evm_hash(const char *file, unsigned char *hash)

Please make sure the caller provides a large enough buffer for the
hash.

Mimi

>  {
> +        const EVP_MD *md;
>  	struct stat st;
>  	int err;
>  	uint32_t generation = 0;
> @@ -374,7 +375,13 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
>  		return -1;
>  	}
> 
> -	err = EVP_DigestInit(pctx, EVP_sha1());
> +	md = EVP_get_digestbyname(params.hash_algo);
> +	if (!md) {
> +		log_err("EVP_get_digestbyname() failed\n");
> +		return 1;
> +	}
> +
> +	err = EVP_DigestInit(pctx, md);
>  	if (!err) {
>  		log_err("EVP_DigestInit() failed\n");
>  		return 1;
> @@ -498,7 +505,7 @@ static int sign_evm(const char *file, const char *key)
>  	if (len <= 1)
>  		return len;
> 
> -	len = sign_hash("sha1", hash, len, key, NULL, sig + 1);
> +	len = sign_hash(params.hash_algo, hash, len, key, NULL, sig + 1);
>  	if (len <= 1)
>  		return len;
> 
> @@ -967,6 +974,7 @@ static int cmd_setxattr_ima(struct command *cmd)
> 
>  static int calc_evm_hmac(const char *file, const char *keyfile, unsigned char *hash)
>  {
> +        const EVP_MD *md;
>  	struct stat st;
>  	int err = -1;
>  	uint32_t generation = 0;
> @@ -1033,7 +1041,13 @@ static int calc_evm_hmac(const char *file, const char *keyfile, unsigned char *h
>  		goto out;
>  	}
> 
> -	err = !HMAC_Init_ex(pctx, evmkey, sizeof(evmkey), EVP_sha1(), NULL);
> +	md = EVP_get_digestbyname(params.hash_algo);
> +	if (!md) {
> +		log_err("EVP_get_digestbyname() failed\n");
> +		goto out;
> +	}
> +
> +	err = !HMAC_Init_ex(pctx, evmkey, sizeof(evmkey), md, NULL);
>  	if (err) {
>  		log_err("HMAC_Init() failed\n");
>  		goto out;

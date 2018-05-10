Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60780 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S966262AbeEJQ2e (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 May 2018 12:28:34 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4AGP4DR071577
        for <linux-integrity@vger.kernel.org>; Thu, 10 May 2018 12:28:34 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2hvqvtwx65-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 10 May 2018 12:28:34 -0400
Received: from localhost
        by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <bauerman@linux.vnet.ibm.com>;
        Thu, 10 May 2018 10:28:32 -0600
References: <20180420203408.50769-1-mjg59@google.com>
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Matthew Garrett <mjg59@google.com>
Cc: linux-integrity@vger.kernel.org, zohar@linux.vnet.ibm.com
Subject: Re: [PATCH] evm: Allow non-SHA1 digital signatures
In-reply-to: <20180420203408.50769-1-mjg59@google.com>
Date: Thu, 10 May 2018 13:28:16 -0300
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <878t8r1nmn.fsf@morokweng.localdomain>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>


Hello Matthew,

I have just a few minor nits. Feel free to ignore if you don't think
it's worth addressing them.

Matthew Garrett <mjg59@google.com> writes:

> @@ -203,10 +205,24 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
>  	if (!(inode->i_opflags & IOP_XATTR))
>  		return -EOPNOTSUPP;
>
> -	desc = init_desc(type);
> +	desc = init_desc(type, hash_algo);
>  	if (IS_ERR(desc))
>  		return PTR_ERR(desc);
>
> +	/*
> +	 * HMACs are always SHA1, but signatures may be of varying sizes, so
> +	 * allocate a buffer for the non-HMAC case and return the size to
> +	 * the caller
> +	 */
> +	if (type != EVM_XATTR_HMAC) {
> +		*digestlen = crypto_shash_digestsize(desc->tfm);
> +		*digest = kmalloc(*digestlen, GFP_KERNEL);
> +		if (!*digest) {
> +			error = -ENOMEM;
> +			goto out;
> +		}
> +	}
> +
>  	error = -ENODATA;
>  	for (xattrname = evm_config_xattrnames; *xattrname != NULL; xattrname++) {
>  		bool is_ima = false;

I think it's worth mentioning either here or in the comment at the
beginning of this function that when type == EVM_XATTR_HMAC *digest is
expected to point to an existing buffer.

> @@ -251,18 +267,18 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
>
>  int evm_calc_hmac(struct dentry *dentry, const char *req_xattr_name,
>  		  const char *req_xattr_value, size_t req_xattr_value_len,
> -		  char *digest)
> +		  char **digest)

IMHO it's a slightly better interface if evm_calc_hmac() keeps taking a
char *, since it won't need to change where its argument points to.

>  {
>  	return evm_calc_hmac_or_hash(dentry, req_xattr_name, req_xattr_value,
> -			       req_xattr_value_len, EVM_XATTR_HMAC, digest);
> +		    req_xattr_value_len, EVM_XATTR_HMAC, 0x02, digest, NULL);

It's clearer to use HASH_ALGO_SHA1 instead of 0x02 here.

>  }
> @@ -333,7 +349,7 @@ int evm_init_hmac(struct inode *inode, const struct xattr *lsm_xattr,
>  {
>  	struct shash_desc *desc;
>
> -	desc = init_desc(EVM_XATTR_HMAC);
> +	desc = init_desc(EVM_XATTR_HMAC, 0x02);

Same here.

>  	if (IS_ERR(desc)) {
>  		pr_info("init_desc failed\n");
>  		return PTR_ERR(desc);
> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
> index 9ea9c19a545c..3d952e69852f 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -28,6 +28,8 @@
>  #include <crypto/algapi.h>
>  #include "evm.h"
>
> +#define HMAC_LEN 20

It's clearer to use SHA1_DIGEST_SIZE instead of 20 here.

> +
>  int evm_initialized;
>
>  static const char * const integrity_status_msg[] = {

--
Thiago Jung Bauermann
IBM Linux Technology Center

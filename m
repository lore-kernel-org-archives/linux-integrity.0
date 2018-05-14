Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52684 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752305AbeENLHN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 May 2018 07:07:13 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4EB5cqX051650
        for <linux-integrity@vger.kernel.org>; Mon, 14 May 2018 07:07:13 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2hy5tgh49q-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 14 May 2018 07:07:11 -0400
Received: from localhost
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 14 May 2018 12:07:10 +0100
Subject: Re: [PATCH V2] evm: Allow non-SHA1 digital signatures
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthew Garrett <mjg59@google.com>, linux-integrity@vger.kernel.org
Cc: bauerman@linux.vnet.ibm.com
Date: Mon, 14 May 2018 07:07:06 -0400
In-Reply-To: <20180511183912.11636-1-mjg59@google.com>
References: <20180511183912.11636-1-mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1526296026.3898.80.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2018-05-11 at 11:39 -0700, Matthew Garrett wrote:
> 
>  static int evm_is_immutable(struct dentry *dentry, struct inode *inode)
> @@ -303,6 +305,7 @@ int evm_update_evmxattr(struct dentry *dentry, const char *xattr_name,
>  {
>  	struct inode *inode = d_backing_inode(dentry);
>  	struct evm_ima_xattr_data xattr_data;
> +	struct ima_digest_data *data;
>  	int rc = 0;
> 
>  	/*
> @@ -315,10 +318,16 @@ int evm_update_evmxattr(struct dentry *dentry, const char *xattr_name,
>  	if (rc)
>  		return -EPERM;
> 
> +	data = kmalloc(sizeof(*data) + SHA1_DIGEST_SIZE, GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;

Instead of allocating and freeing the buffer each time an HMAC is
updated or verified, like before, why not define a new struct which is
allocated on the stack both here and in evm_verify_hmac()?

> +
> +	data->algo = HASH_ALGO_SHA1;
>  	rc = evm_calc_hmac(dentry, xattr_name, xattr_value,
> -			   xattr_value_len, xattr_data.digest);
> +			   xattr_value_len, data);
>  	if (rc == 0) {
>  		xattr_data.type = EVM_XATTR_HMAC;
> +		memcpy(&xattr_data.digest, data->digest, SHA1_DIGEST_SIZE);
>  		rc = __vfs_setxattr_noperm(dentry, XATTR_NAME_EVM,
>  					   &xattr_data,
>  					   sizeof(xattr_data), 0);

ima_fix_xattr() supports writing both the original IMA_XATTR_DIGEST
format, which was sha1 based, and the new IMA_XATTR_DIGEST_NG format,
which supports larger digests. It writes security.ima directly from
ima_digest_data struct.  No need for copying it.

Mimi

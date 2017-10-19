Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39350 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753254AbdJSMwn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Oct 2017 08:52:43 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9JCn2b1036225
        for <linux-integrity@vger.kernel.org>; Thu, 19 Oct 2017 08:52:42 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2dpskbjbub-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 19 Oct 2017 08:52:42 -0400
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Thu, 19 Oct 2017 13:52:39 +0100
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v9JCqaup24510658
        for <linux-integrity@vger.kernel.org>; Thu, 19 Oct 2017 12:52:37 GMT
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
        by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id v9JCqZJx032687
        for <linux-integrity@vger.kernel.org>; Thu, 19 Oct 2017 23:52:35 +1100
Subject: Re: [PATCH] EVM: Add support for portable signature format
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthew Garrett <mjg59@google.com>, linux-integrity@vger.kernel.org
Cc: Dmitry Kasatkin <dmitry.kasatkin@huawei.com>,
        Mikhail Kurinnoi <viewizard@viewizard.com>
Date: Thu, 19 Oct 2017 08:52:32 -0400
In-Reply-To: <20171018180111.13021-1-mjg59@google.com>
References: <20171018180111.13021-1-mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1508417552.4510.131.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, 2017-10-18 at 11:01 -0700, Matthew Garrett wrote:
> The EVM signature includes the inode number and (optionally) the
> filesystem UUID, making it impractical to ship EVM signatures in
> packages. This patch adds a new portable format intended to allow
> distributions to include EVM signatures. It is identical to the existing
> format but hardcodes the inode and generation numbers to 0 and does not
> include the filesystem UUID even if the kernel is configured to do so.

The existing IMA signature format is already portable and immutable.
 The new portable and immutable signature type is only needed for EVM.
 I don't see a need to refer to it as EVM_IMA_XATTR_PORTABLE_DIGSIG.

> Admins should note that creating portable signatures that do not include
> the security.ima xattr would allow these signatures to be applied to any
> file with the same owners and security labels, which would allow
> subversion of EVM's security guarantees. The kernel does not attempt to
> enforce this.

As much as possible IMA and EVM should work independently of each
other.  But in this case, I think we need to blur the lines a bit.

Currently, before writing a new security.evm value, the existing
security.evm value is verified.  To do this it has to read the
security xattrs to calculate the hash/hmac.  How hard would it really
be to verify that a security.ima xattr exists, before writing this new
EVM signature?  How hard would it be to make sure that security.ima is
included in the calculation on verification?

Mimi

> Based on earlier work by Dmitry Kasatkin and Mikhail Kurinnoi.
> 
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> Cc: Dmitry Kasatkin <dmitry.kasatkin@huawei.com>
> Cc: Mikhail Kurinnoi <viewizard@viewizard.com>
> ---
>  security/integrity/evm/evm.h        |  2 +-
>  security/integrity/evm/evm_crypto.c | 24 +++++++++++++++---------
>  security/integrity/evm/evm_main.c   |  7 +++++--
>  security/integrity/integrity.h      |  1 +
>  4 files changed, 22 insertions(+), 12 deletions(-)
> 
> diff --git a/security/integrity/evm/evm.h b/security/integrity/evm/evm.h
> index f5f12727771a..2ff02459fcfd 100644
> --- a/security/integrity/evm/evm.h
> +++ b/security/integrity/evm/evm.h
> @@ -48,7 +48,7 @@ int evm_calc_hmac(struct dentry *dentry, const char *req_xattr_name,
>  		  size_t req_xattr_value_len, char *digest);
>  int evm_calc_hash(struct dentry *dentry, const char *req_xattr_name,
>  		  const char *req_xattr_value,
> -		  size_t req_xattr_value_len, char *digest);
> +		  size_t req_xattr_value_len, char type, char *digest);
>  int evm_init_hmac(struct inode *inode, const struct xattr *xattr,
>  		  char *hmac_val);
>  int evm_init_secfs(void);
> diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
> index 1d32cd20009a..6435f12b0067 100644
> --- a/security/integrity/evm/evm_crypto.c
> +++ b/security/integrity/evm/evm_crypto.c
> @@ -138,7 +138,7 @@ static struct shash_desc *init_desc(char type)
>   * protection.)
>   */
>  static void hmac_add_misc(struct shash_desc *desc, struct inode *inode,
> -			  char *digest)
> +			  char type, char *digest)
>  {
>  	struct h_misc {
>  		unsigned long ino;
> @@ -149,8 +149,13 @@ static void hmac_add_misc(struct shash_desc *desc, struct inode *inode,
>  	} hmac_misc;
> 
>  	memset(&hmac_misc, 0, sizeof(hmac_misc));
> -	hmac_misc.ino = inode->i_ino;
> -	hmac_misc.generation = inode->i_generation;
> +	/* Don't include the inode or generation number in portable
> +	 * signatures
> +	 */
> +	if (type != EVM_IMA_XATTR_PORTABLE_DIGSIG) {
> +		hmac_misc.ino = inode->i_ino;
> +		hmac_misc.generation = inode->i_generation;
> +	}
>  	/* The hmac uid and gid must be encoded in the initial user
>  	 * namespace (not the filesystems user namespace) as encoding
>  	 * them in the filesystems user namespace allows an attack
> @@ -163,7 +168,8 @@ static void hmac_add_misc(struct shash_desc *desc, struct inode *inode,
>  	hmac_misc.gid = from_kgid(&init_user_ns, inode->i_gid);
>  	hmac_misc.mode = inode->i_mode;
>  	crypto_shash_update(desc, (const u8 *)&hmac_misc, sizeof(hmac_misc));
> -	if (evm_hmac_attrs & EVM_ATTR_FSUUID)
> +	if ((evm_hmac_attrs & EVM_ATTR_FSUUID) &&
> +	    type != EVM_IMA_XATTR_PORTABLE_DIGSIG)
>  		crypto_shash_update(desc, &inode->i_sb->s_uuid.b[0],
>  				    sizeof(inode->i_sb->s_uuid));
>  	crypto_shash_final(desc, digest);
> @@ -219,7 +225,7 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
>  		xattr_size = size;
>  		crypto_shash_update(desc, (const u8 *)xattr_value, xattr_size);
>  	}
> -	hmac_add_misc(desc, inode, digest);
> +	hmac_add_misc(desc, inode, type, digest);
> 
>  out:
>  	kfree(xattr_value);
> @@ -232,15 +238,15 @@ int evm_calc_hmac(struct dentry *dentry, const char *req_xattr_name,
>  		  char *digest)
>  {
>  	return evm_calc_hmac_or_hash(dentry, req_xattr_name, req_xattr_value,
> -				req_xattr_value_len, EVM_XATTR_HMAC, digest);
> +			       req_xattr_value_len, EVM_XATTR_HMAC, digest);
>  }
> 
>  int evm_calc_hash(struct dentry *dentry, const char *req_xattr_name,
>  		  const char *req_xattr_value, size_t req_xattr_value_len,
> -		  char *digest)
> +		  char type, char *digest)
>  {
>  	return evm_calc_hmac_or_hash(dentry, req_xattr_name, req_xattr_value,
> -				req_xattr_value_len, IMA_XATTR_DIGEST, digest);
> +				     req_xattr_value_len, type, digest);
>  }
> 
>  /*
> @@ -280,7 +286,7 @@ int evm_init_hmac(struct inode *inode, const struct xattr *lsm_xattr,
>  	}
> 
>  	crypto_shash_update(desc, lsm_xattr->value, lsm_xattr->value_len);
> -	hmac_add_misc(desc, inode, hmac_val);
> +	hmac_add_misc(desc, inode, EVM_XATTR_HMAC, hmac_val);
>  	kfree(desc);
>  	return 0;
>  }
> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
> index 063d38aef64e..ff3c35a7058c 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -161,8 +161,10 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
>  			rc = -EINVAL;
>  		break;
>  	case EVM_IMA_XATTR_DIGSIG:
> +	case EVM_IMA_XATTR_PORTABLE_DIGSIG:
>  		rc = evm_calc_hash(dentry, xattr_name, xattr_value,
> -				xattr_value_len, calc.digest);
> +				   xattr_value_len, xattr_data->type,
> +				   calc.digest);
>  		if (rc)
>  			break;
>  		rc = integrity_digsig_verify(INTEGRITY_KEYRING_EVM,
> @@ -345,7 +347,8 @@ int evm_inode_setxattr(struct dentry *dentry, const char *xattr_name,
>  	if (strcmp(xattr_name, XATTR_NAME_EVM) == 0) {
>  		if (!xattr_value_len)
>  			return -EINVAL;
> -		if (xattr_data->type != EVM_IMA_XATTR_DIGSIG)
> +		if (xattr_data->type != EVM_IMA_XATTR_DIGSIG &&
> +		    xattr_data->type != EVM_IMA_XATTR_PORTABLE_DIGSIG)
>  			return -EPERM;
>  	}
>  	return evm_protect_xattr(dentry, xattr_name, xattr_value,
> diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
> index a53e7e4ab06c..0a721c110e92 100644
> --- a/security/integrity/integrity.h
> +++ b/security/integrity/integrity.h
> @@ -58,6 +58,7 @@ enum evm_ima_xattr_type {
>  	EVM_XATTR_HMAC,
>  	EVM_IMA_XATTR_DIGSIG,
>  	IMA_XATTR_DIGEST_NG,
> +	EVM_IMA_XATTR_PORTABLE_DIGSIG,
>  	IMA_XATTR_LAST
>  };
> 

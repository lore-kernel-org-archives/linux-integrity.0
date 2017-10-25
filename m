Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:49619 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932228AbdJYKN3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 Oct 2017 06:13:29 -0400
Received: by mail-lf0-f66.google.com with SMTP id w21so27238632lfc.6
        for <linux-integrity@vger.kernel.org>; Wed, 25 Oct 2017 03:13:28 -0700 (PDT)
Date: Wed, 25 Oct 2017 13:13:26 +0300
From: Mikhail Kurinnoi <viewizard@viewizard.com>
To: Matthew Garrett <mjg59@google.com>
Cc: linux-integrity@vger.kernel.org, zohar@linux.vnet.ibm.com,
        Dmitry Kasatkin <dmitry.kasatkin@huawei.com>
Subject: Re: [PATCH V3] EVM: Add support for portable signature format
Message-ID: <20171025131326.2ebbb4a4@totoro>
In-Reply-To: <20171025095413.25794-1-mjg59@google.com>
References: <20171025095413.25794-1-mjg59@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

? Wed, 25 Oct 2017 02:54:13 -0700
Matthew Garrett <mjg59@google.com> ?????:

> The EVM signature includes the inode number and (optionally) the
> filesystem UUID, making it impractical to ship EVM signatures in
> packages. This patch adds a new portable format intended to allow
> distributions to include EVM signatures. It is identical to the
> existing format but hardcodes the inode and generation numbers to 0
> and does not include the filesystem UUID even if the kernel is
> configured to do so.
> 
> Removing the inode means that the metadata and signature from one file
> could be copied to another file without invalidating it. This is
> avoided by ensuring that an IMA xattr is present during EVM
> validation.
> 
> Based on earlier work by Dmitry Kasatkin and Mikhail Kurinnoi.
> 
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> Cc: Dmitry Kasatkin <dmitry.kasatkin@huawei.com>
> Cc: Mikhail Kurinnoi <viewizard@viewizard.com>
> ---
> V3: include feedback from Mimi.
> 
>  security/integrity/evm/evm.h        |  2 +-
>  security/integrity/evm/evm_crypto.c | 37
> ++++++++++++++++++++++++++++---------
> security/integrity/evm/evm_main.c   | 14 +++++++++-----
> security/integrity/integrity.h      |  1 + 4 files changed, 39
> insertions(+), 15 deletions(-)
> 
> diff --git a/security/integrity/evm/evm.h
> b/security/integrity/evm/evm.h index f5f12727771a..2ff02459fcfd 100644
> --- a/security/integrity/evm/evm.h
> +++ b/security/integrity/evm/evm.h
> @@ -48,7 +48,7 @@ int evm_calc_hmac(struct dentry *dentry, const char
> *req_xattr_name, size_t req_xattr_value_len, char *digest);
>  int evm_calc_hash(struct dentry *dentry, const char *req_xattr_name,
>  		  const char *req_xattr_value,
> -		  size_t req_xattr_value_len, char *digest);
> +		  size_t req_xattr_value_len, char type, char
> *digest); int evm_init_hmac(struct inode *inode, const struct xattr
> *xattr, char *hmac_val);
>  int evm_init_secfs(void);
> diff --git a/security/integrity/evm/evm_crypto.c
> b/security/integrity/evm/evm_crypto.c index
> 1d32cd20009a..8855722529d4 100644 ---
> a/security/integrity/evm/evm_crypto.c +++
> b/security/integrity/evm/evm_crypto.c @@ -138,7 +138,7 @@ static
> struct shash_desc *init_desc(char type)
>   * protection.)
>   */
>  static void hmac_add_misc(struct shash_desc *desc, struct inode
> *inode,
> -			  char *digest)
> +			  char type, char *digest)
>  {
>  	struct h_misc {
>  		unsigned long ino;
> @@ -149,8 +149,13 @@ static void hmac_add_misc(struct shash_desc
> *desc, struct inode *inode, } hmac_misc;
>  
>  	memset(&hmac_misc, 0, sizeof(hmac_misc));
> -	hmac_misc.ino = inode->i_ino;
> -	hmac_misc.generation = inode->i_generation;
> +	/* Don't include the inode or generation number in portable
> +	 * signatures
> +	 */
> +	if (type != EVM_XATTR_PORTABLE_DIGSIG) {
> +		hmac_misc.ino = inode->i_ino;
> +		hmac_misc.generation = inode->i_generation;
> +	}
>  	/* The hmac uid and gid must be encoded in the initial user
>  	 * namespace (not the filesystems user namespace) as encoding
>  	 * them in the filesystems user namespace allows an attack
> @@ -163,7 +168,8 @@ static void hmac_add_misc(struct shash_desc
> *desc, struct inode *inode, hmac_misc.gid = from_kgid(&init_user_ns,
> inode->i_gid); hmac_misc.mode = inode->i_mode;
>  	crypto_shash_update(desc, (const u8 *)&hmac_misc,
> sizeof(hmac_misc));
> -	if (evm_hmac_attrs & EVM_ATTR_FSUUID)
> +	if ((evm_hmac_attrs & EVM_ATTR_FSUUID) &&
> +	    type != EVM_XATTR_PORTABLE_DIGSIG)
>  		crypto_shash_update(desc, &inode->i_sb->s_uuid.b[0],
>  				    sizeof(inode->i_sb->s_uuid));
>  	crypto_shash_final(desc, digest);
> @@ -189,6 +195,7 @@ static int evm_calc_hmac_or_hash(struct dentry
> *dentry, char *xattr_value = NULL;
>  	int error;
>  	int size;
> +	bool ima_present = false;
>  
>  	if (!(inode->i_opflags & IOP_XATTR))
>  		return -EOPNOTSUPP;
> @@ -199,11 +206,18 @@ static int evm_calc_hmac_or_hash(struct dentry
> *dentry, 
>  	error = -ENODATA;
>  	for (xattrname = evm_config_xattrnames; *xattrname != NULL;
> xattrname++) {
> +		bool is_ima = false;
> +
> +		if (strcmp(*xattrname, XATTR_NAME_IMA) == 0)
> +			is_ima = true;
> +
>  		if ((req_xattr_name && req_xattr_value)
>  		    && !strcmp(*xattrname, req_xattr_name)) {
>  			error = 0;
>  			crypto_shash_update(desc, (const u8
> *)req_xattr_value, req_xattr_value_len);
> +			if (is_ima)
> +				ima_present = true;
>  			continue;
>  		}
>  		size = vfs_getxattr_alloc(dentry, *xattrname,
> @@ -218,9 +232,14 @@ static int evm_calc_hmac_or_hash(struct dentry
> *dentry, error = 0;
>  		xattr_size = size;
>  		crypto_shash_update(desc, (const u8 *)xattr_value,
> xattr_size);
> +		if (is_ima)
> +			ima_present = true;
>  	}
> -	hmac_add_misc(desc, inode, digest);
> +	hmac_add_misc(desc, inode, type, digest);
>  
> +	/* Portable EVM signatures must include an IMA hash */
> +	if (type == EVM_XATTR_PORTABLE_DIGSIG && !ima_present)
> +		return -EPERM;
>  out:
>  	kfree(xattr_value);
>  	kfree(desc);
> @@ -232,15 +251,15 @@ int evm_calc_hmac(struct dentry *dentry, const
> char *req_xattr_name, char *digest)
>  {
>  	return evm_calc_hmac_or_hash(dentry, req_xattr_name,
> req_xattr_value,
> -				req_xattr_value_len, EVM_XATTR_HMAC,
> digest);
> +			       req_xattr_value_len, EVM_XATTR_HMAC,
> digest); }
>  
>  int evm_calc_hash(struct dentry *dentry, const char *req_xattr_name,
>  		  const char *req_xattr_value, size_t
> req_xattr_value_len,
> -		  char *digest)
> +		  char type, char *digest)
>  {
>  	return evm_calc_hmac_or_hash(dentry, req_xattr_name,
> req_xattr_value,
> -				req_xattr_value_len,
> IMA_XATTR_DIGEST, digest);
> +				     req_xattr_value_len, type,
> digest); }
>  
>  /*
> @@ -280,7 +299,7 @@ int evm_init_hmac(struct inode *inode, const
> struct xattr *lsm_xattr, }
>  
>  	crypto_shash_update(desc, lsm_xattr->value,
> lsm_xattr->value_len);
> -	hmac_add_misc(desc, inode, hmac_val);
> +	hmac_add_misc(desc, inode, EVM_XATTR_HMAC, hmac_val);
>  	kfree(desc);
>  	return 0;
>  }
> diff --git a/security/integrity/evm/evm_main.c
> b/security/integrity/evm/evm_main.c index 063d38aef64e..38efee382eb0
> 100644 --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -161,19 +161,22 @@ static enum integrity_status
> evm_verify_hmac(struct dentry *dentry, rc = -EINVAL;
>  		break;
>  	case EVM_IMA_XATTR_DIGSIG:
> +	case EVM_XATTR_PORTABLE_DIGSIG:
>  		rc = evm_calc_hash(dentry, xattr_name, xattr_value,
> -				xattr_value_len, calc.digest);
> +				   xattr_value_len, xattr_data->type,
> +				   calc.digest);
>  		if (rc)
>  			break;
>  		rc = integrity_digsig_verify(INTEGRITY_KEYRING_EVM,
>  					(const char *)xattr_data,
> xattr_len, calc.digest, sizeof(calc.digest));
>  		if (!rc) {
> -			/* Replace RSA with HMAC if not mounted
> readonly and
> -			 * not immutable
> +			/* Replace non-portable RSA with HMAC if not
> +			 * mounted readonly and not immutable.
>  			 */
>  			if (!IS_RDONLY(d_backing_inode(dentry)) &&
> -			    !IS_IMMUTABLE(d_backing_inode(dentry)))
> +			    !IS_IMMUTABLE(d_backing_inode(dentry)) &&
> +			    xattr_data->type !=
> EVM_XATTR_PORTABLE_DIGSIG) evm_update_evmxattr(dentry, xattr_name,
>  						    xattr_value,
>  						    xattr_value_len);
> @@ -345,7 +348,8 @@ int evm_inode_setxattr(struct dentry *dentry,
> const char *xattr_name, if (strcmp(xattr_name, XATTR_NAME_EVM) == 0) {
>  		if (!xattr_value_len)
>  			return -EINVAL;
> -		if (xattr_data->type != EVM_IMA_XATTR_DIGSIG)
> +		if (xattr_data->type != EVM_IMA_XATTR_DIGSIG &&
> +		    xattr_data->type != EVM_XATTR_PORTABLE_DIGSIG)
>  			return -EPERM;
>  	}
>  	return evm_protect_xattr(dentry, xattr_name, xattr_value,
> diff --git a/security/integrity/integrity.h
> b/security/integrity/integrity.h index a53e7e4ab06c..1e268ca9706f
> 100644 --- a/security/integrity/integrity.h
> +++ b/security/integrity/integrity.h
> @@ -58,6 +58,7 @@ enum evm_ima_xattr_type {
>  	EVM_XATTR_HMAC,
>  	EVM_IMA_XATTR_DIGSIG,
>  	IMA_XATTR_DIGEST_NG,
> +	EVM_XATTR_PORTABLE_DIGSIG,
>  	IMA_XATTR_LAST
>  };
>  


In case of IMA hash update we will forced to update EVM xattr from
ima_fix_xattr() with __vfs_setxattr_noperm(), this mean we will not call
evm_inode_setxattr(), but call evm_inode_post_setxattr().

Dmitry's patch 
https://sourceforge.net/p/linux-ima/mailman/message/32987311/
have work around for this issue. Since, in case we have immutable EVM,
we should prevent any file data changes (IMA hash update).



-- 
Best regards,
Mikhail Kurinnoi

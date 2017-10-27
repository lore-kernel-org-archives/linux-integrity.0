Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from lhrrgout.huawei.com ([194.213.3.17]:38705 "EHLO
        lhrrgout.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752016AbdJ0K1t (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 27 Oct 2017 06:27:49 -0400
From: Dmitry Kasatkin <dmitry.kasatkin@huawei.com>
To: Matthew Garrett <mjg59@google.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
CC: "zohar@linux.vnet.ibm.com" <zohar@linux.vnet.ibm.com>,
        Mikhail Kurinnoi <viewizard@viewizard.com>
Subject: RE: [RFC] EVM: Add support for portable signature format
Date: Fri, 27 Oct 2017 10:27:30 +0000
Message-ID: <C2D7A727C393B644B70DF4B4DCFB60B921C4718F@FRAEML521-MBX.china.huawei.com>
References: <20171026083144.16247-1-mjg59@google.com>
In-Reply-To: <20171026083144.16247-1-mjg59@google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>



> -----Original Message-----
> From: Matthew Garrett [mailto:mjg59@google.com]
> Sent: 26 October 2017 11:32
> To: linux-integrity@vger.kernel.org
> Cc: zohar@linux.vnet.ibm.com; Matthew Garrett <mjg59@google.com>;
> Dmitry Kasatkin <dmitry.kasatkin@huawei.com>; Mikhail Kurinnoi
> <viewizard@viewizard.com>
> Subject: [RFC] EVM: Add support for portable signature format
> 
> Ok I /think/ I have everything covered here. I'm away from my workstation
> this week so can't test this beyond building it right now, but thought I should
> send it out so people can check my reasoning.
> 
> The EVM signature includes the inode number and (optionally) the filesystem
> UUID, making it impractical to ship EVM signatures in packages. This patch
> adds a new portable format intended to allow distributions to include EVM
> signatures. It is identical to the existing format but hardcodes the inode and
> generation numbers to 0 and does not include the filesystem UUID even if
> the kernel is configured to do so.
> 
> Removing the inode means that the metadata and signature from one file
> could be copied to another file without invalidating it. This is avoided by
> ensuring that an IMA xattr is present during EVM validation.
> 
> Portable signatures are intended to be immutable - ie, they will never be
> transformed into HMACs. This is achieved via the following changes:
> 
> 1) An update is not triggered on initial xattr write
> 2) evm_verifyxattr returns INTEGRITY_PASS_IMMUTABLE for valid portable
> digital signatures and sets the EVM_IMMUTABLE_DIGSIG flag
> 3) ima_appraise_measurement() is updated to treat
> INTEGRITY_PASS_IMMUTABLE as valid, allowing IMA appraisal to pass
> 4) ima_update_xattr() does not update the IMA xattr if
> EVM_IMMUTABLE_DIGSIG is set
> 5) any other codepath that calls evm_update_evmxattr() treats
> INTEGRITY_PASS_IMMUTABLE as a failure, and prevents the write that would
> trigger an HMAC writeout
> 
> The only path that will still result in an update will be if IMA is in "fix" mode
> while a valid HMAC key is loaded.
> 
> Based on earlier work by Dmitry Kasatkin and Mikhail Kurinnoi.
> 
> Cc: Dmitry Kasatkin <dmitry.kasatkin@huawei.com>
> Cc: Mikhail Kurinnoi <viewizard@viewizard.com>
> ---
>  include/linux/integrity.h             |  1 +
>  security/integrity/evm/evm.h          |  2 +-
>  security/integrity/evm/evm_crypto.c   | 37 ++++++++++++++++++++++++++---
> ------
>  security/integrity/evm/evm_main.c     | 23 ++++++++++++++--------
>  security/integrity/ima/ima_appraise.c |  6 ++++--
>  security/integrity/integrity.h        |  2 ++
>  6 files changed, 51 insertions(+), 20 deletions(-)
> 
> diff --git a/include/linux/integrity.h b/include/linux/integrity.h index
> c2d6082a1a4c..858d3f4a2241 100644
> --- a/include/linux/integrity.h
> +++ b/include/linux/integrity.h
> @@ -14,6 +14,7 @@
> 
>  enum integrity_status {
>  	INTEGRITY_PASS = 0,
> +	INTEGRITY_PASS_IMMUTABLE,
>  	INTEGRITY_FAIL,
>  	INTEGRITY_NOLABEL,
>  	INTEGRITY_NOXATTRS,
> diff --git a/security/integrity/evm/evm.h b/security/integrity/evm/evm.h
> index f5f12727771a..2ff02459fcfd 100644
> --- a/security/integrity/evm/evm.h
> +++ b/security/integrity/evm/evm.h
> @@ -48,7 +48,7 @@ int evm_calc_hmac(struct dentry *dentry, const char
> *req_xattr_name,
>  		  size_t req_xattr_value_len, char *digest);  int
> evm_calc_hash(struct dentry *dentry, const char *req_xattr_name,
>  		  const char *req_xattr_value,
> -		  size_t req_xattr_value_len, char *digest);
> +		  size_t req_xattr_value_len, char type, char *digest);
>  int evm_init_hmac(struct inode *inode, const struct xattr *xattr,
>  		  char *hmac_val);
>  int evm_init_secfs(void);
> diff --git a/security/integrity/evm/evm_crypto.c
> b/security/integrity/evm/evm_crypto.c
> index 1d32cd20009a..8855722529d4 100644
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
> @@ -149,8 +149,13 @@ static void hmac_add_misc(struct shash_desc *desc,
> struct inode *inode,
>  	} hmac_misc;
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
>  	 * them in the filesystems user namespace allows an attack @@ -
> 163,7 +168,8 @@ static void hmac_add_misc(struct shash_desc *desc, struct
> inode *inode,
>  	hmac_misc.gid = from_kgid(&init_user_ns, inode->i_gid);
>  	hmac_misc.mode = inode->i_mode;
>  	crypto_shash_update(desc, (const u8 *)&hmac_misc,
> sizeof(hmac_misc));
> -	if (evm_hmac_attrs & EVM_ATTR_FSUUID)
> +	if ((evm_hmac_attrs & EVM_ATTR_FSUUID) &&
> +	    type != EVM_XATTR_PORTABLE_DIGSIG)
>  		crypto_shash_update(desc, &inode->i_sb->s_uuid.b[0],
>  				    sizeof(inode->i_sb->s_uuid));
>  	crypto_shash_final(desc, digest);
> @@ -189,6 +195,7 @@ static int evm_calc_hmac_or_hash(struct dentry
> *dentry,
>  	char *xattr_value = NULL;
>  	int error;
>  	int size;
> +	bool ima_present = false;
> 
>  	if (!(inode->i_opflags & IOP_XATTR))
>  		return -EOPNOTSUPP;
> @@ -199,11 +206,18 @@ static int evm_calc_hmac_or_hash(struct dentry
> *dentry,
> 
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
> *)req_xattr_value,
>  					     req_xattr_value_len);
> +			if (is_ima)
> +				ima_present = true;
>  			continue;
>  		}
>  		size = vfs_getxattr_alloc(dentry, *xattrname, @@ -218,9
> +232,14 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
>  		error = 0;
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
> char *req_xattr_name,
>  		  char *digest)
>  {
>  	return evm_calc_hmac_or_hash(dentry, req_xattr_name,
> req_xattr_value,
> -				req_xattr_value_len, EVM_XATTR_HMAC,
> digest);
> +			       req_xattr_value_len, EVM_XATTR_HMAC, digest);
>  }
> 
>  int evm_calc_hash(struct dentry *dentry, const char *req_xattr_name,
>  		  const char *req_xattr_value, size_t req_xattr_value_len,
> -		  char *digest)
> +		  char type, char *digest)
>  {
>  	return evm_calc_hmac_or_hash(dentry, req_xattr_name,
> req_xattr_value,
> -				req_xattr_value_len, IMA_XATTR_DIGEST,
> digest);
> +				     req_xattr_value_len, type, digest);
>  }
> 
>  /*
> @@ -280,7 +299,7 @@ int evm_init_hmac(struct inode *inode, const struct
> xattr *lsm_xattr,
>  	}
> 
>  	crypto_shash_update(desc, lsm_xattr->value, lsm_xattr->value_len);
> -	hmac_add_misc(desc, inode, hmac_val);
> +	hmac_add_misc(desc, inode, EVM_XATTR_HMAC, hmac_val);
>  	kfree(desc);
>  	return 0;
>  }
> diff --git a/security/integrity/evm/evm_main.c
> b/security/integrity/evm/evm_main.c
> index 063d38aef64e..7ab633eab576 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -120,7 +120,8 @@ static enum integrity_status evm_verify_hmac(struct
> dentry *dentry,
>  	enum integrity_status evm_status = INTEGRITY_PASS;
>  	int rc, xattr_len;
> 
> -	if (iint && iint->evm_status == INTEGRITY_PASS)
> +	if (iint && (iint->evm_status == INTEGRITY_PASS ||
> +		     iint->evm_status == INTEGRITY_PASS_IMMUTABLE))
>  		return iint->evm_status;
> 
>  	/* if status is not PASS, try to check again - against -ENOMEM */ @@
> -161,22 +162,25 @@ static enum integrity_status evm_verify_hmac(struct
> dentry *dentry,
>  			rc = -EINVAL;
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
>  					(const char *)xattr_data, xattr_len,
>  					calc.digest, sizeof(calc.digest));
>  		if (!rc) {
> -			/* Replace RSA with HMAC if not mounted readonly
> and
> -			 * not immutable
> -			 */
> -			if (!IS_RDONLY(d_backing_inode(dentry)) &&
> -			    !IS_IMMUTABLE(d_backing_inode(dentry)))
> +			if (xattr_data->type ==
> EVM_XATTR_PORTABLE_DIGSIG) {
> +				iint->flags |= EVM_IMMUTABLE_DIGSIG;
> +				evm_status = INTEGRITY_PASS_IMMUTABLE;
> +			} else if (!IS_RDONLY(d_backing_inode(dentry)) &&
> +				   !IS_IMMUTABLE(d_backing_inode(dentry)))
> {
>  				evm_update_evmxattr(dentry, xattr_name,
>  						    xattr_value,
>  						    xattr_value_len);
> +			}
>  		}
>  		break;
>  	default:
> @@ -292,6 +296,7 @@ static int evm_protect_xattr(struct dentry *dentry,
> const char *xattr_name,
>  			return 0;
>  		evm_status = evm_verify_current_integrity(dentry);
>  		if ((evm_status == INTEGRITY_PASS) ||
> +		    (evm_status == INTEGRITY_PASS_IMMUTABLE) ||
>  		    (evm_status == INTEGRITY_NOXATTRS))
>  			return 0;
>  		goto out;
> @@ -345,7 +350,8 @@ int evm_inode_setxattr(struct dentry *dentry, const
> char *xattr_name,
>  	if (strcmp(xattr_name, XATTR_NAME_EVM) == 0) {
>  		if (!xattr_value_len)
>  			return -EINVAL;
> -		if (xattr_data->type != EVM_IMA_XATTR_DIGSIG)
> +		if (xattr_data->type != EVM_IMA_XATTR_DIGSIG &&
> +		    xattr_data->type != EVM_XATTR_PORTABLE_DIGSIG)
>  			return -EPERM;
>  	}
>  	return evm_protect_xattr(dentry, xattr_name, xattr_value, @@ -
> 432,6 +438,7 @@ int evm_inode_setattr(struct dentry *dentry, struct iattr
> *attr)
>  		return 0;
>  	evm_status = evm_verify_current_integrity(dentry);
>  	if ((evm_status == INTEGRITY_PASS) ||
> +	    (evm_status == INTEGRITY_PASS_IMMUTABLE) ||
>  	    (evm_status == INTEGRITY_NOXATTRS))
>  		return 0;

Something is wrong here?
When integrity verification pass, this code WILL ALLOW to change attribute.
But it is not possible... next time integrity verification will fail?
Or I miss something?

>  	integrity_audit_msg(AUDIT_INTEGRITY_METADATA,
> d_backing_inode(dentry), diff --git a/security/integrity/ima/ima_appraise.c
> b/security/integrity/ima/ima_appraise.c
> index 809ba70fbbbf..6e277c5c7829 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -229,7 +229,9 @@ int ima_appraise_measurement(enum ima_hooks
> func,
>  	}
> 
>  	status = evm_verifyxattr(dentry, XATTR_NAME_IMA, xattr_value, rc,
> iint);
> -	if ((status != INTEGRITY_PASS) && (status != INTEGRITY_UNKNOWN))
> {
> +	if ((status != INTEGRITY_PASS) &&
> +	    (status != INTEGRITY_PASS_IMMUTABLE) &&
> +	    (status != INTEGRITY_UNKNOWN)) {
>  		if ((status == INTEGRITY_NOLABEL)
>  		    || (status == INTEGRITY_NOXATTRS))
>  			cause = "missing-HMAC";
> @@ -317,7 +319,7 @@ void ima_update_xattr(struct integrity_iint_cache
> *iint, struct file *file)
>  	int rc = 0;
> 
>  	/* do not collect and update hash for digital signatures */
> -	if (iint->flags & IMA_DIGSIG)
> +	if (iint->flags & IMA_DIGSIG || iint->flags &
> EVM_IMMUTABLE_DIGSIG)
>  		return;
> 
>  	rc = ima_collect_measurement(iint, file, NULL, 0, ima_hash_algo); diff
> --git a/security/integrity/integrity.h b/security/integrity/integrity.h index
> a53e7e4ab06c..cbc7de33fac7 100644
> --- a/security/integrity/integrity.h
> +++ b/security/integrity/integrity.h
> @@ -33,6 +33,7 @@
>  #define IMA_DIGSIG_REQUIRED	0x02000000
>  #define IMA_PERMIT_DIRECTIO	0x04000000
>  #define IMA_NEW_FILE		0x08000000
> +#define EVM_IMMUTABLE_DIGSIG	0x10000000
> 
>  #define IMA_DO_MASK		(IMA_MEASURE | IMA_APPRAISE |
> IMA_AUDIT | \
>  				 IMA_APPRAISE_SUBMASK)
> @@ -58,6 +59,7 @@ enum evm_ima_xattr_type {
>  	EVM_XATTR_HMAC,
>  	EVM_IMA_XATTR_DIGSIG,
>  	IMA_XATTR_DIGEST_NG,
> +	EVM_XATTR_PORTABLE_DIGSIG,
>  	IMA_XATTR_LAST
>  };
> 
> --
> 2.15.0.rc2.357.g7e34df9404-goog

Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59522 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752165AbdKCQDx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Nov 2017 12:03:53 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vA3G3ZaI077111
        for <linux-integrity@vger.kernel.org>; Fri, 3 Nov 2017 12:03:53 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2e0ujr8b0p-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 03 Nov 2017 12:03:51 -0400
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Fri, 3 Nov 2017 16:03:50 -0000
Subject: Re: [PATCH V3] EVM: Allow userland to permit modification of
 EVM-protected metadata
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthew Garrett <mjg59@google.com>, linux-integrity@vger.kernel.org
Date: Fri, 03 Nov 2017 12:03:45 -0400
In-Reply-To: <20171102221005.10190-1-mjg59@google.com>
References: <20171102221005.10190-1-mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1509725025.3416.73.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, 2017-11-02 at 15:10 -0700, Matthew Garrett wrote:
> When EVM is enabled it forbids modification of metadata are protected by
> EVM unless there is already a valid EVM signature. If any modification
> is made, the kernel will then generate a new EVM HMAC. However, this
> does not map well on use cases which use only asymmetric EVM signatures,
> as in this scenario the kernel is unable to generate new signatures.
> 
> This patch extends the /sys/kernel/security/evm interface to allow
> userland to request that modification of these xattrs be permitted. This
> is only permitted if no keys have already been loaded. In this
> configuration, modifying the metadata will invalidate the EVM appraisal
> on the file in question. This allows packaging systems to write out new
> files, set the relevant extended attributes and then move them into
> place.
> 
> There's also some refactoring of the use of evm_initialized in order to
> avoid heading down codepaths that assume there's a key available.
> 
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> ---
>  Documentation/ABI/testing/evm      | 51 +++++++++++++++++++++++++-------------
>  security/integrity/evm/evm.h       |  5 +++-
>  security/integrity/evm/evm_main.c  | 32 ++++++++++++++++++------
>  security/integrity/evm/evm_secfs.c | 14 +++++++++++
>  4 files changed, 77 insertions(+), 25 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/evm b/Documentation/ABI/testing/evm
> index d2782afb0d96..b0f54fe8d0c6 100644
> --- a/Documentation/ABI/testing/evm
> +++ b/Documentation/ABI/testing/evm
> @@ -14,28 +14,45 @@ Description:
>  		generated either locally or remotely using an
>  		asymmetric key. These keys are loaded onto root's
>  		keyring using keyctl, and EVM is then enabled by
> -		echoing a value to <securityfs>/evm:
> +		echoing a value to <securityfs>/evm made up of the
> +		following bits:
> 
> -		1: enable HMAC validation and creation
> -		2: enable digital signature validation
> -		3: enable HMAC and digital signature validation and HMAC
> -		   creation
> +		Bit	  Effect
> +		0	  Enable HMAC validation and creation

The code and documentation do not seem to be in sync.  Dracut is
currently using 1 to indicate the HMAC key has been loaded.  

> +		1	  Enable digital signature validation
> +		2	  Permit modification of EVM-protected metadata at
> +			  runtime. Not supported if HMAC validation and
> +			  creation is enabled.
> +		31	  Disable further runtime modification of EVM policy
> 
> -		Further writes will be blocked if HMAC support is enabled or
> -		if bit 32 is set:
> +		For example:
> 
> -		echo 0x80000002 ><securityfs>/evm
> +		echo 1 ><securityfs>/evm
> 
> -		will enable digital signature validation and block
> -		further writes to <securityfs>/evm.
> +		will enable HMAC validation and creation
> 
> -		Until this is done, EVM can not create or validate the
> -		'security.evm' xattr, but returns INTEGRITY_UNKNOWN.
> -		Loading keys and signaling EVM should be done as early
> -		as possible.  Normally this is done in the initramfs,
> -		which has already been measured as part of the trusted
> -		boot.  For more information on creating and loading
> -		existing trusted/encrypted keys, refer to:
> +		echo 0x80000003 ><securityfs>/evm
> +
> +		will enable HMAC and digital signature validation and
> +		HMAC creation and disable all further modification of policy.
> +
> +		echo 0x80000006 ><securityfs>/evm

4 is missing above.

> +
> +		will enable digital signature validation, permit
> +		modification of EVM-protected metadata and
> +		disable all further modification of policy
> +
> +		Note that once a key has been loaded, it will no longer be
> +		possible to enable metadata modification.
> +
> +		Until key loading has been signaled EVM can not create
> +		or validate the 'security.evm' xattr, but returns
> +		INTEGRITY_UNKNOWN.  Loading keys and signaling EVM
> +		should be done as early as possible.  Normally this is
> +		done in the initramfs, which has already been measured
> +		as part of the trusted boot.  For more information on
> +		creating and loading existing trusted/encrypted keys,
> +		refer to:
>  		Documentation/keys-trusted-encrypted.txt. Both dracut
>  		(via 97masterkey and 98integrity) and systemd (via
>  		core/ima-setup) have support for loading keys at boot
> diff --git a/security/integrity/evm/evm.h b/security/integrity/evm/evm.h
> index 946efffcc389..6c63db19fbcf 100644
> --- a/security/integrity/evm/evm.h
> +++ b/security/integrity/evm/evm.h
> @@ -23,9 +23,12 @@
> 
>  #define EVM_INIT_HMAC	0x0001
>  #define EVM_INIT_X509	0x0002
> +#define EVM_ALLOW_METADATA_WRITES	0x0004
>  #define EVM_SETUP       0x80000000 /* userland has signaled key load */

Sorry for not commenting earlier on this bit's naming, but it's
confusing.  Perhaps something like EVM_SETUP_COMPLETED/FINISHED?

> 
> -#define EVM_INIT_MASK (EVM_INIT_HMAC | EVM_INIT_X509 | EVM_SETUP)
> +#define EVM_KEY_MASK (EVM_INIT_HMAC | EVM_INIT_X509)
> +#define EVM_INIT_MASK (EVM_INIT_HMAC | EVM_INIT_X509 | EVM_SETUP | \
> +		       EVM_ALLOW_METADATA_WRITES)
> 
>  extern int evm_initialized;
>  extern char *evm_hmac;
> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
> index 675a835b6d6d..0788fd08b509 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -73,6 +73,11 @@ static void __init evm_init_config(void)
>  	pr_info("HMAC attrs: 0x%x\n", evm_hmac_attrs);
>  }
> 
> +static bool evm_key_loaded(void)
> +{
> +	return (bool)(evm_initialized & EVM_KEY_MASK);
> +}
> +/

>  static int evm_find_protected_xattrs(struct dentry *dentry)
>  {
>  	struct inode *inode = d_backing_inode(dentry);
> @@ -243,7 +248,7 @@ enum integrity_status evm_verifyxattr(struct dentry *dentry,
>  				      void *xattr_value, size_t xattr_value_len,
>  				      struct integrity_iint_cache *iint)
>  {
> -	if (!evm_initialized || !evm_protected_xattr(xattr_name))
> +	if (!evm_key_loaded() || !evm_protected_xattr(xattr_name))
>  		return INTEGRITY_UNKNOWN;
> 
>  	if (!iint) {
> @@ -267,7 +272,7 @@ static enum integrity_status evm_verify_current_integrity(struct dentry *dentry)
>  {
>  	struct inode *inode = d_backing_inode(dentry);
> 
> -	if (!evm_initialized || !S_ISREG(inode->i_mode) || evm_fixmode)
> +	if (!evm_key_loaded() || !S_ISREG(inode->i_mode) || evm_fixmode)
>  		return 0;
>  	return evm_verify_hmac(dentry, NULL, NULL, 0, NULL);
>  }
> @@ -302,6 +307,7 @@ static int evm_protect_xattr(struct dentry *dentry, const char *xattr_name,
>  			return 0;
>  		goto out;
>  	}
> +
>  	evm_status = evm_verify_current_integrity(dentry);
>  	if (evm_status == INTEGRITY_NOXATTRS) {
>  		struct integrity_iint_cache *iint;
> @@ -348,6 +354,10 @@ int evm_inode_setxattr(struct dentry *dentry, const char *xattr_name,
>  {
>  	const struct evm_ima_xattr_data *xattr_data = xattr_value;
> 
> +	/* Policy permits modification of the protected xattrs */
> +	if (evm_initialized & EVM_ALLOW_METADATA_WRITES)
> +		return 0;
> +
>  	if (strcmp(xattr_name, XATTR_NAME_EVM) == 0) {
>  		if (!xattr_value_len)
>  			return -EINVAL;
> @@ -369,6 +379,10 @@ int evm_inode_setxattr(struct dentry *dentry, const char *xattr_name,
>   */
>  int evm_inode_removexattr(struct dentry *dentry, const char *xattr_name)
>  {
> +	/* Policy permits modification of the protected xattrs */
> +	if (evm_initialized & EVM_ALLOW_METADATA_WRITES)
> +		return 0;
> +
>  	return evm_protect_xattr(dentry, xattr_name, NULL, 0);
>  }
> 
> @@ -397,8 +411,8 @@ static void evm_reset_status(struct inode *inode)
>  void evm_inode_post_setxattr(struct dentry *dentry, const char *xattr_name,
>  			     const void *xattr_value, size_t xattr_value_len)
>  {
> -	if (!evm_initialized || (!evm_protected_xattr(xattr_name)
> -				 && !posix_xattr_acl(xattr_name)))
> +	if (!evm_key_loaded() || (!evm_protected_xattr(xattr_name)
> +				  && !posix_xattr_acl(xattr_name)))
>  		return;
> 
>  	evm_reset_status(dentry->d_inode);
> @@ -418,7 +432,7 @@ void evm_inode_post_setxattr(struct dentry *dentry, const char *xattr_name,
>   */
>  void evm_inode_post_removexattr(struct dentry *dentry, const char *xattr_name)
>  {
> -	if (!evm_initialized || !evm_protected_xattr(xattr_name))
> +	if (!evm_key_loaded() || !evm_protected_xattr(xattr_name))
>  		return;
> 
>  	evm_reset_status(dentry->d_inode);
> @@ -435,6 +449,10 @@ int evm_inode_setattr(struct dentry *dentry, struct iattr *attr)
>  	unsigned int ia_valid = attr->ia_valid;
>  	enum integrity_status evm_status;
> 
> +	/* Policy permits modification of the protected attrs */

Could we indicate that there is no HMAC key loaded.

> +	if (evm_initialized & EVM_ALLOW_METADATA_WRITES)
> +		return 0;
> +
>  	if (!(ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID)))
>  		return 0;
>  	evm_status = evm_verify_current_integrity(dentry);
> @@ -460,7 +478,7 @@ int evm_inode_setattr(struct dentry *dentry, struct iattr *attr)
>   */
>  void evm_inode_post_setattr(struct dentry *dentry, int ia_valid)
>  {
> -	if (!evm_initialized)
> +	if (!evm_key_loaded())
>  		return;
> 
>  	if (ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID))
> @@ -477,7 +495,7 @@ int evm_inode_init_security(struct inode *inode,
>  	struct evm_ima_xattr_data *xattr_data;
>  	int rc;
> 
> -	if (!evm_initialized || !evm_protected_xattr(lsm_xattr->name))
> +	if (!evm_key_loaded() || !evm_protected_xattr(lsm_xattr->name))
>  		return 0;
> 
>  	xattr_data = kzalloc(sizeof(*xattr_data), GFP_NOFS);
> diff --git a/security/integrity/evm/evm_secfs.c b/security/integrity/evm/evm_secfs.c
> index 319cf16d6603..ee8e3abb7dbb 100644
> --- a/security/integrity/evm/evm_secfs.c
> +++ b/security/integrity/evm/evm_secfs.c
> @@ -75,6 +75,14 @@ static ssize_t evm_write_key(struct file *file, const char __user *buf,
>  	if (!i || (i & ~EVM_INIT_MASK) != 0)
>  		return -EINVAL;
> 
> +	/* Don't allow a request to freshly enable metadata writes if
> +	 * keys are loaded.
> +	 */
> +	if ((i & EVM_ALLOW_METADATA_WRITES) &&
> +	    ((evm_initialized & EVM_KEY_MASK) != 0) &&
> +	    !(evm_initialized & EVM_ALLOW_METADATA_WRITES))

Ok, not sure that the "(evm_initialized & EVM_ALLOW_METADATA_WRITES)"
is needed, but it doesn't hurt.

Mimi

> +		return -EPERM;
> +
>  	if (i & EVM_INIT_HMAC) {
>  		ret = evm_init_key();
>  		if (ret != 0)
> @@ -85,6 +93,12 @@ static ssize_t evm_write_key(struct file *file, const char __user *buf,
> 
>  	evm_initialized |= i;
> 
> +	/* Don't allow protected metadata modification if a symmetric key
> +	 * is loaded
> +	 */
> +	if (evm_initialized & EVM_INIT_HMAC)
> +		evm_initialized &= ~(EVM_ALLOW_METADATA_WRITES);
> +
>  	return count;
>  }
> 

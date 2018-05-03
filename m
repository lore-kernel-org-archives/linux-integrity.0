Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50778 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751929AbeECCtR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 2 May 2018 22:49:17 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w432nChX011135
        for <linux-integrity@vger.kernel.org>; Wed, 2 May 2018 22:49:17 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2hqscrh419-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 02 May 2018 22:49:15 -0400
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Thu, 3 May 2018 03:48:45 +0100
Subject: Re: [PATCH V3 1/2] EVM: turn evm_config_xattrnames into a list
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthew Garrett <mjg59@google.com>, linux-integrity@vger.kernel.org
Date: Wed, 02 May 2018 22:48:42 -0400
In-Reply-To: <20180501175124.192587-1-mjg59@google.com>
References: <20180501175124.192587-1-mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1525315722.3238.46.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, 2018-05-01 at 10:51 -0700, Matthew Garrett wrote:
> Use a list of xattrs rather than an array - this makes it easier to
> extend the list at runtime.

Thank you for making this a separate patch.

Once the list is initialized, additional xattrs aren't being added in
this patch. So by itself this patch doesn't require locking, but the
next patch extends the list.  Wouldn't the list then require some form
of locking (eg. RCU)?

Mimi


> Signed-off-by: Matthew Garrett <mjg59@google.com>
> ---
>  security/integrity/evm/evm.h        |  7 ++-
>  security/integrity/evm/evm_crypto.c | 10 ++--
>  security/integrity/evm/evm_main.c   | 72 +++++++++++++++++++----------
>  3 files changed, 59 insertions(+), 30 deletions(-)
> 
> diff --git a/security/integrity/evm/evm.h b/security/integrity/evm/evm.h
> index 45c4a89c02ff..1257c3c24723 100644
> --- a/security/integrity/evm/evm.h
> +++ b/security/integrity/evm/evm.h
> @@ -30,6 +30,11 @@
>  #define EVM_INIT_MASK (EVM_INIT_HMAC | EVM_INIT_X509 | EVM_SETUP_COMPLETE | \
>  		       EVM_ALLOW_METADATA_WRITES)
> 
> +struct xattr_list {
> +	struct list_head list;
> +	char *name;
> +};
> +
>  extern int evm_initialized;
> 
>  #define EVM_ATTR_FSUUID		0x0001
> @@ -40,7 +45,7 @@ extern struct crypto_shash *hmac_tfm;
>  extern struct crypto_shash *hash_tfm;
> 
>  /* List of EVM protected security xattrs */
> -extern char *evm_config_xattrnames[];
> +extern struct list_head evm_config_xattrnames;
> 
>  int evm_init_key(void);
>  int evm_update_evmxattr(struct dentry *dentry,
> diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
> index a46fba322340..caeea20670cc 100644
> --- a/security/integrity/evm/evm_crypto.c
> +++ b/security/integrity/evm/evm_crypto.c
> @@ -192,8 +192,8 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
>  				char type, char *digest)
>  {
>  	struct inode *inode = d_backing_inode(dentry);
> +	struct xattr_list *xattr;
>  	struct shash_desc *desc;
> -	char **xattrname;
>  	size_t xattr_size = 0;
>  	char *xattr_value = NULL;
>  	int error;
> @@ -208,14 +208,14 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
>  		return PTR_ERR(desc);
> 
>  	error = -ENODATA;
> -	for (xattrname = evm_config_xattrnames; *xattrname != NULL; xattrname++) {
> +	list_for_each_entry(xattr, &evm_config_xattrnames, list) {
>  		bool is_ima = false;
> 
> -		if (strcmp(*xattrname, XATTR_NAME_IMA) == 0)
> +		if (strcmp(xattr->name, XATTR_NAME_IMA) == 0)
>  			is_ima = true;
> 
>  		if ((req_xattr_name && req_xattr_value)
> -		    && !strcmp(*xattrname, req_xattr_name)) {
> +		    && !strcmp(xattr->name, req_xattr_name)) {
>  			error = 0;
>  			crypto_shash_update(desc, (const u8 *)req_xattr_value,
>  					     req_xattr_value_len);
> @@ -223,7 +223,7 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
>  				ima_present = true;
>  			continue;
>  		}
> -		size = vfs_getxattr_alloc(dentry, *xattrname,
> +		size = vfs_getxattr_alloc(dentry, xattr->name,
>  					  &xattr_value, xattr_size, GFP_NOFS);
>  		if (size == -ENOMEM) {
>  			error = -ENOMEM;
> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
> index 9ea9c19a545c..dd2415c55982 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -35,28 +35,29 @@ static const char * const integrity_status_msg[] = {
>  };
>  int evm_hmac_attrs;
> 
> -char *evm_config_xattrnames[] = {
> +static struct xattr_list evm_config_default_xattrnames[] __ro_after_init = {
>  #ifdef CONFIG_SECURITY_SELINUX
> -	XATTR_NAME_SELINUX,
> +	{.name = XATTR_NAME_SELINUX},
>  #endif
>  #ifdef CONFIG_SECURITY_SMACK
> -	XATTR_NAME_SMACK,
> +	{.name = XATTR_NAME_SMACK},
>  #ifdef CONFIG_EVM_EXTRA_SMACK_XATTRS
> -	XATTR_NAME_SMACKEXEC,
> -	XATTR_NAME_SMACKTRANSMUTE,
> -	XATTR_NAME_SMACKMMAP,
> +	{.name = XATTR_NAME_SMACKEXEC},
> +	{.name = XATTR_NAME_SMACKTRANSMUTE},
> +	{.name = XATTR_NAME_SMACKMMAP},
>  #endif
>  #endif
>  #ifdef CONFIG_SECURITY_APPARMOR
> -	XATTR_NAME_APPARMOR,
> +	{.name = XATTR_NAME_APPARMOR},
>  #endif
>  #ifdef CONFIG_IMA_APPRAISE
> -	XATTR_NAME_IMA,
> +	{.name = XATTR_NAME_IMA},
>  #endif
> -	XATTR_NAME_CAPS,
> -	NULL
> +	{.name = XATTR_NAME_CAPS},
>  };
> 
> +LIST_HEAD(evm_config_xattrnames);
> +
>  static int evm_fixmode;
>  static int __init evm_set_fixmode(char *str)
>  {
> @@ -68,6 +69,14 @@ __setup("evm=", evm_set_fixmode);
> 
>  static void __init evm_init_config(void)
>  {
> +	int i, xattrs;
> +
> +	xattrs = ARRAY_SIZE(evm_config_default_xattrnames);
> +
> +	for (i = 0; i < xattrs; i++)
> +		list_add_tail(&evm_config_default_xattrnames[i].list,
> +			      &evm_config_xattrnames);
> +
>  #ifdef CONFIG_EVM_ATTR_FSUUID
>  	evm_hmac_attrs |= EVM_ATTR_FSUUID;
>  #endif
> @@ -82,15 +91,15 @@ static bool evm_key_loaded(void)
>  static int evm_find_protected_xattrs(struct dentry *dentry)
>  {
>  	struct inode *inode = d_backing_inode(dentry);
> -	char **xattr;
> +	struct xattr_list *xattr;
>  	int error;
>  	int count = 0;
> 
>  	if (!(inode->i_opflags & IOP_XATTR))
>  		return -EOPNOTSUPP;
> 
> -	for (xattr = evm_config_xattrnames; *xattr != NULL; xattr++) {
> -		error = __vfs_getxattr(dentry, inode, *xattr, NULL, 0);
> +	list_for_each_entry(xattr, &evm_config_xattrnames, list) {
> +		error = __vfs_getxattr(dentry, inode, xattr->name, NULL, 0);
>  		if (error < 0) {
>  			if (error == -ENODATA)
>  				continue;
> @@ -211,24 +220,25 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
> 
>  static int evm_protected_xattr(const char *req_xattr_name)
>  {
> -	char **xattrname;
>  	int namelen;
>  	int found = 0;
> +	struct xattr_list *xattr;
> 
>  	namelen = strlen(req_xattr_name);
> -	for (xattrname = evm_config_xattrnames; *xattrname != NULL; xattrname++) {
> -		if ((strlen(*xattrname) == namelen)
> -		    && (strncmp(req_xattr_name, *xattrname, namelen) == 0)) {
> +	list_for_each_entry(xattr, &evm_config_xattrnames, list) {
> +		if ((strlen(xattr->name) == namelen)
> +		    && (strncmp(req_xattr_name, xattr->name, namelen) == 0)) {
>  			found = 1;
>  			break;
>  		}
>  		if (strncmp(req_xattr_name,
> -			    *xattrname + XATTR_SECURITY_PREFIX_LEN,
> +			    xattr->name + XATTR_SECURITY_PREFIX_LEN,
>  			    strlen(req_xattr_name)) == 0) {
>  			found = 1;
>  			break;
>  		}
>  	}
> +
>  	return found;
>  }
> 
> @@ -544,20 +554,33 @@ void __init evm_load_x509(void)
>  static int __init init_evm(void)
>  {
>  	int error;
> +	struct list_head *pos, *q;
> +	struct xattr_list *xattr;
> 
>  	evm_init_config();
> 
>  	error = integrity_init_keyring(INTEGRITY_KEYRING_EVM);
>  	if (error)
> -		return error;
> +		goto error;
> 
>  	error = evm_init_secfs();
>  	if (error < 0) {
>  		pr_info("Error registering secfs\n");
> -		return error;
> +		goto error;
>  	}
> 
> -	return 0;
> +error:
> +	if (error != 0) {
> +		if (!list_empty(&evm_config_xattrnames)) {
> +			list_for_each_safe(pos, q, &evm_config_xattrnames) {
> +				xattr = list_entry(pos, struct xattr_list,
> +						   list);
> +				list_del(pos);
> +			}
> +		}
> +	}
> +
> +	return error;
>  }
> 
>  /*
> @@ -565,10 +588,11 @@ static int __init init_evm(void)
>   */
>  static int __init evm_display_config(void)
>  {
> -	char **xattrname;
> +	struct xattr_list *xattr;
> +
> +	list_for_each_entry(xattr, &evm_config_xattrnames, list)
> +		pr_info("%s\n", xattr->name);
> 
> -	for (xattrname = evm_config_xattrnames; *xattrname != NULL; xattrname++)
> -		pr_info("%s\n", *xattrname);
>  	return 0;
>  }
> 

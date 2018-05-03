Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46288 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751956AbeECDRS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 2 May 2018 23:17:18 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w433Gar2061468
        for <linux-integrity@vger.kernel.org>; Wed, 2 May 2018 23:17:18 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2hqn3ct8bj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 02 May 2018 23:17:17 -0400
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Thu, 3 May 2018 04:17:15 +0100
Subject: Re: [PATCH V3 2/2] EVM: Allow runtime modification of the set of
 verified xattrs
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthew Garrett <mjg59@google.com>, linux-integrity@vger.kernel.org
Date: Wed, 02 May 2018 23:17:10 -0400
In-Reply-To: <20180501175124.192587-2-mjg59@google.com>
References: <20180501175124.192587-1-mjg59@google.com>
         <20180501175124.192587-2-mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1525317430.3238.58.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, 2018-05-01 at 10:51 -0700, Matthew Garrett wrote:
> Sites may wish to provide additional metadata alongside files in order
> to make more fine-grained security decisions[1]. The security of this is
> enhanced if this metadata is protected, something that EVM makes
> possible. However, the kernel cannot know about the set of extended
> attributes that local admins may wish to protect, and hardcoding this
> policy in the kernel makes it difficult to change over time and less
> convenient for distributions to enable.
> 
> This patch adds a new /sys/kernel/security/evm_xattrs node, which can be
> read to obtain the current set of EVM-protected extended attributes or
> written to in order to add new entries. Extending this list will not
> change the validity of any existing signatures provided that the file
> in question does not have any of the additional extended attributes -
> missing xattrs are skipped when calculating the EVM hash.
> 
> [1] For instance, a package manager could install information about the
> package uploader in an additional extended attribute. Local LSM policy
> could then be associated with that extended attribute in order to
> restrict the privileges available to packages from less trusted
> uploaders.
> 
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> ---
>  Documentation/ABI/testing/evm      |  13 ++++
>  security/integrity/evm/evm_secfs.c | 102 +++++++++++++++++++++++++++--
>  2 files changed, 109 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/evm b/Documentation/ABI/testing/evm
> index d12cb2eae9ee..bfe529eb26b2 100644
> --- a/Documentation/ABI/testing/evm
> +++ b/Documentation/ABI/testing/evm
> @@ -57,3 +57,16 @@ Description:
>  		dracut (via 97masterkey and 98integrity) and systemd (via
>  		core/ima-setup) have support for loading keys at boot
>  		time.
> +
> +What:		security/evm_xattrs
> +Date:		April 2018
> +Contact:	Matthew Garrett <mjg59@google.com>
> +Description:
> +		Shows the set of extended attributes used to calculate or
> +		validate the EVM signature, and allows additional attributes
> +		to be added at runtime. Adding additional extended attributes
> +		will result in any existing signatures generated without the
> +		additional attributes becoming invalid, and any signatures
> +		generated after additional attributes are added will only be
> +		valid if the same additional attributes are configured on
> +		system boot.

This needs to be updated ...

> diff --git a/security/integrity/evm/evm_secfs.c b/security/integrity/evm/evm_secfs.c
> index feba03bbedae..3b371125d439 100644
> --- a/security/integrity/evm/evm_secfs.c
> +++ b/security/integrity/evm/evm_secfs.c
> @@ -20,6 +20,7 @@
>  #include "evm.h"
> 
>  static struct dentry *evm_init_tpm;
> +static struct dentry *evm_xattrs;
> 
>  /**
>   * evm_read_key - read() for <securityfs>/evm
> @@ -107,13 +108,102 @@ static const struct file_operations evm_key_ops = {
>  	.write		= evm_write_key,
>  };
> 
> -int __init evm_init_secfs(void)
> +/**
> + * evm_read_xattrs - read() for <securityfs>/evm_xattrs
> + *
> + * @filp: file pointer, not actually used
> + * @buf: where to put the result
> + * @count: maximum to send along
> + * @ppos: where to start
> + *
> + * Returns number of bytes read or error code, as appropriate
> + */
> +static ssize_t evm_read_xattrs(struct file *filp, char __user *buf,
> +			       size_t count, loff_t *ppos)
>  {
> -	int error = 0;
> +	char *temp;
> +	int offset = 0;
> +	ssize_t rc, size = 0;
> +	struct xattr_list *xattr;
> +
> +	if (*ppos != 0)
> +		return 0;
> 
> -	evm_init_tpm = securityfs_create_file("evm", S_IRUSR | S_IRGRP,
> -					      NULL, NULL, &evm_key_ops);
> +	list_for_each_entry(xattr, &evm_config_xattrnames, list)
> +		size += strlen(xattr->name) + 1;
> +
> +	temp = kmalloc(size + 1, GFP_KERNEL);
> +	if (!temp)
> +		return -ENOMEM;
> +
> +	list_for_each_entry(xattr, &evm_config_xattrnames, list) {
> +		sprintf(temp + offset, "%s\n", xattr->name);
> +		offset += strlen(xattr->name) + 1;
> +	}
> +
> +	rc = simple_read_from_buffer(buf, count, ppos, temp, strlen(temp));
> +
> +	return rc;
> +}
> +
> +/**
> + * evm_write_xattrs - write() for <securityfs>/evm_xattrs
> + * @file: file pointer, not actually used
> + * @buf: where to get the data from
> + * @count: bytes sent
> + * @ppos: where to start
> + *
> + * Returns number of bytes written or error code, as appropriate
> + */
> +static ssize_t evm_write_xattrs(struct file *file, const char __user *buf,
> +				size_t count, loff_t *ppos)
> +{
> +	int len;
> +	struct xattr_list *xattr;
> +
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EPERM;
> +
> +	if (*ppos != 0)
> +		return -EINVAL;

Is there a maximum xattr name size?  Should there be?

> +
> +	xattr = kmalloc(sizeof(struct xattr_list), GFP_KERNEL);
> +	if (!xattr)
> +		return -ENOMEM;
> +
> +	xattr->name = memdup_user_nul(buf, count);
> +	if (!xattr->name) {
> +		kfree(xattr);
> +		return -ENOMEM;
> +	}
> +
> +	/* Remove any trailing newline */
> +	len = strlen(xattr->name);
> +	if (xattr->name[len-1] == '\n')
> +		xattr->name[len-1] = '\0';

Shouldn't we somehow sanity check userspace provided strings, before
adding them to the list of xattrs?  Perhaps limit the string to the
upper and lower case letters?
  
> +
> +	list_add_tail(&xattr->list, &evm_config_xattrnames);
> +	return count;
> +}
> +
> +static const struct file_operations evm_xattr_ops = {
> +	.read		= evm_read_xattrs,
> +	.write		= evm_write_xattrs,
> +};
> +
> +int __init evm_init_secfs(void)
> +{
> +	evm_init_tpm = securityfs_create_file("evm", 0440, NULL, NULL,
> +					      &evm_key_ops);
>  	if (!evm_init_tpm || IS_ERR(evm_init_tpm))
> -		error = -EFAULT;
> -	return error;
> +		return -EFAULT;
> +
> +	evm_xattrs = securityfs_create_file("evm_xattrs", 0440, NULL, NULL,
> +					    &evm_xattr_ops);
> +	if (!evm_xattrs || IS_ERR(evm_xattrs)) {
> +		securityfs_remove(evm_init_tpm);
> +		return -EFAULT;
> +	}
> +

Do we really want this feature unconditionally enabled?  How often do
you expect to add xattrs?  Is there ever a point where you would want
to lock the list of xattrs from changing?

Mimi

> +	return 0;
>  }

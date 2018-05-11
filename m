Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44766 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751828AbeEKEmE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 May 2018 00:42:04 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4B4dNij043018
        for <linux-integrity@vger.kernel.org>; Fri, 11 May 2018 00:42:04 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2hw3m5hneb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 11 May 2018 00:42:03 -0400
Received: from localhost
        by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Fri, 11 May 2018 05:42:02 +0100
Subject: Re: [PATCH V4 2/2] EVM: Allow runtime modification of the set of
 verified xattrs
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthew Garrett <mjg59@google.com>, linux-integrity@vger.kernel.org
Date: Fri, 11 May 2018 00:41:58 -0400
In-Reply-To: <20180509202811.29875-2-mjg59@google.com>
References: <20180509202811.29875-1-mjg59@google.com>
         <20180509202811.29875-2-mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1526013718.3414.32.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, 2018-05-09 at 13:28 -0700, Matthew Garrett wrote:

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
> +	int len, err;
> +	struct xattr_list *xattr, *tmp;
> +
> +	if (!capable(CAP_SYS_ADMIN) || evm_xattrs_locked)
> +		return -EPERM;
> +
> +	if (*ppos != 0)
> +		return -EINVAL;
> +
> +	if (count > XATTR_NAME_MAX)
> +		return -E2BIG;
> +
> +	xattr = kmalloc(sizeof(struct xattr_list), GFP_KERNEL);
> +	if (!xattr)
> +		return -ENOMEM;
> +
> +	xattr->name = memdup_user_nul(buf, count);

Up to now, the set of protected EVM xattrs was in the security domain.
The current code permits any string in any domain.  If that is the
intention, there needs to be an explanation of the security
implications of this change at least in the patch description. 

> +	if (IS_ERR(xattr->name)) {
> +		err = PTR_ERR(xattr->name);
> +		kfree(xattr);
> +		return err;
> +	}
> +
> +	/* Remove any trailing newline */
> +	len = strlen(xattr->name);
> +	if (xattr->name[len-1] == '\n')
> +		xattr->name[len-1] = '\0';
> +
> +	if (strcmp(xattr->name, ".") == 0) {
> +		evm_xattrs_locked = 1;
> +		err = count;

Please update the file mode bits of <securityfs>/evm_xattrs.

> +		goto out;
> +	}
> +
> +	/* Guard against races in evm_read_xattrs */
> +	mutex_lock(&xattr_list_mutex);
> +	list_for_each_entry(tmp, &evm_config_xattrnames, list) {
> +		if (strcmp(xattr->name, tmp->name) == 0) {
> +			err = -EEXIST;
> +			mutex_unlock(&xattr_list_mutex);
> +			goto out;
> +		}
> +	}
> +	list_add_tail_rcu(&xattr->list, &evm_config_xattrnames);
> +	mutex_unlock(&xattr_list_mutex);
> +
> +	return count;
> +out:
> +	kfree(xattr->name);
> +	kfree(xattr);
> +	return err;
> +}
> +
> +static const struct file_operations evm_xattr_ops = {
> +	.read		= evm_read_xattrs,
> +	.write		= evm_write_xattrs,
> +};
> +
> +static int evm_init_xattrs(void)
> +{
> +	evm_xattrs = securityfs_create_file("evm_xattrs", 0440, NULL, NULL,
> +					    &evm_xattr_ops);

The mode bits should reflect the status of the current status of
evm_xattrs.  Initially it would be writeable, but later it might
change to read-only.

Should "evm_xattrs" be defined directly in the securityfs directory or
in a subdirectory similar to ima?  It will be difficult later on to
move "evm_xattrs" to a subdirectory once applications start
reading/writing to it.  What would the subdirectory be called?

Mimi

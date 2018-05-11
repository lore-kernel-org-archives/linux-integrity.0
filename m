Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48444 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750746AbeEKQ63 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 May 2018 12:58:29 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4BGiF0x045194
        for <linux-integrity@vger.kernel.org>; Fri, 11 May 2018 12:58:29 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2hwdjt4c44-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 11 May 2018 12:58:29 -0400
Received: from localhost
        by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Fri, 11 May 2018 17:58:27 +0100
Subject: Re: [PATCH V4 2/2] EVM: Allow runtime modification of the set of
 verified xattrs
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthew Garrett <mjg59@google.com>, linux-integrity@vger.kernel.org
Date: Fri, 11 May 2018 12:58:23 -0400
In-Reply-To: <20180509202811.29875-2-mjg59@google.com>
References: <20180509202811.29875-1-mjg59@google.com>
         <20180509202811.29875-2-mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1526057903.3559.2.camel@linux.vnet.ibm.com>
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

Shouldn't new xattrs be audited/logged?

Mimi

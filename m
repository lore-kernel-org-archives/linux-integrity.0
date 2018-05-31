Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41734 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755417AbeEaPr5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 31 May 2018 11:47:57 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4VFiF0d126669
        for <linux-integrity@vger.kernel.org>; Thu, 31 May 2018 11:47:56 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jahmjq6ef-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 31 May 2018 11:47:55 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Thu, 31 May 2018 16:47:54 +0100
Subject: Re: [PATCH V6] EVM: Allow runtime modification of the set of
 verified xattrs
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthew Garrett <mjg59@google.com>, linux-integrity@vger.kernel.org
Cc: Steve Grubb <sgrubb@redhat.com>, Paul Moore <paul@paul-moore.com>
Date: Thu, 31 May 2018 11:47:38 -0400
In-Reply-To: <20180515173826.21114-1-mjg59@google.com>
References: <20180515173826.21114-1-mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1527781658.3427.25.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi Matthew,

On Tue, 2018-05-15 at 10:38 -0700, Matthew Garrett wrote:

Based on the "IMA: work on audit records produced by IMA" discussion,
should this new audit record be adding the task info by calling
"audit_log_task_info(ab, current);" too?

Could you provide Steve with an example of the audit rule?

thanks!

Mimi

[...]

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
> +	struct audit_buffer *ab;
> +	struct iattr newattrs;
> +	struct inode *inode;
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
> +	ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_INTEGRITY_EVM_XATTR);
> +	if (IS_ERR(ab))
> +		return PTR_ERR(ab);
> +
> +	xattr = kmalloc(sizeof(struct xattr_list), GFP_KERNEL);
> +	if (!xattr) {
> +		err = -ENOMEM;
> +		goto out;
> +	}
> +
> +	xattr->name = memdup_user_nul(buf, count);
> +	if (IS_ERR(xattr->name)) {
> +		err = PTR_ERR(xattr->name);
> +		xattr->name = NULL;
> +		goto out;
> +	}
> +
> +	/* Remove any trailing newline */
> +	len = strlen(xattr->name);
> +	if (xattr->name[len-1] == '\n')
> +		xattr->name[len-1] = '\0';
> +
> +	if (strcmp(xattr->name, ".") == 0) {
> +		evm_xattrs_locked = 1;
> +		newattrs.ia_mode = S_IFREG | 0440;
> +		newattrs.ia_valid = ATTR_MODE;
> +		inode = evm_xattrs->d_inode;
> +		inode_lock(inode);
> +		err = simple_setattr(evm_xattrs, &newattrs);
> +		inode_unlock(inode);
> +		audit_log_format(ab, "locked");
> +		if (!err)
> +			err = count;
> +		goto out;
> +	}
> +
> +	audit_log_format(ab, "xattr=");
> +	audit_log_untrustedstring(ab, xattr->name);
> +
> +	if (strncmp(xattr->name, XATTR_SECURITY_PREFIX,
> +		    XATTR_SECURITY_PREFIX_LEN) != 0) {
> +		err = -EINVAL;
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
> +	audit_log_format(ab, " res=0");
> +	audit_log_end(ab);
> +	return count;
> +out:
> +	audit_log_format(ab, " res=%d", err);
> +	audit_log_end(ab);
> +	kfree(xattr->name);
> +	kfree(xattr);
> +	return err;
> +}

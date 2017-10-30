Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59066 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751663AbdJ3MaS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Oct 2017 08:30:18 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9UCPJhj039221
        for <linux-integrity@vger.kernel.org>; Mon, 30 Oct 2017 08:30:18 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2dx0vrtjun-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 30 Oct 2017 08:30:17 -0400
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 30 Oct 2017 12:30:15 -0000
Subject: Re: [RFC] EVM: Add support for portable signature format
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Dmitry Kasatkin <dmitry.kasatkin@huawei.com>,
        Matthew Garrett <mjg59@google.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Cc: Mikhail Kurinnoi <viewizard@viewizard.com>
Date: Mon, 30 Oct 2017 08:30:11 -0400
In-Reply-To: <C2D7A727C393B644B70DF4B4DCFB60B921C4718F@FRAEML521-MBX.china.huawei.com>
References: <20171026083144.16247-1-mjg59@google.com>
         <C2D7A727C393B644B70DF4B4DCFB60B921C4718F@FRAEML521-MBX.china.huawei.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1509366611.3583.65.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2017-10-27 at 10:27 +0000, Dmitry Kasatkin wrote:

> > @@ -345,7 +350,8 @@ int evm_inode_setxattr(struct dentry *dentry, const
> > char *xattr_name,
> >  	if (strcmp(xattr_name, XATTR_NAME_EVM) == 0) {
> >  		if (!xattr_value_len)
> >  			return -EINVAL;
> > -		if (xattr_data->type != EVM_IMA_XATTR_DIGSIG)
> > +		if (xattr_data->type != EVM_IMA_XATTR_DIGSIG &&
> > +		    xattr_data->type != EVM_XATTR_PORTABLE_DIGSIG)
> >  			return -EPERM;
> >  	}
> >  	return evm_protect_xattr(dentry, xattr_name, xattr_value, @@ -
> > 432,6 +438,7 @@ int evm_inode_setattr(struct dentry *dentry, struct iattr
> > *attr)
> >  		return 0;
> >  	evm_status = evm_verify_current_integrity(dentry);
> >  	if ((evm_status == INTEGRITY_PASS) ||
> > +	    (evm_status == INTEGRITY_PASS_IMMUTABLE) ||
> >  	    (evm_status == INTEGRITY_NOXATTRS))
> >  		return 0;
> 
> Something is wrong here?
> When integrity verification pass, this code WILL ALLOW to change attribute.
> But it is not possible... next time integrity verification will fail?
> Or I miss something?

Right, it will allow the file metadata change.  The bigger problem is
that evm_inode_post_setattr() will replace the signature with an HMAC.

> 
> >  	integrity_audit_msg(AUDIT_INTEGRITY_METADATA,

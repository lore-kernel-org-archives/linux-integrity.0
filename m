Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47792 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756160AbdKCQyQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Nov 2017 12:54:16 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vA3GsAEh008365
        for <linux-integrity@vger.kernel.org>; Fri, 3 Nov 2017 12:54:16 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2e0r6tykeg-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 03 Nov 2017 12:54:15 -0400
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Fri, 3 Nov 2017 16:54:13 -0000
Subject: Re: [PATCH] evm: allow metadata changes for inode without xattr
 support
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Mikhail Kurinnoi <viewizard@viewizard.com>,
        linux-integrity@vger.kernel.org
Date: Fri, 03 Nov 2017 12:54:08 -0400
In-Reply-To: <20171103102652.0618859d@totoro>
References: <20171103102652.0618859d@totoro>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1509728048.3416.80.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2017-11-03 at 10:26 +0300, Mikhail Kurinnoi wrote:
> This patch provide changes in order to allow metadata changes for
> inode without xattr support.
> 
> 
> Signed-off-by: Mikhail Kurinnoi <viewizard@viewizard.com>
> 
>  security/integrity/evm/evm_main.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
> index 9826c02e2db8..51151c43433d 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -294,8 +294,7 @@ static int evm_protect_xattr(struct dentry *dentry, const char *xattr_name,
>  		if (!posix_xattr_acl(xattr_name))
>  			return 0;
>  		evm_status = evm_verify_current_integrity(dentry);
> -		if ((evm_status == INTEGRITY_PASS) ||
> -		    (evm_status == INTEGRITY_NOXATTRS))
> +		if (evm_status == INTEGRITY_NOXATTRS)
>  			return 0;
>  		goto out;
>  	}
> @@ -319,12 +318,15 @@ static int evm_protect_xattr(struct dentry *dentry, const char *xattr_name,
>  				    -EPERM, 0);
>  	}
>  out:
> -	if (evm_status != INTEGRITY_PASS)
> -		integrity_audit_msg(AUDIT_INTEGRITY_METADATA, d_backing_inode(dentry),
> -				    dentry->d_name.name, "appraise_metadata",
> -				    integrity_status_msg[evm_status],
> -				    -EPERM, 0);
> -	return evm_status == INTEGRITY_PASS ? 0 : -EPERM;
> +	if ((evm_status == INTEGRITY_PASS) ||
> +	    (evm_status == INTEGRITY_UNKNOWN))
> +		return 0;
> +
> +	integrity_audit_msg(AUDIT_INTEGRITY_METADATA, d_backing_inode(dentry),
> +			    dentry->d_name.name, "appraise_metadata",
> +			    integrity_status_msg[evm_status],
> +			    -EPERM, 0);
> +	return -EPERM;
>  }
> 
>  /**
> @@ -435,7 +437,8 @@ int evm_inode_setattr(struct dentry *dentry, struct iattr *attr)
>  		return 0;
>  	evm_status = evm_verify_current_integrity(dentry);
>  	if ((evm_status == INTEGRITY_PASS) ||
> -	    (evm_status == INTEGRITY_NOXATTRS))
> +	    (evm_status == INTEGRITY_NOXATTRS) ||
> +	    (evm_status == INTEGRITY_UNKNOWN))
>  		return 0;
>  	integrity_audit_msg(AUDIT_INTEGRITY_METADATA, d_backing_inode(dentry),
>  			    dentry->d_name.name, "appraise_metadata",
> 

Since this change is limited to setattr, perhaps it would be simpler
to test the i_opflags directly, without modifying evm_protect_xattr().

Mimi

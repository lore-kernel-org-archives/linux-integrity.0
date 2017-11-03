Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54150 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1756388AbdKCRPj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Nov 2017 13:15:39 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vA3HEV2q113329
        for <linux-integrity@vger.kernel.org>; Fri, 3 Nov 2017 13:15:38 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2e0vk4rarn-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 03 Nov 2017 13:15:38 -0400
Received: from localhost
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Fri, 3 Nov 2017 17:15:36 -0000
Subject: Re: [PATCH] evm: allow metadata changes for inode without xattr
 support
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Mikhail Kurinnoi <viewizard@viewizard.com>
Cc: linux-integrity@vger.kernel.org
Date: Fri, 03 Nov 2017 13:15:31 -0400
In-Reply-To: <20171103200620.76c1add0@totoro>
References: <20171103102652.0618859d@totoro>
         <1509728048.3416.80.camel@linux.vnet.ibm.com>
         <20171103200620.76c1add0@totoro>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1509729331.3416.84.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2017-11-03 at 20:06 +0300, Mikhail Kurinnoi wrote:
> ? Fri, 03 Nov 2017 12:54:08 -0400
> Mimi Zohar <zohar@linux.vnet.ibm.com> ?????:
> 
> > On Fri, 2017-11-03 at 10:26 +0300, Mikhail Kurinnoi wrote:
> > > This patch provide changes in order to allow metadata changes for
> > > inode without xattr support.
> > > 
> > > 
> > > Signed-off-by: Mikhail Kurinnoi <viewizard@viewizard.com>
> > > 
> > >  security/integrity/evm/evm_main.c | 21 ++++++++++++---------
> > >  1 file changed, 12 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/security/integrity/evm/evm_main.c
> > > b/security/integrity/evm/evm_main.c index
> > > 9826c02e2db8..51151c43433d 100644 ---
> > > a/security/integrity/evm/evm_main.c +++
> > > b/security/integrity/evm/evm_main.c @@ -294,8 +294,7 @@ static int
> > > evm_protect_xattr(struct dentry *dentry, const char *xattr_name, if
> > > (!posix_xattr_acl(xattr_name)) return 0;
> > >  		evm_status = evm_verify_current_integrity(dentry);
> > > -		if ((evm_status == INTEGRITY_PASS) ||
> > > -		    (evm_status == INTEGRITY_NOXATTRS))
> > > +		if (evm_status == INTEGRITY_NOXATTRS)
> > >  			return 0;
> > >  		goto out;
> > >  	}
> > > @@ -319,12 +318,15 @@ static int evm_protect_xattr(struct dentry
> > > *dentry, const char *xattr_name, -EPERM, 0);
> > >  	}
> > >  out:
> > > -	if (evm_status != INTEGRITY_PASS)
> > > -		integrity_audit_msg(AUDIT_INTEGRITY_METADATA,
> > > d_backing_inode(dentry),
> > > -				    dentry->d_name.name,
> > > "appraise_metadata",
> > > -
> > > integrity_status_msg[evm_status],
> > > -				    -EPERM, 0);
> > > -	return evm_status == INTEGRITY_PASS ? 0 : -EPERM;
> > > +	if ((evm_status == INTEGRITY_PASS) ||
> > > +	    (evm_status == INTEGRITY_UNKNOWN))
> > > +		return 0;
> > > +
> > > +	integrity_audit_msg(AUDIT_INTEGRITY_METADATA,
> > > d_backing_inode(dentry),
> > > +			    dentry->d_name.name,
> > > "appraise_metadata",
> > > +			    integrity_status_msg[evm_status],
> > > +			    -EPERM, 0);
> > > +	return -EPERM;
> > >  }
> > > 
> > >  /**
> > > @@ -435,7 +437,8 @@ int evm_inode_setattr(struct dentry *dentry,
> > > struct iattr *attr) return 0;
> > >  	evm_status = evm_verify_current_integrity(dentry);
> > >  	if ((evm_status == INTEGRITY_PASS) ||
> > > -	    (evm_status == INTEGRITY_NOXATTRS))
> > > +	    (evm_status == INTEGRITY_NOXATTRS) ||
> > > +	    (evm_status == INTEGRITY_UNKNOWN))
> > >  		return 0;
> > >  	integrity_audit_msg(AUDIT_INTEGRITY_METADATA,
> > > d_backing_inode(dentry), dentry->d_name.name, "appraise_metadata",
> > >   
> > 
> > Since this change is limited to setattr, perhaps it would be simpler
> > to test the i_opflags directly, without modifying evm_protect_xattr().
> 
> In case of set/remove xattr (evm_inode_setxattr(),
> evm_inode_removexattr()), evm should not interact fs module work, that
> will provide proper error code.
> As I see in __vfs_setxattr_noperm(), error code could be -EOPNOTSUPP
> or -EIO, but evm will override it by error code -EPERM. I think, this is
> wrong. If we don't have xattr support, let fs module handle the error
> code.

The patch description described a specific reason for the change.  If
there is another reason for the change, then either include it in the
patch description or provide a separate patch.

Mimi

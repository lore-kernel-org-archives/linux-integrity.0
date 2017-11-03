Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:53930 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756151AbdKCRGY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Nov 2017 13:06:24 -0400
Received: by mail-lf0-f65.google.com with SMTP id l23so3900683lfk.10
        for <linux-integrity@vger.kernel.org>; Fri, 03 Nov 2017 10:06:23 -0700 (PDT)
Date: Fri, 3 Nov 2017 20:06:20 +0300
From: Mikhail Kurinnoi <viewizard@viewizard.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org
Subject: Re: [PATCH] evm: allow metadata changes for inode without xattr
 support
Message-ID: <20171103200620.76c1add0@totoro>
In-Reply-To: <1509728048.3416.80.camel@linux.vnet.ibm.com>
References: <20171103102652.0618859d@totoro>
        <1509728048.3416.80.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

? Fri, 03 Nov 2017 12:54:08 -0400
Mimi Zohar <zohar@linux.vnet.ibm.com> ?????:

> On Fri, 2017-11-03 at 10:26 +0300, Mikhail Kurinnoi wrote:
> > This patch provide changes in order to allow metadata changes for
> > inode without xattr support.
> > 
> > 
> > Signed-off-by: Mikhail Kurinnoi <viewizard@viewizard.com>
> > 
> >  security/integrity/evm/evm_main.c | 21 ++++++++++++---------
> >  1 file changed, 12 insertions(+), 9 deletions(-)
> > 
> > diff --git a/security/integrity/evm/evm_main.c
> > b/security/integrity/evm/evm_main.c index
> > 9826c02e2db8..51151c43433d 100644 ---
> > a/security/integrity/evm/evm_main.c +++
> > b/security/integrity/evm/evm_main.c @@ -294,8 +294,7 @@ static int
> > evm_protect_xattr(struct dentry *dentry, const char *xattr_name, if
> > (!posix_xattr_acl(xattr_name)) return 0;
> >  		evm_status = evm_verify_current_integrity(dentry);
> > -		if ((evm_status == INTEGRITY_PASS) ||
> > -		    (evm_status == INTEGRITY_NOXATTRS))
> > +		if (evm_status == INTEGRITY_NOXATTRS)
> >  			return 0;
> >  		goto out;
> >  	}
> > @@ -319,12 +318,15 @@ static int evm_protect_xattr(struct dentry
> > *dentry, const char *xattr_name, -EPERM, 0);
> >  	}
> >  out:
> > -	if (evm_status != INTEGRITY_PASS)
> > -		integrity_audit_msg(AUDIT_INTEGRITY_METADATA,
> > d_backing_inode(dentry),
> > -				    dentry->d_name.name,
> > "appraise_metadata",
> > -
> > integrity_status_msg[evm_status],
> > -				    -EPERM, 0);
> > -	return evm_status == INTEGRITY_PASS ? 0 : -EPERM;
> > +	if ((evm_status == INTEGRITY_PASS) ||
> > +	    (evm_status == INTEGRITY_UNKNOWN))
> > +		return 0;
> > +
> > +	integrity_audit_msg(AUDIT_INTEGRITY_METADATA,
> > d_backing_inode(dentry),
> > +			    dentry->d_name.name,
> > "appraise_metadata",
> > +			    integrity_status_msg[evm_status],
> > +			    -EPERM, 0);
> > +	return -EPERM;
> >  }
> > 
> >  /**
> > @@ -435,7 +437,8 @@ int evm_inode_setattr(struct dentry *dentry,
> > struct iattr *attr) return 0;
> >  	evm_status = evm_verify_current_integrity(dentry);
> >  	if ((evm_status == INTEGRITY_PASS) ||
> > -	    (evm_status == INTEGRITY_NOXATTRS))
> > +	    (evm_status == INTEGRITY_NOXATTRS) ||
> > +	    (evm_status == INTEGRITY_UNKNOWN))
> >  		return 0;
> >  	integrity_audit_msg(AUDIT_INTEGRITY_METADATA,
> > d_backing_inode(dentry), dentry->d_name.name, "appraise_metadata",
> >   
> 
> Since this change is limited to setattr, perhaps it would be simpler
> to test the i_opflags directly, without modifying evm_protect_xattr().

In case of set/remove xattr (evm_inode_setxattr(),
evm_inode_removexattr()), evm should not interact fs module work, that
will provide proper error code.
As I see in __vfs_setxattr_noperm(), error code could be -EOPNOTSUPP
or -EIO, but evm will override it by error code -EPERM. I think, this is
wrong. If we don't have xattr support, let fs module handle the error
code.


-- 
Best regards,
Mikhail Kurinnoi

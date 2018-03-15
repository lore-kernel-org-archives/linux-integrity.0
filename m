Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43038 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751488AbeCOTSo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Mar 2018 15:18:44 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2FJI5JE059071
        for <linux-integrity@vger.kernel.org>; Thu, 15 Mar 2018 15:18:43 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2gqu37c9y1-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 15 Mar 2018 15:18:43 -0400
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Thu, 15 Mar 2018 19:18:40 -0000
Subject: Re: [PATCH 3/4] ima: Improvements in ima_appraise_measurement()
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, James Morris <jmorris@namei.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Date: Thu, 15 Mar 2018 15:18:34 -0400
In-Reply-To: <87efkmjjc7.fsf@morokweng.localdomain>
References: <20180314202020.3794-1-bauerman@linux.vnet.ibm.com>
         <20180314202020.3794-4-bauerman@linux.vnet.ibm.com>
         <20180314214045.GC14289@mail.hallyn.com>
         <87efkmjjc7.fsf@morokweng.localdomain>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1521141514.3547.637.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, 2018-03-14 at 21:03 -0300, Thiago Jung Bauermann wrote:
> Hello Serge,
> 
> Thanks for quickly reviewing these patches!
> 
> Serge E. Hallyn <serge@hallyn.com> writes:
> 
> > Quoting Thiago Jung Bauermann (bauerman@linux.vnet.ibm.com):
> >> From: Mimi Zohar <zohar@linux.vnet.ibm.com>
> >> @@ -241,16 +241,20 @@ int ima_appraise_measurement(enum ima_hooks func,
> >>  	}
> >>  
> >>  	status = evm_verifyxattr(dentry, XATTR_NAME_IMA, xattr_value, rc, iint);
> >> -	if ((status != INTEGRITY_PASS) &&
> >> -	    (status != INTEGRITY_PASS_IMMUTABLE) &&
> >> -	    (status != INTEGRITY_UNKNOWN)) {
> >> -		if ((status == INTEGRITY_NOLABEL)
> >> -		    || (status == INTEGRITY_NOXATTRS))
> >> -			cause = "missing-HMAC";
> >> -		else if (status == INTEGRITY_FAIL)
> >> -			cause = "invalid-HMAC";
> >> +	switch (status) {
> >> +	case INTEGRITY_PASS:
> >> +	case INTEGRITY_PASS_IMMUTABLE:
> >> +	case INTEGRITY_UNKNOWN:
> >
> > Wouldn't it be more future-proof to replace this with a 'default', or
> > to at least add a "default: BUG()" to catch new status values?
> 
> I agree. I like the "default: BUG()" option.

Agreed.  I would put it at the end after INTEGRITY_FAIL.

> 
> >> +		break;
> >> +	case INTEGRITY_NOXATTRS:	/* No EVM protected xattrs. */
> >> +	case INTEGRITY_NOLABEL:		/* No security.evm xattr. */
> >> +		cause = "missing-HMAC";
> >> +		goto out;
> >> +	case INTEGRITY_FAIL:		/* Invalid HMAC/signature. */
> >> +		cause = "invalid-HMAC";
> >>  		goto out;
> >>  	}
> >> +
> >>  	switch (xattr_value->type) {
> >>  	case IMA_XATTR_DIGEST_NG:
> >>  		/* first byte contains algorithm id */
> >> @@ -316,17 +320,20 @@ int ima_appraise_measurement(enum ima_hooks func,
> >>  		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode, filename,
> >>  				    op, cause, rc, 0);
> >>  	} else if (status != INTEGRITY_PASS) {
> >> +		/* Fix mode, but don't replace file signatures. */
> >>  		if ((ima_appraise & IMA_APPRAISE_FIX) &&
> >>  		    (!xattr_value ||
> >>  		     xattr_value->type != EVM_IMA_XATTR_DIGSIG)) {
> >>  			if (!ima_fix_xattr(dentry, iint))
> >>  				status = INTEGRITY_PASS;
> >> -		} else if ((inode->i_size == 0) &&
> >> -			   (iint->flags & IMA_NEW_FILE) &&
> >> -			   (xattr_value &&
> >> -			    xattr_value->type == EVM_IMA_XATTR_DIGSIG)) {
> >> +		}
> >> +
> >> +		/* Permit new files with file signatures, but without data. */
> >> +		if (inode->i_size == 0 && iint->flags & IMA_NEW_FILE &&
> >
> > This may be correct, but it's not identical to what you're replacing.
> > Since in either case you're setting status to INTEGRITY_PASS the final
> > result is the same, but with a few extra possible steps.  Not sure
> > whether that matters.
> 
> Good point. I'll have to defer this one to Mimi though.

The end result is the same, but add some needed comments.

Mimi

> 
> >
> >> +		    xattr_value && xattr_value->type == EVM_IMA_XATTR_DIGSIG) {
> >>  			status = INTEGRITY_PASS;
> >>  		}
> >> +
> >>  		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode, filename,
> >>  				    op, cause, rc, 0);
> >>  	} else {
> 
> 

Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53964 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753266AbeB0PeF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Feb 2018 10:34:05 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w1RFV6lL056174
        for <linux-integrity@vger.kernel.org>; Tue, 27 Feb 2018 10:34:04 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2gd9v1rq7g-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 27 Feb 2018 10:34:04 -0500
Received: from localhost
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Tue, 27 Feb 2018 15:34:02 -0000
Subject: Re: [PATCH v2 1/4] ima: fail file signature verification on
 non-init mounted filesystems
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        Seth Forshee <seth.forshee@canonical.com>,
        Dongsu Park <dongsu@kinvolk.io>,
        Alban Crequy <alban@kinvolk.io>,
        "Serge E . Hallyn" <serge@hallyn.com>
Date: Tue, 27 Feb 2018 10:33:57 -0500
In-Reply-To: <87bmgbyzhx.fsf@xmission.com>
References: <1519335184-17808-1-git-send-email-zohar@linux.vnet.ibm.com>
         <1519335184-17808-2-git-send-email-zohar@linux.vnet.ibm.com>
         <87bmgbyzhx.fsf@xmission.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1519745637.3562.364.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, 2018-02-26 at 19:47 -0600, Eric W. Biederman wrote:

> > diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> > index 1b177461f20e..f34901069e78 100644
> > --- a/security/integrity/ima/ima_appraise.c
> > +++ b/security/integrity/ima/ima_appraise.c
> > @@ -302,7 +302,18 @@ int ima_appraise_measurement(enum ima_hooks func,
> >  	}
> >  
> >  out:
> > -	if (status != INTEGRITY_PASS) {
> > +	/*
> > +	 * File signatures on some filesystems can not be properly verified.
> > +	 * On these filesytems, that are mounted by an untrusted mounter,
> > +	 * fail the file signature verification.
> > +	 */
> > +	if (inode->i_sb->s_iflags &
> > +	    (SB_I_IMA_UNVERIFIABLE_SIGNATURE | SB_I_UNTRUSTED_MOUNTER))
> > {
> 
> I like this test.
> 
> This test does not match your comments.  This test returns true if
> either SB_I_IMA_UNVERIFIABLE_SIGNATURE or SB_I_UNTRUSTED_MOUNTER.

Thanks, you're right.  The test should have been:

        if ((inode->i_sb->s_iflags &
            (SB_I_IMA_UNVERIFIABLE_SIGNATURE | SB_I_UNTRUSTED_MOUNTER)) ==
            (SB_I_IMA_UNVERIFIABLE_SIGNATURE | SB_I_UNTRUSTED_MOUNTER)) {

Mimi

> 
> > +		status = INTEGRITY_FAIL;
> > +		cause = "unverifiable-signature";
> > +		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode, filename,
> > +				    op, cause, rc, 0);
> > +	} else if (status != INTEGRITY_PASS) {
> >  		if ((ima_appraise & IMA_APPRAISE_FIX) &&
> >  		    (!xattr_value ||
> >  		     xattr_value->type != EVM_IMA_XATTR_DIGSIG)) {
> 
> Eric
> 

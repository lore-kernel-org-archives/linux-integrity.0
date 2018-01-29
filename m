Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51014 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751435AbeA2QdQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 29 Jan 2018 11:33:16 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w0TGT2aO098262
        for <linux-integrity@vger.kernel.org>; Mon, 29 Jan 2018 11:33:16 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ft4ja8ppa-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 29 Jan 2018 11:33:14 -0500
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 29 Jan 2018 16:33:12 -0000
Subject: Re: [RFC PATCH v3 2/2] ima: force re-appraisal on filesystems with
 FS_IMA_NO_CACHE
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: "Serge E. Hallyn" <serge@hallyn.com>,
        Alban Crequy <alban.crequy@gmail.com>
Cc: alban@kinvolk.io, dongsu@kinvolk.io, iago@kinvolk.io,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, miklos@szeredi.hu,
        viro@zeniv.linux.org.uk, dmitry.kasatkin@gmail.com,
        james.l.morris@oracle.com, seth.forshee@canonical.com,
        hch@infradead.org
Date: Mon, 29 Jan 2018 11:33:05 -0500
In-Reply-To: <1516881401.3751.37.camel@linux.vnet.ibm.com>
References: <20180122162452.8756-1-alban@kinvolk.io>
         <20180122162452.8756-3-alban@kinvolk.io>
         <20180124175234.GA29811@mail.hallyn.com>
         <1516881401.3751.37.camel@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1517243585.29187.546.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi Alban,

On Thu, 2018-01-25 at 06:56 -0500, Mimi Zohar wrote:
> > > @@ -228,9 +229,28 @@ static int process_measurement(struct file *file, char *buf, loff_t size,
> > >  				 IMA_APPRAISE_SUBMASK | IMA_APPRAISED_SUBMASK |
> > >  				 IMA_ACTION_FLAGS);
> > >  
> > > -	if (test_and_clear_bit(IMA_CHANGE_XATTR, &iint->atomic_flags))
> > > -		/* reset all flags if ima_inode_setxattr was called */
> > > +	/*
> > > +	 * Reset the measure, appraise and audit cached flags either if:
> > > +	 * - ima_inode_setxattr was called, or
> > > +	 * - based on filesystem feature flag
> > > +	 * forcing the file to be re-evaluated.
> > > +	 */
> > > +	if (test_and_clear_bit(IMA_CHANGE_XATTR, &iint->atomic_flags)) {
> > >  		iint->flags &= ~IMA_DONE_MASK;
> > > +	} else if (inode->i_sb->s_type->fs_flags & FS_IMA_NO_CACHE) {
> > > +		if (action & IMA_MEASURE) {
> > > +			iint->measured_pcrs = 0;
> > > +			iint->flags &=
> > > +			    ~(IMA_COLLECTED | IMA_MEASURE | IMA_MEASURED);
> > > +		}
> > > +		if (action & IMA_APPRAISE)
> > > +			iint->flags &=
> > > +			    ~(IMA_COLLECTED | IMA_APPRAISE | IMA_APPRAISED |
> > > +			      IMA_APPRAISE_SUBMASK | IMA_APPRAISED_SUBMASK);
> > > +		if (action & IMA_AUDIT)
> > > +			iint->flags &=
> > > +			    ~(IMA_COLLECTED | IMA_AUDIT | IMA_AUDITED);
> > > +	}
> > > 
> 
> Alban, I don't know what I was thinking, but this can be simplified
> like for the IMA_CHANGE_XATTR case.  Except in the IMA_CHANGE_XATTR
> case, "measured_pcrs" was already reset, whereas in this case
> "measured_pcrs" needs to be reset.

Did you get a chance to make the change and test it?

Mimi

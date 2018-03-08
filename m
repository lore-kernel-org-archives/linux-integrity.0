Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54260 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750787AbeCHWFq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 8 Mar 2018 17:05:46 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w28M0Lx1020713
        for <linux-integrity@vger.kernel.org>; Thu, 8 Mar 2018 17:05:46 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2gkah8q4ap-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 08 Mar 2018 17:05:45 -0500
Received: from localhost
        by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Thu, 8 Mar 2018 22:05:44 -0000
Subject: Re: [PATCH v2] ima: drop vla in ima_audit_measurement()
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Tycho Andersen <tycho@tycho.ws>
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Date: Thu, 08 Mar 2018 17:05:40 -0500
In-Reply-To: <20180308214547.kdeoeozugxffzumn@smitten>
References: <20180308202347.31331-1-tycho@tycho.ws>
         <1520541374.3605.101.camel@linux.vnet.ibm.com>
         <20180308214547.kdeoeozugxffzumn@smitten>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1520546740.3605.124.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, 2018-03-08 at 14:45 -0700, Tycho Andersen wrote:
> Hi Mimi,
> 
> On Thu, Mar 08, 2018 at 03:36:14PM -0500, Mimi Zohar wrote:
> > On Thu, 2018-03-08 at 13:23 -0700, Tycho Andersen wrote:
> > 
> > >  /*
> > > diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> > > index 2cfb0c714967..356faae6f09c 100644
> > > --- a/security/integrity/ima/ima_main.c
> > > +++ b/security/integrity/ima/ima_main.c
> > > @@ -288,8 +288,11 @@ static int process_measurement(struct file *file, char *buf, loff_t size,
> > >  					      xattr_value, xattr_len, opened);
> > >  		inode_unlock(inode);
> > >  	}
> > > -	if (action & IMA_AUDIT)
> > > -		ima_audit_measurement(iint, pathname);
> > > +	if (action & IMA_AUDIT) {
> > > +		rc = ima_audit_measurement(iint, pathname);
> > > +		if (rc < 0)
> > > +			goto out_locked;
> > > +	}
> > > 
> > >  	if ((file->f_flags & O_DIRECT) && (iint->flags & IMA_PERMIT_DIRECTIO))
> > >  		rc = 0;
> > 
> > Only when IMA-appraisal is enforcing file data integrity should
> > process_measurement() ever fail.  Other errors can be logged/audited.
> 
> Ok, so previously in ima_audit_measurement() when allocation failed,
> there was nothing logged. If we just keep this behavior like below,
> does that look good?

Before the IMA locking change that were just upstreamed, there were
problems with measuring/appraising files that were opened with the
O_DIRECT flag.  Unless the IMA policy specified permit_directio, the
measurement/appraisal failed.  With the new locking, opening files
with the O_DIRECTIO flag shouldn't be a problem.  It just needs to be
fully tested before removing this code.

On failure, the code below tests the ima_audit_measurement() result
and skips the IMA_PERMIT_DIRECTIO test.  Unless I'm missing something,
I don't see the point.

Mimi


> Thanks!
> 
> Tycho
> 
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 356faae6f09c..4e699bc7adc5 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -289,9 +289,13 @@ static int process_measurement(struct file *file, char *buf, loff_t size,
>  		inode_unlock(inode);
>  	}
>  	if (action & IMA_AUDIT) {
> -		rc = ima_audit_measurement(iint, pathname);
> -		if (rc < 0)
> +		int ret;
> +
> +		ret = ima_audit_measurement(iint, pathname);
> +		if (ret < 0 && ima_appraise & IMA_APPRAISE_ENFORCE) {
> +			rc = ret;
>  			goto out_locked;
> +		}
>  	}
> 
>  	if ((file->f_flags & O_DIRECT) && (iint->flags & IMA_PERMIT_DIRECTIO))
> 

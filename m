Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42418 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726128AbeJHUkA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 8 Oct 2018 16:40:00 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w98DO7C5063797
        for <linux-integrity@vger.kernel.org>; Mon, 8 Oct 2018 09:28:15 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2n06w3kdkb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 08 Oct 2018 09:28:15 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 8 Oct 2018 14:28:14 +0100
Subject: Re: [PATCH] Open a new file instance if no read permissions on files
From: Mimi Zohar <zohar@linux.ibm.com>
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: linux-integrity@vger.kernel.org, linux-unionfs@vger.kernel.org,
        iforster@suse.de, fvogt@suse.de, miklos@szeredi.hu
Date: Mon, 08 Oct 2018 09:27:59 -0400
In-Reply-To: <20181008121455.za53z7kgfizgtiv7@merlin>
References: <20181005214213.ickkfgu5a7tzzenk@merlin>
         <1538874061.4914.16.camel@linux.ibm.com>
         <20181008121455.za53z7kgfizgtiv7@merlin>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1539005279.15382.119.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, 2018-10-08 at 07:14 -0500, Goldwyn Rodrigues wrote:

> 
> > >  
> > > +	if (!(file->f_mode & FMODE_READ)) {
> > > +		struct file *f;
> > 
> > I would define "struct file *f = file" above, at the beginning of
> > function, and "free(f)" below, without modifying "file".
> 
> I suppose you mean fput(f).

yes

> Okay, if it makes code more understandable.

Thanks
> 
> > 
> > > +		int flags = file->f_flags & ~(O_WRONLY | O_APPEND | O_TRUNC | O_CREAT | O_NOCTTY | O_EXCL);
> > 
> > Doesn't O_RDONLY need to be added?
> 
> No. O_RDONLY is zero. But I think I should add it for readability. The
> compiler will optimize it eventually.
> 
> > Please fix the line length.
> > 
> > 
> > > +		f = dentry_open(&file->f_path, flags, file->f_cred);
> > > +		if (IS_ERR(f))
> > > +			return PTR_ERR(f);

It's late in the release cycle to be making this change.  Would it
make sense for now to fallback to modifying the original file
descriptor on failure and emit a message?

Mimi


> > > +		read = 1;
> > > +		file = f;
> > 
> > With the above change, no need to modify "file".
> 

Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55422 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932460AbeEHVnH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 May 2018 17:43:07 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w48LT5kM031562
        for <linux-integrity@vger.kernel.org>; Tue, 8 May 2018 17:43:06 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2huk3mtuj4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 08 May 2018 17:43:06 -0400
Received: from localhost
        by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Tue, 8 May 2018 22:43:04 +0100
Subject: Re: [PATCH V3 2/2] EVM: Allow runtime modification of the set of
 verified xattrs
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthew Garrett <mjg59@google.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>
Date: Tue, 08 May 2018 17:43:02 -0400
In-Reply-To: <CACdnJuvUze0GSmQcnyFi_3vGEPoEgavrF9WhFoDpmHSni3FwEA@mail.gmail.com>
References: <20180501175124.192587-1-mjg59@google.com>
         <20180501175124.192587-2-mjg59@google.com>
         <1525317430.3238.58.camel@linux.vnet.ibm.com>
         <CACdnJuvUze0GSmQcnyFi_3vGEPoEgavrF9WhFoDpmHSni3FwEA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1525815782.3551.86.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, 2018-05-08 at 21:30 +0000, Matthew Garrett wrote:
> On Wed, May 2, 2018 at 8:17 PM Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> > On Tue, 2018-05-01 at 10:51 -0700, Matthew Garrett wrote:
> > > +             Shows the set of extended attributes used to calculate or
> > > +             validate the EVM signature, and allows additional
> attributes
> > > +             to be added at runtime. Adding additional extended
> attributes
> > > +             will result in any existing signatures generated without
> the
> > > +             additional attributes becoming invalid, and any signatures
> > > +             generated after additional attributes are added will only
> be
> > > +             valid if the same additional attributes are configured on
> > > +             system boot.
> 
> > This needs to be updated ...
> 
> Yup.
> 
> > > +     if (*ppos != 0)
> > > +             return -EINVAL;
> 
> > Is there a maximum xattr name size?  Should there be?
> 
> There is - I'll add a check.
> 
> > > +     /* Remove any trailing newline */
> > > +     len = strlen(xattr->name);
> > > +     if (xattr->name[len-1] == '\n')
> > > +             xattr->name[len-1] = '\0';
> 
> > Shouldn't we somehow sanity check userspace provided strings, before
> > adding them to the list of xattrs?  Perhaps limit the string to the
> > upper and lower case letters?
> 
> As far as I can tell the VFS doesn't do that, and I wouldn't put it past
> someone to use UTF-8 at some point...

The audit subsystem uses audit_log_untrustedstrings() to check for
control characters.  I'm not sure what should be included, but not
checking userspace strings doesn't sound right.

> 
>   > +     evm_xattrs = securityfs_create_file("evm_xattrs", 0440, NULL, NULL,
> > > +                                         &evm_xattr_ops);
> > > +     if (!evm_xattrs || IS_ERR(evm_xattrs)) {
> > > +             securityfs_remove(evm_init_tpm);
> > > +             return -EFAULT;
> > > +     }
> > > +
> 
> > Do we really want this feature unconditionally enabled?  How often do
> > you expect to add xattrs?  Is there ever a point where you would want
> > to lock the list of xattrs from changing?
> 
> I think a config option would make sense here. Locking doesn't seem
> unreasonable, but I'm not sure what the threat model would really be -
> adding new xattrs would only result in additional signatures validating if
> they were signed with a trusted key in the first place.

Remember adding additional EVM xattrs isn't limited to just EVM
signatures, but for the original EVM HMAC as well.  Did you want to
limit it to the EVM portable & immutable signatures?

Mimi

Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50204 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752269AbeENRTV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 May 2018 13:19:21 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4EHDrqG166230
        for <linux-integrity@vger.kernel.org>; Mon, 14 May 2018 13:19:20 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2hyd7xv84p-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 14 May 2018 13:19:20 -0400
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 14 May 2018 18:19:19 +0100
Subject: Re: [PATCH V5 3/3] EVM: Allow runtime modification of the set of
 verified xattrs
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthew Garrett <mjg59@google.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>
Date: Mon, 14 May 2018 13:19:14 -0400
In-Reply-To: <CACdnJuuve3OrJPvBYeRoTfaan022hi9p0dDbDbZJuKHCU4t3xA@mail.gmail.com>
References: <20180511231236.5501-1-mjg59@google.com>
         <20180511231236.5501-3-mjg59@google.com>
         <1526229700.3898.26.camel@linux.vnet.ibm.com>
         <CACdnJuuve3OrJPvBYeRoTfaan022hi9p0dDbDbZJuKHCU4t3xA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1526318354.3898.159.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, 2018-05-14 at 10:01 -0700, Matthew Garrett wrote:
> On Sun, May 13, 2018 at 9:41 AM Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> 
> > On Fri, 2018-05-11 at 16:12 -0700, Matthew Garrett wrote:
>   > +
> > > +     if (strcmp(xattr->name, ".") == 0) {
> > > +             evm_xattrs_locked = 1;
> > > +             inode = evm_xattrs->d_inode;
> > > +             inode_lock(inode);
> > > +             newattrs.ia_mode = S_IFREG | 0440;
> > > +             newattrs.ia_valid = ATTR_MODE;
> > > +             err = notify_change(evm_xattrs, &newattrs, NULL);
> > > +             inode_unlock(inode);
> > > +             audit_log_format(ab, "locked");
> > > +             if (!err)
> > > +                     err = count;
> > > +             goto out;
> > > +     }
> > > +
> > > +     audit_log_format(ab, "xattr=");
> > > +     audit_log_untrustedstring(ab, xattr->name);
> > > +
> > > +     if (strncmp(xattr->name, XATTR_SECURITY_PREFIX,
> > > +                 XATTR_SECURITY_PREFIX_LEN) != 0) {
> > > +             err = -EINVAL;
> > > +             goto out;
> > > +     }
> 
> > This test now prevents locking the xattr names list.  Making this an
> > else clause will fix it.
> 
> Are you sure? The check for "." happens before this, and jumps over the
> rest of the function.

Oh! It did work, but the messages are confusing.

# cat /sys/kernel/security/integrity/evm/evm_xattrs 
security.selinux
security.ima
security.capability
security.foo
# echo foo > /sys/kernel/security/integrity/evm/evm_xattrs
bash: echo: write error: Operation not permitted

# echo security.foo > /sys/kernel/security/integrity/evm/evm_xattrs
bash: echo: write error: Operation not permitted

# cat /sys/kernel/security/integrity/evm/evm_xattrs 
security.selinux
security.ima
security.capability
security.foo

# echo . > /sys/kernel/security/integrity/evm/evm_xattrs
bash: echo: write error: Operation not permitted

# echo security.boo > /sys/kernel/security/integrity/evm/evm_xattrs
bash: echo: write error: Operation not permitted

# ls -lat //sys/kernel/security/integrity/evm/evm_xattrs
-rw-rw----. 1 root root 0 May 14 13:10
//sys/kernel/security/integrity/evm/evm_xattrs

"security.boo" wasn't added.  So writing '.' worked, but the chmod did
not work.  Maybe the error messages are coming from there.

Mimi

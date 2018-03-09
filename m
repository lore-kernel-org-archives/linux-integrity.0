Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43088 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932104AbeCIVyh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 9 Mar 2018 16:54:37 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w29LsSjA097515
        for <linux-integrity@vger.kernel.org>; Fri, 9 Mar 2018 16:54:37 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2gkyv75svt-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 09 Mar 2018 16:54:36 -0500
Received: from localhost
        by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Fri, 9 Mar 2018 21:54:34 -0000
Subject: Re: [PATCH v2] exec: Set file unwritable before LSM check
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: James Morris <jmorris@namei.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Date: Fri, 09 Mar 2018 16:54:27 -0500
In-Reply-To: <CAGXu5j++Ju0Jg0O3gXPGD7Nzy8uE3NZo_dCF-L0hontG_P+5yw@mail.gmail.com>
References: <20180309193020.GA5149@beast>
         <CA+55aFyp4Lvz8QVckBr+zp4OfB1VaFNb2J1s0-xEMA9h44c0UA@mail.gmail.com>
         <CAGXu5j++Ju0Jg0O3gXPGD7Nzy8uE3NZo_dCF-L0hontG_P+5yw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1520632467.3911.49.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2018-03-09 at 11:54 -0800, Kees Cook wrote:
> On Fri, Mar 9, 2018 at 11:47 AM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > On Fri, Mar 9, 2018 at 11:30 AM, Kees Cook <keescook@chromium.org> wrote:
> >> The LSM check should happen after the file has been confirmed to be
> >> unchanging. Without this, we could have a race between the Time of Check
> >> (the call to security_kernel_read_file() which could read the file and
> >> make access policy decisions) and the Time of Use (starting with
> >> kernel_read_file()'s reading of the file contents). In theory, file
> >> contents could change between the two.

For files opened by userspace, IMA refers to the problem as "Time of
Measure, Time of Use" (ToMToU) and emits an audit message.

security_kernel_read_file() is being called by the kernel to read the
kexec kernel image and initramfs, kernel modules (new syscall),
ima_policy, EVM x509 certificate, and firmware.

If these files are signed, like they should be, then IMA prevents them
from being opened for write.  Modifying the file via the filesystem
should not be possible.  Other sorts of attacks, would probably be
possible.

If these files aren't signed, then in terms of IMA-measurement the
file measured, might not be the file used.  The ToMToU audit message
is not being generated for these files.

> > I'm going to assume I get this for 4.17 from the security tree.
> >
> > Because I'm guessing there are actually no existing users that care?
> > selinux seems to just look at file state, not actually at contents or
> > anything that write access denial would care about.
> >
> > And the only other security module that even registers this is
> > loadpin, and again it just seems to check things like "on the right
> > filesystem" that aren't actually impacted by write access (in fact,
> > the documented reason is to check that it's a read-only filesystem so
> > that write access is simply _irrelevant_).
> >
> > So this issue seems to be mainly a cleanliness thing, not an actual bug.
> 
> That is my assumption too (I left off the Cc: stable as a result). I'm
> much less familiar with IMA, though, but it's a caller of
> kernel_read_file(), not hooking it, etc.

Please add my reviewed-by.

Mimi

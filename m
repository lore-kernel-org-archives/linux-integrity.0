Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56080 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751663AbdI2Ax0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 28 Sep 2017 20:53:26 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v8T0olgX098646
        for <linux-integrity@vger.kernel.org>; Thu, 28 Sep 2017 20:53:26 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2d977w5867-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 28 Sep 2017 20:53:25 -0400
Received: from localhost
        by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Fri, 29 Sep 2017 10:53:23 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
        by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v8T0rLrC48169128
        for <linux-integrity@vger.kernel.org>; Fri, 29 Sep 2017 10:53:21 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
        by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id v8T0rKs0006461
        for <linux-integrity@vger.kernel.org>; Fri, 29 Sep 2017 10:53:21 +1000
Subject: Re: RFC: Make it practical to ship EVM signatures
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthew Garrett <mjg59@google.com>
Cc: linux-integrity@vger.kernel.org,
        Mikhail Kurinnoi <viewizard@viewizard.com>
Date: Thu, 28 Sep 2017 20:53:17 -0400
In-Reply-To: <CACdnJuuveRvCx57ZnYmRWbiwh3XU7AbxZD2W-Gq_dh_h_6L9Mg@mail.gmail.com>
References: <20170927221653.11219-1-mjg59@google.com>
         <1506629560.5691.33.camel@linux.vnet.ibm.com>
         <CACdnJuuveRvCx57ZnYmRWbiwh3XU7AbxZD2W-Gq_dh_h_6L9Mg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1506646397.5691.64.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, 2017-09-28 at 14:13 -0700, Matthew Garrett wrote:
> On Thu, Sep 28, 2017 at 1:12 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> > Earlier this year there were discussions on defining a portable EVM
> > signature, that could be included in software packages.
> >
> > The reason for including as much metadata as possible in the HMAC is
> > to limit cut & paste attacks.  For this reason, the portable data is
> > only used in transmission, not on disk.
> 
> The concern is that two identical copies of a file may exist, but with
> different security contexts, and that not protecting the inode would
> allow an attacker to copy the security metadata from one file onto the
> other? This presumably only has meaning if they're on separate
> filesystems, since otherwise the attacker could just delete one file
> and hardlink the other to the former's location? I think that for our
> purposes this isn't a big deal.

Without the inode included in the HMAC calculation, the same file
could exist as a different file name on the same file system.  No need
for the two files to be on different file systems.

> > A new EVM type is defined that does not convert the EVM signature to
> > an HMAC.
> >
> > Mikhail's patches:
> > https://sourceforge.net/p/linux-ima/mailman/linux-ima-user/thread/2017
> > 0113072602.4ffaa30a@totoro/
> 
> That looks broadly like what we want, but I think there's some
> advantage in maintaining the flexibility of choosing which information
> is embedded. One additional option would be to allow userland to place
> a restriction on which options *must* be present, ie local policy
> could refuse to allow any signatures that didn't include a specific
> set of metadata.

This introduces a new level of complexity, which I'm not sure is warranted.

> One of the reasons we're interested in allowing the use of signatures
> rather than HMACs is to avoid the case where a machine being
> compromised would allow an attacker to obtain the symmetric key and
> drop new appropriately HMACed binaries on the system that would
> persist even if the kernel was updated to fix the vulnerability.

Assuming you're using a trusted key (TPM based key) to encrypt/decrypt
the EVM key (trusted key), then such an attack would require root
privileges with the ability to read kernel memory.  The EVM key is
never exposed to userspace in the clear.

Mimi

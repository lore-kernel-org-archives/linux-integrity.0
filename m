Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45508 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752280AbdI2TCQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 29 Sep 2017 15:02:16 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v8TJ1mQS041597
        for <linux-integrity@vger.kernel.org>; Fri, 29 Sep 2017 15:02:16 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2d9ncby30q-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 29 Sep 2017 15:02:16 -0400
Received: from localhost
        by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Sat, 30 Sep 2017 05:02:13 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
        by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v8TJ2AdW41156764
        for <linux-integrity@vger.kernel.org>; Sat, 30 Sep 2017 05:02:10 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
        by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id v8TJ2A1Q019385
        for <linux-integrity@vger.kernel.org>; Sat, 30 Sep 2017 05:02:10 +1000
Subject: Re: RFC: Make it practical to ship EVM signatures
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthew Garrett <mjg59@google.com>
Cc: linux-integrity@vger.kernel.org,
        Mikhail Kurinnoi <viewizard@viewizard.com>
Date: Fri, 29 Sep 2017 15:02:06 -0400
In-Reply-To: <CACdnJuueNfLdDnCsmotGhLC58cJXXh35FeZzipJ_ZshScPM=qA@mail.gmail.com>
References: <20170927221653.11219-1-mjg59@google.com>
         <1506629560.5691.33.camel@linux.vnet.ibm.com>
         <CACdnJuuveRvCx57ZnYmRWbiwh3XU7AbxZD2W-Gq_dh_h_6L9Mg@mail.gmail.com>
         <1506646397.5691.64.camel@linux.vnet.ibm.com>
         <CACdnJuueNfLdDnCsmotGhLC58cJXXh35FeZzipJ_ZshScPM=qA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1506711726.5691.141.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2017-09-29 at 11:09 -0700, Matthew Garrett wrote:
> On Thu, Sep 28, 2017 at 5:53 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> > Without the inode included in the HMAC calculation, the same file
> > could exist as a different file name on the same file system.  No need
> > for the two files to be on different file systems.
> 
> But if I create a hardlink to an existing file then I get the same
> file with the same inode number and two different names on the same
> filesystem, and so security.evm would still match?

True, with a hard link that would be the case, but by the same file, I
meant a copy of the original file, not a hard link to the file.

> >> One of the reasons we're interested in allowing the use of signatures
> >> rather than HMACs is to avoid the case where a machine being
> >> compromised would allow an attacker to obtain the symmetric key and
> >> drop new appropriately HMACed binaries on the system that would
> >> persist even if the kernel was updated to fix the vulnerability.
> >
> > Assuming you're using a trusted key (TPM based key) to encrypt/decrypt
> > the EVM key (trusted key), then such an attack would require root
> > privileges with the ability to read kernel memory.  The EVM key is
> > never exposed to userspace in the clear.
> 
> That's a case that we need to be worried about. Trusted boot means we
> can ensure that a system boots an updated kernel, but if the attacker
> has been able to drop a modified sshd with a valid hmac onto the
> system then we have fewer guarantees about the integrity. We could
> continue using signatures for security.ima to avoid that, but then we
> lose the performance benefits of the hmac and also don't have the same
> level of guarantees around the other security metadata.

I think you mean "secure boot", not "trusted boot", in this case.

The original understanding was that IMA/EVM would enforce integrity
and not enforce mandatory access control (MAC).  The LSMs (eg.
SELinux) would be responsible for MAC.  Separation of duties.

With that understanding, if the LSM allows a file to be "dropped" onto
 the file system of a running system, IMA/EVM will hash and hmac the
permitted file.

I don't understand where you're going with this train of thought.  If
you're trying to make a case for EVM to run with only security.evm
signatures, then you wouldn't refer to the HMAC benefits.  If you're
trying to make a case for EVM signatures, with the inode they're not
portable, without the inode, they are susceptible to a cut and paste
attack.

Mickhail's proposed patches resolves this by having a portable EVM
signature that is never written to disk, but converted to an HMAC.

Mimi

Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57640 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1762587AbdJRBuE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 Oct 2017 21:50:04 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9I1nLLF066588
        for <linux-integrity@vger.kernel.org>; Tue, 17 Oct 2017 21:50:03 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2dnssp0jua-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 17 Oct 2017 21:50:03 -0400
Received: from localhost
        by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Wed, 18 Oct 2017 02:50:02 +0100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v9I1nw3429622430
        for <linux-integrity@vger.kernel.org>; Wed, 18 Oct 2017 01:50:00 GMT
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
        by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id v9I1nqJC013026
        for <linux-integrity@vger.kernel.org>; Wed, 18 Oct 2017 12:49:52 +1100
Subject: Re: Writing out EVM protected xattrs while EVM is active
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthew Garrett <mjg59@google.com>,
        linux-integrity <linux-integrity@vger.kernel.org>
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Date: Tue, 17 Oct 2017 21:49:55 -0400
In-Reply-To: <CACdnJutQ1NBxfAO1NBJqrrF0en9hc_C=Jy8XxNb5pEiBVwAa0g@mail.gmail.com>
References: <CACdnJutQ1NBxfAO1NBJqrrF0en9hc_C=Jy8XxNb5pEiBVwAa0g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1508291395.4513.95.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, 2017-10-17 at 16:12 -0700, Matthew Garrett wrote:
> I'm interested in extending our use of IMA digital signatures to EVM
> in order to protect security.capability (and, in the near future,
> security.apparmor). 

security.capability is already included in the EVM HMAC/signature.
Your security.apparmor patch is now queued in my #next branch. 

> However, right now this doesn't seem to quite work
> in terms of allowing updates to a running system.

?

> We've discussed the
> EVM siganture format's use of inode numbers and I think I've got that
> sorted (I'll send a patch once I've got a last couple of things
> working).

Ok

> 
> However, I'm a little confused by how EVM should be working here. Once
> EVM is initialised, all EVM attributes will be protected, making it
> impossible to write new values to any xattrs covered by EVM unless
> IMA_NEW_FILE is set.

Up to now, security.evm has been to detect off line changes, not to
prevent the running system's file meta-data from changing.  Before the
security.evm HMAC can be updated, the existing value must be verified.
 Otherwise any file metadata change would cause security.evm to be
updated, including any off line modifications.

Updating the security.evm HMAC is triggered by writing/updating the
file's metadata (eg. setattr, setxattr, removexattr).

> But as far as I can tell, IMA_NEW_FILE will only
> be set if there's an IMA action that covers the file in question. This
> means it's possible to write out security.evm and friends on newly
> created files that would be appraised, but not on any other files. Am
> I missing something?

Only files in the IMA policy that pass integrity verification can be
accessed.  The IMA_NEW_FILE flag overides this restriction, allowing
IMA to access new files, even if the security.ima xattr does not yet
exist.

Mimi

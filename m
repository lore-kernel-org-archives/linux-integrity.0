Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34282 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S937966AbeBUOq2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 21 Feb 2018 09:46:28 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w1LEjN0k073678
        for <linux-integrity@vger.kernel.org>; Wed, 21 Feb 2018 09:46:28 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2g99pykbyy-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 21 Feb 2018 09:46:27 -0500
Received: from localhost
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Wed, 21 Feb 2018 14:46:25 -0000
Subject: Re: [PATCH v1 1/2] ima: fail signature verification on untrusted
 filesystems
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        James Morris <jmorris@namei.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        Seth Forshee <seth.forshee@canonical.com>,
        Dongsu Park <dongsu@kinvolk.io>,
        Alban Crequy <alban@kinvolk.io>
Date: Wed, 21 Feb 2018 09:46:19 -0500
In-Reply-To: <20180220201636.GA1565@mail.hallyn.com>
References: <1519053483-18396-1-git-send-email-zohar@linux.vnet.ibm.com>
         <1519053483-18396-2-git-send-email-zohar@linux.vnet.ibm.com>
         <87zi44mz26.fsf@xmission.com> <alpine.LRH.2.21.1802201152240.883@namei.org>
         <87tvucifji.fsf@xmission.com> <1519135329.3736.88.camel@linux.vnet.ibm.com>
         <20180220201636.GA1565@mail.hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1519224379.3736.154.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

> > > On the flip side when it really is a trusted mounter, and it is in a
> > > configuration that IMA has a reasonable expectation of seeing all of
> > > the changes it would be nice if we can say please trust this mount.
> > 
> > IMA has no way of detecting file change.  This was one of the reasons
> > for the original patch set's not using the cached IMA results.
> > 
> > Even in the case of a trusted mounter and not using IMA cached
> > results, there are no guarantees that the data read to calculate the
> > file hash, will be the same as what is subsequently read.  In some
> > environments this might be an acceptable risk, while in others not.
> 
> So for the cases where it's not, there should be an IMA option or policy
> to say any SB_I_IMA_UNVERIFIABLE_SIGNATURES mounts should be not
> trusted, with the default being both SB_I_IMA_UNVERIFIABLE_SIGNATURES and
> SB_I_UNTRUSTED_MOUNTER must be true to not trust, right?

Right.  To summarize, we've identified 3 scenarios:
1. Fail signature verification on unprivileged non-init root mounted
file systems.

flags: SB_I_IMA_UNVERIFIABLE_SIGNATURES and SB_I_UNTRUSTED_MOUNTER
(always enabled)

2. Permit signature verification on privileged file system mounts in a
secure system environment.  Willing to accept the risk.  Does not rely
on cached integrity results, but forces re-evaluation.

flags: SB_I_IMA_UNVERIFIABLE_SIGNATURES, not SB_I_UNTRUSTED_MOUNTER or
IMA_FAIL_UNVERIFICABLE_SIGNATURES (default behavior)

3. Fail signature verification also on privileged file system mounts.
Fail safe, unwilling to accept the risk.

flags:
SB_I_IMA_UNVERIFIABLE_SIGNATURES and IMA_FAIL_UNVERIFIABLE_SIGNATURES

Enabled by specifying "ima_policy=unverifiable_sigs" on the boot
command line.

Mimi

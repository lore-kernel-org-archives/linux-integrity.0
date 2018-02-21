Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60154 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750752AbeBUW54 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 21 Feb 2018 17:57:56 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w1LMtvaE061936
        for <linux-integrity@vger.kernel.org>; Wed, 21 Feb 2018 17:57:55 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2g9cprvkpb-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 21 Feb 2018 17:57:55 -0500
Received: from localhost
        by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Wed, 21 Feb 2018 22:57:52 -0000
Subject: Re: [PATCH v1 1/2] ima: fail signature verification on untrusted
 filesystems
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        Seth Forshee <seth.forshee@canonical.com>,
        Dongsu Park <dongsu@kinvolk.io>,
        Alban Crequy <alban@kinvolk.io>
Date: Wed, 21 Feb 2018 17:57:47 -0500
In-Reply-To: <87mv02c65y.fsf@xmission.com>
References: <1519053483-18396-1-git-send-email-zohar@linux.vnet.ibm.com>
         <1519053483-18396-2-git-send-email-zohar@linux.vnet.ibm.com>
         <87zi44mz26.fsf@xmission.com>  <alpine.LRH.2.21.1802201152240.883@namei.org>
         <87tvucifji.fsf@xmission.com>  <1519135329.3736.88.camel@linux.vnet.ibm.com>
         <20180220201636.GA1565@mail.hallyn.com>
         <1519224379.3736.154.camel@linux.vnet.ibm.com>
         <87mv02c65y.fsf@xmission.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1519253867.19593.25.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, 2018-02-21 at 16:46 -0600, Eric W. Biederman wrote:
> Mimi Zohar <zohar@linux.vnet.ibm.com> writes:
> 
> >> > > On the flip side when it really is a trusted mounter, and it is in a
> >> > > configuration that IMA has a reasonable expectation of seeing all of
> >> > > the changes it would be nice if we can say please trust this mount.
> >> > 
> >> > IMA has no way of detecting file change.  This was one of the reasons
> >> > for the original patch set's not using the cached IMA results.
> >> > 
> >> > Even in the case of a trusted mounter and not using IMA cached
> >> > results, there are no guarantees that the data read to calculate the
> >> > file hash, will be the same as what is subsequently read.  In some
> >> > environments this might be an acceptable risk, while in others not.
> >> 
> >> So for the cases where it's not, there should be an IMA option or policy
> >> to say any SB_I_IMA_UNVERIFIABLE_SIGNATURES mounts should be not
> >> trusted, with the default being both SB_I_IMA_UNVERIFIABLE_SIGNATURES and
> >> SB_I_UNTRUSTED_MOUNTER must be true to not trust, right?
> >
> > Right.  To summarize, we've identified 3 scenarios:
> > 1. Fail signature verification on unprivileged non-init root mounted
> > file systems.
> >
> > flags: SB_I_IMA_UNVERIFIABLE_SIGNATURES and SB_I_UNTRUSTED_MOUNTER
> > (always enabled)
> >
> > 2. Permit signature verification on privileged file system mounts in a
> > secure system environment.  Willing to accept the risk.  Does not rely
> > on cached integrity results, but forces re-evaluation.
> >
> > flags: SB_I_IMA_UNVERIFIABLE_SIGNATURES, not SB_I_UNTRUSTED_MOUNTER or
> > IMA_FAIL_UNVERIFICABLE_SIGNATURES (default behavior)
> >
> > 3. Fail signature verification also on privileged file system mounts.
> > Fail safe, unwilling to accept the risk.
> >
> > flags:
> > SB_I_IMA_UNVERIFIABLE_SIGNATURES and IMA_FAIL_UNVERIFIABLE_SIGNATURES
> >
> > Enabled by specifying "ima_policy=unverifiable_sigs" on the boot
> > command line.
> 
> There is another scenaro.
> 4. Permit signature verification on out of kernel but otherwise fully
>    capable and trusted filesystems.
> 
> Fuse has a mode where it appears to be cache coherent, and guaranteed to
> be local. AKA when fuse block is used and FUSE_WRITEBACK_CACHE is set.
> That configuratioin plus the the allow_other mount option appear to
> signal a fuse mount that can be reasonably be trusted as much as an
> in-kernel block based filesystem.
> 
> That is a mode someone might use to mount exFat or ntfs-3g.
> 
> As all writes come from the kernel, and it is safe to have a write-back
> cache I believe ima can reasonably verify signatures.  There may be
> something technical like the need to verify i_version in this case,
> but for purposes of argument let's say fuse has implemented all of the
> necessary technical details.
> 
> In that case we have a case where it is reasonable to say that
> SB_I_IMA_UNVERIFIABLE_SIGNATURES would be incorrect to set on a fuse
> filesystem.
> 
> Mimi do you agree or am I missing something?

This simply sounds like a performance improvement to the second
scenario, where instead of *always* forcing re-validation, it checks
the i_version.  Perhaps based on a different flag.

Mimi 

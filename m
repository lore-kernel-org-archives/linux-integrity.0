Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58104 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751344AbeBTOCW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Feb 2018 09:02:22 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w1KE0s5A049002
        for <linux-integrity@vger.kernel.org>; Tue, 20 Feb 2018 09:02:21 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2g8j0p7wf4-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 20 Feb 2018 09:02:20 -0500
Received: from localhost
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Tue, 20 Feb 2018 14:02:16 -0000
Subject: Re: [PATCH v1 1/2] ima: fail signature verification on untrusted
 filesystems
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>,
        James Morris <jmorris@namei.org>
Cc: linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        Seth Forshee <seth.forshee@canonical.com>,
        Dongsu Park <dongsu@kinvolk.io>,
        Alban Crequy <alban@kinvolk.io>,
        "Serge E . Hallyn" <serge@hallyn.com>
Date: Tue, 20 Feb 2018 09:02:09 -0500
In-Reply-To: <87tvucifji.fsf@xmission.com>
References: <1519053483-18396-1-git-send-email-zohar@linux.vnet.ibm.com>
         <1519053483-18396-2-git-send-email-zohar@linux.vnet.ibm.com>
         <87zi44mz26.fsf@xmission.com> <alpine.LRH.2.21.1802201152240.883@namei.org>
         <87tvucifji.fsf@xmission.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1519135329.3736.88.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, 2018-02-19 at 20:02 -0600, Eric W. Biederman wrote:
> James Morris <jmorris@namei.org> writes:
> 
> > On Mon, 19 Feb 2018, Eric W. Biederman wrote:
> >
> >> Mimi Zohar <zohar@linux.vnet.ibm.com> writes:
> >> 
> >> > Files on untrusted filesystems, such as fuse, can change at any time,
> >> > making the measurement(s) and by extension signature verification
> >> > meaningless.
> >> 
> >> Filesystems with servers?
> >> Remote filesystems?
> >> Perhaps unexpected changes.
> >> 
> >> Untrusted sounds a bit harsh, and I am not certain it quite captures
> >> what you are looking to avoid.
> >
> > Right -- I think whether you trust a filesystem or not depends on how much 
> > assurance you have in your specific configuration, rather than whether you 
> > think the filesystem can be manipulated or not.
> >
> > There is a difference between:
> >
> >   - This fs has no way to communicate a change to IMA, and;
> >
> >   - This fs could be malicious.
> >
> > In the latter case, I suggest that any fs could be malicious if the 
> > overall security policy / settings are inadequate for the threat model, or 
> > if there are vulnerabilities which allow such security to be bypassed.
> >
> > Whether a user trusts FUSE on their particular system should be a policy 
> > decision on the part of the user.  The kernel should not be deciding what 
> > is trusted or not trusted here.
> 
> I believe there has been a good techincal argument made that fuse
> mounted by an malicious user can defeat the protections ima is trying to
> provide.
> 
> In particular the file could change after the signature of the file has
> been verified without ima being alerted.
> 
> As such I think it is very reasonable for ima when a fuse filesystem has
> been mounted by an unprivileged user to report that it can not verify
> signatures, because IMA can not verify signatures in a meaningful way.
> 
> Now that might be better called SB_I_IMA_UNVERIFIABLE_SIGNATURES.

The file signatures are always unverifiable, whether it is mounted by
root or an unprivileged user.  This flag would always be set.

> We may want to complement that flag with SB_I_UNTRUSTED_MOUNTER.
> For the times when it is not the global root user who mounts
> the filesystem.

Ok

> So I do think when both conditions are true there very much is a case
> for the kernel saying realizing it would be stupid to trust sigantures
> it can not reliably verify.

Agreed

> On the flip side when it really is a trusted mounter, and it is in a
> configuration that IMA has a reasonable expectation of seeing all of
> the changes it would be nice if we can say please trust this mount.

IMA has no way of detecting file change.  This was one of the reasons
for the original patch set's not using the cached IMA results.

Even in the case of a trusted mounter and not using IMA cached
results, there are no guarantees that the data read to calculate the
file hash, will be the same as what is subsequently read.  In some
environments this might be an acceptable risk, while in others not.

> It would also be nice if I could provide all of this information at
> mount time (when I am the global root) with mount options.  So I don't
> need to update all of my tooling to know how to update ima policy when I
> am mounting a filesystem.

The latest version of this patch relies on a builtin IMA policy to set
a flag.  No other changes are required to the IMA policy.  This
builtin policy could be used for environments not willing to accept
the default unverifiable signature risk.

Mimi

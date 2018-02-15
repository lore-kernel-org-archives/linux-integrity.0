Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54908 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1164166AbeBORw3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Feb 2018 12:52:29 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w1FHqNNP084415
        for <linux-integrity@vger.kernel.org>; Thu, 15 Feb 2018 12:52:29 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2g5cd9r4dg-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 15 Feb 2018 12:52:28 -0500
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Thu, 15 Feb 2018 17:52:25 -0000
Subject: Re: [RFC PATCH 2/4] ima: fail signature verification on
 unprivileged & untrusted filesystems
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        Seth Forshee <seth.forshee@canonical.com>,
        Dongsu Park <dongsu@kinvolk.io>,
        Alban Crequy <alban@kinvolk.io>,
        "Serge E. Hallyn" <serge@hallyn.com>
Date: Thu, 15 Feb 2018 12:52:20 -0500
In-Reply-To: <87a7wayzcl.fsf@xmission.com>
References: <1518615315-7162-1-git-send-email-zohar@linux.vnet.ibm.com>
         <1518615315-7162-2-git-send-email-zohar@linux.vnet.ibm.com>
         <87po57yvix.fsf@xmission.com>  <1518698285.5667.87.camel@linux.vnet.ibm.com>
         <87a7wayzcl.fsf@xmission.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1518717140.5667.145.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, 2018-02-15 at 10:47 -0600, Eric W. Biederman wrote:
> Mimi Zohar <zohar@linux.vnet.ibm.com> writes:
> 
> > On Wed, 2018-02-14 at 17:57 -0600, Eric W. Biederman wrote:
> >> Mimi Zohar <zohar@linux.vnet.ibm.com> writes:
> >> 
> >> > Files on untrusted filesystems, such as fuse, can change at any time,
> >> > making the measurement(s) and by extension signature verification
> >> > meaningless.
> >> >
> >> > FUSE can be mounted by unprivileged users either today with fusermount
> >> > installed with setuid, or soon with the upcoming patches to allow FUSE
> >> > mounts in a non-init user namespace.
> >> >
> >> > This patch always fails the file signature verification on unprivileged
> >> > and untrusted filesystems.  To also fail file signature verification on
> >> > privileged, untrusted filesystems requires a custom policy.
> >> >
> >> > (This patch is based on Alban Crequy's use of fs_flags and patch
> >> >  description.)
> >> 
> >> This would be much better done based on a flag in s_iflags and then the
> >> mounts that need this can set this.  That new flag can perhaps be called
> >> SB_I_IMA_FAIL.
> >> 
> >> Among other things that should allow the policy of when to set this to
> >> be set in fuse where it is obvious rather than in an magic location in
> >> IMA.
> >
> > Using s_iflags instead of fs_flags is fine, but I'm not sure how this
> > affects the IMA policy.  This patch set assumes only unprivileged,
> > untrusted filesytems can automatically fail file signature
> > verification (2nd patch), as that hasn't yet been upstreamed and won't
> > break userspace.
> >
> > Based on policy, IMA should additionally be able to fail the signature
> > verification for files on privileged, untrusted filesystems.
> 
> Apologies ima has a very specific meaning of policy, as in the loaded
> ima policy.  I was meaning the hard coded policy of which filesystems
> we simply would not trust by default.
> 
> In code terms what I was thinking would look something like:
> 
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -292,7 +292,14 @@ int ima_appraise_measurement(enum ima_hooks func,
>  	}
>   
>  out:
> -	if (status != INTEGRITY_PASS) {
> +	/* Fail if we can't trust the fs enough to support ima xattrs (FUSE) */
> +	if (inode->i_sb->s_iflags & SB_I_NOIMA) {
> +		status = INTEGRITY_FAIL;
> +		cause = "untrusted-filesystem";
> +		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode, filename,
> +				    op, cause, rc, 0);
> +	} else if (status != INTEGRITY_PASS) {
>  		if ((ima_appraise & IMA_APPRAISE_FIX) &&
>  		    (!xattr_value ||
>   		     xattr_value->type != EVM_IMA_XATTR_DIGSIG)) {
> 
> And somewhere in the fuse mount code it would say:
> 
> 	if (sb->s_user_ns != &init_user_ns)
>         	sb->s_iflags |= SB_I_NOIMA);

SB_I_NOIMA would be really confusing, as we're not disabling IMA in
general, just failing the signature verification.  The measurement,
even if it is meaningless, is an indication in the measurement list
that the file was accessed/executed.

I would propose naming the flag SB_I_IMA_UNTRUSTED, meaning the kernel
is unaware of fs changes.

> 
> The point being that the logic for setting the flag can live in fuse or
> a simpler filesystem and all ima proper needs to do is deal with the flag being
> set.  That should be easier to maintainer and simpler to code all
> around.

The last patch (4/4) had 1 line, which set the fs_flags
unconditionally in fuse_fs_type.  Instead, we can set the sb->s_iflags 
in fuse_fill_supper(), again unconditionally, letting IMA-appraisal
differentiate between privileged and unprivileged.

Mimi

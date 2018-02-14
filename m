Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from out02.mta.xmission.com ([166.70.13.232]:37227 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032055AbeBNX5t (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Feb 2018 18:57:49 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        Seth Forshee <seth.forshee@canonical.com>,
        Dongsu Park <dongsu@kinvolk.io>,
        Alban Crequy <alban@kinvolk.io>,
        "Serge E. Hallyn" <serge@hallyn.com>
References: <1518615315-7162-1-git-send-email-zohar@linux.vnet.ibm.com>
        <1518615315-7162-2-git-send-email-zohar@linux.vnet.ibm.com>
Date: Wed, 14 Feb 2018 17:57:26 -0600
In-Reply-To: <1518615315-7162-2-git-send-email-zohar@linux.vnet.ibm.com> (Mimi
        Zohar's message of "Wed, 14 Feb 2018 08:35:13 -0500")
Message-ID: <87po57yvix.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [RFC PATCH 2/4] ima: fail signature verification on unprivileged & untrusted filesystems
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Mimi Zohar <zohar@linux.vnet.ibm.com> writes:

> Files on untrusted filesystems, such as fuse, can change at any time,
> making the measurement(s) and by extension signature verification
> meaningless.
>
> FUSE can be mounted by unprivileged users either today with fusermount
> installed with setuid, or soon with the upcoming patches to allow FUSE
> mounts in a non-init user namespace.
>
> This patch always fails the file signature verification on unprivileged
> and untrusted filesystems.  To also fail file signature verification on
> privileged, untrusted filesystems requires a custom policy.
>
> (This patch is based on Alban Crequy's use of fs_flags and patch
>  description.)

This would be much better done based on a flag in s_iflags and then the
mounts that need this can set this.  That new flag can perhaps be called
SB_I_IMA_FAIL.

Among other things that should allow the policy of when to set this to
be set in fuse where it is obvious rather than in an magic location in
IMA.

Eric

> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: Seth Forshee <seth.forshee@canonical.com>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Cc: Dongsu Park <dongsu@kinvolk.io>
> Cc: Alban Crequy <alban@kinvolk.io>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> ---
>  include/linux/fs.h                    |  1 +
>  security/integrity/ima/ima_appraise.c | 10 +++++++++-
>  2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 2a815560fda0..faffe4aab43d 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2069,6 +2069,7 @@ struct file_system_type {
>  #define FS_BINARY_MOUNTDATA	2
>  #define FS_HAS_SUBTYPE		4
>  #define FS_USERNS_MOUNT		8	/* Can be mounted by userns root */
> +#define FS_UNTRUSTED		16	/* Defined filesystem as untrusted */
>  #define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename() internally. */
>  	struct dentry *(*mount) (struct file_system_type *, int,
>  		       const char *, void *);
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index f2803a40ff82..af8add31fe26 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -292,7 +292,14 @@ int ima_appraise_measurement(enum ima_hooks func,
>  	}
>  
>  out:
> -	if (status != INTEGRITY_PASS) {
> +	/* Fail untrusted and unpriviliged filesystems (eg FUSE) */
> +	if ((inode->i_sb->s_type->fs_flags & FS_UNTRUSTED) &&
> +	    (inode->i_sb->s_user_ns != &init_user_ns)) {
> +		status = INTEGRITY_FAIL;
> +		cause = "untrusted-filesystem";
> +		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode, filename,
> +				    op, cause, rc, 0);
> +	} else if (status != INTEGRITY_PASS) {
>  		if ((ima_appraise & IMA_APPRAISE_FIX) &&
>  		    (!xattr_value ||
>  		     xattr_value->type != EVM_IMA_XATTR_DIGSIG)) {
> @@ -309,6 +316,7 @@ int ima_appraise_measurement(enum ima_hooks func,
>  	} else {
>  		ima_cache_flags(iint, func);
>  	}
> +
>  	ima_set_cache_status(iint, func, status);
>  	return status;
>  }

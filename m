Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59016 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751986AbeBZQD0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Feb 2018 11:03:26 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w1QG1Tdh019266
        for <linux-integrity@vger.kernel.org>; Mon, 26 Feb 2018 11:03:26 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2gcj981hg2-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 26 Feb 2018 11:03:25 -0500
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 26 Feb 2018 16:03:22 -0000
Subject: Re: IMA/EVM writing xattrs during remount filesystem
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-integrity@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel@pengutronix.de
Date: Mon, 26 Feb 2018 11:03:18 -0500
In-Reply-To: <20180226153812.o5qcrcmlundu7pen@pengutronix.de>
References: <20180226142305.mbuuyibpvzzrcvbm@pengutronix.de>
         <1519657925.3562.264.camel@linux.vnet.ibm.com>
         <20180226153812.o5qcrcmlundu7pen@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1519660998.3562.277.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, 2018-02-26 at 16:38 +0100, Sascha Hauer wrote:
> On Mon, Feb 26, 2018 at 10:12:05AM -0500, Mimi Zohar wrote:
> > Hi Sascha,
> > 
> > On Mon, 2018-02-26 at 15:23 +0100, Sascha Hauer wrote:
> > > Hi All,
> > > 
> > > When a filesystem is remounted from rw to ro then
> > > sb_prepare_remount_readonly() is called. After this call there shouldn't
> > > be any writers left on the filesystem. However, IMA/EVM is not aware of
> > > this as it never calls mnt_want_write[_file](), but only looks add the
> > > MS_RDONLY superblock flag before writing to its xattrs. This flag is
> > > only changed after sb->s_op->remount_fs() is called. As a consequence
> > > IMA/EVM still updates xattrs while the filesystem is going to readonly
> > > mode.
> > > 
> > > We observed that on a 4.0 Kernel in conjunction with UBIFS, but the
> > > relevant code in IMA/EVM still looks the same so I assume it's present
> > > in the current kernel aswell.
> > > 
> > > UBIFS calculates its free space before and after the remount_fs op and
> > > if there's a difference it prints a backtrace (dbg_check_space_info:
> > > free space changed from x to y). We see this backtrace sometimes when
> > > remounting the fs readonly. If I understand the situation correctly this
> > > is not UBIFS's fault, right? Any hint what we can do about it?
> > 
> > Not updating the file hashes could result in verification errors.  I
> > would classify updating the xattrs as working as designed.  Wouldn't
> > you?
> 
> If IMA updates the hash for a file that actually gets written then the
> file is opened for writing. Trying remount the filesystem readonly in
> this situation will return -EBUSY. Everything fine here, but look at
> evm_verify_hmac(). Here a file is not necessarily opened for writing,
> but if the file is signed the code replaces the signature with a HMAC by
> calling evm_update_evmxattr(). This function updates the xattr even when
> the VFS is in the process of remounting the filesystem readonly.
> 
> More specifically look at do_remount_sb():
> 
> >	/* If we are remounting RDONLY and current sb is read/write,
> >	   make sure there are no rw files opened */
> >	if (remount_ro) {
> >		if (force) {
> >			sb->s_readonly_remount = 1;
> >			smp_wmb();
> >		} else {
> >			retval = sb_prepare_remount_readonly(sb);
> >			if (retval)
> >				return retval;
> >		}
> >	}
> 
> When sb_prepare_remount_readonly() succeeds there are no writers left.
> 
> >
> >	if (sb->s_op->remount_fs) {
> >		retval = sb->s_op->remount_fs(sb, &sb_flags, data);
> >		if (retval) {
> >			if (!force)
> >				goto cancel_readonly;
> >			/* If forced remount, go ahead despite any errors */
> >			WARN(1, "forced remount of a %s fs returned %i\n",
> >			     sb->s_type->name, retval);
> >		}
> >	}
> 
> remount_fs assumes VFS has stopped writing. At least UBIFS expects this,
> maybe it's wrong:
> 
> /**
>  * ubifs_remount_ro - re-mount in read-only mode.
>  * @c: UBIFS file-system description object
>  *
>  * We assume VFS has stopped writing. Possibly the background thread could be
>  * running a commit, however kthread_stop will wait in that case.
>  */
> 
> >	sb->s_flags = (sb->s_flags & ~MS_RMT_MASK) | (sb_flags & MS_RMT_MASK);
> 
> Here, *after* remount_fs has returned the MS_RDONLY sb flag is set which
> EVM tests for before calling evm_update_evmxattr() and the race window
> closes.

So the cause of the problem is not IMA, per se, but EVM converting the
EVM signature to an HMAC.  There's no harm in not re-writing the xattr
signature as an HMAC.  Feel free to add the additional
"s_readonly_remount" test.

During this open window, we upstreamed support for EVM portable and
immutable file signatures.  Please make sure you base the change on
the linux-integrity #next-integrity branch.

thanks,

Mimi

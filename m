Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59665 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752017AbeB0H1g (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Feb 2018 02:27:36 -0500
Date: Tue, 27 Feb 2018 08:27:34 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: IMA/EVM writing xattrs during remount filesystem
Message-ID: <20180227072734.resrlh6mpkkd5ko6@pengutronix.de>
References: <20180226142305.mbuuyibpvzzrcvbm@pengutronix.de>
 <1519657925.3562.264.camel@linux.vnet.ibm.com>
 <20180226153812.o5qcrcmlundu7pen@pengutronix.de>
 <1519660998.3562.277.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <1519660998.3562.277.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, Feb 26, 2018 at 11:03:18AM -0500, Mimi Zohar wrote:
> >  * ubifs_remount_ro - re-mount in read-only mode.
> >  * @c: UBIFS file-system description object
> >  *
> >  * We assume VFS has stopped writing. Possibly the background thread could be
> >  * running a commit, however kthread_stop will wait in that case.
> >  */
> > 
> > >	sb->s_flags = (sb->s_flags & ~MS_RMT_MASK) | (sb_flags & MS_RMT_MASK);
> > 
> > Here, *after* remount_fs has returned the MS_RDONLY sb flag is set which
> > EVM tests for before calling evm_update_evmxattr() and the race window
> > closes.
> 
> So the cause of the problem is not IMA, per se, but EVM converting the
> EVM signature to an HMAC.  There's no harm in not re-writing the xattr
> signature as an HMAC.  Feel free to add the additional
> "s_readonly_remount" test.

Ok, that should work. I'll give it some testing here before I send a
patch.

> 
> During this open window, we upstreamed support for EVM portable and
> immutable file signatures.  Please make sure you base the change on
> the linux-integrity #next-integrity branch.

sure, thanks

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

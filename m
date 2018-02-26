Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:47655 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753298AbeBZOXH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Feb 2018 09:23:07 -0500
Date: Mon, 26 Feb 2018 15:23:05 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
To: linux-integrity@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>, kernel@pengutronix.de
Subject: IMA/EVM writing xattrs during remount filesystem
Message-ID: <20180226142305.mbuuyibpvzzrcvbm@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi All,

When a filesystem is remounted from rw to ro then
sb_prepare_remount_readonly() is called. After this call there shouldn't
be any writers left on the filesystem. However, IMA/EVM is not aware of
this as it never calls mnt_want_write[_file](), but only looks add the
MS_RDONLY superblock flag before writing to its xattrs. This flag is
only changed after sb->s_op->remount_fs() is called. As a consequence
IMA/EVM still updates xattrs while the filesystem is going to readonly
mode.

We observed that on a 4.0 Kernel in conjunction with UBIFS, but the
relevant code in IMA/EVM still looks the same so I assume it's present
in the current kernel aswell.

UBIFS calculates its free space before and after the remount_fs op and
if there's a difference it prints a backtrace (dbg_check_space_info:
free space changed from x to y). We see this backtrace sometimes when
remounting the fs readonly. If I understand the situation correctly this
is not UBIFS's fault, right? Any hint what we can do about it?

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

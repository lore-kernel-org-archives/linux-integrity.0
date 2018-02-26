Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45462 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750877AbeBZPdX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Feb 2018 10:33:23 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w1QF8raC055855
        for <linux-integrity@vger.kernel.org>; Mon, 26 Feb 2018 10:12:10 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2gckej3vf2-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 26 Feb 2018 10:12:10 -0500
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 26 Feb 2018 15:12:08 -0000
Subject: Re: IMA/EVM writing xattrs during remount filesystem
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Sascha Hauer <s.hauer@pengutronix.de>,
        linux-integrity@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: kernel@pengutronix.de
Date: Mon, 26 Feb 2018 10:12:05 -0500
In-Reply-To: <20180226142305.mbuuyibpvzzrcvbm@pengutronix.de>
References: <20180226142305.mbuuyibpvzzrcvbm@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1519657925.3562.264.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi Sascha,

On Mon, 2018-02-26 at 15:23 +0100, Sascha Hauer wrote:
> Hi All,
> 
> When a filesystem is remounted from rw to ro then
> sb_prepare_remount_readonly() is called. After this call there shouldn't
> be any writers left on the filesystem. However, IMA/EVM is not aware of
> this as it never calls mnt_want_write[_file](), but only looks add the
> MS_RDONLY superblock flag before writing to its xattrs. This flag is
> only changed after sb->s_op->remount_fs() is called. As a consequence
> IMA/EVM still updates xattrs while the filesystem is going to readonly
> mode.
> 
> We observed that on a 4.0 Kernel in conjunction with UBIFS, but the
> relevant code in IMA/EVM still looks the same so I assume it's present
> in the current kernel aswell.
> 
> UBIFS calculates its free space before and after the remount_fs op and
> if there's a difference it prints a backtrace (dbg_check_space_info:
> free space changed from x to y). We see this backtrace sometimes when
> remounting the fs readonly. If I understand the situation correctly this
> is not UBIFS's fault, right? Any hint what we can do about it?

Not updating the file hashes could result in verification errors.  I
would classify updating the xattrs as working as designed.  Wouldn't
you?

Perhaps the files changing should not be included in the IMA-appraisal 
policy?

Mimi

Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52500 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753174AbdI1MmH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 28 Sep 2017 08:42:07 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v8SCdkBl126573
        for <linux-integrity@vger.kernel.org>; Thu, 28 Sep 2017 08:42:07 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2d8u44c8fm-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 28 Sep 2017 08:42:07 -0400
Received: from localhost
        by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Thu, 28 Sep 2017 22:42:04 +1000
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>
Subject: [RFC PATCH 0/3] define new read_iter file operation rwf flag
Date: Thu, 28 Sep 2017 08:39:30 -0400
Message-Id: <1506602373-4799-1-git-send-email-zohar@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

This patch set replaces the "integrity_read" file operation method,
as defined in the "ima: use fs method to read integrity data" patch,
with a new read_iter file operation "rwf" flag.  (The other patches
are the same.*)

The main difference between these approaches is whether IMA must be
explicitly enabled (opt-in), by defining the "integrity_read" file
operation method for each file system, or enabled by default, with
modifications as needed to the read_iter.

*The entire patch sets can be found in
git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
next-integrity-read and next-read-iter.

Mimi

Mimi Zohar (3):
  fs: define new read_iter rwf flag
  integrity: use call_read_iter to calculate the file hash
  fs: detect that the i_rwsem has already been taken exclusively

 arch/s390/hypfs/inode.c                      |  3 ++-
 drivers/block/loop.c                         |  2 +-
 drivers/char/mem.c                           |  6 ++++--
 drivers/gpu/drm/drm_dp_aux_dev.c             |  3 ++-
 drivers/net/tap.c                            |  3 ++-
 drivers/net/tun.c                            |  3 ++-
 drivers/staging/android/ashmem.c             |  3 ++-
 drivers/staging/lustre/lustre/llite/file.c   |  3 ++-
 drivers/staging/lustre/lustre/llite/vvp_io.c |  2 +-
 drivers/usb/gadget/function/f_fs.c           |  3 ++-
 drivers/usb/gadget/legacy/inode.c            |  2 +-
 drivers/vhost/net.c                          |  3 ++-
 fs/9p/vfs_file.c                             |  8 +++++---
 fs/aio.c                                     |  2 +-
 fs/block_dev.c                               |  4 ++--
 fs/ceph/file.c                               |  5 +++--
 fs/cifs/cifsfs.c                             |  6 +++---
 fs/cifs/cifsfs.h                             |  4 ++--
 fs/cifs/file.c                               | 10 +++++-----
 fs/coda/file.c                               |  2 +-
 fs/ecryptfs/file.c                           |  4 ++--
 fs/efivarfs/file.c                           |  2 +-
 fs/ext2/file.c                               | 16 +++++++++------
 fs/ext4/file.c                               | 20 +++++++++++--------
 fs/fuse/cuse.c                               |  3 ++-
 fs/fuse/dev.c                                |  3 ++-
 fs/fuse/file.c                               |  8 +++++---
 fs/hugetlbfs/inode.c                         |  3 ++-
 fs/ncpfs/file.c                              |  2 +-
 fs/nfs/file.c                                |  4 ++--
 fs/nfs/internal.h                            |  2 +-
 fs/ocfs2/file.c                              |  5 +++--
 fs/orangefs/file.c                           |  3 ++-
 fs/pipe.c                                    |  2 +-
 fs/read_write.c                              |  4 ++--
 fs/splice.c                                  |  2 +-
 fs/xfs/xfs_file.c                            | 30 +++++++++++++++++-----------
 include/linux/fs.h                           | 10 +++++-----
 mm/filemap.c                                 |  3 ++-
 mm/shmem.c                                   |  3 ++-
 net/socket.c                                 |  4 ++--
 security/integrity/iint.c                    | 21 +++++++++++++------
 sound/core/pcm_native.c                      |  2 +-
 43 files changed, 139 insertions(+), 94 deletions(-)

-- 
2.7.4

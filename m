Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32987 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752388AbeA3SF2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Jan 2018 13:05:28 -0500
Received: by mail-wm0-f67.google.com with SMTP id x4so4785974wmc.0
        for <linux-integrity@vger.kernel.org>; Tue, 30 Jan 2018 10:05:28 -0800 (PST)
From: Dongsu Park <dongsu@kinvolk.io>
To: linux-kernel@vger.kernel.org
Cc: linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Alban Crequy <alban@kinvolk.io>,
        Dongsu Park <dongsu@kinvolk.io>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Seth Forshee <seth.forshee@canonical.com>
Subject: [RFC PATCH v4 0/2] ima,fuse: introduce new fs flag FS_IMA_NO_CACHE
Date: Tue, 30 Jan 2018 19:06:30 +0100
Message-Id: <cover.1517314847.git.dongsu@kinvolk.io>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

This patchset v4 introduces a new fs flag FS_IMA_NO_CACHE and uses it in
FUSE. This forces files to be re-measured, re-appraised and re-audited
on file systems with the feature flag FS_IMA_NO_CACHE. In that way,
cached integrity results won't be used.

There was a previous attempt (unmerged) with a IMA option named "force" and using
that option for FUSE filesystems. These patches use a different approach
so that the IMA subsystem does not need to know about FUSE.
- https://www.spinics.net/lists/linux-integrity/msg00948.html
- https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1584131.html

Changes since v1: https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1587390.html
- include linux-fsdevel mailing list in cc
- mark patch as RFC
- based on next-integrity, without other unmerged FUSE / IMA patches

Changes since v2: https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1587678.html
- rename flag to FS_IMA_NO_CACHE
- split patch into 2

Changes since v3: https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1592393.html
- make the code simpler by resetting IMA_DONE_MASK

The patchset is also available in our github repo:
  https://github.com/kinvolk/linux/tree/dongsu/fuse-flag-ima-nocache-v4


Alban Crequy (2):
  fuse: introduce new fs_type flag FS_IMA_NO_CACHE
  ima: force re-appraisal on filesystems with FS_IMA_NO_CACHE

 fs/fuse/inode.c                   |  2 +-
 include/linux/fs.h                |  1 +
 security/integrity/ima/ima_main.c | 15 +++++++++++++--
 3 files changed, 15 insertions(+), 3 deletions(-)

-- 
2.13.6

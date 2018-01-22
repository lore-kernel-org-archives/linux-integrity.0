Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39205 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751028AbeAVQZA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 Jan 2018 11:25:00 -0500
From: Alban Crequy <alban.crequy@gmail.com>
To: alban@kinvolk.io
Cc: dongsu@kinvolk.io, iago@kinvolk.io, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, miklos@szeredi.hu,
        viro@zeniv.linux.org.uk, zohar@linux.vnet.ibm.com,
        dmitry.kasatkin@gmail.com, james.l.morris@oracle.com,
        serge@hallyn.com, seth.forshee@canonical.com, hch@infradead.org
Subject: [RFC PATCH v3 0/2] ima,fuse: introduce new fs flag FS_IMA_NO_CACHE
Date: Mon, 22 Jan 2018 17:24:50 +0100
Message-Id: <20180122162452.8756-1-alban@kinvolk.io>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

This patchset v3 introduces a new fs flag FS_IMA_NO_CACHE and uses it in
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

The patchset is also available in our github repo:
  https://github.com/kinvolk/linux/tree/alban/fuse-flag-ima-nocache-v3


Alban Crequy (2):
  fuse: introduce new fs_type flag FS_IMA_NO_CACHE
  ima: force re-appraisal on filesystems with FS_IMA_NO_CACHE

 fs/fuse/inode.c                   |  2 +-
 include/linux/fs.h                |  1 +
 security/integrity/ima/ima_main.c | 24 ++++++++++++++++++++++--
 3 files changed, 24 insertions(+), 3 deletions(-)

-- 
2.13.6

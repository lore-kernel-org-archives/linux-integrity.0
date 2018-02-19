Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47732 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752793AbeBSPST (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Feb 2018 10:18:19 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w1JFFURj051116
        for <linux-integrity@vger.kernel.org>; Mon, 19 Feb 2018 10:18:18 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2g7yqcvj6j-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 19 Feb 2018 10:18:18 -0500
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 19 Feb 2018 15:18:16 -0000
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH v1 0/2] ima: untrusted filesystems 
Date: Mon, 19 Feb 2018 10:18:01 -0500
Message-Id: <1519053483-18396-1-git-send-email-zohar@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Based on the mailing list discussions, it is clear that separating the
non-init unpriviliged, mounted untrusted filesystem from setuid
unprivileged or privileged mounted untrusted filesystems patches was
confusing.  I've combined the patches, commenting the code with an
explanation for the differentiation.

Instad of expliciting modifying the IMA policy to fail file signature
verfication for the setuid unprivileged or privileged mounted untrusted
filesystems cases, this patch set defines a builtin IMA policy named
"untrusted-fs".  No other IMA policy changes are required.

Mimi


Changelog v1:
- Merged the unprivileged and privileged patches.
- Dropped IMA fsname support.
- Introduced a new IMA builtin policy named "untrusted_fs".
- Replaced fs_type flag with sb->s_iflags flag.

Mimi Zohar (2):
  ima: fail signature verification on untrusted filesystems
  fuse: define the filesystem as untrusted

 Documentation/admin-guide/kernel-parameters.txt |  6 +++++-
 fs/fuse/inode.c                                 |  1 +
 include/linux/fs.h                              |  1 +
 security/integrity/ima/ima_appraise.c           | 16 +++++++++++++++-
 security/integrity/ima/ima_policy.c             |  5 +++++
 security/integrity/integrity.h                  |  1 +
 6 files changed, 28 insertions(+), 2 deletions(-)

-- 
2.7.5

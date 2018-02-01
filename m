Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39320 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752661AbeBASiK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Feb 2018 13:38:10 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w11IYuns143012
        for <linux-integrity@vger.kernel.org>; Thu, 1 Feb 2018 13:38:10 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2fv85qggfs-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 01 Feb 2018 13:38:09 -0500
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Thu, 1 Feb 2018 18:38:07 -0000
Subject: [GIT PULL] IMA bug fixes for 4.16
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: James Morris <jmorris@namei.org>
Cc: linux-security-module <linux-security-module@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date: Thu, 01 Feb 2018 13:38:02 -0500
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1517510282.6675.13.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi James,

Included in this pull request are three bug fixes, assuming the 2 FUSE
patches are considered bugs and not new features, and a maintainer update.
I'd appreciate your sending them to Linus for 4.16.

thanks,

Mimi

The following changes since commit 36447456e1cca853188505f2a964dbbeacfc7a7a:

  ima/policy: fix parsing of fsuuid (2018-01-18 16:52:49 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity

for you to fetch changes up to d56f30ac85c067d0d3a6c4f293f655dc298cb5ce:

  ima: force re-appraisal on filesystems with FS_IMA_NO_CACHE (2018-02-01 12:38:31 -0500)

----------------------------------------------------------------
Alban Crequy (2):
      fuse: introduce new fs_type flag FS_IMA_NO_CACHE
      ima: force re-appraisal on filesystems with FS_IMA_NO_CACHE

Mimi Zohar (2):
      ima: re-initialize iint->atomic_flags
      maintainers: update trusted keys

 MAINTAINERS                       |  1 +
 fs/fuse/inode.c                   |  2 +-
 include/linux/fs.h                |  1 +
 security/integrity/iint.c         |  1 +
 security/integrity/ima/ima_main.c | 15 +++++++++++++--
 5 files changed, 17 insertions(+), 3 deletions(-)

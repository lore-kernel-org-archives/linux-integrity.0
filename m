Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41058 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751158AbeBVVdN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 22 Feb 2018 16:33:13 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w1MLTMdw061374
        for <linux-integrity@vger.kernel.org>; Thu, 22 Feb 2018 16:33:13 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ga25yrgk7-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 22 Feb 2018 16:33:12 -0500
Received: from localhost
        by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Thu, 22 Feb 2018 21:33:10 -0000
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH v2 0/4] ima: unverifiable file signatures
Date: Thu, 22 Feb 2018 16:33:00 -0500
Message-Id: <1519335184-17808-1-git-send-email-zohar@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

For local filesystems, the kernel prevents files being executed from
being modified.  With IMA-measurement enabled, the kernel also emits
audit "time of measure, time of use" messages for files opened for
read, and subsequently opened for write.

Files on fuse are initially measured, appraised, and audited.  Although
the file data can change dynamically any time, making re-measuring,
re-appraising, or re-auditing pointless, this patch set attempts to
differentiate between unprivileged non-init root and privileged
mounted fuse filesystems.

This patch set addresses three different scenarios:
- Unprivileged non-init root mounted fuse filesystems are untrusted.
  Signature verification should always fail and re-measuring,
  re-appraising, re-auditing files makes no sense.

  Always enabled.

- For privileged mounted filesystems in a "secure" environment, with a
  correctly enforced security policy, which is willing to assume the
  inherent risk of specific fuse filesystems, it is reasonable to
  re-measure, re-appraise, and re-audit files.

  Enabled by default to prevent breaking existing systems.

- Privileged mounted filesystems unwilling to assume the risks and
  prefers to fail safe.

  Enabled based on policy.

Mimi

Mimi Zohar (4):
  ima: fail file signature verification on non-init mounted filesystems
  ima: re-evaluate files on privileged mounted filesystems
  ima: fail signature verification based on policy
  fuse: define the filesystem as untrusted

 Documentation/admin-guide/kernel-parameters.txt |  8 +++++++-
 fs/fuse/inode.c                                 |  3 +++
 include/linux/fs.h                              |  2 ++
 security/integrity/ima/ima_appraise.c           | 16 +++++++++++++++-
 security/integrity/ima/ima_main.c               | 14 ++++++++++++--
 security/integrity/ima/ima_policy.c             |  5 +++++
 security/integrity/integrity.h                  |  1 +
 7 files changed, 45 insertions(+), 4 deletions(-)

-- 
2.7.5

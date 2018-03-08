Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48792 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750849AbeCHUYT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 8 Mar 2018 15:24:19 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w28K6sKu072148
        for <linux-integrity@vger.kernel.org>; Thu, 8 Mar 2018 15:24:18 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2gk98s743u-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 08 Mar 2018 15:24:17 -0500
Received: from localhost
        by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Thu, 8 Mar 2018 20:24:16 -0000
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH v3 0/4] unverifiable file signatures
Date: Thu,  8 Mar 2018 15:24:06 -0500
Message-Id: <1520540650-7451-1-git-send-email-zohar@linux.vnet.ibm.com>
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
  prefers to securely fail safe.

  Enabled based on policy.

Changelog v3:
- Fix SB_IMA_UNVERIFIABLE_SIGNATURE & SB_I_UNTRUSTED_MOUNTER test.
- Rename the builtin policy name to "fail_securely".

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

Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60204 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388251AbeGXMGf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 24 Jul 2018 08:06:35 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6OAwrZb143705
        for <linux-integrity@vger.kernel.org>; Tue, 24 Jul 2018 07:00:41 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ke0r65vnm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 24 Jul 2018 07:00:41 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 24 Jul 2018 12:00:39 +0100
Subject: [GIT PULL]  linux-integrity patches for 4.19
From: Mimi Zohar <zohar@linux.ibm.com>
To: James Morris <jmorris@namei.org>
Cc: linux-security-module <linux-security-module@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>
Date: Tue, 24 Jul 2018 07:00:23 -0400
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1532430023.4127.10.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi James,

This pull request adds support for EVM signatures based on larger
digests, contains a new audit record AUDIT_INTEGRITY_POLICY_RULE to
differentiate the IMA policy rules from the IMA-audit messages,
addresses two deadlocks due to either loading or searching for crypto
algorithms, and cleans up the audit messages.

New to 4.19, but not included in this pull request, is support for a
build time IMA policy.  Build time IMA policy rules are automatically
enabled on boot and persist after loading a custom policy.

Mimi

The following changes since commit
87ea58433208d17295e200d56be5e2a4fe4ce7d6:

  security: check for kstrdup() failure in lsm_append() (2018-07-17
21:27:06 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-
integrity.git next-integrity

for you to fetch changes up to
3dd0f18c70d94ca2432c78c5735744429f071b0b:

  EVM: fix return value check in evm_write_xattrs() (2018-07-22
14:49:11 -0400)

----------------------------------------------------------------
Matthew Garrett (2):
      evm: Don't deadlock if a crypto algorithm is unavailable
      evm: Allow non-SHA1 digital signatures

Mikhail Kurinnoi (1):
      integrity: prevent deadlock during digsig verification.

Stefan Berger (4):
      ima: Call audit_log_string() rather than logging it untrusted
      ima: Use audit_log_format() rather than audit_log_string()
      ima: Do not audit if CONFIG_INTEGRITY_AUDIT is not set
      ima: Differentiate auditing policy rules from "audit" actions

Sudeep Holla (1):
      integrity: silence warning when CONFIG_SECURITYFS is not enabled

Wei Yongjun (1):
      EVM: fix return value check in evm_write_xattrs()

 crypto/api.c                           |  2 +-
 include/linux/crypto.h                 |  5 ++++
 include/linux/integrity.h              | 13 +++++++++
 include/uapi/linux/audit.h             |  1 +
 security/integrity/digsig_asymmetric.c | 23 ++++++++++++++++
 security/integrity/evm/Kconfig         |  1 +
 security/integrity/evm/evm.h           | 10 +++++--
 security/integrity/evm/evm_crypto.c    | 50 ++++++++++++++++++-------
---------
 security/integrity/evm/evm_main.c      | 19 ++++++++-----
 security/integrity/evm/evm_secfs.c     |  4 +--
 security/integrity/iint.c              |  9 ++++--
 security/integrity/ima/Kconfig         |  1 +
 security/integrity/ima/ima_policy.c    |  9 ++++--
 security/integrity/integrity.h         | 15 ++++++++++
 security/integrity/integrity_audit.c   |  6 +---
 security/security.c                    |  7 ++++-
 16 files changed, 128 insertions(+), 47 deletions(-)

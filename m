Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60786 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752017AbeEKOmm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 May 2018 10:42:42 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4BEe8Up023289
        for <linux-integrity@vger.kernel.org>; Fri, 11 May 2018 10:42:41 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2hwbw33whm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 11 May 2018 10:42:41 -0400
Received: from localhost
        by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <stefanb@linux.vnet.ibm.com>;
        Fri, 11 May 2018 08:42:39 -0600
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org,
        containers@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Cc: serge@hallyn.com, sunyuqiong1988@gmail.com, david.safford@ge.com,
        mkayaalp@cs.binghamton.edu, James.Bottomley@HansenPartnership.com,
        zohar@linux.vnet.ibm.com, ebiederm@xmission.com,
        john.johansen@canonical.com,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [RFC PATCH v4 0/5] ima: Namespacing IMA
Date: Fri, 11 May 2018 10:42:25 -0400
Message-Id: <20180511144230.75384-1-stefanb@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

This patch set implements an IMA namespace data structure that gets
created by first writing a '1' into IMA's securityfs unshare file at
/sys/kernel/security/ima/unshare and then by clone(). This patch set
lays down the foundation for namespacing the different aspects of IMA
(eg. IMA-audit, IMA-measurement, IMA-appraisal).

The original PoC patches created a new CLONE_NEWIMA flag to explicitly
control when a new IMA namespace should be created. The previously posted
version 2 of this series had it hooked on the mount namespace, which was
regarded as inappropriate. The subsequent v3 tied it to the creation of a
user namespace. Based on comments, we elected to now again create an
independent IMA namespace through the above mentioned securityfs file.

The first patch creates the ima_namespace data, while the second patch
puts the iint->flags in the namespace. The third patch introduces an
audit message type for  IMA policy rules. The fourth patch introduces
a new IMA policy rule attribute 'ns' making rules only applicable to child
IMA namespaces. The last patch uses the flags for namespacing the
IMA-audit messages, enabling the same file to be audited each time it
is accessed in a new namespace.

   Stefan

Mehmet Kayaalp (2):
  ima: Add ns_status for storing namespaced iint data
  ima: namespace audit status flags

Mimi Zohar (1):
  ima: differentiate auditing policy rules from "audit" actions

Stefan Berger (1):
  ima: extend IMA audit policy rules with attribute to audit namespaces

Yuqiong Sun (1):
  ima: Add IMA namespace support

 fs/proc/namespaces.c                     |   3 +
 include/linux/ima.h                      |  53 +++++++++
 include/linux/nsproxy.h                  |   2 +
 include/linux/proc_ns.h                  |   1 +
 include/linux/sched.h                    |   6 +
 include/linux/user_namespace.h           |   1 +
 include/uapi/linux/audit.h               |   3 +-
 init/Kconfig                             |  11 ++
 kernel/fork.c                            |   5 +
 kernel/nsproxy.c                         |  25 ++++-
 kernel/ucount.c                          |   1 +
 security/integrity/ima/Makefile          |   3 +-
 security/integrity/ima/ima.h             |  82 +++++++++++++-
 security/integrity/ima/ima_api.c         |  14 ++-
 security/integrity/ima/ima_appraise.c    |   2 +-
 security/integrity/ima/ima_fs.c          |  55 ++++++++++
 security/integrity/ima/ima_init.c        |   4 +
 security/integrity/ima/ima_init_ima_ns.c |  51 +++++++++
 security/integrity/ima/ima_main.c        |  18 ++-
 security/integrity/ima/ima_ns.c          | 183 +++++++++++++++++++++++++++++++
 security/integrity/ima/ima_ns_status.c   | 133 ++++++++++++++++++++++
 security/integrity/ima/ima_policy.c      |  77 ++++++++++++-
 22 files changed, 712 insertions(+), 21 deletions(-)
 create mode 100644 security/integrity/ima/ima_init_ima_ns.c
 create mode 100644 security/integrity/ima/ima_ns.c
 create mode 100644 security/integrity/ima/ima_ns_status.c

-- 
2.14.3

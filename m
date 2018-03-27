Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56772 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752275AbeC0N50 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Mar 2018 09:57:26 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2RDtlgV064781
        for <linux-integrity@vger.kernel.org>; Tue, 27 Mar 2018 09:57:26 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2gyprp1ybe-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 27 Mar 2018 09:57:25 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <stefanb@linux.vnet.ibm.com>;
        Tue, 27 Mar 2018 09:57:25 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: containers@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, tycho@docker.com,
        serge@hallyn.com, sunyuqiong1988@gmail.com, david.safford@ge.com,
        mkayaalp@cs.binghamton.edu, James.Bottomley@HansenPartnership.com,
        zohar@linux.vnet.ibm.com, ebiederm@xmission.com,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [RFC PATCH v3 0/3] ima: namespacing IMA
Date: Tue, 27 Mar 2018 09:57:15 -0400
Message-Id: <1522159038-14175-1-git-send-email-stefanb@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

This patch set implements an IMA namespace data structure that gets
created alongside a user namespace with CLONE_NEWUSER, and lays down the
foundation for namespacing the different aspects of IMA (eg. IMA-audit,
IMA-measurement, IMA-appraisal).

The original PoC patches [1] created a new CLONE_NEWIMA flag to explicitly
control when a new IMA namespace should be created. The previously posted
version 2 of this series had it hooked on the mount namespace, which was
regarded as inappropriate. Based on comments, we elected to hang the IMA
namepace off of the existing user namespace now. In this patch series we
are adding a pointer to the user_namespace pointing to the ima_namespace.
Both are now tied together and joining the user_namespace with setns() also
joins the ima_namespace that was created along with it.

The first patch creates the ima_namespace data, while the second patch
puts the iint->flags in the namespace. The third patch uses these flags
for namespacing the IMA-audit messages, enabling the same file to be
audited each time it is accessed in a new namespace.


   Stefan

Mehmet Kayaalp (2):
  ima: Add ns_status for storing namespaced iint data
  ima: mamespace audit status flags

Yuqiong Sun (1):
  ima: extend clone() with IMA namespace support

 include/linux/ima.h                      |  67 +++++++++
 include/linux/user_namespace.h           |   4 +
 init/Kconfig                             |  10 ++
 kernel/user.c                            |   7 +
 kernel/user_namespace.c                  |  18 +++
 security/integrity/ima/Makefile          |   3 +-
 security/integrity/ima/ima.h             |  47 ++++++-
 security/integrity/ima/ima_api.c         |   8 +-
 security/integrity/ima/ima_init.c        |   4 +
 security/integrity/ima/ima_init_ima_ns.c |  43 ++++++
 security/integrity/ima/ima_main.c        |  15 ++-
 security/integrity/ima/ima_ns.c          | 225 +++++++++++++++++++++++++++++++
 12 files changed, 443 insertions(+), 8 deletions(-)
 create mode 100644 security/integrity/ima/ima_init_ima_ns.c
 create mode 100644 security/integrity/ima/ima_ns.c

-- 
2.14.3

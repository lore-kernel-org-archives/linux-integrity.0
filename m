Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53540 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751192AbeCIUOj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 9 Mar 2018 15:14:39 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w29JtS7V072774
        for <linux-integrity@vger.kernel.org>; Fri, 9 Mar 2018 15:14:38 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2gkwdpg5sr-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 09 Mar 2018 15:14:38 -0500
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <stefanb@linux.vnet.ibm.com>;
        Fri, 9 Mar 2018 15:14:37 -0500
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: linux-ima-devel@lists.sourceforge.net
Cc: containers@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, tycho@docker.com,
        serge@hallyn.com, sunyuqiong1988@gmail.com, david.safford@ge.com,
        mkayaalp@cs.binghamton.edu, linux-integrity@vger.kernel.org,
        James.Bottomley@HansenPartnership.com, zohar@linux.vnet.ibm.com,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [RFC PATCH v2 0/3] ima: namespacing IMA
Date: Fri,  9 Mar 2018 15:14:18 -0500
Message-Id: <20180309201421.6150-1-stefanb@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

This patch set implements an IMA namespace data structure that gets
created alongside a mount namespace with CLONE_NEWNS, and lays down the
foundation for namespacing the different aspects of IMA (eg. IMA-audit,
IMA-measurement, IMA-appraisal).

The original PoC patches [1] created a new CLONE_NEWIMA flag to
explicitly control when a new IMA namespace should be created. Based on
comments, we elected to hang the IMA namepace off of existing namespaces,
and the mount namespace made the most sense. In this version of the patches
we are adding a pointer to the mnt_namespace pointing to the ima_namespace.
Both are now tied together and joining the mnt_namespace with setns()
also joins the ima_namespace that was created along with it.

The first patch creates the ima_namespace data, while the second patch
puts the iint->flags in the namespace. The third patch uses these flags
for namespacing the IMA-audit messages, enabling the same file to be
audited each time it is accessed in a new namespace.

Mehmet Kayaalp (2):
  ima: Add ns_status for storing namespaced iint data
  ima: mamespace audit status flags

Yuqiong Sun (1):
  ima: extend clone() with IMA namespace support

 fs/mount.h                               |  14 --
 fs/namespace.c                           |  29 +++-
 include/linux/ima.h                      |  70 ++++++++++
 include/linux/mount.h                    |  20 ++-
 init/Kconfig                             |  10 ++
 kernel/nsproxy.c                         |   1 +
 security/integrity/ima/Makefile          |   3 +-
 security/integrity/ima/ima.h             |  47 ++++++-
 security/integrity/ima/ima_api.c         |   8 +-
 security/integrity/ima/ima_init.c        |   4 +
 security/integrity/ima/ima_init_ima_ns.c |  44 ++++++
 security/integrity/ima/ima_main.c        |  15 +-
 security/integrity/ima/ima_ns.c          | 230 +++++++++++++++++++++++++++++++
 13 files changed, 469 insertions(+), 26 deletions(-)
 create mode 100644 security/integrity/ima/ima_init_ima_ns.c
 create mode 100644 security/integrity/ima/ima_ns.c

-- 
2.13.6

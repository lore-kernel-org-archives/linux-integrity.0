Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56646 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750805AbeEKBhB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 May 2018 21:37:01 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4B1YnTT147428
        for <linux-integrity@vger.kernel.org>; Thu, 10 May 2018 21:37:00 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2hvvvga257-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 10 May 2018 21:37:00 -0400
Received: from localhost
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Fri, 11 May 2018 02:36:59 +0100
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Eric Biederman <ebiederm@xmission.com>,
        David Howells <dhowells@redhat.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-security-module@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] kexec: limit kexec_load syscall 
Date: Thu, 10 May 2018 21:36:45 -0400
Message-Id: <1526002608-27474-1-git-send-email-zohar@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

IMA-appraisal is mostly being used in the embedded or single purpose
closed system environments.  In these environments, both the Kconfig
options and the userspace tools can be modified appropriately to limit
syscalls.  For stock kernels, userspace applications need to continue to
work with older kernels as well as with newer kernels.

In this environment, the customer needs the ability to define a system
wide IMA runtime policy, such as requiring all kexec'ed images (or
firmware) to be signed, without being dependent on either the Kconfig
options or the userspace tools.

This patch set allows the customer to define a policy which requires
kexec'ed kernels to be signed.

Mimi Zohar (3):
  ima: based on the "secure_boot" policy limit syscalls
  kexec: call LSM hook for kexec_load syscall
  ima: based on policy require signed kexec kernel images

 include/linux/security.h            |  6 ++++++
 kernel/kexec.c                      | 11 +++++++++++
 security/integrity/ima/ima.h        |  1 +
 security/integrity/ima/ima_main.c   |  9 +++++++++
 security/integrity/ima/ima_policy.c | 27 ++++++++++++++++++++-------
 security/security.c                 |  6 ++++++
 6 files changed, 53 insertions(+), 7 deletions(-)

-- 
2.7.5

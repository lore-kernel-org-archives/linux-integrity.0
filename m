Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44316 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731662AbeGZAqJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 Jul 2018 20:46:09 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6PNTR7k134677
        for <linux-integrity@vger.kernel.org>; Wed, 25 Jul 2018 19:32:10 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2keyxep9d0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 25 Jul 2018 19:32:10 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <erichte@linux.vnet.ibm.com>;
        Thu, 26 Jul 2018 00:32:07 +0100
From: Eric Richter <erichte@linux.vnet.ibm.com>
To: linux-integrity <linux-integrity@vger.kernel.org>
Cc: linux-security-module <linux-security-module@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        Justin Forbes <jforbes@redhat.com>,
        Eric Richter <erichte@linux.vnet.ibm.com>
Subject: [PATCH 0/4] Add support for architecture-specific IMA policies
Date: Wed, 25 Jul 2018 18:31:56 -0500
Message-Id: <20180725233200.761-1-erichte@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

IMA can measure and appraise kernel images, but requires the appropriate
policy to be set to do so. This patch set adds the ability for different
architectures to define their own arch-specific default policies to be
loaded at run-time by implementing the arch_ima_get_policy() function.
This allows for the policy to be loaded based on the current system state,
such as secure boot state.

Included is an example patch that loads a set of IMA appraise rules
requiring the kexec kernel images to be measured and signed when EFI secure
boot is enabled. 

This set also contains a patch to IMA that adds a separate appraise func=
specifically for the kexec_load syscall. IMA cannot appraise images loaded
with kexec_load, and therefore automatically fails the signature check --
effectively disabling the syscall when the appropriate appraise rule is
set. This allows for the kexec_load syscall to be "disabled" via IMA
policy, but not conflict with the existing kexec_file_load signature
verification.

Eric Richter (2):
  ima: add support for KEXEC_ORIG_KERNEL_CHECK
  x86/ima: define arch_get_ima_policy() for x86

Nayna Jain (2):
  ima: add support for arch specific policies
  ima: add support for external setting of ima_appraise

 Documentation/ABI/testing/ima_policy  |   1 +
 arch/x86/kernel/Makefile              |   2 +
 arch/x86/kernel/ima_arch.c            |  27 +++++++++
 include/linux/ima.h                   |  13 +++++
 security/integrity/ima/Kconfig        |   8 +++
 security/integrity/ima/ima.h          |   7 +++
 security/integrity/ima/ima_appraise.c |  11 +++-
 security/integrity/ima/ima_main.c     |   3 +-
 security/integrity/ima/ima_policy.c   | 103 ++++++++++++++++++++++++++++++++++
 9 files changed, 172 insertions(+), 3 deletions(-)
 create mode 100644 arch/x86/kernel/ima_arch.c

-- 
2.14.4

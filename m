Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52822 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1032891AbeEXLK2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 24 May 2018 07:10:28 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4OAxjSS092570
        for <linux-integrity@vger.kernel.org>; Thu, 24 May 2018 07:10:27 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2j5tyckt4f-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 24 May 2018 07:10:27 -0400
Received: from localhost
        by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Thu, 24 May 2018 12:10:25 +0100
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org, Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v3 0/7] kexec/firmware: support system wide policy requiring signatures
Date: Thu, 24 May 2018 07:09:29 -0400
Message-Id: <1527160176-29269-1-git-send-email-zohar@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

IMA-appraisal is mostly being used in the embedded or single purpose
closed system environments.  In these environments, both the Kconfig
options and the userspace tools can be modified appropriately to limit
syscalls.  For stock kernels, userspace applications need to continue to
work with older kernels as well as with newer kernels.

In this environment, the customer needs the ability to define a system
wide IMA policy, such as requiring all kexec'ed images, firmware, kernel
modules to be signed, without being dependent on either the Kconfig
options or the userspace tools.[1]

This patch set allows the customer to define a policy which requires
the kexec'ed kernel images, firmware, and/or kernel modules to be
signed.

New to this patch set is the ability to configure a build time IMA policy,
which is automatically loaded at run time without needing to specify it
on the boot command line.  The build time policy rules persist after
loading a custom kernel policy.

[1] kexec-tools suupports the new syscall based on a flag (-s).

Changelog v3:
Based on James' feedback:
- Renamed security_kernel_read_file() to security_kernel_read_data().
- Cleaned up ima_read_data(), replacing if's with switch.

Changelog v2:
- combined "kexec: limit kexec_load syscall" and "firmware: kernel
signature verification" patch sets.
- add support for build time policy.
- defined generic security_kernel_read_blob() wrapper for
  security_kernel_read_file(). Suggested by Luis.
- removed the CONFIG_CFG80211_REQUIRE_SIGNED_REGDB ifdef.  If both REGDB
  and an IMA-appraisal policy require signed firmware, for now require
  both signatures.  Subsequent patches might change this.
- Still unclear if the pre-allocated firmware buffer can be accessed

Mimi Zohar (7):
  security: rename security_kernel_read_file() hook
  kexec: add call to LSM hook in original kexec_load syscall
  ima: based on policy require signed kexec kernel images
  firmware: add call to LSM hook before firmware sysfs fallback
  ima: based on policy require signed firmware (sysfs fallback)
  ima: add build time policy
  ima: based on policy prevent loading firmware (pre-allocated buffer)

 drivers/base/firmware_loader/fallback.c |  7 ++++
 fs/exec.c                               |  2 +-
 include/linux/fs.h                      |  1 +
 include/linux/ima.h                     |  4 +--
 include/linux/security.h                |  4 +--
 kernel/kexec.c                          |  8 +++++
 kernel/module.c                         |  2 +-
 security/integrity/ima/Kconfig          | 58 +++++++++++++++++++++++++++++++++
 security/integrity/ima/ima.h            |  1 +
 security/integrity/ima/ima_main.c       | 39 ++++++++++++++++++----
 security/integrity/ima/ima_policy.c     | 48 +++++++++++++++++++++++++--
 security/loadpin/loadpin.c              |  2 +-
 security/security.c                     |  6 ++--
 13 files changed, 162 insertions(+), 20 deletions(-)

-- 
2.7.5

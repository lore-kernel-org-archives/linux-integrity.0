Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32295 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S965500AbeE2SCQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 May 2018 14:02:16 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4THsYpl138195
        for <linux-integrity@vger.kernel.org>; Tue, 29 May 2018 14:02:15 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2j9b1c9wt7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 29 May 2018 14:02:14 -0400
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Tue, 29 May 2018 19:02:12 +0100
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
Subject: [PATCH v4 0/8] kexec/firmware: support system wide policy requiring signatures
Date: Tue, 29 May 2018 14:01:52 -0400
Message-Id: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Instead of adding the security_kernel_read_file LSM hook - or defining a
wrapper for security_kernel_read_file LSM hook and adding it, or
renaming the existing hook to security_kernel_read_data() and adding it
- in places where the kernel isn't reading a file, this version of the
patch set defines a new LSM hook named security_kernel_load_data().

The new LSM hook does not replace the existing security_kernel_read_file
LSM hook, which is still needed, but defines a new LSM hook allowing
LSMs and IMA-appraisal the opportunity to fail loading userspace
provided file/data.

The only difference between the two LSM hooks is the LSM hook name and a
file descriptor.  Whether this is cause enough for requiring a new LSM
hook, is left to the security community.

---

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

In addition, this patch set includes the ability to configure a build
time IMA policy, which is automatically loaded at run time without
needing to specify it on the boot command line and persists after
loading a custom kernel policy.

[1] kexec-tools suupports the new syscall based on a flag (-s).

Changelog v4:
- Define a new LSM hook named security_kernel_load_data().
- Define kernel_load_data_id enumeration.
- Replace the existing LSM hook in init_module syscall.

Changelog v3:
Based on James' feedback:
- Renamed security_kernel_read_file() to security_kernel_read_data().
- Defined new kernel_load_data_id enumeration.
- Cleaned up ima_read_data(), replacing if's with switch.

Changelog v2:
- combined "kexec: limit kexec_load syscall" and "firmware: kernel
signature verification" patch sets.
- add support for build time policy.
- defined generic security_kernel_read_blob() wrapper for
  security_kernel_read_file(). Suggested by Luis.

Mimi Zohar (8):
  security: define new LSM hook named security_kernel_load_data
  kexec: add call to LSM hook in original kexec_load syscall
  ima: based on policy require signed kexec kernel images
  firmware: add call to LSM hook before firmware sysfs fallback
  ima: based on policy require signed firmware (sysfs fallback)
  ima: add build time policy
  ima: based on policy prevent loading firmware (pre-allocated buffer)
  module: replace the existing LSM hook in init_module

 drivers/base/firmware_loader/fallback.c |  7 +++
 include/linux/ima.h                     |  7 +++
 include/linux/lsm_hooks.h               |  6 +++
 include/linux/security.h                | 33 ++++++++++++++
 kernel/kexec.c                          |  8 ++++
 kernel/module.c                         |  2 +-
 security/integrity/ima/Kconfig          | 58 ++++++++++++++++++++++++
 security/integrity/ima/ima.h            |  1 +
 security/integrity/ima/ima_main.c       | 79 ++++++++++++++++++++++++---------
 security/integrity/ima/ima_policy.c     | 48 ++++++++++++++++++--
 security/security.c                     | 10 +++++
 security/selinux/hooks.c                | 26 ++++++++---
 12 files changed, 255 insertions(+), 30 deletions(-)
-- 
2.7.5

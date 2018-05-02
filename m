Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39534 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751432AbeEBXIk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 2 May 2018 19:08:40 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w42N4sGg084296
        for <linux-integrity@vger.kernel.org>; Wed, 2 May 2018 19:08:39 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2hqkdky2hx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 02 May 2018 19:08:38 -0400
Received: from localhost
        by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <mkayaalp@linux.vnet.ibm.com>;
        Wed, 2 May 2018 17:08:38 -0600
From: Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>
To: David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Keyrings <keyrings@vger.kernel.org>
Cc: Linux Integrity <linux-integrity@vger.kernel.org>,
        Linux Security <linux-security-module@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        George Wilson <gcwilson@us.ibm.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>
Subject: [PATCH v6 0/4] Certificate insertion support for x86 bzImages
Date: Wed,  2 May 2018 19:08:07 -0400
Message-Id: <20180502230811.2751-1-mkayaalp@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

These patches add support for modifying the reserved space for extra
certificates in a compressed bzImage in x86. This allows separating the
system keyring certificate from the kernel build process. After the kernel
image is distributed, the insert-sys-cert script can be used to insert the
certificate for x86.

Changes:

v6:
* Removed libelf dependency (2/4)

v5:
* Added CRC fixing (3/4)

v4:
* Applied checkpatch.pl suggestions (2/4, 3/4)
* Cleaned up the commit messages (1/4, 2/4)
* Added the build file to .gitignore (1/4)

v3:
* Rewrote 1/4 to insert incompressible bytes are at build time. Previous
solution required changes to <arch>/boot/Makefile's for modifying the
vmlinux file after linking, and did not work well with cross compilation.
* Added 2/4 for ELF class-independent processing of vmlinux file, in case
the script was compiled for 64-bit and the kernel was compiled for 32-bit.
* Reordered 3/4, added x86 bzImage boot version (>=2.08) verification.

v2:
* Rebased arch/boot/x86/Makefile patch (removed in v3)

Mehmet Kayaalp (4):
  KEYS: Insert incompressible bytes to reserve space in bzImage
  KEYS: Add ELF class-independent certificate insertion support
  KEYS: Support for inserting a certificate into x86 bzImage
  KEYS: Print insert-sys-cert information to stdout instead of stderr

 certs/.gitignore            |   1 +
 certs/Makefile              |  21 +-
 certs/system_certificates.S |   2 +-
 scripts/insert-sys-cert.c   | 584 +++++++++++++++++++++++++++++-------
 4 files changed, 488 insertions(+), 120 deletions(-)

-- 
2.17.0

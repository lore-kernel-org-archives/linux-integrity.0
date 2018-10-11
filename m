Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33214 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727006AbeJLDCU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Oct 2018 23:02:20 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9BJWAZ8044079
        for <linux-integrity@vger.kernel.org>; Thu, 11 Oct 2018 15:33:40 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2n2a1hytmf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 11 Oct 2018 15:33:39 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 11 Oct 2018 20:33:37 +0100
Subject: [GIT PULL] linux-integrity patches for Linux 4.20
From: Mimi Zohar <zohar@linux.ibm.com>
To: James Morris <jmorris@namei.org>
Cc: linux-security-module <linux-security-module@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>
Date: Thu, 11 Oct 2018 15:33:21 -0400
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1539286401.11939.110.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi James,

Sorry for the delay.  This pull request contains a couple of bug
fixes, including one for a recent problem with calculating file hashes
on overlayfs, and some code cleanup.

Mimi

The following changes since commit
e6123c524064a571616ec978b1317f1696eff0ae:

  security: fix LSM description location (2018-10-09 12:18:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-
integrity.git next-integrity

for you to fetch changes up to
34bccd61b139dbb452421aebf480e7af5f7a12ed:

  MAINTAINERS: add Jarkko as maintainer for trusted keys (2018-10-11
12:10:16 -0400)

----------------------------------------------------------------
Eric Biggers (4):
      vfs: require i_size <= SIZE_MAX in kernel_read_file()
      security/integrity: constify some read-only data
      security/integrity: remove unnecessary 'init_keyring' variable
      ima: fix showing large 'violations' or
'runtime_measurements_count'

Goldwyn Rodrigues (1):
      ima: open a new file instance if no read permissions

Mimi Zohar (1):
      MAINTAINERS: add Jarkko as maintainer for trusted keys

 MAINTAINERS                           |  1 +
 fs/exec.c                             |  8 +++---
 security/integrity/digsig.c           | 10 ++-----
 security/integrity/evm/evm_crypto.c   |  4 +--
 security/integrity/ima/ima.h          |  2 +-
 security/integrity/ima/ima_api.c      |  3 +-
 security/integrity/ima/ima_crypto.c   | 54 ++++++++++++++++++++++--
-----------
 security/integrity/ima/ima_fs.c       |  9 +++---
 security/integrity/ima/ima_init.c     |  2 +-
 security/integrity/ima/ima_main.c     |  2 +-
 security/integrity/ima/ima_template.c | 11 +++----
 11 files changed, 59 insertions(+), 47 deletions(-)

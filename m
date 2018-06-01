Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38588 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753031AbeFATmI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 1 Jun 2018 15:42:08 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w51JcmXO111262
        for <linux-integrity@vger.kernel.org>; Fri, 1 Jun 2018 15:42:08 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jbcd609k2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 01 Jun 2018 15:42:07 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Fri, 1 Jun 2018 20:42:05 +0100
Subject: [GIT PULL]  linux-integrity fixes for Linux 4.18  (#2)
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: James Morris <jmorris@namei.org>
Cc: linux-security-module <linux-security-module@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>
Date: Fri, 01 Jun 2018 15:42:00 -0400
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1527882120.13403.15.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi James,

This pull request includes 6 patches.  Out of the 6 patches 4 are bug
fixes, which were posted after the linux-integrity 4.18 pull request
was sent.  The other 2 patches, which had been queued to be
upstreamed, are code clean up.  As of yesterday, all of these patches
are in linux-next, except for Dan Carpenter's bug fix from today.

thanks,

Mimi

The following changes since commit 6f0911a666d1f99ff72e7848ddee36af7bbce050:

  ima: fix updating the ima_appraise flag (2018-05-22 13:16:42 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity

for you to fetch changes up to b5c90a7526fe39164c2204f0404ce8f8ff21e522:

  EVM: unlock on error path in evm_read_xattrs() (2018-06-01 06:03:08 -0400)

----------------------------------------------------------------
Colin Ian King (2):
      EVM: fix memory leak of temporary buffer 'temp'
      EVM: Fix null dereference on xattr when xattr fails to allocate

Dan Carpenter (2):
      EVM: prevent array underflow in evm_write_xattrs()
      EVM: unlock on error path in evm_read_xattrs()

Petko Manolov (1):
      IMA: use list_splice_tail_init_rcu() instead of its open coded variant

Yisheng Xie (1):
      ima: use match_string() helper

 security/integrity/evm/evm_secfs.c  | 14 ++++++++++----
 security/integrity/ima/ima_main.c   | 11 ++++-------
 security/integrity/ima/ima_policy.c | 17 ++---------------
 3 files changed, 16 insertions(+), 26 deletions(-)

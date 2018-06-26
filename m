Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34912 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752519AbeFZRXh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 Jun 2018 13:23:37 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5QHIkcm023989
        for <linux-integrity@vger.kernel.org>; Tue, 26 Jun 2018 13:23:37 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2juqcpqq50-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 26 Jun 2018 13:23:37 -0400
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <stefanb@linux.vnet.ibm.com>;
        Tue, 26 Jun 2018 11:23:36 -0600
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com,
        zohar@linux.vnet.ibm.com
Cc: jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH v6 0/5] Have IMA find and use a tpm_chip until system shutdown
Date: Tue, 26 Jun 2018 13:23:26 -0400
Message-Id: <20180626172331.2505541-1-stefanb@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

This series of patches converts IMA's usage of the tpm_chip to find a TPM
chip initially and use it until the machine is shut down. To do this we need
to introduce a kref for the tpm_chip that IMA and all other users of a
tpm_chip hold onto until they don't need the TPM chip anymore.

    Stefan

v5->v6:
  - more verbose patch description in patch 2

v4->v5:
  - repost with fixed changelog and posted to linux-security-module

v3->v4:
  - followed Jason's suggestions:
    - extended docs of tpm_find_get_ops()
    - calling new function tpm_default_chip()
    - new patch 3 that uses tpm_default_chip() in tpm_find_get_ops()

v2->v3:
  - renaming tpm_chip_find_get() to tpm_get_ops()
  - IMA does not lock access to ima_tpm_chip anymore
  - IMA does not have a reboot notifier to release the chip anymore

v1->v2:
  - use the kref of the device via get_device()/put_device()



Stefan Berger (5):
  tpm: rename tpm_chip_find_get() to tpm_find_get_ops()
  tpm: Implement tpm_default_chip() to find a TPM chip
  tpm: Convert tpm_find_get_ops() to use tpm_default_chip()
  ima: Use tpm_default_chip() and call TPM functions with a tpm_chip
  ima: Get rid of ima_used_chip and use ima_tpm_chip != NULL instead

 drivers/char/tpm/tpm-chip.c         | 68 +++++++++++++++++++----------
 drivers/char/tpm/tpm-interface.c    | 14 +++---
 drivers/char/tpm/tpm.h              |  2 +-
 include/linux/tpm.h                 |  5 +++
 security/integrity/ima/ima.h        |  2 +-
 security/integrity/ima/ima_crypto.c |  4 +-
 security/integrity/ima/ima_init.c   | 16 +++----
 security/integrity/ima/ima_queue.c  |  4 +-
 8 files changed, 69 insertions(+), 46 deletions(-)

-- 
2.17.1

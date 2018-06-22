Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43808 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934270AbeFVQqV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 Jun 2018 12:46:21 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5MGi66m008716
        for <linux-integrity@vger.kernel.org>; Fri, 22 Jun 2018 12:46:20 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2js2yeweej-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 22 Jun 2018 12:46:20 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <stefanb@linux.vnet.ibm.com>;
        Fri, 22 Jun 2018 12:46:19 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com,
        zohar@linux.vnet.ibm.com
Cc: jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH v3 0/4] Have IMA find and use a tpm_chip until system shutdown
Date: Fri, 22 Jun 2018 12:46:09 -0400
Message-Id: <20180622164613.1609313-1-stefanb@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

This series of patches converts IMA's usage of the tpm_chip to find a TPM
chip initially and use it until the machine is shut down. To do this we need
to introduce a kref for the tpm_chip that IMA and all other users of a
tpm_chip hold onto until they don't need the TPM chip anymore.

    Stefan

v2->v3:
  - renaming tpm_chip_find_get() to tpm_get_ops()
  - IMA does not lock access to ima_tpm_chip anymore
  - IMA does not have a reboot notifier to release the chip anymore

v1->v2:
  - use the kref of the device via get_device()/put_device()

Stefan Berger (4):
  tpm: rename tpm_chip_find_get() to tpm_get_ops()
  tpm: Implement tpm_chip_find() for other subsystems to find a TPM chip
  ima: Use tpm_chip_find() and call TPM functions with a tpm_chip
  ima: Get rid of ima_used_chip and use ima_tpm_chip != NULL instead

 drivers/char/tpm/tpm-chip.c         | 31 +++++++++++++++++++++++++++++--
 drivers/char/tpm/tpm-interface.c    | 14 +++++++-------
 drivers/char/tpm/tpm.h              |  2 +-
 include/linux/tpm.h                 |  5 +++++
 security/integrity/ima/ima.h        |  2 +-
 security/integrity/ima/ima_crypto.c |  4 ++--
 security/integrity/ima/ima_init.c   | 16 +++++-----------
 security/integrity/ima/ima_queue.c  |  4 ++--
 8 files changed, 52 insertions(+), 26 deletions(-)

-- 
2.13.6

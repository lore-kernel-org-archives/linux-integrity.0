Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49350 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754335AbeFTQT6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Jun 2018 12:19:58 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5KGFwHm074549
        for <linux-integrity@vger.kernel.org>; Wed, 20 Jun 2018 12:19:58 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jqsvfhb0b-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 20 Jun 2018 12:19:57 -0400
Received: from localhost
        by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <stefanb@linux.vnet.ibm.com>;
        Wed, 20 Jun 2018 10:19:57 -0600
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com,
        zohar@linux.vnet.ibm.com
Cc: jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH 0/6] Have IMA find and use a tpm_chip until system shutdown
Date: Wed, 20 Jun 2018 12:19:42 -0400
Message-Id: <20180620161948.1464255-1-stefanb@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

This series of patches converts IMA's usage of the tpm_chip to find a TPM
chip initially and use it until the machine is shut down. To do this we need
to introduce a kref for the tpm_chip that IMA and all other users of a
tpm_chip hold onto until they don't need the TPM chip anymore.

    Stefan

Stefan Berger (6):
  tpm: Introduce a kref for the tpm_chip
  tpm: Get additional kref with every call to tpm_try_get_ops()
  tpm: Implement tpm_chip_find() for other subsystems to call
  ima: Implement ima_shutdown and register it as a reboot_notifier
  ima: Use tpm_chip_find() and access TPM functions using it
  ima: Get rid of ima_used_chip and use ima_tpm_chip != NULL instead

 drivers/char/tpm/tpm-chip.c         | 54 +++++++++++++++++++++++++++++++++----
 drivers/char/tpm/tpm.h              |  1 +
 include/linux/tpm.h                 |  9 +++++++
 security/integrity/ima/ima.h        |  4 ++-
 security/integrity/ima/ima_crypto.c | 14 +++++++---
 security/integrity/ima/ima_init.c   | 36 ++++++++++++++++++-------
 security/integrity/ima/ima_queue.c  |  9 ++++---
 7 files changed, 105 insertions(+), 22 deletions(-)

-- 
2.13.6

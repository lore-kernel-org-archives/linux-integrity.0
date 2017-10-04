Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58530 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751114AbdJDK3p (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 Oct 2017 06:29:45 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v94ATcIB142131
        for <linux-integrity@vger.kernel.org>; Wed, 4 Oct 2017 06:29:45 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2dcvyxuc88-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 04 Oct 2017 06:29:45 -0400
Received: from localhost
        by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <nayna@linux.vnet.ibm.com>;
        Wed, 4 Oct 2017 20:29:42 +1000
From: Nayna Jain <nayna@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.vnet.ibm.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterhuewe@gmx.de,
        jarkko.sakkinen@linux.intel.com, tpmdd@selhorst.net,
        jgunthorpe@obsidianresearch.com, patrickc@us.ibm.com,
        Nayna Jain <nayna@linux.vnet.ibm.com>
Subject: [PATCH v3 0/4] additional TPM performance improvements 
Date: Wed,  4 Oct 2017 06:29:19 -0400
Message-Id: <20171004102924.12355-1-nayna@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

After further discussions with the TCG Device Driver working group (ddwg),
the following changes were made: 

* Check for burstcount at least once to confirm the TPM is ready to accept
the data. Similarly, query for the TPM Expect status as sanity check at
the end.

* Make the sleep for status check in the loop less than 5msec.

* Make the sleep in the loop while querying for burstcount less than
5msec.

Below is the list of patches along with the performance improvements
seen with a TPM 1.2 with an 8 byte burstcount for 1000 extends: 

Patch                                        |Improvement(time in sec)

tpm: ignore burstcount to improve tpm_tis    | ~41 - ~14
send() performance.

tpm: reduce polling delay in tpm_tis         | ~14 - ~10
wait_for_tpm_stat()

tpm: reduce tpm_msleep() time in             | ~10 - ~9
get_burstcount()

tpm: modify tpm_msleep() function to have    | ~9 - ~8
max range

Changelog v3:

* Include Jarkko's feedback to move wait_for_tpm_stat() from
tpm-interface.c to respective driver files tpm_tis_core.c and
xen-tpmfront.c.
* Remove use of module parameter ignore_burst_count and is
now alwaysed ignored in tpm tis send() operation.
* Reduce sleep() time during polling in wait_for_tpm_stat() from
5msec to 1msec for both recv() and send() operation. Version
2 of the patches  had it only for send() operation.

Changelog v2:

* Add module parameter to handle ignoring of burst count during
tpm tis send() operation.
* Add improvements over sleep time to reduce delays.

Nayna Jain (5):
  tpm: move wait_for_tpm_stat() to respective driver files
  tpm: ignore burstcount to improve tpm_tis send() performance
  tpm: reduce polling delay in tpm_tis wait_for_tpm_stat()
  tpm: reduce tpm_msleep() time in get_burstcount()
  tpm: use tpm_msleep() value as max delay

 drivers/char/tpm/tpm-interface.c |  60 ----------------------
 drivers/char/tpm/tpm.h           |   6 +--
 drivers/char/tpm/tpm_tis_core.c  | 106 +++++++++++++++++++++++++++++----------
 drivers/char/tpm/xen-tpmfront.c  |  60 ++++++++++++++++++++++
 4 files changed, 141 insertions(+), 91 deletions(-)

-- 
2.13.3

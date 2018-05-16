Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43782 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751402AbeEPFvq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 16 May 2018 01:51:46 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4G5nhBJ147004
        for <linux-integrity@vger.kernel.org>; Wed, 16 May 2018 01:51:45 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2j0ep08ce8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 16 May 2018 01:51:45 -0400
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <nayna@linux.vnet.ibm.com>;
        Wed, 16 May 2018 06:51:43 +0100
From: Nayna Jain <nayna@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.vnet.ibm.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterhuewe@gmx.de,
        jarkko.sakkinen@linux.intel.com, tpmdd@selhorst.net,
        jgunthorpe@obsidianresearch.com, patrickc@us.ibm.com,
        Nayna Jain <nayna@linux.vnet.ibm.com>
Subject: [PATCH v4 0/2] tpm: improving granularity in poll sleep times
Date: Wed, 16 May 2018 01:51:23 -0400
Message-Id: <20180516055125.5685-1-nayna@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

The existing TPM polling code sleeps in each loop iteration for time in
msecs ranging from 1 msecs to 5 msecs. However, many of the TPM commands
complete much faster, resulting in unnecessary delays.

This set of patches identifies such iterations and optimizes the sleep
time. The first patch replaces TPM_POLL_SLEEP with TPM_TIMEOUT_POLL and
moves it from tpm_tis_core.c to tpm.h as an enum with value 1 msecs. The
second patch further reduces the TPM poll sleep time in get_burstcount()
and wait_for_tpm_stat() in tpm_tis_core.c by calling usleep_range()
directly.

The change is only in the polling time, and the maximum timeout is still
maintained the same. Thus, it should not affect the overall existing
behavior.

Changelog:

v4:
tpm: reduce poll sleep time in tpm_transmit()
* added Reviewed-by, Tested-by and Ack-by

tpm: reduce polling time to usecs for even finer granularity
* included Jarkko's feedback
* added Ack-by

v3:

tpm: reduce poll sleep time in tpm_transmit()
* added testing platform information
* updated patch description for more clarity on reasoning

tpm: reduce polling time to usecs for even finer granularity
* added testing platform information
* added Jarkko's and Mimi's Reviewed-by

v2:

tpm: reduce poll sleep time in tpm_transmit()
* merged previously defined two patches into this.
* updated patch description as per Jarkko's feedback

tpm: reduce polling time to usecs for even finer granularity
* directly use usleep_range with finer granularity less than 1msec

Nayna Jain (2):
  tpm: reduce poll sleep time in tpm_transmit()
  tpm: reduce polling time to usecs for even finer granularity

 drivers/char/tpm/tpm-interface.c |  2 +-
 drivers/char/tpm/tpm.h           |  5 ++++-
 drivers/char/tpm/tpm_tis_core.c  | 11 +++--------
 3 files changed, 8 insertions(+), 10 deletions(-)

-- 
2.13.3

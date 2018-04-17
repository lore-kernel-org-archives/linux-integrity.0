Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49748 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753457AbeDQNM7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 Apr 2018 09:12:59 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w3HD9Tb3005203
        for <linux-integrity@vger.kernel.org>; Tue, 17 Apr 2018 09:12:58 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2hdevbqjnm-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 17 Apr 2018 09:12:55 -0400
Received: from localhost
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <nayna@linux.vnet.ibm.com>;
        Tue, 17 Apr 2018 14:12:52 +0100
From: Nayna Jain <nayna@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.vnet.ibm.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterhuewe@gmx.de,
        jarkko.sakkinen@linux.intel.com, tpmdd@selhorst.net,
        jgunthorpe@obsidianresearch.com, patrickc@us.ibm.com,
        Nayna Jain <nayna@linux.vnet.ibm.com>
Subject: [PATCH v2 0/2] tpm: improving granularity in poll sleep times 
Date: Tue, 17 Apr 2018 09:12:44 -0400
Message-Id: <20180417131246.434-1-nayna@linux.vnet.ibm.com>
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

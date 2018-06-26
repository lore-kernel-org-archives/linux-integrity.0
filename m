Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57132 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753281AbeFZTar (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 Jun 2018 15:30:47 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5QJUNm5047954
        for <linux-integrity@vger.kernel.org>; Tue, 26 Jun 2018 15:30:47 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jurm47tyj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 26 Jun 2018 15:30:46 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <stefanb@linux.vnet.ibm.com>;
        Tue, 26 Jun 2018 15:30:45 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com,
        zohar@linux.vnet.ibm.com, jejb@linux.vnet.ibm.com
Cc: jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, dhowells@redhat.com,
        keyrings@vger.kernel.org,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH 0/2] Convert trusted keys to find and use the default TPM chip
Date: Tue, 26 Jun 2018 15:30:38 -0400
Message-Id: <20180626193040.2509798-1-stefanb@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

The following patches build on top of the series of patches that
convert IMA to find and use the system's default TPM chip.

I have done some successful testing with trusted keys using publicly
available examples.

   Stefan

Stefan Berger (2):
  tpm: Implement public tpm_put_chip() to release reference to chip
  KEYS: trusted: Find tpm_chip and use it until module shutdown

 drivers/char/tpm/tpm-chip.c | 10 +++++++++
 include/linux/tpm.h         |  4 ++++
 security/keys/trusted.c     | 41 +++++++++++++++++++++++++------------
 3 files changed, 42 insertions(+), 13 deletions(-)

-- 
2.17.1

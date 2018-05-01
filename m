Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35552 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752182AbeEANsh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 May 2018 09:48:37 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w41Dl7wO045002
        for <linux-integrity@vger.kernel.org>; Tue, 1 May 2018 09:48:37 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2hpsdyg1ws-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 01 May 2018 09:48:36 -0400
Received: from localhost
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Tue, 1 May 2018 14:48:34 +0100
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Jones <pjones@redhat.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH 0/6] firmware: kernel signature verification 
Date: Tue,  1 May 2018 09:48:17 -0400
Message-Id: <1525182503-13849-1-git-send-email-zohar@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Allow LSMs and IMA to differentiate between different methods of
firmware loading (eg. direct loading, sysfs fallback) and to
differentiate/coordinate between signature verification methods (eg.
regdb, IMA-appraisal).

In addition, the last two patches address the pre-allocated buffer.  The
first of these patches doesn't differentiate between reading the
firmware first into kernel memory and verifying the kernel signature,
versus reading the firmware directly into a pre-allocated buffer.

The last patch, which is posted as an RFC, questions whether the device
can access the pre-allocated buffer before the kernel signature has been
verified.

Mimi Zohar (6):
  firmware: permit LSMs and IMA to fail firmware sysfs fallback loading
  ima: prevent sysfs fallback firmware loading
  firmware: differentiate between signed regulatory.db and other
    firmware
  ima: coordinate with signed regulatory.db
  ima: verify kernel firmware signatures when using a preallocated
    buffer
  ima: prevent loading firmware into a pre-allocated buffer

 drivers/base/firmware_loader/fallback.c |  7 +++++++
 drivers/base/firmware_loader/main.c     |  5 +++++
 include/linux/fs.h                      |  2 ++
 security/integrity/ima/ima_main.c       | 29 +++++++++++++++++++++++++++--
 4 files changed, 41 insertions(+), 2 deletions(-)

-- 
2.7.5

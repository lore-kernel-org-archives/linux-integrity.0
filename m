Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52418 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751549AbeCNUUi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Mar 2018 16:20:38 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2EKJoZG017928
        for <linux-integrity@vger.kernel.org>; Wed, 14 Mar 2018 16:20:38 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2gqaa38w7b-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 14 Mar 2018 16:20:37 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <bauerman@linux.vnet.ibm.com>;
        Wed, 14 Mar 2018 16:20:36 -0400
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: [PATCH 0/4] Code improvements in integrity and IMA
Date: Wed, 14 Mar 2018 17:20:16 -0300
Message-Id: <20180314202020.3794-1-bauerman@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hello,

These patches come from the "appended signatures support for IMA appraisal"
series. They are code improvements and cleanups and I decided to submit
them separately for a couple of reasons:

1. they stand on their own and could be included in v4.17;

2. this will simplify the original patch series a bit, by having it contain
   only the patches actually necessary to implement the feature.

These are the changes made to them since v5 of the modsig series:

- Patch "integrity: Remove unused macro IMA_ACTION_RULE_FLAGS"
  - New patch.

- Patch "ima: Improvements in ima_appraise_measurement()"
  - Moved is_ima_sig() to its own patch (not in this series).

Mimi Zohar (1):
  ima: Improvements in ima_appraise_measurement()

Thiago Jung Bauermann (3):
  integrity: Remove unused macro IMA_ACTION_RULE_FLAGS
  ima: Simplify ima_eventsig_init()
  integrity: Introduce struct evm_xattr

 security/integrity/evm/evm_crypto.c       |  4 ++--
 security/integrity/evm/evm_main.c         | 10 ++++----
 security/integrity/ima/ima_appraise.c     | 40 ++++++++++++++++++-------------
 security/integrity/ima/ima_template_lib.c | 11 +++------
 security/integrity/integrity.h            |  6 ++++-
 5 files changed, 39 insertions(+), 32 deletions(-)

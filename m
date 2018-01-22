Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57528 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750945AbeAVOyS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 Jan 2018 09:54:18 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w0MEnpAn131306
        for <linux-integrity@vger.kernel.org>; Mon, 22 Jan 2018 09:54:18 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2fngy5ukus-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 22 Jan 2018 09:54:17 -0500
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 22 Jan 2018 14:54:16 -0000
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        "Bruno E . O . Meneguele" <brdeoliv@redhat.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH 00/10] ima-evm-utils
Date: Mon, 22 Jan 2018 09:53:55 -0500
Message-Id: <1516632845-7087-1-git-send-email-zohar@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Before upgrading to the new OpenSSL 1.1 API, let's clean up the code
a bit and add some missing functionality:
- option to specify the pcr sysfs location
- verify the measurement list using multiple keys
- verify the measurement list using multiple pcrs
- verify a measurement signature against the measurement list digest
- for completeness, extend "ima_verify" to verify the local security.ima hash

Mimi

Mimi Zohar (10):
  ima-evm-utils: fix "ima_measurement" template fields length
  ima-evm-utils: revert the change to use printf instead of log_info()
  ima-evm-utils: fix spelling error
  ima-evm-utils: remove the unnecessary display of the keyid
  ima-evm-utils: support verifying the measurement list using multiple
    keys
  ima-evm-utils: indicate measurement list signature verification
    failure
  ima-evm-utils: add support for specifying the pcr file location
  ima-evm-utils: verify the measurement list signature based on the list
    digest
  ima-evm-utils: verify IMA file hashes stored as xattrs
  ima-evm-utils: add support for validating multiple pcrs

 README          |   2 +-
 src/evmctl.c    |  94 ++++++++++++++++++++++++++++-----------
 src/imaevm.h    |   7 ++-
 src/libimaevm.c | 135 +++++++++++++++++++++++++++++++++++++++++++++++++++-----
 4 files changed, 199 insertions(+), 39 deletions(-)

-- 
2.7.4

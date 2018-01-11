Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:42613 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751923AbeAKU2c (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Jan 2018 15:28:32 -0500
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@huawei.com>,
        linux-integrity@vger.kernel.org
Subject: [RFC PATCH 0/2] IMA: Rewrite tests into new API + fixes
Date: Thu, 11 Jan 2018 21:28:19 +0100
Message-Id: <20180111202821.31639-1-pvorel@suse.cz>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi,

I rewrote IMA tests to use new API + add small fixes.
I haven't tested ima_tpm.sh as I have no TPM :-(.

Comments are welcomed.

Kind regards,
Petr

Petr Vorel (2):
  security/ima: Rewrite tests into new API + fixes
  security/ima: Run measurements after policy

 runtest/ima                                        |   8 +-
 .../integrity/ima/tests/ima_measurements.sh        | 182 +++++++-----------
 .../security/integrity/ima/tests/ima_policy.sh     | 145 +++++++-------
 .../security/integrity/ima/tests/ima_setup.sh      | 109 +++++------
 .../kernel/security/integrity/ima/tests/ima_tpm.sh | 129 ++++++-------
 .../security/integrity/ima/tests/ima_violations.sh | 214 ++++++++++-----------
 6 files changed, 337 insertions(+), 450 deletions(-)
 mode change 100755 => 100644 testcases/kernel/security/integrity/ima/tests/ima_setup.sh

-- 
2.15.1

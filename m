Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:38391 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752778AbeDSTzT (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Apr 2018 15:55:19 -0400
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Subject: [RFC PATCH v3 00/10] Rewrite tests into new API + fixes
Date: Thu, 19 Apr 2018 21:54:53 +0200
Message-Id: <20180419195503.7194-1-pvorel@suse.cz>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi,

changes v2->v3:
* Fixed some of errors caused by test order.

* ima_boot_aggregate
  - max event size is now 1MB according to spec

* ima_mmap
  - reduce sleep + log it
  - rewritten into new API

* ima_measurements.sh
  - don't require iversion for kernel >= 4.16
  - avoid using tmpfs

* ima_policy.sh
  - improved detection of policy writability
  - merge test2 and test3

* ima_violations.sh
  - avoid using tmpfs
  - improved grepping logs (no sleep is needed)

* ima_tpm.sh
  - Improve error messages

TODO:
* fix problems with violations tests (see patch 02/10).
* detect whether policy must be signed (currently tests assume the
policy does not need to be signed):
https://lists.linux.it/pipermail/ltp/2018-April/007702.html
http://lists.linux.it/pipermail/ltp/2018-January/006970.html

Comments and patches are welcome.

Kind regards,
Petr

Petr Vorel (10):
  security/ima: Rewrite tests into new API + fixes
  security/ima: Change order of tests
  ima/ima_policy.sh: Improve check of policy writability
  ima/ima_policy.sh: Load whole policy with cat
  ima/ima_boot_aggregate: Increase MAX_EVENT_SIZE to 1MB
  ima/tpm.sh: Use evmctl + other fixes
  ima/ima_mmap: Reduce sleep + log it
  ima/{ima_measurements,ima_violations}.sh: Avoid running on tmpfs
  ima: CRYPTO_LIBS are needed only for ima_boot_aggregate
  ima/ima_mmap: Rewrite to new library

 runtest/ima                                        |   8 +-
 testcases/kernel/security/integrity/.gitignore     |   1 -
 .../kernel/security/integrity/ima/src/Makefile     |   2 +-
 .../integrity/ima/src/ima_boot_aggregate.c         |  16 +-
 .../security/integrity/ima/src/ima_measure.c       | 219 ------------------
 .../kernel/security/integrity/ima/src/ima_mmap.c   |  82 +++----
 .../integrity/ima/tests/ima_measurements.sh        | 247 +++++++++++----------
 .../security/integrity/ima/tests/ima_policy.sh     | 169 ++++++--------
 .../security/integrity/ima/tests/ima_setup.sh      | 141 ++++++------
 .../kernel/security/integrity/ima/tests/ima_tpm.sh | 165 ++++++--------
 .../security/integrity/ima/tests/ima_violations.sh | 228 ++++++++++---------
 11 files changed, 530 insertions(+), 748 deletions(-)
 delete mode 100644 testcases/kernel/security/integrity/ima/src/ima_measure.c
 mode change 100755 => 100644 testcases/kernel/security/integrity/ima/tests/ima_setup.sh

-- 
2.16.3

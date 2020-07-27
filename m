Return-Path: <SRS0=p1mE=BG=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769D0C433E0
	for <linux-integrity@archiver.kernel.org>; Mon, 27 Jul 2020 22:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F3A920729
	for <linux-integrity@archiver.kernel.org>; Mon, 27 Jul 2020 22:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbgG0Wax (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 27 Jul 2020 18:30:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:39962 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbgG0Waw (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Jul 2020 18:30:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0CEBAAD76;
        Mon, 27 Jul 2020 22:31:02 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Petr Vorel <pvorel@suse.cz>,
        Lachlan Sneff <t-josne@linux.microsoft.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        balajib@linux.microsoft.com, linux-integrity@vger.kernel.org
Subject: [PATCH v5 0/4] IMA: kexec cmdline measurement
Date:   Tue, 28 Jul 2020 00:30:37 +0200
Message-Id: <20200727223041.13110-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi all,

sending hopefully the last version. In the end I did quite few changes,
thus sending patchset instead of merging without review.

Tested on various setup:
ima_kexec 1 TCONF: IMA policy does not specify '^measure.*func=KEXEC_CMDLINE'
---
ima_kexec 1 TPASS: kexec -s -l /boot/vmlinuz-5.3.13-1-default --append=foo passed as expected
ima_kexec 1 TPASS: kexec cmdline for --append=foo was measured correctly
ima_kexec 2 TPASS: kexec -s -l /boot/vmlinuz-5.3.13-1-default --command-line=bar passed as expected
ima_kexec 2 TPASS: kexec cmdline for --command-line=bar was measured correctly
---
ima_kexec 1 TBROK: kexec failed: kexec_file_load failed: Required key not available
---
ima_kexec 1 TWARN: policy not readable, it might not contain required measure func=KEXEC_CMDLINE
ima_kexec 1 TBROK: unable to find a correct entry for --reuse-cmdline

Kind regards,
Petr

Lachlan Sneff (1):
  IMA: Add test for kexec cmdline measurement

Petr Vorel (3):
  IMA: Rename helper to require_ima_policy_cmdline
  IMA: Add policy related helpers
  IMA/ima_keys.sh: Fix policy readability check

 runtest/ima                                   |   1 +
 .../kernel/security/integrity/ima/README.md   |   8 ++
 .../integrity/ima/datafiles/kexec.policy      |   1 +
 .../integrity/ima/tests/evm_overlay.sh        |   2 +-
 .../security/integrity/ima/tests/ima_kexec.sh | 111 ++++++++++++++++++
 .../security/integrity/ima/tests/ima_keys.sh  |  10 +-
 .../integrity/ima/tests/ima_measurements.sh   |   2 +-
 .../security/integrity/ima/tests/ima_setup.sh |  41 ++++++-
 8 files changed, 164 insertions(+), 12 deletions(-)
 create mode 100644 testcases/kernel/security/integrity/ima/datafiles/kexec.policy
 create mode 100755 testcases/kernel/security/integrity/ima/tests/ima_kexec.sh

-- 
2.27.0


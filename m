Return-Path: <SRS0=mqgK=SH=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553F8C282CE
	for <linux-integrity@archiver.kernel.org>; Fri,  5 Apr 2019 16:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D92620989
	for <linux-integrity@archiver.kernel.org>; Fri,  5 Apr 2019 16:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfDEQwg (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 5 Apr 2019 12:52:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:52538 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730587AbfDEQwg (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Apr 2019 12:52:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 64FFBB03C;
        Fri,  5 Apr 2019 16:52:35 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Ignaz Forster <iforster@suse.de>, Fabian Vogt <FVogt@suse.com>,
        Marcus Meissner <meissner@suse.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v2 0/3] LTP reproducer on broken IMA on overlayfs
Date:   Fri,  5 Apr 2019 18:52:22 +0200
Message-Id: <20190405165225.27216-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

this is a second version of patch demonstrating a bug on overlayfs when
combining IMA with EVM. There is ongoing work made by Ignaz Forster and
Fabian Vogt [1] [2], IMA only behavior was already fixed [3].

Main patch is the last one (previous are just a cleanup and not changed).

Kind regards,
Petr

[1] https://www.spinics.net/lists/linux-integrity/msg05926.html
[2] https://www.spinics.net/lists/linux-integrity/msg03593.html
[3] https://patchwork.kernel.org/patch/10776231/

Petr Vorel (3):
  ima: Call test's cleanup inside ima_setup.sh cleanup
  shell: Add $TST_DEVICE as default parameter to tst_umount
  ima: Add overlay test

 doc/test-writing-guidelines.txt               |  4 +-
 runtest/ima                                   |  1 +
 testcases/commands/df/df01.sh                 |  7 +-
 testcases/commands/mkfs/mkfs01.sh             |  2 +-
 .../integrity/ima/tests/evm_overlay.sh        | 86 +++++++++++++++++++
 .../security/integrity/ima/tests/ima_setup.sh | 12 ++-
 .../integrity/ima/tests/ima_violations.sh     |  2 -
 testcases/lib/tst_test.sh                     |  2 +-
 8 files changed, 100 insertions(+), 16 deletions(-)
 create mode 100755 testcases/kernel/security/integrity/ima/tests/evm_overlay.sh

-- 
2.21.0


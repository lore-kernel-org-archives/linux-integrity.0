Return-Path: <SRS0=4VHM=R6=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CDAC43381
	for <linux-integrity@archiver.kernel.org>; Wed, 27 Mar 2019 16:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 494A7206C0
	for <linux-integrity@archiver.kernel.org>; Wed, 27 Mar 2019 16:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfC0QQw (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 27 Mar 2019 12:16:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:46386 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726126AbfC0QQw (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 Mar 2019 12:16:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8531AAC7F;
        Wed, 27 Mar 2019 16:16:51 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Ignaz Forster <iforster@suse.de>, Fabian Vogt <FVogt@suse.com>,
        Weihua Du <WHDu@suse.com>, linux-integrity@vger.kernel.org
Subject: [PATCH 0/3] LTP reproducer on broken IMA on overlayfs
Date:   Wed, 27 Mar 2019 17:16:35 +0100
Message-Id: <20190327161638.7407-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

based on reproducer made by Ignaz Forster <iforster@suse.de>
used for his not upstreamed patchset [1] and previous report [2].

Mimi: does this test make sense to you?

[1] https://www.spinics.net/lists/linux-integrity/msg05926.html
[2] https://www.spinics.net/lists/linux-integrity/msg03593.html

Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Ignaz Forster <iforster@suse.de>
Cc: Fabian Vogt <FVogt@suse.com>
Cc: Weihua Du <WHDu@suse.com>
Cc: linux-integrity@vger.kernel.org

Petr Vorel (3):
  ima: Call test's cleanup inside ima_setup.sh cleanup
  shell: Add $TST_DEVICE as default parameter to tst_umount
  ima: Add overlay test

 doc/test-writing-guidelines.txt               |  4 +-
 runtest/ima                                   |  1 +
 testcases/commands/df/df01.sh                 |  7 +-
 testcases/commands/mkfs/mkfs01.sh             |  2 +-
 .../integrity/ima/tests/ima_overlay.sh        | 65 +++++++++++++++++++
 .../security/integrity/ima/tests/ima_setup.sh | 12 ++--
 .../integrity/ima/tests/ima_violations.sh     |  2 -
 testcases/lib/tst_test.sh                     |  2 +-
 8 files changed, 79 insertions(+), 16 deletions(-)
 create mode 100755 testcases/kernel/security/integrity/ima/tests/ima_overlay.sh

-- 
2.21.0


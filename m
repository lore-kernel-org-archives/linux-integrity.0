Return-Path: <SRS0=a4os=QS=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C6DAC169C4
	for <linux-integrity@archiver.kernel.org>; Mon, 11 Feb 2019 10:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6043C20663
	for <linux-integrity@archiver.kernel.org>; Mon, 11 Feb 2019 10:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbfBKK6w (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 11 Feb 2019 05:58:52 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:38566 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbfBKK6v (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 11 Feb 2019 05:58:51 -0500
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gt9IS-0002bd-DH; Mon, 11 Feb 2019 11:58:44 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-integrity@vger.kernel.org
Cc:     tglx@linutronix.de, Jason Gunthorpe <jgg@ziepe.ca>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Philip Tricca <philip.b.tricca@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH] tpm: remove tpm_dev_wq_lock
Date:   Mon, 11 Feb 2019 11:58:35 +0100
Message-Id: <20190211105835.16851-1-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Added in commit

  9e1b74a63f776 ("tpm: add support for nonblocking operation")

but never actually used it.

Cc: Philip Tricca <philip.b.tricca@intel.com>
Cc: Tadeusz Struk <tadeusz.struk@intel.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/char/tpm/tpm-dev-common.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
index 5eecad233ea1d..eca96e8c669c9 100644
--- a/drivers/char/tpm/tpm-dev-common.c
+++ b/drivers/char/tpm/tpm-dev-common.c
@@ -25,7 +25,6 @@
 #include "tpm-dev.h"
 
 static struct workqueue_struct *tpm_dev_wq;
-static DEFINE_MUTEX(tpm_dev_wq_lock);
 
 static void tpm_async_work(struct work_struct *work)
 {
-- 
2.20.1


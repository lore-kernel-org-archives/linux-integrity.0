Return-Path: <SRS0=nt+s=DG=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C67C47420
	for <linux-integrity@archiver.kernel.org>; Tue, 29 Sep 2020 16:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A98B20936
	for <linux-integrity@archiver.kernel.org>; Tue, 29 Sep 2020 16:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729434AbgI2Qu1 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 29 Sep 2020 12:50:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:43322 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728385AbgI2Qu1 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Sep 2020 12:50:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 75EB0ADDF;
        Tue, 29 Sep 2020 16:50:26 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Petr Vorel <pvorel@suse.cz>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v3 0/4] TPM 2.0 fixes in IMA tests
Date:   Tue, 29 Sep 2020 18:50:17 +0200
Message-Id: <20200929165021.11731-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

few more fixes, mostly touching older kernels or evmctl versions.
Changes in 3rd and 4th commit.

Kind regards,
Petr

Petr Vorel (4):
  IMA: Move get_algorithm_digest(), set_digest_index() to ima_setup.sh
  IMA: Rewrite ima_boot_aggregate.c to new API
  ima_tpm.sh: Fix calculating boot aggregate
  ima_tpm.sh: Fix calculating PCR aggregate

 .../integrity/ima/src/ima_boot_aggregate.c    | 113 ++++----
 .../integrity/ima/tests/ima_measurements.sh   |  62 +---
 .../security/integrity/ima/tests/ima_setup.sh |  70 +++++
 .../security/integrity/ima/tests/ima_tpm.sh   | 265 ++++++++++++++----
 4 files changed, 341 insertions(+), 169 deletions(-)

-- 
2.28.0


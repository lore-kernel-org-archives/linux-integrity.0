Return-Path: <SRS0=ErRK=VE=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5C0C0650E
	for <linux-integrity@archiver.kernel.org>; Sun,  7 Jul 2019 23:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90D7820663
	for <linux-integrity@archiver.kernel.org>; Sun,  7 Jul 2019 23:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbfGGXsz (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sun, 7 Jul 2019 19:48:55 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:42936 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbfGGXsz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 7 Jul 2019 19:48:55 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 4673772CC6C;
        Mon,  8 Jul 2019 02:48:54 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id 080454A4AE8;
        Mon,  8 Jul 2019 02:48:54 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v1 0/5] ima-evm-utils: Assorted fixes and improvements
Date:   Mon,  8 Jul 2019 02:48:32 +0300
Message-Id: <20190707234837.4866-1-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

There is small fixes and improvements to ima-evm-utils.
Tested on x86_64.

Vitaly Chikunov (5):
  ima-evm-utils: Fix EVP_MD_CTX leak in ima_calc_hash
  ima-evm-utils: Fix memory leak in init_public_keys
  ima-evm-utils: Preload public keys for ima_verify
  ima-evm-utils: Allow multiple files in ima_verify
  ima-evm-utils: Fix clang warning about possible unaligned pointer for
    hdr->keyid

 src/evmctl.c    | 11 ++++++++---
 src/libimaevm.c | 38 ++++++++++++++++++++++++++------------
 2 files changed, 34 insertions(+), 15 deletions(-)

-- 
2.11.0


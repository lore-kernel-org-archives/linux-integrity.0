Return-Path: <SRS0=cYyd=R2=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87FBEC43381
	for <linux-integrity@archiver.kernel.org>; Sat, 23 Mar 2019 01:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B70A218E2
	for <linux-integrity@archiver.kernel.org>; Sat, 23 Mar 2019 01:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbfCWBmG (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 22 Mar 2019 21:42:06 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:58102 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbfCWBmG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 Mar 2019 21:42:06 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id C24BE72CCAC;
        Sat, 23 Mar 2019 04:42:04 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id 9CB004A4A16;
        Sat, 23 Mar 2019 04:42:04 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH 0/2] ima-evm-utils: rebase of digest algo resolving
Date:   Sat, 23 Mar 2019 04:41:50 +0300
Message-Id: <20190323014152.14701-1-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This is rebase of the ima-evm-utils commits:

  0267fa1 ima-evm-utils: Try to load digest by its alias
  942d9f9 ima-evm-utils: Extract digest algorithms from hash_info.h

and should be applied over 07d799c ("ima-evm-utils: Preload OpenSSL
engine via '--engine' option").

Changes:

* ima-evm-utils: Extract digest algorithms from hash_info.h
- algocmp is removed.
- `hash_info.h` is parsed better to match algo names in the Kernel,
  thus simple strcmp could be used.

* ima-evm-utils: try to load digest by its alias
- digest name lookup is simplified by removing get_digestbyname
  and strmatch helpers.
- Kernel and OpenSSL algo names arrays are introduced to support
  alternative algo names for older OpenSLL.


*** BLURB HERE ***

Vitaly Chikunov (2):
  ima-evm-utils: Extract digest algorithms from hash_info.h
  ima-evm-utils: try to load digest by its alias

 configure.ac      |  6 ++++++
 src/Makefile.am   |  6 ++++++
 src/hash_info.gen | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 src/libimaevm.c   | 35 ++++++++++++++++++++++++++++++++++-
 4 files changed, 95 insertions(+), 1 deletion(-)
 create mode 100755 src/hash_info.gen

-- 
2.11.0


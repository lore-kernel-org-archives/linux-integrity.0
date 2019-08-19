Return-Path: <SRS0=yGPs=WP=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D7B4C3A5A0
	for <linux-integrity@archiver.kernel.org>; Mon, 19 Aug 2019 20:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09D87206BB
	for <linux-integrity@archiver.kernel.org>; Mon, 19 Aug 2019 20:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728136AbfHSUZN (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 19 Aug 2019 16:25:13 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:45498 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728018AbfHSUZN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Aug 2019 16:25:13 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id F3CE172CCD5;
        Mon, 19 Aug 2019 23:25:11 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id C50BF4A4AF6;
        Mon, 19 Aug 2019 23:25:11 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH] ima-evm-utils: Enable large-file support
Date:   Mon, 19 Aug 2019 23:25:07 +0300
Message-Id: <20190819202507.27735-1-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Some architectures require special measures to access large files (LFS).
Add `AC_SYS_LARGEFILE' to `configure.ac' to handle this.

It seems that ABI is not changed with this.

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 configure.ac | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configure.ac b/configure.ac
index 3f21ba4..02bd6f8 100644
--- a/configure.ac
+++ b/configure.ac
@@ -8,6 +8,7 @@ AC_CONFIG_MACRO_DIR([m4])
 
 AC_CANONICAL_HOST
 AC_USE_SYSTEM_EXTENSIONS
+AC_SYS_LARGEFILE
 
 # Checks for programs.
 AC_PROG_CC
-- 
2.11.0

